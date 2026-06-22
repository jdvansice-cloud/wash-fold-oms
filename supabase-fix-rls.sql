-- ============================================================
-- ⚠️  SUPERSEDED MIGRATION — DO NOT APPLY  ⚠️
-- This file disables RLS or uses USING(true) / GRANT ALL TO anon and would
-- RE-OPEN cross-tenant access. Kept for history only. The single source of
-- truth for RLS is supabase-fix-rls-tenant-isolation.sql.
-- The guard below aborts the script if it is pasted into the SQL editor.
-- ============================================================
DO $$ BEGIN
  RAISE EXCEPTION 'SUPERSEDED RLS migration — do not apply. Use supabase-fix-rls-tenant-isolation.sql.';
END $$;

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

-- Disable RLS on ALL tables (add new tables as needed)
ALTER TABLE IF EXISTS stores DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS companies DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS sections DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS products DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS customers DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS order_items DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS payments DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS payment_methods DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS users DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS invoices DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS promotions DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS gift_cards DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS gift_card_transactions DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS machines DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS refunds DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS stock_movements DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS eod_closings DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS notification_settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS loyalty_settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS customer_loyalty DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS loyalty_transactions DISABLE ROW LEVEL SECURITY;

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
