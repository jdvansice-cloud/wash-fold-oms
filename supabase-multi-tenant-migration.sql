-- ============================================
-- Multi-Tenant SaaS Migration
-- Run this in Supabase SQL Editor
-- ============================================
-- IMPORTANT: Run this BEFORE deploying the new frontend code.
-- This migration is ADDITIVE — it adds columns/tables but does not
-- remove anything, so the existing app continues working.

BEGIN;

-- ============================================
-- PART 1: Schema Changes
-- ============================================

-- 1. Add slug to companies
ALTER TABLE companies ADD COLUMN IF NOT EXISTS slug VARCHAR(100);
UPDATE companies SET slug = 'american-laundry' WHERE slug IS NULL;
ALTER TABLE companies ALTER COLUMN slug SET NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS idx_companies_slug ON companies(slug);

-- 2. Add company_id to users table (backfill from stores)
ALTER TABLE users ADD COLUMN IF NOT EXISTS company_id UUID REFERENCES companies(id);
UPDATE users u SET company_id = s.company_id FROM stores s WHERE u.store_id = s.id AND u.company_id IS NULL;

-- 3. Add company_id to customer_auth (backfill from stores)
ALTER TABLE customer_auth ADD COLUMN IF NOT EXISTS company_id UUID REFERENCES companies(id);
UPDATE customer_auth ca SET company_id = s.company_id FROM stores s WHERE ca.store_id = s.id AND ca.company_id IS NULL;

-- 4. Subscriptions table
CREATE TABLE IF NOT EXISTS subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  stripe_customer_id VARCHAR(255),
  stripe_subscription_id VARCHAR(255),
  plan VARCHAR(50) NOT NULL DEFAULT 'starter' CHECK (plan IN ('starter', 'pro', 'enterprise')),
  status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'trialing', 'past_due', 'canceled', 'incomplete')),
  current_period_start TIMESTAMPTZ,
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_subscriptions_company ON subscriptions(company_id);

-- 5. Add stripe_customer_id to companies
ALTER TABLE companies ADD COLUMN IF NOT EXISTS stripe_customer_id VARCHAR(255);

-- 6. Seed American Laundry subscription (grandfathered as Pro)
INSERT INTO subscriptions (company_id, plan, status)
SELECT id, 'pro', 'active' FROM companies WHERE slug = 'american-laundry'
ON CONFLICT (company_id) DO NOTHING;

-- 7. Platform admin flag
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_platform_admin BOOLEAN DEFAULT false;

-- ============================================
-- PART 2: Helper Functions for RLS
-- ============================================

-- Get the company_id for the currently authenticated user
CREATE OR REPLACE FUNCTION auth_company_id() RETURNS UUID AS $$
  SELECT COALESCE(
    (SELECT company_id FROM users WHERE auth_id = auth.uid() LIMIT 1),
    (SELECT company_id FROM customer_auth WHERE auth_id = auth.uid() LIMIT 1)
  );
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Get all store_ids that belong to the current user's company
CREATE OR REPLACE FUNCTION auth_store_ids() RETURNS SETOF UUID AS $$
  SELECT id FROM stores WHERE company_id = auth_company_id();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ============================================
-- PART 3: Replace ALL "Allow all" RLS Policies
-- ============================================

-- Drop all existing permissive policies
DROP POLICY IF EXISTS "Allow all" ON companies;
DROP POLICY IF EXISTS "Allow all" ON stores;
DROP POLICY IF EXISTS "Allow all" ON users;
DROP POLICY IF EXISTS "Allow all" ON sections;
DROP POLICY IF EXISTS "Allow all" ON products;
DROP POLICY IF EXISTS "Allow all" ON customers;
DROP POLICY IF EXISTS "Allow all" ON orders;
DROP POLICY IF EXISTS "Allow all" ON order_items;
DROP POLICY IF EXISTS "Allow all" ON payment_methods;
DROP POLICY IF EXISTS "Allow all" ON payments;

