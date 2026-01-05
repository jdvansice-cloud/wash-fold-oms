-- =============================================
-- CleanCloud Orders Import - Verification
-- Run this AFTER all parts are imported
-- =============================================

-- Summary of imported orders
SELECT 
  'Total Orders' as metric,
  COUNT(*)::text as value
FROM orders
UNION ALL
SELECT 
  'CleanCloud Orders (CC prefix)',
  COUNT(*)::text
FROM orders WHERE legacy_order_number LIKE 'CC%'
UNION ALL
SELECT 
  'Total Revenue',
  'B/' || ROUND(SUM(total)::numeric, 2)::text
FROM orders WHERE legacy_order_number LIKE 'CC%'
UNION ALL
SELECT 
  'Orders with Customer Link',
  COUNT(*)::text
FROM orders WHERE legacy_order_number LIKE 'CC%' AND customer_id IS NOT NULL
UNION ALL
SELECT 
  'Walk-in Orders',
  COUNT(*)::text
FROM orders WHERE legacy_order_number LIKE 'CC%' AND customer_id IS NULL;

-- Orders by month
SELECT 
  TO_CHAR(created_at, 'YYYY-MM') as month,
  COUNT(*) as orders,
  ROUND(SUM(total)::numeric, 2) as revenue
FROM orders
WHERE legacy_order_number LIKE 'CC%'
GROUP BY TO_CHAR(created_at, 'YYYY-MM')
ORDER BY month;

-- Top 10 customers by historical orders
SELECT 
  COALESCE(c.first_name || ' ' || COALESCE(c.last_name, ''), o.customer_name) as customer,
  COUNT(o.id) as orders,
  ROUND(SUM(o.total)::numeric, 2) as total_spent
FROM orders o
LEFT JOIN customers c ON c.id = o.customer_id
WHERE o.legacy_order_number LIKE 'CC%'
GROUP BY c.id, c.first_name, c.last_name, o.customer_name
ORDER BY orders DESC
LIMIT 10;

-- Payment methods breakdown
SELECT 
  p.payment_method,
  COUNT(*) as transactions,
  ROUND(SUM(p.amount)::numeric, 2) as total
FROM payments p
JOIN orders o ON o.id = p.order_id
WHERE o.legacy_order_number LIKE 'CC%'
GROUP BY p.payment_method
ORDER BY total DESC;
