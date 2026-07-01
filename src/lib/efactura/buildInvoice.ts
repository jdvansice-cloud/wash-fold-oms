// Pure builder: turns an order (plus enriched line items, payments and the
// receptor) into an efacturapty `InvoiceRequest`.
//
// Design notes
// ------------
// * The PAC assigns `numeroDocumento` and auto-fills the emisor block, so we
//   never send them (verified live — see docs/EFACTURA_INTEGRATION_PLAN.md).
// * The app stores discount and ITBMS at the ORDER level (proportionally), but
//   the DGI requires them PER LINE. This builder redistributes the order totals
//   across lines in integer cents so the per-line values sum back to the
//   authoritative `order.tax_amount` / `order.total` exactly.
// * A reconciliation guard throws rather than emit a payload whose totals don't
//   add up — better to fail loudly than to send a rejected/incorrect invoice.

import {
  DATOS_GENERALES_DEFAULTS,
  DEFAULT_PAIS,
  DEFAULT_PUNTO_FACTURACION,
  DOC_TYPE,
  ITBMS_RATE_CODE,
  RECEPTOR_TYPE,
  TIEMPO_PAGO_CONTADO,
  TIPO_CONTRIBUYENTE,
  itbmsRateCode,
  mapPaymentForma,
  paymentFormaDescripcion,
  type DocType,
} from './constants.js';
import { distributeCents, fromCents, round2, toCents } from './money.js';
import type {
  InformacionReceptor,
  InvoiceRequest,
  ListaItem,
  Totales,
} from './types.js';

export class EInvoiceReconciliationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'EInvoiceReconciliationError';
  }
}

/** Subset of a Customer needed to build the receptor block. */
export interface EInvoiceReceptorCustomer {
  first_name?: string;
  last_name?: string;
  company_name?: string;
  ruc?: string;
  dv?: string;
  id_type?: string;
  id_number?: string;
  email?: string;
  address_street?: string;
  address_building?: string;
  address_corregimiento?: string;
  address_district?: string;
  address_province?: string;
  /** ITBMS-exempt (exonerado). Forces tasa "00" on all lines at emit time. */
  tax_exempt?: boolean;
}

/** A No-Tributario RUC (government / state entity), e.g. "8-NT-1-12571". */
export function isGovernmentRuc(ruc?: string | null): boolean {
  return /(?:^|-)NT(?:-|$)/i.test((ruc ?? '').trim());
}

export interface EInvoiceLine {
  description: string;
  internalCode?: string;
  quantity: number;
  /** Unit price before discount and ITBMS. */
  unitPrice: number;
  /** Gross line total (unitPrice × quantity). Defaults to that product. */
  lineTotal?: number;
  /** Defaults to true. Non-taxable lines emit tasa "00" and 0 ITBMS. */
  isTaxable?: boolean;
  /** Defaults to true. Order-level discount is split across discountable lines. */
  isDiscountable?: boolean;
  codigoItemCodificacionPanamena?: number;
  codigoItemCodificacionPanamenaAbreviada?: number;
}

export interface EInvoicePayment {
  method: string;
  amount: number;
  change?: number;
}

export interface EInvoiceConfig {
  /** Company ITBMS rate as a percentage, e.g. 7. */
  itbmsRate: number;
  puntoFacturacion?: string;
  defaultCpbsCode?: number;
  defaultCpbsCodeShort?: number;
}

export interface BuildInvoiceInput {
  docType?: DocType;
  order: {
    discount_amount?: number;
    tax_amount: number;
    total: number;
  };
  items: EInvoiceLine[];
  payments?: EInvoicePayment[];
  customer?: EInvoiceReceptorCustomer | null;
  config: EInvoiceConfig;
  /** Emission timestamp; defaults to now. Injectable for deterministic tests. */
  now?: Date;
}

/**
 * Formats a Date as ISO 8601 in Panama local time (UTC−5, no DST),
 * e.g. "2026-06-21T14:05:05-05:00".
 */
export function formatPanamaDateTime(date: Date): string {
  const shifted = new Date(date.getTime() - 5 * 60 * 60 * 1000);
  const p = (n: number, w = 2) => String(n).padStart(w, '0');
  return (
    `${shifted.getUTCFullYear()}-${p(shifted.getUTCMonth() + 1)}-${p(shifted.getUTCDate())}` +
    `T${p(shifted.getUTCHours())}:${p(shifted.getUTCMinutes())}:${p(shifted.getUTCSeconds())}-05:00`
  );
}

function fullName(c: EInvoiceReceptorCustomer): string | undefined {
  const name = [c.first_name, c.last_name].filter(Boolean).join(' ').trim();
  return name || undefined;
}

