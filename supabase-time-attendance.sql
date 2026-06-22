-- ============================================================
-- Time & attendance  (Roadmap Phase D)
-- ============================================================
-- - users.weekly_hours: scheduled hours per weekday (no slots), e.g.
--     {"mon":8,"tue":8,"wed":8,"thu":8,"fri":8,"sat":4,"sun":0}
-- - time_entries: real-time clock in/out records (one open entry per staff).
-- - auth_staff_id(): the caller's users.id (for self-scoped RLS).
--
-- RLS: a staff user manages their OWN entries; supervisors/admins read all
-- entries for their stores (for EOD). Idempotent + transactional.
-- ============================================================

BEGIN;

-- Scheduled weekly hours on the staff profile.
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS weekly_hours JSONB NOT NULL DEFAULT '{}'::jsonb;

-- Caller's staff users.id (SECURITY DEFINER → no RLS recursion).
CREATE OR REPLACE FUNCTION auth_staff_id() RETURNS UUID
  LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public AS $$
  SELECT id FROM users WHERE auth_id = auth.uid() LIMIT 1;
$$;

-- Real-time attendance.
CREATE TABLE IF NOT EXISTS time_entries (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  store_id    UUID REFERENCES stores(id) ON DELETE SET NULL,
  clock_in    TIMESTAMPTZ NOT NULL DEFAULT now(),
  clock_out   TIMESTAMPTZ,
  notes       TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- At most one open (not-yet-clocked-out) entry per staff member.
CREATE UNIQUE INDEX IF NOT EXISTS time_entries_one_open
  ON time_entries (user_id) WHERE clock_out IS NULL;
CREATE INDEX IF NOT EXISTS time_entries_user_idx ON time_entries (user_id, clock_in DESC);
CREATE INDEX IF NOT EXISTS time_entries_store_day_idx ON time_entries (store_id, clock_in);

ALTER TABLE time_entries ENABLE ROW LEVEL SECURITY;

-- A staff user manages their own entries (clock in/out).
DROP POLICY IF EXISTS time_entries_self ON time_entries;
CREATE POLICY time_entries_self ON time_entries FOR ALL
  USING (user_id = auth_staff_id())
  WITH CHECK (user_id = auth_staff_id());

-- Supervisors/admins read all entries for their stores (EOD + payroll).
DROP POLICY IF EXISTS time_entries_manager_read ON time_entries;
CREATE POLICY time_entries_manager_read ON time_entries FOR SELECT
  USING (auth_is_supervisor() AND store_id IN (SELECT auth_store_ids()));

COMMIT;

-- Verify:
-- SELECT proname FROM pg_proc WHERE proname = 'auth_staff_id';
-- SELECT column_name FROM information_schema.columns
--   WHERE table_name='users' AND column_name='weekly_hours';
-- SELECT policyname FROM pg_policies WHERE tablename='time_entries';
