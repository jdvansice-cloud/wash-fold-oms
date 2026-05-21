-- ============================================================
-- RLS Tenant Isolation — corrective migration
-- ============================================================
-- WHY: Previous policies were all `USING (true) WITH CHECK (true)` and
-- several core tables (customers, customer_auth, orders, companies...)
-- had `FOR SELECT USING (true)`. Because the anon key is shipped in the
-- public JS bundle, ANY visitor could read and write EVERY tenant's data,
-- including customer PII and SMTP passwords. This migration replaces those
-- policies with real company/customer scoping.
--
-- IMPORTANT — this migration MUST be deployed together with the matching
-- frontend changes (data loader + auth.ts now send the logged-in user's
-- JWT instead of the anon key). Applying this without that frontend code
-- will break data loading, because RLS will see every request as `anon`.
--
-- TEST THIS ON A STAGING / BACKUP PROJECT FIRST. It is wrapped in a single
-- transaction, so any error rolls the whole thing back. Verification
-- queries are at the bottom (run them after COMMIT).
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- 1. Move SMTP secrets out of the (publicly readable) companies row
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS company_smtp (
  company_id      UUID PRIMARY KEY REFERENCES companies(id) ON DELETE CASCADE,
  smtp_host       TEXT,
  smtp_port       INTEGER DEFAULT 587,
  smtp_user       TEXT,
  smtp_pass       TEXT,
  smtp_secure     BOOLEAN DEFAULT true,
  smtp_from_name  TEXT,
  smtp_from_email TEXT,
  updated_at      TIMESTAMPTZ DEFAULT now()
);

-- Copy any existing SMTP config off companies (only if those columns exist)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'companies'
      AND column_name = 'smtp_host'
  ) THEN
    INSERT INTO company_smtp (
      company_id, smtp_host, smtp_port, smtp_user, smtp_pass,
      smtp_secure, smtp_from_name, smtp_from_email
    )
    SELECT id, smtp_host, smtp_port, smtp_user, smtp_pass,
           smtp_secure, smtp_from_name, smtp_from_email
    FROM companies
    WHERE smtp_host IS NOT NULL
    ON CONFLICT (company_id) DO NOTHING;
  END IF;
END $$;

-- Drop the SMTP columns from companies (companies stays publicly readable
-- for slug -> tenant resolution, so secrets must not live there).
ALTER TABLE companies
  DROP COLUMN IF EXISTS smtp_host,
  DROP COLUMN IF EXISTS smtp_port,
  DROP COLUMN IF EXISTS smtp_user,
  DROP COLUMN IF EXISTS smtp_pass,
  DROP COLUMN IF EXISTS smtp_secure,
  DROP COLUMN IF EXISTS smtp_from_name,
  DROP COLUMN IF EXISTS smtp_from_email;

-- ------------------------------------------------------------
-- 2. Helper functions (SECURITY DEFINER -> bypass RLS, no recursion)
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION auth_company_id() RETURNS UUID
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT COALESCE(
    (SELECT company_id FROM users         WHERE auth_id = auth.uid() LIMIT 1),
    (SELECT company_id FROM customer_auth WHERE auth_id = auth.uid() LIMIT 1)
  );
$$;

CREATE OR REPLACE FUNCTION auth_store_ids() RETURNS SETOF UUID
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT id FROM stores WHERE company_id = auth_company_id();
$$;

CREATE OR REPLACE FUNCTION auth_customer_id() RETURNS UUID
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid() LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION auth_is_staff() RETURNS BOOLEAN
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid());
$$;

-- ------------------------------------------------------------
-- 3. RPCs for the auth bootstrapping flows
-- ------------------------------------------------------------
-- Links an existing, unlinked staff `users` row to the current auth session
-- by matching the verified email on the JWT. Used for legacy staff whose
-- auth_id was never set.
CREATE OR REPLACE FUNCTION link_staff_account() RETURNS SETOF users
  LANGUAGE sql SECURITY DEFINER SET search_path = public AS $$
  UPDATE users
  SET auth_id = auth.uid()
  WHERE auth_id IS NULL
    AND lower(email) = lower(auth.jwt() ->> 'email')
  RETURNING *;
