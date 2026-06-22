// POST /api/efactura/emit  { order_id, doc_type?, referenced_cufe? }
//
// Builds the invoice from the order server-side, records an electronic_invoices
// row, emits it to the PAC, and persists the result (CUFE, QR, protocolo).
// Idempotent: a partial unique index guarantees one active factura per order,
// and an already-authorized document is returned as-is instead of re-emitted.
// Safe to call as a fire-and-forget trigger after checkout — when E-Factura is
// not enabled for the company it returns { skipped: true } without erroring.

import {
  authenticateStaff,
  assertStoreInCompany,
  emitOrder,
  getAdmin,
  loadEfacturaConfig,
  sendError,
  HttpError,
} from './_shared.js';

export default async function handler(req: any, res: any) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const admin = getAdmin();
    const { companyId } = await authenticateStaff(admin, req);

    const { order_id, doc_type = '01', referenced_cufe } = req.body || {};
    if (!order_id) throw new HttpError(400, 'Missing order_id');

    // Verify the order belongs to this company before touching the PAC.
    const { data: order } = await admin
      .from('orders')
      .select('store_id')
      .eq('id', order_id)
      .maybeSingle();
    if (!order) throw new HttpError(404, 'Order not found');
    await assertStoreInCompany(admin, order.store_id, companyId);

    // Load the store's E-Factura config; no-op cleanly when not configured/enabled.
    let config;
    try {
      config = await loadEfacturaConfig(admin, { storeId: order.store_id, companyId });
    } catch (e) {
      if (e instanceof HttpError && e.status === 400) {
        return res.status(200).json({ success: true, skipped: true, reason: 'not configured' });
      }
      throw e;
    }
    if (!config.enabled) {
      return res.status(200).json({ success: true, skipped: true, reason: 'disabled' });
    }

    // Idempotency: reuse the existing active row; return an authorized one as-is.
    const { data: existing } = await admin
      .from('electronic_invoices')
      .select('id, status, attempts')
      .eq('order_id', order_id)
      .eq('doc_type', doc_type)
      .in('status', ['authorized', 'emitting', 'pending', 'rejected'])
      .maybeSingle();
    if (existing?.status === 'authorized') {
      return res.status(200).json({ success: true, alreadyEmitted: true, invoiceId: existing.id });
    }

    const outcome = await emitOrder(admin, config, {
      orderId: order_id,
      docType: doc_type,
      referencedCufe: referenced_cufe,
      existingId: existing?.id,
      priorAttempts: existing?.attempts,
    });

    if (!outcome.authorized) {
      return res.status(502).json({ success: false, error: outcome.error, invoiceId: outcome.invoiceId, pac: outcome.pac });
    }
    return res.status(200).json({
      success: true,
      invoiceId: outcome.invoiceId,
      cufe: outcome.cufe,
      qrContent: outcome.qrContent,
      protocoloAutorizacion: outcome.protocoloAutorizacion,
    });
  } catch (err) {
    sendError(res, err);
  }
}
