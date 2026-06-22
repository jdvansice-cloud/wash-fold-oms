// GET /api/efactura/cafe?invoice_id=...   (or ?cufe=...)
//
// Downloads the CAFE (the printable PDF representation) from the PAC and returns
// it as base64 so the client can preview, print or download it.

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
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const admin = getAdmin();
    const { companyId } = await authenticateStaff(admin, req);
    const config = await loadEfacturaConfig(admin, companyId);

    const invoiceId = req.query?.invoice_id as string | undefined;
    const cufeParam = req.query?.cufe as string | undefined;
    if (!invoiceId && !cufeParam) throw new HttpError(400, 'Provide invoice_id or cufe');

    // Always resolve the document through our DB and verify the caller's company
    // owns it — never trust a raw CUFE from the query (prevents cross-tenant IDOR).
    const lookup = admin.from('electronic_invoices').select('store_id, cufe');
    const { data: invoice } = await (invoiceId
      ? lookup.eq('id', invoiceId)
      : lookup.eq('cufe', cufeParam)
    ).maybeSingle();
    if (!invoice?.cufe) throw new HttpError(404, 'Invoice not found or not yet authorized');
    await assertStoreInCompany(admin, invoice.store_id, companyId);
    const cufe = invoice.cufe;

    const pacRes = await pacRequest(config, `/Invoices/${encodeURIComponent(cufe)}/cafe-file`, {
      method: 'GET',
    });
    if (!pacRes.ok) {
      throw new HttpError(502, `PAC could not return the CAFE (HTTP ${pacRes.status})`);
    }

    const buffer = Buffer.from(await pacRes.arrayBuffer());
    return res.status(200).json({
      success: true,
      cufe,
      contentType: 'application/pdf',
      base64: buffer.toString('base64'),
    });
  } catch (err) {
    sendError(res, err);
  }
}
