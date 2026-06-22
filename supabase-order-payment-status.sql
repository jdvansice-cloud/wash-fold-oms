-- ============================================================
-- orders.payment_status  (pay-on-pickup = unpaid orders)
-- ============================================================
-- "Pagar al recoger" orders are created UNPAID: no money collected, no payment
-- rows, no electronic invoice. They're settled (paid + invoiced) when the
-- customer picks up, and staff cannot mark an order "completed" (handed over)
-- until it is paid.
--
-- Existing orders were all paid at checkout, so the column defaults to 'paid'.
-- Idempotent + transactional.
-- ============================================================

BEGIN;

ALTER TABLE orders
  ADD COLUMN IF NOT EXISTS payment_status VARCHAR(20) NOT NULL DEFAULT 'paid';

ALTER TABLE orders DROP CONSTRAINT IF EXISTS orders_payment_status_check;
ALTER TABLE orders ADD CONSTRAINT orders_payment_status_check
  CHECK (payment_status IN ('paid', 'unpaid'));

CREATE INDEX IF NOT EXISTS orders_payment_status_idx
  ON orders (store_id, payment_status) WHERE payment_status = 'unpaid';

COMMIT;

-- Verify:
-- SELECT payment_status, count(*) FROM orders GROUP BY payment_status;
