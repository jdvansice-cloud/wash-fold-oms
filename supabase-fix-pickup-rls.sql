-- Fix: Allow portal customers to read pickup schedules, blocked dates, and request counts
-- These tables need public SELECT for the customer portal scheduling flow

-- pickup_schedules: customers need to see available days/times
DROP POLICY IF EXISTS "anon_read_pickup_schedules" ON pickup_schedules;
CREATE POLICY "anon_read_pickup_schedules" ON pickup_schedules
  FOR SELECT USING (true);

-- pickup_blocked_dates: customers need to see blocked dates
DROP POLICY IF EXISTS "anon_read_pickup_blocked_dates" ON pickup_blocked_dates;
CREATE POLICY "anon_read_pickup_blocked_dates" ON pickup_blocked_dates
  FOR SELECT USING (true);

-- pickup_requests: customers need to count bookings per slot + see their own
DROP POLICY IF EXISTS "anon_read_pickup_requests" ON pickup_requests;
CREATE POLICY "anon_read_pickup_requests" ON pickup_requests
  FOR SELECT USING (true);

-- pickup_requests: customers need to INSERT their own requests
DROP POLICY IF EXISTS "anon_insert_pickup_requests" ON pickup_requests;
CREATE POLICY "anon_insert_pickup_requests" ON pickup_requests
  FOR INSERT WITH CHECK (true);

-- customer_locations: customers need to read/write their saved locations
DROP POLICY IF EXISTS "anon_read_customer_locations" ON customer_locations;
CREATE POLICY "anon_read_customer_locations" ON customer_locations
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "anon_insert_customer_locations" ON customer_locations;
CREATE POLICY "anon_insert_customer_locations" ON customer_locations
  FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_customer_locations" ON customer_locations;
CREATE POLICY "anon_update_customer_locations" ON customer_locations
  FOR UPDATE USING (true);

DROP POLICY IF EXISTS "anon_delete_customer_locations" ON customer_locations;
CREATE POLICY "anon_delete_customer_locations" ON customer_locations
  FOR DELETE USING (true);

-- Verify
SELECT tablename, policyname, cmd FROM pg_policies
WHERE tablename IN ('pickup_schedules', 'pickup_blocked_dates', 'pickup_requests', 'customer_locations')
ORDER BY tablename, policyname;
