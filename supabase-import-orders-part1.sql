-- =============================================
-- CleanCloud Orders Import - Part 1 of 7
-- Orders 1 to 500 (of 3472)
-- Run supabase-import-orders-migration.sql FIRST
-- =============================================

DO $$
DECLARE
  v_store_id UUID;
  v_customer_id UUID;
  v_order_id UUID;
  v_pm_efectivo UUID;
  v_pm_tarjeta UUID;
  v_pm_ach UUID;
  v_pm_yappy UUID;
  v_pm_factura UUID;
BEGIN
  SELECT id INTO v_store_id FROM stores LIMIT 1;
  
  IF v_store_id IS NULL THEN
    RAISE EXCEPTION 'No store found. Please create a store first.';
  END IF;
  
  -- Cache payment method IDs
  SELECT id INTO v_pm_efectivo FROM payment_methods WHERE store_id = v_store_id AND name = 'Efectivo' LIMIT 1;
  SELECT id INTO v_pm_tarjeta FROM payment_methods WHERE store_id = v_store_id AND name = 'Tarjeta' LIMIT 1;
  SELECT id INTO v_pm_ach FROM payment_methods WHERE store_id = v_store_id AND name = 'ACH' LIMIT 1;
  SELECT id INTO v_pm_yappy FROM payment_methods WHERE store_id = v_store_id AND name = 'Yappy' LIMIT 1;
  SELECT id INTO v_pm_factura FROM payment_methods WHERE store_id = v_store_id AND name = 'Factura' LIMIT 1;


  -- CC10
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC10', 'Retail', true, 'completed', false, 15.00, 0.00, 0, 1.05, 16.05, 0.00, 0, 4, '', '2024-02-20 00:00:00'::timestamptz, '2024-02-20 00:00:00'::timestamptz, '2024-02-20 09:48:00'::timestamptz, '2024-02-20 09:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.05, '2024-02-20 09:48:00'::timestamptz); END IF;

  -- CC11
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC11', 'Retail', true, 'completed', false, 11.25, 0.00, 0, 0.79, 12.04, 3.54, 1, 3, '', '2024-02-20 00:00:00'::timestamptz, '2024-02-20 00:00:00'::timestamptz, '2024-02-20 09:54:00'::timestamptz, '2024-02-20 09:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.04 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.04, '2024-02-20 09:54:00'::timestamptz); END IF;

  -- CC13
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC13', 'Retail', true, 'completed', false, 15.57, 0.00, 0, 1.09, 16.66, 5.43, 1, 2, '', '2024-02-20 00:00:00'::timestamptz, '2024-02-20 00:00:00'::timestamptz, '2024-02-20 16:23:00'::timestamptz, '2024-02-20 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.66 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.66, '2024-02-20 16:23:00'::timestamptz); END IF;

  -- CC19
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 4;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC19', 'Jefferson Steven Hernández', true, 'completed', false, 9.13, 0.00, 0, 0.64, 9.77, 2.85, 1, 2, '', '2024-02-21 00:00:00'::timestamptz, '2024-02-21 00:00:00'::timestamptz, '2024-02-21 10:59:00'::timestamptz, '2024-02-21 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.77 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.77, '2024-02-21 10:59:00'::timestamptz); END IF;

  -- CC20
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC20', 'Richard Emerson Hernández', true, 'completed', false, 9.88, 0.00, 0, 0.69, 10.57, 3.15, 1, 2, '', '2024-02-21 00:00:00'::timestamptz, '2024-02-21 00:00:00'::timestamptz, '2024-02-21 11:06:00'::timestamptz, '2024-02-21 11:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.57 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.57, '2024-02-21 11:06:00'::timestamptz); END IF;

  -- CC29
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC29', 'Richard Emerson Hernández', false, 'completed', false, 23.50, 0.00, 0, 1.65, 25.15, 0.00, 0, 4, '', '2024-02-26 00:00:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz, '2024-02-25 13:43:00'::timestamptz, '2024-02-25 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.15, '2024-02-25 13:43:00'::timestamptz); END IF;

  -- CC30
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC30', 'Richard Emerson Hernández', false, 'completed', false, 20.00, 0.00, 0, 1.40, 21.40, 0.00, 0, 3, '', '2024-02-26 00:00:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz, '2024-02-25 13:47:00'::timestamptz, '2024-02-25 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.40, '2024-02-25 13:47:00'::timestamptz); END IF;

  -- CC31
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC31', 'Richard Emerson Hernández', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 0.00, 0, 2, '', '2024-02-26 00:00:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz, '2024-02-25 14:09:00'::timestamptz, '2024-02-25 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-02-25 14:09:00'::timestamptz); END IF;

  -- CC32
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC32', 'Richard Emerson Hernández', false, 'completed', false, 16.50, 0.00, 0, 1.16, 17.66, 0.00, 0, 3, '', '2024-02-26 00:00:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz, '2024-02-25 14:10:00'::timestamptz, '2024-02-25 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.66 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.66, '2024-02-25 14:10:00'::timestamptz); END IF;

  -- CC33
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC33', 'Richard Emerson Hernández', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, '', '2024-02-26 00:00:00'::timestamptz, '2024-03-01 15:30:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz, '2024-02-25 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2024-02-25 14:30:00'::timestamptz); END IF;

  -- CC37
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC37', 'Richard Emerson Hernández', false, 'completed', false, 7.50, 0.00, 0, 0.53, 8.03, 0.00, 0, 2, '', '2024-02-27 00:00:00'::timestamptz, '2024-03-01 15:29:00'::timestamptz, '2024-02-26 12:54:00'::timestamptz, '2024-02-26 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.03, '2024-02-26 12:54:00'::timestamptz); END IF;

  -- CC38
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC38', 'Richard Emerson Hernández', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 0.00, 0, 2, '', '2024-02-27 00:00:00'::timestamptz, '2024-03-01 15:29:00'::timestamptz, '2024-02-26 15:03:00'::timestamptz, '2024-02-26 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-02-26 15:03:00'::timestamptz); END IF;

  -- CC39
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC39', 'Richard Emerson Hernández', false, 'completed', false, 10.50, 0.00, 0, 0.74, 11.24, 0.00, 0, 2, '', '2024-02-29 00:00:00'::timestamptz, '2024-03-04 14:16:00'::timestamptz, '2024-02-28 13:33:00'::timestamptz, '2024-02-28 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.24 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.24, '2024-02-28 13:33:00'::timestamptz); END IF;

  -- CC45
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC45', 'Yatzury Anderson', false, 'completed', false, 2.00, 0.00, 0, 0.14, 2.14, 0.00, 0, 1, '', '2024-02-29 00:00:00'::timestamptz, '2024-03-01 15:40:00'::timestamptz, '2024-02-28 14:26:00'::timestamptz, '2024-02-28 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.14 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.14, '2024-02-28 14:26:00'::timestamptz); END IF;

  -- CC46
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC46', 'Yatzury Anderson', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 2, '', '2024-02-28 00:00:00'::timestamptz, '2024-02-28 00:00:00'::timestamptz, '2024-02-28 14:28:00'::timestamptz, '2024-02-28 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-02-28 14:28:00'::timestamptz); END IF;

  -- CC47
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC47', 'Yatzury Anderson', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 1, '', '2024-02-28 00:00:00'::timestamptz, '2024-02-28 00:00:00'::timestamptz, '2024-02-28 14:29:00'::timestamptz, '2024-02-28 14:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-02-28 14:29:00'::timestamptz); END IF;

  -- CC48
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC48', 'Yatzury Anderson', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 0.00, 0, 2, '', '2024-03-02 00:00:00'::timestamptz, '2024-03-01 15:40:00'::timestamptz, '2024-03-01 15:25:00'::timestamptz, '2024-03-01 15:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-03-01 15:25:00'::timestamptz); END IF;

  -- CC49
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC49', 'Yatzury Anderson', true, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 2, '', '2024-03-01 00:00:00'::timestamptz, '2024-03-01 00:00:00'::timestamptz, '2024-03-01 16:00:00'::timestamptz, '2024-03-01 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-03-01 16:00:00'::timestamptz); END IF;

  -- CC50
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC50', 'Yatzury Anderson', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-04 00:00:00'::timestamptz, '2024-03-04 00:00:00'::timestamptz, '2024-03-04 14:15:00'::timestamptz, '2024-03-04 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-04 14:15:00'::timestamptz); END IF;

  -- CC51
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC51', 'Yatzury Anderson', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 0, '', '2024-03-04 00:00:00'::timestamptz, '2024-03-04 00:00:00'::timestamptz, '2024-03-04 14:16:00'::timestamptz, '2024-03-04 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-03-04 14:16:00'::timestamptz); END IF;

  -- CC52
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC52', 'Guzmán', false, 'completed', false, 20.88, 0.00, 0, 0.00, 20.88, 8.35, 2, 1, ' Refunded B/20.88 in order #138', '2024-03-13 00:00:00'::timestamptz, '2024-03-18 12:08:00'::timestamptz, '2024-03-11 13:36:00'::timestamptz, '2024-03-11 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.88, '2024-03-11 13:36:00'::timestamptz); END IF;

  -- CC53
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC53', 'Guzmán', true, 'completed', false, 20.88, 0.00, 0, 0.00, 20.88, 8.35, 3, 1, ' Refunded B/20.88 in order #139', '2024-03-11 00:00:00'::timestamptz, '2024-03-11 00:00:00'::timestamptz, '2024-03-11 15:11:00'::timestamptz, '2024-03-11 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.88, '2024-03-11 15:11:00'::timestamptz); END IF;

  -- CC54
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC54', 'Guzmán', false, 'completed', false, 20.88, 0.00, 0, 0.00, 20.88, 8.35, 2, 1, ' Refunded B/20.88 in order #140', '2024-03-13 00:00:00'::timestamptz, '2024-03-18 12:08:00'::timestamptz, '2024-03-11 15:14:00'::timestamptz, '2024-03-11 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.88, '2024-03-11 15:14:00'::timestamptz); END IF;

  -- CC56
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC56', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-03-15 00:00:00'::timestamptz, '2024-03-15 00:00:00'::timestamptz, '2024-03-15 16:50:00'::timestamptz, '2024-03-15 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-03-15 16:50:00'::timestamptz); END IF;

  -- CC57
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC57', 'Yatzury Anderson', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-03-17 00:00:00'::timestamptz, '2024-03-17 00:00:00'::timestamptz, '2024-03-17 08:57:00'::timestamptz, '2024-03-17 08:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-03-17 08:57:00'::timestamptz); END IF;

  -- CC58
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC58', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 0.00, 78.00, 0.00, 0, 16, ' Refunded B/78 in order #94', '2024-03-19 00:00:00'::timestamptz, '2024-03-22 16:49:00'::timestamptz, '2024-03-18 12:16:00'::timestamptz, '2024-03-18 12:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 78.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 78.00, '2024-03-18 12:16:00'::timestamptz); END IF;

  -- CC59
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC59', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, ' Refunded B/83.46 in order #141', '2024-03-19 00:00:00'::timestamptz, '2024-03-22 16:49:00'::timestamptz, '2024-03-18 12:18:00'::timestamptz, '2024-03-18 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-18 12:18:00'::timestamptz); END IF;

  -- CC60
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC60', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, ' Refunded B/83.46 in order #142', '2024-03-18 00:00:00'::timestamptz, '2024-03-22 16:49:00'::timestamptz, '2024-03-18 12:19:00'::timestamptz, '2024-03-18 12:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-18 12:19:00'::timestamptz); END IF;

  -- CC61
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC61', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, '', '2024-03-19 00:00:00'::timestamptz, '2024-03-22 16:49:00'::timestamptz, '2024-03-18 12:22:00'::timestamptz, '2024-03-18 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-18 12:22:00'::timestamptz); END IF;

  -- CC62
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC62', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, ' Refunded B/83.46 in order #143', '2024-03-18 00:00:00'::timestamptz, '2024-03-25 10:33:00'::timestamptz, '2024-03-18 12:23:00'::timestamptz, '2024-03-18 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-18 12:23:00'::timestamptz); END IF;

  -- CC63
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC63', 'Retail', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 13:37:00'::timestamptz, '2024-03-18 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2024-03-18 13:37:00'::timestamptz); END IF;

  -- CC64
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC64', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 16:11:00'::timestamptz, '2024-03-18 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-03-18 16:11:00'::timestamptz); END IF;

  -- CC65
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC65', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 16:12:00'::timestamptz, '2024-03-18 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-03-18 16:12:00'::timestamptz); END IF;

  -- CC73
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC73', 'Richard Emerson Hernández', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 0.00, 0, 2, '', '2024-03-19 00:00:00'::timestamptz, '2024-03-18 16:25:00'::timestamptz, '2024-03-18 16:25:00'::timestamptz, '2024-03-18 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-03-18 16:25:00'::timestamptz); END IF;

  -- CC74
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC74', 'Richard Emerson Hernández', false, 'completed', false, 23.00, 0.00, 0, 1.61, 24.61, 0.00, 0, 3, '', '2024-03-19 00:00:00'::timestamptz, '2024-03-19 16:09:00'::timestamptz, '2024-03-18 16:25:00'::timestamptz, '2024-03-18 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.61, '2024-03-18 16:25:00'::timestamptz); END IF;

  -- CC76
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC76', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 16:52:00'::timestamptz, '2024-03-18 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-03-18 16:52:00'::timestamptz); END IF;

  -- CC77
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC77', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 2, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 16:54:00'::timestamptz, '2024-03-18 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-03-18 16:54:00'::timestamptz); END IF;

  -- CC78
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC78', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-03-18 00:00:00'::timestamptz, '2024-03-18 00:00:00'::timestamptz, '2024-03-18 16:55:00'::timestamptz, '2024-03-18 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-03-18 16:55:00'::timestamptz); END IF;

  -- CC80
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC80', 'Richard Emerson Hernández', false, 'completed', false, 1.50, 0.00, 0, 0.11, 1.61, 0.00, 0, 1, '', '2024-03-21 00:00:00'::timestamptz, '2024-03-21 10:28:00'::timestamptz, '2024-03-20 10:18:00'::timestamptz, '2024-03-20 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.61, '2024-03-20 10:18:00'::timestamptz); END IF;

  -- CC81
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC81', 'Richard Emerson Hernández', false, 'completed', false, 1.50, 0.00, 0, 0.11, 1.61, 0.00, 0, 1, '', '2024-03-21 00:00:00'::timestamptz, '2024-03-21 10:28:00'::timestamptz, '2024-03-20 10:19:00'::timestamptz, '2024-03-20 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.61, '2024-03-20 10:19:00'::timestamptz); END IF;

  -- CC82
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC82', 'Richard Emerson Hernández', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 0.00, 0, 2, '', '2024-03-21 00:00:00'::timestamptz, '2024-03-21 10:28:00'::timestamptz, '2024-03-20 10:20:00'::timestamptz, '2024-03-20 10:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-03-20 10:20:00'::timestamptz); END IF;

  -- CC83
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC83', 'Richard Emerson Hernández', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 0.00, 0, 1, '', '2024-03-21 00:00:00'::timestamptz, '2024-03-21 10:28:00'::timestamptz, '2024-03-20 10:23:00'::timestamptz, '2024-03-20 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-03-20 10:23:00'::timestamptz); END IF;

  -- CC84
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC84', 'Richard Emerson Hernández', false, 'completed', false, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0, '', '2024-03-21 00:00:00'::timestamptz, '2024-03-21 10:28:00'::timestamptz, '2024-03-20 10:23:00'::timestamptz, '2024-03-20 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2024-03-20 10:23:00'::timestamptz); END IF;

  -- CC94
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC94', 'Guzmán', false, 'completed', false, -78.00, 0.00, 0, 0.00, -78.00, 0.00, 0, 0, '', '2024-03-21 10:56:00'::timestamptz, '2024-03-21 10:56:00'::timestamptz, '2024-03-21 10:56:00'::timestamptz, '2024-03-21 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -78.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -78.00, '2024-03-21 10:56:00'::timestamptz); END IF;

  -- CC95
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC95', 'Richard Emerson Hernández', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-03-22 00:00:00'::timestamptz, '2024-03-22 00:00:00'::timestamptz, '2024-03-22 16:46:00'::timestamptz, '2024-03-22 16:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-03-22 16:46:00'::timestamptz); END IF;

  -- CC96
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC96', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 3, '', '2024-03-23 00:00:00'::timestamptz, '2024-03-23 00:00:00'::timestamptz, '2024-03-23 12:11:00'::timestamptz, '2024-03-23 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-03-23 12:11:00'::timestamptz); END IF;

  -- CC97
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC97', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-03-23 00:00:00'::timestamptz, '2024-03-23 00:00:00'::timestamptz, '2024-03-23 15:23:00'::timestamptz, '2024-03-23 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-03-23 15:23:00'::timestamptz); END IF;

  -- CC98
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC98', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-03-23 00:00:00'::timestamptz, '2024-03-23 00:00:00'::timestamptz, '2024-03-23 16:41:00'::timestamptz, '2024-03-23 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-03-23 16:41:00'::timestamptz); END IF;

  -- CC99
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC99', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 15:24:00'::timestamptz, '2024-03-25 10:30:00'::timestamptz, '2024-03-25 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-25 10:30:00'::timestamptz); END IF;

  -- CC100
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC100', 'Guzmán', false, 'completed', false, 21.38, 0.00, 0, 1.50, 22.88, 8.55, 1, 1, ' Refunded B/22.88 in order #144', '2024-03-27 00:00:00'::timestamptz, '2024-03-25 15:24:00'::timestamptz, '2024-03-25 10:33:00'::timestamptz, '2024-03-25 10:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.88, '2024-03-25 10:33:00'::timestamptz); END IF;

  -- CC101
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC101', 'Richard Emerson Hernández', false, 'completed', false, 23.00, 0.00, 0, 1.61, 24.61, 0.00, 0, 3, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 10:34:00'::timestamptz, '2024-03-25 10:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.61, '2024-03-25 10:34:00'::timestamptz); END IF;

  -- CC102
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC102', 'Richard Emerson Hernández', false, 'completed', false, 11.00, 0.00, 0, 0.77, 11.77, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 10:38:00'::timestamptz, '2024-03-25 10:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.77 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.77, '2024-03-25 10:38:00'::timestamptz); END IF;

  -- CC103
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC103', 'Richard Emerson Hernández', false, 'completed', false, 11.00, 0.00, 0, 0.77, 11.77, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 10:39:00'::timestamptz, '2024-03-25 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.77 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.77, '2024-03-25 10:39:00'::timestamptz); END IF;

  -- CC105
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC105', 'Guzmán', false, 'completed', false, 21.38, 0.00, 0, 1.50, 22.88, 8.55, 1, 1, ' Refunded B/22.88 in order #145', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 15:24:00'::timestamptz, '2024-03-25 11:06:00'::timestamptz, '2024-03-25 11:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.88, '2024-03-25 11:06:00'::timestamptz); END IF;

  -- CC106
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC106', 'Richard Emerson Hernández', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 11:07:00'::timestamptz, '2024-03-25 11:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-03-25 11:07:00'::timestamptz); END IF;

  -- CC107
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC107', 'Richard Emerson Hernández', false, 'completed', false, 11.00, 0.00, 0, 0.77, 11.77, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 11:07:00'::timestamptz, '2024-03-25 11:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.77 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.77, '2024-03-25 11:07:00'::timestamptz); END IF;

  -- CC108
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC108', 'Richard Emerson Hernández', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 11:14:00'::timestamptz, '2024-03-25 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-03-25 11:14:00'::timestamptz); END IF;

  -- CC109
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC109', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 11:17:00'::timestamptz, '2024-03-25 11:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-03-25 11:17:00'::timestamptz); END IF;

  -- CC110
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC110', 'Richard Emerson Hernández', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 13:39:00'::timestamptz, '2024-03-25 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-03-25 13:39:00'::timestamptz); END IF;

  -- CC111
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC111', 'Guzmán', false, 'completed', false, 5.00, 0.00, 0, 0.35, 5.35, 0.00, 0, 1, '', '2024-03-26 00:00:00'::timestamptz, '2024-03-25 15:24:00'::timestamptz, '2024-03-25 14:09:00'::timestamptz, '2024-03-25 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.35, '2024-03-25 14:09:00'::timestamptz); END IF;

  -- CC112
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC112', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 2, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz, '2024-03-25 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-03-25 14:21:00'::timestamptz); END IF;

  -- CC113
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC113', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 14:25:00'::timestamptz, '2024-03-25 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 2.00, '2024-03-25 14:25:00'::timestamptz); END IF;

  -- CC114
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC114', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 14:26:00'::timestamptz, '2024-03-25 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-03-25 14:26:00'::timestamptz); END IF;

  -- CC115
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC115', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 14:30:00'::timestamptz, '2024-03-25 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-03-25 14:30:00'::timestamptz); END IF;

  -- CC116
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC116', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 14:32:00'::timestamptz, '2024-03-25 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-03-25 14:32:00'::timestamptz); END IF;

  -- CC117
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC117', 'Guzmán', false, 'completed', false, 78.00, 0.00, 0, 5.46, 83.46, 0.00, 0, 16, '', '2024-03-25 00:00:00'::timestamptz, '2024-04-08 09:19:00'::timestamptz, '2024-03-25 15:29:00'::timestamptz, '2024-03-25 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 83.46, '2024-03-25 15:29:00'::timestamptz); END IF;

  -- CC118
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC118', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-03-25 00:00:00'::timestamptz, '2024-03-25 00:00:00'::timestamptz, '2024-03-25 15:41:00'::timestamptz, '2024-03-25 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-03-25 15:41:00'::timestamptz); END IF;

  -- CC119
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC119', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 4, '', '2024-03-27 00:00:00'::timestamptz, '2024-03-27 00:00:00'::timestamptz, '2024-03-27 14:57:00'::timestamptz, '2024-03-27 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-27 14:57:00'::timestamptz); END IF;

  -- CC120
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC120', 'Richard Emerson Hernández', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-28 00:00:00'::timestamptz, '2024-03-28 00:00:00'::timestamptz, '2024-03-28 10:14:00'::timestamptz, '2024-03-28 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-28 10:14:00'::timestamptz); END IF;

  -- CC121
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC121', 'Richard Emerson Hernández', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-28 00:00:00'::timestamptz, '2024-03-28 00:00:00'::timestamptz, '2024-03-28 10:15:00'::timestamptz, '2024-03-28 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-28 10:15:00'::timestamptz); END IF;

  -- CC122
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC122', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-28 00:00:00'::timestamptz, '2024-03-28 00:00:00'::timestamptz, '2024-03-28 10:17:00'::timestamptz, '2024-03-28 10:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-28 10:17:00'::timestamptz); END IF;

  -- CC123
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC123', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-28 00:00:00'::timestamptz, '2024-03-28 00:00:00'::timestamptz, '2024-03-28 10:18:00'::timestamptz, '2024-03-28 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-28 10:18:00'::timestamptz); END IF;

  -- CC124
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC124', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-03-28 00:00:00'::timestamptz, '2024-03-28 00:00:00'::timestamptz, '2024-03-28 13:33:00'::timestamptz, '2024-03-28 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-03-28 13:33:00'::timestamptz); END IF;

  -- CC125
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC125', 'Richard Emerson Hernández', false, 'completed', false, 42.00, 0.00, 0, 2.94, 44.94, 0.00, 0, 11, ' Refunded B/44.94 in order #147', '2024-04-02 00:00:00'::timestamptz, '2024-04-08 09:22:00'::timestamptz, '2024-04-01 09:45:00'::timestamptz, '2024-04-01 09:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 44.94 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 44.94, '2024-04-01 09:45:00'::timestamptz); END IF;

  -- CC126
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC126', 'Retail', true, 'completed', false, 4.50, 0.00, 0, 0.00, 4.50, 0.00, 0, 3, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:46:00'::timestamptz, '2024-04-01 09:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-04-01 09:46:00'::timestamptz); END IF;

  -- CC127
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC127', 'Retail', true, 'completed', false, 3.75, 0.00, 0, 0.00, 3.75, 0.00, 0, 3, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:47:00'::timestamptz, '2024-04-01 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2024-04-01 09:47:00'::timestamptz); END IF;

  -- CC128
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC128', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:47:00'::timestamptz, '2024-04-01 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-04-01 09:47:00'::timestamptz); END IF;

  -- CC129
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC129', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:50:00'::timestamptz, '2024-04-01 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-04-01 09:50:00'::timestamptz); END IF;

  -- CC130
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC130', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 2, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:51:00'::timestamptz, '2024-04-01 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-04-01 09:51:00'::timestamptz); END IF;

  -- CC131
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC131', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 09:54:00'::timestamptz, '2024-04-01 09:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-04-01 09:54:00'::timestamptz); END IF;

  -- CC132
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC132', 'Richard Emerson Hernández', false, 'completed', false, 50.00, 0.00, 0, 3.50, 53.50, 0.00, 0, 10, ' Refunded B/53.5 in order #146', '2024-04-02 00:00:00'::timestamptz, '2024-04-08 09:22:00'::timestamptz, '2024-04-01 11:30:00'::timestamptz, '2024-04-01 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 53.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 53.50, '2024-04-01 11:30:00'::timestamptz); END IF;

  -- CC133
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC133', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 13:38:00'::timestamptz, '2024-04-01 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-04-01 13:38:00'::timestamptz); END IF;

  -- CC134
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC134', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 13:40:00'::timestamptz, '2024-04-01 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-04-01 13:40:00'::timestamptz); END IF;

  -- CC135
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC135', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-04-01 00:00:00'::timestamptz, '2024-04-01 00:00:00'::timestamptz, '2024-04-01 13:41:00'::timestamptz, '2024-04-01 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-04-01 13:41:00'::timestamptz); END IF;

  -- CC136
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC136', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-04-02 00:00:00'::timestamptz, '2024-04-02 00:00:00'::timestamptz, '2024-04-02 09:39:00'::timestamptz, '2024-04-02 09:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-04-02 09:39:00'::timestamptz); END IF;

  -- CC137
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC137', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-04-02 00:00:00'::timestamptz, '2024-04-02 00:00:00'::timestamptz, '2024-04-02 09:44:00'::timestamptz, '2024-04-02 09:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-04-02 09:44:00'::timestamptz); END IF;

  -- CC138
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC138', 'Guzmán', false, 'completed', false, -20.88, 0.00, 0, 0.00, -20.88, 0.00, 0, 0, '', '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -20.88, '2024-04-08 09:16:00'::timestamptz); END IF;

  -- CC139
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC139', 'Guzmán', false, 'completed', false, -20.88, 0.00, 0, 0.00, -20.88, 0.00, 0, 0, '', '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -20.88, '2024-04-08 09:16:00'::timestamptz); END IF;

  -- CC140
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC140', 'Guzmán', false, 'completed', false, -20.88, 0.00, 0, 0.00, -20.88, 0.00, 0, 0, '', '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz, '2024-04-08 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -20.88, '2024-04-08 09:16:00'::timestamptz); END IF;

  -- CC141
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC141', 'Guzmán', false, 'completed', false, -78.00, 0.00, 0, -5.46, -83.46, 0.00, 0, 0, '', '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -83.46, '2024-04-08 09:17:00'::timestamptz); END IF;

  -- CC142
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC142', 'Guzmán', false, 'completed', false, -78.00, 0.00, 0, -5.46, -83.46, 0.00, 0, 0, '', '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -83.46, '2024-04-08 09:17:00'::timestamptz); END IF;

  -- CC143
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC143', 'Guzmán', false, 'completed', false, -78.00, 0.00, 0, -5.46, -83.46, 0.00, 0, 0, '', '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz, '2024-04-08 09:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -83.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -83.46, '2024-04-08 09:17:00'::timestamptz); END IF;

  -- CC144
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC144', 'Guzmán', false, 'completed', false, -21.38, 0.00, 0, -1.50, -22.88, 0.00, 0, 0, '', '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -22.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -22.88, '2024-04-08 09:18:00'::timestamptz); END IF;

  -- CC145
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC145', 'Guzmán', false, 'completed', false, -21.38, 0.00, 0, -1.50, -22.88, 0.00, 0, 0, '', '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz, '2024-04-08 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -22.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -22.88, '2024-04-08 09:18:00'::timestamptz); END IF;

  -- CC146
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC146', 'Richard Emerson Hernández', false, 'completed', false, -50.00, 0.00, 0, -3.50, -53.50, 0.00, 0, 0, '', '2024-04-08 09:20:00'::timestamptz, '2024-04-08 09:20:00'::timestamptz, '2024-04-08 09:20:00'::timestamptz, '2024-04-08 09:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -53.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -53.50, '2024-04-08 09:20:00'::timestamptz); END IF;

  -- CC147
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC147', 'Richard Emerson Hernández', false, 'completed', false, -42.00, 0.00, 0, -2.94, -44.94, 0.00, 0, 0, '', '2024-04-08 09:21:00'::timestamptz, '2024-04-08 09:21:00'::timestamptz, '2024-04-08 09:21:00'::timestamptz, '2024-04-08 09:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -44.94 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -44.94, '2024-04-08 09:21:00'::timestamptz); END IF;

  -- CC148
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC148', 'Richard Emerson Hernández', false, 'completed', false, 7.50, 0.00, 0, 0.53, 8.03, 3.00, 1, 1, ' Refunded B/8.03 in order #233', '2024-04-16 00:00:00'::timestamptz, '2024-07-10 13:01:00'::timestamptz, '2024-04-14 10:31:00'::timestamptz, '2024-04-14 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.03, '2024-04-14 10:31:00'::timestamptz); END IF;

  -- CC149
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC149', 'Retail', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, '', '2024-04-18 00:00:00'::timestamptz, '2024-04-18 00:00:00'::timestamptz, '2024-04-18 10:18:00'::timestamptz, '2024-04-18 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2024-04-18 10:18:00'::timestamptz); END IF;

  -- CC150
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC150', 'Retail', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, '', '2024-04-18 00:00:00'::timestamptz, '2024-04-18 00:00:00'::timestamptz, '2024-04-18 10:19:00'::timestamptz, '2024-04-18 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2024-04-18 10:19:00'::timestamptz); END IF;

  -- CC151
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 9;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC151', 'Mariela Arrocha', false, 'completed', false, 31.88, 0.00, 0, 2.23, 34.11, 12.75, 1, 1, '', '2024-04-24 00:00:00'::timestamptz, '2024-04-22 14:08:00'::timestamptz, '2024-04-22 14:07:00'::timestamptz, '2024-04-22 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.11 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.11, '2024-04-22 14:07:00'::timestamptz); END IF;

  -- CC157
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC157', 'Richard Emerson Hernández', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '', '2024-04-28 00:00:00'::timestamptz, '2024-05-20 09:42:00'::timestamptz, '2024-04-27 14:18:00'::timestamptz, '2024-04-27 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-04-27 14:18:00'::timestamptz); END IF;

  -- CC158
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC158', 'Leonel Visueti', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, '', '2024-04-28 00:00:00'::timestamptz, '2024-05-03 11:31:00'::timestamptz, '2024-04-27 14:21:00'::timestamptz, '2024-04-27 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2024-04-27 14:21:00'::timestamptz); END IF;

  -- CC159
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC159', 'Leonel Visueti', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '', '2024-04-28 00:00:00'::timestamptz, '2024-05-03 11:31:00'::timestamptz, '2024-04-27 14:58:00'::timestamptz, '2024-04-27 14:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-04-27 14:58:00'::timestamptz); END IF;

  -- CC160
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC160', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-05-03 00:00:00'::timestamptz, '2024-05-03 00:00:00'::timestamptz, '2024-05-03 10:55:00'::timestamptz, '2024-05-03 10:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-05-03 10:55:00'::timestamptz); END IF;

  -- CC161
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC161', 'Leonel Visueti', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-05-03 00:00:00'::timestamptz, '2024-05-03 00:00:00'::timestamptz, '2024-05-03 11:29:00'::timestamptz, '2024-05-03 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-05-03 11:29:00'::timestamptz); END IF;

  -- CC162
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC162', 'Leonel Visueti', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 1, '', '2024-05-03 00:00:00'::timestamptz, '2024-05-03 00:00:00'::timestamptz, '2024-05-03 11:31:00'::timestamptz, '2024-05-03 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-05-03 11:31:00'::timestamptz); END IF;

  -- CC163
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC163', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 5, '', '2024-05-03 00:00:00'::timestamptz, '2024-05-03 00:00:00'::timestamptz, '2024-05-03 13:01:00'::timestamptz, '2024-05-03 13:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2024-05-03 13:01:00'::timestamptz); END IF;

  -- CC164
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC164', 'Leonel Visueti', false, 'completed', false, 21.25, 0.00, 0, 1.49, 22.74, 8.50, 5, 1, '', '2024-05-04 00:00:00'::timestamptz, '2024-05-15 10:48:00'::timestamptz, '2024-05-03 16:21:00'::timestamptz, '2024-05-03 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.74, '2024-05-03 16:21:00'::timestamptz); END IF;

  -- CC165
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC165', 'Leonel Visueti', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-05-03 00:00:00'::timestamptz, '2024-05-03 00:00:00'::timestamptz, '2024-05-03 16:39:00'::timestamptz, '2024-05-03 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-05-03 16:39:00'::timestamptz); END IF;

  -- CC166
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC166', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-05-04 00:00:00'::timestamptz, '2024-05-04 00:00:00'::timestamptz, '2024-05-04 11:30:00'::timestamptz, '2024-05-04 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-05-04 11:30:00'::timestamptz); END IF;

  -- CC167
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC167', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-05-04 00:00:00'::timestamptz, '2024-05-04 00:00:00'::timestamptz, '2024-05-04 11:51:00'::timestamptz, '2024-05-04 11:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-05-04 11:51:00'::timestamptz); END IF;

  -- CC168
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC168', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-05-04 00:00:00'::timestamptz, '2024-05-04 00:00:00'::timestamptz, '2024-05-04 15:07:00'::timestamptz, '2024-05-04 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-05-04 15:07:00'::timestamptz); END IF;

  -- CC169
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC169', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-05-04 00:00:00'::timestamptz, '2024-05-04 00:00:00'::timestamptz, '2024-05-04 15:12:00'::timestamptz, '2024-05-04 15:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-04 15:12:00'::timestamptz); END IF;

  -- CC170
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC170', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-05 00:00:00'::timestamptz, '2024-05-05 00:00:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-05 14:54:00'::timestamptz); END IF;

  -- CC171
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC171', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-05 00:00:00'::timestamptz, '2024-05-05 00:00:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-05 14:54:00'::timestamptz); END IF;

  -- CC172
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC172', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-05 00:00:00'::timestamptz, '2024-05-05 00:00:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz, '2024-05-05 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-05 14:54:00'::timestamptz); END IF;

  -- CC173
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC173', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-05 00:00:00'::timestamptz, '2024-05-05 00:00:00'::timestamptz, '2024-05-05 14:58:00'::timestamptz, '2024-05-05 14:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-05 14:58:00'::timestamptz); END IF;

  -- CC174
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC174', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, '', '2024-05-06 00:00:00'::timestamptz, '2024-05-06 00:00:00'::timestamptz, '2024-05-06 15:35:00'::timestamptz, '2024-05-06 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2024-05-06 15:35:00'::timestamptz); END IF;

  -- CC175
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC175', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-05-06 00:00:00'::timestamptz, '2024-05-06 00:00:00'::timestamptz, '2024-05-06 15:38:00'::timestamptz, '2024-05-06 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-05-06 15:38:00'::timestamptz); END IF;

  -- CC176
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC176', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-08 00:00:00'::timestamptz, '2024-05-08 00:00:00'::timestamptz, '2024-05-08 09:50:00'::timestamptz, '2024-05-08 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-08 09:50:00'::timestamptz); END IF;

  -- CC177
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC177', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-05-08 00:00:00'::timestamptz, '2024-05-08 00:00:00'::timestamptz, '2024-05-08 13:16:00'::timestamptz, '2024-05-08 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-05-08 13:16:00'::timestamptz); END IF;

  -- CC178
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC178', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-05-08 00:00:00'::timestamptz, '2024-05-08 00:00:00'::timestamptz, '2024-05-08 13:23:00'::timestamptz, '2024-05-08 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-08 13:23:00'::timestamptz); END IF;

  -- CC179
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC179', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-05-09 00:00:00'::timestamptz, '2024-05-09 00:00:00'::timestamptz, '2024-05-09 10:07:00'::timestamptz, '2024-05-09 10:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-09 10:07:00'::timestamptz); END IF;

  -- CC180
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC180', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 2, '', '2024-05-09 00:00:00'::timestamptz, '2024-05-09 00:00:00'::timestamptz, '2024-05-09 10:09:00'::timestamptz, '2024-05-09 10:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-05-09 10:09:00'::timestamptz); END IF;

  -- CC181
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC181', 'Leonel Visueti', false, 'completed', false, 6.25, 0.00, 0, 0.44, 6.69, 2.50, 1, 1, '', '2024-05-12 00:00:00'::timestamptz, '2024-05-15 10:48:00'::timestamptz, '2024-05-10 17:03:00'::timestamptz, '2024-05-10 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.69 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.69, '2024-05-10 17:03:00'::timestamptz); END IF;

  -- CC182
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC182', 'Leonel Visueti', false, 'completed', false, 42.13, 0.00, 0, 2.95, 45.08, 16.85, 8, 1, '', '2024-05-11 00:00:00'::timestamptz, '2024-05-15 10:48:00'::timestamptz, '2024-05-11 12:57:00'::timestamptz, '2024-05-11 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 45.08 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 45.08, '2024-05-11 12:57:00'::timestamptz); END IF;

  -- CC183
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC183', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-11 00:00:00'::timestamptz, '2024-05-11 00:00:00'::timestamptz, '2024-05-11 13:15:00'::timestamptz, '2024-05-11 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-11 13:15:00'::timestamptz); END IF;

  -- CC184
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC184', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 2, '', '2024-05-11 00:00:00'::timestamptz, '2024-05-11 00:00:00'::timestamptz, '2024-05-11 14:53:00'::timestamptz, '2024-05-11 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-05-11 14:53:00'::timestamptz); END IF;

  -- CC185
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC185', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-12 00:00:00'::timestamptz, '2024-05-12 00:00:00'::timestamptz, '2024-05-11 19:11:00'::timestamptz, '2024-05-11 19:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-11 19:11:00'::timestamptz); END IF;

  -- CC186
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC186', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 3, '', '2024-05-12 00:00:00'::timestamptz, '2024-05-12 00:00:00'::timestamptz, '2024-05-11 19:13:00'::timestamptz, '2024-05-11 19:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-05-11 19:13:00'::timestamptz); END IF;

  -- CC187
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC187', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-05-12 00:00:00'::timestamptz, '2024-05-12 00:00:00'::timestamptz, '2024-05-12 10:12:00'::timestamptz, '2024-05-12 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-12 10:12:00'::timestamptz); END IF;

  -- CC188
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC188', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-14 00:00:00'::timestamptz, '2024-05-14 00:00:00'::timestamptz, '2024-05-14 10:57:00'::timestamptz, '2024-05-14 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-14 10:57:00'::timestamptz); END IF;

  -- CC189
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC189', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-14 00:00:00'::timestamptz, '2024-05-14 00:00:00'::timestamptz, '2024-05-14 10:57:00'::timestamptz, '2024-05-14 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-14 10:57:00'::timestamptz); END IF;

  -- CC190
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC190', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-14 00:00:00'::timestamptz, '2024-05-14 00:00:00'::timestamptz, '2024-05-14 10:58:00'::timestamptz, '2024-05-14 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-14 10:58:00'::timestamptz); END IF;

  -- CC191
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC191', 'Leonel Visueti', false, 'completed', false, 12.38, 0.00, 0, 0.87, 13.25, 4.95, 1, 1, '', '2024-05-17 00:00:00'::timestamptz, '2024-05-15 10:48:00'::timestamptz, '2024-05-15 10:46:00'::timestamptz, '2024-05-15 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.25, '2024-05-15 10:46:00'::timestamptz); END IF;

  -- CC192
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC192', 'Leonel Visueti', false, 'completed', false, 12.38, 0.00, 0, 0.87, 13.25, 4.95, 1, 1, '', '2024-05-15 00:00:00'::timestamptz, '2024-05-15 10:48:00'::timestamptz, '2024-05-15 10:47:00'::timestamptz, '2024-05-15 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.25, '2024-05-15 10:47:00'::timestamptz); END IF;

  -- CC193
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC193', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-05-15 00:00:00'::timestamptz, '2024-05-15 00:00:00'::timestamptz, '2024-05-15 12:21:00'::timestamptz, '2024-05-15 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-05-15 12:21:00'::timestamptz); END IF;

  -- CC194
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC194', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-16 00:00:00'::timestamptz, '2024-05-16 00:00:00'::timestamptz, '2024-05-16 10:25:00'::timestamptz, '2024-05-16 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-16 10:25:00'::timestamptz); END IF;

  -- CC195
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC195', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-16 00:00:00'::timestamptz, '2024-05-16 00:00:00'::timestamptz, '2024-05-16 14:34:00'::timestamptz, '2024-05-16 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-16 14:34:00'::timestamptz); END IF;

  -- CC196
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC196', 'Leonel Visueti', false, 'completed', false, 33.50, 0.00, 0, 2.35, 35.85, 13.40, 5, 1, '', '2024-05-19 00:00:00'::timestamptz, '2024-05-24 14:03:00'::timestamptz, '2024-05-17 09:46:00'::timestamptz, '2024-05-17 09:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.85, '2024-05-17 09:46:00'::timestamptz); END IF;

  -- CC197
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC197', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 2, '', '2024-05-17 00:00:00'::timestamptz, '2024-05-17 00:00:00'::timestamptz, '2024-05-17 10:00:00'::timestamptz, '2024-05-17 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-17 10:00:00'::timestamptz); END IF;

  -- CC198
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC198', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-05-18 00:00:00'::timestamptz, '2024-05-18 00:00:00'::timestamptz, '2024-05-18 15:52:00'::timestamptz, '2024-05-18 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-05-18 15:52:00'::timestamptz); END IF;

  -- CC199
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC199', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 3, '', '2024-05-19 00:00:00'::timestamptz, '2024-05-19 00:00:00'::timestamptz, '2024-05-19 07:17:00'::timestamptz, '2024-05-19 07:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-05-19 07:17:00'::timestamptz); END IF;

  -- CC200
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC200', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-20 00:00:00'::timestamptz, '2024-05-20 00:00:00'::timestamptz, '2024-05-20 09:43:00'::timestamptz, '2024-05-20 09:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 1.00, '2024-05-20 09:43:00'::timestamptz); END IF;

  -- CC201
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC201', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-05-20 00:00:00'::timestamptz, '2024-05-20 00:00:00'::timestamptz, '2024-05-20 11:17:00'::timestamptz, '2024-05-20 11:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-05-20 11:17:00'::timestamptz); END IF;

  -- CC202
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC202', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-20 00:00:00'::timestamptz, '2024-05-20 00:00:00'::timestamptz, '2024-05-20 11:18:00'::timestamptz, '2024-05-20 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-20 11:18:00'::timestamptz); END IF;

  -- CC203
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC203', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 5, '', '2024-05-22 00:00:00'::timestamptz, '2024-05-22 00:00:00'::timestamptz, '2024-05-22 12:10:00'::timestamptz, '2024-05-22 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-05-22 12:10:00'::timestamptz); END IF;

  -- CC204
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC204', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-05-22 00:00:00'::timestamptz, '2024-05-22 00:00:00'::timestamptz, '2024-05-22 15:34:00'::timestamptz, '2024-05-22 15:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-05-22 15:34:00'::timestamptz); END IF;

  -- CC205
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC205', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-24 00:00:00'::timestamptz, '2024-05-24 00:00:00'::timestamptz, '2024-05-24 13:17:00'::timestamptz, '2024-05-24 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-24 13:17:00'::timestamptz); END IF;

  -- CC206
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC206', 'Leonel Visueti', false, 'completed', false, 34.38, 0.00, 0, 2.41, 36.79, 13.75, 5, 1, '', '2024-05-26 00:00:00'::timestamptz, '2024-05-24 14:03:00'::timestamptz, '2024-05-24 14:01:00'::timestamptz, '2024-05-24 14:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.79, '2024-05-24 14:01:00'::timestamptz); END IF;

  -- CC207
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC207', 'Leonel Visueti', false, 'completed', false, 34.38, 0.00, 0, 2.41, 36.79, 13.75, 5, 1, '', '2024-05-24 00:00:00'::timestamptz, '2024-05-25 10:16:00'::timestamptz, '2024-05-24 14:03:00'::timestamptz, '2024-05-24 14:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.79, '2024-05-24 14:03:00'::timestamptz); END IF;

  -- CC208
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC208', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.14, 2.14, 0.00, 0, 1, '', '2024-05-25 00:00:00'::timestamptz, '2024-05-25 10:16:00'::timestamptz, '2024-05-24 17:18:00'::timestamptz, '2024-05-24 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.14 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.14, '2024-05-24 17:18:00'::timestamptz); END IF;

  -- CC209
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC209', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.28, 4.28, 0.00, 0, 2, '', '2024-05-25 00:00:00'::timestamptz, '2024-05-25 10:16:00'::timestamptz, '2024-05-24 17:18:00'::timestamptz, '2024-05-24 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.28 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.28, '2024-05-24 17:18:00'::timestamptz); END IF;

  -- CC210
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC210', 'Leonel Visueti', false, 'completed', false, 8.00, 0.00, 0, 0.56, 8.56, 0.00, 0, 4, '', '2024-05-26 00:00:00'::timestamptz, '2024-05-27 15:15:00'::timestamptz, '2024-05-25 10:16:00'::timestamptz, '2024-05-25 10:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.56, '2024-05-25 10:16:00'::timestamptz); END IF;

  -- CC211
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC211', 'Leonel Visueti', false, 'completed', false, 8.00, 0.00, 0, 0.56, 8.56, 0.00, 0, 4, '', '2024-05-26 00:00:00'::timestamptz, '2024-05-27 15:15:00'::timestamptz, '2024-05-25 12:24:00'::timestamptz, '2024-05-25 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.56, '2024-05-25 12:24:00'::timestamptz); END IF;

  -- CC212
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC212', 'Leonel Visueti', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 0.00, 0, 6, '', '2024-05-26 00:00:00'::timestamptz, '2024-05-27 15:15:00'::timestamptz, '2024-05-25 14:12:00'::timestamptz, '2024-05-25 14:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-05-25 14:12:00'::timestamptz); END IF;

  -- CC213
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC213', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-05-26 00:00:00'::timestamptz, '2024-05-26 00:00:00'::timestamptz, '2024-05-26 13:21:00'::timestamptz, '2024-05-26 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-26 13:21:00'::timestamptz); END IF;

  -- CC214
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC214', 'Leonel Visueti', false, 'completed', false, 8.50, 0.00, 0, 0.60, 9.10, 3.40, 2, 1, '', '2024-05-29 00:00:00'::timestamptz, '2024-05-27 15:17:00'::timestamptz, '2024-05-27 15:16:00'::timestamptz, '2024-05-27 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.10, '2024-05-27 15:16:00'::timestamptz); END IF;

  -- CC215
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC215', 'Leonel Visueti', false, 'completed', false, 8.50, 0.00, 0, 0.60, 9.10, 3.40, 2, 1, '', '2024-05-27 00:00:00'::timestamptz, '2024-07-10 13:01:00'::timestamptz, '2024-05-27 15:17:00'::timestamptz, '2024-05-27 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.10, '2024-05-27 15:17:00'::timestamptz); END IF;

  -- CC216
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC216', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-28 00:00:00'::timestamptz, '2024-05-28 00:00:00'::timestamptz, '2024-05-28 09:36:00'::timestamptz, '2024-05-28 09:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-28 09:36:00'::timestamptz); END IF;

  -- CC217
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC217', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-05-30 00:00:00'::timestamptz, '2024-05-30 00:00:00'::timestamptz, '2024-05-30 13:33:00'::timestamptz, '2024-05-30 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-05-30 13:33:00'::timestamptz); END IF;

  -- CC218
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC218', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-31 00:00:00'::timestamptz, '2024-05-31 00:00:00'::timestamptz, '2024-05-31 17:38:00'::timestamptz, '2024-05-31 17:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-31 17:38:00'::timestamptz); END IF;

  -- CC219
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC219', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-05-31 00:00:00'::timestamptz, '2024-05-31 00:00:00'::timestamptz, '2024-05-31 17:38:00'::timestamptz, '2024-05-31 17:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-05-31 17:38:00'::timestamptz); END IF;

  -- CC220
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC220', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-06-01 00:00:00'::timestamptz, '2024-06-01 00:00:00'::timestamptz, '2024-06-01 09:04:00'::timestamptz, '2024-06-01 09:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-06-01 09:04:00'::timestamptz); END IF;

  -- CC221
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC221', 'Leonel Visueti', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 7.20, 3, 1, '', '2024-06-03 00:00:00'::timestamptz, '2024-07-10 13:01:00'::timestamptz, '2024-06-01 11:15:00'::timestamptz, '2024-06-01 11:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-06-01 11:15:00'::timestamptz); END IF;

  -- CC222
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC222', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-06-02 00:00:00'::timestamptz, '2024-06-02 00:00:00'::timestamptz, '2024-06-02 13:26:00'::timestamptz, '2024-06-02 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-06-02 13:26:00'::timestamptz); END IF;

  -- CC223
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC223', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-06-02 00:00:00'::timestamptz, '2024-06-02 00:00:00'::timestamptz, '2024-06-02 15:32:00'::timestamptz, '2024-06-02 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-06-02 15:32:00'::timestamptz); END IF;

  -- CC224
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC224', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-06-02 00:00:00'::timestamptz, '2024-06-02 00:00:00'::timestamptz, '2024-06-02 17:48:00'::timestamptz, '2024-06-02 17:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-06-02 17:48:00'::timestamptz); END IF;

  -- CC225
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC225', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-06-03 00:00:00'::timestamptz, '2024-06-03 00:00:00'::timestamptz, '2024-06-03 16:03:00'::timestamptz, '2024-06-03 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-06-03 16:03:00'::timestamptz); END IF;

  -- CC226
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC226', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-06-04 00:00:00'::timestamptz, '2024-06-04 00:00:00'::timestamptz, '2024-06-04 11:27:00'::timestamptz, '2024-06-04 11:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-06-04 11:27:00'::timestamptz); END IF;

  -- CC227
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC227', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-06-05 00:00:00'::timestamptz, '2024-06-05 00:00:00'::timestamptz, '2024-06-05 11:23:00'::timestamptz, '2024-06-05 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-06-05 11:23:00'::timestamptz); END IF;

  -- CC230
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC230', 'Leonel Visueti', false, 'completed', false, 22.00, 0.00, 0, 1.54, 23.54, 0.00, 0, 3, '', '2024-06-06 00:00:00'::timestamptz, '2024-07-10 12:51:00'::timestamptz, '2024-06-06 10:23:00'::timestamptz, '2024-06-06 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.54, '2024-06-06 10:23:00'::timestamptz); END IF;

  -- CC231
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC231', 'Leonel Visueti', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 2, '', '2024-06-06 00:00:00'::timestamptz, '2024-06-06 00:00:00'::timestamptz, '2024-06-06 12:53:00'::timestamptz, '2024-06-06 12:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-06-06 12:53:00'::timestamptz); END IF;

  -- CC233
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC233', 'Richard Emerson Hernández', false, 'completed', false, -7.50, 0.00, 0, -0.53, -8.03, 0.00, 0, 0, '', '2024-07-10 12:51:00'::timestamptz, '2024-07-10 12:51:00'::timestamptz, '2024-07-10 12:51:00'::timestamptz, '2024-07-10 12:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_tarjeta IS NOT NULL AND -8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_tarjeta, 'Tarjeta', -8.03, '2024-07-10 12:51:00'::timestamptz); END IF;

  -- CC235
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 5;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC235', 'Richard Emerson Hernández', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '', '2024-07-11 00:00:00'::timestamptz, '2024-07-11 09:26:00'::timestamptz, '2024-07-11 09:22:00'::timestamptz, '2024-07-11 09:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-07-11 09:22:00'::timestamptz); END IF;

  -- CC236
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC236', 'Maybelis Robinson', false, 'completed', false, 34.00, 0.00, 0, 2.38, 36.38, 0.00, 0, 5, 'm', '2024-07-11 00:00:00'::timestamptz, '2024-07-11 09:36:00'::timestamptz, '2024-07-11 09:34:00'::timestamptz, '2024-07-11 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.38, '2024-07-11 09:34:00'::timestamptz); END IF;

  -- CC237
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC237', 'Marubenis Calderon', true, 'completed', false, 34.13, 0.00, 0, 2.39, 36.52, 13.65, 5, 1, 'm', '2024-07-11 00:00:00'::timestamptz, '2024-07-11 00:00:00'::timestamptz, '2024-07-11 09:42:00'::timestamptz, '2024-07-11 09:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.52 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.52, '2024-07-11 09:42:00'::timestamptz); END IF;

  -- CC238
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC238', 'Maybelis Robinson', false, 'completed', false, 26.90, 0.00, 0, 1.88, 28.78, 10.76, 4, 1, 'm', '2024-07-13 00:00:00'::timestamptz, '2024-07-11 09:47:00'::timestamptz, '2024-07-11 09:45:00'::timestamptz, '2024-07-11 09:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.78 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.78, '2024-07-11 09:45:00'::timestamptz); END IF;

  -- CC239
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC239', 'Marubenis Calderon', false, 'completed', false, 23.13, 0.00, 0, 1.62, 24.75, 9.25, 3, 1, 'm', '2024-07-13 00:00:00'::timestamptz, '2024-07-11 09:49:00'::timestamptz, '2024-07-11 09:48:00'::timestamptz, '2024-07-11 09:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.75, '2024-07-11 09:48:00'::timestamptz); END IF;

  -- CC240
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC240', 'Maybelis Robinson', false, 'completed', false, 7.44, 0.56, 0, 0.52, 7.96, 0.00, 0, 1, 'm', '2024-07-12 00:00:00'::timestamptz, '2024-07-11 10:07:00'::timestamptz, '2024-07-11 09:52:00'::timestamptz, '2024-07-11 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.96, '2024-07-11 09:52:00'::timestamptz); END IF;

  -- CC241
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC241', 'Maybelis Robinson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'm', '2024-07-12 00:00:00'::timestamptz, '2024-07-11 10:01:00'::timestamptz, '2024-07-11 10:00:00'::timestamptz, '2024-07-11 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-11 10:00:00'::timestamptz); END IF;

  -- CC242
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC242', 'Cliente Lavandería', true, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-11 00:00:00'::timestamptz, '2024-07-11 00:00:00'::timestamptz, '2024-07-11 10:06:00'::timestamptz, '2024-07-11 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-11 10:06:00'::timestamptz); END IF;

  -- CC243
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC243', 'Yatzury Anderson', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 4, '', '2024-07-11 00:00:00'::timestamptz, '2024-07-11 00:00:00'::timestamptz, '2024-07-11 10:28:00'::timestamptz, '2024-07-11 10:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-07-11 10:28:00'::timestamptz); END IF;

  -- CC244
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC244', 'Guzmán', false, 'completed', false, 35.00, 0.00, 0, 2.45, 37.45, 14.00, 5, 1, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-12 14:10:00'::timestamptz, '2024-07-12 08:22:00'::timestamptz, '2024-07-12 08:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 37.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 37.45, '2024-07-12 08:22:00'::timestamptz); END IF;

  -- CC245
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC245', 'Yatzury Anderson', true, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 09:52:00'::timestamptz, '2024-07-12 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:52:00'::timestamptz); END IF;

  -- CC246
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC246', 'Yatzury Anderson', true, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 09:52:00'::timestamptz, '2024-07-12 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:52:00'::timestamptz); END IF;

  -- CC247
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC247', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 09:53:00'::timestamptz, '2024-07-12 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:53:00'::timestamptz); END IF;

  -- CC248
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC248', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 09:54:00'::timestamptz, '2024-07-12 09:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:54:00'::timestamptz); END IF;

  -- CC249
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC249', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 09:55:00'::timestamptz, '2024-07-12 09:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:55:00'::timestamptz); END IF;

  -- CC250
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC250', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:11:00'::timestamptz, '2024-07-12 09:57:00'::timestamptz, '2024-07-12 09:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:57:00'::timestamptz); END IF;

  -- CC251
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC251', 'Yatzury Anderson', false, 'completed', false, 1.88, 0.00, 0, 0.13, 2.01, 0.00, 0, 1, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 09:57:00'::timestamptz, '2024-07-12 09:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.01, '2024-07-12 09:57:00'::timestamptz); END IF;

  -- CC252
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC252', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 09:58:00'::timestamptz, '2024-07-12 09:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-12 09:58:00'::timestamptz); END IF;

  -- CC253
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC253', 'Yatzury Anderson', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 10:00:00'::timestamptz, '2024-07-12 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-12 10:00:00'::timestamptz); END IF;

  -- CC254
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC254', 'Maybelis Robinson', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, 'm', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 13:27:00'::timestamptz, '2024-07-12 10:00:00'::timestamptz, '2024-07-12 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-12 10:00:00'::timestamptz); END IF;

  -- CC255
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC255', 'Leonel Visueti', false, 'completed', false, 7.99, 0.01, 0, 0.56, 8.55, 0.00, 0, 1, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 10:01:00'::timestamptz, '2024-07-12 10:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.55 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.55, '2024-07-12 10:01:00'::timestamptz); END IF;

  -- CC256
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC256', 'Maybelis Robinson', false, 'completed', false, 21.25, 0.00, 0, 1.49, 22.74, 8.50, 1, 1, 'm', '2024-07-14 00:00:00'::timestamptz, '2024-07-12 12:10:00'::timestamptz, '2024-07-12 10:01:00'::timestamptz, '2024-07-12 10:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.74, '2024-07-12 10:01:00'::timestamptz); END IF;

  -- CC257
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC257', 'Cliente Lavandería', false, 'completed', false, 7.47, 0.05, 0, 0.52, 7.99, 0.00, 0, 4, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 12:11:00'::timestamptz, '2024-07-12 10:31:00'::timestamptz, '2024-07-12 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.99, '2024-07-12 10:31:00'::timestamptz); END IF;

  -- CC258
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC258', 'Leonardo Salon', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 13:26:00'::timestamptz, '2024-07-12 10:35:00'::timestamptz, '2024-07-12 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-12 10:35:00'::timestamptz); END IF;

  -- CC259
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC259', 'Yatzury Anderson', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 11:10:00'::timestamptz, '2024-07-12 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-12 11:10:00'::timestamptz); END IF;

  -- CC260
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC260', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 13:52:00'::timestamptz, '2024-07-12 12:21:00'::timestamptz, '2024-07-12 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-12 12:21:00'::timestamptz); END IF;

  -- CC261
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC261', 'Retail', true, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 12:22:00'::timestamptz, '2024-07-12 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-12 12:22:00'::timestamptz); END IF;

  -- CC262
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC262', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 12:57:00'::timestamptz, '2024-07-12 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-12 12:57:00'::timestamptz); END IF;

  -- CC263
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC263', 'Retail', true, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 14:24:00'::timestamptz, '2024-07-12 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-12 14:24:00'::timestamptz); END IF;

  -- CC264
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC264', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-13 11:08:00'::timestamptz, '2024-07-12 14:34:00'::timestamptz, '2024-07-12 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-12 14:34:00'::timestamptz); END IF;

  -- CC265
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC265', 'Leonel Visueti', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-12 15:38:00'::timestamptz, '2024-07-12 15:37:00'::timestamptz, '2024-07-12 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-12 15:37:00'::timestamptz); END IF;

  -- CC266
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC266', 'Yatzury Anderson', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 15:46:00'::timestamptz, '2024-07-12 15:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-12 15:46:00'::timestamptz); END IF;

  -- CC267
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC267', 'Yatzury Anderson', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-12 00:00:00'::timestamptz, '2024-07-12 00:00:00'::timestamptz, '2024-07-12 16:07:00'::timestamptz, '2024-07-12 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-12 16:07:00'::timestamptz); END IF;

  -- CC268
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC268', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-13 00:00:00'::timestamptz, '2024-07-13 11:06:00'::timestamptz, '2024-07-13 11:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-13 11:06:00'::timestamptz); END IF;

  -- CC269
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC269', 'Yatzury Anderson', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-13 00:00:00'::timestamptz, '2024-07-13 11:08:00'::timestamptz, '2024-07-13 11:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-13 11:08:00'::timestamptz); END IF;

  -- CC270
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC270', 'Cliente Lavandería', false, 'completed', false, 16.82, 0.46, 0, 1.18, 18.00, 0.00, 0, 12, 'Lavandería', '2024-07-14 00:00:00'::timestamptz, '2024-07-13 14:11:00'::timestamptz, '2024-07-13 11:57:00'::timestamptz, '2024-07-13 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-07-13 11:57:00'::timestamptz); END IF;

  -- CC271
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC271', 'Yatzury Anderson', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-13 14:28:00'::timestamptz, '2024-07-13 12:13:00'::timestamptz, '2024-07-13 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-13 12:13:00'::timestamptz); END IF;

  -- CC272
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC272', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-13 00:00:00'::timestamptz, '2024-07-13 14:28:00'::timestamptz, '2024-07-13 13:10:00'::timestamptz, '2024-07-13 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-13 13:10:00'::timestamptz); END IF;

  -- CC273
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC273', 'Leonel Visueti', false, 'completed', false, 20.56, 0.12, 0, 1.44, 22.00, 0.00, 0, 11, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-13 16:51:00'::timestamptz, '2024-07-13 14:59:00'::timestamptz, '2024-07-13 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2024-07-13 14:59:00'::timestamptz); END IF;

  -- CC274
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC274', 'Cliente Lavandería', false, 'completed', false, 8.41, 0.23, 0, 0.59, 9.00, 0.00, 0, 6, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-14 09:16:00'::timestamptz, '2024-07-13 15:49:00'::timestamptz, '2024-07-13 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-07-13 15:49:00'::timestamptz); END IF;

  -- CC275
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC275', 'Cliente Lavandería', false, 'completed', false, 6.54, 0.10, 0, 0.46, 7.00, 0.00, 0, 4, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-14 09:19:00'::timestamptz, '2024-07-13 15:53:00'::timestamptz, '2024-07-13 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-07-13 15:53:00'::timestamptz); END IF;

  -- CC276
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC276', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-14 09:16:00'::timestamptz, '2024-07-13 15:55:00'::timestamptz, '2024-07-13 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-13 15:55:00'::timestamptz); END IF;

  -- CC277
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC277', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 09:16:00'::timestamptz, '2024-07-13 16:08:00'::timestamptz, '2024-07-13 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-13 16:08:00'::timestamptz); END IF;

  -- CC278
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC278', 'Cliente Lavandería', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-13 00:00:00'::timestamptz, '2024-07-13 16:14:00'::timestamptz, '2024-07-13 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-13 16:14:00'::timestamptz); END IF;

  -- CC279
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC279', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-14 09:20:00'::timestamptz, '2024-07-13 16:21:00'::timestamptz, '2024-07-13 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-13 16:21:00'::timestamptz); END IF;

  -- CC280
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC280', 'Cliente Lavandería', false, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, 'Lavandería', '2024-07-13 00:00:00'::timestamptz, '2024-07-13 16:35:00'::timestamptz, '2024-07-13 16:31:00'::timestamptz, '2024-07-13 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-13 16:31:00'::timestamptz); END IF;

  -- CC281
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC281', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 00:00:00'::timestamptz, '2024-07-14 07:58:00'::timestamptz, '2024-07-14 07:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-14 07:58:00'::timestamptz); END IF;

  -- CC282
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC282', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 10:52:00'::timestamptz, '2024-07-14 09:16:00'::timestamptz, '2024-07-14 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-14 09:16:00'::timestamptz); END IF;

  -- CC283
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC283', 'Yatzury Anderson', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 00:00:00'::timestamptz, '2024-07-14 10:15:00'::timestamptz, '2024-07-14 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-14 10:15:00'::timestamptz); END IF;

  -- CC284
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC284', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-15 00:00:00'::timestamptz, '2024-07-14 11:37:00'::timestamptz, '2024-07-14 10:39:00'::timestamptz, '2024-07-14 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-14 10:39:00'::timestamptz); END IF;

  -- CC285
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC285', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 11:29:00'::timestamptz, '2024-07-14 10:43:00'::timestamptz, '2024-07-14 10:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-14 10:43:00'::timestamptz); END IF;

  -- CC286
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC286', 'Yatzury Anderson', false, 'completed', false, 9.35, 0.17, 0, 0.65, 10.00, 0.00, 0, 6, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 12:36:00'::timestamptz, '2024-07-14 10:48:00'::timestamptz, '2024-07-14 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-14 10:48:00'::timestamptz); END IF;

  -- CC287
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC287', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 12:36:00'::timestamptz, '2024-07-14 11:03:00'::timestamptz, '2024-07-14 11:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-14 11:03:00'::timestamptz); END IF;

  -- CC288
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC288', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-14 12:14:00'::timestamptz, '2024-07-14 11:18:00'::timestamptz, '2024-07-14 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-14 11:18:00'::timestamptz); END IF;

  -- CC289
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC289', 'Leonel Visueti', false, 'completed', false, 12.15, 0.13, 0, 0.85, 13.00, 0.00, 0, 7, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-14 14:47:00'::timestamptz, '2024-07-14 12:53:00'::timestamptz, '2024-07-14 12:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2024-07-14 12:53:00'::timestamptz); END IF;

  -- CC290
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC290', 'Leonel Visueti', false, 'completed', false, 4.67, 0.59, 0, 0.33, 5.00, 0.00, 0, 4, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 14:15:00'::timestamptz, '2024-07-14 13:04:00'::timestamptz, '2024-07-14 13:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-14 13:04:00'::timestamptz); END IF;

  -- CC291
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC291', 'Leonel Visueti', false, 'completed', false, 0.47, 0.03, 0, 0.03, 0.50, 0.00, 0, 1, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-14 13:30:00'::timestamptz, '2024-07-14 13:08:00'::timestamptz, '2024-07-14 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-14 13:08:00'::timestamptz); END IF;

  -- CC292
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC292', 'Leonel Visueti', false, 'completed', false, 14.95, 0.09, 0, 1.05, 16.00, 0.00, 0, 8, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 15:24:00'::timestamptz, '2024-07-14 13:55:00'::timestamptz, '2024-07-14 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-07-14 13:55:00'::timestamptz); END IF;

  -- CC293
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC293', 'Leonel Visueti', false, 'completed', false, 6.11, 0.03, 0, 0.39, 6.50, 0.00, 0, 4, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-15 11:01:00'::timestamptz, '2024-07-14 13:59:00'::timestamptz, '2024-07-14 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-07-14 13:59:00'::timestamptz); END IF;

  -- CC295
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC295', 'Leonel Visueti', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 00:00:00'::timestamptz, '2024-07-14 14:44:00'::timestamptz, '2024-07-14 14:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-14 14:44:00'::timestamptz); END IF;

  -- CC296
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC296', 'Yatzury Anderson', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-14 00:00:00'::timestamptz, '2024-07-14 00:00:00'::timestamptz, '2024-07-14 15:26:00'::timestamptz, '2024-07-14 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-14 15:26:00'::timestamptz); END IF;

  -- CC297
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC297', 'Leonel Visueti', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 00:00:00'::timestamptz, '2024-07-15 09:18:00'::timestamptz, '2024-07-15 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-07-15 09:18:00'::timestamptz); END IF;

  -- CC298
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC298', 'Yatzury Anderson', false, 'completed', false, 3.76, 0.00, 0, 0.26, 4.02, 0.00, 0, 2, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 13:01:00'::timestamptz, '2024-07-15 10:51:00'::timestamptz, '2024-07-15 10:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.02 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.02, '2024-07-15 10:51:00'::timestamptz); END IF;

  -- CC299
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC299', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 13:02:00'::timestamptz, '2024-07-15 10:52:00'::timestamptz, '2024-07-15 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-15 10:52:00'::timestamptz); END IF;

  -- CC300
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC300', 'Cliente Lavandería', false, 'completed', false, 2.37, 0.01, 0, 0.13, 2.50, 0.00, 0, 2, 'Lavandería', '2024-07-16 00:00:00'::timestamptz, '2024-07-15 13:01:00'::timestamptz, '2024-07-15 10:56:00'::timestamptz, '2024-07-15 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-07-15 10:56:00'::timestamptz); END IF;

  -- CC301
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC301', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 13:02:00'::timestamptz, '2024-07-15 11:36:00'::timestamptz, '2024-07-15 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-15 11:36:00'::timestamptz); END IF;

  -- CC302
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC302', 'Yatzury Anderson', false, 'completed', false, 9.35, 0.17, 0, 0.65, 10.00, 0.00, 0, 6, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 16:01:00'::timestamptz, '2024-07-15 13:26:00'::timestamptz, '2024-07-15 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-15 13:26:00'::timestamptz); END IF;

  -- CC303
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC303', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 16:49:00'::timestamptz, '2024-07-15 14:10:00'::timestamptz, '2024-07-15 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-15 14:10:00'::timestamptz); END IF;

  -- CC304
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC304', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-15 00:00:00'::timestamptz, '2024-07-15 16:49:00'::timestamptz, '2024-07-15 16:01:00'::timestamptz, '2024-07-15 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-15 16:01:00'::timestamptz); END IF;

  -- CC305
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC305', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:02:00'::timestamptz, '2024-07-16 11:16:00'::timestamptz, '2024-07-16 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-16 11:16:00'::timestamptz); END IF;

  -- CC306
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC306', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:02:00'::timestamptz, '2024-07-16 11:18:00'::timestamptz, '2024-07-16 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-16 11:18:00'::timestamptz); END IF;

  -- CC307
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC307', 'Yatzury Anderson', false, 'completed', false, 2.80, 0.08, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 13:05:00'::timestamptz, '2024-07-16 11:55:00'::timestamptz, '2024-07-16 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-07-16 11:55:00'::timestamptz); END IF;

  -- CC308
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC308', 'Leonel Visueti', false, 'completed', false, 9.35, 0.17, 0, 0.65, 10.00, 0.00, 0, 6, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 14:20:00'::timestamptz, '2024-07-16 12:15:00'::timestamptz, '2024-07-16 12:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-16 12:15:00'::timestamptz); END IF;

  -- CC309
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC309', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 13.00, 0.00, 0, 0.91, 13.91, 5.20, 1, 1, 'Salón', '2024-07-18 00:00:00'::timestamptz, '2024-07-16 15:59:00'::timestamptz, '2024-07-16 13:03:00'::timestamptz, '2024-07-16 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.91 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.91, '2024-07-16 13:03:00'::timestamptz); END IF;

  -- CC310
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC310', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 14:19:00'::timestamptz, '2024-07-16 13:31:00'::timestamptz, '2024-07-16 13:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-16 13:31:00'::timestamptz); END IF;

  -- CC311
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC311', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:00:00'::timestamptz, '2024-07-16 14:17:00'::timestamptz, '2024-07-16 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-16 14:17:00'::timestamptz); END IF;

  -- CC312
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC312', 'Leonel Visueti', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:02:00'::timestamptz, '2024-07-16 14:56:00'::timestamptz, '2024-07-16 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-16 14:56:00'::timestamptz); END IF;

  -- CC313
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC313', 'Yatzury Anderson', false, 'completed', false, 10.28, 0.24, 0, 0.72, 11.00, 0.00, 0, 7, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:33:00'::timestamptz, '2024-07-16 15:14:00'::timestamptz, '2024-07-16 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-07-16 15:14:00'::timestamptz); END IF;

  -- CC314
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC314', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:50:00'::timestamptz, '2024-07-16 16:06:00'::timestamptz, '2024-07-16 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-16 16:06:00'::timestamptz); END IF;

  -- CC315
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC315', 'Leonel Visueti', true, 'completed', false, 4.50, 0.00, 0, 0.00, 4.50, 0.00, 0, 8, '', '2024-07-16 00:00:00'::timestamptz, '2024-07-16 00:00:00'::timestamptz, '2024-07-16 16:41:00'::timestamptz, '2024-07-16 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-07-16 16:41:00'::timestamptz); END IF;

  -- CC316
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC316', 'Leonel Visueti', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 13:19:00'::timestamptz, '2024-07-17 11:05:00'::timestamptz, '2024-07-17 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-17 11:05:00'::timestamptz); END IF;

  -- CC317
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC317', 'Yatzury Anderson', false, 'completed', false, 14.95, 0.09, 0, 1.05, 16.00, 0.00, 0, 8, '', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 14:33:00'::timestamptz, '2024-07-17 11:33:00'::timestamptz, '2024-07-17 11:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-07-17 11:33:00'::timestamptz); END IF;

  -- CC318
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC318', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 14:33:00'::timestamptz, '2024-07-17 12:55:00'::timestamptz, '2024-07-17 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-17 12:55:00'::timestamptz); END IF;

  -- CC319
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC319', 'Yatzury Anderson', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, '', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 14:32:00'::timestamptz, '2024-07-17 13:20:00'::timestamptz, '2024-07-17 13:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-17 13:20:00'::timestamptz); END IF;

  -- CC320
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC320', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 17:03:00'::timestamptz, '2024-07-17 14:42:00'::timestamptz, '2024-07-17 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-17 14:42:00'::timestamptz); END IF;

  -- CC321
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC321', 'Cliente Lavandería', false, 'completed', false, 7.38, 0.00, 0, 0.52, 7.90, 2.95, 1, 1, 'Lavandería', '2024-07-17 00:00:00'::timestamptz, '2024-07-18 14:31:00'::timestamptz, '2024-07-17 15:18:00'::timestamptz, '2024-07-17 15:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.90 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.90, '2024-07-17 15:18:00'::timestamptz); END IF;

  -- CC322
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 17;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC322', 'Enrique Martínez', false, 'completed', false, 11.00, 0.00, 0, 0.77, 11.77, 4.40, 1, 1, '0', '2024-07-18 00:00:00'::timestamptz, '2024-07-18 14:31:00'::timestamptz, '2024-07-17 16:31:00'::timestamptz, '2024-07-17 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.77 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.77, '2024-07-17 16:31:00'::timestamptz); END IF;

  -- CC323
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC323', 'Leonel Visueti', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 6, '', '2024-07-17 00:00:00'::timestamptz, '2024-07-17 00:00:00'::timestamptz, '2024-07-17 16:56:00'::timestamptz, '2024-07-17 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-07-17 16:56:00'::timestamptz); END IF;

  -- CC324
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC324', 'Leonel Visueti', false, 'completed', false, 16.82, 0.10, 0, 1.18, 18.00, 0.00, 0, 9, '', '2024-07-18 00:00:00'::timestamptz, '2024-07-18 12:42:00'::timestamptz, '2024-07-18 10:57:00'::timestamptz, '2024-07-18 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-07-18 10:57:00'::timestamptz); END IF;

  -- CC325
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 14;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC325', 'Melissa VanSice', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-24 11:39:00'::timestamptz, '2024-07-18 11:11:00'::timestamptz, '2024-07-18 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-07-18 11:11:00'::timestamptz); END IF;

  -- CC326
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC326', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-18 00:00:00'::timestamptz, '2024-07-19 08:28:00'::timestamptz, '2024-07-18 13:17:00'::timestamptz, '2024-07-18 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-18 13:17:00'::timestamptz); END IF;

  -- CC327
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC327', 'Cliente Lavandería', false, 'completed', false, 11.22, 0.06, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2024-07-18 00:00:00'::timestamptz, '2024-07-18 16:05:00'::timestamptz, '2024-07-18 14:34:00'::timestamptz, '2024-07-18 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-07-18 14:34:00'::timestamptz); END IF;

  -- CC328
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC328', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 7, '', '2024-07-18 00:00:00'::timestamptz, '2024-07-18 00:00:00'::timestamptz, '2024-07-18 16:43:00'::timestamptz, '2024-07-18 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-07-18 16:43:00'::timestamptz); END IF;

  -- CC329
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC329', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 14:27:00'::timestamptz, '2024-07-19 08:34:00'::timestamptz, '2024-07-19 08:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-19 08:34:00'::timestamptz); END IF;

  -- CC330
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC330', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 10:30:00'::timestamptz, '2024-07-19 08:50:00'::timestamptz, '2024-07-19 08:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-19 08:50:00'::timestamptz); END IF;

  -- CC331
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC331', 'Leonardo Salon', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 13:55:00'::timestamptz, '2024-07-19 10:40:00'::timestamptz, '2024-07-19 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-19 10:40:00'::timestamptz); END IF;

  -- CC332
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC332', 'Guzmán', false, 'completed', false, 28.00, 0.00, 0, 1.96, 29.96, 11.20, 5, 1, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 13:53:00'::timestamptz, '2024-07-19 12:33:00'::timestamptz, '2024-07-19 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.96, '2024-07-19 12:33:00'::timestamptz); END IF;

  -- CC333
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC333', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 15:30:00'::timestamptz, '2024-07-19 13:36:00'::timestamptz, '2024-07-19 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-19 13:36:00'::timestamptz); END IF;

  -- CC334
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC334', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 17:00:00'::timestamptz, '2024-07-19 16:05:00'::timestamptz, '2024-07-19 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-19 16:05:00'::timestamptz); END IF;

  -- CC335
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC335', 'Yatzury Anderson', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 7, '', '2024-07-19 00:00:00'::timestamptz, '2024-07-19 00:00:00'::timestamptz, '2024-07-19 16:36:00'::timestamptz, '2024-07-19 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-07-19 16:36:00'::timestamptz); END IF;

  -- CC336
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC336', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-20 00:00:00'::timestamptz, '2024-07-20 13:03:00'::timestamptz, '2024-07-20 09:48:00'::timestamptz, '2024-07-20 09:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-20 09:48:00'::timestamptz); END IF;

  -- CC337
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC337', 'Gisselle', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-07-20 00:00:00'::timestamptz, '2024-07-20 15:34:00'::timestamptz, '2024-07-20 13:44:00'::timestamptz, '2024-07-20 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-20 13:44:00'::timestamptz); END IF;

  -- CC338
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 22;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC338', 'Tamara Collado', false, 'completed', false, 9.35, 0.17, 0, 0.65, 10.00, 0.00, 0, 6, '0', '2024-07-20 00:00:00'::timestamptz, '2024-07-21 10:29:00'::timestamptz, '2024-07-20 15:45:00'::timestamptz, '2024-07-20 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-20 15:45:00'::timestamptz); END IF;

  -- CC339
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 23;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC339', 'Raul', false, 'completed', false, 10.28, 0.12, 0, 0.72, 11.00, 0.00, 0, 6, '0', '2024-07-20 00:00:00'::timestamptz, '2024-07-21 10:29:00'::timestamptz, '2024-07-20 15:52:00'::timestamptz, '2024-07-20 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-07-20 15:52:00'::timestamptz); END IF;

  -- CC340
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 22;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC340', 'Tamara Collado', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-07-20 00:00:00'::timestamptz, '2024-07-21 10:28:00'::timestamptz, '2024-07-20 17:20:00'::timestamptz, '2024-07-20 17:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-20 17:20:00'::timestamptz); END IF;

  -- CC341
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC341', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 6, '', '2024-07-20 00:00:00'::timestamptz, '2024-07-20 00:00:00'::timestamptz, '2024-07-20 17:41:00'::timestamptz, '2024-07-20 17:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-07-20 17:41:00'::timestamptz); END IF;

  -- CC342
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC342', 'Yara Rangel', false, 'completed', false, 11.28, 0.00, 0, 0.79, 12.07, 0.00, 0, 6, '0', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 10:28:00'::timestamptz, '2024-07-21 08:50:00'::timestamptz, '2024-07-21 08:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.07, '2024-07-21 08:50:00'::timestamptz); END IF;

  -- CC343
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC343', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-22 00:00:00'::timestamptz, '2024-07-21 11:15:00'::timestamptz, '2024-07-21 10:05:00'::timestamptz, '2024-07-21 10:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-21 10:05:00'::timestamptz); END IF;

  -- CC344
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC344', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 12:02:00'::timestamptz, '2024-07-21 10:24:00'::timestamptz, '2024-07-21 10:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-21 10:24:00'::timestamptz); END IF;

  -- CC345
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC345', 'Leonel Visueti', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 13:01:00'::timestamptz, '2024-07-21 11:13:00'::timestamptz, '2024-07-21 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-21 11:13:00'::timestamptz); END IF;

  -- CC346
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC346', 'Cliente Lavandería', false, 'completed', false, 8.41, 0.23, 0, 0.59, 9.00, 0.00, 0, 6, 'Lavandería', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 13:08:00'::timestamptz, '2024-07-21 11:54:00'::timestamptz, '2024-07-21 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-07-21 11:54:00'::timestamptz); END IF;

  -- CC347
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC347', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-22 00:00:00'::timestamptz, '2024-07-21 13:11:00'::timestamptz, '2024-07-21 12:48:00'::timestamptz, '2024-07-21 12:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-21 12:48:00'::timestamptz); END IF;

  -- CC348
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC348', 'Blanca', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 15:31:00'::timestamptz, '2024-07-21 14:16:00'::timestamptz, '2024-07-21 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-21 14:16:00'::timestamptz); END IF;

  -- CC349
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC349', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 5, '', '2024-07-21 00:00:00'::timestamptz, '2024-07-21 00:00:00'::timestamptz, '2024-07-21 15:29:00'::timestamptz, '2024-07-21 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2024-07-21 15:29:00'::timestamptz); END IF;

  -- CC350
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC350', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-22 00:00:00'::timestamptz, '2024-07-22 15:32:00'::timestamptz, '2024-07-22 10:13:00'::timestamptz, '2024-07-22 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-22 10:13:00'::timestamptz); END IF;

  -- CC351
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC351', 'Sheila Simons', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-07-23 00:00:00'::timestamptz, '2024-07-22 15:32:00'::timestamptz, '2024-07-22 11:38:00'::timestamptz, '2024-07-22 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-22 11:38:00'::timestamptz); END IF;

  -- CC352
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC352', 'Sheila Simons', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-07-22 00:00:00'::timestamptz, '2024-07-22 15:32:00'::timestamptz, '2024-07-22 12:28:00'::timestamptz, '2024-07-22 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-22 12:28:00'::timestamptz); END IF;

  -- CC353
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC353', 'Leonel Visueti', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-07-22 00:00:00'::timestamptz, '2024-07-22 00:00:00'::timestamptz, '2024-07-22 16:44:00'::timestamptz, '2024-07-22 16:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-22 16:44:00'::timestamptz); END IF;

  -- CC354
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 29;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC354', 'Roy', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 13:11:00'::timestamptz, '2024-07-23 10:31:00'::timestamptz, '2024-07-23 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-23 10:31:00'::timestamptz); END IF;

  -- CC355
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC355', 'Yatzury Anderson', false, 'completed', false, 14.95, 0.09, 0, 1.05, 16.00, 0.00, 0, 8, '', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 14:07:00'::timestamptz, '2024-07-23 11:10:00'::timestamptz, '2024-07-23 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-07-23 11:10:00'::timestamptz); END IF;

  -- CC356
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 17;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC356', 'Enrique Martínez', false, 'completed', false, 17.50, 0.00, 0, 1.23, 18.73, 1.75, 1, 3, '0', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 14:11:00'::timestamptz, '2024-07-23 11:24:00'::timestamptz, '2024-07-23 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.73 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.73, '2024-07-23 11:24:00'::timestamptz); END IF;

  -- CC357
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 30;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC357', 'Guadalupe De Zabala', false, 'completed', false, 9.35, 0.17, 0, 0.65, 10.00, 0.00, 0, 6, '0', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 14:07:00'::timestamptz, '2024-07-23 11:59:00'::timestamptz, '2024-07-23 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-23 11:59:00'::timestamptz); END IF;

  -- CC358
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC358', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 8.13, 0.00, 0, 0.57, 8.70, 3.85, 1, 1, 'Salón', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 14:37:00'::timestamptz, '2024-07-23 13:10:00'::timestamptz, '2024-07-23 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.70, '2024-07-23 13:10:00'::timestamptz); END IF;

  -- CC359
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC359', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 14:07:00'::timestamptz, '2024-07-23 13:24:00'::timestamptz, '2024-07-23 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-23 13:24:00'::timestamptz); END IF;

  -- CC360
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC360', 'Leonel Visueti', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 16:18:00'::timestamptz, '2024-07-23 14:27:00'::timestamptz, '2024-07-23 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-23 14:27:00'::timestamptz); END IF;

  -- CC361
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC361', 'Leonel Visueti', false, 'completed', false, 1.87, 0.13, 0, 0.13, 2.00, 0.00, 0, 2, '', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 15:38:00'::timestamptz, '2024-07-23 15:07:00'::timestamptz, '2024-07-23 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-23 15:07:00'::timestamptz); END IF;

  -- CC362
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC362', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 17:22:00'::timestamptz, '2024-07-23 15:35:00'::timestamptz, '2024-07-23 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-23 15:35:00'::timestamptz); END IF;

  -- CC363
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC363', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-07-23 00:00:00'::timestamptz, '2024-07-23 00:00:00'::timestamptz, '2024-07-23 16:45:00'::timestamptz, '2024-07-23 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-07-23 16:45:00'::timestamptz); END IF;

  -- CC364
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC364', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-24 00:00:00'::timestamptz, '2024-07-24 16:19:00'::timestamptz, '2024-07-24 12:02:00'::timestamptz, '2024-07-24 12:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-24 12:02:00'::timestamptz); END IF;

  -- CC365
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC365', 'Leonel Visueti', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-07-24 00:00:00'::timestamptz, '2024-07-24 00:00:00'::timestamptz, '2024-07-24 16:59:00'::timestamptz, '2024-07-24 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-07-24 16:59:00'::timestamptz); END IF;

  -- CC366
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC366', 'Lineth', false, 'completed', false, 18.69, 0.11, 0, 1.31, 20.00, 0.00, 0, 10, '0', '2024-07-25 00:00:00'::timestamptz, '2024-07-25 13:04:00'::timestamptz, '2024-07-25 10:27:00'::timestamptz, '2024-07-25 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-07-25 10:27:00'::timestamptz); END IF;

  -- CC367
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC367', 'Lineth', false, 'completed', false, 13.08, 0.08, 0, 0.92, 14.00, 0.00, 0, 7, '0', '2024-07-25 00:00:00'::timestamptz, '2024-07-25 13:04:00'::timestamptz, '2024-07-25 11:16:00'::timestamptz, '2024-07-25 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2024-07-25 11:16:00'::timestamptz); END IF;

  -- CC368
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC368', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-07-25 00:00:00'::timestamptz, '2024-07-25 15:31:00'::timestamptz, '2024-07-25 12:38:00'::timestamptz, '2024-07-25 12:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-25 12:38:00'::timestamptz); END IF;

  -- CC369
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC369', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-07-25 00:00:00'::timestamptz, '2024-07-26 11:16:00'::timestamptz, '2024-07-25 13:03:00'::timestamptz, '2024-07-25 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-25 13:03:00'::timestamptz); END IF;

  -- CC370
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC370', 'Leonel Visueti', false, 'completed', false, 8.41, 0.11, 0, 0.59, 9.00, 0.00, 0, 5, '', '2024-07-26 00:00:00'::timestamptz, '2024-07-26 11:16:00'::timestamptz, '2024-07-25 15:28:00'::timestamptz, '2024-07-25 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-07-25 15:28:00'::timestamptz); END IF;

  -- CC371
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC371', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-07-25 00:00:00'::timestamptz, '2024-07-25 00:00:00'::timestamptz, '2024-07-25 16:31:00'::timestamptz, '2024-07-25 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-25 16:31:00'::timestamptz); END IF;

  -- CC372
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC372', 'Leonardo Salon', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-07-26 00:00:00'::timestamptz, '2024-07-26 13:33:00'::timestamptz, '2024-07-26 10:17:00'::timestamptz, '2024-07-26 10:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-26 10:17:00'::timestamptz); END IF;

  -- CC373
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC373', 'Leonel Visueti', false, 'completed', false, 11.22, 0.06, 0, 0.79, 12.01, 0.00, 0, 6, '', '2024-07-26 00:00:00'::timestamptz, '2024-07-26 13:34:00'::timestamptz, '2024-07-26 11:19:00'::timestamptz, '2024-07-26 11:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-07-26 11:19:00'::timestamptz); END IF;

  -- CC374
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC374', 'Guzmán', false, 'completed', false, 25.20, 0.00, 0, 1.76, 26.96, 12.60, 5, 1, '', '2024-07-26 00:00:00'::timestamptz, '2024-07-26 14:55:00'::timestamptz, '2024-07-26 11:49:00'::timestamptz, '2024-07-26 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.96, '2024-07-26 11:49:00'::timestamptz); END IF;

  -- CC375
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC375', 'Leonel Visueti', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-07-26 00:00:00'::timestamptz, '2024-07-26 00:00:00'::timestamptz, '2024-07-26 16:02:00'::timestamptz, '2024-07-26 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-07-26 16:02:00'::timestamptz); END IF;

  -- CC376
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC376', 'Yara Rangel', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 11:49:00'::timestamptz, '2024-07-27 08:51:00'::timestamptz, '2024-07-27 08:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-27 08:51:00'::timestamptz); END IF;

  -- CC377
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 32;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC377', 'Beyra', false, 'completed', false, 10.28, 0.12, 0, 0.72, 11.00, 0.00, 0, 6, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 14:04:00'::timestamptz, '2024-07-27 11:47:00'::timestamptz, '2024-07-27 11:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-07-27 11:47:00'::timestamptz); END IF;

  -- CC378
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC378', 'Fany Luz Salon', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 16:12:00'::timestamptz, '2024-07-27 12:12:00'::timestamptz, '2024-07-27 12:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-27 12:12:00'::timestamptz); END IF;

  -- CC379
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 23;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC379', 'Raul', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 15:24:00'::timestamptz, '2024-07-27 13:35:00'::timestamptz, '2024-07-27 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-27 13:35:00'::timestamptz); END IF;

  -- CC380
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC380', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 15:24:00'::timestamptz, '2024-07-27 13:55:00'::timestamptz, '2024-07-27 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-27 13:55:00'::timestamptz); END IF;

  -- CC381
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC381', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.11, 0.00, 0, 0.99, 15.10, 7.05, 2, 1, 'Salón', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 14:39:00'::timestamptz, '2024-07-27 14:06:00'::timestamptz, '2024-07-27 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.10, '2024-07-27 14:06:00'::timestamptz); END IF;

  -- CC382
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 23;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC382', 'Raul', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 15:24:00'::timestamptz, '2024-07-27 14:25:00'::timestamptz, '2024-07-27 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-27 14:25:00'::timestamptz); END IF;

  -- CC383
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC383', 'Rene Guiñez', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 16:56:00'::timestamptz, '2024-07-27 15:22:00'::timestamptz, '2024-07-27 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-27 15:22:00'::timestamptz); END IF;

  -- CC384
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC384', 'Sandra Medina', false, 'completed', false, 9.35, 0.05, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-07-28 00:00:00'::timestamptz, '2024-07-27 16:57:00'::timestamptz, '2024-07-27 15:51:00'::timestamptz, '2024-07-27 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-07-27 15:51:00'::timestamptz); END IF;

  -- CC385
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC385', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-07-27 00:00:00'::timestamptz, '2024-07-27 00:00:00'::timestamptz, '2024-07-27 16:25:00'::timestamptz, '2024-07-27 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-27 16:25:00'::timestamptz); END IF;

  -- CC386
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC386', 'Liliana', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 12:52:00'::timestamptz, '2024-07-28 09:37:00'::timestamptz, '2024-07-28 09:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-07-28 09:37:00'::timestamptz); END IF;

  -- CC387
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC387', 'Leonel Visueti', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 12:52:00'::timestamptz, '2024-07-28 12:03:00'::timestamptz, '2024-07-28 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-28 12:03:00'::timestamptz); END IF;

  -- CC388
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC388', 'Leonel Visueti', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 14:17:00'::timestamptz, '2024-07-28 12:54:00'::timestamptz, '2024-07-28 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-28 12:54:00'::timestamptz); END IF;

  -- CC389
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC389', 'Samuel Colinas', false, 'completed', false, 5.50, 0.00, 0, 0.39, 5.89, 1.90, 1, 1, '0', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 14:51:00'::timestamptz, '2024-07-28 14:16:00'::timestamptz, '2024-07-28 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.89 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.89, '2024-07-28 14:16:00'::timestamptz); END IF;

  -- CC390
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC390', 'Leonel Visueti', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 00:00:00'::timestamptz, '2024-07-28 14:29:00'::timestamptz, '2024-07-28 14:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-07-28 14:29:00'::timestamptz); END IF;

  -- CC391
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC391', 'Daniel Camarena', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-07-28 00:00:00'::timestamptz, '2024-07-29 10:08:00'::timestamptz, '2024-07-28 14:50:00'::timestamptz, '2024-07-28 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-28 14:50:00'::timestamptz); END IF;

  -- CC392
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC392', 'Leonel Visueti', false, 'completed', false, 6.54, 0.10, 0, 0.46, 7.00, 0.00, 0, 4, '', '2024-07-28 00:00:00'::timestamptz, '2024-07-29 10:08:00'::timestamptz, '2024-07-28 14:55:00'::timestamptz, '2024-07-28 14:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-07-28 14:55:00'::timestamptz); END IF;

  -- CC393
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC393', 'Leonel Visueti', true, 'completed', false, 4.86, 0.14, 0, 0.14, 5.00, 0.00, 0, 8, '', '2024-07-28 00:00:00'::timestamptz, '2024-07-28 00:00:00'::timestamptz, '2024-07-28 15:54:00'::timestamptz, '2024-07-28 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-28 15:54:00'::timestamptz); END IF;

  -- CC394
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC394', 'Leonel Visueti', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-29 00:00:00'::timestamptz, '2024-07-29 12:55:00'::timestamptz, '2024-07-29 10:04:00'::timestamptz, '2024-07-29 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-29 10:04:00'::timestamptz); END IF;

  -- CC395
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC395', 'Leonel Visueti', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-29 00:00:00'::timestamptz, '2024-07-29 14:28:00'::timestamptz, '2024-07-29 12:52:00'::timestamptz, '2024-07-29 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-29 12:52:00'::timestamptz); END IF;

  -- CC396
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC396', 'Leonel Visueti', false, 'completed', false, 4.67, 0.09, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-07-29 00:00:00'::timestamptz, '2024-07-29 16:54:00'::timestamptz, '2024-07-29 15:31:00'::timestamptz, '2024-07-29 15:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-07-29 15:31:00'::timestamptz); END IF;

  -- CC397
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC397', 'Leonel Visueti', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-07-29 00:00:00'::timestamptz, '2024-07-29 00:00:00'::timestamptz, '2024-07-29 16:25:00'::timestamptz, '2024-07-29 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-29 16:25:00'::timestamptz); END IF;

  -- CC398
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC398', 'Leonel Visueti', false, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 2, '', '2024-07-30 00:00:00'::timestamptz, '2024-07-30 10:14:00'::timestamptz, '2024-07-30 10:13:00'::timestamptz, '2024-07-30 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-30 10:13:00'::timestamptz); END IF;

  -- CC399
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC399', 'Blanca', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-07-30 00:00:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz, '2024-07-30 12:56:00'::timestamptz, '2024-07-30 12:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-30 12:56:00'::timestamptz); END IF;

  -- CC400
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC400', 'Leonel Visueti', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-30 00:00:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz, '2024-07-30 13:27:00'::timestamptz, '2024-07-30 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-30 13:27:00'::timestamptz); END IF;

  -- CC401
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC401', 'Yatzury Anderson', false, 'completed', false, 1.88, 0.00, 0, 0.13, 2.01, 0.00, 0, 1, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz, '2024-07-30 13:31:00'::timestamptz, '2024-07-30 13:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.01, '2024-07-30 13:31:00'::timestamptz); END IF;

  -- CC402
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC402', 'Cliente Lavandería', false, 'completed', false, 3.76, 0.00, 0, 0.26, 4.02, 0.00, 0, 2, 'Lavandería', '2024-07-31 00:00:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz, '2024-07-30 13:31:00'::timestamptz, '2024-07-30 13:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.02 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.02, '2024-07-30 13:31:00'::timestamptz); END IF;

  -- CC403
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC403', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-07-30 00:00:00'::timestamptz, '2024-07-30 00:00:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz, '2024-07-30 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-07-30 16:32:00'::timestamptz); END IF;

  -- CC404
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC404', 'Leonel Visueti', false, 'completed', false, 7.48, 0.04, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 12:50:00'::timestamptz, '2024-07-31 10:46:00'::timestamptz, '2024-07-31 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-07-31 10:46:00'::timestamptz); END IF;

  -- CC405
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC405', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 12:50:00'::timestamptz, '2024-07-31 11:38:00'::timestamptz, '2024-07-31 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-31 11:38:00'::timestamptz); END IF;

  -- CC406
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC406', 'Cliente Lavandería', false, 'completed', false, 11.22, 0.06, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 14:08:00'::timestamptz, '2024-07-31 12:13:00'::timestamptz, '2024-07-31 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-07-31 12:13:00'::timestamptz); END IF;

  -- CC407
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC407', 'Yatzury Anderson', false, 'completed', false, 9.85, 0.05, 0, 0.65, 10.50, 0.00, 0, 6, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 14:08:00'::timestamptz, '2024-07-31 13:06:00'::timestamptz, '2024-07-31 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-07-31 13:06:00'::timestamptz); END IF;

  -- CC408
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC408', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 14:41:00'::timestamptz, '2024-07-31 13:55:00'::timestamptz, '2024-07-31 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-31 13:55:00'::timestamptz); END IF;

  -- CC409
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC409', 'Leonel Visueti', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 16:49:00'::timestamptz, '2024-07-31 14:02:00'::timestamptz, '2024-07-31 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-31 14:02:00'::timestamptz); END IF;

  -- CC410
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC410', 'Cliente Lavandería', false, 'completed', false, 8.41, 0.11, 0, 0.59, 9.00, 0.00, 0, 5, 'Lavandería', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 15:38:00'::timestamptz, '2024-07-31 14:10:00'::timestamptz, '2024-07-31 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-07-31 14:10:00'::timestamptz); END IF;

  -- CC411
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC411', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 12.90, 0.00, 0, 0.90, 13.80, 6.45, 2, 1, 'Salón', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 15:17:00'::timestamptz, '2024-07-31 14:13:00'::timestamptz, '2024-07-31 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.80 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.80, '2024-07-31 14:13:00'::timestamptz); END IF;

  -- CC412
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 36;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC412', 'Waldo Juarez', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 16:49:00'::timestamptz, '2024-07-31 14:27:00'::timestamptz, '2024-07-31 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-31 14:27:00'::timestamptz); END IF;

  -- CC413
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC413', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 15:37:00'::timestamptz, '2024-07-31 14:56:00'::timestamptz, '2024-07-31 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-31 14:56:00'::timestamptz); END IF;

  -- CC414
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC414', 'Yatzury Anderson', false, 'completed', false, 4.55, 0.08, 0, 0.20, 4.75, 0.00, 0, 5, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 16:49:00'::timestamptz, '2024-07-31 15:56:00'::timestamptz, '2024-07-31 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.75, '2024-07-31 15:56:00'::timestamptz); END IF;

  -- CC415
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 36;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC415', 'Waldo Juarez', false, 'completed', false, 1.87, 0.01, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 16:49:00'::timestamptz, '2024-07-31 15:57:00'::timestamptz, '2024-07-31 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-07-31 15:57:00'::timestamptz); END IF;

  -- CC416
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC416', 'Retail', true, 'completed', false, 5.70, 0.30, 0, 0.30, 6.00, 0.00, 0, 11, '', '2024-07-31 00:00:00'::timestamptz, '2024-07-31 00:00:00'::timestamptz, '2024-07-31 16:48:00'::timestamptz, '2024-07-31 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-07-31 16:48:00'::timestamptz); END IF;

  -- CC417
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC417', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.03, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 14:46:00'::timestamptz, '2024-08-01 10:12:00'::timestamptz, '2024-08-01 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-01 10:12:00'::timestamptz); END IF;

  -- CC419
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC419', 'Leonel Visueti', false, 'completed', false, 3.74, 0.02, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 14:46:00'::timestamptz, '2024-08-01 11:32:00'::timestamptz, '2024-08-01 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-01 11:32:00'::timestamptz); END IF;

  -- CC420
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC420', 'Retail', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, '', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 00:00:00'::timestamptz, '2024-08-01 11:40:00'::timestamptz, '2024-08-01 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-01 11:40:00'::timestamptz); END IF;

  -- CC421
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC421', 'Cliente Lavandería', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 14:46:00'::timestamptz, '2024-08-01 13:08:00'::timestamptz, '2024-08-01 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-01 13:08:00'::timestamptz); END IF;

  -- CC422
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC422', 'Cliente Lavandería', false, 'completed', false, 10.00, 0.00, 0, 0.00, 10.00, 0.00, 0, 5, 'Lavandería', '2024-08-02 00:00:00'::timestamptz, '2024-08-01 17:06:00'::timestamptz, '2024-08-01 15:23:00'::timestamptz, '2024-08-01 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-01 15:23:00'::timestamptz); END IF;

  -- CC423
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC423', 'Leonel Visueti', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 00:00:00'::timestamptz, '2024-08-01 16:18:00'::timestamptz, '2024-08-01 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-01 16:18:00'::timestamptz); END IF;

  -- CC424
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 32;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC424', 'Beyra', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-02 00:00:00'::timestamptz, '2024-08-02 09:38:00'::timestamptz, '2024-08-01 16:43:00'::timestamptz, '2024-08-01 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-01 16:43:00'::timestamptz); END IF;

  -- CC425
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC425', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-08-01 00:00:00'::timestamptz, '2024-08-01 00:00:00'::timestamptz, '2024-08-01 16:43:00'::timestamptz, '2024-08-01 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-01 16:43:00'::timestamptz); END IF;

  -- CC426
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC426', 'Leonardo Salon', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'leonardo', '2024-08-02 00:00:00'::timestamptz, '2024-08-02 14:24:00'::timestamptz, '2024-08-02 09:35:00'::timestamptz, '2024-08-02 09:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-02 09:35:00'::timestamptz); END IF;

  -- CC427
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC427', 'Guzmán', false, 'completed', false, 16.80, 0.00, 0, 1.18, 17.98, 8.40, 3, 1, '', '2024-08-02 00:00:00'::timestamptz, '2024-08-02 14:15:00'::timestamptz, '2024-08-02 12:23:00'::timestamptz, '2024-08-02 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.98, '2024-08-02 12:23:00'::timestamptz); END IF;

  -- CC428
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC428', 'Cliente Lavandería', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-02 00:00:00'::timestamptz, '2024-08-02 14:25:00'::timestamptz, '2024-08-02 13:08:00'::timestamptz, '2024-08-02 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-02 13:08:00'::timestamptz); END IF;

  -- CC429
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC429', 'Fany Luz Salon', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-02 00:00:00'::timestamptz, '2024-08-03 12:29:00'::timestamptz, '2024-08-02 13:23:00'::timestamptz, '2024-08-02 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-02 13:23:00'::timestamptz); END IF;

  -- CC430
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC430', 'Leonel Visueti', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-08-02 00:00:00'::timestamptz, '2024-08-02 00:00:00'::timestamptz, '2024-08-02 16:38:00'::timestamptz, '2024-08-02 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-02 16:38:00'::timestamptz); END IF;

  -- CC431
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 38;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC431', 'Fara Montero', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 12:29:00'::timestamptz, '2024-08-03 10:45:00'::timestamptz, '2024-08-03 10:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-03 10:45:00'::timestamptz); END IF;

  -- CC432
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 39;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC432', 'Augusto Peralta', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 12:29:00'::timestamptz, '2024-08-03 11:42:00'::timestamptz, '2024-08-03 11:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-03 11:42:00'::timestamptz); END IF;

  -- CC433
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC433', 'Cliente Lavandería', false, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 2, 'Lavandería', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 12:29:00'::timestamptz, '2024-08-03 11:45:00'::timestamptz, '2024-08-03 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-03 11:45:00'::timestamptz); END IF;

  -- CC434
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC434', 'Claudia Londoño', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, 'Lavandería', '2024-08-04 00:00:00'::timestamptz, '2024-08-03 15:36:00'::timestamptz, '2024-08-03 12:52:00'::timestamptz, '2024-08-03 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-03 12:52:00'::timestamptz); END IF;

  -- CC435
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC435', 'Blanca', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 15:36:00'::timestamptz, '2024-08-03 13:34:00'::timestamptz, '2024-08-03 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-03 13:34:00'::timestamptz); END IF;

  -- CC436
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 35;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC436', 'Yamileth Rodriguez', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-04 10:09:00'::timestamptz, '2024-08-03 13:59:00'::timestamptz, '2024-08-03 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-03 13:59:00'::timestamptz); END IF;

  -- CC437
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC437', 'Claudia Londoño', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-04 00:00:00'::timestamptz, '2024-08-03 15:36:00'::timestamptz, '2024-08-03 14:07:00'::timestamptz, '2024-08-03 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-03 14:07:00'::timestamptz); END IF;

  -- CC438
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 35;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC438', 'Yamileth Rodriguez', true, 'completed', false, 1.87, 0.13, 0, 0.13, 2.00, 0.00, 0, 2, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 00:00:00'::timestamptz, '2024-08-03 14:09:00'::timestamptz, '2024-08-03 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-03 14:09:00'::timestamptz); END IF;

  -- CC439
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 42;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC439', 'Milagros Aranda', false, 'completed', false, 5.25, 0.00, 0, 0.00, 5.25, 0.00, 0, 3, '0', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 10:09:00'::timestamptz, '2024-08-03 15:10:00'::timestamptz, '2024-08-03 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2024-08-03 15:10:00'::timestamptz); END IF;

  -- CC440
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 43;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC440', 'Elena Molina', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-03 00:00:00'::timestamptz, '2024-08-04 10:09:00'::timestamptz, '2024-08-03 15:35:00'::timestamptz, '2024-08-03 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-03 15:35:00'::timestamptz); END IF;

  -- CC441
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC441', 'Fernando Ortega', false, 'completed', false, 17.60, 0.00, 0, 0.95, 18.55, 4.80, 1, 4, '', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 08:31:00'::timestamptz, '2024-08-03 16:04:00'::timestamptz, '2024-08-03 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.55 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.55, '2024-08-03 16:04:00'::timestamptz); END IF;

  -- CC442
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC442', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-08-03 00:00:00'::timestamptz, '2024-08-03 00:00:00'::timestamptz, '2024-08-03 17:04:00'::timestamptz, '2024-08-03 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-03 17:04:00'::timestamptz); END IF;

  -- CC443
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 44;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC443', 'Marcelina Rodriguez', false, 'completed', false, 8.79, 0.21, 0, 0.21, 9.00, 0.00, 0, 6, '0', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 10:09:00'::timestamptz, '2024-08-04 08:53:00'::timestamptz, '2024-08-04 08:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-08-04 08:53:00'::timestamptz); END IF;

  -- CC444
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 45;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC444', 'Lisseth Chorchy', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 11:25:00'::timestamptz, '2024-08-04 09:19:00'::timestamptz, '2024-08-04 09:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-04 09:19:00'::timestamptz); END IF;

  -- CC445
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC445', 'Samuel Colinas', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, '0', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 12:24:00'::timestamptz, '2024-08-04 10:23:00'::timestamptz, '2024-08-04 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-04 10:23:00'::timestamptz); END IF;

  -- CC446
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC446', 'Liliana', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-08-05 00:00:00'::timestamptz, '2024-08-04 11:26:00'::timestamptz, '2024-08-04 10:26:00'::timestamptz, '2024-08-04 10:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-04 10:26:00'::timestamptz); END IF;

  -- CC447
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC447', 'Gisselle', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-05 00:00:00'::timestamptz, '2024-08-04 15:28:00'::timestamptz, '2024-08-04 11:14:00'::timestamptz, '2024-08-04 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-04 11:14:00'::timestamptz); END IF;

  -- CC448
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 46;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC448', 'Jan', false, 'completed', false, 5.00, 0.00, 0, 0.07, 5.07, 0.00, 0, 3, '0', '2024-08-05 00:00:00'::timestamptz, '2024-08-04 15:28:00'::timestamptz, '2024-08-04 11:58:00'::timestamptz, '2024-08-04 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.07, '2024-08-04 11:58:00'::timestamptz); END IF;

  -- CC449
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC449', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-04 00:00:00'::timestamptz, '2024-08-04 00:00:00'::timestamptz, '2024-08-04 15:30:00'::timestamptz, '2024-08-04 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-04 15:30:00'::timestamptz); END IF;

  -- CC450
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC450', 'Cliente Lavandería', false, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 2, 'Lavandería', '2024-08-05 00:00:00'::timestamptz, '2024-08-05 13:56:00'::timestamptz, '2024-08-05 10:43:00'::timestamptz, '2024-08-05 10:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-05 10:43:00'::timestamptz); END IF;

  -- CC451
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC451', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 3, '', '2024-08-05 00:00:00'::timestamptz, '2024-08-05 00:00:00'::timestamptz, '2024-08-05 12:29:00'::timestamptz, '2024-08-05 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-05 12:29:00'::timestamptz); END IF;

  -- CC452
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC452', 'Leonel Visueti', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '', '2024-08-05 00:00:00'::timestamptz, '2024-08-05 15:45:00'::timestamptz, '2024-08-05 13:53:00'::timestamptz, '2024-08-05 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-05 13:53:00'::timestamptz); END IF;

  -- CC453
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC453', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-08-05 00:00:00'::timestamptz, '2024-08-05 00:00:00'::timestamptz, '2024-08-05 13:57:00'::timestamptz, '2024-08-05 13:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-08-05 13:57:00'::timestamptz); END IF;

  -- CC454
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC454', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-05 00:00:00'::timestamptz, '2024-08-05 00:00:00'::timestamptz, '2024-08-05 15:45:00'::timestamptz, '2024-08-05 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-05 15:45:00'::timestamptz); END IF;

  -- CC455
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC455', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 11.20, 0.00, 0, 0.78, 11.98, 5.60, 1, 1, 'Salón', '2024-08-06 00:00:00'::timestamptz, '2024-08-06 12:08:00'::timestamptz, '2024-08-06 11:35:00'::timestamptz, '2024-08-06 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.98, '2024-08-06 11:35:00'::timestamptz); END IF;

  -- CC456
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC456', 'Yatzury Anderson', false, 'completed', false, 2.15, 0.00, 0, 0.15, 2.30, 0.00, 0, 2, '', '2024-08-06 00:00:00'::timestamptz, '2024-08-06 16:53:00'::timestamptz, '2024-08-06 12:20:00'::timestamptz, '2024-08-06 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.30, '2024-08-06 12:20:00'::timestamptz); END IF;

  -- CC457
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC457', 'Leonel Visueti', false, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 4, '', '2024-08-06 00:00:00'::timestamptz, '2024-08-06 16:53:00'::timestamptz, '2024-08-06 13:59:00'::timestamptz, '2024-08-06 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-08-06 13:59:00'::timestamptz); END IF;

  -- CC458
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC458', 'Rene Guiñez', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '0', '2024-08-06 00:00:00'::timestamptz, '2024-08-06 16:53:00'::timestamptz, '2024-08-06 15:23:00'::timestamptz, '2024-08-06 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-06 15:23:00'::timestamptz); END IF;

  -- CC459
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC459', 'Cliente Lavandería', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, 'Lavandería', '2024-08-06 00:00:00'::timestamptz, '2024-08-07 09:24:00'::timestamptz, '2024-08-06 15:38:00'::timestamptz, '2024-08-06 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-06 15:38:00'::timestamptz); END IF;

  -- CC460
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 47;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC460', 'Filtros Carossi, S.A', false, 'completed', false, 20.00, 0.00, 0, 0.00, 20.00, 0.00, 0, 10, '0', '2024-08-06 00:00:00'::timestamptz, '2024-08-07 09:24:00'::timestamptz, '2024-08-06 16:13:00'::timestamptz, '2024-08-06 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-08-06 16:13:00'::timestamptz); END IF;

  -- CC461
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC461', 'Evelyn', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, 'Salón', '2024-08-06 00:00:00'::timestamptz, '2024-08-07 09:24:00'::timestamptz, '2024-08-06 16:28:00'::timestamptz, '2024-08-06 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-06 16:28:00'::timestamptz); END IF;

  -- CC462
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC462', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 5, '', '2024-08-06 00:00:00'::timestamptz, '2024-08-06 00:00:00'::timestamptz, '2024-08-06 17:54:00'::timestamptz, '2024-08-06 17:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-06 17:54:00'::timestamptz); END IF;

  -- CC463
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 49;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC463', 'Doris Torres', false, 'completed', false, 6.38, 0.00, 0, 0.45, 6.83, 3.15, 2, 1, '0', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 14:59:00'::timestamptz, '2024-08-07 08:56:00'::timestamptz, '2024-08-07 08:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.83 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.83, '2024-08-07 08:56:00'::timestamptz); END IF;

  -- CC464
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC464', 'Tairis - Diego', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 10:23:00'::timestamptz, '2024-08-07 09:38:00'::timestamptz, '2024-08-07 09:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-07 09:38:00'::timestamptz); END IF;

  -- CC465
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 51;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC465', 'Judy De Morales', false, 'completed', false, 10.47, 0.03, 0, 0.03, 10.50, 0.00, 0, 6, 'Lavandería', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 12:07:00'::timestamptz, '2024-08-07 10:14:00'::timestamptz, '2024-08-07 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-08-07 10:14:00'::timestamptz); END IF;

  -- CC466
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 51;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC466', 'Judy De Morales', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 12:14:00'::timestamptz, '2024-08-07 11:19:00'::timestamptz, '2024-08-07 11:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-07 11:19:00'::timestamptz); END IF;

  -- CC467
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 51;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC467', 'Judy De Morales', false, 'completed', false, 0.61, 0.04, 0, 0.04, 0.65, 0.00, 0, 2, 'Lavandería', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 12:13:00'::timestamptz, '2024-08-07 11:58:00'::timestamptz, '2024-08-07 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.65, '2024-08-07 11:58:00'::timestamptz); END IF;

  -- CC468
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC468', 'Aaron Gutierrez', false, 'completed', false, 10.00, 0.00, 0, 0.00, 10.00, 0.00, 0, 5, 'Lavandería', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 14:59:00'::timestamptz, '2024-08-07 12:50:00'::timestamptz, '2024-08-07 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-07 12:50:00'::timestamptz); END IF;

  -- CC469
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 53;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC469', 'Miguel', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 15:05:00'::timestamptz, '2024-08-07 13:45:00'::timestamptz, '2024-08-07 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-07 13:45:00'::timestamptz); END IF;

  -- CC470
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC470', 'Miguel Arauz', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-07 00:00:00'::timestamptz, '2024-08-08 13:38:00'::timestamptz, '2024-08-07 14:25:00'::timestamptz, '2024-08-07 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-07 14:25:00'::timestamptz); END IF;

  -- CC471
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC471', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-08-07 00:00:00'::timestamptz, '2024-08-07 00:00:00'::timestamptz, '2024-08-07 16:37:00'::timestamptz, '2024-08-07 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-07 16:37:00'::timestamptz); END IF;

  -- CC472
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC472', 'Cliente Lavandería', false, 'completed', false, 1.54, 0.11, 0, 0.11, 1.65, 0.00, 0, 4, 'Lavandería', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 13:38:00'::timestamptz, '2024-08-08 13:35:00'::timestamptz, '2024-08-08 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.65, '2024-08-08 13:35:00'::timestamptz); END IF;

  -- CC473
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 36;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC473', 'Waldo Juarez', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-08 00:00:00'::timestamptz, '2024-08-09 11:35:00'::timestamptz, '2024-08-08 13:36:00'::timestamptz, '2024-08-08 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-08 13:36:00'::timestamptz); END IF;

  -- CC474
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC474', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 00:00:00'::timestamptz, '2024-08-08 14:15:00'::timestamptz, '2024-08-08 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-08 14:15:00'::timestamptz); END IF;

  -- CC475
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC475', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 00:00:00'::timestamptz, '2024-08-08 14:27:00'::timestamptz, '2024-08-08 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-08-08 14:27:00'::timestamptz); END IF;

  -- CC476
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 36;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC476', 'Waldo Juarez', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '0', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 00:00:00'::timestamptz, '2024-08-08 14:38:00'::timestamptz, '2024-08-08 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-08-08 14:38:00'::timestamptz); END IF;

  -- CC477
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC477', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 00:00:00'::timestamptz, '2024-08-08 16:40:00'::timestamptz, '2024-08-08 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-08 16:40:00'::timestamptz); END IF;

  -- CC478
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC478', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-08-08 00:00:00'::timestamptz, '2024-08-08 00:00:00'::timestamptz, '2024-08-08 16:42:00'::timestamptz, '2024-08-08 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-08-08 16:42:00'::timestamptz); END IF;

  -- CC485
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC485', 'Cliente Lavandería', false, 'completed', false, 8.47, 0.03, 0, 0.03, 8.50, 0.00, 0, 5, 'Lavandería', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 11:35:00'::timestamptz, '2024-08-09 09:34:00'::timestamptz, '2024-08-09 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-08-09 09:34:00'::timestamptz); END IF;

  -- CC486
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC486', 'Fany Luz Salon', false, 'completed', false, 5.40, 0.10, 0, 0.10, 5.50, 0.00, 0, 5, '0', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 12:54:00'::timestamptz, '2024-08-09 09:39:00'::timestamptz, '2024-08-09 09:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-08-09 09:39:00'::timestamptz); END IF;

  -- CC487
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC487', 'Leonardo Salon', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, 'leonardo', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 17:00:00'::timestamptz, '2024-08-09 11:27:00'::timestamptz, '2024-08-09 11:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-09 11:27:00'::timestamptz); END IF;

  -- CC488
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC488', 'Cliente Lavandería', false, 'completed', false, 0.47, 0.03, 0, 0.03, 0.50, 0.00, 0, 1, 'Lavandería', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 11:35:00'::timestamptz, '2024-08-09 11:31:00'::timestamptz, '2024-08-09 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-08-09 11:31:00'::timestamptz); END IF;

  -- CC489
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC489', 'Guzmán', false, 'completed', false, 14.40, 0.00, 0, 1.01, 15.41, 7.20, 3, 1, '', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 14:42:00'::timestamptz, '2024-08-09 13:00:00'::timestamptz, '2024-08-09 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.41 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.41, '2024-08-09 13:00:00'::timestamptz); END IF;

  -- CC490
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC490', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-08-09 00:00:00'::timestamptz, '2024-08-09 00:00:00'::timestamptz, '2024-08-09 16:18:00'::timestamptz, '2024-08-09 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-09 16:18:00'::timestamptz); END IF;

  -- CC491
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 55;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC491', 'Jorge', false, 'completed', false, 10.50, 0.00, 0, 0.74, 11.24, 0.00, 0, 2, '', '2024-08-10 00:00:00'::timestamptz, '2024-08-11 15:00:00'::timestamptz, '2024-08-10 09:09:00'::timestamptz, '2024-08-10 09:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.24 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.24, '2024-08-10 09:09:00'::timestamptz); END IF;

  -- CC492
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC492', 'Liliana Zambrano', false, 'completed', false, 7.86, 0.14, 0, 0.14, 8.00, 0.00, 0, 5, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-11 10:24:00'::timestamptz, '2024-08-10 09:24:00'::timestamptz, '2024-08-10 09:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-10 09:24:00'::timestamptz); END IF;

  -- CC493
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 40;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC493', 'Erlyn', false, 'completed', false, 21.66, 0.34, 0, 0.34, 22.00, 0.00, 0, 14, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 14:07:00'::timestamptz, '2024-08-10 10:23:00'::timestamptz, '2024-08-10 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2024-08-10 10:23:00'::timestamptz); END IF;

  -- CC494
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC494', 'Cliente Lavandería', false, 'completed', false, 2.34, 0.16, 0, 0.16, 2.50, 0.00, 0, 2, 'Lavandería', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 14:06:00'::timestamptz, '2024-08-10 11:15:00'::timestamptz, '2024-08-10 11:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-10 11:15:00'::timestamptz); END IF;

  -- CC495
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC495', 'Gisselle', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 16:09:00'::timestamptz, '2024-08-10 13:06:00'::timestamptz, '2024-08-10 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-10 13:06:00'::timestamptz); END IF;

  -- CC496
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC496', 'Gisselle', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 00:00:00'::timestamptz, '2024-08-10 13:12:00'::timestamptz, '2024-08-10 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-10 13:12:00'::timestamptz); END IF;

  -- CC497
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 57;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC497', 'Williams', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 14:06:00'::timestamptz, '2024-08-10 13:24:00'::timestamptz, '2024-08-10 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-10 13:24:00'::timestamptz); END IF;

  -- CC498
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC498', 'Yara Rangel', false, 'completed', false, 12.66, 0.34, 0, 0.34, 13.00, 0.00, 0, 9, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-11 10:24:00'::timestamptz, '2024-08-10 13:42:00'::timestamptz, '2024-08-10 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2024-08-10 13:42:00'::timestamptz); END IF;

  -- CC499
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC499', 'Yara Rangel', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 14:47:00'::timestamptz, '2024-08-10 14:24:00'::timestamptz, '2024-08-10 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-10 14:24:00'::timestamptz); END IF;

  -- CC500
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC500', 'Blanca', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-10 00:00:00'::timestamptz, '2024-08-11 10:24:00'::timestamptz, '2024-08-10 16:08:00'::timestamptz, '2024-08-10 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-10 16:08:00'::timestamptz); END IF;

  -- CC501
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC501', 'Retail', true, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 11, '', '2024-08-10 00:00:00'::timestamptz, '2024-08-10 00:00:00'::timestamptz, '2024-08-10 16:28:00'::timestamptz, '2024-08-10 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-10 16:28:00'::timestamptz); END IF;

  -- CC502
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC502', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 3, '', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 10:24:00'::timestamptz, '2024-08-11 09:18:00'::timestamptz, '2024-08-11 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-11 09:18:00'::timestamptz); END IF;

  -- CC503
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC503', 'Cliente Lavandería', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 10:53:00'::timestamptz, '2024-08-11 09:28:00'::timestamptz, '2024-08-11 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-11 09:28:00'::timestamptz); END IF;

  -- CC504
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC504', 'Liliana', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 10:53:00'::timestamptz, '2024-08-11 09:40:00'::timestamptz, '2024-08-11 09:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-11 09:40:00'::timestamptz); END IF;

  -- CC505
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC505', 'Samuel Colinas', false, 'completed', false, 7.25, 0.00, 0, 0.51, 7.76, 2.90, 1, 1, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:01:00'::timestamptz, '2024-08-11 10:23:00'::timestamptz, '2024-08-11 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.76 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.76, '2024-08-11 10:23:00'::timestamptz); END IF;

  -- CC506
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 46;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC506', 'Jan', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 13:11:00'::timestamptz, '2024-08-11 10:54:00'::timestamptz, '2024-08-11 10:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-11 10:54:00'::timestamptz); END IF;

  -- CC507
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC507', 'Erick Rodriguez', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, 'Lavandería', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 12:38:00'::timestamptz, '2024-08-11 11:48:00'::timestamptz, '2024-08-11 11:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-11 11:48:00'::timestamptz); END IF;

  -- CC508
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC508', 'Blanca', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 3, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 13:11:00'::timestamptz, '2024-08-11 12:13:00'::timestamptz, '2024-08-11 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-11 12:13:00'::timestamptz); END IF;

  -- CC509
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 35;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC509', 'Yamileth Rodriguez', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:02:00'::timestamptz, '2024-08-11 13:16:00'::timestamptz, '2024-08-11 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-11 13:16:00'::timestamptz); END IF;

  -- CC510
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC510', 'Daniel Camarena', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:38:00'::timestamptz, '2024-08-11 13:44:00'::timestamptz, '2024-08-11 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-11 13:44:00'::timestamptz); END IF;

  -- CC511
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 59;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC511', 'Dario', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:01:00'::timestamptz, '2024-08-11 13:55:00'::timestamptz, '2024-08-11 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-11 13:55:00'::timestamptz); END IF;

  -- CC512
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC512', 'Daniel Camarena', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:38:00'::timestamptz, '2024-08-11 14:42:00'::timestamptz, '2024-08-11 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-11 14:42:00'::timestamptz); END IF;

  -- CC513
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 60;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC513', 'Roger Saldaña', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:38:00'::timestamptz, '2024-08-11 15:05:00'::timestamptz, '2024-08-11 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-11 15:05:00'::timestamptz); END IF;

  -- CC514
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC514', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-08-11 00:00:00'::timestamptz, '2024-08-11 00:00:00'::timestamptz, '2024-08-11 15:26:00'::timestamptz, '2024-08-11 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-08-11 15:26:00'::timestamptz); END IF;

  -- CC515
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC515', 'Lineth', false, 'completed', false, 14.00, 0.00, 0, 0.00, 14.00, 0.00, 0, 7, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 12:12:00'::timestamptz, '2024-08-12 08:51:00'::timestamptz, '2024-08-12 08:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2024-08-12 08:51:00'::timestamptz); END IF;

  -- CC516
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC516', 'Lineth', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 12:11:00'::timestamptz, '2024-08-12 09:43:00'::timestamptz, '2024-08-12 09:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-12 09:43:00'::timestamptz); END IF;

  -- CC517
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC517', 'Cliente Lavandería', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, 'Lavandería', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 12:11:00'::timestamptz, '2024-08-12 09:50:00'::timestamptz, '2024-08-12 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-12 09:50:00'::timestamptz); END IF;

  -- CC518
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC518', 'Fany Luz Salon', false, 'completed', false, 5.40, 0.10, 0, 0.10, 5.50, 0.00, 0, 5, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 12:12:00'::timestamptz, '2024-08-12 10:05:00'::timestamptz, '2024-08-12 10:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-08-12 10:05:00'::timestamptz); END IF;

  -- CC519
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC519', 'Rafael Quintero', false, 'completed', false, 8.13, 0.00, 0, 0.57, 8.70, 3.25, 1, 1, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 14:54:00'::timestamptz, '2024-08-12 10:25:00'::timestamptz, '2024-08-12 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.70, '2024-08-12 10:25:00'::timestamptz); END IF;

  -- CC520
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC520', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 9.00, 2, 1, 'Salón', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 14:53:00'::timestamptz, '2024-08-12 13:51:00'::timestamptz, '2024-08-12 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-08-12 13:51:00'::timestamptz); END IF;

  -- CC521
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC521', 'Lineth', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 15:28:00'::timestamptz, '2024-08-12 13:57:00'::timestamptz, '2024-08-12 13:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-12 13:57:00'::timestamptz); END IF;

  -- CC522
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 60;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC522', 'Roger Saldaña', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 17:19:00'::timestamptz, '2024-08-12 14:05:00'::timestamptz, '2024-08-12 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-12 14:05:00'::timestamptz); END IF;

  -- CC523
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC523', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 17:19:00'::timestamptz, '2024-08-12 15:28:00'::timestamptz, '2024-08-12 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-12 15:28:00'::timestamptz); END IF;

  -- CC524
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 42;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC524', 'Milagros Aranda', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 4, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-13 13:23:00'::timestamptz, '2024-08-12 16:07:00'::timestamptz, '2024-08-12 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-12 16:07:00'::timestamptz); END IF;

  -- CC525
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 61;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC525', 'Ana Castrellon', false, 'completed', false, 21.00, 0.00, 0, 1.47, 22.47, 10.50, 1, 1, '0', '2024-08-12 00:00:00'::timestamptz, '2024-08-14 13:50:00'::timestamptz, '2024-08-12 16:20:00'::timestamptz, '2024-08-12 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.47 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.47, '2024-08-12 16:20:00'::timestamptz); END IF;

  -- CC526
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC526', 'Retail', true, 'completed', false, 2.75, 0.00, 0, 0.00, 2.75, 0.00, 0, 6, '', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 00:00:00'::timestamptz, '2024-08-12 16:43:00'::timestamptz, '2024-08-12 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2024-08-12 16:43:00'::timestamptz); END IF;

  -- CC527
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC527', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-08-12 00:00:00'::timestamptz, '2024-08-12 00:00:00'::timestamptz, '2024-08-12 16:43:00'::timestamptz, '2024-08-12 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-12 16:43:00'::timestamptz); END IF;

  -- CC528
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC528', 'Leonel Visueti', false, 'completed', false, 6.47, 0.03, 0, 0.03, 6.50, 0.00, 0, 4, '', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 14:31:00'::timestamptz, '2024-08-13 13:24:00'::timestamptz, '2024-08-13 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-08-13 13:24:00'::timestamptz); END IF;

  -- CC529
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC529', 'Cliente Lavandería', false, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 4, 'Lavandería', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 14:55:00'::timestamptz, '2024-08-13 13:34:00'::timestamptz, '2024-08-13 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-08-13 13:34:00'::timestamptz); END IF;

  -- CC530
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC530', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 14:55:00'::timestamptz, '2024-08-13 14:17:00'::timestamptz, '2024-08-13 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-13 14:17:00'::timestamptz); END IF;

  -- CC531
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC531', 'Yatzury Anderson', false, 'completed', false, 11.29, 0.21, 0, 0.21, 11.50, 0.00, 0, 8, '', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 15:22:00'::timestamptz, '2024-08-13 14:41:00'::timestamptz, '2024-08-13 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.50, '2024-08-13 14:41:00'::timestamptz); END IF;

  -- CC532
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC532', 'Claudia Londoño', false, 'completed', false, 25.93, 0.07, 0, 0.07, 26.00, 0.00, 0, 14, 'Lavandería', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 18:06:00'::timestamptz, '2024-08-13 17:05:00'::timestamptz, '2024-08-13 17:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.00, '2024-08-13 17:05:00'::timestamptz); END IF;

  -- CC533
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC533', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 2, '', '2024-08-13 00:00:00'::timestamptz, '2024-08-13 00:00:00'::timestamptz, '2024-08-13 17:15:00'::timestamptz, '2024-08-13 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-08-13 17:15:00'::timestamptz); END IF;

  -- CC594
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC594', 'Sheila Simons', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 14:33:00'::timestamptz, '2024-08-14 13:14:00'::timestamptz, '2024-08-14 13:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-14 13:14:00'::timestamptz); END IF;

  -- CC595
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC595', 'Aaron Gutierrez', false, 'completed', false, 8.50, 0.00, 0, 0.00, 8.50, 0.00, 0, 5, 'Lavandería', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 15:23:00'::timestamptz, '2024-08-14 13:48:00'::timestamptz, '2024-08-14 13:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-08-14 13:48:00'::timestamptz); END IF;

  -- CC596
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC596', 'Retail', true, 'completed', false, 1.87, 0.13, 0, 0.13, 2.00, 0.00, 0, 2, '', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 00:00:00'::timestamptz, '2024-08-14 13:59:00'::timestamptz, '2024-08-14 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-14 13:59:00'::timestamptz); END IF;

  -- CC597
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC597', 'Sheila Simons', false, 'completed', false, 6.42, 0.03, 0, 0.03, 6.45, 0.00, 0, 6, '0', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 14:48:00'::timestamptz, '2024-08-14 14:05:00'::timestamptz, '2024-08-14 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.45, '2024-08-14 14:05:00'::timestamptz); END IF;

  -- CC598
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC598', 'Cliente Lavandería', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 17:37:00'::timestamptz, '2024-08-14 15:38:00'::timestamptz, '2024-08-14 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-14 15:38:00'::timestamptz); END IF;

  -- CC599
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC599', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 00:00:00'::timestamptz, '2024-08-14 17:07:00'::timestamptz, '2024-08-14 17:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-14 17:07:00'::timestamptz); END IF;

  -- CC600
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC600', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 00:00:00'::timestamptz, '2024-08-14 17:23:00'::timestamptz, '2024-08-14 17:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-08-14 17:23:00'::timestamptz); END IF;

  -- CC601
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC601', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 4, '', '2024-08-14 00:00:00'::timestamptz, '2024-08-14 00:00:00'::timestamptz, '2024-08-14 17:55:00'::timestamptz, '2024-08-14 17:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-08-14 17:55:00'::timestamptz); END IF;

  -- CC602
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC602', 'Miguel Arauz', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-15 00:00:00'::timestamptz, '2024-08-15 12:20:00'::timestamptz, '2024-08-15 10:01:00'::timestamptz, '2024-08-15 10:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-15 10:01:00'::timestamptz); END IF;

  -- CC603
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC603', 'Cliente Lavandería', false, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 2, 'Lavandería', '2024-08-15 00:00:00'::timestamptz, '2024-08-16 09:31:00'::timestamptz, '2024-08-15 16:38:00'::timestamptz, '2024-08-15 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-15 16:38:00'::timestamptz); END IF;

  -- CC604
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC604', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2024-08-15 00:00:00'::timestamptz, '2024-08-15 00:00:00'::timestamptz, '2024-08-15 16:39:00'::timestamptz, '2024-08-15 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-15 16:39:00'::timestamptz); END IF;

  -- CC605
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC605', 'Cliente Lavandería', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 14:37:00'::timestamptz, '2024-08-16 09:31:00'::timestamptz, '2024-08-16 09:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-16 09:31:00'::timestamptz); END IF;

  -- CC606
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC606', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 15:02:00'::timestamptz, '2024-08-16 09:51:00'::timestamptz, '2024-08-16 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-16 09:51:00'::timestamptz); END IF;

  -- CC607
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 29;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC607', 'Roy', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 14:38:00'::timestamptz, '2024-08-16 10:16:00'::timestamptz, '2024-08-16 10:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-16 10:16:00'::timestamptz); END IF;

  -- CC608
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC608', 'Leonardo Salon', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'leonardo', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 14:38:00'::timestamptz, '2024-08-16 10:30:00'::timestamptz, '2024-08-16 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-16 10:30:00'::timestamptz); END IF;

  -- CC609
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC609', 'Guzmán', false, 'completed', false, 25.20, 0.00, 0, 1.76, 26.96, 12.60, 5, 1, '', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 14:36:00'::timestamptz, '2024-08-16 11:49:00'::timestamptz, '2024-08-16 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.96, '2024-08-16 11:49:00'::timestamptz); END IF;

  -- CC610
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC610', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.80, 0.00, 0, 1.18, 17.98, 8.40, 2, 1, 'Salón', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 15:02:00'::timestamptz, '2024-08-16 14:23:00'::timestamptz, '2024-08-16 14:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.98, '2024-08-16 14:23:00'::timestamptz); END IF;

  -- CC611
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 53;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC611', 'Miguel', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 08:30:00'::timestamptz, '2024-08-16 15:17:00'::timestamptz, '2024-08-16 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-16 15:17:00'::timestamptz); END IF;

  -- CC612
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC612', 'Retail', true, 'completed', false, 1.87, 0.13, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 00:00:00'::timestamptz, '2024-08-16 15:51:00'::timestamptz, '2024-08-16 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-16 15:51:00'::timestamptz); END IF;

  -- CC613
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC613', 'Retail', true, 'completed', false, 0.47, 0.03, 0, 0.03, 0.50, 0.00, 0, 1, '', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 00:00:00'::timestamptz, '2024-08-16 16:26:00'::timestamptz, '2024-08-16 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-08-16 16:26:00'::timestamptz); END IF;

  -- CC614
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC614', 'Retail', true, 'completed', false, 6.22, 0.03, 0, 0.03, 6.25, 0.00, 0, 9, '', '2024-08-16 00:00:00'::timestamptz, '2024-08-16 00:00:00'::timestamptz, '2024-08-16 16:52:00'::timestamptz, '2024-08-16 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.25, '2024-08-16 16:52:00'::timestamptz); END IF;

  -- CC615
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC615', 'Yara Rangel', false, 'completed', false, 14.93, 0.07, 0, 0.07, 15.00, 0.00, 0, 8, '0', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 13:38:00'::timestamptz, '2024-08-17 08:30:00'::timestamptz, '2024-08-17 08:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-08-17 08:30:00'::timestamptz); END IF;

  -- CC616
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC616', 'Leonel Visueti', false, 'completed', false, 5.86, 0.14, 0, 0.14, 6.00, 0.00, 0, 4, '', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 13:38:00'::timestamptz, '2024-08-17 08:44:00'::timestamptz, '2024-08-17 08:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-17 08:44:00'::timestamptz); END IF;

  -- CC617
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC617', 'Gisselle', false, 'completed', false, 7.86, 0.14, 0, 0.14, 8.00, 0.00, 0, 5, '0', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 16:58:00'::timestamptz, '2024-08-17 13:37:00'::timestamptz, '2024-08-17 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-17 13:37:00'::timestamptz); END IF;

  -- CC618
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC618', 'Daniel Camarena', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 16:58:00'::timestamptz, '2024-08-17 14:09:00'::timestamptz, '2024-08-17 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-17 14:09:00'::timestamptz); END IF;

  -- CC619
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC619', 'Cliente Lavandería', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 16:59:00'::timestamptz, '2024-08-17 15:17:00'::timestamptz, '2024-08-17 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-17 15:17:00'::timestamptz); END IF;

  -- CC620
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC620', 'Retail', true, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 10, '', '2024-08-17 00:00:00'::timestamptz, '2024-08-17 00:00:00'::timestamptz, '2024-08-17 16:15:00'::timestamptz, '2024-08-17 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-17 16:15:00'::timestamptz); END IF;

  -- CC621
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 46;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC621', 'Jan', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, '0', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 09:48:00'::timestamptz, '2024-08-18 08:07:00'::timestamptz, '2024-08-18 08:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-18 08:07:00'::timestamptz); END IF;

  -- CC622
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 46;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC622', 'Jan', false, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 2, '0', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 08:55:00'::timestamptz, '2024-08-18 08:12:00'::timestamptz, '2024-08-18 08:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-18 08:12:00'::timestamptz); END IF;

  -- CC623
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC623', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 08:55:00'::timestamptz, '2024-08-18 08:33:00'::timestamptz, '2024-08-18 08:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-18 08:33:00'::timestamptz); END IF;

  -- CC624
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC624', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 10:11:00'::timestamptz, '2024-08-18 09:49:00'::timestamptz, '2024-08-18 09:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-18 09:49:00'::timestamptz); END IF;

  -- CC625
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC625', 'Liliana', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 11:33:00'::timestamptz, '2024-08-18 10:30:00'::timestamptz, '2024-08-18 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-18 10:30:00'::timestamptz); END IF;

  -- CC626
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC626', 'Samuel Colinas', false, 'completed', false, 14.00, 0.00, 0, 0.00, 14.00, 0.00, 0, 7, '0', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 14:11:00'::timestamptz, '2024-08-18 10:36:00'::timestamptz, '2024-08-18 10:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2024-08-18 10:36:00'::timestamptz); END IF;

  -- CC627
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC627', 'Blanca', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 15:19:00'::timestamptz, '2024-08-18 14:05:00'::timestamptz, '2024-08-18 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-18 14:05:00'::timestamptz); END IF;

  -- CC628
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC628', 'Retail', true, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 4, '', '2024-08-18 00:00:00'::timestamptz, '2024-08-18 00:00:00'::timestamptz, '2024-08-18 15:22:00'::timestamptz, '2024-08-18 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-18 15:22:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 1: Imported orders 1 to 500';
END $$;
