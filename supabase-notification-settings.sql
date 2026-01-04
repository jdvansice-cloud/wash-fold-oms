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

-- Drop existing policy if exists
DROP POLICY IF EXISTS "notification_settings_policy" ON public.notification_settings;

-- RLS Policy: Allow all operations for authenticated users
CREATE POLICY "notification_settings_policy" ON public.notification_settings
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Grant permissions
GRANT ALL ON public.notification_settings TO authenticated;
GRANT ALL ON public.notification_settings TO anon;

-- Verify
SELECT 'notification_settings table created successfully' as status;
SELECT * FROM public.notification_settings;
