-- ============================================================
-- Consolidated factura electrónica for a B2B invoice  — Slice 2b
-- ============================================================
-- A B2B consolidated invoice is sent to the PAC as ONE factura whose line items
-- are its orders. The resulting electronic_invoices row links to the b2b_invoice
-- (b2b_invoice_id) instead of a single order (order_id stays NULL). One active
-- factura per B2B invoice. Idempotent + transactional.
-- ============================================================

BEGIN;

ALTER TABLE electronic_invoices
  ADD COLUMN IF NOT EXISTS b2b_invoice_id UUID REFERENCES b2b_invoices(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS electronic_invoices_b2b_idx
  ON electronic_invoices (b2b_invoice_id);

-- At most one active (non-failed) factura per B2B invoice.
CREATE UNIQUE INDEX IF NOT EXISTS electronic_invoices_one_active_b2b
  ON electronic_invoices (b2b_invoice_id)
  WHERE doc_type = '01' AND b2b_invoice_id IS NOT NULL
    AND status IN ('pending', 'emitting', 'authorized');

COMMIT;

-- Verify:
-- SELECT column_name FROM information_schema.columns WHERE table_name='electronic_invoices' AND column_name='b2b_invoice_id';
