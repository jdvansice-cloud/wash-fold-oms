// Shared helpers for the E-Factura serverless proxy (/api/efactura/*).
//
// Security model (mirrors api/send-email.js): the caller presents a Supabase
// session token. We validate it with the service-role key, derive the caller's
// company from the authenticated staff user (never from the request body), and
// load that company's PAC API key server-side. The key never reaches the client.

import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import {
  buildInvoiceRequest,
  type EInvoiceLine,
  type EInvoiceReceptorCustomer,
} from '../../src/lib/efactura/buildInvoice.js';
import { round2 } from '../../src/lib/efactura/money.js';

export const PAC_BASE = 'https://api.efacturapty.com/api/v1';

export function getAdmin(): SupabaseClient {
  const url = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) {
    throw new HttpError(500, 'Server misconfigured: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are required.');
  }
  return createClient(url, key, { auth: { autoRefreshToken: false, persistSession: false } });
}

export class HttpError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

/** Validates the bearer token and returns the authenticated staff user + company. */
export async function authenticateStaff(
  admin: SupabaseClient,
  req: { headers: Record<string, string | string[] | undefined> },
): Promise<{ authId: string; companyId: string }> {
  const header = (req.headers.authorization || req.headers.Authorization || '') as string;
  const token = header.startsWith('Bearer ') ? header.slice(7) : null;
  if (!token) throw new HttpError(401, 'Missing Authorization bearer token');

  const { data: userData, error } = await admin.auth.getUser(token);
  if (error || !userData?.user) throw new HttpError(401, 'Invalid or expired session');

  const { data: staff, error: staffError } = await admin
    .from('users')
    .select('company_id')
    .eq('auth_id', userData.user.id)
    .maybeSingle();

  if (staffError || !staff?.company_id) throw new HttpError(403, 'Not authorized');
  return { authId: userData.user.id, companyId: staff.company_id };
}

export interface EFacturaConfig {
  company_id: string;
  api_key: string;
  environment: 'test' | 'prod';
  punto_facturacion: string;
  default_cpbs_code: number | null;
  default_cpbs_code_short: number | null;
  enabled: boolean;
}

export async function loadEfacturaConfig(
  admin: SupabaseClient,
  companyId: string,
): Promise<EFacturaConfig> {
  const { data, error } = await admin
    .from('company_efactura_config')
    .select('*')
    .eq('company_id', companyId)
    .maybeSingle();

  if (error) throw new HttpError(500, 'Could not load E-Factura configuration');
  if (!data || !data.api_key) throw new HttpError(400, 'E-Factura is not configured for this company');
  return data as EFacturaConfig;
}

/** Confirms a store belongs to the company; throws 403 otherwise. */
export async function assertStoreInCompany(
  admin: SupabaseClient,
  storeId: string,
  companyId: string,
): Promise<void> {
  const { data, error } = await admin
    .from('stores')
    .select('id')
    .eq('id', storeId)
    .eq('company_id', companyId)
    .maybeSingle();
  if (error || !data) throw new HttpError(403, 'Store does not belong to this company');
}

/** Calls the PAC with the company's API key as a bearer token. */
export async function pacRequest(
  config: EFacturaConfig,
  path: string,
  init: RequestInit = {},
): Promise<Response> {
  return fetch(`${PAC_BASE}${path}`, {
    ...init,
    headers: {
      Authorization: `Bearer ${config.api_key}`,
      'Content-Type': 'application/json',
      ...(init.headers || {}),
    },
  });
}

interface OrderRow {
  id: string;
  store_id: string;
  customer_id: string | null;
  subtotal: number;
  discount_amount: number;
  delivery_charge: number;
  tax_amount: number;
  total: number;
  order_items?: OrderItemRow[];
  payments?: PaymentRow[];
}
interface OrderItemRow {
  product_id: string | null;
  product_name: string | null;
  quantity: number;
  unit_price: number;
  line_total: number;
  total_weight: number | null;
}
interface PaymentRow {
  payment_method: string;
  amount: number;
  change_amount: number;
}

/**
 * Loads an order and builds the PAC `InvoiceRequest` from it.
 *
 * Line reconstruction: product lines come from order_items (enriched with each
 * product's `is_taxable` and CPBS codes). Delivery is derived from the order
 * totals — `netDelivery = subtotal − (grossProducts − discount)` — so it
 * reconciles whether delivery was stored as a line item, as a standalone
 * `delivery_charge`, or waived (free delivery → no line). The builder's
 * reconciliation guard is the backstop.
 */
