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
  emitB2BInvoice,
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

    const { order_id, b2b_invoice_id, doc_type = '01', referenced_cufe } = req.body || {};

    // --- B2B consolidated invoice path ---
    if (b2b_invoice_id) {
      const { data: inv } = await admin
        .from('b2b_invoices')
        .select('store_id')
        .eq('id', b2b_invoice_id)
        .maybeSingle();
      if (!inv) throw new HttpError(404, 'B2B invoice not found');
      await assertStoreInCompany(admin, inv.store_id, companyId);

      let cfg;
      try {
        cfg = await loadEfacturaConfig(admin, { storeId: inv.store_id, companyId });
      } catch (e) {
        if (e instanceof HttpError && e.status === 400) {
          return res.status(200).json({ success: true, skipped: true, reason: 'not configured' });
        }
        throw e;
      }
      if (!cfg.enabled) {
        return res.status(200).json({ success: true, skipped: true, reason: 'disabled' });
      }

      const { data: existingB2b } = await admin
        .from('electronic_invoices')
        .select('id, status, attempts')
        .eq('b2b_invoice_id', b2b_invoice_id)
        .eq('doc_type', '01')
        .in('status', ['authorized', 'emitting', 'pending', 'rejected'])
        .maybeSingle();
      if (existingB2b?.status === 'authorized') {
        return res.status(200).json({ success: true, alreadyEmitted: true, invoiceId: existingB2b.id });
      }

      const out = await emitB2BInvoice(admin, cfg, {
        b2bInvoiceId: b2b_invoice_id,
        existingId: existingB2b?.id,
        priorAttempts: existingB2b?.attempts,
      });
      if (!out.authorized) {
        return res.status(502).json({ success: false, error: out.error, invoiceId: out.invoiceId, pac: out.pac });
      }
      return res.status(200).json({
        success: true,
        invoiceId: out.invoiceId,
        cufe: out.cufe,
        qrContent: out.qrContent,
        protocoloAutorizacion: out.protocoloAutorizacion,
      });
    }

    if (!order_id) throw new HttpError(400, 'Missing order_id');

    // Verify the order belongs to this company before touching the PAC.
    const { data: order } = await admin
      .from('orders')
      .select('store_id, billing_type')
      .eq('id', order_id)
      .maybeSingle();
    if (!order) throw new HttpError(404, 'Order not found');
    await assertStoreInCompany(admin, order.store_id, companyId);

    // B2B credit (billing_type=account) is invoiced via the CONSOLIDATED factura
    // (b2b_invoice_id path), never per order — skip individual emission.
    if (order.billing_type === 'account') {
      return res.status(200).json({ success: true, skipped: true, reason: 'b2b_account' });
    }

    // Gift cards are prepayment, not a sale → never a factura. Skip when every
    // line on the order is a gift-card product (tax applies later, on redemption).
    const { data: lineProducts } = await admin
      .from('order_items')
      .select('products(product_type)')
      .eq('order_id', order_id);
    if (
      lineProducts &&
      lineProducts.length > 0 &&
      lineProducts.every((r: any) => r.products?.product_type === 'gift_card')
    ) {
      return res.status(200).json({ success: true, skipped: true, reason: 'gift_card' });
    }

    // Pay-on-pickup is a deferred term (collected at pickup), so it must not be
    // invoiced now — it's billed when actually paid. Detect by payment_type so a
    // renamed method still works; skip when every payment on the order is pickup.
    const { data: orderPayments } = await admin
      .from('payments')
      .select('payment_method')
      .eq('order_id', order_id);
    if (orderPayments && orderPayments.length) {
      const { data: pickupMethods } = await admin
        .from('payment_methods')
        .select('name')
        .eq('store_id', order.store_id)
        .eq('payment_type', 'pickup');
      const pickupNames = new Set((pickupMethods || []).map((m: any) => m.name));
      if (pickupNames.size && orderPayments.every((p: any) => pickupNames.has(p.payment_method))) {
        return res.status(200).json({ success: true, skipped: true, reason: 'pay_on_pickup' });
      }
    }

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
