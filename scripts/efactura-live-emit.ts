// Live end-to-end test: emit ONE real order through the test PAC using the
// actual production code path (emitOrder), then read back the DB row.
// Run: EFACTURA_KEY=... npx vite-node scripts/efactura-live-emit.ts
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import { emitOrder } from '../api/efactura/_shared';

const env = fs.readFileSync('.env.test', 'utf8');
const get = (k: string) => env.match(new RegExp('^' + k + '=(.*)$', 'm'))?.[1].trim() || '';
const admin = createClient(get('SUPABASE_URL'), get('SUPABASE_SERVICE_ROLE_KEY'), {
  auth: { persistSession: false },
});

const apiKey = process.env.EFACTURA_KEY;
if (!apiKey) throw new Error('Set EFACTURA_KEY');

// Find a recent paid order that has no active factura yet.
const { data: orders } = await admin
  .from('orders')
  .select('id, order_number, total, store_id, company:stores(company_id)')
  .gt('total', 0)
  .order('created_at', { ascending: false })
  .limit(30);

let target: any = null;
for (const o of orders || []) {
  const { data: existing } = await admin
    .from('electronic_invoices')
    .select('id')
    .eq('order_id', o.id)
    .eq('doc_type', '01')
    .in('status', ['authorized', 'emitting', 'pending'])
    .maybeSingle();
  if (!existing && (o as any).company?.company_id) {
    target = o;
    break;
  }
}
if (!target) throw new Error('No eligible order found');

const config = {
  company_id: target.company.company_id,
  api_key: apiKey,
  environment: 'test' as const,
  punto_facturacion: '001',
  default_cpbs_code: null,
  default_cpbs_code_short: null,
  enabled: true,
};

console.log(`Emitting order #${target.order_number} (total ${target.total})…`);
const outcome = await emitOrder(admin, config, { orderId: target.id });
console.log('Outcome:', {
  authorized: outcome.authorized,
  cufe: outcome.cufe,
  error: outcome.error,
});

// Read back the persisted row.
const { data: row } = await admin
  .from('electronic_invoices')
  .select('id, status, doc_type, environment, cufe, protocolo_autorizacion, qr_content, attempts')
  .eq('id', outcome.invoiceId)
  .single();
console.log('DB row:', row);
