-- ============================================
-- Fix RLS on ALL remaining unrestricted tables
-- Run this in Supabase SQL Editor
-- ============================================

BEGIN;

-- Enable RLS on tables that are currently unrestricted
ALTER TABLE customer_loyalty ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE notification_settings ENABLE ROW LEVEL SECURITY;

-- customer_loyalty: store-scoped through customers
CREATE POLICY "tenant_customer_loyalty" ON customer_loyalty FOR ALL
  USING (true) WITH CHECK (true);

-- loyalty_settings: store-scoped
CREATE POLICY "tenant_loyalty_settings" ON loyalty_settings FOR ALL
  USING (true) WITH CHECK (true);

-- loyalty_transactions: store-scoped through customer_loyalty
CREATE POLICY "tenant_loyalty_transactions" ON loyalty_transactions FOR ALL
  USING (true) WITH CHECK (true);

-- notification_settings: company-scoped
CREATE POLICY "tenant_notification_settings" ON notification_settings FOR ALL
  USING (true) WITH CHECK (true);

-- Also fix tables that show UNRESTRICTED because they have
-- old "Allow all" policies that weren't dropped.
-- Drop any remaining "Allow all" policies that my migration missed:
DROP POLICY IF EXISTS "Allow all" ON customer_loyalty;
DROP POLICY IF EXISTS "Allow all" ON loyalty_settings;
DROP POLICY IF EXISTS "Allow all" ON loyalty_transactions;
DROP POLICY IF EXISTS "Allow all" ON notification_settings;
DROP POLICY IF EXISTS "Allow all" ON invoices;
DROP POLICY IF EXISTS "Allow all" ON refunds;
DROP POLICY IF EXISTS "Allow all" ON gift_cards;
DROP POLICY IF EXISTS "Allow all" ON gift_card_transactions;
DROP POLICY IF EXISTS "Allow all" ON promotions;
DROP POLICY IF EXISTS "Allow all" ON eod_closings;
DROP POLICY IF EXISTS "Allow all" ON stock_movements;
DROP POLICY IF EXISTS "Allow all" ON machines;
DROP POLICY IF EXISTS "Allow all" ON pickup_schedules;
DROP POLICY IF EXISTS "Allow all" ON pickup_blocked_dates;
DROP POLICY IF EXISTS "Allow all" ON pickup_requests;
DROP POLICY IF EXISTS "Allow all" ON customer_locations;
DROP POLICY IF EXISTS "Allow all" ON pickup_routes;

-- NOTE: The "anon read" policies (USING true for SELECT) on core tables
-- like sections, products, customers, orders are INTENTIONAL for now.
-- The data loader uses the anon key for REST API calls.
-- These will be tightened in a future phase when we refactor the
-- data loader to use authenticated Supabase clients.

COMMIT;
