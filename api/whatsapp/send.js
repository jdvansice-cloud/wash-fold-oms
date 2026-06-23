// POST /api/whatsapp/send  { to, template?, language_code?, components?, text? }
//
// Sends a WhatsApp message through the caller's company Cloud API config. The
// caller presents a Supabase session token; the company is derived from the
// authenticated staff user (never the body), and the secret token is read
// server-side only. Mirrors api/send-email.js.

import { createClient } from '@supabase/supabase-js';
import { sendWhatsAppMessage } from '../_lib/whatsapp.js';

export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SECRET_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!supabaseUrl || !serviceKey) {
    return res.status(500).json({ error: 'Server misconfigured' });
  }

  try {
    const authHeader = req.headers.authorization || '';
    const token = authHeader.startsWith('Bearer ') ? authHeader.slice(7) : null;
    if (!token) return res.status(401).json({ error: 'Missing Authorization bearer token' });

    const admin = createClient(supabaseUrl, serviceKey, {
      auth: { autoRefreshToken: false, persistSession: false },
    });

    const { data: userData, error: userError } = await admin.auth.getUser(token);
    if (userError || !userData?.user) return res.status(401).json({ error: 'Invalid or expired session' });

    const { data: staff } = await admin
      .from('users')
      .select('company_id')
      .eq('auth_id', userData.user.id)
      .maybeSingle();
    if (!staff?.company_id) return res.status(403).json({ error: 'Not authorized' });

    const { to, template, language_code, components, text } = req.body || {};
    if (!to) return res.status(400).json({ error: 'Missing recipient (to)' });

    const { data: cfg } = await admin
      .from('company_whatsapp')
      .select('*')
      .eq('company_id', staff.company_id)
      .maybeSingle();
    if (!cfg?.phone_number_id || !cfg?.access_token) {
      return res.status(200).json({ success: false, skipped: true, reason: 'not configured' });
    }

    const out = await sendWhatsAppMessage(cfg, { to, template, languageCode: language_code, components, text });
    return res.status(200).json({ success: !!out.sent, ...out });
  } catch (err) {
    console.error('WhatsApp send error:', err);
    return res.status(500).json({ success: false, error: err.message });
  }
}
