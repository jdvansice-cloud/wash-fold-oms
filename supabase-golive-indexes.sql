-- Go-live DB guards + supporting indexes (applied to live DB). Idempotent.

-- Prevent a day being closed twice (two terminals / stale tab). EOD dedupe was
-- relying on the last-30 loaded rows only.
CREATE UNIQUE INDEX IF NOT EXISTS eod_closings_store_date_uniq
  ON eod_closings(store_id, closing_date);

-- Supports the EOD cash breakdown now querying payments by payment date.
CREATE INDEX IF NOT EXISTS payments_created_at_idx ON payments(created_at);

-- Numeric order-number lookup (POS "find order by number") was seq-scanning.
CREATE INDEX IF NOT EXISTS orders_store_ordernum_idx ON orders(store_id, order_number);
