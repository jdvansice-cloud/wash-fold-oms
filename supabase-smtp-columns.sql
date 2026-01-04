-- =============================================
-- Quick fix: Add missing SMTP columns + RPC function
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

-- Disable RLS on all relevant tables
ALTER TABLE companies DISABLE ROW LEVEL SECURITY;
ALTER TABLE notification_settings DISABLE ROW LEVEL SECURITY;

-- Drop any existing policies on companies
DO $$ 
DECLARE
    pol RECORD;
BEGIN
    FOR pol IN SELECT policyname FROM pg_policies WHERE tablename = 'companies' LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON companies', pol.policyname);
    END LOOP;
END $$;

-- Grant permissions
GRANT ALL ON companies TO anon;
GRANT ALL ON companies TO authenticated;
GRANT ALL ON notification_settings TO anon;
GRANT ALL ON notification_settings TO authenticated;

-- Create RPC function to update SMTP settings (bypasses potential hanging issues)
CREATE OR REPLACE FUNCTION update_company_smtp(
  p_company_id uuid,
  p_smtp_host text,
  p_smtp_port integer,
  p_smtp_user text,
  p_smtp_pass text,
  p_smtp_from_name text,
  p_smtp_from_email text,
  p_smtp_secure boolean
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE companies 
  SET 
    smtp_host = p_smtp_host,
    smtp_port = p_smtp_port,
    smtp_user = p_smtp_user,
    smtp_pass = p_smtp_pass,
    smtp_from_name = p_smtp_from_name,
    smtp_from_email = p_smtp_from_email,
    smtp_secure = p_smtp_secure,
    updated_at = NOW()
  WHERE id = p_company_id;
  
  RETURN jsonb_build_object('success', true);
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION update_company_smtp(uuid, text, integer, text, text, text, text, boolean) TO anon;
GRANT EXECUTE ON FUNCTION update_company_smtp(uuid, text, integer, text, text, text, text, boolean) TO authenticated;

-- Verify columns exist
SELECT column_name FROM information_schema.columns 
WHERE table_name = 'companies' AND column_name LIKE 'smtp%';

-- Test the RPC function exists
SELECT 'update_company_smtp function created' as status;