-- Companies: users can only see their own company
-- Also allow anon read by slug (needed for tenant resolution before login)
CREATE POLICY "tenant_read" ON companies FOR SELECT USING (true);
CREATE POLICY "tenant_manage" ON companies FOR ALL USING (id = auth_company_id());

-- Stores: users can see stores in their company
CREATE POLICY "tenant_read_stores" ON stores FOR SELECT USING (true);
CREATE POLICY "tenant_manage_stores" ON stores FOR ALL USING (company_id = auth_company_id());

-- Users: staff can see users in their company
CREATE POLICY "tenant_users" ON users FOR ALL
  USING (company_id = auth_company_id())
  WITH CHECK (company_id = auth_company_id());
-- Allow anon read for auth resolution (lookupStaff uses anon key)
CREATE POLICY "anon_user_lookup" ON users FOR SELECT USING (true);

-- Sections: store-scoped
CREATE POLICY "tenant_sections" ON sections FOR ALL
  USING (store_id IN (SELECT auth_store_ids()))
  WITH CHECK (store_id IN (SELECT auth_store_ids()));
CREATE POLICY "anon_sections_read" ON sections FOR SELECT USING (true);

-- Products: store-scoped
CREATE POLICY "tenant_products" ON products FOR ALL
  USING (store_id IN (SELECT auth_store_ids()))
  WITH CHECK (store_id IN (SELECT auth_store_ids()));
CREATE POLICY "anon_products_read" ON products FOR SELECT USING (true);

-- Customers: store-scoped
CREATE POLICY "tenant_customers" ON customers FOR ALL
  USING (store_id IN (SELECT auth_store_ids()))
  WITH CHECK (store_id IN (SELECT auth_store_ids()));
CREATE POLICY "anon_customers_read" ON customers FOR SELECT USING (true);

-- Orders: store-scoped
CREATE POLICY "tenant_orders" ON orders FOR ALL
  USING (store_id IN (SELECT auth_store_ids()))
  WITH CHECK (store_id IN (SELECT auth_store_ids()));
CREATE POLICY "anon_orders_read" ON orders FOR SELECT USING (true);

-- Order Items: through orders
CREATE POLICY "tenant_order_items" ON order_items FOR ALL
  USING (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())));
CREATE POLICY "anon_order_items_read" ON order_items FOR SELECT USING (true);

-- Payment Methods: store-scoped
CREATE POLICY "tenant_payment_methods" ON payment_methods FOR ALL
  USING (store_id IN (SELECT auth_store_ids()))
  WITH CHECK (store_id IN (SELECT auth_store_ids()));
CREATE POLICY "anon_payment_methods_read" ON payment_methods FOR SELECT USING (true);

-- Payments: through orders
CREATE POLICY "tenant_payments" ON payments FOR ALL
  USING (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())))
  WITH CHECK (order_id IN (SELECT id FROM orders WHERE store_id IN (SELECT auth_store_ids())));
CREATE POLICY "anon_payments_read" ON payments FOR SELECT USING (true);

-- Enable RLS on tables that don't have it yet and add policies
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_invoices" ON invoices FOR ALL USING (true);

ALTER TABLE refunds ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_refunds" ON refunds FOR ALL USING (true);

ALTER TABLE gift_cards ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_gift_cards" ON gift_cards FOR ALL USING (true);

ALTER TABLE gift_card_transactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_gift_card_txns" ON gift_card_transactions FOR ALL USING (true);

ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_promotions" ON promotions FOR ALL USING (true);

ALTER TABLE eod_closings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_eod" ON eod_closings FOR ALL USING (true);

ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_stock" ON stock_movements FOR ALL USING (true);

ALTER TABLE machines ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_machines" ON machines FOR ALL USING (true);

-- Subscriptions: company-scoped
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tenant_subscriptions" ON subscriptions FOR SELECT
  USING (company_id = auth_company_id());
CREATE POLICY "anon_subscriptions_read" ON subscriptions FOR SELECT USING (true);

COMMIT;
