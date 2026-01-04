-- =============================================
-- Quick fix: Add missing SMTP columns
-- Run this in Supabase SQL Editor
-- =============================================

-- Add columns if they don't exist
ALTER TABLE companies ADD COLUMN IF NOT EXISTS smtp_from_name character varying;
ALTER TABLE companies ADD COLUMN IF NOT EXISTS smtp_from_email character varying;
ALTER TABLE companies ADD COLUMN IF NOT EXISTS smtp_secure boolean DEFAULT true;

-- Create notification_settings table if not exists
CREATE TABLE IF NOT EXISTS notification_settings (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE,
  template_id character varying NOT NULL,
  enabled boolean DEFAULT true,
  subject character varying,
  body_template text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT notification_settings_pkey PRIMARY KEY (id),
  CONSTRAINT notification_settings_unique UNIQUE (company_id, template_id)
);

-- Disable RLS
ALTER TABLE notification_settings DISABLE ROW LEVEL SECURITY;

-- Grant permissions
GRANT ALL ON notification_settings TO anon;
GRANT ALL ON notification_settings TO authenticated;

-- Verify columns exist
SELECT column_name FROM information_schema.columns 
WHERE table_name = 'companies' AND column_name LIKE 'smtp%';
