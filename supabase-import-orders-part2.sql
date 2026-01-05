-- =============================================
-- CleanCloud Orders Import - Part 2 of 7
-- Orders 501 to 1000 (of 3472)
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


  -- CC629
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 60;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC629', 'Roger Saldaña', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-08-19 00:00:00'::timestamptz, '2024-08-19 14:14:00'::timestamptz, '2024-08-19 12:18:00'::timestamptz, '2024-08-19 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-19 12:18:00'::timestamptz); END IF;

  -- CC630
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 63;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC630', 'Maritza Adames', false, 'completed', false, 6.86, 0.14, 0, 0.14, 7.00, 0.00, 0, 5, 'Lavandería', '2024-08-19 00:00:00'::timestamptz, '2024-08-19 16:25:00'::timestamptz, '2024-08-19 13:46:00'::timestamptz, '2024-08-19 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-08-19 13:46:00'::timestamptz); END IF;

  -- CC631
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC631', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-19 00:00:00'::timestamptz, '2024-08-19 00:00:00'::timestamptz, '2024-08-19 14:14:00'::timestamptz, '2024-08-19 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-19 14:14:00'::timestamptz); END IF;

  -- CC632
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC632', 'Cliente Lavandería', false, 'completed', false, 2.34, 0.16, 0, 0.16, 2.50, 0.00, 0, 5, 'Lavandería', '2024-08-19 00:00:00'::timestamptz, '2024-08-19 16:25:00'::timestamptz, '2024-08-19 14:26:00'::timestamptz, '2024-08-19 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-19 14:26:00'::timestamptz); END IF;

  -- CC633
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC633', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-19 00:00:00'::timestamptz, '2024-08-19 00:00:00'::timestamptz, '2024-08-19 15:35:00'::timestamptz, '2024-08-19 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-19 15:35:00'::timestamptz); END IF;

  -- CC634
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 64;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC634', 'Alexander Aguilar', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-08-19 00:00:00'::timestamptz, '2024-08-20 10:58:00'::timestamptz, '2024-08-19 16:24:00'::timestamptz, '2024-08-19 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-19 16:24:00'::timestamptz); END IF;

  -- CC635
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC635', 'Fany Luz Salon', false, 'completed', false, 5.40, 0.10, 0, 0.10, 5.50, 0.00, 0, 5, '0', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 16:21:00'::timestamptz, '2024-08-20 10:53:00'::timestamptz, '2024-08-20 10:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-08-20 10:53:00'::timestamptz); END IF;

  -- CC636
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC636', 'Evelyn', false, 'completed', false, 8.93, 0.07, 0, 0.07, 9.00, 0.00, 0, 5, 'Salón', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 13:14:00'::timestamptz, '2024-08-20 10:57:00'::timestamptz, '2024-08-20 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-08-20 10:57:00'::timestamptz); END IF;

  -- CC637
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC637', 'Aaron Gutierrez', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 15:38:00'::timestamptz, '2024-08-20 13:35:00'::timestamptz, '2024-08-20 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-20 13:35:00'::timestamptz); END IF;

  -- CC638
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC638', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.91, 0.00, 0, 1.18, 18.09, 8.45, 2, 1, 'Salón', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 14:06:00'::timestamptz, '2024-08-20 13:40:00'::timestamptz, '2024-08-20 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.09 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.09, '2024-08-20 13:40:00'::timestamptz); END IF;

  -- CC639
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC639', 'Aaron Gutierrez', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 15:38:00'::timestamptz, '2024-08-20 14:18:00'::timestamptz, '2024-08-20 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-20 14:18:00'::timestamptz); END IF;

  -- CC640
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC640', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-08-20 00:00:00'::timestamptz, '2024-08-20 00:00:00'::timestamptz, '2024-08-20 17:01:00'::timestamptz, '2024-08-20 17:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-08-20 17:01:00'::timestamptz); END IF;

  -- CC641
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC641', 'Cliente Lavandería', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 4, 'Lavandería', '2024-08-21 00:00:00'::timestamptz, '2024-08-22 11:50:00'::timestamptz, '2024-08-21 15:02:00'::timestamptz, '2024-08-21 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-21 15:02:00'::timestamptz); END IF;

  -- CC642
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC642', 'Leonel Visueti', false, 'completed', false, 0.61, 0.04, 0, 0.04, 0.65, 0.00, 0, 2, '', '2024-08-21 00:00:00'::timestamptz, '2024-08-21 16:45:00'::timestamptz, '2024-08-21 15:06:00'::timestamptz, '2024-08-21 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.65, '2024-08-21 15:06:00'::timestamptz); END IF;

  -- CC643
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 53;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC643', 'Miguel', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-21 00:00:00'::timestamptz, '2024-08-22 11:50:00'::timestamptz, '2024-08-21 15:19:00'::timestamptz, '2024-08-21 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-21 15:19:00'::timestamptz); END IF;

  -- CC644
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC644', 'Leonardo Salon', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, 'leonardo', '2024-08-21 00:00:00'::timestamptz, '2024-08-21 16:45:00'::timestamptz, '2024-08-21 15:21:00'::timestamptz, '2024-08-21 15:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-21 15:21:00'::timestamptz); END IF;

  -- CC645
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC645', 'Claudia Londoño', false, 'completed', false, 18.59, 0.41, 0, 0.41, 19.00, 0.00, 0, 13, 'Lavandería', '2024-08-22 00:00:00'::timestamptz, '2024-08-22 12:49:00'::timestamptz, '2024-08-22 11:49:00'::timestamptz, '2024-08-22 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.00, '2024-08-22 11:49:00'::timestamptz); END IF;

  -- CC646
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC646', 'Guzmán', false, 'completed', false, 8.00, 0.00, 0, 0.56, 8.56, 4.00, 1, 1, '', '2024-08-22 00:00:00'::timestamptz, '2024-08-22 12:49:00'::timestamptz, '2024-08-22 12:45:00'::timestamptz, '2024-08-22 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.56, '2024-08-22 12:45:00'::timestamptz); END IF;

  -- CC647
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC647', 'Claudia Londoño', false, 'completed', false, 10.47, 0.03, 0, 0.03, 10.50, 0.00, 0, 6, 'Lavandería', '2024-08-22 00:00:00'::timestamptz, '2024-08-22 16:21:00'::timestamptz, '2024-08-22 13:46:00'::timestamptz, '2024-08-22 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-08-22 13:46:00'::timestamptz); END IF;

  -- CC648
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC648', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2024-08-22 00:00:00'::timestamptz, '2024-08-22 00:00:00'::timestamptz, '2024-08-22 16:27:00'::timestamptz, '2024-08-22 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-08-22 16:27:00'::timestamptz); END IF;

  -- CC649
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC649', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-08-22 00:00:00'::timestamptz, '2024-08-22 00:00:00'::timestamptz, '2024-08-22 16:28:00'::timestamptz, '2024-08-22 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-22 16:28:00'::timestamptz); END IF;

  -- CC650
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC650', 'Guzmán', false, 'completed', false, 25.60, 0.00, 0, 1.79, 27.39, 12.80, 5, 1, '', '2024-08-23 00:00:00'::timestamptz, '2024-08-23 15:04:00'::timestamptz, '2024-08-23 11:26:00'::timestamptz, '2024-08-23 11:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.39 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.39, '2024-08-23 11:26:00'::timestamptz); END IF;

  -- CC652
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC652', 'Miguel Arauz', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-23 00:00:00'::timestamptz, '2024-08-24 10:25:00'::timestamptz, '2024-08-23 14:26:00'::timestamptz, '2024-08-23 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-23 14:26:00'::timestamptz); END IF;

  -- CC653
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC653', 'Yatzury Anderson', false, 'completed', false, 3.66, 0.09, 0, 0.09, 3.75, 0.00, 0, 3, '', '2024-08-23 00:00:00'::timestamptz, '2024-08-24 10:25:00'::timestamptz, '2024-08-23 16:32:00'::timestamptz, '2024-08-23 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2024-08-23 16:32:00'::timestamptz); END IF;

  -- CC654
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC654', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-08-23 00:00:00'::timestamptz, '2024-08-23 00:00:00'::timestamptz, '2024-08-23 16:32:00'::timestamptz, '2024-08-23 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-23 16:32:00'::timestamptz); END IF;

  -- CC655
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC655', 'Blanca', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 10:25:00'::timestamptz, '2024-08-24 09:14:00'::timestamptz, '2024-08-24 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-24 09:14:00'::timestamptz); END IF;

  -- CC656
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC656', 'Rene Guiñez', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '0', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 13:23:00'::timestamptz, '2024-08-24 11:51:00'::timestamptz, '2024-08-24 11:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-24 11:51:00'::timestamptz); END IF;

  -- CC657
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC657', 'Fernando Ortega', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, '', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 16:02:00'::timestamptz, '2024-08-24 13:15:00'::timestamptz, '2024-08-24 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-24 13:15:00'::timestamptz); END IF;

  -- CC658
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC658', 'Fernando Ortega', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 2.80, 1, 1, '', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 15:17:00'::timestamptz, '2024-08-24 13:17:00'::timestamptz, '2024-08-24 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-08-24 13:17:00'::timestamptz); END IF;

  -- CC659
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC659', 'Cliente Lavandería', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 16:02:00'::timestamptz, '2024-08-24 13:46:00'::timestamptz, '2024-08-24 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-24 13:46:00'::timestamptz); END IF;

  -- CC660
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC660', 'Leonel Visueti', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 7, '', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 16:02:00'::timestamptz, '2024-08-24 14:09:00'::timestamptz, '2024-08-24 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-24 14:09:00'::timestamptz); END IF;

  -- CC661
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC661', 'Gisselle', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-24 00:00:00'::timestamptz, '2024-08-25 08:04:00'::timestamptz, '2024-08-24 15:48:00'::timestamptz, '2024-08-24 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-24 15:48:00'::timestamptz); END IF;

  -- CC662
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC662', 'Retail', true, 'completed', false, 1.97, 0.03, 0, 0.03, 2.00, 0.00, 0, 4, '', '2024-08-24 00:00:00'::timestamptz, '2024-08-24 00:00:00'::timestamptz, '2024-08-24 16:40:00'::timestamptz, '2024-08-24 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-24 16:40:00'::timestamptz); END IF;

  -- CC663
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 65;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC663', 'Javier Govea', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, 'Lavandería', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 11:27:00'::timestamptz, '2024-08-25 09:34:00'::timestamptz, '2024-08-25 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-25 09:34:00'::timestamptz); END IF;

  -- CC664
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC664', 'Liliana', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 12:46:00'::timestamptz, '2024-08-25 10:52:00'::timestamptz, '2024-08-25 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-25 10:52:00'::timestamptz); END IF;

  -- CC665
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC665', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 11:27:00'::timestamptz, '2024-08-25 10:53:00'::timestamptz, '2024-08-25 10:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-25 10:53:00'::timestamptz); END IF;

  -- CC666
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC666', 'Samuel Colinas', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.30, 1, 1, '0', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:14:00'::timestamptz, '2024-08-25 11:22:00'::timestamptz, '2024-08-25 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-08-25 11:22:00'::timestamptz); END IF;

  -- CC667
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC667', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 00:00:00'::timestamptz, '2024-08-25 11:28:00'::timestamptz, '2024-08-25 11:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-25 11:28:00'::timestamptz); END IF;

  -- CC668
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC668', 'Yara Rangel', false, 'completed', false, 16.09, 0.41, 0, 0.41, 16.50, 0.00, 0, 12, '0', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:15:00'::timestamptz, '2024-08-25 12:41:00'::timestamptz, '2024-08-25 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.50, '2024-08-25 12:41:00'::timestamptz); END IF;

  -- CC669
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC669', 'Gisselle', false, 'completed', false, 7.86, 0.14, 0, 0.14, 8.00, 0.00, 0, 5, '0', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:31:00'::timestamptz, '2024-08-25 12:46:00'::timestamptz, '2024-08-25 12:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-25 12:46:00'::timestamptz); END IF;

  -- CC670
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC670', 'Yara Rangel', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-26 00:00:00'::timestamptz, '2024-08-25 15:15:00'::timestamptz, '2024-08-25 14:07:00'::timestamptz, '2024-08-25 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-25 14:07:00'::timestamptz); END IF;

  -- CC671
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC671', 'Yatzury Anderson', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:31:00'::timestamptz, '2024-08-25 14:08:00'::timestamptz, '2024-08-25 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-25 14:08:00'::timestamptz); END IF;

  -- CC672
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC672', 'Leonel Visueti', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:31:00'::timestamptz, '2024-08-25 14:09:00'::timestamptz, '2024-08-25 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-25 14:09:00'::timestamptz); END IF;

  -- CC673
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC673', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 00:00:00'::timestamptz, '2024-08-25 14:52:00'::timestamptz, '2024-08-25 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-25 14:52:00'::timestamptz); END IF;

  -- CC674
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC674', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-25 00:00:00'::timestamptz, '2024-08-25 15:16:00'::timestamptz, '2024-08-25 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-08-25 15:16:00'::timestamptz); END IF;

  -- CC676
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC676', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-08-25 00:00:00'::timestamptz, '2024-08-26 08:36:00'::timestamptz, '2024-08-25 15:29:00'::timestamptz, '2024-08-25 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-25 15:29:00'::timestamptz); END IF;

  -- CC677
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC677', 'Fany Luz Salon', false, 'completed', false, 5.40, 0.10, 0, 0.10, 5.50, 0.00, 0, 5, '0', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 12:30:00'::timestamptz, '2024-08-26 10:44:00'::timestamptz, '2024-08-26 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-08-26 10:44:00'::timestamptz); END IF;

  -- CC678
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC678', 'Sandra Medina', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 11:42:00'::timestamptz, '2024-08-26 10:56:00'::timestamptz, '2024-08-26 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-26 10:56:00'::timestamptz); END IF;

  -- CC679
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC679', 'Retail', true, 'completed', false, 0.97, 0.03, 0, 0.03, 1.00, 0.00, 0, 2, '', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 00:00:00'::timestamptz, '2024-08-26 11:13:00'::timestamptz, '2024-08-26 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-26 11:13:00'::timestamptz); END IF;

  -- CC680
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC680', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 00:00:00'::timestamptz, '2024-08-26 11:14:00'::timestamptz, '2024-08-26 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-08-26 11:14:00'::timestamptz); END IF;

  -- CC681
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC681', 'Sandra Medina', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 12:39:00'::timestamptz, '2024-08-26 12:01:00'::timestamptz, '2024-08-26 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-26 12:01:00'::timestamptz); END IF;

  -- CC682
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 67;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC682', 'Pablo Ardito', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, 'Lavandería', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 14:04:00'::timestamptz, '2024-08-26 12:37:00'::timestamptz, '2024-08-26 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-26 12:37:00'::timestamptz); END IF;

  -- CC683
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC683', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 7.00, 2, 1, 'Salón', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 14:40:00'::timestamptz, '2024-08-26 13:39:00'::timestamptz, '2024-08-26 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2024-08-26 13:39:00'::timestamptz); END IF;

  -- CC684
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC684', 'Rafael Quintero', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-26 00:00:00'::timestamptz, '2024-08-26 15:53:00'::timestamptz, '2024-08-26 14:27:00'::timestamptz, '2024-08-26 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-26 14:27:00'::timestamptz); END IF;

  -- CC685
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC685', 'Blanca', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-08-27 00:00:00'::timestamptz, '2024-08-26 15:53:00'::timestamptz, '2024-08-26 15:09:00'::timestamptz, '2024-08-26 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-26 15:09:00'::timestamptz); END IF;

  -- CC686
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC686', 'Yatzury Anderson', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 11:44:00'::timestamptz, '2024-08-27 09:26:00'::timestamptz, '2024-08-27 09:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-27 09:26:00'::timestamptz); END IF;

  -- CC687
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC687', 'Leonel Visueti', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 11:39:00'::timestamptz, '2024-08-27 09:52:00'::timestamptz, '2024-08-27 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-27 09:52:00'::timestamptz); END IF;

  -- CC688
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC688', 'Cliente Lavandería', false, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 2, 'Lavandería', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 14:04:00'::timestamptz, '2024-08-27 11:59:00'::timestamptz, '2024-08-27 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-08-27 11:59:00'::timestamptz); END IF;

  -- CC689
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC689', 'Tairis - Diego', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 16:03:00'::timestamptz, '2024-08-27 13:38:00'::timestamptz, '2024-08-27 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-08-27 13:38:00'::timestamptz); END IF;

  -- CC690
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC690', 'Cliente Lavandería', false, 'completed', false, 12.47, 0.03, 0, 0.03, 12.50, 0.00, 0, 7, 'Lavandería', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 16:03:00'::timestamptz, '2024-08-27 14:05:00'::timestamptz, '2024-08-27 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.50, '2024-08-27 14:05:00'::timestamptz); END IF;

  -- CC691
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC691', 'Leonel Visueti', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '', '2024-08-27 00:00:00'::timestamptz, '2024-08-28 12:37:00'::timestamptz, '2024-08-27 16:02:00'::timestamptz, '2024-08-27 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-08-27 16:02:00'::timestamptz); END IF;

  -- CC692
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC692', 'Yatzury Anderson', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-08-27 00:00:00'::timestamptz, '2024-08-28 12:37:00'::timestamptz, '2024-08-27 16:04:00'::timestamptz, '2024-08-27 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-08-27 16:04:00'::timestamptz); END IF;

  -- CC693
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC693', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-08-27 00:00:00'::timestamptz, '2024-08-27 00:00:00'::timestamptz, '2024-08-27 17:18:00'::timestamptz, '2024-08-27 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-08-27 17:18:00'::timestamptz); END IF;

  -- CC694
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC694', 'Leonel Visueti', false, 'completed', false, 5.43, 0.07, 0, 0.07, 5.50, 0.00, 0, 4, '', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 12:37:00'::timestamptz, '2024-08-28 10:48:00'::timestamptz, '2024-08-28 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-08-28 10:48:00'::timestamptz); END IF;

  -- CC695
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC695', 'Aaron Gutierrez', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 14:42:00'::timestamptz, '2024-08-28 12:39:00'::timestamptz, '2024-08-28 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-28 12:39:00'::timestamptz); END IF;

  -- CC696
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC696', 'Cliente Lavandería', false, 'completed', false, 24.00, 0.00, 0, 1.68, 25.68, 0.00, 0, 5, 'Lavandería', '2024-08-28 00:00:00'::timestamptz, '2024-08-29 09:06:00'::timestamptz, '2024-08-28 12:57:00'::timestamptz, '2024-08-28 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.68 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.68, '2024-08-28 12:57:00'::timestamptz); END IF;

  -- CC697
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC697', 'Leonardo Salon', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'leonardo', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 16:21:00'::timestamptz, '2024-08-28 12:58:00'::timestamptz, '2024-08-28 12:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-28 12:58:00'::timestamptz); END IF;

  -- CC698
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 67;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC698', 'Pablo Ardito', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, 'Lavandería', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 14:42:00'::timestamptz, '2024-08-28 13:05:00'::timestamptz, '2024-08-28 13:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-28 13:05:00'::timestamptz); END IF;

  -- CC699
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC699', 'Aaron Gutierrez', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 16:21:00'::timestamptz, '2024-08-28 13:27:00'::timestamptz, '2024-08-28 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-28 13:27:00'::timestamptz); END IF;

  -- CC700
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC700', 'Retail', true, 'completed', false, 3.63, 0.12, 0, 0.12, 3.75, 0.00, 0, 6, '', '2024-08-28 00:00:00'::timestamptz, '2024-08-28 00:00:00'::timestamptz, '2024-08-28 16:47:00'::timestamptz, '2024-08-28 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2024-08-28 16:47:00'::timestamptz); END IF;

  -- CC701
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC701', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 14:38:00'::timestamptz, '2024-08-30 09:31:00'::timestamptz, '2024-08-30 09:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-08-30 09:31:00'::timestamptz); END IF;

  -- CC702
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC702', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.30, 0.00, 0, 1.00, 15.30, 7.15, 2, 1, 'Salón', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 16:22:00'::timestamptz, '2024-08-30 14:27:00'::timestamptz, '2024-08-30 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.30, '2024-08-30 14:27:00'::timestamptz); END IF;

  -- CC703
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC703', 'Guzmán', false, 'completed', false, 10.71, 0.00, 0, 0.75, 11.46, 5.35, 1, 1, '', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 16:22:00'::timestamptz, '2024-08-30 14:40:00'::timestamptz, '2024-08-30 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.46, '2024-08-30 14:40:00'::timestamptz); END IF;

  -- CC704
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC704', 'Lineth', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 6, '0', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 16:22:00'::timestamptz, '2024-08-30 14:59:00'::timestamptz, '2024-08-30 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-30 14:59:00'::timestamptz); END IF;

  -- CC705
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC705', 'Lineth', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 16:23:00'::timestamptz, '2024-08-30 15:31:00'::timestamptz, '2024-08-30 15:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-08-30 15:31:00'::timestamptz); END IF;

  -- CC706
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC706', 'Guzmán', false, 'completed', false, 30.80, 0.00, 0, 2.16, 32.96, 15.40, 5, 1, '', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 16:23:00'::timestamptz, '2024-08-30 15:37:00'::timestamptz, '2024-08-30 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 32.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 32.96, '2024-08-30 15:37:00'::timestamptz); END IF;

  -- CC707
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC707', 'Lineth', false, 'completed', false, 10.00, 0.00, 0, 0.00, 10.00, 0.00, 0, 5, '0', '2024-08-30 00:00:00'::timestamptz, '2024-08-31 15:40:00'::timestamptz, '2024-08-30 16:20:00'::timestamptz, '2024-08-30 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-08-30 16:20:00'::timestamptz); END IF;

  -- CC708
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC708', 'Retail', true, 'completed', false, 5.60, 0.15, 0, 0.15, 5.75, 0.00, 0, 7, '', '2024-08-30 00:00:00'::timestamptz, '2024-08-30 00:00:00'::timestamptz, '2024-08-30 17:15:00'::timestamptz, '2024-08-30 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.75, '2024-08-30 17:15:00'::timestamptz); END IF;

  -- CC709
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 42;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC709', 'Milagros Aranda', false, 'completed', false, 5.25, 0.00, 0, 0.00, 5.25, 0.00, 0, 5, '0', '2024-08-30 00:00:00'::timestamptz, '2024-08-31 07:46:00'::timestamptz, '2024-08-30 17:17:00'::timestamptz, '2024-08-30 17:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2024-08-30 17:17:00'::timestamptz); END IF;

  -- CC710
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC710', 'Dalvis Ojo', false, 'completed', false, 11.73, 0.27, 0, 0.27, 12.00, 0.00, 0, 8, 'Lavandería', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 13:34:00'::timestamptz, '2024-08-31 07:39:00'::timestamptz, '2024-08-31 07:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-08-31 07:39:00'::timestamptz); END IF;

  -- CC711
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC711', 'Dalvis Ojo', false, 'completed', false, 9.00, 0.00, 0, 0.00, 9.00, 0.00, 0, 7, 'Lavandería', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 13:34:00'::timestamptz, '2024-08-31 08:32:00'::timestamptz, '2024-08-31 08:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-08-31 08:32:00'::timestamptz); END IF;

  -- CC712
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC712', 'Leonel Visueti', false, 'completed', false, 5.86, 0.14, 0, 0.14, 6.00, 0.00, 0, 4, '', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 13:34:00'::timestamptz, '2024-08-31 08:44:00'::timestamptz, '2024-08-31 08:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-31 08:44:00'::timestamptz); END IF;

  -- CC713
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC713', 'Yara Rangel', false, 'completed', false, 9.00, 0.00, 0, 0.00, 9.00, 0.00, 0, 5, '0', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 13:54:00'::timestamptz, '2024-08-31 13:33:00'::timestamptz, '2024-08-31 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-08-31 13:33:00'::timestamptz); END IF;

  -- CC714
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC714', 'Yara Rangel', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 15:40:00'::timestamptz, '2024-08-31 13:51:00'::timestamptz, '2024-08-31 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-31 13:51:00'::timestamptz); END IF;

  -- CC715
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC715', 'Daniel Camarena', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 15:40:00'::timestamptz, '2024-08-31 14:18:00'::timestamptz, '2024-08-31 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-08-31 14:18:00'::timestamptz); END IF;

  -- CC716
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC716', 'Claudia Londoño', false, 'completed', false, 18.59, 0.41, 0, 0.41, 19.00, 0.00, 0, 13, 'Lavandería', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 17:14:00'::timestamptz, '2024-08-31 15:17:00'::timestamptz, '2024-08-31 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.00, '2024-08-31 15:17:00'::timestamptz); END IF;

  -- CC717
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC717', 'Claudia Londoño', false, 'completed', false, 9.48, 0.02, 0, 0.02, 9.50, 0.00, 0, 6, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-08-31 17:14:00'::timestamptz, '2024-08-31 16:14:00'::timestamptz, '2024-08-31 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.50, '2024-08-31 16:14:00'::timestamptz); END IF;

  -- CC718
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC718', 'Cliente Lavandería', false, 'completed', false, 6.08, 0.17, 0, 0.43, 6.51, 0.00, 0, 5, 'Lavandería', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 17:14:00'::timestamptz, '2024-08-31 16:47:00'::timestamptz, '2024-08-31 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.51 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.51, '2024-08-31 16:47:00'::timestamptz); END IF;

  -- CC719
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC719', 'Retail', true, 'completed', false, 7.43, 0.07, 0, 0.07, 7.50, 0.00, 0, 13, '', '2024-08-31 00:00:00'::timestamptz, '2024-08-31 00:00:00'::timestamptz, '2024-08-31 16:52:00'::timestamptz, '2024-08-31 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2024-08-31 16:52:00'::timestamptz); END IF;

  -- CC720
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC720', 'Liliana', false, 'completed', false, 4.50, 0.00, 0, 0.00, 4.50, 0.00, 0, 3, '0', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 10:31:00'::timestamptz, '2024-09-01 09:13:00'::timestamptz, '2024-09-01 09:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-09-01 09:13:00'::timestamptz); END IF;

  -- CC721
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC721', 'Samuel Colinas', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, '0', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 11:25:00'::timestamptz, '2024-09-01 10:35:00'::timestamptz, '2024-09-01 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-01 10:35:00'::timestamptz); END IF;

  -- CC722
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC722', 'Cliente Lavandería', false, 'completed', false, 6.36, 0.14, 0, 0.14, 6.50, 0.00, 0, 5, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 11:46:00'::timestamptz, '2024-09-01 10:57:00'::timestamptz, '2024-09-01 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-09-01 10:57:00'::timestamptz); END IF;

  -- CC723
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC723', 'Samuel Colinas', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 12:12:00'::timestamptz, '2024-09-01 11:28:00'::timestamptz, '2024-09-01 11:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-01 11:28:00'::timestamptz); END IF;

  -- CC724
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC724', 'Dalvis Ojo', false, 'completed', false, 4.11, 0.29, 0, 0.29, 4.40, 0.00, 0, 13, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 12:12:00'::timestamptz, '2024-09-01 12:07:00'::timestamptz, '2024-09-01 12:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.40, '2024-09-01 12:07:00'::timestamptz); END IF;

  -- CC725
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC725', 'Cliente Lavandería', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 5, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 13:58:00'::timestamptz, '2024-09-01 12:09:00'::timestamptz, '2024-09-01 12:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-01 12:09:00'::timestamptz); END IF;

  -- CC726
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC726', 'Blanca', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 13:58:00'::timestamptz, '2024-09-01 12:30:00'::timestamptz, '2024-09-01 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-01 12:30:00'::timestamptz); END IF;

  -- CC727
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC727', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 1, '', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 00:00:00'::timestamptz, '2024-09-01 12:49:00'::timestamptz, '2024-09-01 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-09-01 12:49:00'::timestamptz); END IF;

  -- CC728
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC728', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 00:00:00'::timestamptz, '2024-09-01 12:54:00'::timestamptz, '2024-09-01 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-01 12:54:00'::timestamptz); END IF;

  -- CC729
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 69;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC729', 'Yessy Oroco', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 13:58:00'::timestamptz, '2024-09-01 13:02:00'::timestamptz, '2024-09-01 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-01 13:02:00'::timestamptz); END IF;

  -- CC730
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC730', 'Leonel Visueti', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:25:00'::timestamptz, '2024-09-01 14:11:00'::timestamptz, '2024-09-01 14:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-01 14:11:00'::timestamptz); END IF;

  -- CC731
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC731', 'Blanca', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:25:00'::timestamptz, '2024-09-01 14:20:00'::timestamptz, '2024-09-01 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-01 14:20:00'::timestamptz); END IF;

  -- CC732
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 69;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC732', 'Yessy Oroco', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:25:00'::timestamptz, '2024-09-01 14:57:00'::timestamptz, '2024-09-01 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-01 14:57:00'::timestamptz); END IF;

  -- CC733
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 69;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC733', 'Yessy Oroco', false, 'completed', false, 3.04, 0.21, 0, 0.21, 3.25, 0.00, 0, 10, 'Lavandería', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:25:00'::timestamptz, '2024-09-01 15:00:00'::timestamptz, '2024-09-01 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-09-01 15:00:00'::timestamptz); END IF;

  -- CC734
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC734', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:02:00'::timestamptz, '2024-09-01 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-09-01 15:02:00'::timestamptz); END IF;

  -- CC735
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC735', 'Retail', true, 'completed', false, 1.47, 0.03, 0, 0.03, 1.50, 0.00, 0, 3, '', '2024-09-01 00:00:00'::timestamptz, '2024-09-01 00:00:00'::timestamptz, '2024-09-01 15:23:00'::timestamptz, '2024-09-01 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-09-01 15:23:00'::timestamptz); END IF;

  -- CC736
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC736', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 21.25, 0.00, 0, 1.49, 22.74, 8.50, 2, 1, 'Salón', '2024-09-02 00:00:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz, '2024-09-02 14:02:00'::timestamptz, '2024-09-02 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.74, '2024-09-02 14:02:00'::timestamptz); END IF;

  -- CC737
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC737', 'Leonel Visueti', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, '', '2024-09-02 00:00:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz, '2024-09-02 14:18:00'::timestamptz, '2024-09-02 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-02 14:18:00'::timestamptz); END IF;

  -- CC738
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC738', 'Yatzury Anderson', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '', '2024-09-02 00:00:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz, '2024-09-02 16:01:00'::timestamptz, '2024-09-02 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-02 16:01:00'::timestamptz); END IF;

  -- CC739
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC739', 'Cliente Lavandería', false, 'completed', false, 2.83, 0.17, 0, 0.17, 3.00, 0.00, 0, 3, 'Lavandería', '2024-09-02 00:00:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz, '2024-09-02 16:44:00'::timestamptz, '2024-09-02 16:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-02 16:44:00'::timestamptz); END IF;

  -- CC740
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC740', 'Retail', true, 'completed', false, 4.50, 0.00, 0, 0.00, 4.50, 0.00, 0, 6, '', '2024-09-02 00:00:00'::timestamptz, '2024-09-02 00:00:00'::timestamptz, '2024-09-02 16:46:00'::timestamptz, '2024-09-02 16:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-09-02 16:46:00'::timestamptz); END IF;

  -- CC741
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC741', 'Miguel Arauz', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-09-03 00:00:00'::timestamptz, '2024-09-03 15:43:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz, '2024-09-03 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-03 14:13:00'::timestamptz); END IF;

  -- CC742
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC742', 'Miguel Arauz', false, 'completed', false, 3.16, 0.09, 0, 0.09, 3.25, 0.00, 0, 2, '0', '2024-09-03 00:00:00'::timestamptz, '2024-09-04 10:47:00'::timestamptz, '2024-09-03 14:51:00'::timestamptz, '2024-09-03 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-09-03 14:51:00'::timestamptz); END IF;

  -- CC743
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC743', 'Aaron Gutierrez', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-03 00:00:00'::timestamptz, '2024-09-03 15:45:00'::timestamptz, '2024-09-03 14:55:00'::timestamptz, '2024-09-03 14:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-03 14:55:00'::timestamptz); END IF;

  -- CC744
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC744', 'Yatzury Anderson', false, 'completed', false, 3.66, 0.09, 0, 0.09, 3.75, 0.00, 0, 3, '', '2024-09-03 00:00:00'::timestamptz, '2024-09-03 15:43:00'::timestamptz, '2024-09-03 14:59:00'::timestamptz, '2024-09-03 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2024-09-03 14:59:00'::timestamptz); END IF;

  -- CC745
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC745', 'Cliente Lavandería', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-03 00:00:00'::timestamptz, '2024-09-04 10:47:00'::timestamptz, '2024-09-03 15:20:00'::timestamptz, '2024-09-03 15:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-03 15:20:00'::timestamptz); END IF;

  -- CC746
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC746', 'Aaron Gutierrez', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-03 00:00:00'::timestamptz, '2024-09-04 10:47:00'::timestamptz, '2024-09-03 15:44:00'::timestamptz, '2024-09-03 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-03 15:44:00'::timestamptz); END IF;

  -- CC747
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC747', 'Retail', true, 'completed', false, 3.40, 0.10, 0, 0.10, 3.50, 0.00, 0, 7, '', '2024-09-03 00:00:00'::timestamptz, '2024-09-03 00:00:00'::timestamptz, '2024-09-03 16:31:00'::timestamptz, '2024-09-03 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-09-03 16:31:00'::timestamptz); END IF;

  -- CC748
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC748', 'Yatzury Anderson', false, 'completed', false, 5.93, 0.07, 0, 0.07, 6.00, 0.00, 0, 4, '', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 10:47:00'::timestamptz, '2024-09-04 10:46:00'::timestamptz, '2024-09-04 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-04 10:46:00'::timestamptz); END IF;

  -- CC749
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC749', 'Leonel Visueti', false, 'completed', false, 4.86, 0.14, 0, 0.14, 5.00, 0.00, 0, 10, '', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 13:51:00'::timestamptz, '2024-09-04 10:49:00'::timestamptz, '2024-09-04 10:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-04 10:49:00'::timestamptz); END IF;

  -- CC750
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC750', 'Cliente Lavandería', false, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 2, 'Lavandería', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 13:51:00'::timestamptz, '2024-09-04 10:50:00'::timestamptz, '2024-09-04 10:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-04 10:50:00'::timestamptz); END IF;

  -- CC751
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC751', 'Leonardo Salon', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, 'leonardo', '2024-09-04 00:00:00'::timestamptz, '2024-09-05 10:13:00'::timestamptz, '2024-09-04 13:52:00'::timestamptz, '2024-09-04 13:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-04 13:52:00'::timestamptz); END IF;

  -- CC752
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC752', 'Cliente Lavandería', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 14:38:00'::timestamptz, '2024-09-04 13:55:00'::timestamptz, '2024-09-04 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-04 13:55:00'::timestamptz); END IF;

  -- CC753
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC753', 'Yatzury Anderson', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 15:50:00'::timestamptz, '2024-09-04 15:00:00'::timestamptz, '2024-09-04 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-04 15:00:00'::timestamptz); END IF;

  -- CC754
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC754', 'Maybelis Robinson', false, 'completed', false, 8.50, 0.00, 0, 0.59, 9.09, 0.00, 0, 0, 'm  Perlas de Olor: Media, Tipo de suavizante: Con Suavizante', '2024-09-07 00:00:00'::timestamptz, '2024-09-05 10:13:00'::timestamptz, '2024-09-04 15:28:00'::timestamptz, '2024-09-04 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.09 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.09, '2024-09-04 15:28:00'::timestamptz); END IF;

  -- CC756
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC756', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 6, '', '2024-09-04 00:00:00'::timestamptz, '2024-09-04 00:00:00'::timestamptz, '2024-09-04 16:51:00'::timestamptz, '2024-09-04 16:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-09-04 16:51:00'::timestamptz); END IF;

  -- CC757
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC757', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 16:41:00'::timestamptz, '2024-09-05 11:37:00'::timestamptz, '2024-09-05 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-05 11:37:00'::timestamptz); END IF;

  -- CC758
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC758', 'Fany Luz Salon', false, 'completed', false, 5.40, 0.10, 0, 0.10, 5.50, 0.00, 0, 5, '0', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 14:01:00'::timestamptz, '2024-09-05 12:25:00'::timestamptz, '2024-09-05 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-09-05 12:25:00'::timestamptz); END IF;

  -- CC759
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC759', 'Blanca', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '0', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 14:01:00'::timestamptz, '2024-09-05 13:00:00'::timestamptz, '2024-09-05 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-05 13:00:00'::timestamptz); END IF;

  -- CC760
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC760', 'Blanca', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 16:41:00'::timestamptz, '2024-09-05 14:01:00'::timestamptz, '2024-09-05 14:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-05 14:01:00'::timestamptz); END IF;

  -- CC761
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC761', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 16:40:00'::timestamptz, '2024-09-05 16:06:00'::timestamptz, '2024-09-05 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-05 16:06:00'::timestamptz); END IF;

  -- CC762
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC762', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 6, '', '2024-09-05 00:00:00'::timestamptz, '2024-09-05 00:00:00'::timestamptz, '2024-09-05 16:33:00'::timestamptz, '2024-09-05 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-09-05 16:33:00'::timestamptz); END IF;

  -- CC763
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC763', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.04, 1.04, 0.00, 0, 2, '', '2024-09-06 00:00:00'::timestamptz, '2024-09-06 00:00:00'::timestamptz, '2024-09-06 16:34:00'::timestamptz, '2024-09-06 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.04 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.04, '2024-09-06 16:34:00'::timestamptz); END IF;

  -- CC764
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC764', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-06 00:00:00'::timestamptz, '2024-09-06 00:00:00'::timestamptz, '2024-09-06 16:35:00'::timestamptz, '2024-09-06 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-06 16:35:00'::timestamptz); END IF;

  -- CC765
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC765', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-09-06 00:00:00'::timestamptz, '2024-09-06 16:36:00'::timestamptz, '2024-09-06 16:35:00'::timestamptz, '2024-09-06 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-06 16:35:00'::timestamptz); END IF;

  -- CC766
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC766', 'Guzmán', false, 'completed', false, 8.40, 0.00, 0, 0.59, 8.99, 0.00, 0, 4, '', '2024-09-06 00:00:00'::timestamptz, '2024-09-07 08:13:00'::timestamptz, '2024-09-06 16:48:00'::timestamptz, '2024-09-06 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.99, '2024-09-06 16:48:00'::timestamptz); END IF;

  -- CC767
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC767', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 00:00:00'::timestamptz, '2024-09-07 08:14:00'::timestamptz, '2024-09-07 08:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-07 08:14:00'::timestamptz); END IF;

  -- CC768
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC768', 'Guzmán', false, 'completed', false, 29.25, 0.00, 0, 2.05, 31.30, 11.70, 4, 1, '', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 14:16:00'::timestamptz, '2024-09-07 11:27:00'::timestamptz, '2024-09-07 11:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.30, '2024-09-07 11:27:00'::timestamptz); END IF;

  -- CC769
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC769', 'Octavio Cherigo', false, 'completed', false, 18.83, 0.00, 0, 1.32, 20.15, 6.75, 3, 7, 'Lavandería', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 16:23:00'::timestamptz, '2024-09-07 11:47:00'::timestamptz, '2024-09-07 11:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.15, '2024-09-07 11:47:00'::timestamptz); END IF;

  -- CC770
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 71;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC770', 'Cludia Elena Lopera', false, 'completed', false, 1.00, 0.00, 0, 0.07, 1.07, 0.00, 0, 2, 'Lavandería', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 14:16:00'::timestamptz, '2024-09-07 12:13:00'::timestamptz, '2024-09-07 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.07, '2024-09-07 12:13:00'::timestamptz); END IF;

  -- CC771
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC771', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.75, 0.00, 0, 1.31, 20.06, 7.50, 2, 1, 'Salón', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 15:16:00'::timestamptz, '2024-09-07 14:16:00'::timestamptz, '2024-09-07 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.06, '2024-09-07 14:16:00'::timestamptz); END IF;

  -- CC772
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 72;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC772', 'Mary Drake', false, 'completed', false, 12.00, 0.00, 0, 0.00, 12.00, 0.00, 0, 7, '0', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 16:23:00'::timestamptz, '2024-09-07 15:51:00'::timestamptz, '2024-09-07 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-09-07 15:51:00'::timestamptz); END IF;

  -- CC773
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 72;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC773', 'Mary Drake', false, 'completed', false, 6.50, 0.00, 0, 0.00, 6.50, 0.00, 0, 4, '0', '2024-09-07 00:00:00'::timestamptz, '2024-09-08 09:06:00'::timestamptz, '2024-09-07 15:59:00'::timestamptz, '2024-09-07 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-09-07 15:59:00'::timestamptz); END IF;

  -- CC774
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 42;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC774', 'Milagros Aranda', false, 'completed', false, 10.00, 0.00, 0, 0.00, 10.00, 0.00, 0, 6, '0', '2024-09-07 00:00:00'::timestamptz, '2024-09-08 09:06:00'::timestamptz, '2024-09-07 16:00:00'::timestamptz, '2024-09-07 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-07 16:00:00'::timestamptz); END IF;

  -- CC775
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC775', 'Retail', true, 'completed', false, 1.47, 0.03, 0, 0.03, 1.50, 0.00, 0, 3, '', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 00:00:00'::timestamptz, '2024-09-07 17:01:00'::timestamptz, '2024-09-07 17:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-09-07 17:01:00'::timestamptz); END IF;

  -- CC776
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC776', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-07 00:00:00'::timestamptz, '2024-09-07 00:00:00'::timestamptz, '2024-09-07 17:24:00'::timestamptz, '2024-09-07 17:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-07 17:24:00'::timestamptz); END IF;

  -- CC777
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 73;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC777', 'Noel Hidalgo', false, 'completed', false, 8.50, 0.00, 0, 0.00, 8.50, 0.00, 0, 5, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 11:24:00'::timestamptz, '2024-09-08 09:37:00'::timestamptz, '2024-09-08 09:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-09-08 09:37:00'::timestamptz); END IF;

  -- CC778
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC778', 'Samuel Colinas', false, 'completed', false, 7.63, 0.00, 0, 0.53, 8.16, 3.05, 1, 1, '0', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 15:26:00'::timestamptz, '2024-09-08 11:17:00'::timestamptz, '2024-09-08 11:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.16 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.16, '2024-09-08 11:17:00'::timestamptz); END IF;

  -- CC779
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC779', 'Liliana', false, 'completed', false, 6.00, 0.00, 0, 0.00, 6.00, 0.00, 0, 3, '0', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 13:21:00'::timestamptz, '2024-09-08 11:23:00'::timestamptz, '2024-09-08 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-08 11:23:00'::timestamptz); END IF;

  -- CC780
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC780', 'Cristina Lau', false, 'completed', false, 11.86, 0.14, 0, 0.14, 12.00, 0.00, 0, 7, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 13:41:00'::timestamptz, '2024-09-08 12:50:00'::timestamptz, '2024-09-08 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-09-08 12:50:00'::timestamptz); END IF;

  -- CC781
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 75;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC781', 'Genesis Hassan', false, 'completed', false, 9.00, 0.00, 0, 0.07, 9.07, 0.00, 0, 5, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-08 15:26:00'::timestamptz, '2024-09-08 13:07:00'::timestamptz, '2024-09-08 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.07, '2024-09-08 13:07:00'::timestamptz); END IF;

  -- CC782
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC782', 'Cristina Lau', false, 'completed', false, 8.00, 0.00, 0, 0.00, 8.00, 0.00, 0, 4, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 15:02:00'::timestamptz, '2024-09-08 13:40:00'::timestamptz, '2024-09-08 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-08 13:40:00'::timestamptz); END IF;

  -- CC783
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 76;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC783', 'Hector Martinez', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 15:02:00'::timestamptz, '2024-09-08 13:41:00'::timestamptz, '2024-09-08 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-08 13:41:00'::timestamptz); END IF;

  -- CC784
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 77;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC784', 'Angel Zabala', false, 'completed', false, 10.36, 0.14, 0, 0.14, 10.50, 0.00, 0, 7, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-09 10:12:00'::timestamptz, '2024-09-08 14:02:00'::timestamptz, '2024-09-08 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-09-08 14:02:00'::timestamptz); END IF;

  -- CC785
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 78;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC785', 'Francisco Medina', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, 'Lavandería', '2024-09-08 00:00:00'::timestamptz, '2024-09-09 10:12:00'::timestamptz, '2024-09-08 14:06:00'::timestamptz, '2024-09-08 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-08 14:06:00'::timestamptz); END IF;

  -- CC786
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC786', 'Gisselle', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, '0', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 15:24:00'::timestamptz, '2024-09-08 14:35:00'::timestamptz, '2024-09-08 14:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-08 14:35:00'::timestamptz); END IF;

  -- CC787
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC787', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-09-08 00:00:00'::timestamptz, '2024-09-08 00:00:00'::timestamptz, '2024-09-08 15:54:00'::timestamptz, '2024-09-08 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-08 15:54:00'::timestamptz); END IF;

  -- CC788
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC788', 'Leonel Visueti', false, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 2, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 12:46:00'::timestamptz, '2024-09-09 10:11:00'::timestamptz, '2024-09-09 10:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-09 10:11:00'::timestamptz); END IF;

  -- CC789
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC789', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 00:00:00'::timestamptz, '2024-09-09 10:58:00'::timestamptz, '2024-09-09 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-09 10:58:00'::timestamptz); END IF;

  -- CC790
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC790', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 00:00:00'::timestamptz, '2024-09-09 11:43:00'::timestamptz, '2024-09-09 11:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-09 11:43:00'::timestamptz); END IF;

  -- CC791
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 79;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC791', 'Mini May Garita', false, 'completed', false, 4.93, 0.07, 0, 0.07, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 15:52:00'::timestamptz, '2024-09-09 12:44:00'::timestamptz, '2024-09-09 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-09 12:44:00'::timestamptz); END IF;

  -- CC792
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC792', 'Cliente Lavandería', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 14:14:00'::timestamptz, '2024-09-09 12:45:00'::timestamptz, '2024-09-09 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-09 12:45:00'::timestamptz); END IF;

  -- CC793
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC793', 'Leonel Visueti', false, 'completed', false, 9.86, 0.14, 0, 0.14, 10.00, 0.00, 0, 6, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 15:52:00'::timestamptz, '2024-09-09 14:15:00'::timestamptz, '2024-09-09 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-09 14:15:00'::timestamptz); END IF;

  -- CC794
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC794', 'Cliente Lavandería', false, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 15:52:00'::timestamptz, '2024-09-09 14:44:00'::timestamptz, '2024-09-09 14:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-09 14:44:00'::timestamptz); END IF;

  -- CC795
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC795', 'Retail', true, 'completed', false, 1.17, 0.08, 0, 0.08, 1.25, 0.00, 0, 1, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 00:00:00'::timestamptz, '2024-09-09 14:51:00'::timestamptz, '2024-09-09 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-09-09 14:51:00'::timestamptz); END IF;

  -- CC796
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC796', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 00:00:00'::timestamptz, '2024-09-09 15:39:00'::timestamptz, '2024-09-09 15:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-09 15:39:00'::timestamptz); END IF;

  -- CC797
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC797', 'Erick Rodriguez', false, 'completed', false, 4.74, 0.00, 0, 0.33, 5.07, 0.00, 0, 3, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 18:05:00'::timestamptz, '2024-09-09 16:11:00'::timestamptz, '2024-09-09 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.07, '2024-09-09 16:11:00'::timestamptz); END IF;

  -- CC798
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC798', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-09 00:00:00'::timestamptz, '2024-09-09 00:00:00'::timestamptz, '2024-09-09 16:33:00'::timestamptz, '2024-09-09 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-09 16:33:00'::timestamptz); END IF;

  -- CC799
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC799', 'Dalvis Ojo', false, 'completed', false, 14.02, 0.20, 0, 0.98, 15.00, 0.00, 0, 9, 'Lavandería', '2024-09-09 00:00:00'::timestamptz, '2024-09-10 08:12:00'::timestamptz, '2024-09-09 17:33:00'::timestamptz, '2024-09-09 17:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-09-09 17:33:00'::timestamptz); END IF;

  -- CC800
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC800', 'Guzmán', false, 'completed', false, 5.51, 0.00, 0, 0.39, 5.90, 3.15, 1, 1, '', '2024-09-10 00:00:00'::timestamptz, '2024-09-10 08:12:00'::timestamptz, '2024-09-10 07:48:00'::timestamptz, '2024-09-10 07:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.90 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.90, '2024-09-10 07:48:00'::timestamptz); END IF;

  -- CC801
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC801', 'Guzmán', false, 'completed', false, 3.94, 0.00, 0, 0.28, 4.22, 2.25, 1, 1, '', '2024-09-10 00:00:00'::timestamptz, '2024-09-10 15:01:00'::timestamptz, '2024-09-10 11:31:00'::timestamptz, '2024-09-10 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.22 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.22, '2024-09-10 11:31:00'::timestamptz); END IF;

  -- CC802
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC802', 'Dalvis Ojo', false, 'completed', false, 9.15, 0.00, 0, 0.64, 9.79, 0.00, 0, 23, 'Lavandería', '2024-09-10 00:00:00'::timestamptz, '2024-09-13 14:11:00'::timestamptz, '2024-09-10 11:37:00'::timestamptz, '2024-09-10 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.79, '2024-09-10 11:37:00'::timestamptz); END IF;

  -- CC803
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC803', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 4.80, 2, 1, 'Salón', '2024-09-10 00:00:00'::timestamptz, '2024-09-10 13:12:00'::timestamptz, '2024-09-10 12:57:00'::timestamptz, '2024-09-10 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-09-10 12:57:00'::timestamptz); END IF;

  -- CC804
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC804', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-09-10 00:00:00'::timestamptz, '2024-09-10 14:54:00'::timestamptz, '2024-09-10 14:09:00'::timestamptz, '2024-09-10 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-10 14:09:00'::timestamptz); END IF;

  -- CC805
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC805', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-09-10 00:00:00'::timestamptz, '2024-09-10 00:00:00'::timestamptz, '2024-09-10 16:37:00'::timestamptz, '2024-09-10 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-10 16:37:00'::timestamptz); END IF;

  -- CC806
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC806', 'Cliente Lavandería', false, 'completed', false, 5.17, 0.07, 0, 0.33, 5.50, 0.00, 0, 4, 'Lavandería', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 16:23:00'::timestamptz, '2024-09-11 11:37:00'::timestamptz, '2024-09-11 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-09-11 11:37:00'::timestamptz); END IF;

  -- CC807
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC807', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 16:23:00'::timestamptz, '2024-09-11 14:21:00'::timestamptz, '2024-09-11 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-11 14:21:00'::timestamptz); END IF;

  -- CC808
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC808', 'Leonel Visueti', false, 'completed', false, 8.11, 0.00, 0, 0.39, 8.50, 0.00, 0, 5, '', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 16:23:00'::timestamptz, '2024-09-11 14:24:00'::timestamptz, '2024-09-11 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-09-11 14:24:00'::timestamptz); END IF;

  -- CC809
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC809', 'Yara Rangel', false, 'completed', false, 21.56, 0.14, 0, 1.44, 23.00, 0.00, 0, 13, '0', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 17:52:00'::timestamptz, '2024-09-11 15:09:00'::timestamptz, '2024-09-11 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.00, '2024-09-11 15:09:00'::timestamptz); END IF;

  -- CC810
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC810', 'Retail', true, 'completed', false, 2.75, 0.00, 0, 0.00, 2.75, 0.00, 0, 3, '', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 00:00:00'::timestamptz, '2024-09-11 15:55:00'::timestamptz, '2024-09-11 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2024-09-11 15:55:00'::timestamptz); END IF;

  -- CC811
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC811', 'Yara Rangel', false, 'completed', false, 19.32, 0.27, 0, 1.18, 20.50, 0.00, 0, 15, '0', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 17:52:00'::timestamptz, '2024-09-11 16:01:00'::timestamptz, '2024-09-11 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.50, '2024-09-11 16:01:00'::timestamptz); END IF;

  -- CC812
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 80;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC812', 'Viala Rosene', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.25, 1, 1, 'Lavandería', '2024-09-11 00:00:00'::timestamptz, '2024-09-12 14:26:00'::timestamptz, '2024-09-11 16:14:00'::timestamptz, '2024-09-11 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-09-11 16:14:00'::timestamptz); END IF;

  -- CC814
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC814', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-11 00:00:00'::timestamptz, '2024-09-11 00:00:00'::timestamptz, '2024-09-11 17:44:00'::timestamptz, '2024-09-11 17:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-11 17:44:00'::timestamptz); END IF;

  -- CC815
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC815', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-12 00:00:00'::timestamptz, '2024-09-12 13:38:00'::timestamptz, '2024-09-12 13:37:00'::timestamptz, '2024-09-12 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-12 13:37:00'::timestamptz); END IF;

  -- CC816
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC816', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-12 00:00:00'::timestamptz, '2024-09-12 16:07:00'::timestamptz, '2024-09-12 14:28:00'::timestamptz, '2024-09-12 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-12 14:28:00'::timestamptz); END IF;

  -- CC817
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC817', 'Leonel Visueti', false, 'completed', false, 10.28, 0.07, 0, 0.72, 11.00, 0.00, 0, 6, '', '2024-09-12 00:00:00'::timestamptz, '2024-09-13 08:35:00'::timestamptz, '2024-09-12 16:05:00'::timestamptz, '2024-09-12 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-09-12 16:05:00'::timestamptz); END IF;

  -- CC818
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC818', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-12 00:00:00'::timestamptz, '2024-09-13 08:35:00'::timestamptz, '2024-09-12 16:06:00'::timestamptz, '2024-09-12 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-12 16:06:00'::timestamptz); END IF;

  -- CC819
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC819', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-09-12 00:00:00'::timestamptz, '2024-09-12 00:00:00'::timestamptz, '2024-09-12 16:37:00'::timestamptz, '2024-09-12 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-09-12 16:37:00'::timestamptz); END IF;

  -- CC820
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC820', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 10:44:00'::timestamptz, '2024-09-13 08:05:00'::timestamptz, '2024-09-13 08:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-13 08:05:00'::timestamptz); END IF;

  -- CC821
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC821', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.11, 1.61, 0.00, 0, 3, '', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 00:00:00'::timestamptz, '2024-09-13 08:20:00'::timestamptz, '2024-09-13 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.61, '2024-09-13 08:20:00'::timestamptz); END IF;

  -- CC822
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 81;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC822', 'Yelibeth Castillero', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 10:58:00'::timestamptz, '2024-09-13 08:31:00'::timestamptz, '2024-09-13 08:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-09-13 08:31:00'::timestamptz); END IF;

  -- CC823
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 81;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC823', 'Yelibeth Castillero', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 10:58:00'::timestamptz, '2024-09-13 09:48:00'::timestamptz, '2024-09-13 09:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-13 09:48:00'::timestamptz); END IF;

  -- CC824
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 14;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC824', 'Melissa VanSice', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 15:15:00'::timestamptz, '2024-09-13 11:16:00'::timestamptz, '2024-09-13 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-13 11:16:00'::timestamptz); END IF;

  -- CC825
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC825', 'Guzmán', false, 'completed', false, 13.75, 0.00, 0, 0.96, 14.71, 5.50, 3, 1, '', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 14:15:00'::timestamptz, '2024-09-13 12:41:00'::timestamptz, '2024-09-13 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.71 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.71, '2024-09-13 12:41:00'::timestamptz); END IF;

  -- CC826
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC826', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2024-09-13 00:00:00'::timestamptz, '2024-09-14 09:18:00'::timestamptz, '2024-09-13 14:39:00'::timestamptz, '2024-09-13 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-09-13 14:39:00'::timestamptz); END IF;

  -- CC827
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC827', 'Rene Guiñez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-09-13 00:00:00'::timestamptz, '2024-09-14 09:18:00'::timestamptz, '2024-09-13 15:19:00'::timestamptz, '2024-09-13 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-13 15:19:00'::timestamptz); END IF;

  -- CC828
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC828', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 00:00:00'::timestamptz, '2024-09-13 16:33:00'::timestamptz, '2024-09-13 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-13 16:33:00'::timestamptz); END IF;

  -- CC829
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC829', 'Juan David VanSice', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, 'Perlas de Olor: Media,Tipo de suavizante: Sin suavizante', '2024-09-13 00:00:00'::timestamptz, '2024-09-13 16:38:00'::timestamptz, '2024-09-13 16:34:00'::timestamptz, '2024-09-13 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-13 16:34:00'::timestamptz); END IF;

  -- CC830
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC830', 'Yatzury Anderson', false, 'completed', false, 5.74, 0.00, 0, 0.40, 6.14, 0.00, 0, 3, '', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 14:18:00'::timestamptz, '2024-09-14 09:16:00'::timestamptz, '2024-09-14 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.14 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.14, '2024-09-14 09:16:00'::timestamptz); END IF;

  -- CC831
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC831', 'Daniel Camarena', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 11:07:00'::timestamptz, '2024-09-14 09:40:00'::timestamptz, '2024-09-14 09:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-14 09:40:00'::timestamptz); END IF;

  -- CC832
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC832', 'Octavio Cherigo', false, 'completed', false, 7.78, 0.00, 0, 0.54, 8.32, 2.65, 1, 4, 'Lavandería', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:20:00'::timestamptz, '2024-09-14 13:11:00'::timestamptz, '2024-09-14 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.32 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.32, '2024-09-14 13:11:00'::timestamptz); END IF;

  -- CC833
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC833', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 21.13, 0.00, 0, 1.48, 22.61, 8.45, 2, 1, 'Salón', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 14:18:00'::timestamptz, '2024-09-14 14:13:00'::timestamptz, '2024-09-14 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.61, '2024-09-14 14:13:00'::timestamptz); END IF;

  -- CC834
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 82;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC834', 'Gladys Duque', false, 'completed', false, 21.99, 0.34, 0, 1.51, 23.50, 0.00, 0, 15, '0', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:49:00'::timestamptz, '2024-09-14 14:37:00'::timestamptz, '2024-09-14 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.50, '2024-09-14 14:37:00'::timestamptz); END IF;

  -- CC835
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC835', 'Fernando Ortega', false, 'completed', false, 3.12, 0.00, 0, 0.13, 3.25, 0.00, 0, 2, '', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:49:00'::timestamptz, '2024-09-14 15:28:00'::timestamptz, '2024-09-14 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-09-14 15:28:00'::timestamptz); END IF;

  -- CC836
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC836', 'Retail', true, 'completed', false, 7.75, 0.00, 0, 0.00, 7.75, 0.00, 0, 11, '', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:42:00'::timestamptz, '2024-09-14 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.75, '2024-09-14 16:42:00'::timestamptz); END IF;

  -- CC837
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC837', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:49:00'::timestamptz, '2024-09-14 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-14 16:49:00'::timestamptz); END IF;

  -- CC838
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC838', 'Retail', true, 'completed', false, 0.65, 0.00, 0, 0.05, 0.70, 0.00, 0, 2, '', '2024-09-14 00:00:00'::timestamptz, '2024-09-14 00:00:00'::timestamptz, '2024-09-14 16:55:00'::timestamptz, '2024-09-14 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.70, '2024-09-14 16:55:00'::timestamptz); END IF;

  -- CC839
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC839', 'Samuel Colinas', false, 'completed', false, 13.09, 0.00, 0, 0.92, 14.01, 0.00, 0, 7, '0', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 13:02:00'::timestamptz, '2024-09-15 10:35:00'::timestamptz, '2024-09-15 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.01, '2024-09-15 10:35:00'::timestamptz); END IF;

  -- CC840
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC840', 'Cristina Lau', false, 'completed', false, 14.95, 0.01, 0, 1.05, 16.00, 0.00, 0, 8, 'Lavandería', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 14:26:00'::timestamptz, '2024-09-15 12:27:00'::timestamptz, '2024-09-15 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-09-15 12:27:00'::timestamptz); END IF;

  -- CC841
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC841', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 14:26:00'::timestamptz, '2024-09-15 12:35:00'::timestamptz, '2024-09-15 12:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-15 12:35:00'::timestamptz); END IF;

  -- CC842
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC842', 'Cristina Lau', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavandería', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 00:00:00'::timestamptz, '2024-09-15 13:11:00'::timestamptz, '2024-09-15 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-15 13:11:00'::timestamptz); END IF;

  -- CC843
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC843', 'Yatzury Anderson', true, 'completed', false, 2.93, 0.07, 0, 0.07, 3.00, 0.00, 0, 3, '', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 00:00:00'::timestamptz, '2024-09-15 13:12:00'::timestamptz, '2024-09-15 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-15 13:12:00'::timestamptz); END IF;

  -- CC846
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC846', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-15 00:00:00'::timestamptz, '2024-09-16 08:30:00'::timestamptz, '2024-09-15 14:04:00'::timestamptz, '2024-09-15 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-15 14:04:00'::timestamptz); END IF;

  -- CC847
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC847', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-09-15 00:00:00'::timestamptz, '2024-09-15 00:00:00'::timestamptz, '2024-09-15 15:33:00'::timestamptz, '2024-09-15 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-15 15:33:00'::timestamptz); END IF;

  -- CC848
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC848', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 09:09:00'::timestamptz, '2024-09-16 08:20:00'::timestamptz, '2024-09-16 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-16 08:20:00'::timestamptz); END IF;

  -- CC849
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC849', 'Guzmán', false, 'completed', false, 1.84, 0.00, 0, 0.13, 1.97, 1.05, 1, 1, '', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 09:09:00'::timestamptz, '2024-09-16 09:02:00'::timestamptz, '2024-09-16 09:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.97, '2024-09-16 09:02:00'::timestamptz); END IF;

  -- CC850
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC850', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 00:00:00'::timestamptz, '2024-09-16 10:26:00'::timestamptz, '2024-09-16 10:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-16 10:26:00'::timestamptz); END IF;

  -- CC851
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC851', 'Sara Charles', false, 'completed', false, 9.85, 0.13, 0, 0.65, 10.50, 0.00, 0, 7, 'Lavandería', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 15:43:00'::timestamptz, '2024-09-16 11:24:00'::timestamptz, '2024-09-16 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-09-16 11:24:00'::timestamptz); END IF;

  -- CC852
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC852', 'Liliana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 13:40:00'::timestamptz, '2024-09-16 11:59:00'::timestamptz, '2024-09-16 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-16 11:59:00'::timestamptz); END IF;

  -- CC853
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC853', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.13, 0.00, 0, 1.06, 16.19, 6.05, 2, 1, 'Salón', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 15:43:00'::timestamptz, '2024-09-16 13:00:00'::timestamptz, '2024-09-16 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.19 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.19, '2024-09-16 13:00:00'::timestamptz); END IF;

  -- CC854
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC854', 'Sheila Simons', false, 'completed', false, 14.95, 0.01, 0, 1.05, 16.00, 0.00, 0, 8, '0', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 15:44:00'::timestamptz, '2024-09-16 13:39:00'::timestamptz, '2024-09-16 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-09-16 13:39:00'::timestamptz); END IF;

  -- CC855
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 84;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC855', 'Julia Sandoval', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 15:43:00'::timestamptz, '2024-09-16 14:00:00'::timestamptz, '2024-09-16 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-16 14:00:00'::timestamptz); END IF;

  -- CC856
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC856', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 00:00:00'::timestamptz, '2024-09-16 15:44:00'::timestamptz, '2024-09-16 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-16 15:44:00'::timestamptz); END IF;

  -- CC857
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 85;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC857', 'Roberto Vasquez', false, 'completed', false, 23.36, 0.34, 0, 1.64, 25.00, 0.00, 0, 15, 'Lavandería', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 18:09:00'::timestamptz, '2024-09-16 15:59:00'::timestamptz, '2024-09-16 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.00, '2024-09-16 15:59:00'::timestamptz); END IF;

  -- CC858
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC858', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-09-16 00:00:00'::timestamptz, '2024-09-16 00:00:00'::timestamptz, '2024-09-16 16:53:00'::timestamptz, '2024-09-16 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-16 16:53:00'::timestamptz); END IF;

  -- CC859
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC859', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-17 00:00:00'::timestamptz, '2024-09-17 13:21:00'::timestamptz, '2024-09-17 09:29:00'::timestamptz, '2024-09-17 09:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-17 09:29:00'::timestamptz); END IF;

  -- CC860
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC860', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-09-17 00:00:00'::timestamptz, '2024-09-17 13:22:00'::timestamptz, '2024-09-17 12:37:00'::timestamptz, '2024-09-17 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-17 12:37:00'::timestamptz); END IF;

  -- CC861
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC861', 'Aaron Gutierrez', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavandería', '2024-09-17 00:00:00'::timestamptz, '2024-09-17 15:33:00'::timestamptz, '2024-09-17 13:20:00'::timestamptz, '2024-09-17 13:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-09-17 13:20:00'::timestamptz); END IF;

  -- CC862
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC862', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-17 00:00:00'::timestamptz, '2024-09-18 12:04:00'::timestamptz, '2024-09-17 15:02:00'::timestamptz, '2024-09-17 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-17 15:02:00'::timestamptz); END IF;

  -- CC863
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC863', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 7, '', '2024-09-17 00:00:00'::timestamptz, '2024-09-17 00:00:00'::timestamptz, '2024-09-17 16:42:00'::timestamptz, '2024-09-17 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-17 16:42:00'::timestamptz); END IF;

  -- CC864
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC864', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-09-18 00:00:00'::timestamptz, '2024-09-18 16:04:00'::timestamptz, '2024-09-18 11:59:00'::timestamptz, '2024-09-18 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-18 11:59:00'::timestamptz); END IF;

  -- CC865
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC865', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-09-18 00:00:00'::timestamptz, '2024-09-18 16:04:00'::timestamptz, '2024-09-18 14:23:00'::timestamptz, '2024-09-18 14:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-18 14:23:00'::timestamptz); END IF;

  -- CC866
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC866', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 7, '', '2024-09-18 00:00:00'::timestamptz, '2024-09-18 00:00:00'::timestamptz, '2024-09-18 16:05:00'::timestamptz, '2024-09-18 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-18 16:05:00'::timestamptz); END IF;

  -- CC867
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC867', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-18 00:00:00'::timestamptz, '2024-09-18 00:00:00'::timestamptz, '2024-09-18 16:21:00'::timestamptz, '2024-09-18 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-18 16:21:00'::timestamptz); END IF;

  -- CC868
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC868', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.20, 1, 1, '', '2024-09-19 00:00:00'::timestamptz, '2024-09-19 16:05:00'::timestamptz, '2024-09-19 11:18:00'::timestamptz, '2024-09-19 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-09-19 11:18:00'::timestamptz); END IF;

  -- CC869
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC869', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-19 00:00:00'::timestamptz, '2024-09-19 16:05:00'::timestamptz, '2024-09-19 12:49:00'::timestamptz, '2024-09-19 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-19 12:49:00'::timestamptz); END IF;

  -- CC870
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC870', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-19 00:00:00'::timestamptz, '2024-09-19 16:05:00'::timestamptz, '2024-09-19 13:54:00'::timestamptz, '2024-09-19 13:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-19 13:54:00'::timestamptz); END IF;

  -- CC871
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC871', 'Guzmán', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 4.00, 2, 1, '', '2024-09-19 00:00:00'::timestamptz, '2024-09-20 11:41:00'::timestamptz, '2024-09-19 15:08:00'::timestamptz, '2024-09-19 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-09-19 15:08:00'::timestamptz); END IF;

  -- CC872
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC872', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-19 00:00:00'::timestamptz, '2024-09-20 11:41:00'::timestamptz, '2024-09-19 15:10:00'::timestamptz, '2024-09-19 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-19 15:10:00'::timestamptz); END IF;

  -- CC873
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 87;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC873', 'Yajaira Castillo', false, 'completed', false, 19.63, 0.20, 0, 1.37, 21.00, 0.00, 0, 12, '0', '2024-09-19 00:00:00'::timestamptz, '2024-09-19 18:52:00'::timestamptz, '2024-09-19 16:48:00'::timestamptz, '2024-09-19 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.00, '2024-09-19 16:48:00'::timestamptz); END IF;

  -- CC874
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC874', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-19 00:00:00'::timestamptz, '2024-09-19 18:52:00'::timestamptz, '2024-09-19 16:54:00'::timestamptz, '2024-09-19 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-19 16:54:00'::timestamptz); END IF;

  -- CC875
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 86;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC875', 'Yolanda Espinosa', false, 'completed', false, 25.50, 0.00, 0, 1.79, 27.29, 10.20, 4, 1, 'Lavandería', '2024-09-19 00:00:00'::timestamptz, '2024-09-20 10:21:00'::timestamptz, '2024-09-19 19:01:00'::timestamptz, '2024-09-19 19:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.29 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.29, '2024-09-19 19:01:00'::timestamptz); END IF;

  -- CC876
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 88;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC876', 'Marcelis Santana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 11:41:00'::timestamptz, '2024-09-20 09:43:00'::timestamptz, '2024-09-20 09:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-20 09:43:00'::timestamptz); END IF;

  -- CC877
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC877', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 00:00:00'::timestamptz, '2024-09-20 09:45:00'::timestamptz, '2024-09-20 09:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-20 09:45:00'::timestamptz); END IF;

  -- CC878
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 88;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC878', 'Marcelis Santana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 11:41:00'::timestamptz, '2024-09-20 10:27:00'::timestamptz, '2024-09-20 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-20 10:27:00'::timestamptz); END IF;

  -- CC879
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC879', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 21.00, 0.00, 0, 1.47, 22.47, 8.40, 2, 1, 'Salón', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 15:19:00'::timestamptz, '2024-09-20 11:12:00'::timestamptz, '2024-09-20 11:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.47 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.47, '2024-09-20 11:12:00'::timestamptz); END IF;

  -- CC880
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC880', 'Guzmán', false, 'completed', false, 14.88, 0.00, 0, 1.04, 15.92, 5.95, 3, 1, '', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 15:11:00'::timestamptz, '2024-09-20 12:56:00'::timestamptz, '2024-09-20 12:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.92, '2024-09-20 12:56:00'::timestamptz); END IF;

  -- CC881
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC881', 'Leonel Visueti', false, 'completed', false, 8.41, 0.07, 0, 0.59, 9.00, 0.00, 0, 5, '', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 15:43:00'::timestamptz, '2024-09-20 14:00:00'::timestamptz, '2024-09-20 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-09-20 14:00:00'::timestamptz); END IF;

  -- CC882
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC882', 'Sandra Medina', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-09-21 00:00:00'::timestamptz, '2024-09-20 15:59:00'::timestamptz, '2024-09-20 14:14:00'::timestamptz, '2024-09-20 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-20 14:14:00'::timestamptz); END IF;

  -- CC883
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 89;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC883', 'María Sandoval', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '0', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 16:09:00'::timestamptz, '2024-09-20 15:15:00'::timestamptz, '2024-09-20 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-09-20 15:15:00'::timestamptz); END IF;

  -- CC884
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 89;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC884', 'María Sandoval', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 16:09:00'::timestamptz, '2024-09-20 15:15:00'::timestamptz, '2024-09-20 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-20 15:15:00'::timestamptz); END IF;

  -- CC885
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC885', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2024-09-20 00:00:00'::timestamptz, '2024-09-20 00:00:00'::timestamptz, '2024-09-20 16:11:00'::timestamptz, '2024-09-20 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-09-20 16:11:00'::timestamptz); END IF;

  -- CC886
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC886', 'Dalvis Ojo', false, 'completed', false, 8.48, 0.00, 0, 0.59, 9.07, 0.00, 0, 5, 'Lavandería', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 12:04:00'::timestamptz, '2024-09-21 10:35:00'::timestamptz, '2024-09-21 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.07, '2024-09-21 10:35:00'::timestamptz); END IF;

  -- CC887
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC887', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 00:00:00'::timestamptz, '2024-09-21 11:20:00'::timestamptz, '2024-09-21 11:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-21 11:20:00'::timestamptz); END IF;

  -- CC888
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC888', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-09-22 00:00:00'::timestamptz, '2024-09-21 12:46:00'::timestamptz, '2024-09-21 11:21:00'::timestamptz, '2024-09-21 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-21 11:21:00'::timestamptz); END IF;

  -- CC889
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC889', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 00:00:00'::timestamptz, '2024-09-21 12:03:00'::timestamptz, '2024-09-21 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-21 12:03:00'::timestamptz); END IF;

  -- CC890
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 90;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC890', 'Marisol Gonzalez', false, 'completed', false, 14.02, 0.20, 0, 0.98, 15.00, 0.00, 0, 9, 'Lavandería', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 14:12:00'::timestamptz, '2024-09-21 12:45:00'::timestamptz, '2024-09-21 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-09-21 12:45:00'::timestamptz); END IF;

  -- CC891
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC891', 'Octavio Cherigo', false, 'completed', false, 9.38, 0.00, 0, 0.66, 10.04, 3.55, 1, 2, 'Lavandería', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 14:48:00'::timestamptz, '2024-09-21 14:19:00'::timestamptz, '2024-09-21 14:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.04 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.04, '2024-09-21 14:19:00'::timestamptz); END IF;

  -- CC892
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC892', 'Virginia Gonzalez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 16:06:00'::timestamptz, '2024-09-21 15:30:00'::timestamptz, '2024-09-21 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-21 15:30:00'::timestamptz); END IF;

  -- CC893
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC893', 'Virginia Gonzalez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-21 00:00:00'::timestamptz, '2024-09-22 11:08:00'::timestamptz, '2024-09-21 16:06:00'::timestamptz, '2024-09-21 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-21 16:06:00'::timestamptz); END IF;

  -- CC894
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC894', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 00:00:00'::timestamptz, '2024-09-21 16:07:00'::timestamptz, '2024-09-21 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-21 16:07:00'::timestamptz); END IF;

  -- CC895
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC895', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-09-21 00:00:00'::timestamptz, '2024-09-21 00:00:00'::timestamptz, '2024-09-21 16:13:00'::timestamptz, '2024-09-21 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-21 16:13:00'::timestamptz); END IF;

  -- CC896
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC896', 'Sara Charles', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 12:03:00'::timestamptz, '2024-09-22 11:01:00'::timestamptz, '2024-09-22 11:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-22 11:01:00'::timestamptz); END IF;

  -- CC897
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC897', 'Daniel Camarena', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 12:46:00'::timestamptz, '2024-09-22 11:05:00'::timestamptz, '2024-09-22 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-22 11:05:00'::timestamptz); END IF;

  -- CC898
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC898', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 12:03:00'::timestamptz, '2024-09-22 11:10:00'::timestamptz, '2024-09-22 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-22 11:10:00'::timestamptz); END IF;

  -- CC899
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC899', 'Fany Luz Salon', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 12:03:00'::timestamptz, '2024-09-22 11:21:00'::timestamptz, '2024-09-22 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-22 11:21:00'::timestamptz); END IF;

  -- CC900
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC900', 'Cristina Lau', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 16:16:00'::timestamptz, '2024-09-22 14:38:00'::timestamptz, '2024-09-22 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-22 14:38:00'::timestamptz); END IF;

  -- CC901
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC901', 'Cristina Lau', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 16:16:00'::timestamptz, '2024-09-22 15:30:00'::timestamptz, '2024-09-22 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-22 15:30:00'::timestamptz); END IF;

  -- CC902
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC902', 'Cristina Lau', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavandería', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 00:00:00'::timestamptz, '2024-09-22 15:40:00'::timestamptz, '2024-09-22 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-22 15:40:00'::timestamptz); END IF;

  -- CC903
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC903', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-09-22 00:00:00'::timestamptz, '2024-09-22 00:00:00'::timestamptz, '2024-09-22 15:42:00'::timestamptz, '2024-09-22 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-22 15:42:00'::timestamptz); END IF;

  -- CC904
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 89;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC904', 'María Sandoval', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 09:52:00'::timestamptz, '2024-09-23 08:20:00'::timestamptz, '2024-09-23 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-23 08:20:00'::timestamptz); END IF;

  -- CC905
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC905', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.50, 0.00, 0, 1.09, 16.59, 6.20, 2, 1, 'Salón', '2024-09-24 00:00:00'::timestamptz, '2024-09-23 13:57:00'::timestamptz, '2024-09-23 13:37:00'::timestamptz, '2024-09-23 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.59, '2024-09-23 13:37:00'::timestamptz); END IF;

  -- CC906
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC906', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 13:42:00'::timestamptz, '2024-09-23 13:41:00'::timestamptz, '2024-09-23 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-23 13:41:00'::timestamptz); END IF;

  -- CC907
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC907', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 14:48:00'::timestamptz, '2024-09-23 13:43:00'::timestamptz, '2024-09-23 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-23 13:43:00'::timestamptz); END IF;

  -- CC908
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC908', 'Lineth', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 16:17:00'::timestamptz, '2024-09-23 14:00:00'::timestamptz, '2024-09-23 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-23 14:00:00'::timestamptz); END IF;

  -- CC909
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC909', 'Manuel Rueda', false, 'completed', false, 4.67, 0.20, 0, 0.33, 5.00, 0.00, 0, 4, 'Lavandería', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 14:54:00'::timestamptz, '2024-09-23 14:11:00'::timestamptz, '2024-09-23 14:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-23 14:11:00'::timestamptz); END IF;

  -- CC910
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC910', 'Guzmán', false, 'completed', false, 5.25, 0.00, 0, 0.37, 5.62, 3.00, 1, 1, '', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 14:48:00'::timestamptz, '2024-09-23 14:12:00'::timestamptz, '2024-09-23 14:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.62 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.62, '2024-09-23 14:12:00'::timestamptz); END IF;

  -- CC911
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC911', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 00:00:00'::timestamptz, '2024-09-23 16:05:00'::timestamptz, '2024-09-23 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-23 16:05:00'::timestamptz); END IF;

  -- CC912
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC912', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 16:17:00'::timestamptz, '2024-09-23 16:07:00'::timestamptz, '2024-09-23 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-23 16:07:00'::timestamptz); END IF;

  -- CC913
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC913', 'Yara Rangel', false, 'completed', false, 12.21, 0.01, 0, 0.79, 13.00, 0.00, 0, 7, '0', '2024-09-23 00:00:00'::timestamptz, '2024-09-24 12:12:00'::timestamptz, '2024-09-23 16:16:00'::timestamptz, '2024-09-23 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2024-09-23 16:16:00'::timestamptz); END IF;

  -- CC914
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC914', 'Yara Rangel', false, 'completed', false, 11.71, 0.01, 0, 0.79, 12.50, 0.00, 0, 7, '0', '2024-09-23 00:00:00'::timestamptz, '2024-09-24 12:12:00'::timestamptz, '2024-09-23 16:49:00'::timestamptz, '2024-09-23 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.50, '2024-09-23 16:49:00'::timestamptz); END IF;

  -- CC915
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC915', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 4, '', '2024-09-23 00:00:00'::timestamptz, '2024-09-23 00:00:00'::timestamptz, '2024-09-23 16:50:00'::timestamptz, '2024-09-23 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-09-23 16:50:00'::timestamptz); END IF;

  -- CC916
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC916', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-24 00:00:00'::timestamptz, '2024-09-24 16:48:00'::timestamptz, '2024-09-24 12:12:00'::timestamptz, '2024-09-24 12:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-24 12:12:00'::timestamptz); END IF;

  -- CC917
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC917', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-09-24 00:00:00'::timestamptz, '2024-09-24 12:59:00'::timestamptz, '2024-09-24 12:14:00'::timestamptz, '2024-09-24 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-24 12:14:00'::timestamptz); END IF;

  -- CC918
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC918', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-24 00:00:00'::timestamptz, '2024-09-24 12:59:00'::timestamptz, '2024-09-24 12:14:00'::timestamptz, '2024-09-24 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-24 12:14:00'::timestamptz); END IF;

  -- CC919
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC919', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-09-24 00:00:00'::timestamptz, '2024-09-24 16:48:00'::timestamptz, '2024-09-24 12:59:00'::timestamptz, '2024-09-24 12:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-24 12:59:00'::timestamptz); END IF;

  -- CC920
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC920', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-09-24 00:00:00'::timestamptz, '2024-09-24 00:00:00'::timestamptz, '2024-09-24 16:49:00'::timestamptz, '2024-09-24 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-09-24 16:49:00'::timestamptz); END IF;

  -- CC921
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC921', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 10:57:00'::timestamptz, '2024-09-25 08:54:00'::timestamptz, '2024-09-25 08:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-25 08:54:00'::timestamptz); END IF;

  -- CC922
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC922', 'Leonel Visueti', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 17:03:00'::timestamptz, '2024-09-25 11:12:00'::timestamptz, '2024-09-25 11:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-09-25 11:12:00'::timestamptz); END IF;

  -- CC923
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 93;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC923', 'Mirleidis Ferrer', false, 'completed', false, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0, 'App order: Durante la tarde  Perlas de Olor: Fuerte, Tipo de suavizante: Con Suavizante', '2024-09-26 00:00:00'::timestamptz, '2024-09-28 13:42:00'::timestamptz, '2024-09-25 12:00:00'::timestamptz, '2024-09-25 12:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2024-09-25 12:00:00'::timestamptz); END IF;

  -- CC924
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC924', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 16:09:00'::timestamptz, '2024-09-25 14:39:00'::timestamptz, '2024-09-25 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-25 14:39:00'::timestamptz); END IF;

  -- CC925
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 54;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC925', 'Miguel Arauz', false, 'completed', false, 9.47, 0.14, 0, 0.53, 10.00, 0.00, 0, 7, '0', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 17:03:00'::timestamptz, '2024-09-25 14:49:00'::timestamptz, '2024-09-25 14:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-09-25 14:49:00'::timestamptz); END IF;

  -- CC926
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC926', 'Rene Guiñez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 17:03:00'::timestamptz, '2024-09-25 15:55:00'::timestamptz, '2024-09-25 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-25 15:55:00'::timestamptz); END IF;

  -- CC927
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC927', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 17:03:00'::timestamptz, '2024-09-25 15:57:00'::timestamptz, '2024-09-25 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-25 15:57:00'::timestamptz); END IF;

  -- CC928
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC928', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2024-09-25 00:00:00'::timestamptz, '2024-09-25 00:00:00'::timestamptz, '2024-09-25 16:35:00'::timestamptz, '2024-09-25 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-25 16:35:00'::timestamptz); END IF;

  -- CC929
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC929', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-26 00:00:00'::timestamptz, '2024-09-26 16:54:00'::timestamptz, '2024-09-26 10:12:00'::timestamptz, '2024-09-26 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-26 10:12:00'::timestamptz); END IF;

  -- CC930
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC930', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 3, '', '2024-09-26 00:00:00'::timestamptz, '2024-09-26 16:56:00'::timestamptz, '2024-09-26 16:54:00'::timestamptz, '2024-09-26 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-09-26 16:54:00'::timestamptz); END IF;

  -- CC931
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC931', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-26 00:00:00'::timestamptz, '2024-09-26 16:56:00'::timestamptz, '2024-09-26 16:55:00'::timestamptz, '2024-09-26 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-26 16:55:00'::timestamptz); END IF;

  -- CC932
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC932', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-09-26 00:00:00'::timestamptz, '2024-09-27 14:47:00'::timestamptz, '2024-09-26 16:55:00'::timestamptz, '2024-09-26 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-26 16:55:00'::timestamptz); END IF;

  -- CC933
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC933', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2024-09-26 00:00:00'::timestamptz, '2024-09-26 00:00:00'::timestamptz, '2024-09-26 16:56:00'::timestamptz, '2024-09-26 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-26 16:56:00'::timestamptz); END IF;

  -- CC934
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC934', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:47:00'::timestamptz, '2024-09-27 10:04:00'::timestamptz, '2024-09-27 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-27 10:04:00'::timestamptz); END IF;

  -- CC935
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC935', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:46:00'::timestamptz, '2024-09-27 10:07:00'::timestamptz, '2024-09-27 10:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-09-27 10:07:00'::timestamptz); END IF;

  -- CC936
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 64;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC936', 'Alexander Aguilar', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:47:00'::timestamptz, '2024-09-27 11:48:00'::timestamptz, '2024-09-27 11:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-27 11:48:00'::timestamptz); END IF;

  -- CC937
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC937', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 20.00, 0.00, 0, 1.40, 21.40, 8.00, 2, 1, 'Salón', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:46:00'::timestamptz, '2024-09-27 12:11:00'::timestamptz, '2024-09-27 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.40, '2024-09-27 12:11:00'::timestamptz); END IF;

  -- CC939
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC939', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.35, 1, 1, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:49:00'::timestamptz, '2024-09-27 12:42:00'::timestamptz, '2024-09-27 12:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-09-27 12:42:00'::timestamptz); END IF;

  -- CC940
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC940', 'Retail', true, 'completed', false, 0.65, 0.00, 0, 0.05, 0.70, 0.00, 0, 2, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 00:00:00'::timestamptz, '2024-09-27 12:55:00'::timestamptz, '2024-09-27 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.70, '2024-09-27 12:55:00'::timestamptz); END IF;

  -- CC941
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC941', 'Guzmán', false, 'completed', false, 17.13, 0.00, 0, 1.20, 18.33, 6.85, 3, 1, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:49:00'::timestamptz, '2024-09-27 13:11:00'::timestamptz, '2024-09-27 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.33 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.33, '2024-09-27 13:11:00'::timestamptz); END IF;

  -- CC943
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC943', 'Guzmán', false, 'completed', false, 7.35, 0.00, 0, 0.51, 7.86, 4.20, 1, 1, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 14:47:00'::timestamptz, '2024-09-27 14:36:00'::timestamptz, '2024-09-27 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.86 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.86, '2024-09-27 14:36:00'::timestamptz); END IF;

  -- CC944
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC944', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-09-27 00:00:00'::timestamptz, '2024-09-27 00:00:00'::timestamptz, '2024-09-27 16:07:00'::timestamptz, '2024-09-27 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-09-27 16:07:00'::timestamptz); END IF;

  -- CC945
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC945', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-09-28 00:00:00'::timestamptz, '2024-09-28 13:42:00'::timestamptz, '2024-09-28 10:00:00'::timestamptz, '2024-09-28 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-28 10:00:00'::timestamptz); END IF;

  -- CC946
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC946', 'Fany Luz Salon', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-09-28 00:00:00'::timestamptz, '2024-09-28 14:42:00'::timestamptz, '2024-09-28 12:45:00'::timestamptz, '2024-09-28 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-28 12:45:00'::timestamptz); END IF;

  -- CC947
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 73;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC947', 'Noel Hidalgo', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2024-09-28 00:00:00'::timestamptz, '2024-09-28 14:42:00'::timestamptz, '2024-09-28 13:43:00'::timestamptz, '2024-09-28 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-09-28 13:43:00'::timestamptz); END IF;

  -- CC948
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC948', 'Yatzury Anderson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-09-28 00:00:00'::timestamptz, '2024-09-28 15:58:00'::timestamptz, '2024-09-28 13:44:00'::timestamptz, '2024-09-28 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-28 13:44:00'::timestamptz); END IF;

  -- CC949
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC949', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-09-28 00:00:00'::timestamptz, '2024-09-29 09:34:00'::timestamptz, '2024-09-28 15:00:00'::timestamptz, '2024-09-28 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-09-28 15:00:00'::timestamptz); END IF;

  -- CC950
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC950', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-28 00:00:00'::timestamptz, '2024-09-29 09:34:00'::timestamptz, '2024-09-28 15:13:00'::timestamptz, '2024-09-28 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-28 15:13:00'::timestamptz); END IF;

  -- CC951
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC951', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 5, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 00:00:00'::timestamptz, '2024-09-29 08:13:00'::timestamptz, '2024-09-29 08:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-09-29 08:13:00'::timestamptz); END IF;

  -- CC952
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC952', 'Sara Charles', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 15:09:00'::timestamptz, '2024-09-29 09:33:00'::timestamptz, '2024-09-29 09:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-29 09:33:00'::timestamptz); END IF;

  -- CC953
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 95;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC953', 'Benjamin', false, 'completed', false, 10.28, 0.00, 0, 0.72, 11.00, 4.11, 1, 1, 'Lavandería', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 12:16:00'::timestamptz, '2024-09-29 10:19:00'::timestamptz, '2024-09-29 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-09-29 10:19:00'::timestamptz); END IF;

  -- CC954
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC954', 'Retail', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 00:00:00'::timestamptz, '2024-09-29 12:17:00'::timestamptz, '2024-09-29 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-29 12:17:00'::timestamptz); END IF;

  -- CC955
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC955', 'Sara Charles', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, 'Lavandería', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 00:00:00'::timestamptz, '2024-09-29 12:24:00'::timestamptz, '2024-09-29 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-09-29 12:24:00'::timestamptz); END IF;

  -- CC956
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC956', 'Fernando Ortega', false, 'completed', false, 5.95, 0.00, 0, 0.42, 6.37, 3.40, 1, 1, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 14:06:00'::timestamptz, '2024-09-29 12:37:00'::timestamptz, '2024-09-29 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.37 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.37, '2024-09-29 12:37:00'::timestamptz); END IF;

  -- CC957
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC957', 'Daniel Camarena', false, 'completed', false, 11.10, 0.00, 0, 0.65, 11.75, 0.00, 0, 7, '0', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 15:53:00'::timestamptz, '2024-09-29 14:07:00'::timestamptz, '2024-09-29 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.75, '2024-09-29 14:07:00'::timestamptz); END IF;

  -- CC958
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC958', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-09-29 00:00:00'::timestamptz, '2024-09-30 08:50:00'::timestamptz, '2024-09-29 15:04:00'::timestamptz, '2024-09-29 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-29 15:04:00'::timestamptz); END IF;

  -- CC959
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC959', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-30 08:50:00'::timestamptz, '2024-09-29 15:35:00'::timestamptz, '2024-09-29 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-29 15:35:00'::timestamptz); END IF;

  -- CC960
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC960', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 00:00:00'::timestamptz, '2024-09-29 15:36:00'::timestamptz, '2024-09-29 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-09-29 15:36:00'::timestamptz); END IF;

  -- CC961
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC961', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-09-29 00:00:00'::timestamptz, '2024-09-29 00:00:00'::timestamptz, '2024-09-29 15:57:00'::timestamptz, '2024-09-29 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-29 15:57:00'::timestamptz); END IF;

  -- CC962
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC962', 'Evy Ortega', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '0', '2024-09-30 00:00:00'::timestamptz, '2024-10-01 13:10:00'::timestamptz, '2024-09-30 08:38:00'::timestamptz, '2024-09-30 08:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-09-30 08:38:00'::timestamptz); END IF;

  -- CC963
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC963', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 00:00:00'::timestamptz, '2024-09-30 09:23:00'::timestamptz, '2024-09-30 09:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-30 09:23:00'::timestamptz); END IF;

  -- CC964
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC964', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 22.13, 0.00, 0, 1.55, 23.68, 8.85, 3, 1, 'Salón', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 13:25:00'::timestamptz, '2024-09-30 12:04:00'::timestamptz, '2024-09-30 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.68 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.68, '2024-09-30 12:04:00'::timestamptz); END IF;

  -- CC965
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC965', 'Sandra Medina', false, 'completed', false, 13.00, 0.00, 0, 0.84, 13.84, 0.00, 0, 3, '0', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 17:48:00'::timestamptz, '2024-09-30 14:40:00'::timestamptz, '2024-09-30 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.84, '2024-09-30 14:40:00'::timestamptz); END IF;

  -- CC966
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC966', 'Sandra Medina', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, '0', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 15:29:00'::timestamptz, '2024-09-30 14:43:00'::timestamptz, '2024-09-30 14:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-09-30 14:43:00'::timestamptz); END IF;

  -- CC967
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC967', 'Liliana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 15:29:00'::timestamptz, '2024-09-30 14:47:00'::timestamptz, '2024-09-30 14:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-09-30 14:47:00'::timestamptz); END IF;

  -- CC968
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC968', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 17:48:00'::timestamptz, '2024-09-30 14:52:00'::timestamptz, '2024-09-30 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-09-30 14:52:00'::timestamptz); END IF;

  -- CC969
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC969', 'Yara Rangel', false, 'completed', false, 14.02, 0.20, 0, 0.98, 15.00, 0.00, 0, 9, '0', '2024-10-01 00:00:00'::timestamptz, '2024-09-30 17:48:00'::timestamptz, '2024-09-30 16:24:00'::timestamptz, '2024-09-30 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-09-30 16:24:00'::timestamptz); END IF;

  -- CC970
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC970', 'Yara Rangel', false, 'completed', false, 8.41, 0.07, 0, 0.59, 9.00, 0.00, 0, 5, '0', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 17:48:00'::timestamptz, '2024-09-30 17:11:00'::timestamptz, '2024-09-30 17:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-09-30 17:11:00'::timestamptz); END IF;

  -- CC971
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC971', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 6, '', '2024-09-30 00:00:00'::timestamptz, '2024-09-30 00:00:00'::timestamptz, '2024-09-30 17:19:00'::timestamptz, '2024-09-30 17:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-09-30 17:19:00'::timestamptz); END IF;

  -- CC972
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 97;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC972', 'Cesar Beltrán', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, '0', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 10:43:00'::timestamptz, '2024-10-01 09:08:00'::timestamptz, '2024-10-01 09:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-01 09:08:00'::timestamptz); END IF;

  -- CC973
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC973', 'Yatzury Anderson', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 10:43:00'::timestamptz, '2024-10-01 09:09:00'::timestamptz, '2024-10-01 09:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-01 09:09:00'::timestamptz); END IF;

  -- CC974
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC974', 'Renzo Mundo', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 13:11:00'::timestamptz, '2024-10-01 10:30:00'::timestamptz, '2024-10-01 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-01 10:30:00'::timestamptz); END IF;

  -- CC975
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 63;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC975', 'Maritza Adames', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 7, 'Lavandería', '2024-10-02 00:00:00'::timestamptz, '2024-10-01 15:10:00'::timestamptz, '2024-10-01 10:35:00'::timestamptz, '2024-10-01 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-01 10:35:00'::timestamptz); END IF;

  -- CC976
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 36;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC976', 'Waldo Juarez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 15:10:00'::timestamptz, '2024-10-01 11:16:00'::timestamptz, '2024-10-01 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-01 11:16:00'::timestamptz); END IF;

  -- CC977
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 99;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC977', 'Caja De Social Plaza Tocumen', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 0.00, 0, 2, 'Lavandería', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 15:10:00'::timestamptz, '2024-10-01 13:02:00'::timestamptz, '2024-10-01 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-10-01 13:02:00'::timestamptz); END IF;

  -- CC978
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC978', 'Manuel Rueda', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 15:10:00'::timestamptz, '2024-10-01 13:09:00'::timestamptz, '2024-10-01 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-01 13:09:00'::timestamptz); END IF;

  -- CC979
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 29;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC979', 'Roy', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 16:17:00'::timestamptz, '2024-10-01 13:10:00'::timestamptz, '2024-10-01 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-01 13:10:00'::timestamptz); END IF;

  -- CC980
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 100;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC980', 'Compañía Panameña De Aviación S.A', false, 'completed', false, 37.00, 0.00, 0, 2.59, 39.59, 0.00, 0, 4, 'RUC 130-377-34706', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 15:10:00'::timestamptz, '2024-10-01 15:08:00'::timestamptz, '2024-10-01 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 39.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 39.59, '2024-10-01 15:08:00'::timestamptz); END IF;

  -- CC981
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC981', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 16:17:00'::timestamptz, '2024-10-01 15:27:00'::timestamptz, '2024-10-01 15:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-01 15:27:00'::timestamptz); END IF;

  -- CC982
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC982', 'Aaron Gutierrez', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, 'Lavandería', '2024-10-01 00:00:00'::timestamptz, '2024-10-02 09:52:00'::timestamptz, '2024-10-01 16:15:00'::timestamptz, '2024-10-01 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-10-01 16:15:00'::timestamptz); END IF;

  -- CC983
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC983', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 4, '', '2024-10-01 00:00:00'::timestamptz, '2024-10-01 00:00:00'::timestamptz, '2024-10-01 16:42:00'::timestamptz, '2024-10-01 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-01 16:42:00'::timestamptz); END IF;

  -- CC984
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC984', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-02 00:00:00'::timestamptz, '2024-10-02 09:52:00'::timestamptz, '2024-10-02 08:31:00'::timestamptz, '2024-10-02 08:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-02 08:31:00'::timestamptz); END IF;

  -- CC985
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC985', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-10-02 00:00:00'::timestamptz, '2024-10-02 13:20:00'::timestamptz, '2024-10-02 11:09:00'::timestamptz, '2024-10-02 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-02 11:09:00'::timestamptz); END IF;

  -- CC986
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC986', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-10-02 00:00:00'::timestamptz, '2024-10-02 15:03:00'::timestamptz, '2024-10-02 12:27:00'::timestamptz, '2024-10-02 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-02 12:27:00'::timestamptz); END IF;

  -- CC987
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC987', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-10-02 00:00:00'::timestamptz, '2024-10-03 14:48:00'::timestamptz, '2024-10-02 16:27:00'::timestamptz, '2024-10-02 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-02 16:27:00'::timestamptz); END IF;

  -- CC988
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC988', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 4, '', '2024-10-02 00:00:00'::timestamptz, '2024-10-02 00:00:00'::timestamptz, '2024-10-02 16:49:00'::timestamptz, '2024-10-02 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-02 16:49:00'::timestamptz); END IF;

  -- CC989
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC989', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-10-03 00:00:00'::timestamptz, '2024-10-03 14:48:00'::timestamptz, '2024-10-03 13:56:00'::timestamptz, '2024-10-03 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-03 13:56:00'::timestamptz); END IF;

  -- CC990
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC990', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2024-10-03 00:00:00'::timestamptz, '2024-10-03 16:46:00'::timestamptz, '2024-10-03 13:59:00'::timestamptz, '2024-10-03 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-03 13:59:00'::timestamptz); END IF;

  -- CC991
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC991', 'Liliana Zambrano', false, 'completed', false, 4.21, 0.03, 0, 0.29, 4.50, 0.00, 0, 4, '0', '2024-10-03 00:00:00'::timestamptz, '2024-10-03 16:49:00'::timestamptz, '2024-10-03 14:01:00'::timestamptz, '2024-10-03 14:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-10-03 14:01:00'::timestamptz); END IF;

  -- CC992
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC992', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 5, '', '2024-10-03 00:00:00'::timestamptz, '2024-10-03 00:00:00'::timestamptz, '2024-10-03 16:49:00'::timestamptz, '2024-10-03 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-10-03 16:49:00'::timestamptz); END IF;

  -- CC993
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC993', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 10:06:00'::timestamptz, '2024-10-04 07:58:00'::timestamptz, '2024-10-04 07:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-04 07:58:00'::timestamptz); END IF;

  -- CC994
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC994', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 00:00:00'::timestamptz, '2024-10-04 08:23:00'::timestamptz, '2024-10-04 08:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-04 08:23:00'::timestamptz); END IF;

  -- CC995
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC995', 'Manuel Rueda', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 14:07:00'::timestamptz, '2024-10-04 09:22:00'::timestamptz, '2024-10-04 09:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-04 09:22:00'::timestamptz); END IF;

  -- CC996
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC996', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 00:00:00'::timestamptz, '2024-10-04 09:35:00'::timestamptz, '2024-10-04 09:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-10-04 09:35:00'::timestamptz); END IF;

  -- CC997
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 101;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC997', 'Mirian Perez', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, 'Lavandería', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 12:02:00'::timestamptz, '2024-10-04 10:14:00'::timestamptz, '2024-10-04 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-04 10:14:00'::timestamptz); END IF;

  -- CC998
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC998', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.75, 0.00, 0, 1.03, 15.78, 5.90, 2, 1, 'Salón', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 10:38:00'::timestamptz, '2024-10-04 10:30:00'::timestamptz, '2024-10-04 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.78 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.78, '2024-10-04 10:30:00'::timestamptz); END IF;

  -- CC999
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC999', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 14:09:00'::timestamptz, '2024-10-04 10:35:00'::timestamptz, '2024-10-04 10:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-04 10:35:00'::timestamptz); END IF;

  -- CC1000
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1000', 'Evy Ortega', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, '0 Refunded B/14.98 in order #1035 ', '2024-10-04 00:00:00'::timestamptz, '2024-10-08 09:24:00'::timestamptz, '2024-10-04 11:18:00'::timestamptz, '2024-10-04 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2024-10-04 11:18:00'::timestamptz); END IF;

  -- CC1001
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1001', 'Guzmán', false, 'completed', false, 16.50, 0.00, 0, 1.16, 17.66, 6.60, 3, 1, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 14:09:00'::timestamptz, '2024-10-04 12:33:00'::timestamptz, '2024-10-04 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.66 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.66, '2024-10-04 12:33:00'::timestamptz); END IF;

  -- CC1002
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1002', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 00:00:00'::timestamptz, '2024-10-04 16:29:00'::timestamptz, '2024-10-04 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-04 16:29:00'::timestamptz); END IF;

  -- CC1003
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1003', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 00:00:00'::timestamptz, '2024-10-04 16:30:00'::timestamptz, '2024-10-04 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-10-04 16:30:00'::timestamptz); END IF;

  -- CC1004
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1004', 'Yatzury Anderson', false, 'completed', false, 1.00, 0.00, 0, 0.07, 1.07, 0.00, 0, 2, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-04 17:00:00'::timestamptz, '2024-10-04 16:59:00'::timestamptz, '2024-10-04 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.07, '2024-10-04 16:59:00'::timestamptz); END IF;

  -- CC1005
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1005', 'Yatzury Anderson', false, 'completed', false, 2.45, 0.00, 0, 0.17, 2.62, 0.00, 0, 7, '', '2024-10-04 00:00:00'::timestamptz, '2024-10-05 08:20:00'::timestamptz, '2024-10-04 17:02:00'::timestamptz, '2024-10-04 17:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.62 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.62, '2024-10-04 17:02:00'::timestamptz); END IF;

  -- CC1006
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 102;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1006', 'Juan Carlos Pastor', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 13:01:00'::timestamptz, '2024-10-05 09:00:00'::timestamptz, '2024-10-05 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-05 09:00:00'::timestamptz); END IF;

  -- CC1007
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1007', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 12:29:00'::timestamptz, '2024-10-05 09:50:00'::timestamptz, '2024-10-05 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-05 09:50:00'::timestamptz); END IF;

  -- CC1008
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1008', 'Dalvis Ojo', false, 'completed', false, 7.01, 0.10, 0, 0.49, 7.50, 0.00, 0, 6, 'Lavandería', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 16:23:00'::timestamptz, '2024-10-05 11:13:00'::timestamptz, '2024-10-05 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2024-10-05 11:13:00'::timestamptz); END IF;

  -- CC1009
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 84;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1009', 'Julia Sandoval', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 16:22:00'::timestamptz, '2024-10-05 12:28:00'::timestamptz, '2024-10-05 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-05 12:28:00'::timestamptz); END IF;

  -- CC1010
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1010', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.95, 1, 1, '', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 14:58:00'::timestamptz, '2024-10-05 13:33:00'::timestamptz, '2024-10-05 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-10-05 13:33:00'::timestamptz); END IF;

  -- CC1011
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1011', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-10-05 00:00:00'::timestamptz, '2024-10-05 00:00:00'::timestamptz, '2024-10-05 16:33:00'::timestamptz, '2024-10-05 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-10-05 16:33:00'::timestamptz); END IF;

  -- CC1012
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1012', 'Samuel Colinas', false, 'completed', false, 8.00, 0.00, 0, 0.56, 8.56, 3.20, 1, 1, '0', '2024-10-06 00:00:00'::timestamptz, '2024-10-06 15:38:00'::timestamptz, '2024-10-06 10:25:00'::timestamptz, '2024-10-06 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.56, '2024-10-06 10:25:00'::timestamptz); END IF;

  -- CC1013
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1013', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-10-06 00:00:00'::timestamptz, '2024-10-06 13:51:00'::timestamptz, '2024-10-06 12:37:00'::timestamptz, '2024-10-06 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-06 12:37:00'::timestamptz); END IF;

  -- CC1014
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1014', 'Yatzury Anderson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-10-06 00:00:00'::timestamptz, '2024-10-07 11:44:00'::timestamptz, '2024-10-06 15:36:00'::timestamptz, '2024-10-06 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-06 15:36:00'::timestamptz); END IF;

  -- CC1015
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1015', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-10-06 00:00:00'::timestamptz, '2024-10-06 00:00:00'::timestamptz, '2024-10-06 15:48:00'::timestamptz, '2024-10-06 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-10-06 15:48:00'::timestamptz); END IF;

  -- CC1016
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1016', 'Retail', true, 'completed', false, 7.00, 0.00, 0, 0.00, 7.00, 0.00, 0, 10, '', '2024-10-06 00:00:00'::timestamptz, '2024-10-06 00:00:00'::timestamptz, '2024-10-06 15:51:00'::timestamptz, '2024-10-06 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-10-06 15:51:00'::timestamptz); END IF;

  -- CC1017
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1017', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 12:56:00'::timestamptz, '2024-10-07 11:44:00'::timestamptz, '2024-10-07 11:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-07 11:44:00'::timestamptz); END IF;

  -- CC1018
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1018', 'Liliana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 12:46:00'::timestamptz, '2024-10-07 11:45:00'::timestamptz, '2024-10-07 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-07 11:45:00'::timestamptz); END IF;

  -- CC1019
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1019', 'Sara Charles', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 15:01:00'::timestamptz, '2024-10-07 12:34:00'::timestamptz, '2024-10-07 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-07 12:34:00'::timestamptz); END IF;

  -- CC1020
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1020', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 12:46:00'::timestamptz, '2024-10-07 12:35:00'::timestamptz, '2024-10-07 12:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-07 12:35:00'::timestamptz); END IF;

  -- CC1021
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1021', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 17.63, 0.00, 0, 1.23, 18.86, 7.05, 2, 1, 'Salón', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 15:01:00'::timestamptz, '2024-10-07 12:44:00'::timestamptz, '2024-10-07 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.86 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.86, '2024-10-07 12:44:00'::timestamptz); END IF;

  -- CC1022
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1022', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 00:00:00'::timestamptz, '2024-10-07 12:47:00'::timestamptz, '2024-10-07 12:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-07 12:47:00'::timestamptz); END IF;

  -- CC1023
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1023', 'Manuel Rueda', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 15:34:00'::timestamptz, '2024-10-07 12:50:00'::timestamptz, '2024-10-07 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-07 12:50:00'::timestamptz); END IF;

  -- CC1024
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1024', 'Liliana Zambrano', false, 'completed', false, 7.94, 0.04, 0, 0.56, 8.50, 0.00, 0, 6, '0', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 15:34:00'::timestamptz, '2024-10-07 13:11:00'::timestamptz, '2024-10-07 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-10-07 13:11:00'::timestamptz); END IF;

  -- CC1025
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1025', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 16:42:00'::timestamptz, '2024-10-07 15:33:00'::timestamptz, '2024-10-07 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-07 15:33:00'::timestamptz); END IF;

  -- CC1026
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1026', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 7, '', '2024-10-07 00:00:00'::timestamptz, '2024-10-07 00:00:00'::timestamptz, '2024-10-07 16:45:00'::timestamptz, '2024-10-07 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-07 16:45:00'::timestamptz); END IF;

  -- CC1027
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 103;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1027', 'Patricia Valle', false, 'completed', false, 30.00, 0.00, 0, 2.10, 32.10, 0.00, 0, 3, '', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 09:30:00'::timestamptz, '2024-10-07 16:47:00'::timestamptz, '2024-10-07 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 32.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 32.10, '2024-10-07 16:47:00'::timestamptz); END IF;

  -- CC1028
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1028', 'Guzmán', false, 'completed', false, 4.99, 0.00, 0, 0.35, 5.34, 2.85, 1, 1, '', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 09:35:00'::timestamptz, '2024-10-08 09:22:00'::timestamptz, '2024-10-08 09:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.34, '2024-10-08 09:22:00'::timestamptz); END IF;

  -- CC1029
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1029', 'Renzo Mundo', false, 'completed', false, 6.61, 0.00, 0, 0.46, 7.07, 0.00, 0, 4, 'Lavandería', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 12:33:00'::timestamptz, '2024-10-08 10:00:00'::timestamptz, '2024-10-08 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.07, '2024-10-08 10:00:00'::timestamptz); END IF;

  -- CC1030
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1030', 'Lineth', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, '0', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 12:33:00'::timestamptz, '2024-10-08 11:22:00'::timestamptz, '2024-10-08 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-10-08 11:22:00'::timestamptz); END IF;

  -- CC1031
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1031', 'Lineth', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 12:47:00'::timestamptz, '2024-10-08 12:01:00'::timestamptz, '2024-10-08 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-08 12:01:00'::timestamptz); END IF;

  -- CC1032
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1032', 'Lineth', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 12:47:00'::timestamptz, '2024-10-08 12:05:00'::timestamptz, '2024-10-08 12:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-08 12:05:00'::timestamptz); END IF;

  -- CC1033
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1033', 'Aaron Gutierrez', false, 'completed', false, 7.98, 0.00, 0, 0.52, 8.50, 0.00, 0, 5, 'Lavandería', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 17:15:00'::timestamptz, '2024-10-08 15:44:00'::timestamptz, '2024-10-08 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-10-08 15:44:00'::timestamptz); END IF;

  -- CC1034
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1034', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 17:14:00'::timestamptz, '2024-10-08 16:12:00'::timestamptz, '2024-10-08 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-08 16:12:00'::timestamptz); END IF;

  -- CC1036
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1036', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2024-10-08 00:00:00'::timestamptz, '2024-10-08 00:00:00'::timestamptz, '2024-10-08 16:36:00'::timestamptz, '2024-10-08 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-08 16:36:00'::timestamptz); END IF;

  -- CC1037
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1037', 'Evy Ortega', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, '0', '2024-10-08 00:00:00'::timestamptz, '2024-10-09 12:41:00'::timestamptz, '2024-10-08 16:45:00'::timestamptz, '2024-10-08 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2024-10-08 16:45:00'::timestamptz); END IF;

  -- CC1038
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1038', 'Lineth', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 08:50:00'::timestamptz, '2024-10-09 08:05:00'::timestamptz, '2024-10-09 08:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-09 08:05:00'::timestamptz); END IF;

  -- CC1039
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1039', 'Lineth', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 10:06:00'::timestamptz, '2024-10-09 08:53:00'::timestamptz, '2024-10-09 08:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-09 08:53:00'::timestamptz); END IF;

  -- CC1040
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 97;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1040', 'Cesar Beltrán', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 11:37:00'::timestamptz, '2024-10-09 09:15:00'::timestamptz, '2024-10-09 09:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-09 09:15:00'::timestamptz); END IF;

  -- CC1041
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 104;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1041', 'Carlos Abrego', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 11:37:00'::timestamptz, '2024-10-09 09:23:00'::timestamptz, '2024-10-09 09:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-09 09:23:00'::timestamptz); END IF;

  -- CC1042
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1042', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 11:37:00'::timestamptz, '2024-10-09 10:07:00'::timestamptz, '2024-10-09 10:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-09 10:07:00'::timestamptz); END IF;

  -- CC1043
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1043', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 16:04:00'::timestamptz, '2024-10-09 11:55:00'::timestamptz, '2024-10-09 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-09 11:55:00'::timestamptz); END IF;

  -- CC1044
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1044', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-10-09 00:00:00'::timestamptz, '2024-10-09 16:03:00'::timestamptz, '2024-10-09 12:23:00'::timestamptz, '2024-10-09 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-09 12:23:00'::timestamptz); END IF;

  -- CC1045
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1045', 'Karla Garibaldi', false, 'completed', false, 7.74, 0.00, 0, 0.54, 8.28, 0.00, 0, 3, 'Lavandería', '2024-10-10 00:00:00'::timestamptz, '2024-10-10 17:03:00'::timestamptz, '2024-10-10 13:20:00'::timestamptz, '2024-10-10 13:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.28 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.28, '2024-10-10 13:20:00'::timestamptz); END IF;

  -- CC1046
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1046', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-10-10 00:00:00'::timestamptz, '2024-10-10 17:03:00'::timestamptz, '2024-10-10 13:22:00'::timestamptz, '2024-10-10 13:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-10 13:22:00'::timestamptz); END IF;

  -- CC1047
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1047', 'Guzmán', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 4.00, 1, 1, '', '2024-10-10 00:00:00'::timestamptz, '2024-10-10 17:03:00'::timestamptz, '2024-10-10 14:35:00'::timestamptz, '2024-10-10 14:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-10-10 14:35:00'::timestamptz); END IF;

  -- CC1048
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1048', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-10-10 00:00:00'::timestamptz, '2024-10-10 00:00:00'::timestamptz, '2024-10-10 14:53:00'::timestamptz, '2024-10-10 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-10 14:53:00'::timestamptz); END IF;

  -- CC1049
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1049', 'Oscar Oropeza', false, 'completed', false, 18.69, 0.01, 0, 1.31, 20.00, 0.00, 0, 10, 'Lavandería', '2024-10-10 00:00:00'::timestamptz, '2024-10-10 17:19:00'::timestamptz, '2024-10-10 16:59:00'::timestamptz, '2024-10-10 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-10-10 16:59:00'::timestamptz); END IF;

  -- CC1050
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1050', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:15:00'::timestamptz, '2024-10-11 08:59:00'::timestamptz, '2024-10-11 08:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-11 08:59:00'::timestamptz); END IF;

  -- CC1051
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1051', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 11:08:00'::timestamptz, '2024-10-11 10:13:00'::timestamptz, '2024-10-11 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-11 10:13:00'::timestamptz); END IF;

  -- CC1052
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 29;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1052', 'Roy', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:16:00'::timestamptz, '2024-10-11 10:14:00'::timestamptz, '2024-10-11 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-11 10:14:00'::timestamptz); END IF;

  -- CC1053
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1053', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:16:00'::timestamptz, '2024-10-11 10:14:00'::timestamptz, '2024-10-11 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-11 10:14:00'::timestamptz); END IF;

  -- CC1054
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1054', 'Guzmán', false, 'completed', false, 14.75, 0.00, 0, 1.03, 15.78, 5.90, 3, 1, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:45:00'::timestamptz, '2024-10-11 11:59:00'::timestamptz, '2024-10-11 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.78 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.78, '2024-10-11 11:59:00'::timestamptz); END IF;

  -- CC1055
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1055', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.60, 1, 1, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:45:00'::timestamptz, '2024-10-11 12:10:00'::timestamptz, '2024-10-11 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-10-11 12:10:00'::timestamptz); END IF;

  -- CC1056
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1056', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 00:00:00'::timestamptz, '2024-10-11 13:46:00'::timestamptz, '2024-10-11 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-11 13:46:00'::timestamptz); END IF;

  -- CC1057
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 108;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1057', 'Estefanía Rodríguez', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '0', '2024-10-11 00:00:00'::timestamptz, '2024-10-12 17:14:00'::timestamptz, '2024-10-11 14:30:00'::timestamptz, '2024-10-11 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-11 14:30:00'::timestamptz); END IF;

  -- CC1058
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1058', 'Grethell Guevara', false, 'completed', false, 47.20, 11.80, 0, 3.30, 50.50, 23.60, 4, 1, 'Lavandería', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 17:32:00'::timestamptz, '2024-10-11 16:25:00'::timestamptz, '2024-10-11 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 50.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 50.50, '2024-10-11 16:25:00'::timestamptz); END IF;

  -- CC1059
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1059', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-10-11 00:00:00'::timestamptz, '2024-10-11 00:00:00'::timestamptz, '2024-10-11 16:42:00'::timestamptz, '2024-10-11 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-11 16:42:00'::timestamptz); END IF;

  -- CC1060
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1060', 'Leonel Willson', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '0', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 11:55:00'::timestamptz, '2024-10-12 09:46:00'::timestamptz, '2024-10-12 09:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-12 09:46:00'::timestamptz); END IF;

  -- CC1061
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1061', 'Rene Guiñez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 13:39:00'::timestamptz, '2024-10-12 11:54:00'::timestamptz, '2024-10-12 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-12 11:54:00'::timestamptz); END IF;

  -- CC1062
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1062', 'Yatzury Anderson', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 13:38:00'::timestamptz, '2024-10-12 11:55:00'::timestamptz, '2024-10-12 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-12 11:55:00'::timestamptz); END IF;

  -- CC1063
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 68;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1063', 'Dalvis Ojo', false, 'completed', false, 27.90, 6.98, 0, 1.95, 29.85, 13.95, 3, 1, 'Lavandería', '2024-10-12 00:00:00'::timestamptz, '2024-10-16 16:06:00'::timestamptz, '2024-10-12 13:36:00'::timestamptz, '2024-10-12 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.85, '2024-10-12 13:36:00'::timestamptz); END IF;

  -- CC1064
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1064', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 20.50, 0.00, 0, 1.44, 21.94, 8.20, 2, 1, 'Salón', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 15:47:00'::timestamptz, '2024-10-12 15:35:00'::timestamptz, '2024-10-12 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.94 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.94, '2024-10-12 15:35:00'::timestamptz); END IF;

  -- CC1065
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1065', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 00:00:00'::timestamptz, '2024-10-12 16:23:00'::timestamptz, '2024-10-12 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-12 16:23:00'::timestamptz); END IF;

  -- CC1066
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1066', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 17:14:00'::timestamptz, '2024-10-12 16:36:00'::timestamptz, '2024-10-12 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-12 16:36:00'::timestamptz); END IF;

  -- CC1067
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 108;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1067', 'Estefanía Rodríguez', false, 'completed', false, 8.00, 0.00, 0, 0.56, 8.56, 0.00, 0, 1, '0', '2024-10-12 00:00:00'::timestamptz, '2024-10-23 16:09:00'::timestamptz, '2024-10-12 16:48:00'::timestamptz, '2024-10-12 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.56, '2024-10-12 16:48:00'::timestamptz); END IF;

  -- CC1068
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1068', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2024-10-12 00:00:00'::timestamptz, '2024-10-12 00:00:00'::timestamptz, '2024-10-12 17:04:00'::timestamptz, '2024-10-12 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-12 17:04:00'::timestamptz); END IF;

  -- CC1069
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 30;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1069', 'Guadalupe De Zabala', false, 'completed', false, 11.22, 0.26, 0, 0.79, 12.01, 0.00, 0, 8, '0', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 13:49:00'::timestamptz, '2024-10-13 09:43:00'::timestamptz, '2024-10-13 09:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-10-13 09:43:00'::timestamptz); END IF;

  -- CC1070
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1070', 'Samuel Colinas', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '0', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 13:49:00'::timestamptz, '2024-10-13 09:57:00'::timestamptz, '2024-10-13 09:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-10-13 09:57:00'::timestamptz); END IF;

  -- CC1071
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1071', 'Samuel Colinas', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 13:49:00'::timestamptz, '2024-10-13 10:48:00'::timestamptz, '2024-10-13 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-13 10:48:00'::timestamptz); END IF;

  -- CC1072
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1072', 'Liliana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 15:12:00'::timestamptz, '2024-10-13 13:36:00'::timestamptz, '2024-10-13 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-13 13:36:00'::timestamptz); END IF;

  -- CC1073
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1073', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 00:00:00'::timestamptz, '2024-10-13 13:50:00'::timestamptz, '2024-10-13 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-13 13:50:00'::timestamptz); END IF;

  -- CC1074
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 109;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1074', 'Cristel Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-13 00:00:00'::timestamptz, '2024-10-14 08:03:00'::timestamptz, '2024-10-13 14:20:00'::timestamptz, '2024-10-13 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-13 14:20:00'::timestamptz); END IF;

  -- CC1075
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1075', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-10-13 00:00:00'::timestamptz, '2024-10-14 11:10:00'::timestamptz, '2024-10-13 15:45:00'::timestamptz, '2024-10-13 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-13 15:45:00'::timestamptz); END IF;

  -- CC1076
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1076', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2024-10-13 00:00:00'::timestamptz, '2024-10-13 00:00:00'::timestamptz, '2024-10-13 15:45:00'::timestamptz, '2024-10-13 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-13 15:45:00'::timestamptz); END IF;

  -- CC1077
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1077', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-14 00:00:00'::timestamptz, '2024-10-14 17:13:00'::timestamptz, '2024-10-14 11:06:00'::timestamptz, '2024-10-14 11:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-14 11:06:00'::timestamptz); END IF;

  -- CC1078
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1078', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-14 00:00:00'::timestamptz, '2024-10-14 12:42:00'::timestamptz, '2024-10-14 11:08:00'::timestamptz, '2024-10-14 11:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-14 11:08:00'::timestamptz); END IF;

  -- CC1079
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1079', 'Erick Rodriguez', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2024-10-14 00:00:00'::timestamptz, '2024-10-14 17:13:00'::timestamptz, '2024-10-14 15:40:00'::timestamptz, '2024-10-14 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-14 15:40:00'::timestamptz); END IF;

  -- CC1080
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1080', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2024-10-14 00:00:00'::timestamptz, '2024-10-14 00:00:00'::timestamptz, '2024-10-14 15:45:00'::timestamptz, '2024-10-14 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-14 15:45:00'::timestamptz); END IF;

  -- CC1081
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1081', 'Samuel Colinas', false, 'completed', false, 6.75, 0.00, 0, 0.47, 7.22, 2.70, 1, 1, '0', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 14:58:00'::timestamptz, '2024-10-15 10:48:00'::timestamptz, '2024-10-15 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.22 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.22, '2024-10-15 10:48:00'::timestamptz); END IF;

  -- CC1082
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1082', 'Sandra Medina', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 16:26:00'::timestamptz, '2024-10-15 13:55:00'::timestamptz, '2024-10-15 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-15 13:55:00'::timestamptz); END IF;

  -- CC1083
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1083', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 16:26:00'::timestamptz, '2024-10-15 14:13:00'::timestamptz, '2024-10-15 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-15 14:13:00'::timestamptz); END IF;

  -- CC1084
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1084', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 16:26:00'::timestamptz, '2024-10-15 15:09:00'::timestamptz, '2024-10-15 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-15 15:09:00'::timestamptz); END IF;

  -- CC1085
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1085', 'Yatzury Anderson', false, 'completed', false, 3.12, 0.00, 0, 0.13, 3.25, 0.00, 0, 2, '', '2024-10-15 00:00:00'::timestamptz, '2024-10-16 14:20:00'::timestamptz, '2024-10-15 16:42:00'::timestamptz, '2024-10-15 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-10-15 16:42:00'::timestamptz); END IF;

  -- CC1086
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1086', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 00:00:00'::timestamptz, '2024-10-15 17:13:00'::timestamptz, '2024-10-15 17:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-15 17:13:00'::timestamptz); END IF;

  -- CC1087
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1087', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, '', '2024-10-15 00:00:00'::timestamptz, '2024-10-16 14:20:00'::timestamptz, '2024-10-15 17:15:00'::timestamptz, '2024-10-15 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-10-15 17:15:00'::timestamptz); END IF;

  -- CC1088
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1088', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-10-15 00:00:00'::timestamptz, '2024-10-15 00:00:00'::timestamptz, '2024-10-15 17:18:00'::timestamptz, '2024-10-15 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-15 17:18:00'::timestamptz); END IF;

  -- CC1089
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1089', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.75, 0.00, 0, 1.31, 20.06, 7.50, 2, 1, 'Salón', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 14:17:00'::timestamptz, '2024-10-16 11:52:00'::timestamptz, '2024-10-16 11:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.06, '2024-10-16 11:52:00'::timestamptz); END IF;

  -- CC1090
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1090', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:06:00'::timestamptz, '2024-10-16 14:12:00'::timestamptz, '2024-10-16 14:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-16 14:12:00'::timestamptz); END IF;

  -- CC1091
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1091', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:41:00'::timestamptz, '2024-10-16 15:42:00'::timestamptz, '2024-10-16 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-16 15:42:00'::timestamptz); END IF;

  -- CC1092
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1092', 'Leonel Visueti', false, 'completed', false, 4.05, 0.07, 0, 0.20, 4.25, 0.00, 0, 3, '', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:41:00'::timestamptz, '2024-10-16 15:54:00'::timestamptz, '2024-10-16 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2024-10-16 15:54:00'::timestamptz); END IF;

  -- CC1093
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1093', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 2, '', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:32:00'::timestamptz, '2024-10-16 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-10-16 16:32:00'::timestamptz); END IF;

  -- CC1094
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1094', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:50:00'::timestamptz, '2024-10-16 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-16 16:50:00'::timestamptz); END IF;

  -- CC1095
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1095', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-10-16 00:00:00'::timestamptz, '2024-10-16 00:00:00'::timestamptz, '2024-10-16 16:59:00'::timestamptz, '2024-10-16 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-16 16:59:00'::timestamptz); END IF;

  -- CC1096
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1096', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 14:51:00'::timestamptz, '2024-10-17 12:30:00'::timestamptz, '2024-10-17 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-17 12:30:00'::timestamptz); END IF;

  -- CC1097
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1097', 'Grethell Guevara', false, 'completed', false, 51.13, 0.00, 0, 3.58, 54.71, 17.65, 6, 2, 'Lavandería ', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 17:30:00'::timestamptz, '2024-10-17 13:19:00'::timestamptz, '2024-10-17 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 54.71 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 54.71, '2024-10-17 13:19:00'::timestamptz); END IF;

  -- CC1098
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1098', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 00:00:00'::timestamptz, '2024-10-17 14:51:00'::timestamptz, '2024-10-17 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-17 14:51:00'::timestamptz); END IF;

  -- CC1099
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1099', 'Oscar Oropeza', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 17:30:00'::timestamptz, '2024-10-17 15:24:00'::timestamptz, '2024-10-17 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-17 15:24:00'::timestamptz); END IF;

  -- CC1100
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1100', 'Oscar Oropeza', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 17:30:00'::timestamptz, '2024-10-17 17:03:00'::timestamptz, '2024-10-17 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-17 17:03:00'::timestamptz); END IF;

  -- CC1101
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1101', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-10-17 00:00:00'::timestamptz, '2024-10-17 00:00:00'::timestamptz, '2024-10-17 17:33:00'::timestamptz, '2024-10-17 17:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-10-17 17:33:00'::timestamptz); END IF;

  -- CC1102
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1102', 'Guzmán', false, 'completed', false, 15.50, 0.00, 0, 1.09, 16.59, 6.20, 3, 1, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 15:04:00'::timestamptz, '2024-10-18 12:55:00'::timestamptz, '2024-10-18 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.59, '2024-10-18 12:55:00'::timestamptz); END IF;

  -- CC1103
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1103', 'Guzmán', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 15:03:00'::timestamptz, '2024-10-18 14:23:00'::timestamptz, '2024-10-18 14:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-10-18 14:23:00'::timestamptz); END IF;

  -- CC1104
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 97;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1104', 'Cesar Beltrán', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, '0', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 16:57:00'::timestamptz, '2024-10-18 15:05:00'::timestamptz, '2024-10-18 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-18 15:05:00'::timestamptz); END IF;

  -- CC1105
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1105', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 16:57:00'::timestamptz, '2024-10-18 15:37:00'::timestamptz, '2024-10-18 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-18 15:37:00'::timestamptz); END IF;

  -- CC1106
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1106', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 16:57:00'::timestamptz, '2024-10-18 16:33:00'::timestamptz, '2024-10-18 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-18 16:33:00'::timestamptz); END IF;

  -- CC1107
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1107', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 00:00:00'::timestamptz, '2024-10-18 16:35:00'::timestamptz, '2024-10-18 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-18 16:35:00'::timestamptz); END IF;

  -- CC1108
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1108', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-10-18 00:00:00'::timestamptz, '2024-10-18 00:00:00'::timestamptz, '2024-10-18 16:39:00'::timestamptz, '2024-10-18 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-10-18 16:39:00'::timestamptz); END IF;

  -- CC1109
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1109', 'Liliana Zambrano', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-10-19 00:00:00'::timestamptz, '2024-10-19 09:49:00'::timestamptz, '2024-10-19 09:18:00'::timestamptz, '2024-10-19 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-19 09:18:00'::timestamptz); END IF;

  -- CC1110
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1110', 'Leonel Willson', false, 'completed', false, 3.74, 3.74, 0, 0.26, 4.00, 0.00, 0, 4, '0', '2024-10-19 00:00:00'::timestamptz, '2024-10-19 13:22:00'::timestamptz, '2024-10-19 10:45:00'::timestamptz, '2024-10-19 10:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-19 10:45:00'::timestamptz); END IF;

  -- CC1111
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1111', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.15, 2, 1, '', '2024-10-19 00:00:00'::timestamptz, '2024-10-19 13:20:00'::timestamptz, '2024-10-19 11:49:00'::timestamptz, '2024-10-19 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-10-19 11:49:00'::timestamptz); END IF;

  -- CC1112
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1112', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 17.25, 0.00, 0, 1.21, 18.46, 6.90, 2, 1, 'Salón', '2024-10-19 00:00:00'::timestamptz, '2024-10-19 13:20:00'::timestamptz, '2024-10-19 12:40:00'::timestamptz, '2024-10-19 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.46, '2024-10-19 12:40:00'::timestamptz); END IF;

  -- CC1113
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1113', 'Leonel Visueti', false, 'completed', false, 4.80, 0.07, 0, 0.20, 5.00, 0.00, 0, 4, '', '2024-10-19 00:00:00'::timestamptz, '2024-10-20 08:41:00'::timestamptz, '2024-10-19 17:12:00'::timestamptz, '2024-10-19 17:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-19 17:12:00'::timestamptz); END IF;

  -- CC1114
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1114', 'Fernando Ortega', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 13:34:00'::timestamptz, '2024-10-20 13:32:00'::timestamptz, '2024-10-20 13:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-20 13:32:00'::timestamptz); END IF;

  -- CC1115
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 64;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1115', 'Alexander Aguilar', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 0.90, 1, 1, 'Lavandería', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 13:34:00'::timestamptz, '2024-10-20 13:33:00'::timestamptz, '2024-10-20 13:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-10-20 13:33:00'::timestamptz); END IF;

  -- CC1116
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1116', 'Leonel Visueti', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 13:41:00'::timestamptz, '2024-10-20 13:37:00'::timestamptz, '2024-10-20 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-20 13:37:00'::timestamptz); END IF;

  -- CC1117
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1117', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 4, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 00:00:00'::timestamptz, '2024-10-20 13:39:00'::timestamptz, '2024-10-20 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-20 13:39:00'::timestamptz); END IF;

  -- CC1118
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1118', 'Leonel Visueti', false, 'completed', false, 5.17, 0.07, 0, 0.33, 5.50, 0.00, 0, 4, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 13:47:00'::timestamptz, '2024-10-20 13:43:00'::timestamptz, '2024-10-20 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-10-20 13:43:00'::timestamptz); END IF;

  -- CC1119
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 34;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1119', 'Samuel Colinas', false, 'completed', false, 2.84, 1.90, 0, 0.16, 3.00, 0.00, 0, 3, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 14:53:00'::timestamptz, '2024-10-20 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-20 14:53:00'::timestamptz); END IF;

  -- CC1120
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1120', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 14:56:00'::timestamptz, '2024-10-20 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-20 14:56:00'::timestamptz); END IF;

  -- CC1121
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1121', 'Cliente Lavandería', false, 'completed', false, 7.49, 0.00, 0, 0.26, 7.75, 0.00, 0, 6, 'Lavandería', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 15:02:00'::timestamptz, '2024-10-20 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.75, '2024-10-20 15:02:00'::timestamptz); END IF;

  -- CC1122
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1122', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 15:02:00'::timestamptz, '2024-10-20 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-20 15:02:00'::timestamptz); END IF;

  -- CC1123
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1123', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 15:03:00'::timestamptz, '2024-10-20 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-20 15:03:00'::timestamptz); END IF;

  -- CC1124
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1124', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-20 00:00:00'::timestamptz, '2024-10-20 16:06:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz, '2024-10-20 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-20 15:54:00'::timestamptz); END IF;

  -- CC1125
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1125', 'Liliana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 15:35:00'::timestamptz, '2024-10-21 12:05:00'::timestamptz, '2024-10-21 12:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 12:05:00'::timestamptz); END IF;

  -- CC1126
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1126', 'Liliana Zambrano', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 13:15:00'::timestamptz, '2024-10-21 12:25:00'::timestamptz, '2024-10-21 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-21 12:25:00'::timestamptz); END IF;

  -- CC1127
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1127', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:05:00'::timestamptz, '2024-10-21 13:15:00'::timestamptz, '2024-10-21 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 13:15:00'::timestamptz); END IF;

  -- CC1128
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1128', 'Liliana Zambrano', false, 'completed', false, 2.34, 0.03, 0, 0.16, 2.50, 0.00, 0, 3, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:05:00'::timestamptz, '2024-10-21 13:18:00'::timestamptz, '2024-10-21 13:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-21 13:18:00'::timestamptz); END IF;

  -- CC1129
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1129', 'Aaron Gutierrez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:05:00'::timestamptz, '2024-10-21 13:21:00'::timestamptz, '2024-10-21 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 13:21:00'::timestamptz); END IF;

  -- CC1130
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1130', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 15:36:00'::timestamptz, '2024-10-21 13:30:00'::timestamptz, '2024-10-21 13:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-21 13:30:00'::timestamptz); END IF;

  -- CC1131
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1131', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:30:00'::timestamptz, '2024-10-21 13:36:00'::timestamptz, '2024-10-21 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 13:36:00'::timestamptz); END IF;

  -- CC1132
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1132', 'Guzmán', false, 'completed', false, 20.38, 0.00, 0, 1.43, 21.81, 8.15, 4, 1, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:29:00'::timestamptz, '2024-10-21 14:20:00'::timestamptz, '2024-10-21 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.81 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.81, '2024-10-21 14:20:00'::timestamptz); END IF;

  -- CC1133
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1133', 'Manuel Rueda', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 15:35:00'::timestamptz, '2024-10-21 14:36:00'::timestamptz, '2024-10-21 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-21 14:36:00'::timestamptz); END IF;

  -- CC1134
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1134', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 00:00:00'::timestamptz, '2024-10-21 14:38:00'::timestamptz, '2024-10-21 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-21 14:38:00'::timestamptz); END IF;

  -- CC1135
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1135', 'Aaron Gutierrez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 15:35:00'::timestamptz, '2024-10-21 15:35:00'::timestamptz, '2024-10-21 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 15:35:00'::timestamptz); END IF;

  -- CC1136
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1136', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 16:33:00'::timestamptz, '2024-10-21 15:44:00'::timestamptz, '2024-10-21 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-21 15:44:00'::timestamptz); END IF;

  -- CC1137
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1137', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 17:28:00'::timestamptz, '2024-10-21 16:16:00'::timestamptz, '2024-10-21 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-21 16:16:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 2: Imported orders 501 to 1000';
END $$;