/** Builds the receptor (buyer) block, choosing the receptor type from the customer. */
export function buildReceptor(customer?: EInvoiceReceptorCustomer | null): InformacionReceptor {
  // No customer, or a walk-in without RUC/passport → consumidor final.
  if (!customer || (!customer.ruc && customer.id_type !== 'passport')) {
    const name = customer ? fullName(customer) : undefined;
    return {
      tipoReceptorFe: RECEPTOR_TYPE.CONSUMIDOR_FINAL,
      paisReceptor: DEFAULT_PAIS,
      ...(name ? { nombreRazonReceptor: name } : {}),
    };
  }

  // Foreign buyer identified by passport.
  if (!customer.ruc && customer.id_type === 'passport' && customer.id_number) {
    return {
      tipoReceptorFe: RECEPTOR_TYPE.EXTRANJERO,
      paisReceptor: DEFAULT_PAIS,
      nombreRazonReceptor: customer.company_name || fullName(customer),
      grupoIdentificacionExtranjera: {
        pasaportNumeroIdentificacionExtranjera: customer.id_number,
      },
      ...(customer.email ? { correoElectronicoReceptor: customer.email } : {}),
    };
  }

  // RUC receptor (named/fiscal invoice). A No-Tributario RUC identifies a
  // government / state entity → receptor type GOBIERNO (03); otherwise the
  // standard CONTRIBUYENTE (01).
  const direccion = [customer.address_street, customer.address_building]
    .filter(Boolean)
    .join(', ')
    .trim();
  const hasUbicacion =
    customer.address_corregimiento || customer.address_district || customer.address_province;
  const tipoReceptorFe = isGovernmentRuc(customer.ruc)
    ? RECEPTOR_TYPE.GOBIERNO
    : RECEPTOR_TYPE.CONTRIBUYENTE;

  return {
    tipoReceptorFe,
    paisReceptor: DEFAULT_PAIS,
    nombreRazonReceptor: customer.company_name || fullName(customer),
    datosRucReceptor: {
      tipoContribuyente: customer.company_name
        ? TIPO_CONTRIBUYENTE.JURIDICO
        : TIPO_CONTRIBUYENTE.NATURAL,
      rucReceptor: customer.ruc!,
      digitoVerificador: customer.dv ?? '',
    },
    ...(direccion ? { direccionReceptor: direccion } : {}),
    ...(hasUbicacion
      ? {
          ubicacionReceptor: {
            corregimiento: customer.address_corregimiento,
            distrito: customer.address_district,
            provincia: customer.address_province,
          },
        }
      : {}),
    ...(customer.email ? { correoElectronicoReceptor: customer.email } : {}),
  };
}

