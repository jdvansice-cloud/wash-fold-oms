// POST /api/efactura/cancel  { invoice_id | cufe, reason }
//
// Voids an authorized factura at the PAC (anulación by CUFE) and marks the
// electronic_invoices row cancelled.

import {
  authenticateStaff,
  assertStoreInCompany,
  getAdmin,
  loadEfacturaConfig,
  pacRequest,
  sendError,
  HttpError,
} from './_shared.js';

export default async function handler(req: any, res: any) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const admin = getAdmin();
    const { companyId } = await authenticateStaff(admin, req);

    const { invoice_id, cufe, reason } = req.body || {};
    if (!invoice_id && !cufe) throw new HttpError(400, 'Provide invoice_id or cufe');
    if (!reason) throw new HttpError(400, 'A cancellation reason is required');

    // Resolve the invoice row and verify tenant ownership.
    const query = admin.from('electronic_invoices').select('*');
    const { data: invoice } = await (invoice_id
      ? query.eq('id', invoice_id)
      : query.eq('cufe', cufe)
    ).maybeSingle();
    if (!invoice) throw new HttpError(404, 'Invoice not found');
    await assertStoreInCompany(admin, invoice.store_id, companyId);
    if (invoice.status !== 'authorized') {
      throw new HttpError(409, `Only authorized invoices can be cancelled (status: ${invoice.status})`);
    }

    const config = await loadEfacturaConfig(admin, { storeId: invoice.store_id, companyId });

    const pacRes = await pacRequest(config, '/InvoiceEvents/CreateCancellation', {
      method: 'POST',
      body: JSON.stringify({ cufe: invoice.cufe, cancellationReason: reason }),
    });
    const result = await pacRes.json().catch(() => ({}));
    if (!pacRes.ok) {
      return res.status(502).json({
        success: false,
        error: result?.message || result?.title || `PAC could not cancel (HTTP ${pacRes.status})`,
        pac: result,
      });
    }

    await admin
      .from('electronic_invoices')
      .update({
        status: 'cancelled',
        response_payload: result,
        error: reason,
        updated_at: new Date().toISOString(),
      })
      .eq('id', invoice.id);

    return res.status(200).json({ success: true, invoiceId: invoice.id });
  } catch (err) {
    sendError(res, err);
  }
}
