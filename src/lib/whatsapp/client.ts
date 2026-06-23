// Browser client for the WhatsApp proxy (/api/whatsapp/send). Attaches the
// Supabase session; the server derives the company + secret token from it.
import { supabase } from '@/lib/supabase';

export interface SendWhatsAppPayload {
  to: string;
  template?: string;
  language_code?: string;
  components?: unknown;
  text?: string;
}

export async function sendWhatsApp(payload: SendWhatsAppPayload): Promise<any> {
  const { data: { session } } = await supabase.auth.getSession();
  const res = await fetch('/api/whatsapp/send', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${session?.access_token || ''}`,
    },
    body: JSON.stringify(payload),
  });
  const contentType = res.headers.get('content-type') || '';
  if (!contentType.includes('application/json')) {
    throw new Error('El envío de WhatsApp requiere el entorno desplegado (/api no disponible en dev).');
  }
  const body = await res.json().catch(() => ({}));
  if (!res.ok || body?.success === false) {
    throw new Error(body?.error || body?.reason || `Falló el envío (HTTP ${res.status})`);
  }
  return body;
}
