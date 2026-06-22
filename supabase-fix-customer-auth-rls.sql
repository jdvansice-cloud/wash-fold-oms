-- ============================================================
-- ⚠️  SUPERSEDED MIGRATION — DO NOT APPLY  ⚠️
-- This file disables RLS or uses USING(true) / GRANT ALL TO anon and would
-- RE-OPEN cross-tenant access. Kept for history only. The single source of
-- truth for RLS is supabase-fix-rls-tenant-isolation.sql.
-- The guard below aborts the script if it is pasted into the SQL editor.
-- ============================================================
DO $$ BEGIN
  RAISE EXCEPTION 'SUPERSEDED RLS migration — do not apply. Use supabase-fix-rls-tenant-isolation.sql.';
END $$;

-- Fix: Allow anon key to read customer_auth for auth resolution
-- The auth resolver needs to look up customer_auth by auth_id using the anon key

-- Drop existing restrictive policy if it exists
DROP POLICY IF EXISTS "anon_read_customer_auth" ON customer_auth;
DROP POLICY IF EXISTS "customer_auth_read" ON customer_auth;

-- Create permissive SELECT for service/anon (auth resolver needs this)
CREATE POLICY "anon_read_customer_auth" ON customer_auth
  FOR SELECT USING (true);

-- Also ensure customers table is readable (for the join)
DROP POLICY IF EXISTS "anon_read_customers" ON customers;
CREATE POLICY "anon_read_customers" ON customers
  FOR SELECT USING (true);

-- Verify
SELECT policyname, cmd, qual FROM pg_policies WHERE tablename = 'customer_auth';