$$;

-- Customer self-registration: resolves the tenant by slug, finds or creates
-- the customer record, and links it to the current auth session. Runs as
-- definer so a brand-new customer (no customer_auth row yet) can bootstrap.
CREATE OR REPLACE FUNCTION register_customer(
  p_slug       TEXT,
  p_first_name TEXT,
  p_last_name  TEXT,
  p_email      TEXT,
  p_phone      TEXT
) RETURNS UUID
  LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_auth_id     UUID := auth.uid();
  v_company_id  UUID;
  v_store_id    UUID;
  v_customer_id UUID;
BEGIN
  IF v_auth_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  SELECT id INTO v_company_id FROM companies WHERE slug = p_slug;
  IF v_company_id IS NULL THEN
    RAISE EXCEPTION 'Company not found for slug %', p_slug;
  END IF;

  SELECT id INTO v_store_id
  FROM stores
  WHERE company_id = v_company_id AND is_active = true
  ORDER BY created_at
  LIMIT 1;
  IF v_store_id IS NULL THEN
    RAISE EXCEPTION 'No active store for company';
  END IF;

  -- Already linked? return existing customer.
  SELECT customer_id INTO v_customer_id
  FROM customer_auth WHERE auth_id = v_auth_id;
  IF v_customer_id IS NOT NULL THEN
    RETURN v_customer_id;
  END IF;

  -- Existing customer with this email in the store?
  SELECT id INTO v_customer_id
  FROM customers
  WHERE store_id = v_store_id AND lower(email) = lower(p_email)
  LIMIT 1;

  IF v_customer_id IS NULL THEN
    INSERT INTO customers (
      store_id, first_name, last_name, email, phone,
      phone_country, address_district, address_province, is_active
    ) VALUES (
      v_store_id, p_first_name, p_last_name, lower(p_email),
      regexp_replace(p_phone, '\D', '', 'g'),
      '+507', 'Panama', 'Panama', true
    )
    RETURNING id INTO v_customer_id;
  END IF;

  INSERT INTO customer_auth (auth_id, customer_id, store_id, company_id)
  VALUES (v_auth_id, v_customer_id, v_store_id, v_company_id);

  RETURN v_customer_id;
END;
$$;

GRANT EXECUTE ON FUNCTION link_staff_account() TO authenticated;
GRANT EXECUTE ON FUNCTION register_customer(TEXT, TEXT, TEXT, TEXT, TEXT) TO authenticated;

-- ------------------------------------------------------------
-- 4. Wipe ALL existing policies on the target tables
-- ------------------------------------------------------------
DO $$
DECLARE
  r RECORD;
  tbl TEXT;
  tables TEXT[] := ARRAY[
    'companies','company_smtp','stores','users','customer_auth',
    'sections','products','customers','orders','order_items',
    'payment_methods','payments','invoices','refunds','gift_cards',
    'gift_card_transactions','promotions','eod_closings','stock_movements',
    'machines','subscriptions','notification_settings','customer_loyalty',
    'loyalty_settings','loyalty_transactions','customer_locations',
    'pickup_routes','pickup_schedules','pickup_blocked_dates','pickup_requests'
  ];
BEGIN
  FOR r IN
    SELECT schemaname, tablename, policyname
    FROM pg_policies
    WHERE schemaname = 'public' AND tablename = ANY(tables)
  LOOP
    EXECUTE format('DROP POLICY IF EXISTS %I ON %I.%I',
                   r.policyname, r.schemaname, r.tablename);
  END LOOP;

  FOREACH tbl IN ARRAY tables LOOP
    EXECUTE format('ALTER TABLE %I ENABLE ROW LEVEL SECURITY', tbl);
  END LOOP;
END $$;

-- ------------------------------------------------------------
-- 5. New policies
-- ------------------------------------------------------------

