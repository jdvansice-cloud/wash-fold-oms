// Vercel Serverless Function: /api/send-email
//
// Sends transactional email through the caller's company SMTP settings.
// The caller MUST present a valid Supabase session token (Authorization:
// Bearer <access_token>). The sending company is derived from the
// authenticated staff user — never from the request body — so a caller can
// only ever send mail for their own company.

import { createClient } from '@supabase/supabase-js';
import nodemailer from 'nodemailer';

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !serviceKey) {
    return res.status(500).json({
      error: 'Server misconfigured: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are required.',
    });
  }

  try {
    // --- Authenticate the caller ---
    const authHeader = req.headers.authorization || '';
    const token = authHeader.startsWith('Bearer ') ? authHeader.slice(7) : null;
    if (!token) {
      return res.status(401).json({ error: 'Missing Authorization bearer token' });
    }

    // Service-role client: validates the token and reads SMTP secrets.
    const admin = createClient(supabaseUrl, serviceKey, {
      auth: { autoRefreshToken: false, persistSession: false },
    });

    const { data: userData, error: userError } = await admin.auth.getUser(token);
    if (userError || !userData?.user) {
      return res.status(401).json({ error: 'Invalid or expired session' });
    }

    // --- Resolve the caller's company (staff only) ---
    const { data: staff, error: staffError } = await admin
      .from('users')
      .select('company_id')
      .eq('auth_id', userData.user.id)
      .maybeSingle();

    if (staffError || !staff?.company_id) {
      return res.status(403).json({ error: 'Not authorized to send email' });
    }

    const { to, subject, html, text } = req.body || {};
    if (!to || !subject) {
      return res.status(400).json({ error: 'Missing required fields: to, subject' });
    }

    // --- Load SMTP settings for the caller's company ---
    const { data: smtp, error: smtpError } = await admin
      .from('company_smtp')
      .select('smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email')
      .eq('company_id', staff.company_id)
      .maybeSingle();

    if (smtpError) {
      console.error('SMTP lookup error:', smtpError);
      return res.status(500).json({ error: 'Could not load SMTP settings' });
    }
    if (!smtp || !smtp.smtp_host || !smtp.smtp_user || !smtp.smtp_pass) {
      return res.status(400).json({ error: 'SMTP not configured for this company' });
    }

    // --- Send ---
    const port = smtp.smtp_port || 587;
    const transporter = nodemailer.createTransport({
      host: smtp.smtp_host,
      port,
      secure: port === 465, // implicit TLS on 465, STARTTLS otherwise
      auth: { user: smtp.smtp_user, pass: smtp.smtp_pass },
    });

    const info = await transporter.sendMail({
      from: `"${smtp.smtp_from_name || 'Notificación'}" <${smtp.smtp_from_email || smtp.smtp_user}>`,
      to,
      subject,
      text: text || '',
      html: html || text || '',
    });

    return res.status(200).json({ success: true, messageId: info.messageId });
  } catch (error) {
    console.error('Error sending email:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
}
