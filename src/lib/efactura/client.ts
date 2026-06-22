// Browser-side client for the E-Factura proxy (/api/efactura/*).
// Each call attaches the current Supabase session token; the server derives the
// company and PAC key from it. Kept out of the package barrel (index.ts) so the
// pure builder can be imported server-side without pulling in the Supabase SDK.

import { supabase } from '@/lib/supabase';

async function authedFetch(path: string, init: RequestInit = {}): Promise<any> {
  const {
    data: { session },
  } = await supabase.auth.getSession();
  const res = await fetch(path, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${session?.access_token || ''}`,
      ...(init.headers || {}),
    },
  });
  const body = await res.json().catch(() => ({}));
  if (!res.ok || body?.success === false) {
    throw new Error(body?.error || `Request failed (HTTP ${res.status})`);
  }
  return body;
}

export interface EmitResult {
  success: true;
  invoiceId: string;
  cufe?: string;
  qrContent?: string;
  protocoloAutorizacion?: string;
  alreadyEmitted?: boolean;
}

/** Emits (or returns the existing) electronic document for an order. */
export function emitInvoice(orderId: string, opts?: { docType?: '01' | '06' | '07'; referencedCufe?: string }) {
  return authedFetch('/api/efactura/emit', {
    method: 'POST',
    body: JSON.stringify({
      order_id: orderId,
      doc_type: opts?.docType,
      referenced_cufe: opts?.referencedCufe,
    }),
  }) as Promise<EmitResult>;
}

/** Emits (or returns the existing) consolidated factura for a B2B invoice. */
export function emitB2BInvoice(b2bInvoiceId: string) {
  return authedFetch('/api/efactura/emit', {
    method: 'POST',
    body: JSON.stringify({ b2b_invoice_id: b2bInvoiceId }),
  }) as Promise<EmitResult>;
}

/** Voids an authorized factura at the PAC. */
export function cancelInvoice(params: { invoiceId?: string; cufe?: string; reason: string }) {
  return authedFetch('/api/efactura/cancel', {
    method: 'POST',
    body: JSON.stringify({ invoice_id: params.invoiceId, cufe: params.cufe, reason: params.reason }),
  });
}

/** Fetches the CAFE PDF (base64) for an authorized invoice. */
export function fetchCafePdf(params: { invoiceId?: string; cufe?: string }): Promise<{ base64: string; contentType: string }> {
  const q = params.invoiceId ? `invoice_id=${encodeURIComponent(params.invoiceId)}` : `cufe=${encodeURIComponent(params.cufe || '')}`;
  return authedFetch(`/api/efactura/cafe?${q}`, { method: 'GET' });
}
