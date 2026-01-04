// Vercel Serverless Function: /api/send-email.js
// This function sends emails using SMTP credentials stored in Supabase

import { createClient } from '@supabase/supabase-js';
import nodemailer from 'nodemailer';

export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { to, subject, html, text, company_id } = req.body;

    if (!to || !subject || !company_id) {
      return res.status(400).json({ error: 'Missing required fields: to, subject, company_id' });
    }

    // Get Supabase credentials - try multiple env var names
    const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return res.status(500).json({ 
        error: 'supabaseKey is required. Add SUPABASE_URL and SUPABASE_ANON_KEY to Vercel Environment Variables.' 
      });
    }

    // Initialize Supabase client
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Get SMTP settings from database
    const { data: company, error: companyError } = await supabase
      .from('companies')
      .select('smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email, smtp_secure, name')
      .eq('id', company_id)
      .single();

    if (companyError || !company) {
      console.error('Company error:', companyError);
      return res.status(404).json({ error: 'Company not found' });
    }

    if (!company.smtp_host || !company.smtp_user || !company.smtp_pass) {
      return res.status(400).json({ error: 'SMTP not configured for this company' });
    }

    // Create transporter
    const transporter = nodemailer.createTransport({
      host: company.smtp_host,
      port: company.smtp_port || 587,
      secure: company.smtp_port === 465, // true for 465, false for other ports
      auth: {
        user: company.smtp_user,
        pass: company.smtp_pass,
      },
      tls: {
        rejectUnauthorized: false // Allow self-signed certificates
      }
    });

    // Send email
    const info = await transporter.sendMail({
      from: `"${company.smtp_from_name || company.name || 'Notification'}" <${company.smtp_from_email || company.smtp_user}>`,
      to: to,
      subject: subject,
      text: text || '',
      html: html || text || '',
    });

    console.log('Email sent:', info.messageId);

    return res.status(200).json({ 
      success: true, 
      messageId: info.messageId 
    });

  } catch (error) {
    console.error('Error sending email:', error);
    return res.status(500).json({ 
      success: false, 
      error: error.message 
    });
  }
}
