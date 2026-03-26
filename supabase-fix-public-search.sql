-- Fix: Ensure companies and stores are readable by anon users
-- This is needed for the landing page org search

-- Check and recreate policies for public read access
DROP POLICY IF EXISTS "tenant_read" ON companies;
DROP POLICY IF EXISTS "tenant_manage" ON companies;
DROP POLICY IF EXISTS "tenant_read_stores" ON stores;
DROP POLICY IF EXISTS "tenant_manage_stores" ON stores;

-- Companies: anyone can SELECT (needed for org search on landing page)
CREATE POLICY "public_read_companies" ON companies FOR SELECT USING (true);
-- Only company members can modify
CREATE POLICY "tenant_manage_companies" ON companies FOR INSERT WITH CHECK (true);
CREATE POLICY "tenant_update_companies" ON companies FOR UPDATE USING (id = auth_company_id());
CREATE POLICY "tenant_delete_companies" ON companies FOR DELETE USING (id = auth_company_id());

-- Stores: anyone can SELECT (needed for org search join)
CREATE POLICY "public_read_stores" ON stores FOR SELECT USING (true);
-- Only company members can modify
CREATE POLICY "tenant_manage_stores" ON stores FOR INSERT WITH CHECK (true);
CREATE POLICY "tenant_update_stores" ON stores FOR UPDATE USING (company_id = auth_company_id());
CREATE POLICY "tenant_delete_stores" ON stores FOR DELETE USING (company_id = auth_company_id());

-- Verify: test the query that the landing page uses
-- SELECT id, name, slug, address FROM companies WHERE name ILIKE '%american%' LIMIT 8;
