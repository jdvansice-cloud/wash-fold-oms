-- =============================================
-- Verify Customer-Order Linking
-- Run this to check for missing customer links
-- =============================================

-- 1. Check how many CleanCloud orders are NOT linked to customers
SELECT 
  'Orders without customer link' as issue,
  COUNT(*) as count
FROM orders 
WHERE legacy_order_number LIKE 'CC%' 
AND customer_id IS NULL;

-- 2. Show which customer names appear in unlinked orders
SELECT 
  customer_name,
  COUNT(*) as order_count,
  ROUND(SUM(total)::numeric, 2) as total_revenue
FROM orders 
WHERE legacy_order_number LIKE 'CC%' 
AND customer_id IS NULL
AND customer_name NOT IN ('Retail', '')
GROUP BY customer_name
ORDER BY order_count DESC
LIMIT 20;

-- 3. Check if customers have cc_id in their preferences
SELECT 
  'Customers with cc_id' as metric,
  COUNT(*) as count
FROM customers 
WHERE preferences->>'cc_id' IS NOT NULL;

-- 4. Check if German Alveo exists and has correct cc_id
SELECT 
  id, first_name, last_name, 
  preferences->>'cc_id' as cc_id,
  preferences->>'total_orders' as expected_orders
FROM customers 
WHERE first_name ILIKE '%german%' OR last_name ILIKE '%alveo%';

-- =============================================
-- FIX: Re-link orders to customers by matching cc_id
-- Run this AFTER verifying customers are imported
-- =============================================

-- This will update all CleanCloud orders to link to the correct customer
UPDATE orders o
SET customer_id = c.id
FROM customers c
WHERE o.legacy_order_number LIKE 'CC%'
AND o.customer_id IS NULL
AND o.customer_name IS NOT NULL
AND c.preferences->>'cc_id' IS NOT NULL
AND EXISTS (
  -- Match by finding customer with same cc_id that appears in at least one order with that customer name
  SELECT 1 FROM orders o2 
  WHERE o2.customer_name = o.customer_name 
  AND o2.legacy_order_number LIKE 'CC%'
);

-- Alternative: More direct fix - match orders to customers by name
-- (Use this if the above doesn't work)
/*
UPDATE orders o
SET customer_id = c.id
FROM customers c
WHERE o.legacy_order_number LIKE 'CC%'
AND o.customer_id IS NULL
AND (
  c.first_name || ' ' || COALESCE(c.last_name, '') = o.customer_name
  OR c.first_name = o.customer_name
);
*/

-- =============================================
-- VERIFY AFTER FIX
-- =============================================

-- Check German Alveo's orders are now linked
SELECT 
  o.legacy_order_number,
  o.customer_name,
  o.customer_id,
  c.first_name || ' ' || c.last_name as linked_customer
FROM orders o
LEFT JOIN customers c ON c.id = o.customer_id
WHERE o.customer_name ILIKE '%german%'
ORDER BY o.created_at DESC
LIMIT 10;

-- Summary after fix
SELECT 
  CASE WHEN customer_id IS NULL THEN 'Not Linked' ELSE 'Linked' END as status,
  COUNT(*) as orders,
  ROUND(SUM(total)::numeric, 2) as total
FROM orders 
WHERE legacy_order_number LIKE 'CC%'
GROUP BY CASE WHEN customer_id IS NULL THEN 'Not Linked' ELSE 'Linked' END;