export async function buildPayloadForOrder(
  admin: SupabaseClient,
  config: EFacturaConfig,
  orderId: string,
  docType?: '01' | '06' | '07',
) {
  const { data: order, error } = await admin
    .from('orders')
    .select('*, order_items(*), payments(*)')
    .eq('id', orderId)
    .maybeSingle();
  if (error || !order) throw new HttpError(404, 'Order not found');
  const o = order as OrderRow;

  const items = o.order_items || [];
  const productIds = [...new Set(items.map((i) => i.product_id).filter(Boolean))] as string[];

  const productMeta = new Map<string, { is_taxable: boolean; product_type: string; pricing_type: string; cpbs_code: number | null; cpbs_code_short: number | null; sku: string | null }>();
  if (productIds.length) {
    const { data: products } = await admin
      .from('products')
      .select('id, is_taxable, product_type, pricing_type, cpbs_code, cpbs_code_short, sku')
      .in('id', productIds);
    for (const p of products || []) {
      productMeta.set(p.id, {
        is_taxable: p.is_taxable !== false,
        product_type: p.product_type || 'service',
        pricing_type: p.pricing_type || 'quantity',
        cpbs_code: p.cpbs_code ?? null,
        cpbs_code_short: p.cpbs_code_short ?? null,
        sku: p.sku || null,
      });
    }
  }

  // codigoInternoItem is capped at 20 chars by the DGI. Prefer the SKU; fall
  // back to a truncated product id; never send a full UUID (36 chars).
  const internalCodeFor = (i: OrderItemRow) => {
    const sku = i.product_id ? productMeta.get(i.product_id)?.sku : null;
    const code = sku || i.product_id || '';
    return code ? code.slice(0, 20) : undefined;
  };

  // Credit notes (refund orders carry negative amounts) are emitted as positive
  // magnitudes — abs() is a no-op for normal sales and normalizes refunds.
  const isCredit = docType === '06' || o.total < 0;
  const abs = (n: number) => (isCredit ? Math.abs(n) : n);

  const isDelivery = (i: OrderItemRow) =>
    (i.product_id && productMeta.get(i.product_id)?.product_type === 'delivery') || false;

  const productItems = items.filter((i) => !isDelivery(i));
  const grossProducts = productItems.reduce(
    (s, i) => s + abs(i.line_total ?? i.unit_price * i.quantity),
    0,
  );

  const lines: EInvoiceLine[] = productItems.map((i) => {
    const meta = i.product_id ? productMeta.get(i.product_id) : undefined;
    // For weight-priced products the DGI quantity is the weight (e.g. 1.40 kg),
    // not the number of bags. precioUnitario is then the per-unit (per-kg) rate
    // derived by the builder as lineTotal / cantidad.
    const isWeight = meta?.pricing_type === 'weight' && (i.total_weight ?? 0) > 0;
    const cantidad = isWeight ? abs(i.total_weight as number) : abs(i.quantity);
    return {
      description: i.product_name || 'Producto/Servicio',
      internalCode: internalCodeFor(i),
      quantity: cantidad,
      unitPrice: abs(i.unit_price),
      lineTotal: abs(i.line_total ?? i.unit_price * i.quantity),
      isTaxable: meta ? meta.is_taxable : true,
      isDiscountable: true,
      codigoItemCodificacionPanamena: meta?.cpbs_code ?? config.default_cpbs_code ?? undefined,
      codigoItemCodificacionPanamenaAbreviada: meta?.cpbs_code_short ?? config.default_cpbs_code_short ?? undefined,
    };
  });

  // Delivery derived from totals (covers item / standalone / waived).
  const netDelivery = round2(abs(o.subtotal) - (grossProducts - abs(o.discount_amount || 0)));
  if (netDelivery > 0.005) {
    lines.push({
      description: 'Servicio de entrega',
      quantity: 1,
      unitPrice: netDelivery,
      lineTotal: netDelivery,
      isTaxable: true,
      isDiscountable: false,
      codigoItemCodificacionPanamena: config.default_cpbs_code ?? undefined,
      codigoItemCodificacionPanamenaAbreviada: config.default_cpbs_code_short ?? undefined,
    });
  }

  let customer: EInvoiceReceptorCustomer | null = null;
  if (o.customer_id) {
    const { data: c } = await admin.from('customers').select('*').eq('id', o.customer_id).maybeSingle();
    if (c) customer = c as EInvoiceReceptorCustomer;
  }

  const { data: company } = await admin
    .from('companies')
    .select('itbms_rate')
    .eq('id', config.company_id)
    .maybeSingle();
  const itbmsRate = company?.itbms_rate ?? 7;

  const payments = (o.payments || []).map((p) => ({
    method: p.payment_method,
    amount: abs(p.amount),
    change: abs(p.change_amount),
  }));

  const payload = buildInvoiceRequest({
    docType,
    order: { discount_amount: abs(o.discount_amount), tax_amount: abs(o.tax_amount), total: abs(o.total) },
    items: lines,
    payments,
    customer,
    config: {
      itbmsRate,
      puntoFacturacion: config.punto_facturacion,
      defaultCpbsCode: config.default_cpbs_code ?? undefined,
      defaultCpbsCodeShort: config.default_cpbs_code_short ?? undefined,
    },
  });

  return { payload, order: o };
}

