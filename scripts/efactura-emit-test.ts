// Throwaway: build an invoice with the real builder and emit it to the test PAC.
// Run: EFACTURA_KEY=... npx vite-node scripts/efactura-emit-test.ts
import { buildInvoiceRequest } from '../src/lib/efactura/buildInvoice';

const KEY = process.env.EFACTURA_KEY;
const BASE = 'https://api.efacturapty.com/api/v1';

const payload = buildInvoiceRequest({
  order: { tax_amount: 0.7, total: 10.7 },
  items: [
    {
      description: 'Lavado y doblado - prueba builder',
      internalCode: 'WF-001',
      quantity: 1,
      unitPrice: 10,
      lineTotal: 10,
      isTaxable: true,
    },
  ],
  payments: [{ method: 'Efectivo', amount: 10.7 }],
  customer: { first_name: 'Cliente', last_name: 'Prueba' },
  config: { itbmsRate: 7 },
});

console.log('PAYLOAD:\n', JSON.stringify(payload, null, 2));

const res = await fetch(`${BASE}/Invoices`, {
  method: 'POST',
  headers: { Authorization: `Bearer ${KEY}`, 'Content-Type': 'application/json' },
  body: JSON.stringify(payload),
});
const json: any = await res.json();
console.log('\nHTTP', res.status);
console.log('cufe:', json.cufe, '| autorizada:', json.autorizada, '| secuence:', json.secuence);
if (!json.autorizada) console.log('FULL:', JSON.stringify(json).slice(0, 1200));
