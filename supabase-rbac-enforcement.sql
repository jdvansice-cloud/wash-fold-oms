-- ============================================================
-- RBAC enforcement + customer tenant-hop fix  (Roadmap Phase A)
-- ============================================================
-- Today every staff user (operator/supervisor/admin) has identical write
-- rights in RLS because policies only check `auth_is_staff()`. This migration
-- adds role helpers and restricts CONFIG / SECRET tables to ADMINS only, and
-- pins a customer's store_id on self-update (prevents tenant-hopping).
--
-- Safe for daily POS: the tables tightened here (company settings, SMTP,
-- e-factura config, notification + loyalty settings) are already admin-only in
-- the UI; this is defense-in-depth at the database layer. Orders, payments,
-- customers, products, etc. remain writable by any staff.
--
-- PRECONDITION: each company must have at least one user with role='admin'
-- (otherwise no one can edit that company's settings). Verify before applying:
--   SELECT company_id, count(*) FILTER (WHERE role='admin') AS admins
--   FROM users GROUP BY company_id;
--
-- Idempotent and transactional. Depends on auth_company_id()/auth_is_staff()
-- from supabase-fix-rls-tenant-isolation.sql.
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- 1. Role helper functions (SECURITY DEFINER → bypass RLS, no recursion)
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION auth_role() RETURNS TEXT
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT role FROM users WHERE auth_id = auth.uid() LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION auth_is_admin() RETURNS BOOLEAN
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid() AND role = 'admin');
$$;

-- admin OR supervisor (for manager-level actions; available for later phases)
CREATE OR REPLACE FUNCTION auth_is_supervisor() RETURNS BOOLEAN
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid() AND role IN ('admin','supervisor'));
$$;

-- ------------------------------------------------------------
-- 2. Restrict config / secret tables to admins
-- ------------------------------------------------------------
-- companies: stays publicly readable for slug resolution; writes admin-only.
DROP POLICY IF EXISTS companies_manage ON companies;
CREATE POLICY companies_manage ON companies FOR ALL
  USING (id = auth_company_id() AND auth_is_admin())
  WITH CHECK (id = auth_company_id() AND auth_is_admin());

DROP POLICY IF EXISTS company_smtp_staff ON company_smtp;
CREATE POLICY company_smtp_admin ON company_smtp FOR ALL
  USING (company_id = auth_company_id() AND auth_is_admin())
  WITH CHECK (company_id = auth_company_id() AND auth_is_admin());

DROP POLICY IF EXISTS company_efactura_config_staff ON company_efactura_config;
CREATE POLICY company_efactura_config_admin ON company_efactura_config FOR ALL
  USING (company_id = auth_company_id() AND auth_is_admin())
  WITH CHECK (company_id = auth_company_id() AND auth_is_admin());

DROP POLICY IF EXISTS notification_settings_staff ON notification_settings;
CREATE POLICY notification_settings_admin ON notification_settings FOR ALL
  USING (company_id = auth_company_id() AND auth_is_admin())
  WITH CHECK (company_id = auth_company_id() AND auth_is_admin());

-- loyalty_settings is configuration (rates, thresholds) → admin-only writes.
DROP POLICY IF EXISTS loyalty_settings_staff ON loyalty_settings;
CREATE POLICY loyalty_settings_admin ON loyalty_settings FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_admin())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_admin());

-- ------------------------------------------------------------
-- 3. Fix customer tenant-hop: pin store_id on self-update
-- ------------------------------------------------------------
-- A customer may edit their own profile but must NOT move their row to another
-- store/tenant. The subquery reads the existing (pre-update) store_id, so the
-- new value must equal it.
DROP POLICY IF EXISTS customers_self_update ON customers;
CREATE POLICY customers_self_update ON customers FOR UPDATE
  USING (id = auth_customer_id())
  WITH CHECK (
    id = auth_customer_id()
    AND store_id = (SELECT store_id FROM customers WHERE id = auth_customer_id())
  );

COMMIT;

-- ------------------------------------------------------------
-- Verify (run after COMMIT)
-- ------------------------------------------------------------
-- SELECT proname FROM pg_proc WHERE proname IN ('auth_role','auth_is_admin','auth_is_supervisor');
-- SELECT policyname, tablename FROM pg_policies
--   WHERE tablename IN ('companies','company_smtp','company_efactura_config',
--                       'notification_settings','loyalty_settings','customers')
--   ORDER BY tablename, policyname;