-- companies: publicly readable (needed for slug -> tenant resolution before
-- login). No secrets remain on this table. Writes: staff of that company.
CREATE POLICY companies_read   ON companies FOR SELECT USING (true);
CREATE POLICY companies_manage ON companies FOR ALL
  USING (id = auth_company_id() AND auth_is_staff())
  WITH CHECK (id = auth_company_id() AND auth_is_staff());

-- company_smtp: staff of the company only. The serverless email function
-- uses the service-role key, which bypasses RLS.
CREATE POLICY company_smtp_staff ON company_smtp FOR ALL
  USING (company_id = auth_company_id() AND auth_is_staff())
  WITH CHECK (company_id = auth_company_id() AND auth_is_staff());

-- stores: readable by anyone in the company; writable by staff.
CREATE POLICY stores_read  ON stores FOR SELECT
  USING (company_id = auth_company_id());
CREATE POLICY stores_write ON stores FOR ALL
  USING (company_id = auth_company_id() AND auth_is_staff())
  WITH CHECK (company_id = auth_company_id() AND auth_is_staff());

-- users: a user can always read their own row; staff read their company.
CREATE POLICY users_read  ON users FOR SELECT
  USING (auth_id = auth.uid() OR company_id = auth_company_id());
CREATE POLICY users_write ON users FOR ALL
  USING (company_id = auth_company_id() AND auth_is_staff())
  WITH CHECK (company_id = auth_company_id() AND auth_is_staff());

-- customer_auth: a customer reads/links their own row; staff read company rows.
CREATE POLICY customer_auth_self ON customer_auth FOR SELECT
  USING (auth_id = auth.uid()
         OR (auth_is_staff() AND company_id = auth_company_id()));
CREATE POLICY customer_auth_insert ON customer_auth FOR INSERT
  WITH CHECK (auth_id = auth.uid());
CREATE POLICY customer_auth_update ON customer_auth FOR UPDATE
  USING (auth_id = auth.uid()) WITH CHECK (auth_id = auth.uid());
CREATE POLICY customer_auth_staff ON customer_auth FOR ALL
  USING (auth_is_staff() AND company_id = auth_company_id())
  WITH CHECK (auth_is_staff() AND company_id = auth_company_id());

-- Catalog tables: readable by the company (staff + customers), staff write.
CREATE POLICY sections_read  ON sections FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
CREATE POLICY sections_write ON sections FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

CREATE POLICY products_read  ON products FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
CREATE POLICY products_write ON products FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

CREATE POLICY payment_methods_read  ON payment_methods FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
CREATE POLICY payment_methods_write ON payment_methods FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- customers: staff see their stores' customers; a customer sees only itself.
CREATE POLICY customers_read ON customers FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR id = auth_customer_id());
CREATE POLICY customers_staff ON customers FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY customers_self_update ON customers FOR UPDATE
  USING (id = auth_customer_id()) WITH CHECK (id = auth_customer_id());

-- orders: staff see their stores' orders; a customer sees only its own.
CREATE POLICY orders_read ON orders FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR customer_id = auth_customer_id());
CREATE POLICY orders_staff ON orders FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- order_items / payments: visibility cascades from the parent order's RLS.
CREATE POLICY order_items_read ON order_items FOR SELECT
  USING (order_id IN (SELECT id FROM orders));
