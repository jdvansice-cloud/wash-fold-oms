-- ============================================================
-- B2B consolidated invoices  — Slice 2: bill a group of credit orders
-- ============================================================
-- A B2B customer's credit orders (billing_type='account') are billed together
-- on ONE invoice whose LINE ITEMS are the orders themselves (order number +
-- amount). Generating the invoice links those orders to it; the consolidated
-- invoice — not each order — is what gets sent for the electronic invoice and
-- paid. No separate line-items table: the linked orders ARE the lines.
--
-- Lifecycle: 'open' (issued, sent for payment) -> 'paid'.
-- Idempotent + transactional.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS b2b_invoices (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  invoice_number BIGSERIAL,
  store_id      UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  customer_id   UUID NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
  status        VARCHAR(20) NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'paid', 'void')),
  subtotal      NUMERIC(10,2) NOT NULL DEFAULT 0,
  tax_amount    NUMERIC(10,2) NOT NULL DEFAULT 0,
  total         NUMERIC(10,2) NOT NULL DEFAULT 0,
  notes         TEXT,
  created_by    UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  paid_at       TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS b2b_invoices_customer_idx ON b2b_invoices (customer_id, status);
CREATE INDEX IF NOT EXISTS b2b_invoices_store_idx ON b2b_invoices (store_id, created_at DESC);

-- Each order belongs to at most one consolidated invoice (its "line item").
ALTER TABLE orders
  ADD COLUMN IF NOT EXISTS b2b_invoice_id UUID REFERENCES b2b_invoices(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS orders_b2b_invoice_idx ON orders (b2b_invoice_id);

ALTER TABLE b2b_invoices ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS b2b_invoices_read ON b2b_invoices;
CREATE POLICY b2b_invoices_read ON b2b_invoices FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));

DROP POLICY IF EXISTS b2b_invoices_staff ON b2b_invoices;
CREATE POLICY b2b_invoices_staff ON b2b_invoices FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

COMMIT;

-- Verify:
-- SELECT count(*) FROM b2b_invoices;
-- SELECT column_name FROM information_schema.columns WHERE table_name='orders' AND column_name='b2b_invoice_id';
