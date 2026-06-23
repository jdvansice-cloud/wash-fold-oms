// Shared WhatsApp sender — Meta Cloud API. Takes a company's config so it works
// from user-authenticated endpoints and crons alike.

const GRAPH = 'https://graph.facebook.com/v21.0';

/** Digits-only E.164 (no +). Panama locals are 8 digits → prepend country code. */
export function normalizePhone(raw, defaultCc = '507') {
  let d = String(raw || '').replace(/\D/g, '');
  if (!d) return '';
  if (d.length <= 8 && defaultCc) d = String(defaultCc) + d;
  return d;
}

/**
 * Send a WhatsApp message. `template` (name + optional components) for proactive
 * notifications; `text` for free-form replies (only valid inside the 24h window
 * or to test recipients of a test number).
 */
export async function sendWhatsAppMessage(config, { to, template, languageCode = 'es', components, text }) {
  if (!config?.phone_number_id || !config?.access_token) return { sent: false, reason: 'not-configured' };
  const phone = normalizePhone(to, config.default_country_code || '507');
  if (!phone) return { sent: false, reason: 'no-recipient' };

  const body = template
    ? {
        messaging_product: 'whatsapp',
        to: phone,
        type: 'template',
        template: { name: template, language: { code: languageCode }, ...(components ? { components } : {}) },
      }
    : { messaging_product: 'whatsapp', to: phone, type: 'text', text: { body: text || '' } };

  const res = await fetch(`${GRAPH}/${config.phone_number_id}/messages`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${config.access_token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(data?.error?.message || `WhatsApp send failed (HTTP ${res.status})`);
  return { sent: true, id: data?.messages?.[0]?.id };
}