CREATE POLICY order_items_staff ON order_items FOR ALL
  USING (auth_is_staff() AND order_id IN
         (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (auth_is_staff() AND order_id IN
         (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())));

CREATE POLICY payments_read ON payments FOR SELECT
  USING (order_id IN (SELECT id FROM orders));
CREATE POLICY payments_staff ON payments FOR ALL
  USING (auth_is_staff() AND order_id IN
         (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (auth_is_staff() AND order_id IN
         (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())));

-- invoices: staff see store invoices; a customer sees only its own.
CREATE POLICY invoices_read ON invoices FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR customer_id = auth_customer_id());
CREATE POLICY invoices_staff ON invoices FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- Staff-only, store-scoped tables.
CREATE POLICY refunds_staff ON refunds FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY gift_cards_staff ON gift_cards FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY promotions_staff ON promotions FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY eod_closings_staff ON eod_closings FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY stock_movements_staff ON stock_movements FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY machines_staff ON machines FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY loyalty_settings_staff ON loyalty_settings FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());
CREATE POLICY pickup_routes_staff ON pickup_routes FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- gift_card_transactions: staff only, scoped through the parent gift card.
CREATE POLICY gift_card_txn_staff ON gift_card_transactions FOR ALL
  USING (auth_is_staff() AND gift_card_id IN (SELECT id FROM gift_cards))
  WITH CHECK (auth_is_staff() AND gift_card_id IN (SELECT id FROM gift_cards));

-- subscriptions: publicly readable (FeatureGate checks the plan before login);
-- writes happen via the Stripe webhook using the service-role key.
CREATE POLICY subscriptions_read ON subscriptions FOR SELECT USING (true);

-- notification_settings: staff of the company only.
CREATE POLICY notification_settings_staff ON notification_settings FOR ALL
  USING (company_id = auth_company_id() AND auth_is_staff())
  WITH CHECK (company_id = auth_company_id() AND auth_is_staff());

-- Loyalty (customer-facing): staff see store rows; a customer sees its own.
CREATE POLICY customer_loyalty_read ON customer_loyalty FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR customer_id = auth_customer_id());
CREATE POLICY customer_loyalty_staff ON customer_loyalty FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

CREATE POLICY loyalty_txn_read ON loyalty_transactions FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR customer_id = auth_customer_id());
CREATE POLICY loyalty_txn_staff ON loyalty_transactions FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- customer_locations: a customer manages its own; staff see/manage their stores'.
CREATE POLICY customer_locations_self ON customer_locations FOR ALL
  USING (customer_id = auth_customer_id())
  WITH CHECK (customer_id = auth_customer_id());
CREATE POLICY customer_locations_staff ON customer_locations FOR ALL
  USING (auth_is_staff() AND customer_id IN
         (SELECT id FROM customers WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (auth_is_staff() AND customer_id IN
         (SELECT id FROM customers WHERE store_id IN (SELECT auth_store_ids())));

-- Pickup schedule config: readable by the company (customers need it to
-- book), writable by staff.
CREATE POLICY pickup_schedules_read  ON pickup_schedules FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
CREATE POLICY pickup_schedules_write ON pickup_schedules FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

CREATE POLICY pickup_blocked_read  ON pickup_blocked_dates FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
CREATE POLICY pickup_blocked_write ON pickup_blocked_dates FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- pickup_requests: a customer creates/sees/updates its own; staff manage
-- requests for their stores.
CREATE POLICY pickup_requests_read ON pickup_requests FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()) OR customer_id = auth_customer_id());
CREATE POLICY pickup_requests_customer_insert ON pickup_requests FOR INSERT
  WITH CHECK (customer_id = auth_customer_id());
CREATE POLICY pickup_requests_customer_update ON pickup_requests FOR UPDATE
  USING (customer_id = auth_customer_id())
  WITH CHECK (customer_id = auth_customer_id());
CREATE POLICY pickup_requests_staff ON pickup_requests FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

COMMIT;

-- ============================================================
-- VERIFICATION — run these AFTER the migration commits.
-- ============================================================
-- Every listed table should report rowsecurity = true:
--   SELECT tablename, rowsecurity FROM pg_tables
--   WHERE schemaname = 'public' ORDER BY tablename;
--
-- No policy should still be unconditionally permissive ("true"):
--   SELECT tablename, policyname, cmd, qual, with_check
--   FROM pg_policies WHERE schemaname = 'public'
--   ORDER BY tablename, policyname;
--
-- companies must no longer expose SMTP columns:
--   SELECT column_name FROM information_schema.columns
--   WHERE table_name = 'companies' AND column_name LIKE 'smtp%';  -- expect 0 rows
-- ============================================================
