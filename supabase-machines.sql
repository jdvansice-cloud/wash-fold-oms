-- ============================================================
-- Machine inventory + usage/maintenance tracking
-- ============================================================
-- Washers/dryers are tracked by CYCLES. Selling a "laundromat" wash/dry assigns
-- a machine and adds cycles; maintenance is due after `maintenance_interval`
-- cycles since the last service. The empty `machines` table from the base schema
-- is extended here. Idempotent + transactional.
-- ============================================================

BEGIN;

ALTER TABLE machines
  ADD COLUMN IF NOT EXISTS cycle_count INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS maintenance_interval INTEGER,         -- cycles between service; NULL = no schedule
  ADD COLUMN IF NOT EXISTS last_service_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS last_service_cycle INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS notes TEXT,
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT now();

CREATE INDEX IF NOT EXISTS machines_store_idx ON machines (store_id);

ALTER TABLE machines ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS machines_read ON machines;
CREATE POLICY machines_read ON machines FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
DROP POLICY IF EXISTS machines_staff ON machines;
CREATE POLICY machines_staff ON machines FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- One row per assigned use (usually an order line); cycles = quantity sold.
CREATE TABLE IF NOT EXISTS machine_usage (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  machine_id  UUID NOT NULL REFERENCES machines(id) ON DELETE CASCADE,
  store_id    UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  order_id    UUID REFERENCES orders(id) ON DELETE SET NULL,
  cycles      INTEGER NOT NULL DEFAULT 1,
  used_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_by  UUID REFERENCES users(id) ON DELETE SET NULL
);
CREATE INDEX IF NOT EXISTS machine_usage_machine_idx ON machine_usage (machine_id, used_at DESC);
ALTER TABLE machine_usage ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS machine_usage_read ON machine_usage;
CREATE POLICY machine_usage_read ON machine_usage FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
DROP POLICY IF EXISTS machine_usage_staff ON machine_usage;
CREATE POLICY machine_usage_staff ON machine_usage FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- Service log.
CREATE TABLE IF NOT EXISTS machine_maintenance (
  id             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  machine_id     UUID NOT NULL REFERENCES machines(id) ON DELETE CASCADE,
  store_id       UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  serviced_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  cycle_count_at INTEGER NOT NULL DEFAULT 0,
  notes          TEXT,
  performed_by   UUID REFERENCES users(id) ON DELETE SET NULL
);
CREATE INDEX IF NOT EXISTS machine_maintenance_machine_idx ON machine_maintenance (machine_id, serviced_at DESC);
ALTER TABLE machine_maintenance ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS machine_maintenance_read ON machine_maintenance;
CREATE POLICY machine_maintenance_read ON machine_maintenance FOR SELECT
  USING (store_id IN (SELECT auth_store_ids()));
DROP POLICY IF EXISTS machine_maintenance_staff ON machine_maintenance;
CREATE POLICY machine_maintenance_staff ON machine_maintenance FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- A product that consumes a machine cycle when sold (assign a machine at POS).
ALTER TABLE products ADD COLUMN IF NOT EXISTS machine_type VARCHAR(20);

-- Atomically record a use: insert usage + bump the machine's cycle counter.
CREATE OR REPLACE FUNCTION record_machine_usage(p_machine_id uuid, p_order_id uuid, p_cycles int, p_user uuid DEFAULT NULL)
  RETURNS void
  LANGUAGE plpgsql SECURITY INVOKER SET search_path = public AS $$
DECLARE v_store uuid;
BEGIN
  SELECT store_id INTO v_store FROM machines WHERE id = p_machine_id;
  IF v_store IS NULL THEN RETURN; END IF;
  INSERT INTO machine_usage (machine_id, store_id, order_id, cycles, created_by)
    VALUES (p_machine_id, v_store, p_order_id, GREATEST(p_cycles, 1), p_user);
  UPDATE machines
     SET cycle_count = cycle_count + GREATEST(p_cycles, 1), updated_at = now()
   WHERE id = p_machine_id;
END;
$$;

-- Log a service: record it + reset the "since service" baseline.
CREATE OR REPLACE FUNCTION log_machine_maintenance(p_machine_id uuid, p_notes text DEFAULT NULL, p_user uuid DEFAULT NULL)
  RETURNS void
  LANGUAGE plpgsql SECURITY INVOKER SET search_path = public AS $$
DECLARE v_store uuid; v_cycles int;
BEGIN
  SELECT store_id, cycle_count INTO v_store, v_cycles FROM machines WHERE id = p_machine_id;
  IF v_store IS NULL THEN RETURN; END IF;
  INSERT INTO machine_maintenance (machine_id, store_id, cycle_count_at, notes, performed_by)
    VALUES (p_machine_id, v_store, v_cycles, p_notes, p_user);
  UPDATE machines
     SET last_service_at = now(), last_service_cycle = v_cycles, updated_at = now()
   WHERE id = p_machine_id;
END;
$$;

COMMIT;

-- Verify:
-- SELECT name, machine_type, cycle_count, maintenance_interval, last_service_cycle FROM machines;
