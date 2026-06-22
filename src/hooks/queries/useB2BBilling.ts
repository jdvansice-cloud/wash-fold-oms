import { supabase } from '@/lib/supabase';

export interface OutstandingOrder {
  id: string;
  order_number: number;
  legacy_order_number: string | null;
  total: number;
  subtotal: number;
  tax_amount: number;
  created_at: string;
  status: string;
}

export interface B2BCustomerSummary {
  customer_id: string;
  name: string;
  company_name: string | null;
  order_count: number;
  outstanding_total: number;
}

export interface B2BInvoice {
  id: string;
  invoice_number: number;
  store_id: string;
  customer_id: string;
  status: 'open' | 'paid' | 'void';
  subtotal: number;
  tax_amount: number;
  total: number;
  notes: string | null;
  created_at: string;
  paid_at: string | null;
}

const displayNo = (o: { order_number: number; legacy_order_number: string | null }) =>
  o.legacy_order_number || `#${o.order_number}`;

/** B2B credit orders not yet placed on a consolidated invoice. */
export async function fetchOutstandingOrders(customerId: string): Promise<OutstandingOrder[]> {
  const { data, error } = await supabase
    .from('orders')
    .select('id, order_number, legacy_order_number, total, subtotal, tax_amount, created_at, status')
    .eq('customer_id', customerId)
    .eq('billing_type', 'account')
    .is('b2b_invoice_id', null)
    .order('created_at', { ascending: true });
  if (error) throw error;
  return (data as OutstandingOrder[]) || [];
}

/** B2B customers (in a store) with at least one un-invoiced credit order. */
export async function fetchB2BCustomersWithOutstanding(storeId: string): Promise<B2BCustomerSummary[]> {
  const { data, error } = await supabase
    .from('orders')
    .select('customer_id, total, customers(first_name, last_name, company_name)')
    .eq('store_id', storeId)
    .eq('billing_type', 'account')
    .is('b2b_invoice_id', null);
  if (error) throw error;
  const byCustomer = new Map<string, B2BCustomerSummary>();
  for (const row of (data as any[]) || []) {
    if (!row.customer_id) continue;
    const c = row.customers || {};
    const cur = byCustomer.get(row.customer_id) || {
      customer_id: row.customer_id,
      name: c.company_name || `${c.first_name || ''} ${c.last_name || ''}`.trim() || 'Cliente',
      company_name: c.company_name || null,
      order_count: 0,
      outstanding_total: 0,
    };
    cur.order_count += 1;
    cur.outstanding_total += Math.abs(Number(row.total) || 0);
    byCustomer.set(row.customer_id, cur);
  }
  return [...byCustomer.values()].sort((a, b) => b.outstanding_total - a.outstanding_total);
}

/**
 * Consolidate the given credit orders into one B2B invoice. The orders become
 * the invoice's line items (linked via orders.b2b_invoice_id); totals are summed
 * from the orders. Issued as 'open' (sent for payment); paid later.
 */
export async function generateB2BInvoice(args: {
  storeId: string;
  customerId: string;
  orderIds: string[];
  createdBy?: string | null;
  notes?: string;
}): Promise<B2BInvoice> {
  const { storeId, customerId, orderIds, createdBy, notes } = args;
  if (!orderIds.length) throw new Error('No hay órdenes seleccionadas.');

  // Re-read the orders server-side-ish to total them (and guard they're billable).
  const { data: orders, error: ordErr } = await supabase
    .from('orders')
    .select('id, subtotal, tax_amount, total, billing_type, b2b_invoice_id, customer_id')
    .in('id', orderIds);
  if (ordErr) throw ordErr;
  const billable = (orders || []).filter(
    (o: any) => o.customer_id === customerId && o.billing_type === 'account' && !o.b2b_invoice_id,
  );
  if (!billable.length) throw new Error('Las órdenes ya fueron facturadas o no son válidas.');

  const subtotal = round2(billable.reduce((s: number, o: any) => s + (Number(o.subtotal) || 0), 0));
  const tax = round2(billable.reduce((s: number, o: any) => s + (Number(o.tax_amount) || 0), 0));
  const total = round2(billable.reduce((s: number, o: any) => s + (Number(o.total) || 0), 0));

  const { data: invoice, error: invErr } = await supabase
    .from('b2b_invoices')
    .insert({
      store_id: storeId,
      customer_id: customerId,
      status: 'open',
      subtotal,
      tax_amount: tax,
      total,
      notes: notes || null,
      created_by: createdBy || null,
    })
    .select()
    .single();
  if (invErr) throw invErr;

  const { error: linkErr } = await supabase
    .from('orders')
    .update({ b2b_invoice_id: invoice.id })
    .in('id', billable.map((o: any) => o.id));
  if (linkErr) {
    // Roll back the invoice so we don't leave an empty one.
    await supabase.from('b2b_invoices').delete().eq('id', invoice.id);
    throw linkErr;
  }
  return invoice as B2BInvoice;
}

/** A customer's consolidated invoices (most recent first). */
export async function fetchB2BInvoices(customerId: string): Promise<B2BInvoice[]> {
  const { data, error } = await supabase
    .from('b2b_invoices')
    .select('*')
    .eq('customer_id', customerId)
    .order('created_at', { ascending: false });
  if (error) throw error;
  return (data as B2BInvoice[]) || [];
}

/** The orders that make up an invoice (its line items). */
export async function fetchInvoiceOrders(invoiceId: string): Promise<OutstandingOrder[]> {
  const { data, error } = await supabase
    .from('orders')
    .select('id, order_number, legacy_order_number, total, subtotal, tax_amount, created_at, status')
    .eq('b2b_invoice_id', invoiceId)
    .order('created_at', { ascending: true });
  if (error) throw error;
  return (data as OutstandingOrder[]) || [];
}

/** Mark an invoice paid: settle it and mark its orders paid. */
export async function markB2BInvoicePaid(invoiceId: string): Promise<void> {
  const { error: ordErr } = await supabase
    .from('orders')
    .update({ payment_status: 'paid', updated_at: new Date().toISOString() })
    .eq('b2b_invoice_id', invoiceId);
  if (ordErr) throw ordErr;
  const { error: invErr } = await supabase
    .from('b2b_invoices')
    .update({ status: 'paid', paid_at: new Date().toISOString() })
    .eq('id', invoiceId);
  if (invErr) throw invErr;
}

export const orderDisplayNumber = displayNo;

function round2(n: number): number {
  return Math.round((n + Number.EPSILON) * 100) / 100;
}
