-- ============================================================
-- Payments against a B2B consolidated invoice  — Slice 2 (payment)
-- ============================================================
-- A B2B invoice is paid through the regular payment screen (cash/card/ACH/Yappy).
-- Those tenders are recorded in `payments` linked to the invoice (b2b_invoice_id)
-- rather than to a single order — one invoice covers many orders.
--
-- RLS today only admits payments whose order_id is in the caller's stores; we
-- widen it to also admit payments whose b2b_invoice_id is in the caller's stores
-- (order_id is then NULL). Idempotent + transactional.
-- ============================================================

BEGIN;

ALTER TABLE payments
  ADD COLUMN IF NOT EXISTS b2b_invoice_id UUID REFERENCES b2b_invoices(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS payments_b2b_invoice_idx ON payments (b2b_invoice_id);

-- Read: a payment is visible if its order or its B2B invoice is visible
-- (both subqueries are themselves RLS-filtered).
DROP POLICY IF EXISTS payments_read ON payments;
CREATE POLICY payments_read ON payments FOR SELECT
  USING (
    (order_id IN (SELECT id FROM orders))
    OR (b2b_invoice_id IN (SELECT id FROM b2b_invoices))
  );

-- Staff write: order or invoice must belong to one of the caller's stores.
DROP POLICY IF EXISTS payments_staff ON payments;
CREATE POLICY payments_staff ON payments FOR ALL
  USING (
    auth_is_staff() AND (
      (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
      OR (b2b_invoice_id IN (SELECT id FROM b2b_invoices WHERE store_id IN (SELECT auth_store_ids())))
    )
  )
  WITH CHECK (
    auth_is_staff() AND (
      (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
      OR (b2b_invoice_id IN (SELECT id FROM b2b_invoices WHERE store_id IN (SELECT auth_store_ids())))
    )
  );

COMMIT;

-- Verify:
-- SELECT column_name FROM information_schema.columns WHERE table_name='payments' AND column_name='b2b_invoice_id';
-- SELECT policyname FROM pg_policies WHERE tablename='payments';
