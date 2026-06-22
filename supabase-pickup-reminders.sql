-- ============================================================
-- Ready-for-pickup automation  (Roadmap Phase F #3)
-- ============================================================
-- Track when an order became ready and when we last reminded the customer, so
-- the UI can flag long-unclaimed orders and a daily job can send reminders.
-- Idempotent.
-- ============================================================

ALTER TABLE orders ADD COLUMN IF NOT EXISTS ready_at TIMESTAMPTZ;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS pickup_reminder_at TIMESTAMPTZ;

-- Backfill currently-ready orders (best estimate from updated_at/created_at).
UPDATE orders
   SET ready_at = COALESCE(ready_at, updated_at, created_at)
 WHERE status = 'ready' AND ready_at IS NULL;

-- Drives both the "awaiting pickup" view and the reminder job.
CREATE INDEX IF NOT EXISTS orders_ready_pickup_idx
  ON orders (store_id, ready_at)
  WHERE status = 'ready';

-- Verify:
-- SELECT order_number, ready_at, pickup_reminder_at FROM orders WHERE status='ready';
