-- ============================================================
-- B2B credit ("Factura" term)  — Slice 1: credit at checkout
-- ============================================================
-- The "Factura" payment term is for B2B customers only (customers.can_be_invoiced).
-- It credits the order to the customer's account: the order is delivered now but
-- created UNPAID and billed later as a GROUP (consolidated invoice + statement).
--
-- We distinguish WHY an order is unpaid via orders.billing_type:
--   immediate  — paid at checkout (default; all existing orders)
--   pickup     — pay-on-pickup; UNPAID, delivery is gated until paid
--   account    — B2B credit; UNPAID, delivered on account, billed later (NOT gated)
--
-- The "Factura" method is typed payment_type='credit' so the POS shows it only
-- for B2B customers. Idempotent + transactional.
-- ============================================================

BEGIN;

-- 1) Order billing type.
ALTER TABLE orders
  ADD COLUMN IF NOT EXISTS billing_type VARCHAR(20) NOT NULL DEFAULT 'immediate';
ALTER TABLE orders DROP CONSTRAINT IF EXISTS orders_billing_type_check;
ALTER TABLE orders ADD CONSTRAINT orders_billing_type_check
  CHECK (billing_type IN ('immediate', 'pickup', 'account'));

-- Backfill: the only prior path to an unpaid order was pay-on-pickup.
UPDATE orders SET billing_type = 'pickup'
 WHERE payment_status = 'unpaid' AND billing_type = 'immediate';

-- Outstanding B2B credit orders, for the consolidated-billing view (Slice 2).
CREATE INDEX IF NOT EXISTS orders_account_outstanding_idx
  ON orders (customer_id)
  WHERE billing_type = 'account' AND payment_status = 'unpaid';

-- 2) "Factura" becomes a B2B credit payment type.
ALTER TABLE payment_methods DROP CONSTRAINT IF EXISTS payment_methods_payment_type_check;
ALTER TABLE payment_methods ADD CONSTRAINT payment_methods_payment_type_check
  CHECK (payment_type IN ('cash', 'card', 'other', 'pickup', 'credit'));

UPDATE payment_methods SET payment_type = 'credit'
 WHERE payment_type IS DISTINCT FROM 'credit'
   AND (name ILIKE 'Factura' OR name ILIKE 'Facturar' OR name ILIKE '%crédito%' OR name ILIKE '%credito%');

COMMIT;

-- Verify:
-- SELECT billing_type, payment_status, count(*) FROM orders GROUP BY 1,2 ORDER BY 1,2;
-- SELECT name, payment_type FROM payment_methods WHERE payment_type='credit';