export function buildInvoiceRequest(input: BuildInvoiceInput): InvoiceRequest {
  const { order, items, customer, config } = input;
  const docType = input.docType ?? DOC_TYPE.FACTURA;
  const now = input.now ?? new Date();

  if (items.length === 0) {
    throw new EInvoiceReconciliationError('Cannot build an invoice with no line items.');
  }

  const grossCents = items.map((it) =>
    toCents(it.lineTotal ?? it.unitPrice * it.quantity),
  );

  // --- Distribute the order-level discount across discountable lines ---
  const discountCentsTotal = toCents(order.discount_amount ?? 0);
  const discountWeights = items.map((it, i) =>
    it.isDiscountable === false ? 0 : grossCents[i],
  );
  const discountPerLine = distributeCents(discountCentsTotal, discountWeights);
  const netCents = grossCents.map((g, i) => g - discountPerLine[i]);

  // --- Distribute the order-level ITBMS across taxable lines (by net base) ---
  const taxCentsTotal = toCents(order.tax_amount ?? 0);
  const taxWeights = items.map((it, i) => (it.isTaxable === false ? 0 : netCents[i]));
  const itbmsPerLine = distributeCents(taxCentsTotal, taxWeights);

  // --- Reconcile to order.total, absorbing sub-cent rounding drift ---
  // An order's stored subtotal + tax can differ from its total by a cent or two
  // (independent rounding of each field). `total` is authoritative — it's what
  // was charged — so we nudge the largest net line to make the document balance.
  // A larger gap means a genuinely missing line (e.g. delivery) -> fail loudly.
  const totalCents = toCents(order.total);
  const driftTolerance = Math.max(2, items.length);
  const residual =
    totalCents - netCents.reduce((s, c) => s + c, 0) - itbmsPerLine.reduce((s, c) => s + c, 0);
  if (residual !== 0) {
    if (Math.abs(residual) > driftTolerance) {
      throw new EInvoiceReconciliationError(
        `Invoice totals do not reconcile by ${fromCents(residual)} (order.total ${order.total}). ` +
          `Ensure every billable line (including delivery) is passed in \`items\`.`,
      );
    }
    let idx = 0;
    for (let i = 1; i < netCents.length; i++) if (netCents[i] > netCents[idx]) idx = i;
    netCents[idx] += residual;
  }

  const rateCode = itbmsRateCode(config.itbmsRate);

  const listaItems: ListaItem[] = items.map((it, i) => {
    const taxable = it.isTaxable !== false;
    const sumaCents = netCents[i] + itbmsPerLine[i];
    // Derive the per-line discount from the actual gross→net gap so that
    // precioItem === precioUnitario·cantidad − descuento·cantidad stays exact,
    // including any absorbed rounding drift.
    const lineDiscountCents = grossCents[i] - netCents[i];

    return {
      numeroSecuenciaItem: i + 1,
      descripcionProductoServicio: it.description,
      ...(it.internalCode ? { codigoInternoItem: it.internalCode } : {}),
      cantidadProductoServicio: it.quantity,
      ...(it.codigoItemCodificacionPanamena ?? config.defaultCpbsCode
        ? {
            codigoItemCodificacionPanamena:
              it.codigoItemCodificacionPanamena ?? config.defaultCpbsCode,
          }
        : {}),
      ...(it.codigoItemCodificacionPanamenaAbreviada ?? config.defaultCpbsCodeShort
        ? {
            codigoItemCodificacionPanamenaAbreviada:
              it.codigoItemCodificacionPanamenaAbreviada ?? config.defaultCpbsCodeShort,
          }
        : {}),
      grupoPrecios: {
        // Unit price (and per-unit discount) are always 2-decimal currency
        // values, derived from the gross line so that precioUnitario × cantidad
        // tracks the line total. For weight items cantidad is the weight, so the
        // unit price is the per-kg rate (e.g. 3.28 / 1.40 -> 2.34).
        precioUnitarioTransferencia: round2(fromCents(grossCents[i]) / it.quantity),
        ...(lineDiscountCents > 0
          ? { descuento: round2(fromCents(lineDiscountCents) / it.quantity) }
          : {}),
        precioItem: fromCents(netCents[i]),
        sumaPrecioItem: fromCents(sumaCents),
      },
      grupoITBMS: {
        tasaITBMSAplicable: taxable ? rateCode : ITBMS_RATE_CODE.EXENTO,
        montoITBMS: fromCents(itbmsPerLine[i]),
      },
    };
  });

  // --- Totals ---
  const totalNetoCents = netCents.reduce((s, c) => s + c, 0);
  const totalItbmsCents = itbmsPerLine.reduce((s, c) => s + c, 0);

  // DGI rule: vueltoEntregado === sumaValoresRecibidos − valorTotalFactura.
  // The stored payment.amount is the amount APPLIED to the order; the value the
  // customer actually tendered (reported as "received") is amount + change.
  const effectivePayments = (input.payments?.length
    ? input.payments
    : [{ method: 'efectivo', amount: order.total, change: 0 }]
  ).map((p) => ({ method: p.method, received: toCents(p.amount) + toCents(p.change ?? 0) }));

  const grupoFormasPago = effectivePayments.map((p) => {
    const forma = mapPaymentForma(p.method);
    return {
      formaPago: forma,
      // DGI rule 2601: code "99" (otro) must carry a text description.
      ...(forma === '99' ? { formaPagoDescripcion: paymentFormaDescripcion(p.method) } : {}),
      valorCuotaPagada: fromCents(p.received),
    };
  });
  const receivedCents = effectivePayments.reduce((s, p) => s + p.received, 0);
  const changeCents = Math.max(0, receivedCents - totalCents);

  const totales: Totales = {
    totalNeto: fromCents(totalNetoCents),
    totalITBMS: fromCents(totalItbmsCents),
    totalGravado: fromCents(totalItbmsCents),
    valorTotalFactura: fromCents(totalCents),
    sumaValoresRecibidos: fromCents(receivedCents),
    ...(changeCents > 0 ? { vueltoEntregado: fromCents(changeCents) } : {}),
    tiempoPago: TIEMPO_PAGO_CONTADO,
    numeroTotalItems: items.length,
    totalTodosItems: fromCents(totalCents),
    grupoFormasPago,
  };

  // --- Reconciliation guard ---
  if (totalNetoCents + totalItbmsCents !== totalCents) {
    throw new EInvoiceReconciliationError(
      `Invoice totals do not reconcile: netos ${fromCents(totalNetoCents)} + ITBMS ` +
        `${fromCents(totalItbmsCents)} = ${fromCents(totalNetoCents + totalItbmsCents)}, ` +
        `but order.total is ${order.total}. Ensure every billable line (including ` +
        `delivery) is passed in \`items\`.`,
    );
  }

  return {
    datosGenerales: {
      ...DATOS_GENERALES_DEFAULTS,
      tipoDocumento: docType,
      puntoFacturacion: config.puntoFacturacion ?? DEFAULT_PUNTO_FACTURACION,
      fechaEmision: formatPanamaDateTime(now),
      informacionReceptor: buildReceptor(customer),
    },
    listaItems,
    totales,
  };
}
