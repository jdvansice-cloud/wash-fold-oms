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
