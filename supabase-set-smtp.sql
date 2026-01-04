-- =============================================
-- Set SMTP Settings Directly
-- Run this in Supabase SQL Editor
-- =============================================

UPDATE companies 
SET 
  smtp_host = 'smtp.gmail.com',
  smtp_port = 587,
  smtp_user = 'consultas@lavaydobla.com',
  smtp_pass = 'loxy vyzy rnrs kkvt',
  smtp_from_name = 'American Laundry',
  smtp_from_email = 'NoReply@lavaydobla.com',
  smtp_secure = true,
  updated_at = NOW()
WHERE id = '012b703e-1245-4c56-9f7d-78fff25435ed';

-- Verify it saved
SELECT 
  name,
  smtp_host,
  smtp_port,
  smtp_user,
  smtp_pass,
  smtp_from_name,
  smtp_from_email,
  smtp_secure
FROM companies 
WHERE id = '012b703e-1245-4c56-9f7d-78fff25435ed';
