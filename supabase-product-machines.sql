-- ============================================================
-- Link services to the machines they may use
-- ============================================================
-- A machine product (products.machine_type set) can be restricted to specific
-- machines. No rows for a product = "any machine of its type" (the default the
-- UI shows as all-checked). Idempotent + transactional.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS product_machines (
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  machine_id UUID NOT NULL REFERENCES machines(id) ON DELETE CASCADE,
  PRIMARY KEY (product_id, machine_id)
);
CREATE INDEX IF NOT EXISTS product_machines_machine_idx ON product_machines (machine_id);

ALTER TABLE product_machines ENABLE ROW LEVEL SECURITY;

-- Visible/editable when the linked product is in the caller's stores.
DROP POLICY IF EXISTS product_machines_read ON product_machines;
CREATE POLICY product_machines_read ON product_machines FOR SELECT
  USING (product_id IN (SELECT id FROM products));
DROP POLICY IF EXISTS product_machines_staff ON product_machines;
CREATE POLICY product_machines_staff ON product_machines FOR ALL
  USING (auth_is_staff() AND product_id IN (SELECT id FROM products WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (auth_is_staff() AND product_id IN (SELECT id FROM products WHERE store_id IN (SELECT auth_store_ids())));

COMMIT;

-- Verify:
-- SELECT product_id, count(*) FROM product_machines GROUP BY 1;
