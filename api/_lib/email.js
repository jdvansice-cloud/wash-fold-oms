// Shared server-side email sender. Loads a company's SMTP settings (service-role)
// and sends via nodemailer. Used by user-authenticated endpoints AND by crons
// (which have no user session), so it takes an explicit companyId.

import nodemailer from 'nodemailer';

const cache = new Map(); // companyId -> { transporter, from } | null (not configured)

export async function sendCompanyEmail(admin, companyId, { to, subject, html, text }) {
  if (!companyId || !to || !subject) return { sent: false, reason: 'missing-args' };

  let entry = cache.get(companyId);
  if (entry === undefined) {
    const { data: smtp } = await admin
      .from('company_smtp')
      .select('smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email')
      .eq('company_id', companyId)
      .maybeSingle();
    if (!smtp?.smtp_host || !smtp.smtp_user || !smtp.smtp_pass) {
      cache.set(companyId, null);
      entry = null;
    } else {
      const port = smtp.smtp_port || 587;
      entry = {
        transporter: nodemailer.createTransport({
          host: smtp.smtp_host,
          port,
          secure: port === 465,
          auth: { user: smtp.smtp_user, pass: smtp.smtp_pass },
        }),
        from: `"${smtp.smtp_from_name || 'Notificación'}" <${smtp.smtp_from_email || smtp.smtp_user}>`,
      };
      cache.set(companyId, entry);
    }
  }
  if (!entry) return { sent: false, reason: 'smtp-not-configured' };

  await entry.transporter.sendMail({ from: entry.from, to, subject, text: text || '', html: html || text || '' });
  return { sent: true };
}
