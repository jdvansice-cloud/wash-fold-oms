-- Migration: Add notification_settings table for email templates
-- Run this in Supabase SQL Editor

-- Create notification_settings table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.notification_settings (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  template_id varchar NOT NULL, -- 'welcome', 'order_created', 'order_ready', 'order_delivered'
  enabled boolean DEFAULT true,
  subject varchar,
  body_template text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT notification_settings_pkey PRIMARY KEY (id),
  CONSTRAINT notification_settings_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE,
  CONSTRAINT notification_settings_unique UNIQUE (company_id, template_id)
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_notification_settings_company_template 
ON public.notification_settings(company_id, template_id);

-- Enable RLS
ALTER TABLE public.notification_settings ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Allow all operations for authenticated users
CREATE POLICY "notification_settings_policy" ON public.notification_settings
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Grant permissions
GRANT ALL ON public.notification_settings TO authenticated;
GRANT ALL ON public.notification_settings TO anon;

-- Insert default notification settings for existing companies
INSERT INTO public.notification_settings (company_id, template_id, enabled, subject, body_template)
SELECT 
  c.id,
  t.template_id,
  true,
  t.subject,
  t.body_template
FROM public.companies c
CROSS JOIN (
  VALUES 
    ('welcome', '¡Bienvenido a {company_name}!', '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;"><h1 style="color: #0891b2;">¡Bienvenido, {customer_name}!</h1><p>Gracias por registrarte en <strong>{company_name}</strong>.</p><p>Estamos aquí para hacer tu vida más fácil con nuestros servicios de lavandería profesional.</p><p>¡Te esperamos pronto!</p><hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;"><p style="color: #64748b; font-size: 12px;">{company_name}<br>Este es un mensaje automático, por favor no responder.</p></div>'),
    ('order_created', 'Tu orden #{order_number} ha sido recibida - {company_name}', '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;"><h1 style="color: #0891b2;">¡Orden Recibida!</h1><p>Hola {customer_name},</p><p>Hemos recibido tu orden <strong>#{order_number}</strong>.</p><table style="width: 100%; margin: 20px 0; border-collapse: collapse;"><tr><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;"><strong>Total:</strong></td><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;">B/{total}</td></tr><tr><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;"><strong>Fecha estimada:</strong></td><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;">{promised_date}</td></tr></table><p>Te notificaremos cuando tu orden esté lista.</p><hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;"><p style="color: #64748b; font-size: 12px;">{company_name} | {store_phone}</p></div>'),
    ('order_ready', '¡Tu orden #{order_number} está lista! - {company_name}', '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;"><h1 style="color: #10b981;">¡Tu orden está lista!</h1><p>Hola {customer_name},</p><p>Tu orden <strong>#{order_number}</strong> está lista para recoger.</p><div style="background: #f0fdf4; padding: 15px; border-radius: 8px; margin: 20px 0;"><p style="margin: 0; color: #166534;"><strong>✓ Lista para recoger</strong></p></div><p>Te esperamos en nuestra tienda.</p><hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;"><p style="color: #64748b; font-size: 12px;">{company_name} | {store_phone}</p></div>'),
    ('order_delivered', 'Orden #{order_number} entregada - {company_name}', '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;"><h1 style="color: #10b981;">¡Orden Entregada!</h1><p>Hola {customer_name},</p><p>Tu orden <strong>#{order_number}</strong> ha sido entregada exitosamente.</p><div style="background: #f0fdf4; padding: 15px; border-radius: 8px; margin: 20px 0;"><p style="margin: 0; color: #166534;"><strong>✓ Entrega completada</strong></p></div><p>¡Gracias por confiar en nosotros!</p><hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;"><p style="color: #64748b; font-size: 12px;">{company_name}</p></div>')
) AS t(template_id, subject, body_template)
ON CONFLICT (company_id, template_id) DO NOTHING;

-- Verify
SELECT * FROM public.notification_settings;
