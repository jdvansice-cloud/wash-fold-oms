-- ============================================================
-- Pre-go-live security hardening (P0 authorization holes)
-- ============================================================
-- 1) `receipts` storage bucket was world-readable/writable via the anon key
--    (policies scoped only by bucket_id) → cross-tenant fiscal-document leak
--    and tamper. Restrict to staff of the OWNING store. Receipts are pathed
--    `${store_id}/date/file`, so gate on the first path segment.
-- 2) `users_write` was gated on auth_is_staff() (true for ANY user row), so an
--    operator could UPDATE their own role='admin'. Gate on auth_is_admin().
-- 3) `customer_auth` client INSERT/UPDATE let a portal user bind their login to
--    another customer's id. Drop them; signup goes through register_customer
--    (SECURITY DEFINER). Reads stay via customer_auth_self.
-- Idempotent. Compares the store-folder as TEXT to avoid a uuid-cast error on a
-- degenerate 'default' path.
-- ============================================================

-- 1) receipts bucket ------------------------------------------------------
DROP POLICY IF EXISTS "Anyone can read receipts"   ON storage.objects;
DROP POLICY IF EXISTS "Anyone can update receipts" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can upload receipts" ON storage.objects;
DROP POLICY IF EXISTS receipts_select_policy ON storage.objects;
DROP POLICY IF EXISTS receipts_insert_policy ON storage.objects;
DROP POLICY IF EXISTS receipts_update_policy ON storage.objects;
DROP POLICY IF EXISTS receipts_delete_policy ON storage.objects;

DROP POLICY IF EXISTS receipts_staff_select ON storage.objects;
DROP POLICY IF EXISTS receipts_staff_insert ON storage.objects;
DROP POLICY IF EXISTS receipts_staff_update ON storage.objects;
DROP POLICY IF EXISTS receipts_staff_delete ON storage.objects;

CREATE POLICY receipts_staff_select ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'receipts' AND auth_is_staff()
         AND (storage.foldername(name))[1] IN (SELECT auth_store_ids()::text));
CREATE POLICY receipts_staff_insert ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'receipts' AND auth_is_staff()
         AND (storage.foldername(name))[1] IN (SELECT auth_store_ids()::text));
CREATE POLICY receipts_staff_update ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'receipts' AND auth_is_staff()
         AND (storage.foldername(name))[1] IN (SELECT auth_store_ids()::text))
  WITH CHECK (bucket_id = 'receipts' AND auth_is_staff()
         AND (storage.foldername(name))[1] IN (SELECT auth_store_ids()::text));
CREATE POLICY receipts_staff_delete ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'receipts' AND auth_is_staff()
         AND (storage.foldername(name))[1] IN (SELECT auth_store_ids()::text));

-- 2) users: only admins may write; no self-promotion ----------------------
DROP POLICY IF EXISTS users_write ON users;
CREATE POLICY users_write ON users FOR ALL TO authenticated
  USING (company_id = auth_company_id() AND auth_is_admin())
  WITH CHECK (company_id = auth_company_id() AND auth_is_admin());

-- 3) customer_auth: force linkage through register_customer ----------------
DROP POLICY IF EXISTS customer_auth_insert ON customer_auth;
DROP POLICY IF EXISTS customer_auth_update ON customer_auth;

-- Verify:
-- SELECT policyname, cmd, roles::text FROM pg_policies WHERE schemaname='storage' AND policyname LIKE 'receipts%';
-- SELECT policyname, qual FROM pg_policies WHERE tablename IN ('users','customer_auth');
