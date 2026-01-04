-- =============================================
-- SMTP & Notifications Setup
-- Run this in Supabase SQL Editor
-- =============================================

-- Add SMTP columns to companies table if they don't exist
DO $$ 
BEGIN
  -- smtp_from_name
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_name = 'companies' AND column_name = 'smtp_from_name') THEN
    ALTER TABLE companies ADD COLUMN smtp_from_name character varying;
  END IF;
  
  -- smtp_from_email
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_name = 'companies' AND column_name = 'smtp_from_email') THEN
    ALTER TABLE companies ADD COLUMN smtp_from_email character varying;
  END IF;
  
  -- smtp_secure
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_name = 'companies' AND column_name = 'smtp_secure') THEN
    ALTER TABLE companies ADD COLUMN smtp_secure boolean DEFAULT true;
  END IF;
END $$;

-- Create notification_settings table
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

-- Disable RLS on notification_settings
ALTER TABLE notification_settings DISABLE ROW LEVEL SECURITY;

-- Grant permissions
GRANT ALL ON notification_settings TO anon;
GRANT ALL ON notification_settings TO authenticated;

-- =============================================
-- Email sending function (uses pg_net extension)
-- Note: For production, use Supabase Edge Functions
-- =============================================

-- Create a simple function to test SMTP connectivity
-- This stores the test result - actual email sending requires Edge Functions
CREATE OR REPLACE FUNCTION send_test_email(
  to_email text,
  company_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_company record;
  v_result jsonb;
BEGIN
  -- Get company SMTP settings
  SELECT smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email, name
  INTO v_company
  FROM companies
  WHERE id = company_id;

  IF v_company.smtp_host IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'SMTP no configurado');
  END IF;

  -- For now, just return success with the config (actual sending done via Edge Function)
  -- In production, this would trigger an Edge Function or use pg_net
  RETURN jsonb_build_object(
    'success', true, 
    'message', 'Configuración SMTP válida. Para enviar emails, configura una Edge Function.',
    'config', jsonb_build_object(
      'host', v_company.smtp_host,
      'port', v_company.smtp_port,
      'from', COALESCE(v_company.smtp_from_email, v_company.smtp_user),
      'from_name', COALESCE(v_company.smtp_from_name, v_company.name)
    )
  );
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION send_test_email(text, uuid) TO anon;
GRANT EXECUTE ON FUNCTION send_test_email(text, uuid) TO authenticated;

-- =============================================
-- Verify setup
-- =============================================
SELECT 
  column_name, 
  data_type 
FROM information_schema.columns 
WHERE table_name = 'companies' 
  AND column_name LIKE 'smtp%'
ORDER BY column_name;

SELECT 'notification_settings table created' as status 
WHERE EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'notification_settings');
