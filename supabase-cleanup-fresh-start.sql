-- =============================================
-- American Laundry OMS - Fresh Start SQL Script
-- =============================================
-- This script cleans ALL data EXCEPT the users table
-- Run this to start fresh with real company data
-- =============================================

-- =============================================
-- STEP 1: Clear all transactional/operational data
-- =============================================

-- Payments and transactions
TRUNCATE TABLE payments CASCADE;
TRUNCATE TABLE order_items CASCADE;
TRUNCATE TABLE invoices CASCADE;
TRUNCATE TABLE refunds CASCADE;
TRUNCATE TABLE orders CASCADE;
TRUNCATE TABLE eod_closings CASCADE;

-- Gift cards and promotions
TRUNCATE TABLE gift_card_transactions CASCADE;
TRUNCATE TABLE gift_cards CASCADE;
TRUNCATE TABLE promotions CASCADE;

-- Inventory
TRUNCATE TABLE stock_movements CASCADE;

-- Products and organization
TRUNCATE TABLE products CASCADE;
TRUNCATE TABLE sections CASCADE;

-- Equipment
TRUNCATE TABLE machines CASCADE;

-- Customers
TRUNCATE TABLE customers CASCADE;

-- Payment methods
TRUNCATE TABLE payment_methods CASCADE;

-- =============================================
-- STEP 2: Clear company/store (preserve users)
-- =============================================

-- Remove store reference from users temporarily
UPDATE users SET store_id = NULL;

-- Clear stores and companies
TRUNCATE TABLE stores CASCADE;
TRUNCATE TABLE companies CASCADE;

-- =============================================
-- STEP 3: Create fresh American Laundry company
-- =============================================

INSERT INTO companies (
  id,
  name, 
  ruc, 
  dv, 
  address, 
  phone, 
  itbms_rate,
  default_completion_days,
  express_completion_days
) VALUES (
  uuid_generate_v4(),
  'American Laundry',
  '',  -- Enter RUC in Settings
  '',  -- Enter DV in Settings
  '',  -- Enter Address in Settings
  '',  -- Enter Phone in Settings
  7.00,
  1,
  0
);

-- Create main store
INSERT INTO stores (
  id,
  company_id,
  name,
  address,
  phone,
  is_active
) VALUES (
  uuid_generate_v4(),
  (SELECT id FROM companies LIMIT 1),
  'American Laundry - Principal',
  '',  -- Enter Address in Settings
  '',  -- Enter Phone in Settings
  true
);

-- =============================================
-- STEP 4: Re-link users to the new store
-- =============================================

UPDATE users 
SET store_id = (SELECT id FROM stores WHERE is_active = true LIMIT 1)
WHERE store_id IS NULL;

-- =============================================
-- STEP 5: Create default payment methods
-- =============================================

INSERT INTO payment_methods (store_id, name, icon, is_active, display_order)
SELECT 
  s.id,
  pm.name,
  pm.icon,
  true,
  pm.display_order
FROM stores s
CROSS JOIN (VALUES 
  ('Efectivo', '💵', 0),
  ('Tarjeta', '💳', 1),
  ('Yappy', '📱', 2),
  ('ACH', '🏦', 3),
  ('Facturar', '📄', 4),
  ('Pagar al Recoger', '🛒', 5)
) AS pm(name, icon, display_order)
WHERE s.is_active = true;

-- =============================================
-- STEP 6: Create default sections
-- =============================================

INSERT INTO sections (store_id, name, color, display_order, is_active, is_online)
SELECT 
  s.id,
  sec.name,
  sec.color,
  sec.display_order,
  true,
  true
FROM stores s
CROSS JOIN (VALUES 
  ('Lava y Dobla', '#0891b2', 0),
  ('Lavamático', '#8b5cf6', 1),
  ('Productos', '#f59e0b', 2),
  ('Entregas', '#10b981', 3)
) AS sec(name, color, display_order)
WHERE s.is_active = true;

-- =============================================
-- VERIFICATION: Check results
-- =============================================

SELECT 'CLEANUP COMPLETE' as status;

SELECT 
  'companies' as tabla, COUNT(*) as registros FROM companies
UNION ALL SELECT 
  'stores', COUNT(*) FROM stores
UNION ALL SELECT 
  'users', COUNT(*) FROM users
UNION ALL SELECT 
  'sections', COUNT(*) FROM sections
UNION ALL SELECT 
  'products', COUNT(*) FROM products
UNION ALL SELECT 
  'customers', COUNT(*) FROM customers
UNION ALL SELECT 
  'orders', COUNT(*) FROM orders
UNION ALL SELECT 
  'payment_methods', COUNT(*) FROM payment_methods;

-- =============================================
-- NEXT STEPS:
-- 1. Go to Settings > Empresa and fill in:
--    - Company name, RUC, DV
--    - Address, Phone
--    - Upload Logo
-- 2. Go to Settings > Tiendas and update store info
-- 3. Go to Settings > Productos and add your products
-- 4. Start taking orders!
-- =============================================

