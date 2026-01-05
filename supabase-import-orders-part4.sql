-- =============================================
-- CleanCloud Orders Import - Part 4 of 7
-- Orders 1501 to 2000 (of 3472)
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


  -- CC1639
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1639', 'Leonel Visueti', false, 'completed', false, 13.28, 0.33, 0, 0.72, 14.00, 0.00, 0, 11, '', '2025-01-19 00:00:00'::timestamptz, '2025-01-20 11:31:00'::timestamptz, '2025-01-19 15:02:00'::timestamptz, '2025-01-19 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-01-19 15:02:00'::timestamptz); END IF;

  -- CC1640
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1640', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 16:23:00'::timestamptz, '2025-01-20 11:32:00'::timestamptz, '2025-01-20 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-01-20 11:32:00'::timestamptz); END IF;

  -- CC1641
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1641', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 00:00:00'::timestamptz, '2025-01-20 13:56:00'::timestamptz, '2025-01-20 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-20 13:56:00'::timestamptz); END IF;

  -- CC1642
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1642', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 00:00:00'::timestamptz, '2025-01-20 13:57:00'::timestamptz, '2025-01-20 13:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-01-20 13:57:00'::timestamptz); END IF;

  -- CC1643
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1643', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 00:00:00'::timestamptz, '2025-01-20 14:48:00'::timestamptz, '2025-01-20 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-20 14:48:00'::timestamptz); END IF;

  -- CC1644
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1644', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 00:00:00'::timestamptz, '2025-01-20 14:49:00'::timestamptz, '2025-01-20 14:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-01-20 14:49:00'::timestamptz); END IF;

  -- CC1645
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1645', 'Aaron Gutierrez', false, 'completed', false, 12.08, 0.03, 0, 0.67, 12.75, 0.00, 0, 10, 'Lavandería', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 16:22:00'::timestamptz, '2025-01-20 14:57:00'::timestamptz, '2025-01-20 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.75, '2025-01-20 14:57:00'::timestamptz); END IF;

  -- CC1646
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1646', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 00:00:00'::timestamptz, '2025-01-20 15:01:00'::timestamptz, '2025-01-20 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-20 15:01:00'::timestamptz); END IF;

  -- CC1647
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1647', 'Blanca', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '0', '2025-01-20 00:00:00'::timestamptz, '2025-01-20 17:13:00'::timestamptz, '2025-01-20 16:09:00'::timestamptz, '2025-01-20 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-20 16:09:00'::timestamptz); END IF;

  -- CC1648
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1648', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.63, 0.00, 0, 1.30, 19.93, 7.45, 3, 1, 'Salón', '2025-01-21 00:00:00'::timestamptz, '2025-01-21 16:26:00'::timestamptz, '2025-01-21 12:20:00'::timestamptz, '2025-01-21 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.93 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.93, '2025-01-21 12:20:00'::timestamptz); END IF;

  -- CC1649
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1649', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2025-01-21 00:00:00'::timestamptz, '2025-01-21 16:26:00'::timestamptz, '2025-01-21 14:07:00'::timestamptz, '2025-01-21 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-01-21 14:07:00'::timestamptz); END IF;

  -- CC1650
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1650', 'Rafael Quintero', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2025-01-22 00:00:00'::timestamptz, '2025-01-22 15:08:00'::timestamptz, '2025-01-22 12:14:00'::timestamptz, '2025-01-22 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-22 12:14:00'::timestamptz); END IF;

  -- CC1651
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1651', 'Leonel Visueti', false, 'completed', false, 13.15, 0.20, 0, 0.85, 14.00, 0.00, 0, 10, '', '2025-01-23 00:00:00'::timestamptz, '2025-01-23 14:58:00'::timestamptz, '2025-01-23 14:57:00'::timestamptz, '2025-01-23 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-01-23 14:57:00'::timestamptz); END IF;

  -- CC1652
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1652', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, '', '2025-01-23 00:00:00'::timestamptz, '2025-01-23 00:00:00'::timestamptz, '2025-01-23 16:25:00'::timestamptz, '2025-01-23 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-01-23 16:25:00'::timestamptz); END IF;

  -- CC1653
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1653', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 3.74, 1, 1, '', '2025-01-24 00:00:00'::timestamptz, '2025-01-24 16:24:00'::timestamptz, '2025-01-24 13:07:00'::timestamptz, '2025-01-24 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-24 13:07:00'::timestamptz); END IF;

  -- CC1654
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1654', 'Guzmán', false, 'completed', false, 11.50, 0.00, 0, 0.81, 12.31, 4.60, 1, 1, '', '2025-01-24 00:00:00'::timestamptz, '2025-01-24 16:07:00'::timestamptz, '2025-01-24 13:08:00'::timestamptz, '2025-01-24 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.31 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.31, '2025-01-24 13:08:00'::timestamptz); END IF;

  -- CC1655
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1655', 'Guzmán', false, 'completed', false, 19.63, 0.00, 0, 1.37, 21.00, 7.85, 3, 1, '', '2025-01-24 00:00:00'::timestamptz, '2025-01-24 15:29:00'::timestamptz, '2025-01-24 13:37:00'::timestamptz, '2025-01-24 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.00, '2025-01-24 13:37:00'::timestamptz); END IF;

  -- CC1656
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 125;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1656', 'Yisel Acosta', false, 'completed', false, 20.00, 0.00, 0, 1.40, 21.40, 7.20, 2, 3, 'Lavandería', '2025-01-25 00:00:00'::timestamptz, '2025-01-27 10:26:00'::timestamptz, '2025-01-25 09:41:00'::timestamptz, '2025-01-25 09:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.40, '2025-01-25 09:41:00'::timestamptz); END IF;

  -- CC1657
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1657', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-01-25 00:00:00'::timestamptz, '2025-01-25 15:12:00'::timestamptz, '2025-01-25 09:41:00'::timestamptz, '2025-01-25 09:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-25 09:41:00'::timestamptz); END IF;

  -- CC1658
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1658', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 3.74, 1, 1, 'Lavandería', '2025-01-25 00:00:00'::timestamptz, '2025-01-25 16:09:00'::timestamptz, '2025-01-25 09:53:00'::timestamptz, '2025-01-25 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-25 09:53:00'::timestamptz); END IF;

  -- CC1659
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1659', 'Cliente Lavandería', false, 'completed', false, 3.97, 0.02, 0, 0.28, 4.25, 0.00, 0, 3, 'Lavandería', '2025-01-26 00:00:00'::timestamptz, '2025-01-27 10:26:00'::timestamptz, '2025-01-26 14:08:00'::timestamptz, '2025-01-26 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2025-01-26 14:08:00'::timestamptz); END IF;

  -- CC1660
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1660', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-01-26 00:00:00'::timestamptz, '2025-01-26 00:00:00'::timestamptz, '2025-01-26 14:10:00'::timestamptz, '2025-01-26 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-01-26 14:10:00'::timestamptz); END IF;

  -- CC1661
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1661', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-01-26 00:00:00'::timestamptz, '2025-01-27 10:26:00'::timestamptz, '2025-01-26 15:10:00'::timestamptz, '2025-01-26 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-01-26 15:10:00'::timestamptz); END IF;

  -- CC1662
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1662', 'Evelyn', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Salón', '2025-01-27 00:00:00'::timestamptz, '2025-01-27 15:18:00'::timestamptz, '2025-01-27 10:25:00'::timestamptz, '2025-01-27 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-27 10:25:00'::timestamptz); END IF;

  -- CC1663
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1663', 'Evelyn', false, 'completed', false, 1.93, 0.07, 0, 0.07, 2.00, 0.00, 0, 2, 'Salón', '2025-01-27 00:00:00'::timestamptz, '2025-01-27 15:17:00'::timestamptz, '2025-01-27 10:25:00'::timestamptz, '2025-01-27 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-01-27 10:25:00'::timestamptz); END IF;

  -- CC1664
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1664', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.75, 0.00, 0, 1.17, 17.92, 6.70, 2, 1, 'Salón', '2025-01-27 00:00:00'::timestamptz, '2025-01-27 15:17:00'::timestamptz, '2025-01-27 11:14:00'::timestamptz, '2025-01-27 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.92, '2025-01-27 11:14:00'::timestamptz); END IF;

  -- CC1665
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1665', 'Fany Luz Salon', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '0', '2025-01-27 00:00:00'::timestamptz, '2025-01-27 16:43:00'::timestamptz, '2025-01-27 15:16:00'::timestamptz, '2025-01-27 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-01-27 15:16:00'::timestamptz); END IF;

  -- CC1666
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1666', 'Leonel Visueti', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, '', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 10:45:00'::timestamptz, '2025-01-28 10:11:00'::timestamptz, '2025-01-28 10:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-28 10:11:00'::timestamptz); END IF;

  -- CC1667
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1667', 'Relax Cala,S.A', false, 'completed', false, 156.38, 0.00, 0, 10.95, 167.33, 48.95, 7, 51, 'Lavandería', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 12:22:00'::timestamptz, '2025-01-28 12:19:00'::timestamptz, '2025-01-28 12:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 167.33 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 167.33, '2025-01-28 12:19:00'::timestamptz); END IF;

  -- CC1668
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1668', 'Relax Cala,S.A', false, 'completed', false, 144.14, 0.00, 0, 10.09, 154.23, 48.95, 7, 51, 'Lavandería', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 15:29:00'::timestamptz, '2025-01-28 14:08:00'::timestamptz, '2025-01-28 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 154.23 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 154.23, '2025-01-28 14:08:00'::timestamptz); END IF;

  -- CC1669
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1669', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 16:00:00'::timestamptz, '2025-01-28 15:23:00'::timestamptz, '2025-01-28 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-01-28 15:23:00'::timestamptz); END IF;

  -- CC1670
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1670', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 00:00:00'::timestamptz, '2025-01-28 16:21:00'::timestamptz, '2025-01-28 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-01-28 16:21:00'::timestamptz); END IF;

  -- CC1671
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1671', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2025-01-28 00:00:00'::timestamptz, '2025-01-28 16:47:00'::timestamptz, '2025-01-28 16:30:00'::timestamptz, '2025-01-28 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-28 16:30:00'::timestamptz); END IF;

  -- CC1672
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 133;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1672', 'CIFSA, S.A', false, 'completed', false, 47.15, 0.00, 0, 3.30, 50.45, 15.40, 4, 26, 'Lavandería', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 15:17:00'::timestamptz, '2025-01-29 11:55:00'::timestamptz, '2025-01-29 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 50.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 50.45, '2025-01-29 11:55:00'::timestamptz); END IF;

  -- CC1673
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1673', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 21.88, 0.00, 0, 1.53, 23.41, 8.75, 2, 1, 'Salón', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 16:06:00'::timestamptz, '2025-01-29 15:14:00'::timestamptz, '2025-01-29 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.41 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.41, '2025-01-29 15:14:00'::timestamptz); END IF;

  -- CC1674
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1674', 'Aaron Gutierrez', false, 'completed', false, 12.15, 0.20, 0, 0.85, 13.00, 0.00, 0, 8, 'Lavandería', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 16:57:00'::timestamptz, '2025-01-29 16:19:00'::timestamptz, '2025-01-29 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-01-29 16:19:00'::timestamptz); END IF;

  -- CC1675
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1675', 'Leonel Visueti', false, 'completed', false, 11.22, 0.13, 0, 0.79, 12.01, 0.00, 0, 7, '', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 16:57:00'::timestamptz, '2025-01-29 16:24:00'::timestamptz, '2025-01-29 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2025-01-29 16:24:00'::timestamptz); END IF;

  -- CC1676
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1676', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 00:00:00'::timestamptz, '2025-01-29 16:47:00'::timestamptz, '2025-01-29 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-01-29 16:47:00'::timestamptz); END IF;

  -- CC1677
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1677', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2025-01-29 00:00:00'::timestamptz, '2025-01-29 00:00:00'::timestamptz, '2025-01-29 16:48:00'::timestamptz, '2025-01-29 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-01-29 16:48:00'::timestamptz); END IF;

  -- CC1678
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1678', 'Guzmán', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 2.30, 1, 2, '', '2025-01-30 00:00:00'::timestamptz, '2025-01-30 15:38:00'::timestamptz, '2025-01-30 12:31:00'::timestamptz, '2025-01-30 12:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2025-01-30 12:31:00'::timestamptz); END IF;

  -- CC1679
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1679', 'Guzmán', false, 'completed', false, 15.63, 0.00, 0, 1.09, 16.72, 6.25, 3, 1, '', '2025-01-30 00:00:00'::timestamptz, '2025-01-30 15:37:00'::timestamptz, '2025-01-30 12:33:00'::timestamptz, '2025-01-30 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.72 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.72, '2025-01-30 12:33:00'::timestamptz); END IF;

  -- CC1680
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1680', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2025-01-30 00:00:00'::timestamptz, '2025-01-30 00:00:00'::timestamptz, '2025-01-30 16:31:00'::timestamptz, '2025-01-30 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-01-30 16:31:00'::timestamptz); END IF;

  -- CC1681
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1681', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-01-31 00:00:00'::timestamptz, '2025-02-01 08:44:00'::timestamptz, '2025-01-31 15:23:00'::timestamptz, '2025-01-31 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-31 15:23:00'::timestamptz); END IF;

  -- CC1682
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1682', 'Cliente Lavandería', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 8, 'Lavandería', '2025-01-31 00:00:00'::timestamptz, '2025-02-01 08:45:00'::timestamptz, '2025-01-31 17:14:00'::timestamptz, '2025-01-31 17:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-31 17:14:00'::timestamptz); END IF;

  -- CC1683
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 125;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1683', 'Yisel Acosta', false, 'completed', false, 15.13, 0.00, 0, 0.92, 16.05, 4.05, 1, 7, 'Lavandería', '2025-02-02 00:00:00'::timestamptz, '2025-02-01 16:13:00'::timestamptz, '2025-02-01 11:46:00'::timestamptz, '2025-02-01 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.05, '2025-02-01 11:46:00'::timestamptz); END IF;

  -- CC1684
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1684', 'Rosa Arrocha', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2025-02-01 00:00:00'::timestamptz, '2025-02-01 15:29:00'::timestamptz, '2025-02-01 13:21:00'::timestamptz, '2025-02-01 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-01 13:21:00'::timestamptz); END IF;

  -- CC1685
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1685', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-02-01 00:00:00'::timestamptz, '2025-02-01 15:29:00'::timestamptz, '2025-02-01 13:23:00'::timestamptz, '2025-02-01 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-01 13:23:00'::timestamptz); END IF;

  -- CC1686
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1686', 'Cliente Lavandería', false, 'completed', false, 12.13, 0.12, 0, 0.71, 12.84, 2.90, 1, 7, 'Lavandería', '2025-02-02 00:00:00'::timestamptz, '2025-02-02 16:01:00'::timestamptz, '2025-02-02 11:44:00'::timestamptz, '2025-02-02 11:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2025-02-02 11:44:00'::timestamptz); END IF;

  -- CC1687
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1687', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2025-02-02 00:00:00'::timestamptz, '2025-02-02 16:23:00'::timestamptz, '2025-02-02 16:00:00'::timestamptz, '2025-02-02 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-02 16:00:00'::timestamptz); END IF;

  -- CC1688
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1688', 'Cliente Lavandería', false, 'completed', false, 8.48, 0.13, 0, 0.53, 9.01, 0.00, 0, 6, 'Lavandería', '2025-02-02 00:00:00'::timestamptz, '2025-02-02 16:23:00'::timestamptz, '2025-02-02 16:01:00'::timestamptz, '2025-02-02 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.01, '2025-02-02 16:01:00'::timestamptz); END IF;

  -- CC1689
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1689', 'Blanca', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '0', '2025-02-02 00:00:00'::timestamptz, '2025-02-02 16:23:00'::timestamptz, '2025-02-02 16:03:00'::timestamptz, '2025-02-02 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-02-02 16:03:00'::timestamptz); END IF;

  -- CC1690
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1690', 'Lina Perez', false, 'completed', false, 5.80, 0.07, 0, 0.20, 6.00, 0.00, 0, 6, 'Lavandería', '2025-02-03 00:00:00'::timestamptz, '2025-02-03 12:48:00'::timestamptz, '2025-02-03 11:00:00'::timestamptz, '2025-02-03 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-02-03 11:00:00'::timestamptz); END IF;

  -- CC1691
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1691', 'Relax Cala,S.A', false, 'completed', false, 182.16, 0.00, 0, 12.75, 194.91, 65.85, 12, 51, 'Lavandería', '2025-02-03 00:00:00'::timestamptz, '2025-02-03 15:39:00'::timestamptz, '2025-02-03 13:38:00'::timestamptz, '2025-02-03 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 194.91 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 194.91, '2025-02-03 13:38:00'::timestamptz); END IF;

  -- CC1692
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1692', 'Aaron Gutierrez', false, 'completed', false, 9.97, 0.14, 0, 0.53, 10.50, 0.00, 0, 8, 'Lavandería', '2025-02-03 00:00:00'::timestamptz, '2025-02-03 17:09:00'::timestamptz, '2025-02-03 15:45:00'::timestamptz, '2025-02-03 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2025-02-03 15:45:00'::timestamptz); END IF;

  -- CC1693
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1693', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-02-03 00:00:00'::timestamptz, '2025-02-03 00:00:00'::timestamptz, '2025-02-03 17:09:00'::timestamptz, '2025-02-03 17:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-03 17:09:00'::timestamptz); END IF;

  -- CC1694
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1694', 'Relax Cala,S.A', false, 'completed', false, 95.06, 0.00, 0, 6.65, 101.71, 32.25, 5, 28, 'Lavandería', '2025-02-04 00:00:00'::timestamptz, '2025-02-04 13:30:00'::timestamptz, '2025-02-04 13:26:00'::timestamptz, '2025-02-04 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 101.71 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 101.71, '2025-02-04 13:26:00'::timestamptz); END IF;

  -- CC1695
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1695', 'Relax Cala,S.A', false, 'completed', false, 56.52, 0.00, 0, 3.96, 60.48, 22.90, 3, 11, 'Lavandería', '2025-02-04 00:00:00'::timestamptz, '2025-02-04 13:30:00'::timestamptz, '2025-02-04 13:27:00'::timestamptz, '2025-02-04 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 60.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 60.48, '2025-02-04 13:27:00'::timestamptz); END IF;

  -- CC1696
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1696', 'Relax Cala,S.A', false, 'completed', false, 141.21, 0.00, 0, 9.88, 151.09, 53.65, 8, 24, 'Lavandería', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 09:59:00'::timestamptz, '2025-02-06 07:34:00'::timestamptz, '2025-02-06 07:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 151.09 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 151.09, '2025-02-06 07:34:00'::timestamptz); END IF;

  -- CC1697
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 118;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1697', 'Sysco Panama', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 1.60, 1, 2, 'Lavandería', '2025-02-06 00:00:00'::timestamptz, '2025-02-10 15:06:00'::timestamptz, '2025-02-06 09:52:00'::timestamptz, '2025-02-06 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2025-02-06 09:52:00'::timestamptz); END IF;

  -- CC1698
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1698', 'Guzmán', false, 'completed', false, 7.75, 0.00, 0, 0.54, 8.29, 3.10, 2, 1, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 14:21:00'::timestamptz, '2025-02-06 12:18:00'::timestamptz, '2025-02-06 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.29 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.29, '2025-02-06 12:18:00'::timestamptz); END IF;

  -- CC1700
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1700', 'Guzmán', false, 'completed', false, 17.63, 0.00, 0, 1.23, 18.86, 7.05, 3, 1, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 14:19:00'::timestamptz, '2025-02-06 13:15:00'::timestamptz, '2025-02-06 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.86 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.86, '2025-02-06 13:15:00'::timestamptz); END IF;

  -- CC1701
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1701', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 25.63, 0.00, 0, 1.79, 27.42, 10.25, 4, 1, 'Salón', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 15:56:00'::timestamptz, '2025-02-06 14:46:00'::timestamptz, '2025-02-06 14:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.42, '2025-02-06 14:46:00'::timestamptz); END IF;

  -- CC1702
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1702', 'Leonel Visueti', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.00, 1, 1, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 16:05:00'::timestamptz, '2025-02-06 16:04:00'::timestamptz, '2025-02-06 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2025-02-06 16:04:00'::timestamptz); END IF;

  -- CC1703
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1703', 'Leonel Visueti', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 16:33:00'::timestamptz, '2025-02-06 16:28:00'::timestamptz, '2025-02-06 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2025-02-06 16:28:00'::timestamptz); END IF;

  -- CC1704
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1704', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 16:44:00'::timestamptz, '2025-02-06 16:34:00'::timestamptz, '2025-02-06 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-02-06 16:34:00'::timestamptz); END IF;

  -- CC1705
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1705', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 5, '', '2025-02-06 00:00:00'::timestamptz, '2025-02-06 16:54:00'::timestamptz, '2025-02-06 16:45:00'::timestamptz, '2025-02-06 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-02-06 16:45:00'::timestamptz); END IF;

  -- CC1706
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1706', 'Relax Cala,S.A', false, 'completed', false, 198.81, 0.00, 0, 13.92, 212.73, 75.25, 11, 42, 'Lavandería', '2025-02-07 00:00:00'::timestamptz, '2025-02-07 12:22:00'::timestamptz, '2025-02-07 12:18:00'::timestamptz, '2025-02-07 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 212.73 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 212.73, '2025-02-07 12:18:00'::timestamptz); END IF;

  -- CC1707
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1707', 'Relax Cala,S.A', false, 'completed', false, 109.69, 0.00, 0, 7.68, 117.37, 36.75, 6, 20, 'Lavandería', '2025-02-07 00:00:00'::timestamptz, '2025-02-07 16:47:00'::timestamptz, '2025-02-07 16:45:00'::timestamptz, '2025-02-07 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 117.37 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 117.37, '2025-02-07 16:45:00'::timestamptz); END IF;

  -- CC1708
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1708', 'Relax Cala,S.A', false, 'completed', false, 101.08, 0.00, 0, 7.08, 108.16, 36.70, 6, 20, 'Lavandería', '2025-02-07 00:00:00'::timestamptz, '2025-02-07 17:00:00'::timestamptz, '2025-02-07 16:53:00'::timestamptz, '2025-02-07 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 108.16 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 108.16, '2025-02-07 16:53:00'::timestamptz); END IF;

  -- CC1709
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1709', 'Leonel Visueti', false, 'completed', false, 5.89, 0.02, 0, 0.41, 6.30, 0.00, 0, 5, '', '2025-02-07 00:00:00'::timestamptz, '2025-02-07 17:13:00'::timestamptz, '2025-02-07 17:12:00'::timestamptz, '2025-02-07 17:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.30, '2025-02-07 17:12:00'::timestamptz); END IF;

  -- CC1710
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1710', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-02-09 00:00:00'::timestamptz, '2025-02-08 14:22:00'::timestamptz, '2025-02-08 13:10:00'::timestamptz, '2025-02-08 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-02-08 13:10:00'::timestamptz); END IF;

  -- CC1711
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 125;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1711', 'Yisel Acosta', false, 'completed', false, 17.38, 0.00, 0, 1.22, 18.60, 6.15, 1, 3, 'Lavandería', '2025-02-08 00:00:00'::timestamptz, '2025-02-08 15:45:00'::timestamptz, '2025-02-08 13:14:00'::timestamptz, '2025-02-08 13:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.60, '2025-02-08 13:14:00'::timestamptz); END IF;

  -- CC1712
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1712', 'Relax Cala,S.A', false, 'completed', false, 183.53, 0.00, 0, 12.85, 196.38, 70.90, 10, 40, 'Lavandería', '2025-02-08 00:00:00'::timestamptz, '2025-02-08 17:04:00'::timestamptz, '2025-02-08 16:45:00'::timestamptz, '2025-02-08 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 196.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 196.38, '2025-02-08 16:45:00'::timestamptz); END IF;

  -- CC1713
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1713', 'Relax Cala,S.A', false, 'completed', false, 199.51, 0.00, 0, 13.97, 213.48, 72.45, 11, 56, 'Lavandería', '2025-02-10 00:00:00'::timestamptz, '2025-02-10 10:39:00'::timestamptz, '2025-02-10 10:33:00'::timestamptz, '2025-02-10 10:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 213.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 213.48, '2025-02-10 10:33:00'::timestamptz); END IF;

  -- CC1714
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1714', 'Relax Cala,S.A', false, 'completed', false, 96.83, 0.00, 0, 6.78, 103.61, 33.70, 5, 25, 'Lavandería', '2025-02-10 00:00:00'::timestamptz, '2025-02-10 12:48:00'::timestamptz, '2025-02-10 12:39:00'::timestamptz, '2025-02-10 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 103.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 103.61, '2025-02-10 12:39:00'::timestamptz); END IF;

  -- CC1715
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 136;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1715', 'Sysco Autoservicio S.A', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 1.60, 1, 2, 'Lavandería', '2025-02-10 00:00:00'::timestamptz, '2025-02-10 16:27:00'::timestamptz, '2025-02-10 15:45:00'::timestamptz, '2025-02-10 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2025-02-10 15:45:00'::timestamptz); END IF;

  -- CC1716
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1716', 'Leonel Visueti', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2025-02-10 00:00:00'::timestamptz, '2025-02-10 00:00:00'::timestamptz, '2025-02-10 16:28:00'::timestamptz, '2025-02-10 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-02-10 16:28:00'::timestamptz); END IF;

  -- CC1717
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1717', 'Relax Cala,S.A', false, 'completed', false, 129.88, 0.00, 0, 9.09, 138.97, 47.50, 5, 29, 'Lavandería', '2025-02-11 00:00:00'::timestamptz, '2025-02-12 07:34:00'::timestamptz, '2025-02-11 14:59:00'::timestamptz, '2025-02-11 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 138.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 138.97, '2025-02-11 14:59:00'::timestamptz); END IF;

  -- CC1718
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1718', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 37.38, 0.00, 0, 2.62, 40.00, 14.95, 6, 1, 'Salón', '2025-02-11 00:00:00'::timestamptz, '2025-02-11 17:19:00'::timestamptz, '2025-02-11 15:04:00'::timestamptz, '2025-02-11 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.00, '2025-02-11 15:04:00'::timestamptz); END IF;

  -- CC1719
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1719', 'Leonel Visueti', false, 'completed', false, 12.28, 0.20, 0, 0.72, 13.00, 0.00, 0, 9, '', '2025-02-11 00:00:00'::timestamptz, '2025-02-12 07:34:00'::timestamptz, '2025-02-11 16:50:00'::timestamptz, '2025-02-11 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-02-11 16:50:00'::timestamptz); END IF;

  -- CC1720
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1720', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-02-11 00:00:00'::timestamptz, '2025-02-11 00:00:00'::timestamptz, '2025-02-11 17:10:00'::timestamptz, '2025-02-11 17:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-02-11 17:10:00'::timestamptz); END IF;

  -- CC1721
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1721', 'Lina Perez', false, 'completed', false, 18.88, 0.34, 0, 1.12, 20.00, 0.00, 0, 15, 'Lavandería', '2025-02-13 00:00:00'::timestamptz, '2025-02-13 11:39:00'::timestamptz, '2025-02-13 10:41:00'::timestamptz, '2025-02-13 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-02-13 10:41:00'::timestamptz); END IF;

  -- CC1722
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1722', 'Guzmán', false, 'completed', false, 15.88, 0.00, 0, 1.11, 16.99, 6.35, 3, 1, '', '2025-02-13 00:00:00'::timestamptz, '2025-02-13 16:11:00'::timestamptz, '2025-02-13 11:40:00'::timestamptz, '2025-02-13 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.99, '2025-02-13 11:40:00'::timestamptz); END IF;

  -- CC1723
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1723', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.40, 1, 1, '', '2025-02-13 00:00:00'::timestamptz, '2025-02-13 16:11:00'::timestamptz, '2025-02-13 12:44:00'::timestamptz, '2025-02-13 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2025-02-13 12:44:00'::timestamptz); END IF;

  -- CC1724
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1724', 'Cliente Lavandería', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, 'Lavandería', '2025-02-14 00:00:00'::timestamptz, '2025-02-15 14:12:00'::timestamptz, '2025-02-14 16:35:00'::timestamptz, '2025-02-14 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-02-14 16:35:00'::timestamptz); END IF;

  -- CC1725
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1725', 'Leonel Visueti', false, 'completed', false, 20.69, 0.01, 0, 1.31, 22.00, 0.00, 0, 13, '', '2025-02-15 00:00:00'::timestamptz, '2025-02-16 08:54:00'::timestamptz, '2025-02-15 09:12:00'::timestamptz, '2025-02-15 09:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2025-02-15 09:12:00'::timestamptz); END IF;

  -- CC1726
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1726', 'Leonel Willson', false, 'completed', false, 14.95, 0.53, 0, 1.05, 16.00, 0.00, 0, 12, '0', '2025-02-15 00:00:00'::timestamptz, '2025-02-16 08:54:00'::timestamptz, '2025-02-15 15:48:00'::timestamptz, '2025-02-15 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-02-15 15:48:00'::timestamptz); END IF;

  -- CC1727
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1727', 'Leonel Visueti', false, 'completed', false, 9.48, 0.13, 0, 0.53, 10.01, 0.00, 0, 8, '', '2025-02-16 00:00:00'::timestamptz, '2025-02-16 13:23:00'::timestamptz, '2025-02-16 12:24:00'::timestamptz, '2025-02-16 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.01, '2025-02-16 12:24:00'::timestamptz); END IF;

  -- CC1728
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1728', 'Relax Cala,S.A', false, 'completed', false, 127.67, 0.00, 0, 8.94, 136.61, 44.30, 6, 39, 'Lavandería', '2025-02-16 00:00:00'::timestamptz, '2025-02-16 13:24:00'::timestamptz, '2025-02-16 13:15:00'::timestamptz, '2025-02-16 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 136.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 136.61, '2025-02-16 13:15:00'::timestamptz); END IF;

  -- CC1729
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1729', 'Blanca', false, 'completed', false, 5.67, 0.07, 0, 0.33, 6.00, 0.00, 0, 8, '0', '2025-02-16 00:00:00'::timestamptz, '2025-02-16 14:15:00'::timestamptz, '2025-02-16 13:40:00'::timestamptz, '2025-02-16 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-02-16 13:40:00'::timestamptz); END IF;

  -- CC1730
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1730', 'Lina Perez', false, 'completed', false, 26.87, 0.47, 0, 1.38, 28.25, 0.00, 0, 24, 'Lavandería', '2025-02-17 00:00:00'::timestamptz, '2025-02-17 12:23:00'::timestamptz, '2025-02-17 12:21:00'::timestamptz, '2025-02-17 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.25, '2025-02-17 12:21:00'::timestamptz); END IF;

  -- CC1731
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1731', 'Tairis - Diego', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 4, '0', '2025-02-17 00:00:00'::timestamptz, '2025-02-18 08:20:00'::timestamptz, '2025-02-17 13:58:00'::timestamptz, '2025-02-17 13:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-02-17 13:58:00'::timestamptz); END IF;

  -- CC1732
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1732', 'Relax Cala,S.A', false, 'completed', false, 132.35, 0.00, 0, 9.26, 141.61, 46.60, 7, 38, 'Lavandería', '2025-02-17 00:00:00'::timestamptz, '2025-02-18 08:22:00'::timestamptz, '2025-02-17 14:00:00'::timestamptz, '2025-02-17 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 141.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 141.61, '2025-02-17 14:00:00'::timestamptz); END IF;

  -- CC1733
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1733', 'Aaron Gutierrez', false, 'completed', false, 7.98, 0.13, 0, 0.52, 8.50, 0.00, 0, 6, 'Lavandería', '2025-02-19 00:00:00'::timestamptz, '2025-02-18 14:03:00'::timestamptz, '2025-02-18 13:06:00'::timestamptz, '2025-02-18 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2025-02-18 13:06:00'::timestamptz); END IF;

  -- CC1734
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1734', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 6, '', '2025-02-18 00:00:00'::timestamptz, '2025-02-18 14:03:00'::timestamptz, '2025-02-18 13:49:00'::timestamptz, '2025-02-18 13:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-02-18 13:49:00'::timestamptz); END IF;

  -- CC1735
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1735', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2025-02-18 00:00:00'::timestamptz, '2025-02-18 14:03:00'::timestamptz, '2025-02-18 13:50:00'::timestamptz, '2025-02-18 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-02-18 13:50:00'::timestamptz); END IF;

  -- CC1736
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1736', 'Liliana Zambrano', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 6, '0', '2025-02-18 00:00:00'::timestamptz, '2025-02-18 00:00:00'::timestamptz, '2025-02-18 14:02:00'::timestamptz, '2025-02-18 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-02-18 14:02:00'::timestamptz); END IF;

  -- CC1737
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1737', 'Oscar Oropeza', false, 'completed', false, 16.82, 0.01, 0, 1.18, 18.00, 0.00, 0, 9, 'Lavandería', '2025-02-19 00:00:00'::timestamptz, '2025-02-18 16:09:00'::timestamptz, '2025-02-18 16:08:00'::timestamptz, '2025-02-18 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-02-18 16:08:00'::timestamptz); END IF;

  -- CC1738
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1738', 'Liliana', false, 'completed', false, 0.70, 0.05, 0, 0.05, 0.75, 0.00, 0, 3, '0', '2025-02-18 00:00:00'::timestamptz, '2025-02-18 16:50:00'::timestamptz, '2025-02-18 16:11:00'::timestamptz, '2025-02-18 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2025-02-18 16:11:00'::timestamptz); END IF;

  -- CC1739
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 138;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1739', 'Francisco Paredes', false, 'completed', false, 17.68, 0.07, 0, 1.24, 18.92, 6.70, 1, 2, '0', '2025-02-19 00:00:00'::timestamptz, '2025-02-19 14:33:00'::timestamptz, '2025-02-19 08:39:00'::timestamptz, '2025-02-19 08:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.92, '2025-02-19 08:39:00'::timestamptz); END IF;

  -- CC1740
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1740', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2025-02-19 00:00:00'::timestamptz, '2025-02-19 14:33:00'::timestamptz, '2025-02-19 13:22:00'::timestamptz, '2025-02-19 13:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-02-19 13:22:00'::timestamptz); END IF;

  -- CC1741
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1741', 'Cliente Lavandería', false, 'completed', false, 8.54, 0.09, 0, 0.56, 9.10, 2.45, 1, 4, 'Lavandería', '2025-02-19 00:00:00'::timestamptz, '2025-02-19 16:32:00'::timestamptz, '2025-02-19 16:31:00'::timestamptz, '2025-02-19 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.10, '2025-02-19 16:31:00'::timestamptz); END IF;

  -- CC1742
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1742', 'Leonel Visueti', false, 'completed', false, 4.74, 0.13, 0, 0.26, 5.00, 0.00, 0, 5, '', '2025-02-20 00:00:00'::timestamptz, '2025-02-20 11:31:00'::timestamptz, '2025-02-20 11:31:00'::timestamptz, '2025-02-20 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-20 11:31:00'::timestamptz); END IF;

  -- CC1743
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1743', 'Guzmán', false, 'completed', false, 15.50, 0.00, 0, 1.09, 16.59, 6.20, 3, 1, '', '2025-02-20 00:00:00'::timestamptz, '2025-02-20 14:44:00'::timestamptz, '2025-02-20 11:32:00'::timestamptz, '2025-02-20 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.59, '2025-02-20 11:32:00'::timestamptz); END IF;

  -- CC1744
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1744', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.40, 1, 1, '', '2025-02-20 00:00:00'::timestamptz, '2025-02-20 14:43:00'::timestamptz, '2025-02-20 14:13:00'::timestamptz, '2025-02-20 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2025-02-20 14:13:00'::timestamptz); END IF;

  -- CC1745
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1745', 'Guzmán', false, 'completed', false, 7.88, 0.00, 0, 0.55, 8.43, 4.50, 1, 1, '', '2025-02-20 00:00:00'::timestamptz, '2025-02-20 16:11:00'::timestamptz, '2025-02-20 16:10:00'::timestamptz, '2025-02-20 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.43, '2025-02-20 16:10:00'::timestamptz); END IF;

  -- CC1746
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1746', 'Leonel Visueti', false, 'completed', false, 3.80, 0.07, 0, 0.20, 4.00, 0.00, 0, 3, '', '2025-02-20 00:00:00'::timestamptz, '2025-02-20 16:34:00'::timestamptz, '2025-02-20 16:13:00'::timestamptz, '2025-02-20 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-02-20 16:13:00'::timestamptz); END IF;

  -- CC1747
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1747', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-02-21 00:00:00'::timestamptz, '2025-02-21 16:17:00'::timestamptz, '2025-02-20 16:14:00'::timestamptz, '2025-02-20 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-20 16:14:00'::timestamptz); END IF;

  -- CC1748
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1748', 'Leonel Visueti', false, 'completed', false, 2.37, 0.00, 0, 0.17, 2.54, 0.00, 0, 3, '', '2025-02-21 00:00:00'::timestamptz, '2025-02-21 16:17:00'::timestamptz, '2025-02-21 14:07:00'::timestamptz, '2025-02-21 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.54, '2025-02-21 14:07:00'::timestamptz); END IF;

  -- CC1749
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1749', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.88, 0.00, 0, 1.32, 20.20, 7.55, 2, 1, 'Salón', '2025-02-21 00:00:00'::timestamptz, '2025-02-21 16:17:00'::timestamptz, '2025-02-21 16:16:00'::timestamptz, '2025-02-21 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.20, '2025-02-21 16:16:00'::timestamptz); END IF;

  -- CC1750
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1750', 'Leonel Visueti', false, 'completed', false, 2.60, 0.02, 0, 0.15, 2.75, 0.00, 0, 3, '', '2025-02-21 00:00:00'::timestamptz, '2025-02-21 17:00:00'::timestamptz, '2025-02-21 16:43:00'::timestamptz, '2025-02-21 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2025-02-21 16:43:00'::timestamptz); END IF;

  -- CC1751
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1751', 'Relax Cala,S.A', false, 'completed', false, 164.14, 0.00, 0, 11.49, 175.63, 52.95, 7, 53, 'Lavandería', '2025-02-22 00:00:00'::timestamptz, '2025-07-04 12:08:00'::timestamptz, '2025-02-22 13:36:00'::timestamptz, '2025-02-22 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 175.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 175.63, '2025-02-22 13:36:00'::timestamptz); END IF;

  -- CC1752
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1752', 'Relax Cala,S.A', false, 'completed', false, 154.14, 0.00, 0, 10.79, 164.93, 52.95, 7, 53, 'Lavandería', '2025-02-22 00:00:00'::timestamptz, '2025-02-22 15:18:00'::timestamptz, '2025-02-22 13:51:00'::timestamptz, '2025-02-22 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 164.93 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 164.93, '2025-02-22 13:51:00'::timestamptz); END IF;

  -- CC1753
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1753', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-02-22 00:00:00'::timestamptz, '2025-02-22 15:21:00'::timestamptz, '2025-02-22 15:19:00'::timestamptz, '2025-02-22 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-02-22 15:19:00'::timestamptz); END IF;

  -- CC1754
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1754', 'Fernando Ortega', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-02-22 00:00:00'::timestamptz, '2025-02-22 17:31:00'::timestamptz, '2025-02-22 17:01:00'::timestamptz, '2025-02-22 17:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-22 17:01:00'::timestamptz); END IF;

  -- CC1755
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1755', 'Oscar Oropeza', false, 'completed', false, 16.82, 1.88, 0, 1.18, 18.00, 0.00, 0, 10, 'Lavandería', '2025-02-22 00:00:00'::timestamptz, '2025-02-22 17:32:00'::timestamptz, '2025-02-22 17:29:00'::timestamptz, '2025-02-22 17:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-02-22 17:29:00'::timestamptz); END IF;

  -- CC1756
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1756', 'Relax Cala,S.A', false, 'completed', false, 94.61, 0.00, 0, 6.62, 101.23, 32.05, 4, 28, 'Lavandería', '2025-02-23 00:00:00'::timestamptz, '2025-02-23 13:35:00'::timestamptz, '2025-02-23 13:27:00'::timestamptz, '2025-02-23 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 101.23 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 101.23, '2025-02-23 13:27:00'::timestamptz); END IF;

  -- CC1757
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1757', 'Aaron Gutierrez', false, 'completed', false, 9.41, 0.20, 0, 0.59, 10.00, 0.00, 0, 8, 'Lavandería', '2025-02-23 00:00:00'::timestamptz, '2025-02-24 13:56:00'::timestamptz, '2025-02-23 15:08:00'::timestamptz, '2025-02-23 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-02-23 15:08:00'::timestamptz); END IF;

  -- CC1758
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1758', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-02-23 00:00:00'::timestamptz, '2025-02-23 00:00:00'::timestamptz, '2025-02-23 15:26:00'::timestamptz, '2025-02-23 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-23 15:26:00'::timestamptz); END IF;

  -- CC1759
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1759', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 10, '', '2025-02-23 00:00:00'::timestamptz, '2025-02-23 00:00:00'::timestamptz, '2025-02-23 15:28:00'::timestamptz, '2025-02-23 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-23 15:28:00'::timestamptz); END IF;

  -- CC1760
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1760', 'Relax Cala,S.A', false, 'completed', false, 129.74, 0.00, 0, 9.08, 138.82, 46.55, 7, 33, 'Lavandería', '2025-02-24 00:00:00'::timestamptz, '2025-02-24 17:04:00'::timestamptz, '2025-02-24 13:51:00'::timestamptz, '2025-02-24 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 138.82 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 138.82, '2025-02-24 13:51:00'::timestamptz); END IF;

  -- CC1761
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1761', 'Leonel Visueti', false, 'completed', false, 10.41, 0.20, 0, 0.59, 11.00, 0.00, 0, 9, '', '2025-02-24 00:00:00'::timestamptz, '2025-02-24 17:04:00'::timestamptz, '2025-02-24 14:33:00'::timestamptz, '2025-02-24 14:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2025-02-24 14:33:00'::timestamptz); END IF;

  -- CC1762
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1762', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-02-24 00:00:00'::timestamptz, '2025-02-24 00:00:00'::timestamptz, '2025-02-24 17:00:00'::timestamptz, '2025-02-24 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-24 17:00:00'::timestamptz); END IF;

  -- CC1763
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1763', 'Leonel Visueti', false, 'completed', false, 11.34, 0.14, 0, 0.66, 12.00, 0.00, 0, 10, '', '2025-02-26 00:00:00'::timestamptz, '2025-02-26 17:57:00'::timestamptz, '2025-02-26 15:01:00'::timestamptz, '2025-02-26 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-02-26 15:01:00'::timestamptz); END IF;

  -- CC1764
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1764', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 6, '', '2025-02-26 00:00:00'::timestamptz, '2025-02-26 00:00:00'::timestamptz, '2025-02-26 17:19:00'::timestamptz, '2025-02-26 17:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-02-26 17:19:00'::timestamptz); END IF;

  -- CC1765
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1765', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2025-02-26 00:00:00'::timestamptz, '2025-02-26 17:57:00'::timestamptz, '2025-02-26 17:19:00'::timestamptz, '2025-02-26 17:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-26 17:19:00'::timestamptz); END IF;

  -- CC1766
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1766', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-02-26 00:00:00'::timestamptz, '2025-02-26 00:00:00'::timestamptz, '2025-02-26 17:26:00'::timestamptz, '2025-02-26 17:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-02-26 17:26:00'::timestamptz); END IF;

  -- CC1767
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1767', 'Guzmán', false, 'completed', false, 33.50, 0.00, 0, 2.35, 35.85, 3.80, 1, 5, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-27 17:22:00'::timestamptz, '2025-02-27 12:21:00'::timestamptz, '2025-02-27 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.85, '2025-02-27 12:21:00'::timestamptz); END IF;

  -- CC1768
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1768', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.80, 1, 1, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-27 17:22:00'::timestamptz, '2025-02-27 15:07:00'::timestamptz, '2025-02-27 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2025-02-27 15:07:00'::timestamptz); END IF;

  -- CC1769
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1769', 'Guzmán', false, 'completed', false, 7.88, 0.00, 0, 0.55, 8.43, 3.15, 2, 1, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-27 17:22:00'::timestamptz, '2025-02-27 15:10:00'::timestamptz, '2025-02-27 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.43, '2025-02-27 15:10:00'::timestamptz); END IF;

  -- CC1770
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1770', 'Guzmán', false, 'completed', false, 34.50, 0.00, 0, 2.42, 36.92, 9.00, 3, 3, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-28 16:28:00'::timestamptz, '2025-02-27 15:21:00'::timestamptz, '2025-02-27 15:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.92, '2025-02-27 15:21:00'::timestamptz); END IF;

  -- CC1771
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1771', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-27 00:00:00'::timestamptz, '2025-02-27 15:44:00'::timestamptz, '2025-02-27 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-02-27 15:44:00'::timestamptz); END IF;

  -- CC1772
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1772', 'Guzmán', false, 'completed', false, 7.88, 0.00, 0, 0.55, 8.43, 4.50, 1, 1, '', '2025-02-27 00:00:00'::timestamptz, '2025-02-28 16:28:00'::timestamptz, '2025-02-27 15:57:00'::timestamptz, '2025-02-27 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.43, '2025-02-27 15:57:00'::timestamptz); END IF;

  -- CC1773
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1773', 'Leonel Visueti', false, 'completed', false, 4.80, 0.07, 0, 0.20, 5.00, 0.00, 0, 4, '', '2025-02-28 00:00:00'::timestamptz, '2025-02-28 18:01:00'::timestamptz, '2025-02-28 16:30:00'::timestamptz, '2025-02-28 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-28 16:30:00'::timestamptz); END IF;

  -- CC1774
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1774', 'Cliente Lavandería', false, 'completed', false, 1.73, 0.02, 0, 0.07, 1.80, 0.00, 0, 4, 'Lavandería', '2025-02-28 00:00:00'::timestamptz, '2025-02-28 16:54:00'::timestamptz, '2025-02-28 16:34:00'::timestamptz, '2025-02-28 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.80 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.80, '2025-02-28 16:34:00'::timestamptz); END IF;

  -- CC1775
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1775', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2025-02-28 00:00:00'::timestamptz, '2025-02-28 18:01:00'::timestamptz, '2025-02-28 16:54:00'::timestamptz, '2025-02-28 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-02-28 16:54:00'::timestamptz); END IF;

  -- CC1776
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1776', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-03-01 00:00:00'::timestamptz, '2025-03-01 00:00:00'::timestamptz, '2025-03-01 10:41:00'::timestamptz, '2025-03-01 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-03-01 10:41:00'::timestamptz); END IF;

  -- CC1777
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1777', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, '', '2025-03-01 00:00:00'::timestamptz, '2025-03-01 00:00:00'::timestamptz, '2025-03-01 12:01:00'::timestamptz, '2025-03-01 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-03-01 12:01:00'::timestamptz); END IF;

  -- CC1778
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1778', 'Guzmán', false, 'completed', false, 14.75, 0.00, 0, 1.03, 15.78, 3.50, 1, 2, '', '2025-03-01 00:00:00'::timestamptz, '2025-03-01 14:37:00'::timestamptz, '2025-03-01 13:49:00'::timestamptz, '2025-03-01 13:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.78 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.78, '2025-03-01 13:49:00'::timestamptz); END IF;

  -- CC1779
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1779', 'Liliana', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '0', '2025-03-03 00:00:00'::timestamptz, '2025-03-03 17:35:00'::timestamptz, '2025-03-03 09:12:00'::timestamptz, '2025-03-03 09:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-03-03 09:12:00'::timestamptz); END IF;

  -- CC1780
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1780', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-03-03 00:00:00'::timestamptz, '2025-03-03 17:34:00'::timestamptz, '2025-03-03 10:09:00'::timestamptz, '2025-03-03 10:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-03-03 10:09:00'::timestamptz); END IF;

  -- CC1781
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1781', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-03-03 00:00:00'::timestamptz, '2025-03-03 17:34:00'::timestamptz, '2025-03-03 10:10:00'::timestamptz, '2025-03-03 10:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-03-03 10:10:00'::timestamptz); END IF;

  -- CC1782
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1782', 'Relax Cala,S.A', false, 'completed', false, 110.21, 0.00, 0, 7.71, 117.92, 41.65, 6, 34, 'Lavandería', '2025-03-03 00:00:00'::timestamptz, '2025-03-03 17:34:00'::timestamptz, '2025-03-03 16:47:00'::timestamptz, '2025-03-03 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 117.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 117.92, '2025-03-03 16:47:00'::timestamptz); END IF;

  -- CC1783
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1783', 'Leonel Visueti', false, 'completed', false, 3.80, 0.07, 0, 0.20, 4.00, 0.00, 0, 3, '', '2025-03-03 00:00:00'::timestamptz, '2025-03-03 17:34:00'::timestamptz, '2025-03-03 17:06:00'::timestamptz, '2025-03-03 17:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-03-03 17:06:00'::timestamptz); END IF;

  -- CC1784
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1784', 'Guzmán', false, 'completed', false, 12.25, 0.00, 0, 0.86, 13.11, 4.90, 1, 1, '', '2025-03-05 00:00:00'::timestamptz, '2025-03-05 13:53:00'::timestamptz, '2025-03-05 12:46:00'::timestamptz, '2025-03-05 12:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.11 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.11, '2025-03-05 12:46:00'::timestamptz); END IF;

  -- CC1785
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1785', 'Leonel Visueti', false, 'completed', false, 9.75, 0.00, 0, 0.61, 10.36, 0.80, 1, 9, '', '2025-03-05 00:00:00'::timestamptz, '2025-03-05 16:38:00'::timestamptz, '2025-03-05 14:14:00'::timestamptz, '2025-03-05 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.36 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.36, '2025-03-05 14:14:00'::timestamptz); END IF;

  -- CC1786
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1786', 'Rosa Arrocha', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2025-03-05 00:00:00'::timestamptz, '2025-03-05 16:38:00'::timestamptz, '2025-03-05 15:38:00'::timestamptz, '2025-03-05 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-03-05 15:38:00'::timestamptz); END IF;

  -- CC1787
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1787', 'Guzmán', false, 'completed', false, 16.38, 0.00, 0, 1.15, 17.53, 6.55, 3, 1, '', '2025-03-06 00:00:00'::timestamptz, '2025-03-06 16:43:00'::timestamptz, '2025-03-06 13:44:00'::timestamptz, '2025-03-06 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.53 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.53, '2025-03-06 13:44:00'::timestamptz); END IF;

  -- CC1788
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1788', 'Guzmán', false, 'completed', false, 6.25, 0.00, 0, 0.44, 6.69, 2.50, 1, 1, '', '2025-03-06 00:00:00'::timestamptz, '2025-03-06 16:43:00'::timestamptz, '2025-03-06 13:47:00'::timestamptz, '2025-03-06 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.69 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.69, '2025-03-06 13:47:00'::timestamptz); END IF;

  -- CC1789
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1789', 'Guzmán', false, 'completed', false, 6.56, 0.00, 0, 0.46, 7.02, 3.75, 1, 1, '', '2025-03-06 00:00:00'::timestamptz, '2025-03-06 16:43:00'::timestamptz, '2025-03-06 15:18:00'::timestamptz, '2025-03-06 15:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.02 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.02, '2025-03-06 15:18:00'::timestamptz); END IF;

  -- CC1790
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1790', 'Leonel Visueti', false, 'completed', false, 9.60, 0.14, 0, 0.40, 10.00, 0.00, 0, 9, '', '2025-03-06 00:00:00'::timestamptz, '2025-03-06 16:44:00'::timestamptz, '2025-03-06 16:42:00'::timestamptz, '2025-03-06 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-03-06 16:42:00'::timestamptz); END IF;

  -- CC1791
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1791', 'Blanca', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-03-06 00:00:00'::timestamptz, '2025-03-06 16:44:00'::timestamptz, '2025-03-06 16:42:00'::timestamptz, '2025-03-06 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-03-06 16:42:00'::timestamptz); END IF;

  -- CC1792
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1792', 'Leonel Visueti', false, 'completed', false, 8.60, 0.14, 0, 0.40, 9.00, 0.00, 0, 8, '', '2025-03-07 00:00:00'::timestamptz, '2025-03-07 12:24:00'::timestamptz, '2025-03-07 12:00:00'::timestamptz, '2025-03-07 12:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-03-07 12:00:00'::timestamptz); END IF;

  -- CC1793
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1793', 'Relax Cala,S.A', false, 'completed', false, 161.17, 0.00, 0, 11.28, 172.45, 56.30, 7, 52, 'Lavandería', '2025-03-07 00:00:00'::timestamptz, '2025-03-07 12:25:00'::timestamptz, '2025-03-07 12:23:00'::timestamptz, '2025-03-07 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 172.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 172.45, '2025-03-07 12:23:00'::timestamptz); END IF;

  -- CC1794
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1794', 'Oscar Oropeza', false, 'completed', false, 20.56, 3.75, 0, 1.44, 22.00, 0.00, 0, 13, 'Lavandería', '2025-03-07 00:00:00'::timestamptz, '2025-03-07 17:31:00'::timestamptz, '2025-03-07 17:28:00'::timestamptz, '2025-03-07 17:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2025-03-07 17:28:00'::timestamptz); END IF;

  -- CC1795
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1795', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2025-03-09 00:00:00'::timestamptz, '2025-03-09 14:27:00'::timestamptz, '2025-03-09 14:20:00'::timestamptz, '2025-03-09 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-03-09 14:20:00'::timestamptz); END IF;

  -- CC1796
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1796', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-03-09 00:00:00'::timestamptz, '2025-03-09 00:00:00'::timestamptz, '2025-03-09 14:21:00'::timestamptz, '2025-03-09 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-03-09 14:21:00'::timestamptz); END IF;

  -- CC1797
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1797', 'Lina Perez', false, 'completed', false, 18.76, 0.46, 0, 1.24, 20.00, 0.00, 0, 14, 'Lavandería', '2025-03-10 00:00:00'::timestamptz, '2025-03-10 15:30:00'::timestamptz, '2025-03-10 11:49:00'::timestamptz, '2025-03-10 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-03-10 11:49:00'::timestamptz); END IF;

  -- CC1798
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1798', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 9, '', '2025-03-10 00:00:00'::timestamptz, '2025-03-10 00:00:00'::timestamptz, '2025-03-10 17:19:00'::timestamptz, '2025-03-10 17:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-03-10 17:19:00'::timestamptz); END IF;

  -- CC1799
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1799', 'Leonel Visueti', false, 'completed', false, 6.80, 0.07, 0, 0.20, 7.00, 0.00, 0, 7, '', '2025-03-10 00:00:00'::timestamptz, '2025-03-10 17:24:00'::timestamptz, '2025-03-10 17:22:00'::timestamptz, '2025-03-10 17:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-03-10 17:22:00'::timestamptz); END IF;

  -- CC1800
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 125;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1800', 'Yisel Acosta', false, 'completed', false, 13.60, 0.15, 0, 0.85, 14.45, 4.10, 1, 6, 'Lavandería', '2025-03-11 00:00:00'::timestamptz, '2025-03-11 14:51:00'::timestamptz, '2025-03-11 11:41:00'::timestamptz, '2025-03-11 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.45, '2025-03-11 11:41:00'::timestamptz); END IF;

  -- CC1801
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1801', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-03-11 00:00:00'::timestamptz, '2025-03-11 00:00:00'::timestamptz, '2025-03-11 15:15:00'::timestamptz, '2025-03-11 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-03-11 15:15:00'::timestamptz); END IF;

  -- CC1802
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1802', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-03-12 00:00:00'::timestamptz, '2025-03-12 17:24:00'::timestamptz, '2025-03-12 16:19:00'::timestamptz, '2025-03-12 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-03-12 16:19:00'::timestamptz); END IF;

  -- CC1803
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1803', 'Cliente Lavandería', false, 'completed', false, 0.50, 0.00, 0, 0.04, 0.54, 0.00, 0, 1, 'Lavandería', '2025-03-12 00:00:00'::timestamptz, '2025-03-12 17:25:00'::timestamptz, '2025-03-12 16:20:00'::timestamptz, '2025-03-12 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.54, '2025-03-12 16:20:00'::timestamptz); END IF;

  -- CC1804
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1804', 'Guzmán', false, 'completed', false, 30.00, 0.00, 0, 2.10, 32.10, 12.00, 5, 1, '', '2025-03-13 00:00:00'::timestamptz, '2025-03-13 13:53:00'::timestamptz, '2025-03-13 10:14:00'::timestamptz, '2025-03-13 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 32.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 32.10, '2025-03-13 10:14:00'::timestamptz); END IF;

  -- CC1805
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1805', 'Guzmán', false, 'completed', false, 7.13, 0.00, 0, 0.50, 7.63, 2.85, 1, 1, '', '2025-03-13 00:00:00'::timestamptz, '2025-03-13 13:53:00'::timestamptz, '2025-03-13 12:49:00'::timestamptz, '2025-03-13 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.63, '2025-03-13 12:49:00'::timestamptz); END IF;

  -- CC1806
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1806', 'Blanca', false, 'completed', false, 8.54, 0.07, 0, 0.46, 9.00, 0.00, 0, 11, '0', '2025-03-13 00:00:00'::timestamptz, '2025-03-13 15:29:00'::timestamptz, '2025-03-13 14:39:00'::timestamptz, '2025-03-13 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-03-13 14:39:00'::timestamptz); END IF;

  -- CC1807
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1807', 'Liliana Zambrano', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '0', '2025-03-14 00:00:00'::timestamptz, '2025-03-14 16:59:00'::timestamptz, '2025-03-14 16:18:00'::timestamptz, '2025-03-14 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-03-14 16:18:00'::timestamptz); END IF;

  -- CC1808
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1808', 'Rosa Arrocha', false, 'completed', false, 9.99, 0.01, 0, 0.59, 10.58, 3.20, 1, 6, 'Lavandería', '2025-03-16 00:00:00'::timestamptz, '2025-03-15 10:49:00'::timestamptz, '2025-03-15 09:19:00'::timestamptz, '2025-03-15 09:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.58 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.58, '2025-03-15 09:19:00'::timestamptz); END IF;

  -- CC1809
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1809', 'Yara Rangel', false, 'completed', false, 5.67, 0.07, 0, 0.33, 6.00, 0.00, 0, 5, '0', '2025-03-15 00:00:00'::timestamptz, '2025-03-15 10:49:00'::timestamptz, '2025-03-15 10:04:00'::timestamptz, '2025-03-15 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-03-15 10:04:00'::timestamptz); END IF;

  -- CC1810
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 140;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1810', 'Kianeth Diaz', false, 'completed', false, 32.67, 0.09, 0, 2.08, 34.75, 0.00, 0, 47, 'Lavandería', '2025-03-15 00:00:00'::timestamptz, '2025-03-15 16:31:00'::timestamptz, '2025-03-15 10:58:00'::timestamptz, '2025-03-15 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.75, '2025-03-15 10:58:00'::timestamptz); END IF;

  -- CC1811
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 141;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1811', 'Juan Camilo Gomez', false, 'completed', false, 16.88, 0.00, 0, 1.18, 18.06, 4.75, 2, 6, 'Lavandería', '2025-03-15 00:00:00'::timestamptz, '2025-03-15 16:31:00'::timestamptz, '2025-03-15 12:14:00'::timestamptz, '2025-03-15 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.06, '2025-03-15 12:14:00'::timestamptz); END IF;

  -- CC1812
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1812', 'Leonel Visueti', false, 'completed', false, 4.21, 0.03, 0, 0.29, 4.50, 0.00, 0, 4, '', '2025-03-15 00:00:00'::timestamptz, '2025-03-15 16:31:00'::timestamptz, '2025-03-15 15:18:00'::timestamptz, '2025-03-15 15:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-03-15 15:18:00'::timestamptz); END IF;

  -- CC1813
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1813', 'Leonel Visueti', false, 'completed', false, 1.55, 0.00, 0, 0.09, 1.64, 0.00, 0, 5, '', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 13:40:00'::timestamptz, '2025-03-16 12:58:00'::timestamptz, '2025-03-16 12:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.64 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.64, '2025-03-16 12:58:00'::timestamptz); END IF;

  -- CC1814
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1814', 'Cliente Lavandería', false, 'completed', false, 12.71, 0.27, 0, 0.79, 13.50, 0.00, 0, 12, 'Lavandería', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 13:45:00'::timestamptz, '2025-03-16 13:01:00'::timestamptz, '2025-03-16 13:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.50, '2025-03-16 13:01:00'::timestamptz); END IF;

  -- CC1815
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1815', 'Liliana', false, 'completed', false, 4.47, 0.02, 0, 0.28, 4.75, 0.00, 0, 4, '0', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 15:09:00'::timestamptz, '2025-03-16 13:03:00'::timestamptz, '2025-03-16 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.75, '2025-03-16 13:03:00'::timestamptz); END IF;

  -- CC1816
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1816', 'Lina Perez', false, 'completed', false, 25.30, 0.66, 0, 1.70, 27.00, 0.00, 0, 19, 'Lavandería', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 13:46:00'::timestamptz, '2025-03-16 13:06:00'::timestamptz, '2025-03-16 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.00, '2025-03-16 13:06:00'::timestamptz); END IF;

  -- CC1817
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1817', 'Leonel Visueti', false, 'completed', false, 9.35, 0.26, 0, 0.65, 10.00, 0.00, 0, 10, '', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 15:09:00'::timestamptz, '2025-03-16 13:42:00'::timestamptz, '2025-03-16 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-03-16 13:42:00'::timestamptz); END IF;

  -- CC1818
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1818', 'Cliente Lavandería', false, 'completed', false, 3.80, 0.07, 0, 0.20, 4.00, 0.00, 0, 3, 'Lavandería', '2025-03-16 00:00:00'::timestamptz, '2025-03-16 15:09:00'::timestamptz, '2025-03-16 13:47:00'::timestamptz, '2025-03-16 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-03-16 13:47:00'::timestamptz); END IF;

  -- CC1819
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1819', 'Oscar Oropeza', false, 'completed', false, 16.82, 0.27, 0, 1.18, 18.00, 0.00, 0, 11, 'Lavandería', '2025-03-17 00:00:00'::timestamptz, '2025-03-17 17:06:00'::timestamptz, '2025-03-17 17:04:00'::timestamptz, '2025-03-17 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-03-17 17:04:00'::timestamptz); END IF;

  -- CC1820
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1820', 'Leonel Visueti', false, 'completed', false, 9.47, 0.14, 0, 0.53, 10.00, 0.00, 0, 8, '', '2025-03-17 00:00:00'::timestamptz, '2025-03-17 17:06:00'::timestamptz, '2025-03-17 17:05:00'::timestamptz, '2025-03-17 17:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-03-17 17:05:00'::timestamptz); END IF;

  -- CC1821
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1821', 'Relax Cala,S.A', false, 'completed', false, 143.36, 0.00, 0, 10.04, 153.40, 51.05, 5, 40, 'Lavandería', '2025-03-18 00:00:00'::timestamptz, '2025-03-18 16:09:00'::timestamptz, '2025-03-18 12:34:00'::timestamptz, '2025-03-18 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 153.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 153.40, '2025-03-18 12:34:00'::timestamptz); END IF;

  -- CC1822
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1822', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2025-03-19 00:00:00'::timestamptz, '2025-03-19 17:21:00'::timestamptz, '2025-03-19 17:20:00'::timestamptz, '2025-03-19 17:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-03-19 17:20:00'::timestamptz); END IF;

  -- CC1823
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1823', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-03-19 00:00:00'::timestamptz, '2025-03-19 00:00:00'::timestamptz, '2025-03-19 17:20:00'::timestamptz, '2025-03-19 17:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-03-19 17:20:00'::timestamptz); END IF;

  -- CC1824
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1824', 'Guzmán', false, 'completed', false, 7.13, 0.00, 0, 0.50, 7.63, 2.85, 1, 1, '', '2025-03-20 00:00:00'::timestamptz, '2025-03-20 17:18:00'::timestamptz, '2025-03-20 12:43:00'::timestamptz, '2025-03-20 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.63, '2025-03-20 12:43:00'::timestamptz); END IF;

  -- CC1825
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1825', 'Guzmán', false, 'completed', false, 29.88, 0.00, 0, 2.09, 31.97, 11.95, 5, 1, '', '2025-03-20 00:00:00'::timestamptz, '2025-03-20 17:07:00'::timestamptz, '2025-03-20 12:45:00'::timestamptz, '2025-03-20 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.97, '2025-03-20 12:45:00'::timestamptz); END IF;

  -- CC1826
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1826', 'Grethell Guevara', false, 'completed', false, 127.25, 0.00, 0, 8.91, 136.16, 45.70, 9, 14, 'Lavandería', '2025-03-21 00:00:00'::timestamptz, '2025-03-21 17:20:00'::timestamptz, '2025-03-21 15:49:00'::timestamptz, '2025-03-21 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 136.16 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 136.16, '2025-03-21 15:49:00'::timestamptz); END IF;

  -- CC1827
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1827', 'Leonel Visueti', false, 'completed', false, 4.21, 0.03, 0, 0.29, 4.50, 0.00, 0, 4, '', '2025-03-21 00:00:00'::timestamptz, '2025-03-21 15:58:00'::timestamptz, '2025-03-21 15:55:00'::timestamptz, '2025-03-21 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-03-21 15:55:00'::timestamptz); END IF;

  -- CC1828
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1828', 'Blanca', false, 'completed', false, 6.31, 0.05, 0, 0.44, 6.75, 0.00, 0, 6, '0', '2025-03-21 00:00:00'::timestamptz, '2025-03-21 16:41:00'::timestamptz, '2025-03-21 15:57:00'::timestamptz, '2025-03-21 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.75, '2025-03-21 15:57:00'::timestamptz); END IF;

  -- CC1829
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 141;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1829', 'Juan Camilo Gomez', false, 'completed', false, 13.13, 0.00, 0, 0.92, 14.05, 4.35, 2, 4, 'Lavandería', '2025-03-22 00:00:00'::timestamptz, '2025-03-22 15:42:00'::timestamptz, '2025-03-22 12:17:00'::timestamptz, '2025-03-22 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.05, '2025-03-22 12:17:00'::timestamptz); END IF;

  -- CC1830
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1830', 'Relax Cala,S.A', false, 'completed', false, 104.75, 0.00, 0, 7.33, 112.08, 35.00, 3, 35, 'Lavandería', '2025-03-22 00:00:00'::timestamptz, '2025-03-22 15:48:00'::timestamptz, '2025-03-22 15:47:00'::timestamptz, '2025-03-22 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 112.08 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 112.08, '2025-03-22 15:47:00'::timestamptz); END IF;

  -- CC1831
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1831', 'Leonel Visueti', false, 'completed', false, 9.48, 0.13, 0, 0.53, 10.01, 0.00, 0, 7, '', '2025-03-22 00:00:00'::timestamptz, '2025-03-22 16:51:00'::timestamptz, '2025-03-22 16:50:00'::timestamptz, '2025-03-22 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.01, '2025-03-22 16:50:00'::timestamptz); END IF;

  -- CC1832
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1832', 'Rafael Quintero', false, 'completed', false, 8.63, 0.00, 0, 0.60, 9.23, 3.05, 1, 2, '0', '2025-03-24 00:00:00'::timestamptz, '2025-03-24 16:39:00'::timestamptz, '2025-03-24 09:16:00'::timestamptz, '2025-03-24 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.23 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.23, '2025-03-24 09:16:00'::timestamptz); END IF;

  -- CC1833
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1833', 'Relax Cala,S.A', false, 'completed', false, 95.23, 0.00, 0, 6.67, 101.90, 32.10, 3, 29, 'Lavandería', '2025-03-24 00:00:00'::timestamptz, '2025-03-24 16:39:00'::timestamptz, '2025-03-24 10:12:00'::timestamptz, '2025-03-24 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 101.90 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 101.90, '2025-03-24 10:12:00'::timestamptz); END IF;

  -- CC1835
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1835', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 00:00:00'::timestamptz, '2025-03-25 12:06:00'::timestamptz, '2025-03-25 12:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-03-25 12:06:00'::timestamptz); END IF;

  -- CC1836
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1836', 'Liliana', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '0', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 00:00:00'::timestamptz, '2025-03-25 12:17:00'::timestamptz, '2025-03-25 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-03-25 12:17:00'::timestamptz); END IF;

  -- CC1837
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1837', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 00:00:00'::timestamptz, '2025-03-25 12:40:00'::timestamptz, '2025-03-25 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-03-25 12:40:00'::timestamptz); END IF;

  -- CC1838
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1838', 'Relax Cala,S.A', false, 'completed', false, 105.50, 0.00, 0, 7.39, 112.89, 38.00, 4, 23, 'Lavandería', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 18:05:00'::timestamptz, '2025-03-25 13:16:00'::timestamptz, '2025-03-25 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 112.89 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 112.89, '2025-03-25 13:16:00'::timestamptz); END IF;

  -- CC1839
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1839', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 13:51:00'::timestamptz, '2025-03-25 13:24:00'::timestamptz, '2025-03-25 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-03-25 13:24:00'::timestamptz); END IF;

  -- CC1840
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1840', 'Cliente Lavandería', false, 'completed', false, 19.09, 0.00, 0, 0.92, 20.01, 0.00, 0, 13, 'Lavandería', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 18:05:00'::timestamptz, '2025-03-25 13:49:00'::timestamptz, '2025-03-25 13:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.01, '2025-03-25 13:49:00'::timestamptz); END IF;

  -- CC1841
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1841', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 10, '', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 00:00:00'::timestamptz, '2025-03-25 14:30:00'::timestamptz, '2025-03-25 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-03-25 14:30:00'::timestamptz); END IF;

  -- CC1842
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1842', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-03-25 00:00:00'::timestamptz, '2025-03-25 18:05:00'::timestamptz, '2025-03-25 16:38:00'::timestamptz, '2025-03-25 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-03-25 16:38:00'::timestamptz); END IF;

  -- CC1843
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 118;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1843', 'Sysco Panama', false, 'completed', false, 8.00, 0.00, 0, 0.42, 8.42, 2.25, 1, 3, 'Lavandería', '2025-03-26 00:00:00'::timestamptz, '2025-03-26 16:56:00'::timestamptz, '2025-03-26 10:37:00'::timestamptz, '2025-03-26 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.42, '2025-03-26 10:37:00'::timestamptz); END IF;

  -- CC1844
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1844', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-03-26 00:00:00'::timestamptz, '2025-03-26 00:00:00'::timestamptz, '2025-03-26 17:07:00'::timestamptz, '2025-03-26 17:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-03-26 17:07:00'::timestamptz); END IF;

  -- CC1845
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 141;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1845', 'Juan Camilo Gomez', false, 'completed', false, 11.38, 0.00, 0, 0.59, 11.97, 3.35, 2, 4, 'Lavandería', '2025-03-27 00:00:00'::timestamptz, '2025-03-27 12:34:00'::timestamptz, '2025-03-27 10:47:00'::timestamptz, '2025-03-27 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.97, '2025-03-27 10:47:00'::timestamptz); END IF;

  -- CC1846
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1846', 'Liliana Zambrano', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '0', '2025-03-27 00:00:00'::timestamptz, '2025-03-27 13:08:00'::timestamptz, '2025-03-27 10:49:00'::timestamptz, '2025-03-27 10:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-03-27 10:49:00'::timestamptz); END IF;

  -- CC1847
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1847', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-03-27 00:00:00'::timestamptz, '2025-03-27 00:00:00'::timestamptz, '2025-03-27 10:49:00'::timestamptz, '2025-03-27 10:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-03-27 10:49:00'::timestamptz); END IF;

  -- CC1848
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1848', 'Guzmán', false, 'completed', false, 7.38, 0.00, 0, 0.52, 7.90, 2.95, 1, 1, '', '2025-03-27 00:00:00'::timestamptz, '2025-03-27 13:08:00'::timestamptz, '2025-03-27 11:55:00'::timestamptz, '2025-03-27 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.90 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.90, '2025-03-27 11:55:00'::timestamptz); END IF;

  -- CC1849
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1849', 'Guzmán', false, 'completed', false, 33.13, 0.00, 0, 2.32, 35.45, 13.25, 5, 1, '', '2025-03-27 00:00:00'::timestamptz, '2025-03-27 13:08:00'::timestamptz, '2025-03-27 11:59:00'::timestamptz, '2025-03-27 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.45, '2025-03-27 11:59:00'::timestamptz); END IF;

  -- CC1850
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1850', 'Oscar Oropeza', false, 'completed', false, 19.09, 0.00, 0, 0.92, 20.01, 0.00, 0, 14, 'Lavandería', '2025-03-27 00:00:00'::timestamptz, '2025-03-28 07:59:00'::timestamptz, '2025-03-27 15:52:00'::timestamptz, '2025-03-27 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.01, '2025-03-27 15:52:00'::timestamptz); END IF;

  -- CC1851
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1851', 'Guzmán', false, 'completed', false, 7.44, 0.00, 0, 0.52, 7.96, 4.25, 1, 1, '', '2025-03-28 00:00:00'::timestamptz, '2025-03-28 15:11:00'::timestamptz, '2025-03-28 08:19:00'::timestamptz, '2025-03-28 08:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.96, '2025-03-28 08:19:00'::timestamptz); END IF;

  -- CC1852
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1852', 'Evy Ortega', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, '0', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 12:25:00'::timestamptz, '2025-03-29 11:08:00'::timestamptz, '2025-03-29 11:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.98, '2025-03-29 11:08:00'::timestamptz); END IF;

  -- CC1853
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1853', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.15, 1, 1, '', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 14:19:00'::timestamptz, '2025-03-29 11:21:00'::timestamptz, '2025-03-29 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2025-03-29 11:21:00'::timestamptz); END IF;

  -- CC1854
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1854', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 12:25:00'::timestamptz, '2025-03-29 11:22:00'::timestamptz, '2025-03-29 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-03-29 11:22:00'::timestamptz); END IF;

  -- CC1855
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 142;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1855', 'Luis Barlo', false, 'completed', false, 21.88, 0.00, 0, 1.04, 22.92, 5.95, 1, 11, 'Lavandería', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 14:19:00'::timestamptz, '2025-03-29 11:41:00'::timestamptz, '2025-03-29 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.92 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.92, '2025-03-29 11:41:00'::timestamptz); END IF;

  -- CC1856
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1856', 'Leonel Visueti', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, '', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 16:37:00'::timestamptz, '2025-03-29 12:55:00'::timestamptz, '2025-03-29 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-03-29 12:55:00'::timestamptz); END IF;

  -- CC1857
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1857', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2025-03-29 00:00:00'::timestamptz, '2025-03-29 16:37:00'::timestamptz, '2025-03-29 13:46:00'::timestamptz, '2025-03-29 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-03-29 13:46:00'::timestamptz); END IF;

  -- CC1858
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1858', 'Leonel Visueti', false, 'completed', false, 9.86, 0.00, 0, 0.39, 10.25, 0.00, 0, 8, '', '2025-03-30 00:00:00'::timestamptz, '2025-03-30 13:58:00'::timestamptz, '2025-03-30 13:56:00'::timestamptz, '2025-03-30 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.25, '2025-03-30 13:56:00'::timestamptz); END IF;

  -- CC1859
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1859', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 4, '', '2025-03-30 00:00:00'::timestamptz, '2025-03-30 16:04:00'::timestamptz, '2025-03-30 13:58:00'::timestamptz, '2025-03-30 13:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-03-30 13:58:00'::timestamptz); END IF;

  -- CC1860
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1860', 'Leonel Visueti', false, 'completed', false, 0.50, 0.00, 0, 0.04, 0.54, 0.00, 0, 1, '', '2025-03-30 00:00:00'::timestamptz, '2025-03-30 16:04:00'::timestamptz, '2025-03-30 14:00:00'::timestamptz, '2025-03-30 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.54, '2025-03-30 14:00:00'::timestamptz); END IF;

  -- CC1861
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 118;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1861', 'Sysco Panama', false, 'completed', false, 19.25, 0.00, 0, 1.07, 20.32, 6.10, 3, 5, 'Lavandería', '2025-03-31 00:00:00'::timestamptz, '2025-03-31 15:08:00'::timestamptz, '2025-03-31 11:48:00'::timestamptz, '2025-03-31 11:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.32 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.32, '2025-03-31 11:48:00'::timestamptz); END IF;

  -- CC1862
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 143;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1862', 'Alexandra Arroyo', false, 'completed', false, 45.63, 0.00, 0, 3.19, 48.82, 15.45, 3, 2, 'Lavandería', '2025-03-31 00:00:00'::timestamptz, '2025-03-31 15:08:00'::timestamptz, '2025-03-31 14:39:00'::timestamptz, '2025-03-31 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 48.82 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 48.82, '2025-03-31 14:39:00'::timestamptz); END IF;

  -- CC1863
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1863', 'Lina Perez', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, 'Lavandería', '2025-04-01 00:00:00'::timestamptz, '2025-03-31 17:40:00'::timestamptz, '2025-03-31 17:18:00'::timestamptz, '2025-03-31 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-03-31 17:18:00'::timestamptz); END IF;

  -- CC1864
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1864', 'Lina Perez', false, 'completed', false, 5.87, 0.00, 0, 0.13, 6.00, 0.00, 0, 5, 'Lavandería', '2025-03-31 00:00:00'::timestamptz, '2025-03-31 17:40:00'::timestamptz, '2025-03-31 17:19:00'::timestamptz, '2025-03-31 17:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-03-31 17:19:00'::timestamptz); END IF;

  -- CC1865
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1865', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-04-01 00:00:00'::timestamptz, '2025-04-01 16:36:00'::timestamptz, '2025-04-01 16:33:00'::timestamptz, '2025-04-01 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-04-01 16:33:00'::timestamptz); END IF;

  -- CC1866
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1866', 'Cliente Lavandería', false, 'completed', false, 27.18, 0.00, 0, 1.83, 29.01, 0.00, 0, 15, 'Lavandería', '2025-04-02 00:00:00'::timestamptz, '2025-04-02 18:26:00'::timestamptz, '2025-04-02 17:27:00'::timestamptz, '2025-04-02 17:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.01, '2025-04-02 17:27:00'::timestamptz); END IF;

  -- CC1867
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1867', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-04-02 00:00:00'::timestamptz, '2025-04-02 18:26:00'::timestamptz, '2025-04-02 18:11:00'::timestamptz, '2025-04-02 18:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-04-02 18:11:00'::timestamptz); END IF;

  -- CC1868
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1868', 'German Alveo', false, 'completed', false, 9.75, 0.00, 0, 0.68, 10.43, 3.90, 1, 1, 'Lavandería', '2025-04-03 00:00:00'::timestamptz, '2025-04-03 14:05:00'::timestamptz, '2025-04-03 12:03:00'::timestamptz, '2025-04-03 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.43, '2025-04-03 12:03:00'::timestamptz); END IF;

  -- CC1869
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1869', 'German Alveo', false, 'completed', false, 33.00, 0.00, 0, 2.31, 35.31, 13.20, 6, 1, 'Lavandería', '2025-04-03 00:00:00'::timestamptz, '2025-04-03 14:05:00'::timestamptz, '2025-04-03 12:05:00'::timestamptz, '2025-04-03 12:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.31 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.31, '2025-04-03 12:05:00'::timestamptz); END IF;

  -- CC1870
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1870', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2025-04-03 00:00:00'::timestamptz, '2025-04-03 15:47:00'::timestamptz, '2025-04-03 14:42:00'::timestamptz, '2025-04-03 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-03 14:42:00'::timestamptz); END IF;

  -- CC1871
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1871', 'Fernando Ortega', false, 'completed', false, 4.37, 0.00, 0, 0.13, 4.50, 0.00, 0, 4, '', '2025-04-05 00:00:00'::timestamptz, '2025-04-05 13:35:00'::timestamptz, '2025-04-05 12:03:00'::timestamptz, '2025-04-05 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-04-05 12:03:00'::timestamptz); END IF;

  -- CC1872
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1872', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-04-05 00:00:00'::timestamptz, '2025-04-05 15:12:00'::timestamptz, '2025-04-05 13:36:00'::timestamptz, '2025-04-05 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-05 13:36:00'::timestamptz); END IF;

  -- CC1873
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1873', 'Cliente Lavandería', false, 'completed', false, 1.50, 0.00, 0, 0.11, 1.61, 0.00, 0, 3, 'Lavandería', '2025-04-05 00:00:00'::timestamptz, '2025-04-05 14:16:00'::timestamptz, '2025-04-05 14:15:00'::timestamptz, '2025-04-05 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.61, '2025-04-05 14:15:00'::timestamptz); END IF;

  -- CC1874
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1874', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-04-05 00:00:00'::timestamptz, '2025-04-05 00:00:00'::timestamptz, '2025-04-05 15:11:00'::timestamptz, '2025-04-05 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-04-05 15:11:00'::timestamptz); END IF;

  -- CC1875
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1875', 'Virginia Gonzalez', false, 'completed', false, 8.11, 0.00, 0, 0.39, 8.50, 0.00, 0, 7, 'Lavandería', '2025-04-06 00:00:00'::timestamptz, '2025-04-06 16:24:00'::timestamptz, '2025-04-06 16:07:00'::timestamptz, '2025-04-06 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2025-04-06 16:07:00'::timestamptz); END IF;

  -- CC1876
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1876', 'Leonel Visueti', false, 'completed', false, 9.50, 0.00, 0, 0.56, 10.06, 0.00, 0, 3, '', '2025-04-06 00:00:00'::timestamptz, '2025-04-07 17:05:00'::timestamptz, '2025-04-06 16:10:00'::timestamptz, '2025-04-06 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.06, '2025-04-06 16:10:00'::timestamptz); END IF;

  -- CC1877
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1877', 'Cliente Lavandería', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, 'Lavandería', '2025-04-07 00:00:00'::timestamptz, '2025-04-07 17:05:00'::timestamptz, '2025-04-07 14:07:00'::timestamptz, '2025-04-07 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-04-07 14:07:00'::timestamptz); END IF;

  -- CC1878
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1878', 'Lina Perez', false, 'completed', false, 21.34, 0.00, 0, 0.92, 22.26, 0.00, 0, 16, 'Lavandería', '2025-04-07 00:00:00'::timestamptz, '2025-04-07 17:18:00'::timestamptz, '2025-04-07 17:17:00'::timestamptz, '2025-04-07 17:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.26, '2025-04-07 17:17:00'::timestamptz); END IF;

  -- CC1879
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1879', 'Evelyn', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Salón', '2025-04-08 00:00:00'::timestamptz, '2025-04-08 16:52:00'::timestamptz, '2025-04-08 16:52:00'::timestamptz, '2025-04-08 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-04-08 16:52:00'::timestamptz); END IF;

  -- CC1880
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1880', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-04-09 00:00:00'::timestamptz, '2025-04-09 16:30:00'::timestamptz, '2025-04-09 14:42:00'::timestamptz, '2025-04-09 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-09 14:42:00'::timestamptz); END IF;

  -- CC1881
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1881', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 5.60, 2, 1, 'Salón', '2025-04-09 00:00:00'::timestamptz, '2025-04-09 17:06:00'::timestamptz, '2025-04-09 15:55:00'::timestamptz, '2025-04-09 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2025-04-09 15:55:00'::timestamptz); END IF;

  -- CC1882
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1882', 'Leonardo Salon', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'leonardo', '2025-04-09 00:00:00'::timestamptz, '2025-04-09 17:06:00'::timestamptz, '2025-04-09 15:58:00'::timestamptz, '2025-04-09 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-04-09 15:58:00'::timestamptz); END IF;

  -- CC1883
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1883', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-04-09 00:00:00'::timestamptz, '2025-04-09 17:06:00'::timestamptz, '2025-04-09 16:57:00'::timestamptz, '2025-04-09 16:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-09 16:57:00'::timestamptz); END IF;

  -- CC1884
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1884', 'German Alveo', false, 'completed', false, 35.50, 0.00, 0, 2.49, 37.99, 14.20, 6, 1, 'Lavandería', '2025-04-10 00:00:00'::timestamptz, '2025-04-10 16:28:00'::timestamptz, '2025-04-10 14:43:00'::timestamptz, '2025-04-10 14:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 37.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 37.99, '2025-04-10 14:43:00'::timestamptz); END IF;

  -- CC1885
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1885', 'German Alveo', false, 'completed', false, 7.50, 0.00, 0, 0.53, 8.03, 3.00, 1, 1, 'Lavandería', '2025-04-10 00:00:00'::timestamptz, '2025-04-10 16:29:00'::timestamptz, '2025-04-10 14:48:00'::timestamptz, '2025-04-10 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.03, '2025-04-10 14:48:00'::timestamptz); END IF;

  -- CC1886
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1886', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2025-04-10 00:00:00'::timestamptz, '2025-04-10 16:13:00'::timestamptz, '2025-04-10 15:15:00'::timestamptz, '2025-04-10 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-10 15:15:00'::timestamptz); END IF;

  -- CC1887
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1887', 'Leonel Visueti', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, '', '2025-04-10 00:00:00'::timestamptz, '2025-04-10 16:12:00'::timestamptz, '2025-04-10 15:39:00'::timestamptz, '2025-04-10 15:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-04-10 15:39:00'::timestamptz); END IF;

  -- CC1888
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1888', 'German Alveo', false, 'completed', false, 14.00, 0.00, 0, 0.98, 14.98, 0.00, 0, 2, 'Lavandería', '2025-04-11 00:00:00'::timestamptz, '2025-04-12 09:31:00'::timestamptz, '2025-04-11 11:30:00'::timestamptz, '2025-04-11 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.98, '2025-04-11 11:30:00'::timestamptz); END IF;

  -- CC1889
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1889', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.07, 2.07, 0.00, 0, 4, '', '2025-04-11 00:00:00'::timestamptz, '2025-04-11 16:48:00'::timestamptz, '2025-04-11 16:47:00'::timestamptz, '2025-04-11 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.07, '2025-04-11 16:47:00'::timestamptz); END IF;

  -- CC1890
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1890', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-04-12 00:00:00'::timestamptz, '2025-04-12 15:08:00'::timestamptz, '2025-04-12 13:28:00'::timestamptz, '2025-04-12 13:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-04-12 13:28:00'::timestamptz); END IF;

  -- CC1891
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1891', 'Leonel Visueti', false, 'completed', false, 21.75, 0.00, 0, 1.52, 23.27, 8.70, 2, 1, '', '2025-04-12 00:00:00'::timestamptz, '2025-04-13 15:01:00'::timestamptz, '2025-04-12 13:40:00'::timestamptz, '2025-04-12 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 23.27 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 23.27, '2025-04-12 13:40:00'::timestamptz); END IF;

  -- CC1892
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1892', 'Cliente Lavandería', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2025-04-13 00:00:00'::timestamptz, '2025-04-13 11:41:00'::timestamptz, '2025-04-13 11:05:00'::timestamptz, '2025-04-13 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2025-04-13 11:05:00'::timestamptz); END IF;

  -- CC1893
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1893', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, '', '2025-04-13 00:00:00'::timestamptz, '2025-04-13 16:47:00'::timestamptz, '2025-04-13 15:03:00'::timestamptz, '2025-04-13 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-04-13 15:03:00'::timestamptz); END IF;

  -- CC1894
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1894', 'Cliente Lavandería', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavandería', '2025-04-13 00:00:00'::timestamptz, '2025-04-13 16:47:00'::timestamptz, '2025-04-13 15:12:00'::timestamptz, '2025-04-13 15:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-04-13 15:12:00'::timestamptz); END IF;

  -- CC1895
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 145;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1895', 'Emma Ducreux', false, 'completed', false, 3.50, 0.00, 0, 0.25, 3.75, 0.00, 0, 1, '', '2025-04-13 00:00:00'::timestamptz, '2025-04-13 16:47:00'::timestamptz, '2025-04-13 15:45:00'::timestamptz, '2025-04-13 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.75, '2025-04-13 15:45:00'::timestamptz); END IF;

  -- CC1896
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1896', 'Virginia Gonzalez', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavandería', '2025-04-13 00:00:00'::timestamptz, '2025-04-13 16:46:00'::timestamptz, '2025-04-13 16:05:00'::timestamptz, '2025-04-13 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-04-13 16:05:00'::timestamptz); END IF;

  -- CC1897
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1897', 'Oscar Oropeza', false, 'completed', false, 14.96, 0.00, 0, 1.05, 16.01, 0.00, 0, 8, 'Lavandería', '2025-04-14 00:00:00'::timestamptz, '2025-04-14 14:20:00'::timestamptz, '2025-04-14 12:57:00'::timestamptz, '2025-04-14 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.01, '2025-04-14 12:57:00'::timestamptz); END IF;

  -- CC1898
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1898', 'Cliente Lavandería', false, 'completed', false, 13.48, 0.00, 0, 0.52, 14.00, 0.00, 0, 10, 'Lavandería', '2025-04-14 00:00:00'::timestamptz, '2025-04-14 15:08:00'::timestamptz, '2025-04-14 13:03:00'::timestamptz, '2025-04-14 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-04-14 13:03:00'::timestamptz); END IF;

  -- CC1899
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1899', 'Aaron Gutierrez', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, 'Lavandería', '2025-04-14 00:00:00'::timestamptz, '2025-04-14 16:05:00'::timestamptz, '2025-04-14 15:07:00'::timestamptz, '2025-04-14 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-14 15:07:00'::timestamptz); END IF;

  -- CC1901
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1901', 'German Alveo', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, 'Lavandería', '2025-04-16 00:00:00'::timestamptz, '2025-04-16 17:34:00'::timestamptz, '2025-04-16 17:03:00'::timestamptz, '2025-04-16 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2025-04-16 17:03:00'::timestamptz); END IF;

  -- CC1902
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1902', 'Leonel Visueti', false, 'completed', false, 0.50, 0.00, 0, 0.04, 0.54, 0.00, 0, 1, '', '2025-04-16 00:00:00'::timestamptz, '2025-04-16 17:32:00'::timestamptz, '2025-04-16 17:16:00'::timestamptz, '2025-04-16 17:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.54, '2025-04-16 17:16:00'::timestamptz); END IF;

  -- CC1903
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1903', 'Cliente Lavandería', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-04-16 00:00:00'::timestamptz, '2025-04-16 17:33:00'::timestamptz, '2025-04-16 17:22:00'::timestamptz, '2025-04-16 17:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-16 17:22:00'::timestamptz); END IF;

  -- CC1904
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1904', 'Leonel Visueti', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 8, '', '2025-04-16 00:00:00'::timestamptz, '2025-04-16 17:33:00'::timestamptz, '2025-04-16 17:24:00'::timestamptz, '2025-04-16 17:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-04-16 17:24:00'::timestamptz); END IF;

  -- CC1905
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1905', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-04-16 00:00:00'::timestamptz, '2025-04-16 17:33:00'::timestamptz, '2025-04-16 17:25:00'::timestamptz, '2025-04-16 17:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-04-16 17:25:00'::timestamptz); END IF;

  -- CC1906
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1906', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-04-17 00:00:00'::timestamptz, '2025-04-17 13:10:00'::timestamptz, '2025-04-17 10:48:00'::timestamptz, '2025-04-17 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-04-17 10:48:00'::timestamptz); END IF;

  -- CC1907
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1907', 'German Alveo', false, 'completed', false, 7.50, 0.00, 0, 0.53, 8.03, 3.00, 1, 1, 'Lavandería', '2025-04-17 00:00:00'::timestamptz, '2025-04-17 14:08:00'::timestamptz, '2025-04-17 13:08:00'::timestamptz, '2025-04-17 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.03, '2025-04-17 13:08:00'::timestamptz); END IF;

  -- CC1908
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1908', 'German Alveo', false, 'completed', false, 20.88, 0.00, 0, 1.46, 22.34, 8.35, 4, 1, 'Lavandería', '2025-04-17 00:00:00'::timestamptz, '2025-04-17 14:08:00'::timestamptz, '2025-04-17 13:09:00'::timestamptz, '2025-04-17 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.34, '2025-04-17 13:09:00'::timestamptz); END IF;

  -- CC1909
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1909', 'Leonel Visueti', false, 'completed', false, 7.74, 0.00, 0, 0.26, 8.00, 0.00, 0, 7, '', '2025-04-19 00:00:00'::timestamptz, '2025-04-19 16:33:00'::timestamptz, '2025-04-19 12:32:00'::timestamptz, '2025-04-19 12:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-04-19 12:32:00'::timestamptz); END IF;

  -- CC1910
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1910', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-04-20 00:00:00'::timestamptz, '2025-04-20 15:55:00'::timestamptz, '2025-04-20 15:29:00'::timestamptz, '2025-04-20 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-04-20 15:29:00'::timestamptz); END IF;

  -- CC1911
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1911', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2025-04-22 00:00:00'::timestamptz, '2025-04-22 16:51:00'::timestamptz, '2025-04-22 16:00:00'::timestamptz, '2025-04-22 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-04-22 16:00:00'::timestamptz); END IF;

  -- CC1912
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1912', 'Oscar Oropeza', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, 'Lavandería', '2025-04-23 00:00:00'::timestamptz, '2025-04-23 15:59:00'::timestamptz, '2025-04-23 15:58:00'::timestamptz, '2025-04-23 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-04-23 15:58:00'::timestamptz); END IF;

  -- CC1913
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1913', 'Blanca', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-04-23 00:00:00'::timestamptz, '2025-04-23 16:40:00'::timestamptz, '2025-04-23 15:59:00'::timestamptz, '2025-04-23 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-04-23 15:59:00'::timestamptz); END IF;

  -- CC1914
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1914', 'German Alveo', false, 'completed', false, 31.25, 0.00, 0, 2.19, 33.44, 12.50, 5, 1, 'Lavandería', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 15:13:00'::timestamptz, '2025-04-24 08:28:00'::timestamptz, '2025-04-24 08:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 33.44 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 33.44, '2025-04-24 08:28:00'::timestamptz); END IF;

  -- CC1915
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1915', 'German Alveo', false, 'completed', false, 7.75, 0.00, 0, 0.54, 8.29, 3.10, 1, 1, 'Lavandería', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 15:13:00'::timestamptz, '2025-04-24 08:34:00'::timestamptz, '2025-04-24 08:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.29 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.29, '2025-04-24 08:34:00'::timestamptz); END IF;

  -- CC1916
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1916', 'Leonel Visueti', false, 'completed', false, 12.48, 0.00, 0, 0.52, 13.00, 0.00, 0, 9, '', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 11:49:00'::timestamptz, '2025-04-24 09:21:00'::timestamptz, '2025-04-24 09:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-04-24 09:21:00'::timestamptz); END IF;

  -- CC1917
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1917', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 00:00:00'::timestamptz, '2025-04-24 09:21:00'::timestamptz, '2025-04-24 09:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-04-24 09:21:00'::timestamptz); END IF;

  -- CC1918
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1918', 'Cliente Lavandería', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, 'Lavandería', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 11:49:00'::timestamptz, '2025-04-24 10:47:00'::timestamptz, '2025-04-24 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-24 10:47:00'::timestamptz); END IF;

  -- CC1919
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1919', 'Cliente Lavandería', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, 'Lavandería', '2025-04-24 00:00:00'::timestamptz, '2025-04-24 16:40:00'::timestamptz, '2025-04-24 15:51:00'::timestamptz, '2025-04-24 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-24 15:51:00'::timestamptz); END IF;

  -- CC1920
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1920', 'Leonel Visueti', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, '', '2025-04-24 00:00:00'::timestamptz, '2025-04-25 08:10:00'::timestamptz, '2025-04-24 15:52:00'::timestamptz, '2025-04-24 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-04-24 15:52:00'::timestamptz); END IF;

  -- CC1921
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1921', 'Cliente Lavandería', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Lavandería', '2025-04-24 00:00:00'::timestamptz, '2025-04-25 08:10:00'::timestamptz, '2025-04-24 16:41:00'::timestamptz, '2025-04-24 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-04-24 16:41:00'::timestamptz); END IF;

  -- CC1922
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1922', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-04-25 00:00:00'::timestamptz, '2025-04-25 13:27:00'::timestamptz, '2025-04-25 12:15:00'::timestamptz, '2025-04-25 12:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-04-25 12:15:00'::timestamptz); END IF;

  -- CC1923
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1923', 'Cliente Lavandería', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, 'Lavandería', '2025-04-25 00:00:00'::timestamptz, '2025-04-25 15:39:00'::timestamptz, '2025-04-25 14:59:00'::timestamptz, '2025-04-25 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-04-25 14:59:00'::timestamptz); END IF;

  -- CC1924
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1924', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-04-25 00:00:00'::timestamptz, '2025-04-25 16:32:00'::timestamptz, '2025-04-25 15:01:00'::timestamptz, '2025-04-25 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-04-25 15:01:00'::timestamptz); END IF;

  -- CC1925
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 147;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1925', 'Ines Rojas', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2025-04-25 00:00:00'::timestamptz, '2025-04-25 16:32:00'::timestamptz, '2025-04-25 15:37:00'::timestamptz, '2025-04-25 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-04-25 15:37:00'::timestamptz); END IF;

  -- CC1926
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1926', 'Cliente Lavandería', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-04-25 00:00:00'::timestamptz, '2025-04-25 16:32:00'::timestamptz, '2025-04-25 16:14:00'::timestamptz, '2025-04-25 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-25 16:14:00'::timestamptz); END IF;

  -- CC1927
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1927', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-04-26 00:00:00'::timestamptz, '2025-04-27 08:19:00'::timestamptz, '2025-04-26 14:50:00'::timestamptz, '2025-04-26 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-04-26 14:50:00'::timestamptz); END IF;

  -- CC1928
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1928', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-04-26 00:00:00'::timestamptz, '2025-04-27 08:19:00'::timestamptz, '2025-04-26 15:01:00'::timestamptz, '2025-04-26 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-04-26 15:01:00'::timestamptz); END IF;

  -- CC1929
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1929', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-04-26 00:00:00'::timestamptz, '2025-04-26 15:55:00'::timestamptz, '2025-04-26 15:04:00'::timestamptz, '2025-04-26 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-04-26 15:04:00'::timestamptz); END IF;

  -- CC1930
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1930', 'Cliente Lavandería', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2025-04-26 00:00:00'::timestamptz, '2025-04-27 08:19:00'::timestamptz, '2025-04-26 15:58:00'::timestamptz, '2025-04-26 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2025-04-26 15:58:00'::timestamptz); END IF;

  -- CC1931
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1931', 'Lina Perez', false, 'completed', false, 23.96, 0.00, 0, 1.05, 25.01, 0.00, 0, 17, 'Lavandería', '2025-04-28 00:00:00'::timestamptz, '2025-04-28 12:21:00'::timestamptz, '2025-04-28 11:36:00'::timestamptz, '2025-04-28 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 25.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 25.01, '2025-04-28 11:36:00'::timestamptz); END IF;

  -- CC1932
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1932', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-04-28 00:00:00'::timestamptz, '2025-04-28 12:21:00'::timestamptz, '2025-04-28 11:38:00'::timestamptz, '2025-04-28 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-04-28 11:38:00'::timestamptz); END IF;

  -- CC1933
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1933', 'Virginia Gonzalez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-04-28 00:00:00'::timestamptz, '2025-04-28 15:29:00'::timestamptz, '2025-04-28 14:13:00'::timestamptz, '2025-04-28 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-04-28 14:13:00'::timestamptz); END IF;

  -- CC1934
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1934', 'Oscar Oropeza', false, 'completed', false, 16.83, 0.00, 0, 1.18, 18.01, 0.00, 0, 9, 'Lavandería', '2025-04-28 00:00:00'::timestamptz, '2025-04-28 17:18:00'::timestamptz, '2025-04-28 17:11:00'::timestamptz, '2025-04-28 17:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.01, '2025-04-28 17:11:00'::timestamptz); END IF;

  -- CC1935
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1935', 'German Alveo', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 1.20, 1, 2, 'Lavandería', '2025-04-29 00:00:00'::timestamptz, '2025-04-29 14:55:00'::timestamptz, '2025-04-29 13:36:00'::timestamptz, '2025-04-29 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2025-04-29 13:36:00'::timestamptz); END IF;

  -- CC1936
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1936', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-04-29 00:00:00'::timestamptz, '2025-04-29 16:24:00'::timestamptz, '2025-04-29 15:05:00'::timestamptz, '2025-04-29 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-04-29 15:05:00'::timestamptz); END IF;

  -- CC1937
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 148;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1937', 'Yul Pinto', false, 'completed', false, 10.25, 0.00, 0, 0.72, 10.97, 4.10, 1, 1, 'lavanderia', '2025-04-30 00:00:00'::timestamptz, '2025-04-30 10:40:00'::timestamptz, '2025-04-30 10:39:00'::timestamptz, '2025-04-30 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.97, '2025-04-30 10:39:00'::timestamptz); END IF;

  -- CC1938
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1938', 'German Alveo', false, 'completed', false, 7.50, 0.00, 0, 0.53, 8.03, 3.00, 1, 1, 'Lavandería', '2025-04-30 00:00:00'::timestamptz, '2025-04-30 14:44:00'::timestamptz, '2025-04-30 11:36:00'::timestamptz, '2025-04-30 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.03 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.03, '2025-04-30 11:36:00'::timestamptz); END IF;

  -- CC1939
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1939', 'German Alveo', false, 'completed', false, 37.00, 0.00, 0, 2.59, 39.59, 14.80, 7, 1, 'Lavandería', '2025-04-30 00:00:00'::timestamptz, '2025-04-30 14:50:00'::timestamptz, '2025-04-30 13:47:00'::timestamptz, '2025-04-30 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 39.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 39.59, '2025-04-30 13:47:00'::timestamptz); END IF;

  -- CC1940
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1940', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2025-04-30 00:00:00'::timestamptz, '2025-04-30 14:51:00'::timestamptz, '2025-04-30 14:32:00'::timestamptz, '2025-04-30 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-04-30 14:32:00'::timestamptz); END IF;

  -- CC1941
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1941', 'Leonel Visueti', false, 'completed', false, 17.09, 0.00, 0, 0.92, 18.01, 0.00, 0, 11, '', '2025-04-30 00:00:00'::timestamptz, '2025-04-30 16:21:00'::timestamptz, '2025-04-30 15:05:00'::timestamptz, '2025-04-30 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.01, '2025-04-30 15:05:00'::timestamptz); END IF;

  -- CC1942
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1942', 'Liliana Zambrano', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-05-02 00:00:00'::timestamptz, '2025-05-02 10:58:00'::timestamptz, '2025-05-02 10:02:00'::timestamptz, '2025-05-02 10:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-02 10:02:00'::timestamptz); END IF;

  -- CC1943
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1943', 'German Alveo', false, 'completed', false, 9.45, 0.00, 0, 0.66, 10.11, 5.40, 1, 1, 'Lavandería', '2025-05-02 00:00:00'::timestamptz, '2025-05-02 16:33:00'::timestamptz, '2025-05-02 15:37:00'::timestamptz, '2025-05-02 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.11 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.11, '2025-05-02 15:37:00'::timestamptz); END IF;

  -- CC1944
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 145;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1944', 'Emma Ducreux', false, 'completed', false, 23.00, 0.00, 0, 1.61, 24.61, 9.20, 2, 1, '', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 15:29:00'::timestamptz, '2025-05-03 09:56:00'::timestamptz, '2025-05-03 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.61, '2025-05-03 09:56:00'::timestamptz); END IF;

  -- CC1945
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1945', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 16:13:00'::timestamptz, '2025-05-03 15:30:00'::timestamptz, '2025-05-03 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-03 15:30:00'::timestamptz); END IF;

  -- CC1946
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1946', 'Fernando Ortega', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 16:59:00'::timestamptz, '2025-05-03 16:10:00'::timestamptz, '2025-05-03 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-05-03 16:10:00'::timestamptz); END IF;

  -- CC1947
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1947', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 5, '', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 17:16:00'::timestamptz, '2025-05-03 16:33:00'::timestamptz, '2025-05-03 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-05-03 16:33:00'::timestamptz); END IF;

  -- CC1948
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1948', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 17:23:00'::timestamptz, '2025-05-03 16:58:00'::timestamptz, '2025-05-03 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-05-03 16:58:00'::timestamptz); END IF;

  -- CC1949
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1949', 'Virginia Gonzalez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-05-03 00:00:00'::timestamptz, '2025-05-03 17:23:00'::timestamptz, '2025-05-03 17:12:00'::timestamptz, '2025-05-03 17:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-03 17:12:00'::timestamptz); END IF;

  -- CC1950
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 142;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1950', 'Luis Barlo', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavandería', '2025-05-04 00:00:00'::timestamptz, '2025-05-04 15:35:00'::timestamptz, '2025-05-04 13:42:00'::timestamptz, '2025-05-04 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-05-04 13:42:00'::timestamptz); END IF;

  -- CC1951
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1951', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-04 00:00:00'::timestamptz, '2025-05-04 15:12:00'::timestamptz, '2025-05-04 14:07:00'::timestamptz, '2025-05-04 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-04 14:07:00'::timestamptz); END IF;

  -- CC1952
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1952', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-05-04 00:00:00'::timestamptz, '2025-05-04 15:40:00'::timestamptz, '2025-05-04 15:19:00'::timestamptz, '2025-05-04 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-04 15:19:00'::timestamptz); END IF;

  -- CC1955
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1955', 'Josue Pernett', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavanderia', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 15:52:00'::timestamptz, '2025-05-05 13:53:00'::timestamptz, '2025-05-05 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-05-05 13:53:00'::timestamptz); END IF;

  -- CC1956
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 100;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1956', 'Compañía Panameña De Aviación S.A', false, 'completed', false, 19.50, 0.00, 0, 1.37, 20.87, 0.00, 0, 3, 'RUC 130-377-34706', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 15:10:00'::timestamptz, '2025-05-05 14:28:00'::timestamptz, '2025-05-05 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.87 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.87, '2025-05-05 14:28:00'::timestamptz); END IF;

  -- CC1957
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1957', 'Josue Pernett', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavanderia', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 00:00:00'::timestamptz, '2025-05-05 14:42:00'::timestamptz, '2025-05-05 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-05-05 14:42:00'::timestamptz); END IF;

  -- CC1958
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1958', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 16:56:00'::timestamptz, '2025-05-05 15:53:00'::timestamptz, '2025-05-05 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-05 15:53:00'::timestamptz); END IF;

  -- CC1959
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1959', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 17:33:00'::timestamptz, '2025-05-05 16:14:00'::timestamptz, '2025-05-05 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-05-05 16:14:00'::timestamptz); END IF;

  -- CC1960
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1960', 'Leonel Visueti', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 00:00:00'::timestamptz, '2025-05-05 16:16:00'::timestamptz, '2025-05-05 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-05 16:16:00'::timestamptz); END IF;

  -- CC1961
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1961', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-05-05 00:00:00'::timestamptz, '2025-05-05 17:33:00'::timestamptz, '2025-05-05 16:55:00'::timestamptz, '2025-05-05 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-05-05 16:55:00'::timestamptz); END IF;

  -- CC1962
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1962', 'Aaron Gutierrez', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, 'Lavandería', '2025-05-06 00:00:00'::timestamptz, '2025-05-06 14:24:00'::timestamptz, '2025-05-06 12:55:00'::timestamptz, '2025-05-06 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-05-06 12:55:00'::timestamptz); END IF;

  -- CC1963
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1963', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-05-07 00:00:00'::timestamptz, '2025-05-08 08:02:00'::timestamptz, '2025-05-07 16:51:00'::timestamptz, '2025-05-07 16:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-05-07 16:51:00'::timestamptz); END IF;

  -- CC1964
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1964', 'German Alveo', false, 'completed', false, 34.11, 0.00, 0, 2.39, 36.50, 14.60, 6, 1, 'Lavandería', '2025-05-08 00:00:00'::timestamptz, '2025-05-08 14:32:00'::timestamptz, '2025-05-08 11:38:00'::timestamptz, '2025-05-08 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.50, '2025-05-08 11:38:00'::timestamptz); END IF;

  -- CC1965
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1965', 'German Alveo', false, 'completed', false, 8.07, 0.00, 0, 0.56, 8.63, 3.45, 1, 1, 'Lavandería', '2025-05-08 00:00:00'::timestamptz, '2025-05-08 14:32:00'::timestamptz, '2025-05-08 13:16:00'::timestamptz, '2025-05-08 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.63, '2025-05-08 13:16:00'::timestamptz); END IF;

  -- CC1966
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1966', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-05-08 00:00:00'::timestamptz, '2025-05-08 14:33:00'::timestamptz, '2025-05-08 13:17:00'::timestamptz, '2025-05-08 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-08 13:17:00'::timestamptz); END IF;

  -- CC1967
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1967', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-05-08 00:00:00'::timestamptz, '2025-05-08 16:37:00'::timestamptz, '2025-05-08 15:17:00'::timestamptz, '2025-05-08 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-05-08 15:17:00'::timestamptz); END IF;

  -- CC1968
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1968', 'Liliana', false, 'completed', false, 2.34, 0.00, 0, 0.16, 2.50, 0.00, 0, 2, '0', '2025-05-09 00:00:00'::timestamptz, '2025-05-09 16:07:00'::timestamptz, '2025-05-09 15:06:00'::timestamptz, '2025-05-09 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-05-09 15:06:00'::timestamptz); END IF;

  -- CC1969
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1969', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-10 00:00:00'::timestamptz, '2025-05-10 14:47:00'::timestamptz, '2025-05-10 14:07:00'::timestamptz, '2025-05-10 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-10 14:07:00'::timestamptz); END IF;

  -- CC1970
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1970', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-05-10 00:00:00'::timestamptz, '2025-05-10 17:01:00'::timestamptz, '2025-05-10 16:32:00'::timestamptz, '2025-05-10 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-05-10 16:32:00'::timestamptz); END IF;

  -- CC1971
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1971', 'Rosa Arrocha', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-05-10 00:00:00'::timestamptz, '2025-05-10 17:01:00'::timestamptz, '2025-05-10 16:34:00'::timestamptz, '2025-05-10 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-05-10 16:34:00'::timestamptz); END IF;

  -- CC1972
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1972', 'Lina Perez', false, 'completed', false, 31.43, 0.00, 0, 1.57, 33.00, 0.00, 0, 21, 'Lavandería', '2025-05-11 00:00:00'::timestamptz, '2025-05-11 12:17:00'::timestamptz, '2025-05-11 11:35:00'::timestamptz, '2025-05-11 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 33.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 33.00, '2025-05-11 11:35:00'::timestamptz); END IF;

  -- CC1973
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1973', 'Josue Pernett', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2025-05-11 00:00:00'::timestamptz, '2025-05-11 15:36:00'::timestamptz, '2025-05-11 12:34:00'::timestamptz, '2025-05-11 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-11 12:34:00'::timestamptz); END IF;

  -- CC1974
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1974', 'Virginia Gonzalez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-05-11 00:00:00'::timestamptz, '2025-05-11 16:14:00'::timestamptz, '2025-05-11 15:41:00'::timestamptz, '2025-05-11 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-05-11 15:41:00'::timestamptz); END IF;

  -- CC1975
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1975', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-05-12 00:00:00'::timestamptz, '2025-05-12 11:35:00'::timestamptz, '2025-05-12 11:29:00'::timestamptz, '2025-05-12 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-05-12 11:29:00'::timestamptz); END IF;

  -- CC1976
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1976', 'Oscar Oropeza', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavandería', '2025-05-12 00:00:00'::timestamptz, '2025-05-12 15:41:00'::timestamptz, '2025-05-12 14:02:00'::timestamptz, '2025-05-12 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-05-12 14:02:00'::timestamptz); END IF;

  -- CC1977
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1977', 'Liliana', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '0', '2025-05-12 00:00:00'::timestamptz, '2025-05-12 15:59:00'::timestamptz, '2025-05-12 15:14:00'::timestamptz, '2025-05-12 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-05-12 15:14:00'::timestamptz); END IF;

  -- CC1978
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1978', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-05-13 00:00:00'::timestamptz, '2025-05-13 17:35:00'::timestamptz, '2025-05-13 12:30:00'::timestamptz, '2025-05-13 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-13 12:30:00'::timestamptz); END IF;

  -- CC1979
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1979', 'Liliana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-05-13 00:00:00'::timestamptz, '2025-05-13 17:35:00'::timestamptz, '2025-05-13 17:35:00'::timestamptz, '2025-05-13 17:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-13 17:35:00'::timestamptz); END IF;

  -- CC1980
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 150;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1980', 'Paulo Motta Mello', false, 'completed', false, 12.62, 0.00, 0, 0.88, 13.50, 1.85, 1, 2, '149', '2025-05-14 00:00:00'::timestamptz, '2025-05-14 16:15:00'::timestamptz, '2025-05-14 15:03:00'::timestamptz, '2025-05-14 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.50, '2025-05-14 15:03:00'::timestamptz); END IF;

  -- CC1981
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1981', 'Rosa Arrocha', false, 'completed', false, 9.58, 0.00, 0, 0.67, 10.25, 4.10, 1, 1, 'Lavandería', '2025-05-15 00:00:00'::timestamptz, '2025-05-15 12:20:00'::timestamptz, '2025-05-15 09:30:00'::timestamptz, '2025-05-15 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.25, '2025-05-15 09:30:00'::timestamptz); END IF;

  -- CC1982
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1982', 'German Alveo', false, 'completed', false, 32.57, 0.00, 0, 2.28, 34.85, 13.94, 6, 1, 'Lavandería', '2025-05-15 00:00:00'::timestamptz, '2025-05-15 16:01:00'::timestamptz, '2025-05-15 15:53:00'::timestamptz, '2025-05-15 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.85, '2025-05-15 15:53:00'::timestamptz); END IF;

  -- CC1983
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1983', 'German Alveo', false, 'completed', false, 8.18, 0.00, 0, 0.57, 8.75, 3.50, 1, 1, 'Lavandería', '2025-05-15 00:00:00'::timestamptz, '2025-05-15 16:02:00'::timestamptz, '2025-05-15 15:55:00'::timestamptz, '2025-05-15 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.75, '2025-05-15 15:55:00'::timestamptz); END IF;

  -- CC1984
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1984', 'Leonel Visueti', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-05-15 00:00:00'::timestamptz, '2025-05-15 00:00:00'::timestamptz, '2025-05-15 16:08:00'::timestamptz, '2025-05-15 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-05-15 16:08:00'::timestamptz); END IF;

  -- CC1985
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1985', 'Leonel Visueti', false, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, '', '2025-05-16 00:00:00'::timestamptz, '2025-05-16 09:23:00'::timestamptz, '2025-05-16 09:23:00'::timestamptz, '2025-05-16 09:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-05-16 09:23:00'::timestamptz); END IF;

  -- CC1986
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1986', 'Grethell Guevara', false, 'completed', false, 24.63, 0.00, 0, 1.37, 26.00, 8.40, 2, 6, 'Lavandería', '2025-05-16 00:00:00'::timestamptz, '2025-05-16 15:46:00'::timestamptz, '2025-05-16 14:27:00'::timestamptz, '2025-05-16 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.00, '2025-05-16 14:27:00'::timestamptz); END IF;

  -- CC1987
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1987', 'Virginia Gonzalez', false, 'completed', false, 15.35, 0.00, 0, 0.65, 16.00, 0.00, 0, 11, 'Lavandería', '2025-05-17 00:00:00'::timestamptz, '2025-05-17 14:15:00'::timestamptz, '2025-05-17 12:51:00'::timestamptz, '2025-05-17 12:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-05-17 12:51:00'::timestamptz); END IF;

  -- CC1988
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1988', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-05-17 00:00:00'::timestamptz, '2025-05-17 15:25:00'::timestamptz, '2025-05-17 14:30:00'::timestamptz, '2025-05-17 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-05-17 14:30:00'::timestamptz); END IF;

  -- CC1989
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1989', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-05-17 00:00:00'::timestamptz, '2025-05-17 16:53:00'::timestamptz, '2025-05-17 16:53:00'::timestamptz, '2025-05-17 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-05-17 16:53:00'::timestamptz); END IF;

  -- CC1990
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1990', 'Leonel Visueti', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, '', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 11:47:00'::timestamptz, '2025-05-18 09:53:00'::timestamptz, '2025-05-18 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-05-18 09:53:00'::timestamptz); END IF;

  -- CC1991
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1991', 'Josue Pernett', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavanderia', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 12:27:00'::timestamptz, '2025-05-18 10:59:00'::timestamptz, '2025-05-18 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-05-18 10:59:00'::timestamptz); END IF;

  -- CC1992
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 151;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1992', 'Miguel Vega', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 6, 'lavanderia', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 15:08:00'::timestamptz, '2025-05-18 11:42:00'::timestamptz, '2025-05-18 11:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-05-18 11:42:00'::timestamptz); END IF;

  -- CC1993
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 151;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1993', 'Miguel Vega', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'lavanderia', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 00:00:00'::timestamptz, '2025-05-18 11:51:00'::timestamptz, '2025-05-18 11:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-05-18 11:51:00'::timestamptz); END IF;

  -- CC1994
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 145;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1994', 'Emma Ducreux', false, 'completed', false, 16.71, 0.00, 0, 1.17, 17.88, 7.15, 2, 1, '', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 15:08:00'::timestamptz, '2025-05-18 12:43:00'::timestamptz, '2025-05-18 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.88, '2025-05-18 12:43:00'::timestamptz); END IF;

  -- CC1995
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1995', 'Liliana Zambrano', false, 'completed', false, 11.48, 0.00, 0, 0.52, 12.00, 0.00, 0, 8, '0', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 13:26:00'::timestamptz, '2025-05-18 12:49:00'::timestamptz, '2025-05-18 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-05-18 12:49:00'::timestamptz); END IF;

  -- CC1996
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1996', 'Leonel Visueti', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 00:00:00'::timestamptz, '2025-05-18 12:55:00'::timestamptz, '2025-05-18 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-18 12:55:00'::timestamptz); END IF;

  -- CC1997
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1997', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-05-18 00:00:00'::timestamptz, '2025-05-18 15:24:00'::timestamptz, '2025-05-18 15:03:00'::timestamptz, '2025-05-18 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-05-18 15:03:00'::timestamptz); END IF;

  -- CC1998
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 153;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1998', 'Aracely Morales', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-05-19 00:00:00'::timestamptz, '2025-05-19 17:30:00'::timestamptz, '2025-05-19 13:32:00'::timestamptz, '2025-05-19 13:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-05-19 13:32:00'::timestamptz); END IF;

  -- CC1999
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1999', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-19 00:00:00'::timestamptz, '2025-05-19 14:25:00'::timestamptz, '2025-05-19 13:37:00'::timestamptz, '2025-05-19 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-19 13:37:00'::timestamptz); END IF;

  -- CC2000
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2000', 'Leonel Visueti', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, '', '2025-05-19 00:00:00'::timestamptz, '2025-05-19 17:15:00'::timestamptz, '2025-05-19 15:53:00'::timestamptz, '2025-05-19 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-05-19 15:53:00'::timestamptz); END IF;

  -- CC2001
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2001', 'Lina Perez', false, 'completed', false, 15.35, 0.00, 0, 0.65, 16.00, 0.00, 0, 11, 'Lavandería', '2025-05-19 00:00:00'::timestamptz, '2025-05-19 17:15:00'::timestamptz, '2025-05-19 17:12:00'::timestamptz, '2025-05-19 17:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-05-19 17:12:00'::timestamptz); END IF;

  -- CC2002
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2002', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-05-20 00:00:00'::timestamptz, '2025-05-20 11:18:00'::timestamptz, '2025-05-20 09:28:00'::timestamptz, '2025-05-20 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-20 09:28:00'::timestamptz); END IF;

  -- CC2003
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2003', 'Leonel Visueti', false, 'completed', false, 22.43, 0.00, 0, 1.57, 24.00, 0.00, 0, 12, '', '2025-05-20 00:00:00'::timestamptz, '2025-05-20 16:59:00'::timestamptz, '2025-05-20 15:38:00'::timestamptz, '2025-05-20 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.00, '2025-05-20 15:38:00'::timestamptz); END IF;

  -- CC2004
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 14;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2004', 'Melissa VanSice', false, 'completed', false, 65.65, 0.00, 0, 4.60, 70.25, 28.10, 4, 1, '', '2025-05-20 00:00:00'::timestamptz, '2025-05-21 13:07:00'::timestamptz, '2025-05-20 15:43:00'::timestamptz, '2025-05-20 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 70.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 70.25, '2025-05-20 15:43:00'::timestamptz); END IF;

  -- CC2005
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2005', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-05-20 00:00:00'::timestamptz, '2025-05-20 17:47:00'::timestamptz, '2025-05-20 17:00:00'::timestamptz, '2025-05-20 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-20 17:00:00'::timestamptz); END IF;

  -- CC2006
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2006', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-05-20 00:00:00'::timestamptz, '2025-05-20 17:47:00'::timestamptz, '2025-05-20 17:15:00'::timestamptz, '2025-05-20 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-05-20 17:15:00'::timestamptz); END IF;

  -- CC2007
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2007', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 12:15:00'::timestamptz, '2025-05-21 12:14:00'::timestamptz, '2025-05-21 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-05-21 12:14:00'::timestamptz); END IF;

  -- CC2009
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 155;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2009', 'Julissa', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 2, '', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 16:29:00'::timestamptz, '2025-05-21 12:39:00'::timestamptz, '2025-05-21 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-05-21 12:39:00'::timestamptz); END IF;

  -- CC2010
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2010', 'Aaron Gutierrez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 14:11:00'::timestamptz, '2025-05-21 12:43:00'::timestamptz, '2025-05-21 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-05-21 12:43:00'::timestamptz); END IF;

  -- CC2011
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2011', 'Karla Garibaldi', false, 'completed', false, 28.04, 0.00, 0, 1.96, 30.00, 0.00, 0, 12, 'Lavandería', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 16:29:00'::timestamptz, '2025-05-21 13:27:00'::timestamptz, '2025-05-21 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.00, '2025-05-21 13:27:00'::timestamptz); END IF;

  -- CC2012
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2012', 'Karla Garibaldi', false, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, 'Lavandería', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 14:11:00'::timestamptz, '2025-05-21 13:59:00'::timestamptz, '2025-05-21 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-05-21 13:59:00'::timestamptz); END IF;

  -- CC2013
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2013', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-05-21 00:00:00'::timestamptz, '2025-05-21 16:29:00'::timestamptz, '2025-05-21 16:07:00'::timestamptz, '2025-05-21 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-05-21 16:07:00'::timestamptz); END IF;

  -- CC2015
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2015', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-05-22 00:00:00'::timestamptz, '2025-05-22 09:52:00'::timestamptz, '2025-05-22 08:32:00'::timestamptz, '2025-05-22 08:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-05-22 08:32:00'::timestamptz); END IF;

  -- CC2016
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2016', 'German Alveo', false, 'completed', false, 32.36, 0.00, 0, 2.27, 34.63, 13.85, 6, 1, 'Lavandería', '2025-05-22 00:00:00'::timestamptz, '2025-05-22 14:21:00'::timestamptz, '2025-05-22 09:54:00'::timestamptz, '2025-05-22 09:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.63, '2025-05-22 09:54:00'::timestamptz); END IF;

  -- CC2017
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2017', 'German Alveo', false, 'completed', false, 7.01, 0.00, 0, 0.49, 7.50, 3.00, 1, 1, 'Lavandería', '2025-05-22 00:00:00'::timestamptz, '2025-05-22 14:21:00'::timestamptz, '2025-05-22 09:55:00'::timestamptz, '2025-05-22 09:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-05-22 09:55:00'::timestamptz); END IF;

  -- CC2018
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2018', 'Carlos Arroyo', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia', '2025-05-22 00:00:00'::timestamptz, '2025-05-22 15:17:00'::timestamptz, '2025-05-22 14:31:00'::timestamptz, '2025-05-22 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-05-22 14:31:00'::timestamptz); END IF;

  -- CC2019
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2019', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-05-22 00:00:00'::timestamptz, '2025-05-22 16:44:00'::timestamptz, '2025-05-22 15:06:00'::timestamptz, '2025-05-22 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-05-22 15:06:00'::timestamptz); END IF;

  -- CC2020
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2020', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-05-23 00:00:00'::timestamptz, '2025-05-23 17:08:00'::timestamptz, '2025-05-23 16:26:00'::timestamptz, '2025-05-23 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-23 16:26:00'::timestamptz); END IF;

  -- CC2021
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2021', 'Oscar Oropeza', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 0.00, 0, 9, 'Lavandería', '2025-05-23 00:00:00'::timestamptz, '2025-05-23 17:31:00'::timestamptz, '2025-05-23 17:30:00'::timestamptz, '2025-05-23 17:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-05-23 17:30:00'::timestamptz); END IF;

  -- CC2022
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2022', 'Leonel Willson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-05-24 00:00:00'::timestamptz, '2025-05-24 12:09:00'::timestamptz, '2025-05-24 10:31:00'::timestamptz, '2025-05-24 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-05-24 10:31:00'::timestamptz); END IF;

  -- CC2023
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2023', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-05-24 00:00:00'::timestamptz, '2025-05-24 13:28:00'::timestamptz, '2025-05-24 12:33:00'::timestamptz, '2025-05-24 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-05-24 12:33:00'::timestamptz); END IF;

  -- CC2024
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2024', 'Fernando Ortega', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-05-25 00:00:00'::timestamptz, '2025-05-25 13:42:00'::timestamptz, '2025-05-25 12:52:00'::timestamptz, '2025-05-25 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-05-25 12:52:00'::timestamptz); END IF;

  -- CC2025
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2025', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-26 00:00:00'::timestamptz, '2025-05-25 15:09:00'::timestamptz, '2025-05-25 14:21:00'::timestamptz, '2025-05-25 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-25 14:21:00'::timestamptz); END IF;

  -- CC2026
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2026', 'Grethell Guevara', false, 'completed', false, 119.31, 0.00, 0, 7.44, 126.75, 45.50, 9, 14, 'Lavandería', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 12:23:00'::timestamptz, '2025-05-26 11:50:00'::timestamptz, '2025-05-26 11:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 126.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 126.75, '2025-05-26 11:50:00'::timestamptz); END IF;

  -- CC2027
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2027', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 13:15:00'::timestamptz, '2025-05-26 11:55:00'::timestamptz, '2025-05-26 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-05-26 11:55:00'::timestamptz); END IF;

  -- CC2028
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2028', 'Grethell Guevara', false, 'completed', false, 3.27, 0.00, 0, 0.23, 3.50, 0.00, 0, 1, 'Lavandería', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 12:24:00'::timestamptz, '2025-05-26 12:04:00'::timestamptz, '2025-05-26 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.50, '2025-05-26 12:04:00'::timestamptz); END IF;

  -- CC2029
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2029', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 16:59:00'::timestamptz, '2025-05-26 13:15:00'::timestamptz, '2025-05-26 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-26 13:15:00'::timestamptz); END IF;

  -- CC2030
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2030', 'Josue Pernett', false, 'completed', false, 14.35, 0.00, 0, 0.65, 15.00, 0.00, 0, 10, 'Lavanderia', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 16:58:00'::timestamptz, '2025-05-26 14:40:00'::timestamptz, '2025-05-26 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-05-26 14:40:00'::timestamptz); END IF;

  -- CC2031
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2031', 'Leonel Visueti', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, '', '2025-05-26 00:00:00'::timestamptz, '2025-05-26 16:58:00'::timestamptz, '2025-05-26 14:46:00'::timestamptz, '2025-05-26 14:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-05-26 14:46:00'::timestamptz); END IF;

  -- CC2032
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2032', 'Rafael Quintero', false, 'completed', false, 14.14, 0.00, 0, 0.99, 15.13, 6.05, 1, 1, '0', '2025-05-27 00:00:00'::timestamptz, '2025-05-28 11:39:00'::timestamptz, '2025-05-27 09:31:00'::timestamptz, '2025-05-27 09:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.13, '2025-05-27 09:31:00'::timestamptz); END IF;

  -- CC2033
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2033', 'Carlos Arroyo', false, 'completed', false, 18.95, 0.00, 0, 1.05, 20.00, 0.00, 0, 12, 'lavanderia', '2025-05-27 00:00:00'::timestamptz, '2025-05-27 11:44:00'::timestamptz, '2025-05-27 10:06:00'::timestamptz, '2025-05-27 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-05-27 10:06:00'::timestamptz); END IF;

  -- CC2034
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2034', 'Cliente Lavandería', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 2, 'Lavandería', '2025-05-27 00:00:00'::timestamptz, '2025-05-30 16:17:00'::timestamptz, '2025-05-27 14:22:00'::timestamptz, '2025-05-27 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-05-27 14:22:00'::timestamptz); END IF;

  -- CC2035
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2035', 'Leonel Visueti', false, 'completed', false, 51.21, 0.00, 0, 3.59, 54.80, 24.65, 4, 2, '', '2025-05-27 00:00:00'::timestamptz, '2025-05-27 17:04:00'::timestamptz, '2025-05-27 17:03:00'::timestamptz, '2025-05-27 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 54.80 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 54.80, '2025-05-27 17:03:00'::timestamptz); END IF;

  -- CC2036
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2036', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-27 00:00:00'::timestamptz, '2025-05-27 17:09:00'::timestamptz, '2025-05-27 17:08:00'::timestamptz, '2025-05-27 17:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-27 17:08:00'::timestamptz); END IF;

  -- CC2037
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2037', 'Lina Perez', false, 'completed', false, 33.24, 4.00, 0, 1.76, 35.00, 0.00, 0, 24, 'Lavandería', '2025-05-28 00:00:00'::timestamptz, '2025-05-28 11:39:00'::timestamptz, '2025-05-28 10:52:00'::timestamptz, '2025-05-28 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.00, '2025-05-28 10:52:00'::timestamptz); END IF;

  -- CC2038
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 148;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2038', 'Yul Pinto', false, 'completed', false, 6.07, 0.00, 0, 0.43, 6.50, 2.60, 1, 1, 'lavanderia', '2025-05-28 00:00:00'::timestamptz, '2025-05-28 15:43:00'::timestamptz, '2025-05-28 13:34:00'::timestamptz, '2025-05-28 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-05-28 13:34:00'::timestamptz); END IF;

  -- CC2039
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2039', 'Leonel Visueti', false, 'completed', false, 1.07, 0.00, 0, 0.08, 1.15, 0.00, 0, 3, '', '2025-05-28 00:00:00'::timestamptz, '2025-05-28 15:03:00'::timestamptz, '2025-05-28 14:30:00'::timestamptz, '2025-05-28 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.15, '2025-05-28 14:30:00'::timestamptz); END IF;

  -- CC2040
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2040', 'Aaron Gutierrez', false, 'completed', false, 9.85, 0.00, 0, 0.65, 10.50, 0.00, 0, 6, 'Lavandería', '2025-05-28 00:00:00'::timestamptz, '2025-05-29 10:16:00'::timestamptz, '2025-05-28 14:35:00'::timestamptz, '2025-05-28 14:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-05-28 14:35:00'::timestamptz); END IF;

  -- CC2041
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 157;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2041', 'Sisi Varela', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia', '2025-05-28 00:00:00'::timestamptz, '2025-05-28 15:43:00'::timestamptz, '2025-05-28 14:49:00'::timestamptz, '2025-05-28 14:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-28 14:49:00'::timestamptz); END IF;

  -- CC2042
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2042', 'German Alveo', false, 'completed', false, 1.54, 0.00, 0, 0.11, 1.65, 0.00, 0, 4, 'Lavandería', '2025-05-29 00:00:00'::timestamptz, '2025-05-29 14:10:00'::timestamptz, '2025-05-29 10:15:00'::timestamptz, '2025-05-29 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.65, '2025-05-29 10:15:00'::timestamptz); END IF;

  -- CC2043
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2043', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-29 00:00:00'::timestamptz, '2025-05-29 14:10:00'::timestamptz, '2025-05-29 10:17:00'::timestamptz, '2025-05-29 10:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-29 10:17:00'::timestamptz); END IF;

  -- CC2044
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2044', 'German Alveo', false, 'completed', false, 6.78, 0.00, 0, 0.47, 7.25, 2.90, 1, 1, 'Lavandería', '2025-05-29 00:00:00'::timestamptz, '2025-05-29 16:09:00'::timestamptz, '2025-05-29 14:09:00'::timestamptz, '2025-05-29 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.25, '2025-05-29 14:09:00'::timestamptz); END IF;

  -- CC2045
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2045', 'German Alveo', false, 'completed', false, 38.79, 0.00, 0, 2.71, 41.50, 16.60, 6, 1, 'Lavandería', '2025-05-29 00:00:00'::timestamptz, '2025-05-29 16:09:00'::timestamptz, '2025-05-29 14:15:00'::timestamptz, '2025-05-29 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 41.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 41.50, '2025-05-29 14:15:00'::timestamptz); END IF;

  -- CC2046
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2046', 'Alberto Campell', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, 'lavanderia', '2025-05-29 00:00:00'::timestamptz, '2025-05-29 00:00:00'::timestamptz, '2025-05-29 15:14:00'::timestamptz, '2025-05-29 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-05-29 15:14:00'::timestamptz); END IF;

  -- CC2047
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 159;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2047', 'Brenda Paredes', false, 'completed', false, 35.51, 0.00, 0, 2.49, 38.00, 0.00, 0, 5, '0', '2025-05-31 00:00:00'::timestamptz, '2025-05-30 16:07:00'::timestamptz, '2025-05-30 12:51:00'::timestamptz, '2025-05-30 12:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 38.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 38.00, '2025-05-30 12:51:00'::timestamptz); END IF;

  -- CC2048
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2048', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-05-31 00:00:00'::timestamptz, '2025-05-31 12:10:00'::timestamptz, '2025-05-31 11:28:00'::timestamptz, '2025-05-31 11:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-05-31 11:28:00'::timestamptz); END IF;

  -- CC2049
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2049', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-05-31 00:00:00'::timestamptz, '2025-05-31 17:05:00'::timestamptz, '2025-05-31 16:10:00'::timestamptz, '2025-05-31 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-05-31 16:10:00'::timestamptz); END IF;

  -- CC2050
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2050', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-01 00:00:00'::timestamptz, '2025-06-01 12:55:00'::timestamptz, '2025-06-01 11:32:00'::timestamptz, '2025-06-01 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-06-01 11:32:00'::timestamptz); END IF;

  -- CC2051
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2051', 'Alberto Campell', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'lavanderia', '2025-06-01 00:00:00'::timestamptz, '2025-06-01 00:00:00'::timestamptz, '2025-06-01 11:49:00'::timestamptz, '2025-06-01 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-01 11:49:00'::timestamptz); END IF;

  -- CC2052
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2052', 'Liliana', false, 'completed', false, 4.87, 0.00, 0, 0.13, 5.00, 0.00, 0, 5, '0', '2025-06-01 00:00:00'::timestamptz, '2025-06-01 12:55:00'::timestamptz, '2025-06-01 12:13:00'::timestamptz, '2025-06-01 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-01 12:13:00'::timestamptz); END IF;

  -- CC2053
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2053', 'Virginia Gonzalez', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, 'Lavandería', '2025-06-01 00:00:00'::timestamptz, '2025-06-01 15:52:00'::timestamptz, '2025-06-01 14:37:00'::timestamptz, '2025-06-01 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-06-01 14:37:00'::timestamptz); END IF;

  -- CC2054
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2054', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-01 00:00:00'::timestamptz, '2025-06-01 15:52:00'::timestamptz, '2025-06-01 15:23:00'::timestamptz, '2025-06-01 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-06-01 15:23:00'::timestamptz); END IF;

  -- CC2055
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2055', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-06-02 00:00:00'::timestamptz, '2025-06-02 16:29:00'::timestamptz, '2025-06-02 13:49:00'::timestamptz, '2025-06-02 13:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-02 13:49:00'::timestamptz); END IF;

  -- CC2056
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2056', 'Alberto Campell', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'lavanderia', '2025-06-02 00:00:00'::timestamptz, '2025-06-02 00:00:00'::timestamptz, '2025-06-02 15:59:00'::timestamptz, '2025-06-02 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-02 15:59:00'::timestamptz); END IF;

  -- CC2057
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2057', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-06-02 00:00:00'::timestamptz, '2025-06-02 16:45:00'::timestamptz, '2025-06-02 16:00:00'::timestamptz, '2025-06-02 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-02 16:00:00'::timestamptz); END IF;

  -- CC2058
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2058', 'Rosa Arrocha', false, 'completed', false, 11.40, 0.00, 0, 0.73, 12.13, 4.25, 1, 3, 'Lavandería', '2025-06-03 00:00:00'::timestamptz, '2025-06-03 13:18:00'::timestamptz, '2025-06-03 08:27:00'::timestamptz, '2025-06-03 08:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.13, '2025-06-03 08:27:00'::timestamptz); END IF;

  -- CC2059
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2059', 'Carlos Arroyo', false, 'completed', false, 16.95, 0.00, 0, 1.05, 18.00, 0.00, 0, 11, 'lavanderia', '2025-06-03 00:00:00'::timestamptz, '2025-06-03 16:51:00'::timestamptz, '2025-06-03 15:43:00'::timestamptz, '2025-06-03 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-06-03 15:43:00'::timestamptz); END IF;

  -- CC2060
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2060', 'Aaron Gutierrez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-06-04 00:00:00'::timestamptz, '2025-06-04 16:53:00'::timestamptz, '2025-06-04 16:30:00'::timestamptz, '2025-06-04 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-06-04 16:30:00'::timestamptz); END IF;

  -- CC2061
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2061', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-04 00:00:00'::timestamptz, '2025-06-04 16:53:00'::timestamptz, '2025-06-04 16:43:00'::timestamptz, '2025-06-04 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-04 16:43:00'::timestamptz); END IF;

  -- CC2062
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2062', 'German Alveo', false, 'completed', false, 42.18, 0.00, 0, 2.95, 45.13, 18.05, 6, 1, 'Lavandería', '2025-06-05 00:00:00'::timestamptz, '2025-06-05 14:06:00'::timestamptz, '2025-06-05 11:30:00'::timestamptz, '2025-06-05 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 45.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 45.13, '2025-06-05 11:30:00'::timestamptz); END IF;

  -- CC2063
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2063', 'German Alveo', false, 'completed', false, 8.88, 0.00, 0, 0.62, 9.50, 3.80, 1, 1, 'Lavandería', '2025-06-05 00:00:00'::timestamptz, '2025-06-05 14:06:00'::timestamptz, '2025-06-05 11:30:00'::timestamptz, '2025-06-05 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.50, '2025-06-05 11:30:00'::timestamptz); END IF;

  -- CC2064
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2064', 'German Alveo', false, 'completed', false, 6.06, 0.00, 0, 0.42, 6.48, 3.70, 1, 1, 'Lavandería', '2025-06-05 00:00:00'::timestamptz, '2025-06-06 08:45:00'::timestamptz, '2025-06-05 15:40:00'::timestamptz, '2025-06-05 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.48, '2025-06-05 15:40:00'::timestamptz); END IF;

  -- CC2065
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2065', 'Cliente Lavandería', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, 'Lavandería', '2025-06-05 00:00:00'::timestamptz, '2025-06-05 17:01:00'::timestamptz, '2025-06-05 16:20:00'::timestamptz, '2025-06-05 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-05 16:20:00'::timestamptz); END IF;

  -- CC2066
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2066', 'Cliente Lavandería', false, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavandería', '2025-06-05 00:00:00'::timestamptz, '2025-06-05 17:01:00'::timestamptz, '2025-06-05 16:20:00'::timestamptz, '2025-06-05 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-05 16:20:00'::timestamptz); END IF;

  -- CC2067
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2067', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-06 00:00:00'::timestamptz, '2025-06-07 10:39:00'::timestamptz, '2025-06-06 16:29:00'::timestamptz, '2025-06-06 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-06 16:29:00'::timestamptz); END IF;

  -- CC2068
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2068', 'Retail', true, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, '', '2025-06-06 00:00:00'::timestamptz, '2025-06-06 00:00:00'::timestamptz, '2025-06-06 16:30:00'::timestamptz, '2025-06-06 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-06-06 16:30:00'::timestamptz); END IF;

  -- CC2069
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2069', 'Oscar Oropeza', false, 'completed', false, 9.35, 2.00, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 12:56:00'::timestamptz, '2025-06-07 10:39:00'::timestamptz, '2025-06-07 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-06-07 10:39:00'::timestamptz); END IF;

  -- CC2070
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2070', 'Leonel Visueti', false, 'completed', false, 15.08, 0.00, 0, 0.92, 16.00, 0.00, 0, 9, '', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 15:38:00'::timestamptz, '2025-06-07 13:25:00'::timestamptz, '2025-06-07 13:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-06-07 13:25:00'::timestamptz); END IF;

  -- CC2071
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2071', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 14:53:00'::timestamptz, '2025-06-07 14:20:00'::timestamptz, '2025-06-07 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-07 14:20:00'::timestamptz); END IF;

  -- CC2072
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2072', 'Virginia Gonzalez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 16:57:00'::timestamptz, '2025-06-07 16:38:00'::timestamptz, '2025-06-07 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-07 16:38:00'::timestamptz); END IF;

  -- CC2073
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2073', 'Sandra Medina', false, 'completed', false, 13.21, 0.00, 0, 0.79, 14.00, 0.00, 0, 8, '0', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 16:57:00'::timestamptz, '2025-06-07 16:40:00'::timestamptz, '2025-06-07 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-06-07 16:40:00'::timestamptz); END IF;

  -- CC2074
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2074', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 4, 'Lavandería', '2025-06-07 00:00:00'::timestamptz, '2025-06-07 17:04:00'::timestamptz, '2025-06-07 17:04:00'::timestamptz, '2025-06-07 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-07 17:04:00'::timestamptz); END IF;

  -- CC2075
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2075', 'Josue Pernett', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2025-06-08 00:00:00'::timestamptz, '2025-06-08 13:45:00'::timestamptz, '2025-06-08 11:54:00'::timestamptz, '2025-06-08 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-06-08 11:54:00'::timestamptz); END IF;

  -- CC2076
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2076', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-06-08 00:00:00'::timestamptz, '2025-06-08 13:45:00'::timestamptz, '2025-06-08 12:12:00'::timestamptz, '2025-06-08 12:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-08 12:12:00'::timestamptz); END IF;

  -- CC2077
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2077', 'Cristina Lau', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavandería', '2025-06-08 00:00:00'::timestamptz, '2025-06-08 14:37:00'::timestamptz, '2025-06-08 12:53:00'::timestamptz, '2025-06-08 12:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-06-08 12:53:00'::timestamptz); END IF;

  -- CC2078
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2078', 'Leonel Visueti', false, 'completed', false, 11.48, 0.00, 0, 0.52, 12.00, 0.00, 0, 8, '', '2025-06-08 00:00:00'::timestamptz, '2025-06-08 16:07:00'::timestamptz, '2025-06-08 15:40:00'::timestamptz, '2025-06-08 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-06-08 15:40:00'::timestamptz); END IF;

  -- CC2079
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2079', 'Cliente Lavandería', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, 'Lavandería', '2025-06-08 00:00:00'::timestamptz, '2025-06-08 16:07:00'::timestamptz, '2025-06-08 15:42:00'::timestamptz, '2025-06-08 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-06-08 15:42:00'::timestamptz); END IF;

  -- CC2080
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2080', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-09 00:00:00'::timestamptz, '2025-06-09 15:59:00'::timestamptz, '2025-06-09 09:27:00'::timestamptz, '2025-06-09 09:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-06-09 09:27:00'::timestamptz); END IF;

  -- CC2081
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 142;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2081', 'Luis Barlo', false, 'completed', false, 12.48, 0.00, 0, 0.52, 13.00, 0.00, 0, 10, 'Lavandería', '2025-06-09 00:00:00'::timestamptz, '2025-06-09 16:50:00'::timestamptz, '2025-06-09 16:30:00'::timestamptz, '2025-06-09 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-06-09 16:30:00'::timestamptz); END IF;

  -- CC2082
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2082', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-10 00:00:00'::timestamptz, '2025-06-10 16:49:00'::timestamptz, '2025-06-10 12:11:00'::timestamptz, '2025-06-10 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-06-10 12:11:00'::timestamptz); END IF;

  -- CC2083
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2083', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-10 00:00:00'::timestamptz, '2025-06-10 16:49:00'::timestamptz, '2025-06-10 16:12:00'::timestamptz, '2025-06-10 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-06-10 16:12:00'::timestamptz); END IF;

  -- CC2084
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2084', 'Justo Arosemena', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.95, 1, 1, 'lavanderia', '2025-06-11 00:00:00'::timestamptz, '2025-06-12 14:15:00'::timestamptz, '2025-06-11 13:46:00'::timestamptz, '2025-06-11 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-11 13:46:00'::timestamptz); END IF;

  -- CC2085
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2085', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-06-11 00:00:00'::timestamptz, '2025-06-11 16:16:00'::timestamptz, '2025-06-11 16:06:00'::timestamptz, '2025-06-11 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-06-11 16:06:00'::timestamptz); END IF;

  -- CC2086
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 164;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2086', 'Joel Iglesia', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 2, '0', '2025-06-12 00:00:00'::timestamptz, '2025-06-13 08:26:00'::timestamptz, '2025-06-12 09:15:00'::timestamptz, '2025-06-12 09:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-06-12 09:15:00'::timestamptz); END IF;

  -- CC2087
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2087', 'German Alveo', false, 'completed', false, 37.62, 0.00, 0, 2.63, 40.25, 16.10, 5, 1, 'Lavandería', '2025-06-12 00:00:00'::timestamptz, '2025-06-12 15:53:00'::timestamptz, '2025-06-12 13:48:00'::timestamptz, '2025-06-12 13:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.25, '2025-06-12 13:48:00'::timestamptz); END IF;

  -- CC2088
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2088', 'German Alveo', false, 'completed', false, 7.36, 0.00, 0, 0.52, 7.88, 3.15, 1, 1, 'Lavandería', '2025-06-12 00:00:00'::timestamptz, '2025-06-12 15:53:00'::timestamptz, '2025-06-12 13:59:00'::timestamptz, '2025-06-12 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.88, '2025-06-12 13:59:00'::timestamptz); END IF;

  -- CC2089
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 165;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2089', 'Marian Bequiz', false, 'completed', false, 5.96, 0.00, 0, 0.42, 6.38, 2.55, 1, 1, '0', '2025-06-12 00:00:00'::timestamptz, '2025-06-12 16:00:00'::timestamptz, '2025-06-12 14:26:00'::timestamptz, '2025-06-12 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.38, '2025-06-12 14:26:00'::timestamptz); END IF;

  -- CC2090
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 166;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2090', 'Ismary Salcedo', false, 'completed', false, 16.21, 0.00, 0, 0.79, 17.00, 0.00, 0, 11, 'lavanderia', '2025-06-13 00:00:00'::timestamptz, '2025-06-13 11:11:00'::timestamptz, '2025-06-13 10:27:00'::timestamptz, '2025-06-13 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.00, '2025-06-13 10:27:00'::timestamptz); END IF;

  -- CC2091
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2091', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-06-13 00:00:00'::timestamptz, '2025-06-13 11:56:00'::timestamptz, '2025-06-13 11:54:00'::timestamptz, '2025-06-13 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-06-13 11:54:00'::timestamptz); END IF;

  -- CC2092
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2092', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 5, '', '2025-06-13 00:00:00'::timestamptz, '2025-06-13 14:29:00'::timestamptz, '2025-06-13 12:14:00'::timestamptz, '2025-06-13 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-06-13 12:14:00'::timestamptz); END IF;

  -- CC2093
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2093', 'Fany Luz Salon', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-06-13 00:00:00'::timestamptz, '2025-06-13 14:30:00'::timestamptz, '2025-06-13 12:21:00'::timestamptz, '2025-06-13 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-13 12:21:00'::timestamptz); END IF;

  -- CC2094
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2094', 'Leonel Visueti', false, 'completed', false, 4.97, 0.00, 0, 0.28, 5.25, 0.00, 0, 4, '', '2025-06-13 00:00:00'::timestamptz, '2025-06-13 16:33:00'::timestamptz, '2025-06-13 16:32:00'::timestamptz, '2025-06-13 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2025-06-13 16:32:00'::timestamptz); END IF;

  -- CC2095
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 167;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2095', 'Karla Palacios', false, 'completed', false, 10.98, 0.00, 0, 0.77, 11.75, 4.70, 1, 1, '0', '2025-06-13 00:00:00'::timestamptz, '2025-06-14 10:16:00'::timestamptz, '2025-06-13 16:56:00'::timestamptz, '2025-06-13 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.75, '2025-06-13 16:56:00'::timestamptz); END IF;

  -- CC2096
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2096', 'Lina Perez', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavandería', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 00:00:00'::timestamptz, '2025-06-14 11:24:00'::timestamptz, '2025-06-14 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-14 11:24:00'::timestamptz); END IF;

  -- CC2097
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2097', 'Virginia Gonzalez', false, 'completed', false, 0.00, 4.00, 0, 0.00, 0.00, 0.00, 0, 2, 'Lavandería', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 13:29:00'::timestamptz, '2025-06-14 11:43:00'::timestamptz, '2025-06-14 11:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-06-14 11:43:00'::timestamptz); END IF;

  -- CC2098
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2098', 'Leonel Willson', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 13:50:00'::timestamptz, '2025-06-14 12:06:00'::timestamptz, '2025-06-14 12:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-14 12:06:00'::timestamptz); END IF;

  -- CC2099
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2099', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 13:50:00'::timestamptz, '2025-06-14 12:34:00'::timestamptz, '2025-06-14 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-14 12:34:00'::timestamptz); END IF;

  -- CC2100
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2100', 'Alvaro Martinez', false, 'completed', false, 7.94, 0.00, 0, 0.56, 8.50, 3.40, 3, 1, 'lavanderia', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 17:03:00'::timestamptz, '2025-06-14 12:50:00'::timestamptz, '2025-06-14 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.50, '2025-06-14 12:50:00'::timestamptz); END IF;

  -- CC2101
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2101', 'Lina Perez', false, 'completed', false, 36.98, 4.00, 0, 2.02, 39.00, 0.00, 0, 26, 'Lavandería', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 13:54:00'::timestamptz, '2025-06-14 13:51:00'::timestamptz, '2025-06-14 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 39.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 39.00, '2025-06-14 13:51:00'::timestamptz); END IF;

  -- CC2102
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2102', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 5, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 15:44:00'::timestamptz, '2025-06-14 13:56:00'::timestamptz, '2025-06-14 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-06-14 13:56:00'::timestamptz); END IF;

  -- CC2103
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2103', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 14:58:00'::timestamptz, '2025-06-14 14:56:00'::timestamptz, '2025-06-14 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-06-14 14:56:00'::timestamptz); END IF;

  -- CC2104
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2104', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 00:00:00'::timestamptz, '2025-06-14 15:04:00'::timestamptz, '2025-06-14 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-14 15:04:00'::timestamptz); END IF;

  -- CC2105
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2105', 'Josue Pernett', false, 'completed', false, 14.08, 0.00, 0, 0.92, 15.00, 0.00, 0, 8, 'Lavanderia', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 15:44:00'::timestamptz, '2025-06-14 15:13:00'::timestamptz, '2025-06-14 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-06-14 15:13:00'::timestamptz); END IF;

  -- CC2106
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2106', 'Leonel Visueti', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 17:03:00'::timestamptz, '2025-06-14 15:49:00'::timestamptz, '2025-06-14 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-06-14 15:49:00'::timestamptz); END IF;

  -- CC2107
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2107', 'Sandra Medina', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '0', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 17:03:00'::timestamptz, '2025-06-14 16:22:00'::timestamptz, '2025-06-14 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-06-14 16:22:00'::timestamptz); END IF;

  -- CC2108
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2108', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 00:00:00'::timestamptz, '2025-06-14 16:40:00'::timestamptz, '2025-06-14 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-14 16:40:00'::timestamptz); END IF;

  -- CC2109
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2109', 'Leonel Visueti', false, 'completed', false, 8.73, 0.00, 0, 0.52, 9.25, 0.00, 0, 8, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 17:15:00'::timestamptz, '2025-06-14 17:06:00'::timestamptz, '2025-06-14 17:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.25, '2025-06-14 17:06:00'::timestamptz); END IF;

  -- CC2110
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2110', 'Leonel Visueti', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 0.00, 0, 11, '', '2025-06-14 00:00:00'::timestamptz, '2025-06-14 17:39:00'::timestamptz, '2025-06-14 17:15:00'::timestamptz, '2025-06-14 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.00, '2025-06-14 17:15:00'::timestamptz); END IF;

  -- CC2111
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2111', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '', '2025-06-16 00:00:00'::timestamptz, '2025-06-16 10:33:00'::timestamptz, '2025-06-16 09:17:00'::timestamptz, '2025-06-16 09:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-06-16 09:17:00'::timestamptz); END IF;

  -- CC2112
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2112', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-16 00:00:00'::timestamptz, '2025-06-16 16:36:00'::timestamptz, '2025-06-16 10:33:00'::timestamptz, '2025-06-16 10:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-16 10:33:00'::timestamptz); END IF;

  -- CC2113
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2113', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-06-16 00:00:00'::timestamptz, '2025-06-16 14:18:00'::timestamptz, '2025-06-16 11:23:00'::timestamptz, '2025-06-16 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-06-16 11:23:00'::timestamptz); END IF;

  -- CC2114
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2114', 'Carlos Arroyo', false, 'completed', false, 40.64, 0.00, 0, 2.36, 43.00, 0.00, 0, 23, 'lavanderia', '2025-06-16 00:00:00'::timestamptz, '2025-06-16 14:18:00'::timestamptz, '2025-06-16 12:36:00'::timestamptz, '2025-06-16 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 43.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 43.00, '2025-06-16 12:36:00'::timestamptz); END IF;

  -- CC2115
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2115', 'Carlos Arroyo', false, 'completed', false, 0.84, 0.00, 0, 0.06, 0.90, 0.00, 0, 6, 'lavanderia', '2025-06-16 00:00:00'::timestamptz, '2025-06-16 14:19:00'::timestamptz, '2025-06-16 14:17:00'::timestamptz, '2025-06-16 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.90 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.90, '2025-06-16 14:17:00'::timestamptz); END IF;

  -- CC2116
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2116', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-06-17 00:00:00'::timestamptz, '2025-06-16 15:40:00'::timestamptz, '2025-06-16 14:58:00'::timestamptz, '2025-06-16 14:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-16 14:58:00'::timestamptz); END IF;

  -- CC2117
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2117', 'Leonel Visueti', false, 'completed', false, 0.61, 0.00, 0, 0.04, 0.65, 0.00, 0, 2, '', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 08:36:00'::timestamptz, '2025-06-17 08:35:00'::timestamptz, '2025-06-17 08:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.65, '2025-06-17 08:35:00'::timestamptz); END IF;

  -- CC2118
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2118', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 10:29:00'::timestamptz, '2025-06-17 10:29:00'::timestamptz, '2025-06-17 10:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-17 10:29:00'::timestamptz); END IF;

  -- CC2119
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2119', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 11:58:00'::timestamptz, '2025-06-17 10:58:00'::timestamptz, '2025-06-17 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-17 10:58:00'::timestamptz); END IF;

  -- CC2120
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2120', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 13:49:00'::timestamptz, '2025-06-17 11:58:00'::timestamptz, '2025-06-17 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-06-17 11:58:00'::timestamptz); END IF;

  -- CC2121
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2121', 'Cliente Lavandería', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, 'Lavandería', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 13:49:00'::timestamptz, '2025-06-17 11:59:00'::timestamptz, '2025-06-17 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-06-17 11:59:00'::timestamptz); END IF;

  -- CC2122
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 145;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2122', 'Emma Ducreux', false, 'completed', false, 8.88, 0.00, 0, 0.62, 9.50, 0.00, 0, 2, '', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 15:23:00'::timestamptz, '2025-06-17 14:00:00'::timestamptz, '2025-06-17 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.50, '2025-06-17 14:00:00'::timestamptz); END IF;

  -- CC2123
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2123', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 27.34, 0.00, 0, 1.91, 29.25, 11.70, 3, 1, 'Salón', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 15:14:00'::timestamptz, '2025-06-17 15:14:00'::timestamptz, '2025-06-17 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.25, '2025-06-17 15:14:00'::timestamptz); END IF;

  -- CC2124
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2124', 'Karla Garibaldi', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-06-17 00:00:00'::timestamptz, '2025-06-17 16:20:00'::timestamptz, '2025-06-17 15:24:00'::timestamptz, '2025-06-17 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-06-17 15:24:00'::timestamptz); END IF;

  -- CC2125
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 169;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2125', 'Juan Martinez', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 8.80, 2, 1, 'lavanderia', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 16:40:00'::timestamptz, '2025-06-18 12:43:00'::timestamptz, '2025-06-18 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.00, '2025-06-18 12:43:00'::timestamptz); END IF;

  -- CC2126
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2126', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 14:20:00'::timestamptz, '2025-06-18 12:45:00'::timestamptz, '2025-06-18 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-06-18 12:45:00'::timestamptz); END IF;

  -- CC2127
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2127', 'Cliente Lavandería', false, 'completed', false, 10.35, 0.00, 0, 0.65, 11.00, 0.00, 0, 6, 'Lavandería', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 14:20:00'::timestamptz, '2025-06-18 12:46:00'::timestamptz, '2025-06-18 12:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2025-06-18 12:46:00'::timestamptz); END IF;

  -- CC2128
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2128', 'Leonel Visueti', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, '', '2025-06-19 00:00:00'::timestamptz, '2025-06-18 16:50:00'::timestamptz, '2025-06-18 16:11:00'::timestamptz, '2025-06-18 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-06-18 16:11:00'::timestamptz); END IF;

  -- CC2129
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2129', 'Cliente Lavandería', false, 'completed', false, 13.58, 0.00, 0, 0.92, 14.50, 0.00, 0, 9, 'Lavandería', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 16:50:00'::timestamptz, '2025-06-18 16:12:00'::timestamptz, '2025-06-18 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.50, '2025-06-18 16:12:00'::timestamptz); END IF;

  -- CC2130
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2130', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 16:40:00'::timestamptz, '2025-06-18 16:25:00'::timestamptz, '2025-06-18 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-18 16:25:00'::timestamptz); END IF;

  -- CC2131
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2131', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 16:40:00'::timestamptz, '2025-06-18 16:39:00'::timestamptz, '2025-06-18 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-18 16:39:00'::timestamptz); END IF;

  -- CC2132
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2132', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-18 00:00:00'::timestamptz, '2025-06-18 17:38:00'::timestamptz, '2025-06-18 17:08:00'::timestamptz, '2025-06-18 17:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-18 17:08:00'::timestamptz); END IF;

  -- CC2133
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2133', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-19 00:00:00'::timestamptz, '2025-06-19 11:46:00'::timestamptz, '2025-06-19 11:45:00'::timestamptz, '2025-06-19 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-19 11:45:00'::timestamptz); END IF;

  -- CC2134
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2134', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-19 00:00:00'::timestamptz, '2025-06-19 13:08:00'::timestamptz, '2025-06-19 11:46:00'::timestamptz, '2025-06-19 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-06-19 11:46:00'::timestamptz); END IF;

  -- CC2135
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2135', 'German Alveo', false, 'completed', false, 51.17, 0.00, 0, 3.58, 54.75, 21.90, 7, 1, 'Lavandería', '2025-06-19 00:00:00'::timestamptz, '2025-06-19 16:03:00'::timestamptz, '2025-06-19 11:50:00'::timestamptz, '2025-06-19 11:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 54.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 54.75, '2025-06-19 11:50:00'::timestamptz); END IF;

  -- CC2136
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2136', 'German Alveo', false, 'completed', false, 7.36, 0.00, 0, 0.52, 7.88, 3.15, 1, 1, 'Lavandería', '2025-06-19 00:00:00'::timestamptz, '2025-06-19 16:03:00'::timestamptz, '2025-06-19 11:51:00'::timestamptz, '2025-06-19 11:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.88, '2025-06-19 11:51:00'::timestamptz); END IF;

  -- CC2137
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2137', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-19 00:00:00'::timestamptz, '2025-06-19 14:46:00'::timestamptz, '2025-06-19 13:09:00'::timestamptz, '2025-06-19 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-19 13:09:00'::timestamptz); END IF;

  -- CC2138
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2138', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 10:09:00'::timestamptz, '2025-06-20 08:56:00'::timestamptz, '2025-06-20 08:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-20 08:56:00'::timestamptz); END IF;

  -- CC2139
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2139', 'Cliente Lavandería', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 11:58:00'::timestamptz, '2025-06-20 09:35:00'::timestamptz, '2025-06-20 09:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-06-20 09:35:00'::timestamptz); END IF;

  -- CC2140
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2140', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 11:58:00'::timestamptz, '2025-06-20 09:36:00'::timestamptz, '2025-06-20 09:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-20 09:36:00'::timestamptz); END IF;

  -- CC2141
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2141', 'Cliente Lavandería', false, 'completed', false, 0.61, 0.00, 0, 0.04, 0.65, 0.00, 0, 2, 'Lavandería', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 09:37:00'::timestamptz, '2025-06-20 09:37:00'::timestamptz, '2025-06-20 09:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.65, '2025-06-20 09:37:00'::timestamptz); END IF;

  -- CC2142
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2142', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 15:51:00'::timestamptz, '2025-06-20 13:44:00'::timestamptz, '2025-06-20 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-06-20 13:44:00'::timestamptz); END IF;

  -- CC2143
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2143', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-20 00:00:00'::timestamptz, '2025-06-20 16:36:00'::timestamptz, '2025-06-20 14:51:00'::timestamptz, '2025-06-20 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-20 14:51:00'::timestamptz); END IF;

  -- CC2144
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 170;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2144', 'Carlos Moreno', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 10:20:00'::timestamptz, '2025-06-21 08:06:00'::timestamptz, '2025-06-21 08:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-06-21 08:06:00'::timestamptz); END IF;

  -- CC2145
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2145', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 10:20:00'::timestamptz, '2025-06-21 08:23:00'::timestamptz, '2025-06-21 08:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-21 08:23:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 4: Imported orders 1501 to 2000';
END $$;
