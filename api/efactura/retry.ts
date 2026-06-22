// GET /api/efactura/retry  — background worker (Vercel Cron)
//
// Re-emits electronic_invoices that are pending, were rejected (e.g. PAC/DGI
// downtime), or are stuck `emitting` (a serverless function that died mid-call).
// Authenticated by CRON_SECRET, not a user session; uses the service-role key.
//
// Permanently-invalid documents (bad data) keep failing, so attempts are capped
// to stop infinite retries — those remain `rejected` for manual review.

import {
  emitOrder,
  getAdmin,
  loadEfacturaConfig,
  HttpError,
  type EFacturaConfig,
} from './_shared';

const MAX_ATTEMPTS = 5;
const BATCH_SIZE = 25;
const STUCK_EMITTING_MS = 5 * 60 * 1000;

export default async function handler(req: any, res: any) {
  // Cron auth: Vercel sends `Authorization: Bearer <CRON_SECRET>`.
  const secret = process.env.CRON_SECRET;
  const header = (req.headers.authorization || '') as string;
  if (!secret || header !== `Bearer ${secret}`) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  try {
    const admin = getAdmin();
    const stuckBefore = new Date(Date.now() - STUCK_EMITTING_MS).toISOString();

    // pending / rejected rows, plus emitting rows that have gone stale.
    const { data: rows, error } = await admin
      .from('electronic_invoices')
      .select('id, order_id, doc_type, referenced_cufe, status, attempts, store_id, updated_at')
      .or(`status.in.(pending,rejected),and(status.eq.emitting,updated_at.lt.${stuckBefore})`)
      .lt('attempts', MAX_ATTEMPTS)
      .not('order_id', 'is', null)
      .order('created_at', { ascending: true })
      .limit(BATCH_SIZE);

    if (error) throw new HttpError(500, error.message);

    const configCache = new Map<string, EFacturaConfig | null>();
    const results: Array<{ id: string; authorized?: boolean; skipped?: string; error?: string }> = [];

    for (const row of rows || []) {
      try {
        // Resolve the company from the store, then its E-Factura config.
        const { data: store } = await admin
          .from('stores')
          .select('company_id')
          .eq('id', row.store_id)
          .maybeSingle();
        const companyId = store?.company_id;
        if (!companyId) {
          results.push({ id: row.id, skipped: 'no company' });
          continue;
        }

        if (!configCache.has(companyId)) {
          try {
            configCache.set(companyId, await loadEfacturaConfig(admin, companyId));
          } catch {
            configCache.set(companyId, null);
          }
        }
        const config = configCache.get(companyId);
        if (!config || !config.enabled) {
          results.push({ id: row.id, skipped: 'disabled' });
          continue;
        }

        const outcome = await emitOrder(admin, config, {
          orderId: row.order_id,
          docType: row.doc_type,
          referencedCufe: row.referenced_cufe,
          existingId: row.id,
          priorAttempts: row.attempts,
        });
        results.push({ id: row.id, authorized: outcome.authorized, error: outcome.error });
      } catch (e) {
        results.push({ id: row.id, error: (e as Error)?.message || 'error' });
      }
    }

    return res.status(200).json({
      success: true,
      processed: results.length,
      authorized: results.filter((r) => r.authorized).length,
      results,
    });
  } catch (err) {
    const status = err instanceof HttpError ? err.status : 500;
    return res.status(status).json({ success: false, error: (err as Error)?.message });
  }
}
