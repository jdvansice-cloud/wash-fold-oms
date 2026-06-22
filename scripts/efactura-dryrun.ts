// Dry run: build an InvoiceRequest from a REAL order in the DB (no PAC call).
// Validates the order→payload enrichment + reconciliation on real data.
// Run: npx vite-node scripts/efactura-dryrun.ts
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import { buildPayloadForOrder } from '../api/efactura/_shared';

const env = fs.readFileSync('.env.test', 'utf8');
const get = (k: string) => env.match(new RegExp('^' + k + '=(.*)$', 'm'))?.[1].trim() || '';
const admin = createClient(get('SUPABASE_URL'), get('SUPABASE_SERVICE_ROLE_KEY'), {
  auth: { persistSession: false },
});

// Synthetic config (no DB row needed for a dry run).
const config = {
  company_id: '',
  api_key: 'dryrun',
  environment: 'test' as const,
  punto_facturacion: '001',
  default_cpbs_code: null,
  default_cpbs_code_short: null,
  enabled: true,
};

// Pick a few recent paid orders with items + payments.
const { data: orders } = await admin
  .from('orders')
  .select('id, order_number, total, store_id, company:stores(company_id)')
  .gt('total', 0)
  .order('created_at', { ascending: false })
  .limit(20);

let tested = 0;
for (const o of orders || []) {
  const companyId = (o as any).company?.company_id;
  if (!companyId) continue;
  try {
    const { payload } = await buildPayloadForOrder(admin, { ...config, company_id: companyId }, o.id);
    const t = payload.totales;
    const sumItbms = payload.listaItems.reduce((s, i) => s + i.grupoITBMS.montoITBMS, 0);
    console.log(
      `✅ #${o.order_number} total=${o.total} → items=${payload.listaItems.length} ` +
        `neto=${t.totalNeto} itbms=${t.totalITBMS} valor=${t.valorTotalFactura} ` +
        `receptor=${payload.datosGenerales.informacionReceptor.tipoReceptorFe} ` +
        `(ΣITBMS=${sumItbms.toFixed(2)})`,
    );
    tested++;
    if (tested >= 5) break;
  } catch (e) {
    console.log(`❌ #${o.order_number} total=${o.total}: ${(e as Error).message}`);
    tested++;
    if (tested >= 5) break;
  }
}
console.log(`\nTested ${tested} order(s).`);
