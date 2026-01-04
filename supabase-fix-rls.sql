-- =============================================
-- Fix RLS Policies for American Laundry OMS
-- Run this if you're having permission issues
-- =============================================

-- Option 1: Disable RLS entirely for development (easier)
ALTER TABLE stores DISABLE ROW LEVEL SECURITY;
ALTER TABLE companies DISABLE ROW LEVEL SECURITY;
ALTER TABLE sections DISABLE ROW LEVEL SECURITY;
ALTER TABLE products DISABLE ROW LEVEL SECURITY;
ALTER TABLE customers DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE order_items DISABLE ROW LEVEL SECURITY;
ALTER TABLE payments DISABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods DISABLE ROW LEVEL SECURITY;
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE invoices DISABLE ROW LEVEL SECURITY;
ALTER TABLE promotions DISABLE ROW LEVEL SECURITY;
ALTER TABLE gift_cards DISABLE ROW LEVEL SECURITY;
ALTER TABLE gift_card_transactions DISABLE ROW LEVEL SECURITY;
ALTER TABLE machines DISABLE ROW LEVEL SECURITY;
ALTER TABLE refunds DISABLE ROW LEVEL SECURITY;
ALTER TABLE stock_movements DISABLE ROW LEVEL SECURITY;
ALTER TABLE eod_closings DISABLE ROW LEVEL SECURITY;

-- =============================================
-- OR Option 2: Create permissive policies
-- =============================================

/*
-- Enable RLS
ALTER TABLE stores ENABLE ROW LEVEL SECURITY;

-- Drop existing policies
DROP POLICY IF EXISTS "Allow all for authenticated users" ON stores;

-- Create permissive policy for authenticated users
CREATE POLICY "Allow all for authenticated users" ON stores
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- For anonymous access (if needed during development)
CREATE POLICY "Allow all for anon" ON stores
  FOR ALL
  TO anon
  USING (true)
  WITH CHECK (true);
*/

-- =============================================
-- Verify current RLS status
-- =============================================
SELECT 
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;
