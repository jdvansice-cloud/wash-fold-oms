import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import { emitInvoice, cancelInvoice, fetchCafePdf } from '@/lib/efactura/client';
import { generateReceiptData, printFiscalReceipt } from '@/utils/receiptPrinter';
import type { ElectronicInvoice } from '@/types';

/** Latest electronic document (factura/NC) for an order, if any. */
async function fetchOrderInvoice(orderId: string): Promise<ElectronicInvoice | null> {
  const { data, error } = await supabase
    .from('electronic_invoices')
    .select('*')
    .eq('order_id', orderId)
    .order('created_at', { ascending: false })
    .limit(1)
    .maybeSingle();
  if (error) throw error;
  return (data as ElectronicInvoice) || null;
}

export function useOrderInvoice(orderId?: string) {
  return useQuery({
    queryKey: ['electronic-invoice', orderId],
    queryFn: () => fetchOrderInvoice(orderId as string),
    enabled: !!orderId,
  });
}

export function useEmitInvoice(orderId?: string) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: () => emitInvoice(orderId as string),
    onSuccess: () => qc.invalidateQueries({ queryKey: ['electronic-invoice', orderId] }),
  });
}

export function useCancelInvoice(orderId?: string) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (params: { invoiceId?: string; cufe?: string; reason: string }) =>
      cancelInvoice(params),
    onSuccess: () => qc.invalidateQueries({ queryKey: ['electronic-invoice', orderId] }),
  });
}

async function fetchCafeBlobUrl(params: { invoiceId?: string; cufe?: string }) {
  const { base64, contentType } = await fetchCafePdf(params);
  const bytes = Uint8Array.from(atob(base64), (c) => c.charCodeAt(0));
  const blob = new Blob([bytes], { type: contentType || 'application/pdf' });
  return URL.createObjectURL(blob);
}

/** Fetches the CAFE PDF and triggers a browser download. */
export async function downloadCafe(params: { invoiceId?: string; cufe?: string }, filename = 'factura.pdf') {
  const url = await fetchCafeBlobUrl(params);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(url);
}

/**
 * Fetches the CAFE PDF and opens the print dialog. Uses a hidden iframe (not a
 * popup) so it isn't blocked, and works for both first print and reprints.
 */
export async function printCafe(params: { invoiceId?: string; cufe?: string }) {
  const url = await fetchCafeBlobUrl(params);
  const iframe = document.createElement('iframe');
  iframe.style.position = 'fixed';
  iframe.style.right = '0';
  iframe.style.bottom = '0';
  iframe.style.width = '0';
  iframe.style.height = '0';
  iframe.style.border = '0';
  iframe.src = url;
  iframe.onload = () => {
    try {
      iframe.contentWindow?.focus();
      iframe.contentWindow?.print();
    } catch {
      /* ignore — browser PDF viewer handles printing */
    }
  };
  document.body.appendChild(iframe);
  // Clean up after the print dialog has had time to read the document.
  setTimeout(() => {
    iframe.remove();
    URL.revokeObjectURL(url);
  }, 60_000);
}

/**
 * Silently reprints the thermal representación impresa (QR + CUFE) of an
 * authorized factura / nota de crédito — no browser dialog. Assembles the
 * receipt data from the order and routes it through the active print transport.
 */
export async function reprintFiscalReceipt(orderId: string, invoice: ElectronicInvoice) {
  const { data: order, error } = await supabase
    .from('orders')
    .select('*, order_items(*), payments(*), stores(*, companies(*))')
    .eq('id', orderId)
    .single();
  if (error || !order) throw new Error('No se pudo cargar la orden.');

  const store = (order as any).stores || null;
  const company = store?.companies || null;
  const payments = ((order as any).payments || []).map((p: any) => ({
    method: p.payment_method,
    amount: p.amount,
    reference: p.reference || '',
  }));
  const receiptData = generateReceiptData(
    order,
    company,
    store,
    (order as any).order_items || [],
    payments,
  );
  await printFiscalReceipt(receiptData, invoice, false);
}

export interface InvoiceWithOrder extends ElectronicInvoice {
  orders?: { order_number: number; customer_name: string | null; total: number } | null;
}

/** Electronic documents for a store within a date range (for reports). */
async function fetchStoreInvoices(
  storeId: string,
  startISO: string,
  endISO: string,
): Promise<InvoiceWithOrder[]> {
  const { data, error } = await supabase
    .from('electronic_invoices')
    .select('*, orders(order_number, customer_name, total)')
    .eq('store_id', storeId)
    .gte('created_at', startISO)
    .lte('created_at', endISO)
    .order('created_at', { ascending: false });
  if (error) throw error;
  return (data as InvoiceWithOrder[]) || [];
}

export function useStoreInvoices(storeId?: string, startISO?: string, endISO?: string) {
  return useQuery({
    queryKey: ['store-invoices', storeId, startISO, endISO],
    queryFn: () => fetchStoreInvoices(storeId as string, startISO as string, endISO as string),
    enabled: !!storeId && !!startISO && !!endISO,
  });
}

/**
 * Latest electronic document per order, for a set of order ids. Returned as a
 * map keyed by order_id (used by the EOD reconciliation).
 */
async function fetchInvoicesForOrders(orderIds: string[]): Promise<Record<string, ElectronicInvoice>> {
  if (orderIds.length === 0) return {};
  const { data, error } = await supabase
    .from('electronic_invoices')
    .select('*')
    .in('order_id', orderIds)
    .order('created_at', { ascending: false });
  if (error) throw error;
  const map: Record<string, ElectronicInvoice> = {};
  for (const row of (data as ElectronicInvoice[]) || []) {
    // First seen wins (rows are newest-first), so we keep the latest per order.
    if (row.order_id && !map[row.order_id]) map[row.order_id] = row;
  }
  return map;
}

export function useInvoicesForOrders(orderIds: string[]) {
  // Stable key regardless of order array identity / ordering.
  const key = [...orderIds].sort().join(',');
  return useQuery({
    queryKey: ['invoices-for-orders', key],
    queryFn: () => fetchInvoicesForOrders(orderIds),
    enabled: orderIds.length > 0,
  });
}
