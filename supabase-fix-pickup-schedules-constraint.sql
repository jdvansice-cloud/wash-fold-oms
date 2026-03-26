-- Fix: Add unique constraint on pickup_schedules for upsert to work
-- The Settings page uses upsert with onConflict: 'store_id,day_of_week'
-- but no unique constraint exists, so inserts silently fail

-- Add unique constraint
ALTER TABLE pickup_schedules
  ADD CONSTRAINT pickup_schedules_store_day_unique UNIQUE (store_id, day_of_week);

-- Verify
SELECT conname FROM pg_constraint WHERE conrelid = 'pickup_schedules'::regclass;
