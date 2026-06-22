// Cron: /api/notifications/pickup-reminders  (daily)
//
// Reminds customers whose order is ready but past its promised pickup date and
// hasn't been reminded in the last 24h. Authenticated by CRON_SECRET (Vercel
// sends `Authorization: Bearer <CRON_SECRET>`), uses the service-role key.

import { createClient } from '@supabase/supabase-js';
import { sendCompanyEmail } from '../_lib/email.js';

const esc = (s) => String(s ?? '').replace(/[<>&]/g, (c) => ({ '<': '&lt;', '>': '&gt;', '&': '&amp;' }[c]));

export default async function handler(req, res) {
  const secret = process.env.CRON_SECRET;
  const header = req.headers.authorization || '';
  if (!secret || header !== `Bearer ${secret}`) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SECRET_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!supabaseUrl || !serviceKey) {
    return res.status(500).json({ error: 'Server misconfigured' });
  }
  const admin = createClient(supabaseUrl, serviceKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  try {
    const now = new Date();
    const cutoff = new Date(now.getTime() - 24 * 3600 * 1000).toISOString();

    // Ready, past promised pickup, not reminded in the last 24h.
    const { data: orders, error } = await admin
      .from('orders')
      .select('id, order_number, customer_name, store_id, customers(email, first_name), stores(company_id, companies(name))')
      .eq('status', 'ready')
      .lt('promised_date', now.toISOString())
      .or(`pickup_reminder_at.is.null,pickup_reminder_at.lt.${cutoff}`)
      .limit(200);
    if (error) throw error;

    let sent = 0;
    let skipped = 0;
    for (const o of orders || []) {
      const email = o.customers?.email;
      const companyId = o.stores?.company_id;
      const companyName = o.stores?.companies?.name || 'Lavandería';
      if (!email || !companyId) {
        skipped += 1;
        continue;
      }
      const number = o.order_number;
      const name = o.customers?.first_name || o.customer_name || 'Cliente';
      const subject = `Recordatorio: tu orden #${number} está lista para recoger - ${companyName}`;
      const html = `<p>Hola ${esc(name)},</p>
        <p>Tu orden <strong>#${esc(number)}</strong> está lista y te espera para recoger en ${esc(companyName)}.</p>
        <p>¡Gracias!</p>`;
      try {
        const r = await sendCompanyEmail(admin, companyId, { to: email, subject, html });
        if (r.sent) {
          await admin.from('orders').update({ pickup_reminder_at: now.toISOString() }).eq('id', o.id);
          sent += 1;
        } else {
          skipped += 1;
        }
      } catch (e) {
        console.error('pickup-reminder send failed', o.id, e?.message || e);
        skipped += 1;
      }
    }

    return res.status(200).json({ success: true, candidates: orders?.length || 0, sent, skipped });
  } catch (err) {
    console.error('pickup-reminders cron error:', err);
    return res.status(500).json({ success: false, error: err.message });
  }
}