/**
 * Extracts a human-readable rejection reason from a PAC response. The DGI
 * validation results live in rRetEnviFe.xProtFe.rProtFe.gInfProt.gResProc[]
 * (e.g. "10103: Campo codigoInternoItem no debe superar los 20 caracteres").
 */
export function pacRejectionMessage(result: any, httpStatus: number): string {
  const proc = result?.rRetEnviFe?.xProtFe?.rProtFe?.gInfProt?.gResProc;
  if (Array.isArray(proc) && proc.length) {
    return proc.map((p: any) => [p?.dCodRes, p?.dMsgRes].filter(Boolean).join(': ')).join('; ');
  }
  return result?.message || result?.title || `PAC HTTP ${httpStatus}`;
}

export interface EmitOutcome {
  invoiceId: string;
  authorized: boolean;
  cufe?: string;
  qrContent?: string;
  protocoloAutorizacion?: string;
  error?: string;
  pac?: any;
}

/**
 * Core emission routine shared by the live endpoint and the retry worker:
 * builds the payload, upserts the tracking row (`emitting`), calls the PAC, and
 * persists the result (`authorized` | `rejected`). Pass `existingId` to reuse a
 * row (retries); omit it to create a new one.
 */
export async function emitOrder(
  admin: SupabaseClient,
  config: EFacturaConfig,
  params: {
    orderId: string;
    docType?: '01' | '06' | '07';
    referencedCufe?: string | null;
    existingId?: string;
    priorAttempts?: number;
  },
): Promise<EmitOutcome> {
  const docType = params.docType || '01';
  const { payload, order } = await buildPayloadForOrder(admin, config, params.orderId, docType);

  let invoiceId = params.existingId;
  if (!invoiceId) {
    const { data: created, error: insErr } = await admin
      .from('electronic_invoices')
      .insert({
        store_id: order.store_id,
        order_id: params.orderId,
        doc_type: docType,
        environment: config.environment,
        status: 'emitting',
        referenced_cufe: params.referencedCufe || null,
        request_payload: payload,
        attempts: 1,
      })
      .select('id')
      .single();
    if (insErr) throw new HttpError(500, `Could not record invoice: ${insErr.message}`);
    invoiceId = created.id;
  } else {
    await admin
      .from('electronic_invoices')
      .update({
        status: 'emitting',
        request_payload: payload,
        attempts: (params.priorAttempts ?? 0) + 1,
        error: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', invoiceId);
  }

  const pacRes = await pacRequest(config, '/Invoices', { method: 'POST', body: JSON.stringify(payload) });
  const result = await pacRes.json().catch(() => ({}));
  const authorized = pacRes.ok && result?.autorizada === true;
  const error = authorized ? null : pacRejectionMessage(result, pacRes.status);

  await admin
    .from('electronic_invoices')
    .update({
      status: authorized ? 'authorized' : 'rejected',
      cufe: result?.cufe || null,
      protocolo_autorizacion: result?.protocoloAutorizacion || null,
      fecha_autorizacion: result?.fechaAutorizacion || null,
      qr_content: result?.qrContent || null,
      response_payload: result,
      error,
      emitted_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq('id', invoiceId);

  return {
    invoiceId: invoiceId!,
    authorized,
    cufe: result?.cufe,
    qrContent: result?.qrContent,
    protocoloAutorizacion: result?.protocoloAutorizacion,
    error: error || undefined,
    pac: result,
  };
}

/** Uniform error responder. */
export function sendError(res: { status: (n: number) => { json: (b: unknown) => void } }, err: unknown) {
  if (err instanceof HttpError) {
    res.status(err.status).json({ success: false, error: err.message });
  } else {
    // eslint-disable-next-line no-console
    console.error('E-Factura proxy error:', err);
    res.status(500).json({ success: false, error: (err as Error)?.message || 'Internal error' });
  }
}
