-- =============================================
-- Find and Merge Duplicate Customers
-- Run this to clean up duplicate customer records
-- =============================================

-- STEP 1: Identify duplicates (by phone number)
SELECT 
  phone,
  COUNT(*) as count,
  STRING_AGG(id::text, ', ') as customer_ids,
  STRING_AGG(first_name || ' ' || COALESCE(last_name, ''), ', ') as names
FROM customers
WHERE phone IS NOT NULL AND phone != ''
GROUP BY phone
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- STEP 2: Identify duplicates (by email)
SELECT 
  email,
  COUNT(*) as count,
  STRING_AGG(id::text, ', ') as customer_ids,
  STRING_AGG(first_name || ' ' || COALESCE(last_name, ''), ', ') as names
FROM customers
WHERE email IS NOT NULL AND email != ''
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- STEP 3: Show duplicates with their order counts
-- This helps identify which record to keep (the one with orders linked)
WITH duplicate_phones AS (
  SELECT phone
  FROM customers
  WHERE phone IS NOT NULL AND phone != ''
  GROUP BY phone
  HAVING COUNT(*) > 1
)
SELECT 
  c.id,
  c.first_name,
  c.last_name,
  c.phone,
  c.email,
  c.preferences->>'cc_id' as cc_id,
  (SELECT COUNT(*) FROM orders WHERE customer_id = c.id) as order_count,
  c.created_at
FROM customers c
WHERE c.phone IN (SELECT phone FROM duplicate_phones)
ORDER BY c.phone, order_count DESC;

-- =============================================
-- STEP 4: MERGE DUPLICATES
-- This will:
-- 1. Move all orders from duplicate to the "keeper" (one with cc_id or more orders)
-- 2. Delete the duplicate record
-- =============================================

DO $$
DECLARE
  dup RECORD;
  keeper_id UUID;
  duplicate_id UUID;
  merged_count INT := 0;
BEGIN
  -- Find duplicates by phone
  FOR dup IN 
    SELECT phone
    FROM customers
    WHERE phone IS NOT NULL AND phone != ''
    GROUP BY phone
    HAVING COUNT(*) > 1
  LOOP
    -- Get the keeper (prefer one with cc_id, then most orders, then oldest)
    SELECT id INTO keeper_id
    FROM customers c
    WHERE c.phone = dup.phone
    ORDER BY 
      CASE WHEN c.preferences->>'cc_id' IS NOT NULL THEN 0 ELSE 1 END,
      (SELECT COUNT(*) FROM orders WHERE customer_id = c.id) DESC,
      c.created_at ASC
    LIMIT 1;
    
    -- Get all duplicates (not the keeper)
    FOR duplicate_id IN
      SELECT id FROM customers
      WHERE phone = dup.phone AND id != keeper_id
    LOOP
      -- Move orders from duplicate to keeper
      UPDATE orders SET customer_id = keeper_id WHERE customer_id = duplicate_id;
      
      -- Move invoices from duplicate to keeper
      UPDATE invoices SET customer_id = keeper_id WHERE customer_id = duplicate_id;
      
      -- Delete loyalty transactions for duplicate (can't merge, just delete)
      DELETE FROM loyalty_transactions WHERE customer_id = duplicate_id;
      
      -- Delete customer_loyalty record for duplicate
      DELETE FROM customer_loyalty WHERE customer_id = duplicate_id;
      
      -- Delete duplicate customer
      DELETE FROM customers WHERE id = duplicate_id;
      
      merged_count := merged_count + 1;
    END LOOP;
  END LOOP;
  
  RAISE NOTICE 'Merged % duplicate customers', merged_count;
END $$;

-- =============================================
-- STEP 5: Also merge by email (for any remaining)
-- =============================================

DO $$
DECLARE
  dup RECORD;
  keeper_id UUID;
  duplicate_id UUID;
  merged_count INT := 0;
BEGIN
  -- Find duplicates by email
  FOR dup IN 
    SELECT email
    FROM customers
    WHERE email IS NOT NULL AND email != ''
    GROUP BY email
    HAVING COUNT(*) > 1
  LOOP
    -- Get the keeper
    SELECT id INTO keeper_id
    FROM customers c
    WHERE c.email = dup.email
    ORDER BY 
      CASE WHEN c.preferences->>'cc_id' IS NOT NULL THEN 0 ELSE 1 END,
      (SELECT COUNT(*) FROM orders WHERE customer_id = c.id) DESC,
      c.created_at ASC
    LIMIT 1;
    
    -- Get all duplicates
    FOR duplicate_id IN
      SELECT id FROM customers
      WHERE email = dup.email AND id != keeper_id
    LOOP
      UPDATE orders SET customer_id = keeper_id WHERE customer_id = duplicate_id;
      UPDATE invoices SET customer_id = keeper_id WHERE customer_id = duplicate_id;
      
      -- Delete loyalty data for duplicate
      DELETE FROM loyalty_transactions WHERE customer_id = duplicate_id;
      DELETE FROM customer_loyalty WHERE customer_id = duplicate_id;
      
      DELETE FROM customers WHERE id = duplicate_id;
      merged_count := merged_count + 1;
    END LOOP;
  END LOOP;
  
  RAISE NOTICE 'Merged % additional duplicate customers by email', merged_count;
END $$;

-- =============================================
-- VERIFICATION
-- =============================================

-- Check remaining duplicates
SELECT 'Remaining phone duplicates' as check_type, COUNT(*) as count
FROM (
  SELECT phone FROM customers 
  WHERE phone IS NOT NULL AND phone != ''
  GROUP BY phone HAVING COUNT(*) > 1
) t
UNION ALL
SELECT 'Remaining email duplicates', COUNT(*)
FROM (
  SELECT email FROM customers 
  WHERE email IS NOT NULL AND email != ''
  GROUP BY email HAVING COUNT(*) > 1
) t;

-- Final customer count
SELECT 'Total customers after cleanup' as metric, COUNT(*) as count FROM customers;

-- Verify German Alveo
SELECT id, first_name, last_name, phone, 
  preferences->>'cc_id' as cc_id,
  (SELECT COUNT(*) FROM orders WHERE customer_id = customers.id) as orders
FROM customers
WHERE first_name ILIKE '%german%';
