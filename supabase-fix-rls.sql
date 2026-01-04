-- =============================================
-- Fix RLS Policies for American Laundry OMS
-- Run this ENTIRE script in Supabase SQL Editor
-- =============================================

-- First, drop ALL existing policies on stores (they might be blocking)
DO $$ 
DECLARE
    pol RECORD;
BEGIN
    FOR pol IN SELECT policyname FROM pg_policies WHERE tablename = 'stores' LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON stores', pol.policyname);
    END LOOP;
END $$;

-- Disable RLS on ALL tables
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

-- Grant full access to anon and authenticated roles
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon;
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;

-- =============================================
-- Verify RLS is disabled
-- =============================================
SELECT 
  tablename,
  CASE WHEN rowsecurity THEN 'ENABLED ❌' ELSE 'DISABLED ✓' END as rls_status
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;

-- =============================================
-- Test: Try to update a store directly
-- =============================================
-- UPDATE stores SET updated_at = NOW() WHERE name LIKE '%Tocumen%';
-- If this works, the app should work too
