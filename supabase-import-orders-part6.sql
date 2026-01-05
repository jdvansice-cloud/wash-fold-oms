-- =============================================
-- CleanCloud Orders Import - Part 6 of 7
-- Orders 2501 to 3000 (of 3472)
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


  -- CC2649
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2649', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, '', '2025-09-02 00:00:00'::timestamptz, '2025-09-01 12:21:00'::timestamptz, '2025-09-01 12:20:00'::timestamptz, '2025-09-01 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-01 12:20:00'::timestamptz); END IF;

  -- CC2650
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2650', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 00:00:00'::timestamptz, '2025-09-01 12:20:00'::timestamptz, '2025-09-01 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-01 12:20:00'::timestamptz); END IF;

  -- CC2651
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2651', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 12:52:00'::timestamptz, '2025-09-01 12:37:00'::timestamptz, '2025-09-01 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-01 12:37:00'::timestamptz); END IF;

  -- CC2652
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2652', 'Josue Rosales', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 3.60, 2, 5, 'lavanderia', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 14:52:00'::timestamptz, '2025-09-01 12:44:00'::timestamptz, '2025-09-01 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-09-01 12:44:00'::timestamptz); END IF;

  -- CC2653
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2653', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 13:22:00'::timestamptz, '2025-09-01 12:52:00'::timestamptz, '2025-09-01 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-01 12:52:00'::timestamptz); END IF;

  -- CC2654
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2654', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 14:52:00'::timestamptz, '2025-09-01 13:23:00'::timestamptz, '2025-09-01 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-01 13:23:00'::timestamptz); END IF;

  -- CC2655
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2655', 'Lina Perez', false, 'completed', false, 23.79, 2.00, 0, 1.21, 25.00, 0.00, 0, 17, 'Lavandería', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 15:14:00'::timestamptz, '2025-09-01 15:02:00'::timestamptz, '2025-09-01 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 25.00, '2025-09-01 15:02:00'::timestamptz); END IF;

  -- CC2656
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2656', 'Byron Moreno', false, 'completed', false, 6.30, 0.00, 0, 0.44, 6.74, 3.85, 1, 1, 'lavanderia', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 15:17:00'::timestamptz, '2025-09-01 15:16:00'::timestamptz, '2025-09-01 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.74, '2025-09-01 15:16:00'::timestamptz); END IF;

  -- CC2657
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2657', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 15:43:00'::timestamptz, '2025-09-01 15:41:00'::timestamptz, '2025-09-01 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-01 15:41:00'::timestamptz); END IF;

  -- CC2658
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2658', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-02 00:00:00'::timestamptz, '2025-09-01 15:50:00'::timestamptz, '2025-09-01 15:43:00'::timestamptz, '2025-09-01 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-01 15:43:00'::timestamptz); END IF;

  -- CC2659
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2659', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 16:42:00'::timestamptz, '2025-09-01 16:41:00'::timestamptz, '2025-09-01 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-09-01 16:41:00'::timestamptz); END IF;

  -- CC2660
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2660', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 17:29:00'::timestamptz, '2025-09-01 17:28:00'::timestamptz, '2025-09-01 17:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-01 17:28:00'::timestamptz); END IF;

  -- CC2661
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2661', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-02 00:00:00'::timestamptz, '2025-09-02 10:13:00'::timestamptz, '2025-09-02 08:26:00'::timestamptz, '2025-09-02 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-02 08:26:00'::timestamptz); END IF;

  -- CC2662
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2662', 'Juan David VanSice', false, 'completed', false, 0.00, 31.00, 0, 0.00, 0.00, 12.40, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-09-02 00:00:00'::timestamptz, '2025-09-02 16:27:00'::timestamptz, '2025-09-02 10:11:00'::timestamptz, '2025-09-02 10:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-09-02 10:11:00'::timestamptz); END IF;

  -- CC2663
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 74;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2663', 'Cristina Lau', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-09-02 00:00:00'::timestamptz, '2025-09-02 16:27:00'::timestamptz, '2025-09-02 13:31:00'::timestamptz, '2025-09-02 13:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-02 13:31:00'::timestamptz); END IF;

  -- CC2664
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2664', 'Alvaro Martinez', false, 'completed', false, 34.00, 0.00, 0, 2.38, 36.38, 14.55, 3, 1, 'lavanderia', '2025-09-02 00:00:00'::timestamptz, '2025-09-04 16:53:00'::timestamptz, '2025-09-02 16:15:00'::timestamptz, '2025-09-02 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 36.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 36.38, '2025-09-02 16:15:00'::timestamptz); END IF;

  -- CC2665
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2665', 'Leonel Visueti', false, 'completed', false, 1.47, 0.00, 0, 0.03, 1.50, 0.00, 0, 2, '', '2025-09-03 00:00:00'::timestamptz, '2025-09-03 16:45:00'::timestamptz, '2025-09-03 10:14:00'::timestamptz, '2025-09-03 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-09-03 10:14:00'::timestamptz); END IF;

  -- CC2666
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2666', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-09-03 00:00:00'::timestamptz, '2025-09-03 16:46:00'::timestamptz, '2025-09-03 16:05:00'::timestamptz, '2025-09-03 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-09-03 16:05:00'::timestamptz); END IF;

  -- CC2667
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2667', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-09-03 00:00:00'::timestamptz, '2025-09-03 16:46:00'::timestamptz, '2025-09-03 16:05:00'::timestamptz, '2025-09-03 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-03 16:05:00'::timestamptz); END IF;

  -- CC2668
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2668', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-09-03 00:00:00'::timestamptz, '2025-09-04 08:00:00'::timestamptz, '2025-09-03 16:08:00'::timestamptz, '2025-09-03 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-03 16:08:00'::timestamptz); END IF;

  -- CC2669
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2669', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-09-03 00:00:00'::timestamptz, '2025-09-04 08:00:00'::timestamptz, '2025-09-03 16:34:00'::timestamptz, '2025-09-03 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-03 16:34:00'::timestamptz); END IF;

  -- CC2670
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2670', 'German Alveo', false, 'completed', false, 40.31, 0.00, 0, 2.82, 43.13, 17.25, 7, 1, 'Lavandería', '2025-09-04 00:00:00'::timestamptz, '2025-09-04 13:54:00'::timestamptz, '2025-09-04 11:45:00'::timestamptz, '2025-09-04 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 43.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 43.13, '2025-09-04 11:45:00'::timestamptz); END IF;

  -- CC2671
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2671', 'Leonel Visueti', false, 'completed', false, 3.99, 0.00, 0, 0.26, 4.25, 0.00, 0, 3, '', '2025-09-04 00:00:00'::timestamptz, '2025-09-04 12:32:00'::timestamptz, '2025-09-04 12:28:00'::timestamptz, '2025-09-04 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2025-09-04 12:28:00'::timestamptz); END IF;

  -- CC2672
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 228;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2672', 'Suri Morales', false, 'completed', false, 11.96, 0.00, 0, 0.79, 12.75, 0.00, 0, 9, 'lavanderia', '2025-09-04 00:00:00'::timestamptz, '2025-09-04 12:32:00'::timestamptz, '2025-09-04 12:29:00'::timestamptz, '2025-09-04 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.75, '2025-09-04 12:29:00'::timestamptz); END IF;

  -- CC2673
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 17;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2673', 'Enrique Martínez', false, 'completed', false, 72.24, 0.00, 0, 4.64, 76.88, 28.35, 4, 7, '0', '2025-09-04 00:00:00'::timestamptz, '2025-09-04 16:33:00'::timestamptz, '2025-09-04 16:16:00'::timestamptz, '2025-09-04 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 76.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 76.88, '2025-09-04 16:16:00'::timestamptz); END IF;

  -- CC2674
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2674', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-09-04 00:00:00'::timestamptz, '2025-09-04 00:00:00'::timestamptz, '2025-09-04 16:19:00'::timestamptz, '2025-09-04 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-09-04 16:19:00'::timestamptz); END IF;

  -- CC2675
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 221;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2675', 'Yanis Hernandez', false, 'completed', false, 15.95, 0.00, 0, 1.05, 17.00, 0.00, 0, 9, 'lavanderia', '2025-09-05 00:00:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz, '2025-09-05 10:52:00'::timestamptz, '2025-09-05 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.00, '2025-09-05 10:52:00'::timestamptz); END IF;

  -- CC2676
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2676', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-09-05 00:00:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz, '2025-09-05 12:16:00'::timestamptz, '2025-09-05 12:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-05 12:16:00'::timestamptz); END IF;

  -- CC2677
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2677', 'Alberto Campell', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'lavanderia', '2025-09-05 00:00:00'::timestamptz, '2025-09-05 00:00:00'::timestamptz, '2025-09-05 15:26:00'::timestamptz, '2025-09-05 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-09-05 15:26:00'::timestamptz); END IF;

  -- CC2678
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2678', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-09-05 00:00:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz, '2025-09-05 15:57:00'::timestamptz, '2025-09-05 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-05 15:57:00'::timestamptz); END IF;

  -- CC2679
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2679', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-05 00:00:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz, '2025-09-05 16:36:00'::timestamptz, '2025-09-05 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-05 16:36:00'::timestamptz); END IF;

  -- CC2680
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2680', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.90, 1, 1, '', '2025-09-05 00:00:00'::timestamptz, '2025-09-06 10:36:00'::timestamptz, '2025-09-05 16:56:00'::timestamptz, '2025-09-05 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-05 16:56:00'::timestamptz); END IF;

  -- CC2681
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2681', 'Cliente Lavandería', false, 'completed', false, 1.07, 0.00, 0, 0.08, 1.15, 0.00, 0, 3, 'Lavandería', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 08:30:00'::timestamptz, '2025-09-06 08:27:00'::timestamptz, '2025-09-06 08:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.15, '2025-09-06 08:27:00'::timestamptz); END IF;

  -- CC2682
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2682', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 08:30:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz, '2025-09-06 08:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-06 08:28:00'::timestamptz); END IF;

  -- CC2683
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2683', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 09:57:00'::timestamptz, '2025-09-06 08:53:00'::timestamptz, '2025-09-06 08:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-06 08:53:00'::timestamptz); END IF;

  -- CC2684
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2684', 'Israel Rentería', false, 'completed', false, 18.88, 0.00, 0, 1.25, 20.13, 7.65, 1, 2, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 14:11:00'::timestamptz, '2025-09-06 09:34:00'::timestamptz, '2025-09-06 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.13, '2025-09-06 09:34:00'::timestamptz); END IF;

  -- CC2685
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 155;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2685', 'Julissa', false, 'completed', false, 10.70, 0.00, 0, 0.68, 11.38, 4.15, 1, 2, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 11:42:00'::timestamptz, '2025-09-06 09:41:00'::timestamptz, '2025-09-06 09:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.38, '2025-09-06 09:41:00'::timestamptz); END IF;

  -- CC2686
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2686', 'Virginia Gonzalez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 09:57:00'::timestamptz, '2025-09-06 09:51:00'::timestamptz, '2025-09-06 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-06 09:51:00'::timestamptz); END IF;

  -- CC2687
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2687', 'Cesar Malave', false, 'completed', false, 12.21, 2.00, 0, 0.79, 13.00, 0.00, 0, 8, 'lavanderia', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 10:35:00'::timestamptz, '2025-09-06 10:29:00'::timestamptz, '2025-09-06 10:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-09-06 10:29:00'::timestamptz); END IF;

  -- CC2688
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2688', 'Leonel Willson', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 6, '0', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 10:36:00'::timestamptz, '2025-09-06 10:34:00'::timestamptz, '2025-09-06 10:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-06 10:34:00'::timestamptz); END IF;

  -- CC2689
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2689', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 10:54:00'::timestamptz, '2025-09-06 10:50:00'::timestamptz, '2025-09-06 10:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-06 10:50:00'::timestamptz); END IF;

  -- CC2690
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 229;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2690', 'Tony Parra', false, 'completed', false, 33.53, 0.00, 0, 2.35, 35.88, 14.35, 3, 1, 'lavanderia', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 14:30:00'::timestamptz, '2025-09-06 12:04:00'::timestamptz, '2025-09-06 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.88, '2025-09-06 12:04:00'::timestamptz); END IF;

  -- CC2691
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 230;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2691', 'Doraluz Fernandez', false, 'completed', false, 18.88, 0.00, 0, 1.25, 20.13, 7.65, 1, 2, 'lavanderia', '2025-09-06 00:00:00'::timestamptz, '2025-09-09 12:23:00'::timestamptz, '2025-09-06 12:26:00'::timestamptz, '2025-09-06 12:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.13, '2025-09-06 12:26:00'::timestamptz); END IF;

  -- CC2692
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2692', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 16:57:00'::timestamptz, '2025-09-06 15:11:00'::timestamptz, '2025-09-06 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-06 15:11:00'::timestamptz); END IF;

  -- CC2693
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2693', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 16:57:00'::timestamptz, '2025-09-06 16:54:00'::timestamptz, '2025-09-06 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-06 16:54:00'::timestamptz); END IF;

  -- CC2694
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2694', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-06 00:00:00'::timestamptz, '2025-09-06 16:59:00'::timestamptz, '2025-09-06 16:58:00'::timestamptz, '2025-09-06 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-06 16:58:00'::timestamptz); END IF;

  -- CC2695
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2695', 'Byron Moreno', false, 'completed', false, 4.75, 0.00, 0, 0.33, 5.08, 2.90, 1, 1, 'lavanderia', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 09:08:00'::timestamptz, '2025-09-08 09:07:00'::timestamptz, '2025-09-08 09:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.08 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.08, '2025-09-08 09:07:00'::timestamptz); END IF;

  -- CC2696
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2696', 'Yariela Phillips', false, 'completed', false, 15.95, 0.00, 0, 1.05, 17.00, 0.00, 0, 12, 'lavanderia', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 11:10:00'::timestamptz, '2025-09-08 09:15:00'::timestamptz, '2025-09-08 09:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.00, '2025-09-08 09:15:00'::timestamptz); END IF;

  -- CC2697
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2697', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 12:34:00'::timestamptz, '2025-09-08 11:09:00'::timestamptz, '2025-09-08 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-08 11:09:00'::timestamptz); END IF;

  -- CC2698
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2698', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 12:34:00'::timestamptz, '2025-09-08 11:10:00'::timestamptz, '2025-09-08 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-08 11:10:00'::timestamptz); END IF;

  -- CC2699
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2699', 'Juan David VanSice', false, 'completed', false, 0.00, 19.13, 0, 0.00, 0.00, 7.65, 1, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-09-08 00:00:00'::timestamptz, '2025-09-09 12:21:00'::timestamptz, '2025-09-08 13:43:00'::timestamptz, '2025-09-08 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-09-08 13:43:00'::timestamptz); END IF;

  -- CC2700
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2700', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 13:53:00'::timestamptz, '2025-09-08 13:51:00'::timestamptz, '2025-09-08 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-08 13:51:00'::timestamptz); END IF;

  -- CC2701
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2701', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 00:00:00'::timestamptz, '2025-09-08 13:52:00'::timestamptz, '2025-09-08 13:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-08 13:52:00'::timestamptz); END IF;

  -- CC2703
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2703', 'Oscar Oropeza', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'Lavandería', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 16:09:00'::timestamptz, '2025-09-08 14:48:00'::timestamptz, '2025-09-08 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-09-08 14:48:00'::timestamptz); END IF;

  -- CC2704
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2704', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 16:09:00'::timestamptz, '2025-09-08 16:04:00'::timestamptz, '2025-09-08 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-08 16:04:00'::timestamptz); END IF;

  -- CC2705
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2705', 'Evelyn', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, 'Salón', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 16:28:00'::timestamptz, '2025-09-08 16:26:00'::timestamptz, '2025-09-08 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-08 16:26:00'::timestamptz); END IF;

  -- CC2706
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2706', 'Evelyn', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, 'Salón', '2025-09-08 00:00:00'::timestamptz, '2025-09-08 16:28:00'::timestamptz, '2025-09-08 16:28:00'::timestamptz, '2025-09-08 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-09-08 16:28:00'::timestamptz); END IF;

  -- CC2707
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2707', 'Karla Garibaldi', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 12:21:00'::timestamptz, '2025-09-09 10:47:00'::timestamptz, '2025-09-09 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-09 10:47:00'::timestamptz); END IF;

  -- CC2708
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2708', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 15:41:00'::timestamptz, '2025-09-09 15:00:00'::timestamptz, '2025-09-09 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-09 15:00:00'::timestamptz); END IF;

  -- CC2709
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2709', 'Rolando Mendoza', false, 'completed', false, 13.67, 0.00, 0, 0.96, 14.63, 5.85, 1, 1, 'lavanderia', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 15:05:00'::timestamptz, '2025-09-09 15:04:00'::timestamptz, '2025-09-09 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.63, '2025-09-09 15:04:00'::timestamptz); END IF;

  -- CC2710
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2710', 'Karla Garibaldi', false, 'completed', false, 32.32, 0.00, 0, 2.12, 34.44, 13.05, 2, 7, 'Lavandería', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 15:40:00'::timestamptz, '2025-09-09 15:36:00'::timestamptz, '2025-09-09 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.44 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.44, '2025-09-09 15:36:00'::timestamptz); END IF;

  -- CC2711
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2711', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 16:40:00'::timestamptz, '2025-09-09 15:50:00'::timestamptz, '2025-09-09 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-09 15:50:00'::timestamptz); END IF;

  -- CC2712
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2712', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 16:42:00'::timestamptz, '2025-09-09 16:03:00'::timestamptz, '2025-09-09 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-09 16:03:00'::timestamptz); END IF;

  -- CC2713
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2713', 'Alberto Campell', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'lavanderia', '2025-09-09 00:00:00'::timestamptz, '2025-09-09 00:00:00'::timestamptz, '2025-09-09 16:27:00'::timestamptz, '2025-09-09 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-09-09 16:27:00'::timestamptz); END IF;

  -- CC2714
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 232;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2714', 'Kenneth Caubble', false, 'completed', false, 28.39, 0.00, 0, 1.99, 30.38, 8.15, 2, 3, 'Lavanderia', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 08:47:00'::timestamptz, '2025-09-10 08:16:00'::timestamptz, '2025-09-10 08:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.38, '2025-09-10 08:16:00'::timestamptz); END IF;

  -- CC2715
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2715', 'Leonel Visueti', false, 'completed', false, 19.95, 0.00, 0, 1.05, 21.00, 0.00, 0, 13, '', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 11:31:00'::timestamptz, '2025-09-10 09:56:00'::timestamptz, '2025-09-10 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 21.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 21.00, '2025-09-10 09:56:00'::timestamptz); END IF;

  -- CC2716
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2716', 'Byron Moreno', false, 'completed', false, 7.28, 0.00, 0, 0.51, 7.79, 4.45, 1, 1, 'lavanderia', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 11:44:00'::timestamptz, '2025-09-10 11:31:00'::timestamptz, '2025-09-10 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.79, '2025-09-10 11:31:00'::timestamptz); END IF;

  -- CC2717
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2717', 'Alberto Campell', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, 'lavanderia', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 00:00:00'::timestamptz, '2025-09-10 15:14:00'::timestamptz, '2025-09-10 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-10 15:14:00'::timestamptz); END IF;

  -- CC2718
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2718', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 15:40:00'::timestamptz, '2025-09-10 15:39:00'::timestamptz, '2025-09-10 15:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-09-10 15:39:00'::timestamptz); END IF;

  -- CC2719
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2719', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 15:41:00'::timestamptz, '2025-09-10 15:41:00'::timestamptz, '2025-09-10 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-10 15:41:00'::timestamptz); END IF;

  -- CC2720
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2720', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, '', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 16:43:00'::timestamptz, '2025-09-10 16:42:00'::timestamptz, '2025-09-10 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-09-10 16:42:00'::timestamptz); END IF;

  -- CC2721
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2721', 'Alvaro Martinez', false, 'completed', false, 28.50, 0.00, 0, 2.00, 30.50, 12.20, 2, 1, 'lavanderia', '2025-09-10 00:00:00'::timestamptz, '2025-09-11 16:31:00'::timestamptz, '2025-09-10 16:48:00'::timestamptz, '2025-09-10 16:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.50, '2025-09-10 16:48:00'::timestamptz); END IF;

  -- CC2722
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2722', 'Lina Perez', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, 'Lavandería', '2025-09-10 00:00:00'::timestamptz, '2025-09-10 17:55:00'::timestamptz, '2025-09-10 17:34:00'::timestamptz, '2025-09-10 17:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-10 17:34:00'::timestamptz); END IF;

  -- CC2723
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2723', 'German Alveo', false, 'completed', false, 48.72, 0.00, 0, 3.41, 52.13, 20.85, 6, 1, 'Lavandería', '2025-09-11 00:00:00'::timestamptz, '2025-09-11 14:09:00'::timestamptz, '2025-09-11 08:21:00'::timestamptz, '2025-09-11 08:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 52.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 52.13, '2025-09-11 08:21:00'::timestamptz); END IF;

  -- CC2724
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 233;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2724', 'Ilma Beluche', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'lavanderia', '2025-09-11 00:00:00'::timestamptz, '2025-09-11 16:17:00'::timestamptz, '2025-09-11 12:30:00'::timestamptz, '2025-09-11 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-09-11 12:30:00'::timestamptz); END IF;

  -- CC2725
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 233;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2725', 'Ilma Beluche', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'lavanderia', '2025-09-11 00:00:00'::timestamptz, '2025-09-11 00:00:00'::timestamptz, '2025-09-11 12:38:00'::timestamptz, '2025-09-11 12:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-09-11 12:38:00'::timestamptz); END IF;

  -- CC2726
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 234;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2726', 'Ezequiel Soto', false, 'completed', false, 16.01, 0.00, 0, 1.12, 17.13, 6.85, 1, 1, 'lavanderia', '2025-09-11 00:00:00'::timestamptz, '2025-09-11 15:57:00'::timestamptz, '2025-09-11 13:48:00'::timestamptz, '2025-09-11 13:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.13, '2025-09-11 13:48:00'::timestamptz); END IF;

  -- CC2727
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2727', 'Juan David VanSice', false, 'completed', false, 0.00, 32.50, 0, 0.00, 0.00, 13.00, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-09-11 00:00:00'::timestamptz, '2025-09-12 10:47:00'::timestamptz, '2025-09-11 16:15:00'::timestamptz, '2025-09-11 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-09-11 16:15:00'::timestamptz); END IF;

  -- CC2728
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2728', 'Paula Perez', false, 'completed', false, 27.22, 0.00, 0, 1.91, 29.13, 2.65, 1, 13, 'lavanderia', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 13:33:00'::timestamptz, '2025-09-12 07:45:00'::timestamptz, '2025-09-12 07:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.13, '2025-09-12 07:45:00'::timestamptz); END IF;

  -- CC2729
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2729', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 10:47:00'::timestamptz, '2025-09-12 10:46:00'::timestamptz, '2025-09-12 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-12 10:46:00'::timestamptz); END IF;

  -- CC2730
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 212;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2730', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.35, 1, 1, 'lavanderia', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 14:24:00'::timestamptz, '2025-09-12 11:55:00'::timestamptz, '2025-09-12 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-12 11:55:00'::timestamptz); END IF;

  -- CC2731
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2731', 'Leonel Visueti', false, 'completed', false, 2.34, 0.00, 0, 0.16, 2.50, 0.00, 0, 2, '', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 13:32:00'::timestamptz, '2025-09-12 13:31:00'::timestamptz, '2025-09-12 13:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.50, '2025-09-12 13:31:00'::timestamptz); END IF;

  -- CC2732
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2732', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 14:24:00'::timestamptz, '2025-09-12 13:32:00'::timestamptz, '2025-09-12 13:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-12 13:32:00'::timestamptz); END IF;

  -- CC2733
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2733', 'Sandra Medina', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 16:22:00'::timestamptz, '2025-09-12 14:37:00'::timestamptz, '2025-09-12 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-12 14:37:00'::timestamptz); END IF;

  -- CC2734
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2734', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 16:55:00'::timestamptz, '2025-09-12 16:25:00'::timestamptz, '2025-09-12 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-12 16:25:00'::timestamptz); END IF;

  -- CC2735
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2735', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 16:42:00'::timestamptz, '2025-09-12 16:41:00'::timestamptz, '2025-09-12 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-12 16:41:00'::timestamptz); END IF;

  -- CC2736
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2736', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-09-12 00:00:00'::timestamptz, '2025-09-12 16:54:00'::timestamptz, '2025-09-12 16:53:00'::timestamptz, '2025-09-12 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-12 16:53:00'::timestamptz); END IF;

  -- CC2737
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2737', 'Julissa Rivera', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.35, 1, 2, 'lavanderia', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 10:25:00'::timestamptz, '2025-09-13 08:07:00'::timestamptz, '2025-09-13 08:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-09-13 08:07:00'::timestamptz); END IF;

  -- CC2738
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2738', 'Israel Rentería', false, 'completed', false, 15.49, 0.00, 0, 1.01, 16.50, 6.20, 1, 2, '', '2025-09-14 00:00:00'::timestamptz, '2025-09-13 10:25:00'::timestamptz, '2025-09-13 08:13:00'::timestamptz, '2025-09-13 08:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.50, '2025-09-13 08:13:00'::timestamptz); END IF;

  -- CC2739
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2739', 'Fabio Nunez', false, 'completed', false, 11.21, 2.00, 0, 0.79, 12.00, 0.00, 0, 7, 'lavanderia', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 10:25:00'::timestamptz, '2025-09-13 10:16:00'::timestamptz, '2025-09-13 10:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-09-13 10:16:00'::timestamptz); END IF;

  -- CC2740
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2740', 'Cesar Malave', false, 'completed', false, 16.95, 0.00, 0, 1.05, 18.00, 0.00, 0, 10, 'lavanderia', '2025-09-14 00:00:00'::timestamptz, '2025-09-13 11:16:00'::timestamptz, '2025-09-13 11:14:00'::timestamptz, '2025-09-13 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-09-13 11:14:00'::timestamptz); END IF;

  -- CC2741
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 188;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2741', 'Librada Mendoza', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, 'lavandria', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 11:17:00'::timestamptz, '2025-09-13 11:17:00'::timestamptz, '2025-09-13 11:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-09-13 11:17:00'::timestamptz); END IF;

  -- CC2742
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2742', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 6.78, 0.00, 0, 0.47, 7.25, 2.90, 1, 1, 'Salón', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 11:49:00'::timestamptz, '2025-09-13 11:35:00'::timestamptz, '2025-09-13 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.25, '2025-09-13 11:35:00'::timestamptz); END IF;

  -- CC2743
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2743', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 13:09:00'::timestamptz, '2025-09-13 11:56:00'::timestamptz, '2025-09-13 11:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-13 11:56:00'::timestamptz); END IF;

  -- CC2744
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2744', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 13:09:00'::timestamptz, '2025-09-13 11:57:00'::timestamptz, '2025-09-13 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-09-13 11:57:00'::timestamptz); END IF;

  -- CC2745
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2745', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 13:10:00'::timestamptz, '2025-09-13 13:07:00'::timestamptz, '2025-09-13 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-13 13:07:00'::timestamptz); END IF;

  -- CC2746
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2746', 'Gustavo Cumbrera', false, 'completed', false, 14.95, 2.00, 0, 1.05, 16.00, 0.00, 0, 9, 'lavanderia', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 14:26:00'::timestamptz, '2025-09-13 13:48:00'::timestamptz, '2025-09-13 13:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-09-13 13:48:00'::timestamptz); END IF;

  -- CC2747
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2747', 'Leonel Visueti', false, 'completed', false, 16.21, 0.00, 0, 0.79, 17.00, 0.00, 0, 11, '', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 14:30:00'::timestamptz, '2025-09-13 14:25:00'::timestamptz, '2025-09-13 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.00, '2025-09-13 14:25:00'::timestamptz); END IF;

  -- CC2748
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2748', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 15:50:00'::timestamptz, '2025-09-13 14:34:00'::timestamptz, '2025-09-13 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-09-13 14:34:00'::timestamptz); END IF;

  -- CC2749
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2749', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 15:50:00'::timestamptz, '2025-09-13 14:40:00'::timestamptz, '2025-09-13 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-13 14:40:00'::timestamptz); END IF;

  -- CC2750
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2750', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 7, '', '2025-09-13 00:00:00'::timestamptz, '2025-09-13 15:50:00'::timestamptz, '2025-09-13 15:02:00'::timestamptz, '2025-09-13 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-09-13 15:02:00'::timestamptz); END IF;

  -- CC2751
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 235;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2751', 'Tamika Johnson', false, 'completed', false, 12.40, 0.00, 0, 0.73, 13.13, 4.45, 1, 3, 'lavanderia', '2025-09-15 00:00:00'::timestamptz, '2025-09-16 10:50:00'::timestamptz, '2025-09-15 08:54:00'::timestamptz, '2025-09-15 08:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.13, '2025-09-15 08:54:00'::timestamptz); END IF;

  -- CC2752
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2752', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 14:07:00'::timestamptz, '2025-09-15 14:06:00'::timestamptz, '2025-09-15 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-15 14:06:00'::timestamptz); END IF;

  -- CC2753
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2753', 'Lina Perez', false, 'completed', false, 35.11, 4.00, 0, 1.89, 37.00, 0.00, 0, 25, 'Lavandería', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 15:21:00'::timestamptz, '2025-09-15 14:08:00'::timestamptz, '2025-09-15 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 37.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 37.00, '2025-09-15 14:08:00'::timestamptz); END IF;

  -- CC2754
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2754', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 15:21:00'::timestamptz, '2025-09-15 15:21:00'::timestamptz, '2025-09-15 15:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-15 15:21:00'::timestamptz); END IF;

  -- CC2755
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2755', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 00:00:00'::timestamptz, '2025-09-15 15:42:00'::timestamptz, '2025-09-15 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-15 15:42:00'::timestamptz); END IF;

  -- CC2756
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2756', 'Leonel Visueti', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 6, '', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 16:01:00'::timestamptz, '2025-09-15 15:55:00'::timestamptz, '2025-09-15 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-09-15 15:55:00'::timestamptz); END IF;

  -- CC2757
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2757', 'Evelyn', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 5, 'Salón', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 17:19:00'::timestamptz, '2025-09-15 16:46:00'::timestamptz, '2025-09-15 16:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-09-15 16:46:00'::timestamptz); END IF;

  -- CC2758
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2758', 'Oscar Oropeza', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'Lavandería', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 17:20:00'::timestamptz, '2025-09-15 17:04:00'::timestamptz, '2025-09-15 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-09-15 17:04:00'::timestamptz); END IF;

  -- CC2759
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2759', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-15 00:00:00'::timestamptz, '2025-09-15 17:34:00'::timestamptz, '2025-09-15 17:34:00'::timestamptz, '2025-09-15 17:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-15 17:34:00'::timestamptz); END IF;

  -- CC2760
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 235;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2760', 'Tamika Johnson', false, 'completed', false, 9.94, 0.00, 0, 0.56, 10.50, 3.40, 1, 3, 'lavanderia', '2025-09-16 00:00:00'::timestamptz, '2025-09-17 12:27:00'::timestamptz, '2025-09-16 09:08:00'::timestamptz, '2025-09-16 09:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2025-09-16 09:08:00'::timestamptz); END IF;

  -- CC2761
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2761', 'Rolando Mendoza', false, 'completed', false, 25.70, 0.00, 0, 1.80, 27.50, 11.00, 2, 1, 'lavanderia', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 16:31:00'::timestamptz, '2025-09-16 09:24:00'::timestamptz, '2025-09-16 09:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 27.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 27.50, '2025-09-16 09:24:00'::timestamptz); END IF;

  -- CC2762
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2762', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 11:50:00'::timestamptz, '2025-09-16 10:57:00'::timestamptz, '2025-09-16 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-16 10:57:00'::timestamptz); END IF;

  -- CC2763
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2763', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 12:25:00'::timestamptz, '2025-09-16 12:24:00'::timestamptz, '2025-09-16 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-09-16 12:24:00'::timestamptz); END IF;

  -- CC2764
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 236;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2764', 'Kerel Morales', false, 'completed', false, 34.74, 0.00, 0, 2.01, 36.75, 12.30, 3, 10, 'lavanderia', '2025-09-16 00:00:00'::timestamptz, '2025-09-17 12:27:00'::timestamptz, '2025-09-16 12:48:00'::timestamptz, '2025-09-16 12:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 36.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 36.75, '2025-09-16 12:48:00'::timestamptz); END IF;

  -- CC2765
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2765', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 13:34:00'::timestamptz, '2025-09-16 13:04:00'::timestamptz, '2025-09-16 13:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-16 13:04:00'::timestamptz); END IF;

  -- CC2766
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 237;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2766', 'Fibergo Telecom S. A', false, 'completed', false, 9.51, 0.00, 0, 0.49, 10.00, 3.00, 1, 5, 'lavanderia', '2025-09-16 00:00:00'::timestamptz, '2025-09-18 18:10:00'::timestamptz, '2025-09-16 13:18:00'::timestamptz, '2025-09-16 13:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-16 13:18:00'::timestamptz); END IF;

  -- CC2767
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2767', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 14:57:00'::timestamptz, '2025-09-16 13:34:00'::timestamptz, '2025-09-16 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-16 13:34:00'::timestamptz); END IF;

  -- CC2768
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2768', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-09-16 00:00:00'::timestamptz, '2025-09-16 16:32:00'::timestamptz, '2025-09-16 15:08:00'::timestamptz, '2025-09-16 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-16 15:08:00'::timestamptz); END IF;

  -- CC2769
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2769', 'German Alveo', false, 'completed', false, 10.51, 0.00, 0, 0.74, 11.25, 4.50, 1, 1, 'Lavandería', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 12:27:00'::timestamptz, '2025-09-17 07:54:00'::timestamptz, '2025-09-17 07:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.25, '2025-09-17 07:54:00'::timestamptz); END IF;

  -- CC2770
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2770', 'Leonel Visueti', false, 'completed', false, 10.88, 0.00, 0, 0.62, 11.50, 0.00, 0, 8, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 12:27:00'::timestamptz, '2025-09-17 11:52:00'::timestamptz, '2025-09-17 11:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.50, '2025-09-17 11:52:00'::timestamptz); END IF;

  -- CC2771
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2771', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 12:27:00'::timestamptz, '2025-09-17 11:54:00'::timestamptz, '2025-09-17 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-17 11:54:00'::timestamptz); END IF;

  -- CC2772
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2772', 'Alberto Campell', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, 'lavanderia', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 00:00:00'::timestamptz, '2025-09-17 11:56:00'::timestamptz, '2025-09-17 11:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-09-17 11:56:00'::timestamptz); END IF;

  -- CC2773
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2773', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 14:37:00'::timestamptz, '2025-09-17 12:26:00'::timestamptz, '2025-09-17 12:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-17 12:26:00'::timestamptz); END IF;

  -- CC2774
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2774', 'German Alveo', false, 'completed', false, 40.65, 0.00, 0, 2.85, 43.50, 17.40, 6, 1, 'Lavandería', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 14:38:00'::timestamptz, '2025-09-17 13:42:00'::timestamptz, '2025-09-17 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 43.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 43.50, '2025-09-17 13:42:00'::timestamptz); END IF;

  -- CC2775
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2775', 'Retail', true, 'completed', false, 2.33, 0.00, 0, 0.02, 2.35, 0.00, 0, 4, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 00:00:00'::timestamptz, '2025-09-17 14:36:00'::timestamptz, '2025-09-17 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.35, '2025-09-17 14:36:00'::timestamptz); END IF;

  -- CC2776
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2776', 'Fany Luz Salon', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 16:40:00'::timestamptz, '2025-09-17 14:37:00'::timestamptz, '2025-09-17 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-17 14:37:00'::timestamptz); END IF;

  -- CC2777
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2777', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 16:40:00'::timestamptz, '2025-09-17 15:28:00'::timestamptz, '2025-09-17 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-17 15:28:00'::timestamptz); END IF;

  -- CC2778
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2778', 'Alberto Campell', true, 'completed', false, 1.06, 0.00, 0, 0.04, 1.10, 0.00, 0, 2, 'lavanderia', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 00:00:00'::timestamptz, '2025-09-17 15:52:00'::timestamptz, '2025-09-17 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-09-17 15:52:00'::timestamptz); END IF;

  -- CC2779
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2779', 'Leonel Visueti', false, 'completed', false, 15.08, 0.00, 0, 0.92, 16.00, 0.00, 0, 9, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 16:40:00'::timestamptz, '2025-09-17 16:39:00'::timestamptz, '2025-09-17 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-09-17 16:39:00'::timestamptz); END IF;

  -- CC2780
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 238;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2780', 'Alexis Rivera', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, 'lavanderia', '2025-09-17 00:00:00'::timestamptz, '2025-09-18 18:10:00'::timestamptz, '2025-09-17 16:54:00'::timestamptz, '2025-09-17 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-17 16:54:00'::timestamptz); END IF;

  -- CC2781
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2781', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 17:03:00'::timestamptz, '2025-09-17 16:59:00'::timestamptz, '2025-09-17 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-17 16:59:00'::timestamptz); END IF;

  -- CC2782
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2782', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 17:03:00'::timestamptz, '2025-09-17 17:02:00'::timestamptz, '2025-09-17 17:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-17 17:02:00'::timestamptz); END IF;

  -- CC2783
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2783', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-09-17 00:00:00'::timestamptz, '2025-09-17 17:04:00'::timestamptz, '2025-09-17 17:03:00'::timestamptz, '2025-09-17 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-09-17 17:03:00'::timestamptz); END IF;

  -- CC2784
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2784', 'German Alveo', false, 'completed', false, 214.49, 0.00, 0, 15.01, 229.50, 3.80, 2, 37, 'Lavandería', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 13:16:00'::timestamptz, '2025-09-18 11:02:00'::timestamptz, '2025-09-18 11:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 229.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 229.50, '2025-09-18 11:02:00'::timestamptz); END IF;

  -- CC2785
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2785', 'Byron Moreno', false, 'completed', false, 7.20, 0.00, 0, 0.50, 7.70, 4.40, 1, 1, 'lavanderia', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 13:17:00'::timestamptz, '2025-09-18 11:43:00'::timestamptz, '2025-09-18 11:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.70, '2025-09-18 11:43:00'::timestamptz); END IF;

  -- CC2786
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2786', 'Leonel Visueti', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, '', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 14:49:00'::timestamptz, '2025-09-18 13:17:00'::timestamptz, '2025-09-18 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-09-18 13:17:00'::timestamptz); END IF;

  -- CC2787
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2787', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 14:50:00'::timestamptz, '2025-09-18 14:22:00'::timestamptz, '2025-09-18 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-18 14:22:00'::timestamptz); END IF;

  -- CC2788
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2788', 'Grethell Guevara', false, 'completed', false, 125.08, 0.00, 0, 7.92, 133.00, 48.40, 11, 13, 'Lavandería', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 18:16:00'::timestamptz, '2025-09-18 14:38:00'::timestamptz, '2025-09-18 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 133.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 133.00, '2025-09-18 14:38:00'::timestamptz); END IF;

  -- CC2789
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2789', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 14:50:00'::timestamptz, '2025-09-18 14:50:00'::timestamptz, '2025-09-18 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-18 14:50:00'::timestamptz); END IF;

  -- CC2790
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2790', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 14:51:00'::timestamptz, '2025-09-18 14:51:00'::timestamptz, '2025-09-18 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-18 14:51:00'::timestamptz); END IF;

  -- CC2792
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2792', 'Juan David VanSice', false, 'completed', false, -5.61, 0.00, 0, -0.39, -6.00, 0.00, 0, 0, '', '2025-09-18 16:11:00'::timestamptz, '2025-09-18 16:11:00'::timestamptz, '2025-09-18 16:11:00'::timestamptz, '2025-09-18 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND -6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', -6.00, '2025-09-18 16:11:00'::timestamptz); END IF;

  -- CC2794
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2794', 'Retail', true, 'completed', false, 4.43, 0.00, 0, 0.07, 4.50, 0.00, 0, 7, '', '2025-09-18 00:00:00'::timestamptz, '2025-09-18 00:00:00'::timestamptz, '2025-09-18 18:20:00'::timestamptz, '2025-09-18 18:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-09-18 18:20:00'::timestamptz); END IF;

  -- CC2795
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 237;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2795', 'Fibergo Telecom S. A', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.30, 1, 1, 'lavanderia', '2025-09-18 00:00:00'::timestamptz, '2025-09-19 16:49:00'::timestamptz, '2025-09-18 18:55:00'::timestamptz, '2025-09-18 18:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-18 18:55:00'::timestamptz); END IF;

  -- CC2796
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2796', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-09-19 00:00:00'::timestamptz, '2025-09-19 16:41:00'::timestamptz, '2025-09-19 10:38:00'::timestamptz, '2025-09-19 10:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-19 10:38:00'::timestamptz); END IF;

  -- CC2797
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2797', 'Israel Rentería', false, 'completed', false, 23.33, 0.00, 0, 1.42, 24.75, 8.70, 2, 4, '', '2025-09-19 00:00:00'::timestamptz, '2025-09-20 14:59:00'::timestamptz, '2025-09-19 14:30:00'::timestamptz, '2025-09-19 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.75, '2025-09-19 14:30:00'::timestamptz); END IF;

  -- CC2798
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2798', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '0', '2025-09-20 00:00:00'::timestamptz, '2025-09-19 16:41:00'::timestamptz, '2025-09-19 15:37:00'::timestamptz, '2025-09-19 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-09-19 15:37:00'::timestamptz); END IF;

  -- CC2799
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2799', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 7, '', '2025-09-19 00:00:00'::timestamptz, '2025-09-19 00:00:00'::timestamptz, '2025-09-19 16:40:00'::timestamptz, '2025-09-19 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-19 16:40:00'::timestamptz); END IF;

  -- CC2800
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2800', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-09-19 00:00:00'::timestamptz, '2025-09-19 16:49:00'::timestamptz, '2025-09-19 16:44:00'::timestamptz, '2025-09-19 16:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-19 16:44:00'::timestamptz); END IF;

  -- CC2801
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2801', 'Juan Jose Rubio', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 3.20, 2, 1, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 13:17:00'::timestamptz, '2025-09-20 08:27:00'::timestamptz, '2025-09-20 08:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-20 08:27:00'::timestamptz); END IF;

  -- CC2802
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2802', 'Julissa Rivera', false, 'completed', false, 6.84, 0.00, 0, 0.41, 7.25, 2.50, 1, 2, 'lavanderia', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 15:02:00'::timestamptz, '2025-09-20 08:51:00'::timestamptz, '2025-09-20 08:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.25, '2025-09-20 08:51:00'::timestamptz); END IF;

  -- CC2803
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2803', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 14:59:00'::timestamptz, '2025-09-20 09:34:00'::timestamptz, '2025-09-20 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-20 09:34:00'::timestamptz); END IF;

  -- CC2804
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2804', 'Cesar Malave', false, 'completed', false, 9.46, 2.00, 0, 0.54, 10.00, 0.00, 0, 7, 'lavanderia', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 10:11:00'::timestamptz, '2025-09-20 10:03:00'::timestamptz, '2025-09-20 10:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-20 10:03:00'::timestamptz); END IF;

  -- CC2805
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2805', 'Fabio Nunez', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 14:59:00'::timestamptz, '2025-09-20 12:15:00'::timestamptz, '2025-09-20 12:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-09-20 12:15:00'::timestamptz); END IF;

  -- CC2806
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 240;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2806', 'Reina Gonzalez', false, 'completed', false, 95.56, 0.00, 0, 6.69, 102.25, 30.50, 5, 4, 'lavanderia', '2025-09-21 00:00:00'::timestamptz, '2025-09-22 14:05:00'::timestamptz, '2025-09-20 13:36:00'::timestamptz, '2025-09-20 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 102.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 102.25, '2025-09-20 13:36:00'::timestamptz); END IF;

  -- CC2807
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2807', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 15:00:00'::timestamptz, '2025-09-20 14:59:00'::timestamptz, '2025-09-20 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-09-20 14:59:00'::timestamptz); END IF;

  -- CC2808
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2808', 'Alberto Campell', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, 'lavanderia', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 00:00:00'::timestamptz, '2025-09-20 15:01:00'::timestamptz, '2025-09-20 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-09-20 15:01:00'::timestamptz); END IF;

  -- CC2809
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2809', 'Fernando Ortega', false, 'completed', false, 9.36, 0.00, 0, 0.64, 10.00, 3.90, 1, 2, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 16:39:00'::timestamptz, '2025-09-20 16:36:00'::timestamptz, '2025-09-20 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-20 16:36:00'::timestamptz); END IF;

  -- CC2810
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2810', 'Virginia Gonzalez', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 5, 'Lavandería', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 16:39:00'::timestamptz, '2025-09-20 16:39:00'::timestamptz, '2025-09-20 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-09-20 16:39:00'::timestamptz); END IF;

  -- CC2811
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2811', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 00:00:00'::timestamptz, '2025-09-20 16:41:00'::timestamptz, '2025-09-20 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-20 16:41:00'::timestamptz); END IF;

  -- CC2812
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2812', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 16:43:00'::timestamptz, '2025-09-20 16:42:00'::timestamptz, '2025-09-20 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-20 16:42:00'::timestamptz); END IF;

  -- CC2813
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2813', 'Ileana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 16:43:00'::timestamptz, '2025-09-20 16:42:00'::timestamptz, '2025-09-20 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-20 16:42:00'::timestamptz); END IF;

  -- CC2814
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2814', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2025-09-20 00:00:00'::timestamptz, '2025-09-20 00:00:00'::timestamptz, '2025-09-20 17:11:00'::timestamptz, '2025-09-20 17:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-20 17:11:00'::timestamptz); END IF;

  -- CC2815
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2815', 'Alvaro Martinez @', false, 'completed', false, 36.92, 0.00, 0, 2.58, 39.50, 15.80, 2, 1, 'lavanderia', '2025-09-22 00:00:00'::timestamptz, '2025-09-23 13:13:00'::timestamptz, '2025-09-22 10:06:00'::timestamptz, '2025-09-22 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 39.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 39.50, '2025-09-22 10:06:00'::timestamptz); END IF;

  -- CC2816
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2816', 'Yariela Phillips', false, 'completed', false, 15.95, 0.00, 0, 1.05, 17.00, 0.00, 0, 12, 'lavanderia', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 10:40:00'::timestamptz, '2025-09-22 10:39:00'::timestamptz, '2025-09-22 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.00, '2025-09-22 10:39:00'::timestamptz); END IF;

  -- CC2817
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2817', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 13:12:00'::timestamptz, '2025-09-22 10:40:00'::timestamptz, '2025-09-22 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-22 10:40:00'::timestamptz); END IF;

  -- CC2818
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2818', 'Leonel Visueti', false, 'completed', false, 13.58, 0.00, 0, 0.92, 14.50, 0.00, 0, 8, '', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 14:05:00'::timestamptz, '2025-09-22 13:42:00'::timestamptz, '2025-09-22 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.50, '2025-09-22 13:42:00'::timestamptz); END IF;

  -- CC2819
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2819', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 14:05:00'::timestamptz, '2025-09-22 14:04:00'::timestamptz, '2025-09-22 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-22 14:04:00'::timestamptz); END IF;

  -- CC2820
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2820', 'Leonel Visueti', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, '', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 16:50:00'::timestamptz, '2025-09-22 16:24:00'::timestamptz, '2025-09-22 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-09-22 16:24:00'::timestamptz); END IF;

  -- CC2821
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2821', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 00:00:00'::timestamptz, '2025-09-22 16:27:00'::timestamptz, '2025-09-22 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-09-22 16:27:00'::timestamptz); END IF;

  -- CC2822
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2822', 'Alberto Campell', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, 'lavanderia', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 00:00:00'::timestamptz, '2025-09-22 16:28:00'::timestamptz, '2025-09-22 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-09-22 16:28:00'::timestamptz); END IF;

  -- CC2823
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2823', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-22 00:00:00'::timestamptz, '2025-09-22 16:50:00'::timestamptz, '2025-09-22 16:50:00'::timestamptz, '2025-09-22 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-22 16:50:00'::timestamptz); END IF;

  -- CC2824
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2824', 'Leonel Visueti', false, 'completed', false, 10.10, 0.00, 0, 0.50, 10.60, 0.00, 0, 9, '', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 12:25:00'::timestamptz, '2025-09-23 12:03:00'::timestamptz, '2025-09-23 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.60, '2025-09-23 12:03:00'::timestamptz); END IF;

  -- CC2825
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2825', 'Alberto Campell', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, 'lavanderia', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 00:00:00'::timestamptz, '2025-09-23 12:04:00'::timestamptz, '2025-09-23 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-23 12:04:00'::timestamptz); END IF;

  -- CC2826
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2826', 'Leonel Visueti', false, 'completed', false, 10.28, 0.00, 0, 0.72, 11.00, 0.00, 0, 7, '', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 13:13:00'::timestamptz, '2025-09-23 12:28:00'::timestamptz, '2025-09-23 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-09-23 12:28:00'::timestamptz); END IF;

  -- CC2827
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2827', 'Paula Perez', false, 'completed', false, 23.13, 0.00, 0, 1.62, 24.75, 1.95, 1, 10, 'lavanderia', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 13:25:00'::timestamptz, '2025-09-23 13:18:00'::timestamptz, '2025-09-23 13:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.75, '2025-09-23 13:18:00'::timestamptz); END IF;

  -- CC2828
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2828', 'Josue Rosales', false, 'completed', false, 7.54, 0.00, 0, 0.46, 8.00, 1.00, 1, 4, 'lavanderia', '2025-09-23 00:00:00'::timestamptz, '2025-09-24 15:28:00'::timestamptz, '2025-09-23 14:10:00'::timestamptz, '2025-09-23 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-23 14:10:00'::timestamptz); END IF;

  -- CC2829
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2829', 'Leonel Visueti', false, 'completed', false, 5.67, 0.00, 0, 0.33, 6.00, 0.00, 0, 5, '', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 16:52:00'::timestamptz, '2025-09-23 16:23:00'::timestamptz, '2025-09-23 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-23 16:23:00'::timestamptz); END IF;

  -- CC2830
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2830', 'Retail', true, 'completed', false, 1.06, 0.00, 0, 0.04, 1.10, 0.00, 0, 2, '', '2025-09-23 00:00:00'::timestamptz, '2025-09-23 00:00:00'::timestamptz, '2025-09-23 16:24:00'::timestamptz, '2025-09-23 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-09-23 16:24:00'::timestamptz); END IF;

  -- CC2831
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2831', 'German Alveo', false, 'completed', false, 180.61, 0.00, 0, 12.64, 193.25, 2.90, 1, 32, 'Lavandería', '2025-09-24 00:00:00'::timestamptz, '2025-09-24 11:50:00'::timestamptz, '2025-09-24 08:10:00'::timestamptz, '2025-09-24 08:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 193.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 193.25, '2025-09-24 08:10:00'::timestamptz); END IF;

  -- CC2832
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 231;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2832', 'Liebherr Panama S.A', false, 'completed', false, 70.09, 0.00, 0, 4.91, 75.00, 0.00, 0, 20, 'Empresa', '2025-09-24 00:00:00'::timestamptz, '2025-09-24 08:21:00'::timestamptz, '2025-09-24 08:18:00'::timestamptz, '2025-09-24 08:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 75.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 75.00, '2025-09-24 08:18:00'::timestamptz); END IF;

  -- CC2833
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 241;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2833', 'Alberto Galvez', false, 'completed', false, 23.43, 0.00, 0, 1.57, 25.00, 0.00, 0, 9, '', '2025-09-24 00:00:00'::timestamptz, '2025-09-24 15:28:00'::timestamptz, '2025-09-24 11:09:00'::timestamptz, '2025-09-24 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.00, '2025-09-24 11:09:00'::timestamptz); END IF;

  -- CC2834
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 242;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2834', 'Cifsa S.A', false, 'completed', false, 7.54, 0.00, 0, 0.46, 8.00, 0.00, 0, 4, 'lavanderia', '2025-09-24 00:00:00'::timestamptz, '2025-09-25 12:47:00'::timestamptz, '2025-09-24 13:00:00'::timestamptz, '2025-09-24 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-24 13:00:00'::timestamptz); END IF;

  -- CC2835
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2835', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-09-24 00:00:00'::timestamptz, '2025-09-24 00:00:00'::timestamptz, '2025-09-24 15:30:00'::timestamptz, '2025-09-24 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-24 15:30:00'::timestamptz); END IF;

  -- CC2836
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2836', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-09-24 00:00:00'::timestamptz, '2025-09-24 16:33:00'::timestamptz, '2025-09-24 16:12:00'::timestamptz, '2025-09-24 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-09-24 16:12:00'::timestamptz); END IF;

  -- CC2837
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2837', 'Juan David VanSice', false, 'completed', false, 0.00, 44.88, 0, 0.00, 0.00, 17.95, 3, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 15:53:00'::timestamptz, '2025-09-25 08:01:00'::timestamptz, '2025-09-25 08:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-09-25 08:01:00'::timestamptz); END IF;

  -- CC2838
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 243;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2838', 'Yahaira Castillo', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 08:09:00'::timestamptz, '2025-09-25 08:04:00'::timestamptz, '2025-09-25 08:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-25 08:04:00'::timestamptz); END IF;

  -- CC2839
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2839', 'Fernando Rios', false, 'completed', false, 10.75, 0.00, 0, 0.75, 11.50, 4.20, 2, 3, 'lavanderia', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 15:53:00'::timestamptz, '2025-09-25 09:14:00'::timestamptz, '2025-09-25 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.50, '2025-09-25 09:14:00'::timestamptz); END IF;

  -- CC2840
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 245;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2840', 'Armando Terrado', false, 'completed', false, 37.51, 0.00, 0, 2.49, 40.00, 15.20, 1, 3, 'lavanderia', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 16:06:00'::timestamptz, '2025-09-25 09:30:00'::timestamptz, '2025-09-25 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.00, '2025-09-25 09:30:00'::timestamptz); END IF;

  -- CC2842
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2842', 'German Alveo', false, 'completed', false, 58.88, 0.00, 0, 4.12, 63.00, 25.20, 8, 1, 'Lavandería', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 15:53:00'::timestamptz, '2025-09-25 11:54:00'::timestamptz, '2025-09-25 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 63.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 63.00, '2025-09-25 11:54:00'::timestamptz); END IF;

  -- CC2843
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2843', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 00:00:00'::timestamptz, '2025-09-25 15:25:00'::timestamptz, '2025-09-25 15:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-09-25 15:25:00'::timestamptz); END IF;

  -- CC2844
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 66;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2844', 'Juan Vansice', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Perlas de Olor: No scent, Fabric Softener Type: No softener', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 00:00:00'::timestamptz, '2025-09-25 15:43:00'::timestamptz, '2025-09-25 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-25 15:43:00'::timestamptz); END IF;

  -- CC2845
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2845', 'Retail', true, 'completed', false, 0.56, 0.00, 0, 0.04, 0.60, 0.00, 0, 1, '', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 00:00:00'::timestamptz, '2025-09-25 15:54:00'::timestamptz, '2025-09-25 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.60, '2025-09-25 15:54:00'::timestamptz); END IF;

  -- CC2846
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2846', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 17:02:00'::timestamptz, '2025-09-25 16:13:00'::timestamptz, '2025-09-25 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-09-25 16:13:00'::timestamptz); END IF;

  -- CC2847
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 246;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2847', 'Edgar Moreno', false, 'completed', false, 18.36, 0.00, 0, 1.14, 19.50, 0.00, 0, 12, 'lavanderia', '2025-09-25 00:00:00'::timestamptz, '2025-09-25 17:01:00'::timestamptz, '2025-09-25 16:19:00'::timestamptz, '2025-09-25 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 19.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 19.50, '2025-09-25 16:19:00'::timestamptz); END IF;

  -- CC2848
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2848', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 00:00:00'::timestamptz, '2025-09-26 07:57:00'::timestamptz, '2025-09-26 07:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-26 07:57:00'::timestamptz); END IF;

  -- CC2849
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2849', 'Julissa Rivera', false, 'completed', false, 7.07, 0.00, 0, 0.43, 7.50, 2.60, 1, 2, 'lavanderia', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 15:44:00'::timestamptz, '2025-09-26 09:38:00'::timestamptz, '2025-09-26 09:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-09-26 09:38:00'::timestamptz); END IF;

  -- CC2850
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2850', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 13:44:00'::timestamptz, '2025-09-26 10:08:00'::timestamptz, '2025-09-26 10:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-09-26 10:08:00'::timestamptz); END IF;

  -- CC2851
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2851', 'Alberto Campell', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, 'lavanderia', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 00:00:00'::timestamptz, '2025-09-26 10:42:00'::timestamptz, '2025-09-26 10:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-09-26 10:42:00'::timestamptz); END IF;

  -- CC2852
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2852', 'Grethell Guevara', false, 'completed', false, 70.85, 0.00, 0, 4.40, 75.25, 26.10, 4, 11, 'Lavandería', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 13:44:00'::timestamptz, '2025-09-26 11:57:00'::timestamptz, '2025-09-26 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 75.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 75.25, '2025-09-26 11:57:00'::timestamptz); END IF;

  -- CC2853
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2853', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 15:37:00'::timestamptz, '2025-09-26 13:42:00'::timestamptz, '2025-09-26 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-09-26 13:42:00'::timestamptz); END IF;

  -- CC2854
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2854', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 13:47:00'::timestamptz, '2025-09-26 13:47:00'::timestamptz, '2025-09-26 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-09-26 13:47:00'::timestamptz); END IF;

  -- CC2855
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2855', 'Leonel Visueti', false, 'completed', false, 11.71, 0.00, 0, 0.79, 12.50, 0.00, 0, 7, '', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 14:52:00'::timestamptz, '2025-09-26 14:51:00'::timestamptz, '2025-09-26 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.50, '2025-09-26 14:51:00'::timestamptz); END IF;

  -- CC2856
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2856', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 15:54:00'::timestamptz, '2025-09-26 15:53:00'::timestamptz, '2025-09-26 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-26 15:53:00'::timestamptz); END IF;

  -- CC2857
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2857', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-26 16:35:00'::timestamptz, '2025-09-26 15:55:00'::timestamptz, '2025-09-26 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-09-26 15:55:00'::timestamptz); END IF;

  -- CC2858
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2858', 'Retail', true, 'completed', false, 2.35, 0.00, 0, 0.00, 2.35, 0.00, 0, 5, '', '2025-09-26 00:00:00'::timestamptz, '2025-09-26 00:00:00'::timestamptz, '2025-09-26 15:59:00'::timestamptz, '2025-09-26 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.35, '2025-09-26 15:59:00'::timestamptz); END IF;

  -- CC2859
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2859', 'Leonel Willson', false, 'completed', false, 8.46, 4.00, 0, 0.54, 9.00, 0.00, 0, 7, '0', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 11:02:00'::timestamptz, '2025-09-27 09:47:00'::timestamptz, '2025-09-27 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-09-27 09:47:00'::timestamptz); END IF;

  -- CC2860
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2860', 'Leonel Visueti', false, 'completed', false, 14.43, 0.00, 0, 0.92, 15.35, 0.00, 0, 11, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 11:02:00'::timestamptz, '2025-09-27 10:04:00'::timestamptz, '2025-09-27 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.35, '2025-09-27 10:04:00'::timestamptz); END IF;

  -- CC2861
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2861', 'Israel Rentería', false, 'completed', false, 21.56, 0.00, 0, 1.44, 23.00, 8.80, 1, 2, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 15:43:00'::timestamptz, '2025-09-27 10:13:00'::timestamptz, '2025-09-27 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.00, '2025-09-27 10:13:00'::timestamptz); END IF;

  -- CC2862
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 237;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2862', 'Fibergo Telecom S. A', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 2.40, 1, 3, 'lavanderia', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 11:02:00'::timestamptz, '2025-09-27 10:56:00'::timestamptz, '2025-09-27 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-27 10:56:00'::timestamptz); END IF;

  -- CC2863
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2863', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 12:47:00'::timestamptz, '2025-09-27 12:41:00'::timestamptz, '2025-09-27 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-09-27 12:41:00'::timestamptz); END IF;

  -- CC2864
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2864', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 00:00:00'::timestamptz, '2025-09-27 12:43:00'::timestamptz, '2025-09-27 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-27 12:43:00'::timestamptz); END IF;

  -- CC2865
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2865', 'Gustavo Cumbrera', false, 'completed', false, 12.15, 0.00, 0, 0.85, 13.00, 0.00, 0, 8, 'lavanderia', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 13:43:00'::timestamptz, '2025-09-27 13:42:00'::timestamptz, '2025-09-27 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-09-27 13:42:00'::timestamptz); END IF;

  -- CC2866
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2866', 'Virginia Gonzalez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 13:43:00'::timestamptz, '2025-09-27 13:42:00'::timestamptz, '2025-09-27 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-09-27 13:42:00'::timestamptz); END IF;

  -- CC2867
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2867', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 15:43:00'::timestamptz, '2025-09-27 13:45:00'::timestamptz, '2025-09-27 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-09-27 13:45:00'::timestamptz); END IF;

  -- CC2868
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2868', 'Retail', true, 'completed', false, 1.10, 0.00, 0, 0.00, 1.10, 0.00, 0, 2, '', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 00:00:00'::timestamptz, '2025-09-27 13:46:00'::timestamptz, '2025-09-27 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-09-27 13:46:00'::timestamptz); END IF;

  -- CC2869
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2869', 'Alberto Campell', true, 'completed', false, 1.10, 0.00, 0, 0.00, 1.10, 0.00, 0, 2, 'lavanderia', '2025-09-27 00:00:00'::timestamptz, '2025-09-27 00:00:00'::timestamptz, '2025-09-27 15:52:00'::timestamptz, '2025-09-27 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-09-27 15:52:00'::timestamptz); END IF;

  -- CC2870
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 66;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2870', 'Juan Vansice', false, 'completed', false, 0.00, 37.25, 0, 0.00, 0.00, 14.90, 2, 1, 'Perlas de Olor: Sin aromatizante,Tipo De Suavizante: Sin suavizante', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 10:07:00'::timestamptz, '2025-09-29 10:06:00'::timestamptz, '2025-09-29 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-09-29 10:06:00'::timestamptz); END IF;

  -- CC2871
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2871', 'Leonel Visueti', false, 'completed', false, 5.17, 0.00, 0, 0.33, 5.50, 0.00, 0, 5, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 12:07:00'::timestamptz, '2025-09-29 12:04:00'::timestamptz, '2025-09-29 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.50, '2025-09-29 12:04:00'::timestamptz); END IF;

  -- CC2872
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2872', 'Retail', true, 'completed', false, 2.70, 0.00, 0, 0.00, 2.70, 0.00, 0, 4, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 00:00:00'::timestamptz, '2025-09-29 12:06:00'::timestamptz, '2025-09-29 12:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.70, '2025-09-29 12:06:00'::timestamptz); END IF;

  -- CC2873
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2873', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 12:07:00'::timestamptz, '2025-09-29 12:06:00'::timestamptz, '2025-09-29 12:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-29 12:06:00'::timestamptz); END IF;

  -- CC2874
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2874', 'Paula Perez', false, 'completed', false, 21.50, 0.00, 0, 1.50, 23.00, 1.25, 1, 8, 'lavanderia', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 15:11:00'::timestamptz, '2025-09-29 12:42:00'::timestamptz, '2025-09-29 12:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.00, '2025-09-29 12:42:00'::timestamptz); END IF;

  -- CC2875
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2875', 'Josue Rosales', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.95, 1, 2, 'lavanderia', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 16:38:00'::timestamptz, '2025-09-29 13:09:00'::timestamptz, '2025-09-29 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-09-29 13:09:00'::timestamptz); END IF;

  -- CC2876
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2876', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 00:00:00'::timestamptz, '2025-09-29 15:07:00'::timestamptz, '2025-09-29 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-09-29 15:07:00'::timestamptz); END IF;

  -- CC2877
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2877', 'Oscar Oropeza', false, 'completed', false, 9.35, 4.00, 0, 0.65, 10.00, 0.00, 0, 7, 'Lavandería', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 16:04:00'::timestamptz, '2025-09-29 16:03:00'::timestamptz, '2025-09-29 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-29 16:03:00'::timestamptz); END IF;

  -- CC2878
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2878', 'Leonel Visueti', false, 'completed', false, 15.21, 0.00, 0, 0.79, 16.00, 0.00, 0, 10, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 16:38:00'::timestamptz, '2025-09-29 16:37:00'::timestamptz, '2025-09-29 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-09-29 16:37:00'::timestamptz); END IF;

  -- CC2879
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2879', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 16:39:00'::timestamptz, '2025-09-29 16:38:00'::timestamptz, '2025-09-29 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-09-29 16:38:00'::timestamptz); END IF;

  -- CC2880
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2880', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2025-09-29 00:00:00'::timestamptz, '2025-09-29 00:00:00'::timestamptz, '2025-09-29 16:40:00'::timestamptz, '2025-09-29 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-09-29 16:40:00'::timestamptz); END IF;

  -- CC2881
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2881', 'Leonel Visueti', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-09-30 00:00:00'::timestamptz, '2025-09-30 00:00:00'::timestamptz, '2025-09-30 08:42:00'::timestamptz, '2025-09-30 08:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.50, '2025-09-30 08:42:00'::timestamptz); END IF;

  -- CC2882
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2882', 'Alvaro Martinez @', false, 'completed', false, 33.41, 0.00, 0, 2.34, 35.75, 14.30, 2, 1, 'lavanderia', '2025-09-30 00:00:00'::timestamptz, '2025-10-01 16:27:00'::timestamptz, '2025-09-30 14:17:00'::timestamptz, '2025-09-30 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.75, '2025-09-30 14:17:00'::timestamptz); END IF;

  -- CC2883
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2883', 'Alberto Campell', true, 'completed', false, 2.10, 0.00, 0, 0.00, 2.10, 0.00, 0, 4, 'lavanderia', '2025-09-30 00:00:00'::timestamptz, '2025-09-30 00:00:00'::timestamptz, '2025-09-30 16:44:00'::timestamptz, '2025-09-30 16:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.10, '2025-09-30 16:44:00'::timestamptz); END IF;

  -- CC2884
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2884', 'Blanca', false, 'completed', false, 0.00, 2.00, 0, 0.00, 0.00, 0.00, 0, 1, '0', '2025-09-30 00:00:00'::timestamptz, '2025-09-30 16:45:00'::timestamptz, '2025-09-30 16:45:00'::timestamptz, '2025-09-30 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-09-30 16:45:00'::timestamptz); END IF;

  -- CC2885
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2885', 'Fernando Rios', false, 'completed', false, 12.51, 0.00, 0, 0.74, 13.25, 4.50, 2, 3, 'lavanderia', '2025-10-01 00:00:00'::timestamptz, '2025-10-02 13:20:00'::timestamptz, '2025-10-01 08:55:00'::timestamptz, '2025-10-01 08:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.25, '2025-10-01 08:55:00'::timestamptz); END IF;

  -- CC2886
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 215;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2886', 'Arturo Martinez', false, 'completed', false, 15.42, 0.00, 0, 1.08, 16.50, 0.00, 0, 14, 'lavanderia', '2025-10-01 00:00:00'::timestamptz, '2025-10-02 13:20:00'::timestamptz, '2025-10-01 10:17:00'::timestamptz, '2025-10-01 10:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.50, '2025-10-01 10:17:00'::timestamptz); END IF;

  -- CC2887
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 248;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2887', 'Eufemia Moreno', false, 'completed', false, 20.86, 0.00, 0, 1.39, 22.25, 8.50, 2, 2, 'lavanderia', '2025-10-01 00:00:00'::timestamptz, '2025-10-01 16:26:00'::timestamptz, '2025-10-01 11:22:00'::timestamptz, '2025-10-01 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.25, '2025-10-01 11:22:00'::timestamptz); END IF;

  -- CC2888
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2888', 'Leonel Visueti', false, 'completed', false, 25.69, 0.00, 0, 1.31, 27.00, 0.00, 0, 17, '', '2025-10-01 00:00:00'::timestamptz, '2025-10-01 13:10:00'::timestamptz, '2025-10-01 12:56:00'::timestamptz, '2025-10-01 12:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 27.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 27.00, '2025-10-01 12:56:00'::timestamptz); END IF;

  -- CC2889
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2889', 'Cliente Lavandería', false, 'completed', false, 9.57, 0.00, 0, 0.43, 10.00, 0.00, 0, 9, 'Lavandería', '2025-10-01 00:00:00'::timestamptz, '2025-10-01 16:26:00'::timestamptz, '2025-10-01 15:54:00'::timestamptz, '2025-10-01 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-10-01 15:54:00'::timestamptz); END IF;

  -- CC2890
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2890', 'Retail', true, 'completed', false, 2.10, 0.00, 0, 0.00, 2.10, 0.00, 0, 4, '', '2025-10-01 00:00:00'::timestamptz, '2025-10-01 00:00:00'::timestamptz, '2025-10-01 16:02:00'::timestamptz, '2025-10-01 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.10, '2025-10-01 16:02:00'::timestamptz); END IF;

  -- CC2891
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2891', 'Leonel Visueti', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2025-10-01 00:00:00'::timestamptz, '2025-10-01 00:00:00'::timestamptz, '2025-10-01 16:05:00'::timestamptz, '2025-10-01 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-10-01 16:05:00'::timestamptz); END IF;

  -- CC2892
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2892', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 3, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 00:00:00'::timestamptz, '2025-10-02 08:45:00'::timestamptz, '2025-10-02 08:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2025-10-02 08:45:00'::timestamptz); END IF;

  -- CC2893
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2893', 'German Alveo', false, 'completed', false, 43.46, 0.00, 0, 3.04, 46.50, 18.60, 7, 1, 'Lavandería', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 13:56:00'::timestamptz, '2025-10-02 08:46:00'::timestamptz, '2025-10-02 08:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 46.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 46.50, '2025-10-02 08:46:00'::timestamptz); END IF;

  -- CC2894
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2894', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 13:20:00'::timestamptz, '2025-10-02 13:19:00'::timestamptz, '2025-10-02 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-02 13:19:00'::timestamptz); END IF;

  -- CC2895
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2895', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 13:48:00'::timestamptz, '2025-10-02 13:47:00'::timestamptz, '2025-10-02 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-02 13:47:00'::timestamptz); END IF;

  -- CC2896
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 250;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2896', 'Ivan Miranda', false, 'completed', false, 17.78, 0.00, 0, 1.10, 18.88, 6.75, 1, 3, 'lavanderia', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 15:04:00'::timestamptz, '2025-10-02 15:01:00'::timestamptz, '2025-10-02 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.88, '2025-10-02 15:01:00'::timestamptz); END IF;

  -- CC2897
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2897', 'Retail', true, 'completed', false, 1.95, 0.00, 0, 0.00, 1.95, 0.00, 0, 3, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 00:00:00'::timestamptz, '2025-10-02 15:03:00'::timestamptz, '2025-10-02 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.95 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.95, '2025-10-02 15:03:00'::timestamptz); END IF;

  -- CC2898
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2898', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 15:04:00'::timestamptz, '2025-10-02 15:03:00'::timestamptz, '2025-10-02 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-02 15:03:00'::timestamptz); END IF;

  -- CC2899
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2899', 'Leonel Visueti', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, '', '2025-10-02 00:00:00'::timestamptz, '2025-10-02 15:58:00'::timestamptz, '2025-10-02 15:57:00'::timestamptz, '2025-10-02 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-10-02 15:57:00'::timestamptz); END IF;

  -- CC2900
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 251;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2900', 'Raul Guevara', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, 'lavanderia', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 10:20:00'::timestamptz, '2025-10-03 08:31:00'::timestamptz, '2025-10-03 08:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-03 08:31:00'::timestamptz); END IF;

  -- CC2901
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2901', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 10:20:00'::timestamptz, '2025-10-03 08:32:00'::timestamptz, '2025-10-03 08:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-03 08:32:00'::timestamptz); END IF;

  -- CC2902
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2902', 'Julissa Rivera', false, 'completed', false, 7.07, 0.00, 0, 0.43, 7.50, 2.60, 1, 2, 'lavanderia', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 15:08:00'::timestamptz, '2025-10-03 10:19:00'::timestamptz, '2025-10-03 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.50, '2025-10-03 10:19:00'::timestamptz); END IF;

  -- CC2903
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2903', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 14:57:00'::timestamptz, '2025-10-03 13:40:00'::timestamptz, '2025-10-03 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-03 13:40:00'::timestamptz); END IF;

  -- CC2904
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2904', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 14:58:00'::timestamptz, '2025-10-03 14:57:00'::timestamptz, '2025-10-03 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-03 14:57:00'::timestamptz); END IF;

  -- CC2905
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2905', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 16:30:00'::timestamptz, '2025-10-03 16:01:00'::timestamptz, '2025-10-03 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-03 16:01:00'::timestamptz); END IF;

  -- CC2906
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2906', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2025-10-03 00:00:00'::timestamptz, '2025-10-03 00:00:00'::timestamptz, '2025-10-03 16:18:00'::timestamptz, '2025-10-03 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-10-03 16:18:00'::timestamptz); END IF;

  -- CC2907
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2907', 'Fabio Nunez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'lavanderia', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 09:39:00'::timestamptz, '2025-10-04 09:34:00'::timestamptz, '2025-10-04 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-04 09:34:00'::timestamptz); END IF;

  -- CC2908
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2908', 'Cesar Malave', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, 'lavanderia', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 10:25:00'::timestamptz, '2025-10-04 10:23:00'::timestamptz, '2025-10-04 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-10-04 10:23:00'::timestamptz); END IF;

  -- CC2909
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2909', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 10:33:00'::timestamptz, '2025-10-04 10:31:00'::timestamptz, '2025-10-04 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-04 10:31:00'::timestamptz); END IF;

  -- CC2910
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2910', 'Virginia Gonzalez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 11:56:00'::timestamptz, '2025-10-04 11:55:00'::timestamptz, '2025-10-04 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-04 11:55:00'::timestamptz); END IF;

  -- CC2911
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2911', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 00:00:00'::timestamptz, '2025-10-04 11:55:00'::timestamptz, '2025-10-04 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-04 11:55:00'::timestamptz); END IF;

  -- CC2912
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2912', 'Lina Perez', false, 'completed', false, 42.72, 4.00, 0, 2.28, 45.00, 0.00, 0, 30, 'Lavandería', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 14:50:00'::timestamptz, '2025-10-04 14:11:00'::timestamptz, '2025-10-04 14:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 45.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 45.00, '2025-10-04 14:11:00'::timestamptz); END IF;

  -- CC2913
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2913', 'Fernando Ortega', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 14:50:00'::timestamptz, '2025-10-04 14:48:00'::timestamptz, '2025-10-04 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-10-04 14:48:00'::timestamptz); END IF;

  -- CC2914
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2914', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 15:08:00'::timestamptz, '2025-10-04 15:07:00'::timestamptz, '2025-10-04 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-04 15:07:00'::timestamptz); END IF;

  -- CC2915
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2915', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 15:54:00'::timestamptz, '2025-10-04 15:54:00'::timestamptz, '2025-10-04 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-04 15:54:00'::timestamptz); END IF;

  -- CC2916
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2916', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-10-04 00:00:00'::timestamptz, '2025-10-04 00:00:00'::timestamptz, '2025-10-04 15:56:00'::timestamptz, '2025-10-04 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-10-04 15:56:00'::timestamptz); END IF;

  -- CC2917
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2917', 'Maribel Carruyo', false, 'completed', false, 22.06, 0.00, 0, 1.44, 23.50, 0.00, 0, 9, 'lavanderia', '2025-10-06 00:00:00'::timestamptz, '2025-10-06 09:52:00'::timestamptz, '2025-10-06 09:11:00'::timestamptz, '2025-10-06 09:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 23.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 23.50, '2025-10-06 09:11:00'::timestamptz); END IF;

  -- CC2918
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2918', 'Leonel Visueti', false, 'completed', false, 3.99, 0.00, 0, 0.26, 4.25, 0.00, 0, 3, '', '2025-10-06 00:00:00'::timestamptz, '2025-10-06 11:09:00'::timestamptz, '2025-10-06 10:04:00'::timestamptz, '2025-10-06 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.25, '2025-10-06 10:04:00'::timestamptz); END IF;

  -- CC2919
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2919', 'Maribel Carruyo', false, 'completed', false, 0.23, 0.00, 0, 0.02, 0.25, 0.00, 0, 1, 'lavanderia', '2025-10-07 00:00:00'::timestamptz, '2025-10-06 10:06:00'::timestamptz, '2025-10-06 10:05:00'::timestamptz, '2025-10-06 10:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.25, '2025-10-06 10:05:00'::timestamptz); END IF;

  -- CC2920
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 253;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2920', 'Javier Oberto', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 4, 'lavanderia', '2025-10-06 00:00:00'::timestamptz, '2025-10-07 13:09:00'::timestamptz, '2025-10-06 13:35:00'::timestamptz, '2025-10-06 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-10-06 13:35:00'::timestamptz); END IF;

  -- CC2921
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 240;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2921', 'Reina Gonzalez', false, 'completed', false, 51.87, 0.00, 0, 3.63, 55.50, 18.20, 4, 3, 'lavanderia', '2025-10-06 00:00:00'::timestamptz, '2025-10-07 11:12:00'::timestamptz, '2025-10-06 15:24:00'::timestamptz, '2025-10-06 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 55.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 55.50, '2025-10-06 15:24:00'::timestamptz); END IF;

  -- CC2922
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2922', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-10-06 00:00:00'::timestamptz, '2025-10-06 15:47:00'::timestamptz, '2025-10-06 15:43:00'::timestamptz, '2025-10-06 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-06 15:43:00'::timestamptz); END IF;

  -- CC2923
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2923', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-10-06 00:00:00'::timestamptz, '2025-10-06 16:30:00'::timestamptz, '2025-10-06 15:45:00'::timestamptz, '2025-10-06 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-06 15:45:00'::timestamptz); END IF;

  -- CC2924
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2924', 'Retail', true, 'completed', false, 1.10, 0.00, 0, 0.00, 1.10, 0.00, 0, 2, '', '2025-10-06 00:00:00'::timestamptz, '2025-10-06 00:00:00'::timestamptz, '2025-10-06 16:21:00'::timestamptz, '2025-10-06 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-10-06 16:21:00'::timestamptz); END IF;

  -- CC2925
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2925', 'Yariela Phillips', false, 'completed', false, 10.18, 4.00, 0, 0.57, 10.75, 0.00, 0, 11, 'lavanderia', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 11:11:00'::timestamptz, '2025-10-07 08:26:00'::timestamptz, '2025-10-07 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.75, '2025-10-07 08:26:00'::timestamptz); END IF;

  -- CC2926
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2926', 'Juan David VanSice', false, 'completed', false, 0.00, 29.13, 0, 0.00, 0.00, 11.65, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 11:11:00'::timestamptz, '2025-10-07 08:35:00'::timestamptz, '2025-10-07 08:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-10-07 08:35:00'::timestamptz); END IF;

  -- CC2927
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2927', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 11:11:00'::timestamptz, '2025-10-07 09:50:00'::timestamptz, '2025-10-07 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-07 09:50:00'::timestamptz); END IF;

  -- CC2928
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2928', 'Academia Jireh', false, 'completed', false, 46.86, 0.00, 0, 3.14, 50.00, 0.00, 0, 8, '0', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 11:12:00'::timestamptz, '2025-10-07 11:10:00'::timestamptz, '2025-10-07 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 50.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 50.00, '2025-10-07 11:10:00'::timestamptz); END IF;

  -- CC2929
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2929', 'Aaron Gutierrez', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 11:57:00'::timestamptz, '2025-10-07 11:49:00'::timestamptz, '2025-10-07 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-07 11:49:00'::timestamptz); END IF;

  -- CC2930
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 254;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2930', 'Mayanin Carrion', false, 'completed', false, 38.38, 0.00, 0, 2.62, 41.00, 2.10, 1, 7, 'lavanderia', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 16:27:00'::timestamptz, '2025-10-07 11:55:00'::timestamptz, '2025-10-07 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 41.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 41.00, '2025-10-07 11:55:00'::timestamptz); END IF;

  -- CC2931
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2931', 'Fany Luz Salon', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-10-07 00:00:00'::timestamptz, '2025-10-07 16:27:00'::timestamptz, '2025-10-07 16:26:00'::timestamptz, '2025-10-07 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-10-07 16:26:00'::timestamptz); END IF;

  -- CC2932
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2932', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 10:30:00'::timestamptz, '2025-10-08 08:50:00'::timestamptz, '2025-10-08 08:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-08 08:50:00'::timestamptz); END IF;

  -- CC2933
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2933', 'Paula Perez', false, 'completed', false, 26.17, 0.00, 0, 1.83, 28.00, 2.20, 1, 12, 'lavanderia', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 11:35:00'::timestamptz, '2025-10-08 09:00:00'::timestamptz, '2025-10-08 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.00, '2025-10-08 09:00:00'::timestamptz); END IF;

  -- CC2934
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2934', 'Alvaro Martinez @', false, 'completed', false, 27.80, 0.00, 0, 1.95, 29.75, 11.90, 2, 1, 'lavanderia', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 16:06:00'::timestamptz, '2025-10-08 11:28:00'::timestamptz, '2025-10-08 11:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.75, '2025-10-08 11:28:00'::timestamptz); END IF;

  -- CC2935
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2935', 'Oscar Oropeza', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 16:06:00'::timestamptz, '2025-10-08 14:27:00'::timestamptz, '2025-10-08 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-08 14:27:00'::timestamptz); END IF;

  -- CC2936
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2936', 'Retail', true, 'completed', false, 1.05, 0.00, 0, 0.00, 1.05, 0.00, 0, 3, '', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 00:00:00'::timestamptz, '2025-10-08 15:10:00'::timestamptz, '2025-10-08 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.05, '2025-10-08 15:10:00'::timestamptz); END IF;

  -- CC2937
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2937', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 15:43:00'::timestamptz, '2025-10-08 15:21:00'::timestamptz, '2025-10-08 15:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-08 15:21:00'::timestamptz); END IF;

  -- CC2938
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2938', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-10-08 00:00:00'::timestamptz, '2025-10-08 16:36:00'::timestamptz, '2025-10-08 15:31:00'::timestamptz, '2025-10-08 15:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-10-08 15:31:00'::timestamptz); END IF;

  -- CC2939
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2939', 'German Alveo', false, 'completed', false, 37.74, 0.00, 0, 2.64, 40.38, 16.15, 6, 1, 'Lavandería', '2025-10-09 00:00:00'::timestamptz, '2025-10-09 14:49:00'::timestamptz, '2025-10-09 10:18:00'::timestamptz, '2025-10-09 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.38, '2025-10-09 10:18:00'::timestamptz); END IF;

  -- CC2940
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 255;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2940', 'Glorianna Cochez', false, 'completed', false, 49.66, 0.00, 0, 3.34, 53.00, 16.40, 3, 5, 'lavabderia ', '2025-10-09 00:00:00'::timestamptz, '2025-10-09 16:14:00'::timestamptz, '2025-10-09 14:30:00'::timestamptz, '2025-10-09 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 53.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 53.00, '2025-10-09 14:30:00'::timestamptz); END IF;

  -- CC2941
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2941', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-10-09 00:00:00'::timestamptz, '2025-10-09 14:49:00'::timestamptz, '2025-10-09 14:36:00'::timestamptz, '2025-10-09 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-09 14:36:00'::timestamptz); END IF;

  -- CC2942
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2942', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-09 00:00:00'::timestamptz, '2025-10-09 16:15:00'::timestamptz, '2025-10-09 16:15:00'::timestamptz, '2025-10-09 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-09 16:15:00'::timestamptz); END IF;

  -- CC2943
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2943', 'Retail', true, 'completed', false, 1.10, 0.00, 0, 0.00, 1.10, 0.00, 0, 2, '', '2025-10-09 00:00:00'::timestamptz, '2025-10-09 00:00:00'::timestamptz, '2025-10-09 16:16:00'::timestamptz, '2025-10-09 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.10, '2025-10-09 16:16:00'::timestamptz); END IF;

  -- CC2944
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2944', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 12:37:00'::timestamptz, '2025-10-10 11:54:00'::timestamptz, '2025-10-10 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-10-10 11:54:00'::timestamptz); END IF;

  -- CC2945
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2945', 'Juan David VanSice', false, 'completed', false, 0.00, 6.63, 0, 0.00, 0.00, 2.65, 1, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 12:37:00'::timestamptz, '2025-10-10 12:10:00'::timestamptz, '2025-10-10 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-10-10 12:10:00'::timestamptz); END IF;

  -- CC2946
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 155;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2946', 'Julissa', false, 'completed', false, 10.07, 0.00, 0, 0.43, 10.50, 2.60, 1, 5, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 16:18:00'::timestamptz, '2025-10-10 12:36:00'::timestamptz, '2025-10-10 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-10-10 12:36:00'::timestamptz); END IF;

  -- CC2947
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2947', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 15:05:00'::timestamptz, '2025-10-10 15:05:00'::timestamptz, '2025-10-10 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-10 15:05:00'::timestamptz); END IF;

  -- CC2948
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2948', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 16:19:00'::timestamptz, '2025-10-10 15:07:00'::timestamptz, '2025-10-10 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-10 15:07:00'::timestamptz); END IF;

  -- CC2949
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2949', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 16:19:00'::timestamptz, '2025-10-10 16:18:00'::timestamptz, '2025-10-10 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-10 16:18:00'::timestamptz); END IF;

  -- CC2950
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2950', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-10-10 00:00:00'::timestamptz, '2025-10-10 00:00:00'::timestamptz, '2025-10-10 16:21:00'::timestamptz, '2025-10-10 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-10-10 16:21:00'::timestamptz); END IF;

  -- CC2951
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2951', 'Israel Rentería', false, 'completed', false, 18.06, 0.00, 0, 1.19, 19.25, 7.30, 1, 2, '', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 11:12:00'::timestamptz, '2025-10-11 08:20:00'::timestamptz, '2025-10-11 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.25, '2025-10-11 08:20:00'::timestamptz); END IF;

  -- CC2952
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2952', 'Cesar Malave', false, 'completed', false, 13.15, 0.00, 0, 0.85, 14.00, 0.00, 0, 8, 'lavanderia', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 10:42:00'::timestamptz, '2025-10-11 10:42:00'::timestamptz, '2025-10-11 10:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-10-11 10:42:00'::timestamptz); END IF;

  -- CC2953
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2953', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 12:03:00'::timestamptz, '2025-10-11 11:12:00'::timestamptz, '2025-10-11 11:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-11 11:12:00'::timestamptz); END IF;

  -- CC2954
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2954', 'Leonel Visueti', false, 'completed', false, 2.01, 0.00, 0, 0.14, 2.15, 0.00, 0, 2, '', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 16:04:00'::timestamptz, '2025-10-11 15:35:00'::timestamptz, '2025-10-11 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.15, '2025-10-11 15:35:00'::timestamptz); END IF;

  -- CC2955
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2955', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 16:04:00'::timestamptz, '2025-10-11 16:01:00'::timestamptz, '2025-10-11 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-11 16:01:00'::timestamptz); END IF;

  -- CC2956
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2956', 'Alberto Campell', true, 'completed', false, 3.10, 0.00, 0, 0.00, 3.10, 0.00, 0, 6, 'lavanderia', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 00:00:00'::timestamptz, '2025-10-11 16:03:00'::timestamptz, '2025-10-11 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.10, '2025-10-11 16:03:00'::timestamptz); END IF;

  -- CC2957
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2957', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 00:00:00'::timestamptz, '2025-10-11 16:06:00'::timestamptz, '2025-10-11 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-11 16:06:00'::timestamptz); END IF;

  -- CC2958
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2958', 'Nicole Flores', false, 'completed', false, 27.43, 0.00, 0, 1.57, 29.00, 0.00, 0, 11, 'lavanderia', '2025-10-11 00:00:00'::timestamptz, '2025-10-11 16:43:00'::timestamptz, '2025-10-11 16:26:00'::timestamptz, '2025-10-11 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.00, '2025-10-11 16:26:00'::timestamptz); END IF;

  -- CC2959
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2959', 'Fernando Rios', false, 'completed', false, 7.07, 0.00, 0, 0.43, 7.50, 2.10, 1, 3, 'lavanderia', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 14:58:00'::timestamptz, '2025-10-13 08:59:00'::timestamptz, '2025-10-13 08:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-10-13 08:59:00'::timestamptz); END IF;

  -- CC2960
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2960', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 10:19:00'::timestamptz, '2025-10-13 10:19:00'::timestamptz, '2025-10-13 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-13 10:19:00'::timestamptz); END IF;

  -- CC2961
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2961', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 12:22:00'::timestamptz, '2025-10-13 10:20:00'::timestamptz, '2025-10-13 10:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-13 10:20:00'::timestamptz); END IF;

  -- CC2962
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2962', 'Maribel Carruyo', false, 'completed', false, 12.68, 0.00, 0, 0.82, 13.50, 0.00, 0, 9, 'lavanderia', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 12:22:00'::timestamptz, '2025-10-13 10:36:00'::timestamptz, '2025-10-13 10:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.50, '2025-10-13 10:36:00'::timestamptz); END IF;

  -- CC2963
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 255;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2963', 'Glorianna Cochez', false, 'completed', false, 61.21, 0.00, 0, 4.29, 65.50, 10.20, 2, 6, 'lavabderia', '2025-10-13 00:00:00'::timestamptz, '2025-10-14 11:31:00'::timestamptz, '2025-10-13 14:31:00'::timestamptz, '2025-10-13 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 65.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 65.50, '2025-10-13 14:31:00'::timestamptz); END IF;

  -- CC2964
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2964', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 14:58:00'::timestamptz, '2025-10-13 14:36:00'::timestamptz, '2025-10-13 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-13 14:36:00'::timestamptz); END IF;

  -- CC2965
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2965', 'Leonel Visueti', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, '', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 16:53:00'::timestamptz, '2025-10-13 16:07:00'::timestamptz, '2025-10-13 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.50, '2025-10-13 16:07:00'::timestamptz); END IF;

  -- CC2966
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2966', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-10-13 00:00:00'::timestamptz, '2025-10-13 16:53:00'::timestamptz, '2025-10-13 16:28:00'::timestamptz, '2025-10-13 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-13 16:28:00'::timestamptz); END IF;

  -- CC2967
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2967', 'Juan David VanSice', false, 'completed', false, 0.00, 16.25, 0, 0.00, 0.00, 6.50, 1, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 11:31:00'::timestamptz, '2025-10-14 08:14:00'::timestamptz, '2025-10-14 08:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-10-14 08:14:00'::timestamptz); END IF;

  -- CC2968
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2968', 'Josue Pernett', false, 'completed', false, 7.54, 0.00, 0, 0.46, 8.00, 1.95, 1, 4, 'Lavanderia', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 16:38:00'::timestamptz, '2025-10-14 12:22:00'::timestamptz, '2025-10-14 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-14 12:22:00'::timestamptz); END IF;

  -- CC2969
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2969', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 16:38:00'::timestamptz, '2025-10-14 12:39:00'::timestamptz, '2025-10-14 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-10-14 12:39:00'::timestamptz); END IF;

  -- CC2970
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2970', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 12:41:00'::timestamptz, '2025-10-14 12:40:00'::timestamptz, '2025-10-14 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-14 12:40:00'::timestamptz); END IF;

  -- CC2971
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2971', 'Karla Garibaldi', false, 'completed', false, 7.11, 0.00, 0, 0.39, 7.50, 0.00, 0, 9, 'Lavandería', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 16:38:00'::timestamptz, '2025-10-14 12:41:00'::timestamptz, '2025-10-14 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.50, '2025-10-14 12:41:00'::timestamptz); END IF;

  -- CC2972
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2972', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 16:39:00'::timestamptz, '2025-10-14 16:38:00'::timestamptz, '2025-10-14 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-14 16:38:00'::timestamptz); END IF;

  -- CC2973
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2973', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-14 00:00:00'::timestamptz, '2025-10-14 16:55:00'::timestamptz, '2025-10-14 16:40:00'::timestamptz, '2025-10-14 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-14 16:40:00'::timestamptz); END IF;

  -- CC2974
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2974', 'Paula Perez', false, 'completed', false, 21.96, 0.00, 0, 1.54, 23.50, 1.60, 1, 9, 'lavanderia', '2025-10-15 00:00:00'::timestamptz, '2025-10-15 14:36:00'::timestamptz, '2025-10-15 08:12:00'::timestamptz, '2025-10-15 08:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.50, '2025-10-15 08:12:00'::timestamptz); END IF;

  -- CC2975
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2975', 'German Alveo', false, 'completed', false, 35.51, 0.00, 0, 2.49, 38.00, 1.65, 1, 6, 'Lavandería', '2025-10-16 00:00:00'::timestamptz, '2025-10-15 14:05:00'::timestamptz, '2025-10-15 11:26:00'::timestamptz, '2025-10-15 11:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 38.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 38.00, '2025-10-15 11:26:00'::timestamptz); END IF;

  -- CC2976
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2976', 'Leonel Visueti', false, 'completed', false, 5.34, 0.00, 0, 0.26, 5.60, 0.00, 0, 4, '', '2025-10-15 00:00:00'::timestamptz, '2025-10-15 16:45:00'::timestamptz, '2025-10-15 14:06:00'::timestamptz, '2025-10-15 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.60, '2025-10-15 14:06:00'::timestamptz); END IF;

  -- CC2977
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2977', 'German Alveo', false, 'completed', false, 6.38, 0.00, 0, 0.45, 6.83, 3.90, 1, 1, 'Lavandería', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 10:09:00'::timestamptz, '2025-10-16 08:41:00'::timestamptz, '2025-10-16 08:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.83 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.83, '2025-10-16 08:41:00'::timestamptz); END IF;

  -- CC2978
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2978', 'Leonel Visueti', false, 'completed', false, 14.02, 0.00, 0, 0.98, 15.00, 0.00, 0, 12, '', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 12:19:00'::timestamptz, '2025-10-16 10:08:00'::timestamptz, '2025-10-16 10:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-10-16 10:08:00'::timestamptz); END IF;

  -- CC2979
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2979', 'German Alveo', false, 'completed', false, 32.24, 0.00, 0, 2.26, 34.50, 13.80, 5, 1, 'Lavandería', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 13:53:00'::timestamptz, '2025-10-16 12:24:00'::timestamptz, '2025-10-16 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.50, '2025-10-16 12:24:00'::timestamptz); END IF;

  -- CC2980
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2980', 'Aaron Gutierrez', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, 'Lavandería', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 13:56:00'::timestamptz, '2025-10-16 13:54:00'::timestamptz, '2025-10-16 13:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-10-16 13:54:00'::timestamptz); END IF;

  -- CC2981
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2981', 'Retail', true, 'completed', false, 1.35, 0.00, 0, 0.00, 1.35, 0.00, 0, 2, '', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 00:00:00'::timestamptz, '2025-10-16 16:45:00'::timestamptz, '2025-10-16 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.35, '2025-10-16 16:45:00'::timestamptz); END IF;

  -- CC2982
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2982', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-10-16 00:00:00'::timestamptz, '2025-10-16 00:00:00'::timestamptz, '2025-10-16 16:49:00'::timestamptz, '2025-10-16 16:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-10-16 16:49:00'::timestamptz); END IF;

  -- CC2983
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2983', 'Juan David VanSice', false, 'completed', false, 0.00, 15.25, 0, 0.00, 0.00, 6.10, 1, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 12:21:00'::timestamptz, '2025-10-17 08:14:00'::timestamptz, '2025-10-17 08:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-10-17 08:14:00'::timestamptz); END IF;

  -- CC2984
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 257;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2984', 'Carlos Batista', false, 'completed', false, 20.69, 0.00, 0, 1.31, 22.00, 0.00, 0, 4, 'lavanderia', '2025-10-17 00:00:00'::timestamptz, '2025-10-18 16:06:00'::timestamptz, '2025-10-17 09:13:00'::timestamptz, '2025-10-17 09:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2025-10-17 09:13:00'::timestamptz); END IF;

  -- CC2985
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2985', 'Julissa Rivera', false, 'completed', false, 11.28, 0.00, 0, 0.72, 12.00, 4.40, 1, 2, 'lavanderia', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 16:00:00'::timestamptz, '2025-10-17 09:49:00'::timestamptz, '2025-10-17 09:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-10-17 09:49:00'::timestamptz); END IF;

  -- CC2986
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 258;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2986', 'Davis Valdes', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 1, 'lavanderia', '2025-10-17 00:00:00'::timestamptz, '2025-10-18 15:11:00'::timestamptz, '2025-10-17 09:56:00'::timestamptz, '2025-10-17 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-10-17 09:56:00'::timestamptz); END IF;

  -- CC2987
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2987', 'Retail', true, 'completed', false, 3.85, 0.00, 0, 0.00, 3.85, 0.00, 0, 5, '', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 00:00:00'::timestamptz, '2025-10-17 10:52:00'::timestamptz, '2025-10-17 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.85, '2025-10-17 10:52:00'::timestamptz); END IF;

  -- CC2988
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2988', 'Retail', true, 'completed', false, 1.20, 0.00, 0, 0.00, 1.20, 0.00, 0, 2, '', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 00:00:00'::timestamptz, '2025-10-17 11:00:00'::timestamptz, '2025-10-17 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.20, '2025-10-17 11:00:00'::timestamptz); END IF;

  -- CC2989
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2989', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 00:00:00'::timestamptz, '2025-10-17 11:01:00'::timestamptz, '2025-10-17 11:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-17 11:01:00'::timestamptz); END IF;

  -- CC2990
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2990', 'Leonel Visueti', false, 'completed', false, 7.03, 0.00, 0, 0.42, 7.45, 0.00, 0, 7, '', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 12:21:00'::timestamptz, '2025-10-17 11:05:00'::timestamptz, '2025-10-17 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.45, '2025-10-17 11:05:00'::timestamptz); END IF;

  -- CC2991
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2991', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 12:21:00'::timestamptz, '2025-10-17 12:21:00'::timestamptz, '2025-10-17 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-17 12:21:00'::timestamptz); END IF;

  -- CC2992
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2992', 'Israel Rentería', false, 'completed', false, 10.58, 0.00, 0, 0.67, 11.25, 4.10, 1, 2, '', '2025-10-17 00:00:00'::timestamptz, '2025-10-18 13:18:00'::timestamptz, '2025-10-17 14:04:00'::timestamptz, '2025-10-17 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.25, '2025-10-17 14:04:00'::timestamptz); END IF;

  -- CC2993
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2993', 'Luis Carlos Arosema', false, 'completed', false, 4.25, 0.00, 0, 0.30, 4.55, 0.00, 0, 14, 'lavanderia', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 14:42:00'::timestamptz, '2025-10-17 14:38:00'::timestamptz, '2025-10-17 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.55 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.55, '2025-10-17 14:38:00'::timestamptz); END IF;

  -- CC2994
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2994', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 14:54:00'::timestamptz, '2025-10-17 14:53:00'::timestamptz, '2025-10-17 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-17 14:53:00'::timestamptz); END IF;

  -- CC2995
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2995', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 16:00:00'::timestamptz, '2025-10-17 15:59:00'::timestamptz, '2025-10-17 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-17 15:59:00'::timestamptz); END IF;

  -- CC2996
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 260;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2996', 'Anabela Morales', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 17:21:00'::timestamptz, '2025-10-17 16:16:00'::timestamptz, '2025-10-17 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-17 16:16:00'::timestamptz); END IF;

  -- CC2997
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2997', 'Oscar Oropeza', false, 'completed', false, 26.17, 4.00, 0, 1.83, 28.00, 0.00, 0, 16, 'Lavandería', '2025-10-17 00:00:00'::timestamptz, '2025-10-17 17:13:00'::timestamptz, '2025-10-17 17:10:00'::timestamptz, '2025-10-17 17:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.00, '2025-10-17 17:10:00'::timestamptz); END IF;

  -- CC2998
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2998', 'Leonel Willson', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '0', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 10:54:00'::timestamptz, '2025-10-18 09:05:00'::timestamptz, '2025-10-18 09:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-10-18 09:05:00'::timestamptz); END IF;

  -- CC2999
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2999', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 10:54:00'::timestamptz, '2025-10-18 09:06:00'::timestamptz, '2025-10-18 09:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-18 09:06:00'::timestamptz); END IF;

  -- CC3000
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3000', 'Fabio Nunez', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'lavanderia', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 10:54:00'::timestamptz, '2025-10-18 09:14:00'::timestamptz, '2025-10-18 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-18 09:14:00'::timestamptz); END IF;

  -- CC3001
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3001', 'Israel Rentería', false, 'completed', false, 8.64, 0.00, 0, 0.61, 9.25, 3.70, 1, 1, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 13:18:00'::timestamptz, '2025-10-18 09:44:00'::timestamptz, '2025-10-18 09:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.25, '2025-10-18 09:44:00'::timestamptz); END IF;

  -- CC3002
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3002', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 11:05:00'::timestamptz, '2025-10-18 10:03:00'::timestamptz, '2025-10-18 10:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-18 10:03:00'::timestamptz); END IF;

  -- CC3003
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3003', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 11:05:00'::timestamptz, '2025-10-18 11:04:00'::timestamptz, '2025-10-18 11:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-18 11:04:00'::timestamptz); END IF;

  -- CC3004
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3004', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 12:09:00'::timestamptz, '2025-10-18 12:07:00'::timestamptz, '2025-10-18 12:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-18 12:07:00'::timestamptz); END IF;

  -- CC3005
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3005', 'Rafael Quintero', false, 'completed', false, 8.64, 0.00, 0, 0.61, 9.25, 3.70, 1, 1, '0', '2025-10-18 00:00:00'::timestamptz, '2025-10-20 13:03:00'::timestamptz, '2025-10-18 12:15:00'::timestamptz, '2025-10-18 12:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.25, '2025-10-18 12:15:00'::timestamptz); END IF;

  -- CC3006
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3006', 'Cesar Malave', false, 'completed', false, 11.85, 0.00, 0, 0.65, 12.50, 0.00, 0, 8, 'lavanderia', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 13:24:00'::timestamptz, '2025-10-18 13:23:00'::timestamptz, '2025-10-18 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.50, '2025-10-18 13:23:00'::timestamptz); END IF;

  -- CC3007
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3007', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 15:52:00'::timestamptz, '2025-10-18 14:57:00'::timestamptz, '2025-10-18 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-18 14:57:00'::timestamptz); END IF;

  -- CC3008
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3008', 'Leonel Visueti', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 15:11:00'::timestamptz, '2025-10-18 15:10:00'::timestamptz, '2025-10-18 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-10-18 15:10:00'::timestamptz); END IF;

  -- CC3009
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3009', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 1, '', '2025-10-19 00:00:00'::timestamptz, '2025-10-18 15:52:00'::timestamptz, '2025-10-18 15:50:00'::timestamptz, '2025-10-18 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-18 15:50:00'::timestamptz); END IF;

  -- CC3010
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3010', 'Gustavo Cumbrera', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 16:01:00'::timestamptz, '2025-10-18 15:59:00'::timestamptz, '2025-10-18 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-10-18 15:59:00'::timestamptz); END IF;

  -- CC3011
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 222;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3011', 'Maria Lossada', false, 'completed', false, 33.64, 0.00, 0, 2.36, 36.00, 0.00, 0, 3, 'lavanderia', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 16:39:00'::timestamptz, '2025-10-18 16:22:00'::timestamptz, '2025-10-18 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 36.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 36.00, '2025-10-18 16:22:00'::timestamptz); END IF;

  -- CC3012
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3012', 'Virginia Gonzalez', false, 'completed', false, 10.48, 0.00, 0, 0.52, 11.00, 0.00, 0, 8, 'Lavandería', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 16:39:00'::timestamptz, '2025-10-18 16:26:00'::timestamptz, '2025-10-18 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-10-18 16:26:00'::timestamptz); END IF;

  -- CC3013
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3013', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 16:38:00'::timestamptz, '2025-10-18 16:38:00'::timestamptz, '2025-10-18 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-18 16:38:00'::timestamptz); END IF;

  -- CC3014
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3014', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 16:59:00'::timestamptz, '2025-10-18 16:55:00'::timestamptz, '2025-10-18 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-10-18 16:55:00'::timestamptz); END IF;

  -- CC3015
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 247;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3015', 'Joel Armando', false, 'completed', false, 51.61, 0.00, 0, 3.57, 55.18, 21.55, 2, 4, 'lavanderia', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 17:44:00'::timestamptz, '2025-10-18 17:27:00'::timestamptz, '2025-10-18 17:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 55.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 55.18, '2025-10-18 17:27:00'::timestamptz); END IF;

  -- CC3016
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3016', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 00:00:00'::timestamptz, '2025-10-18 17:31:00'::timestamptz, '2025-10-18 17:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.50, '2025-10-18 17:31:00'::timestamptz); END IF;

  -- CC3017
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3017', 'Retail', true, 'completed', false, 2.05, 0.00, 0, 0.00, 2.05, 0.00, 0, 5, '', '2025-10-18 00:00:00'::timestamptz, '2025-10-18 00:00:00'::timestamptz, '2025-10-18 17:32:00'::timestamptz, '2025-10-18 17:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.05, '2025-10-18 17:32:00'::timestamptz); END IF;

  -- CC3018
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3018', 'Maribel Carruyo', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'lavanderia', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 10:32:00'::timestamptz, '2025-10-20 10:25:00'::timestamptz, '2025-10-20 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-20 10:25:00'::timestamptz); END IF;

  -- CC3019
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3019', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 10:53:00'::timestamptz, '2025-10-20 10:31:00'::timestamptz, '2025-10-20 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-20 10:31:00'::timestamptz); END IF;

  -- CC3020
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3020', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 10:53:00'::timestamptz, '2025-10-20 10:52:00'::timestamptz, '2025-10-20 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-20 10:52:00'::timestamptz); END IF;

  -- CC3021
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3021', 'Valery Rosas', false, 'completed', false, 18.95, 0.00, 0, 1.05, 20.00, 0.00, 0, 12, 'Lavanderia', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 11:58:00'::timestamptz, '2025-10-20 11:57:00'::timestamptz, '2025-10-20 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-10-20 11:57:00'::timestamptz); END IF;

  -- CC3022
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3022', 'Valery Rosas', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, 'Lavanderia', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 00:00:00'::timestamptz, '2025-10-20 11:58:00'::timestamptz, '2025-10-20 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-10-20 11:58:00'::timestamptz); END IF;

  -- CC3023
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 184;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3023', 'La Barberia', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.40, 1, 1, 'lavanderia', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 13:03:00'::timestamptz, '2025-10-20 13:02:00'::timestamptz, '2025-10-20 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-20 13:02:00'::timestamptz); END IF;

  -- CC3024
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3024', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 2, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 14:45:00'::timestamptz, '2025-10-20 14:41:00'::timestamptz, '2025-10-20 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-10-20 14:41:00'::timestamptz); END IF;

  -- CC3025
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3025', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 14:45:00'::timestamptz, '2025-10-20 14:43:00'::timestamptz, '2025-10-20 14:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-20 14:43:00'::timestamptz); END IF;

  -- CC3026
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3026', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 14:45:00'::timestamptz, '2025-10-20 14:44:00'::timestamptz, '2025-10-20 14:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-20 14:44:00'::timestamptz); END IF;

  -- CC3027
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3027', 'Fany Luz Salon', false, 'completed', false, 3.34, 0.00, 0, 0.16, 3.50, 0.00, 0, 6, '0 ', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 14:58:00'::timestamptz, '2025-10-20 14:51:00'::timestamptz, '2025-10-20 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.50, '2025-10-20 14:51:00'::timestamptz); END IF;

  -- CC3028
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3028', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 15:03:00'::timestamptz, '2025-10-20 15:02:00'::timestamptz, '2025-10-20 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-20 15:02:00'::timestamptz); END IF;

  -- CC3029
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3029', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 15:09:00'::timestamptz, '2025-10-20 15:08:00'::timestamptz, '2025-10-20 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-20 15:08:00'::timestamptz); END IF;

  -- CC3030
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3030', 'Leonel Visueti', false, 'completed', false, 1.42, 0.00, 0, 0.03, 1.45, 0.00, 0, 4, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 16:37:00'::timestamptz, '2025-10-20 16:27:00'::timestamptz, '2025-10-20 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.45, '2025-10-20 16:27:00'::timestamptz); END IF;

  -- CC3031
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3031', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 6, '', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 00:00:00'::timestamptz, '2025-10-20 16:33:00'::timestamptz, '2025-10-20 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-10-20 16:33:00'::timestamptz); END IF;

  -- CC3032
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3032', 'Lina Perez', false, 'completed', false, 38.85, 4.00, 0, 2.15, 41.00, 0.00, 0, 27, 'Lavandería', '2025-10-20 00:00:00'::timestamptz, '2025-10-20 17:54:00'::timestamptz, '2025-10-20 17:31:00'::timestamptz, '2025-10-20 17:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 41.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 41.00, '2025-10-20 17:31:00'::timestamptz); END IF;

  -- CC3033
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3033', 'Fernando Rios', false, 'completed', false, 14.49, 0.00, 0, 1.01, 15.50, 5.60, 3, 4, 'lavanderia', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 16:56:00'::timestamptz, '2025-10-21 08:21:00'::timestamptz, '2025-10-21 08:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.50, '2025-10-21 08:21:00'::timestamptz); END IF;

  -- CC3034
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 261;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3034', 'Genesis Samaniego', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 09:01:00'::timestamptz, '2025-10-21 08:27:00'::timestamptz, '2025-10-21 08:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-21 08:27:00'::timestamptz); END IF;

  -- CC3035
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3035', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 12:25:00'::timestamptz, '2025-10-21 09:41:00'::timestamptz, '2025-10-21 09:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-21 09:41:00'::timestamptz); END IF;

  -- CC3036
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 262;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3036', 'Scott Schneider', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 3, 'lavanderia', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 10:36:00'::timestamptz, '2025-10-21 10:31:00'::timestamptz, '2025-10-21 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-10-21 10:31:00'::timestamptz); END IF;

  -- CC3037
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3037', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 12:25:00'::timestamptz, '2025-10-21 12:17:00'::timestamptz, '2025-10-21 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-21 12:17:00'::timestamptz); END IF;

  -- CC3038
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3038', 'Leonel Visueti', false, 'completed', false, 10.48, 0.00, 0, 0.52, 11.00, 0.00, 0, 8, '', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 14:37:00'::timestamptz, '2025-10-21 14:36:00'::timestamptz, '2025-10-21 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-10-21 14:36:00'::timestamptz); END IF;

  -- CC3039
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3039', 'Retail', true, 'completed', false, 2.20, 0.00, 0, 0.00, 2.20, 0.00, 0, 4, '', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 00:00:00'::timestamptz, '2025-10-21 16:55:00'::timestamptz, '2025-10-21 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.20, '2025-10-21 16:55:00'::timestamptz); END IF;

  -- CC3040
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3040', 'Juan David VanSice', false, 'completed', false, 0.00, 28.75, 0, 0.00, 0.00, 11.50, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-21 00:00:00'::timestamptz, '2025-10-22 14:55:00'::timestamptz, '2025-10-21 16:56:00'::timestamptz, '2025-10-21 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-10-21 16:56:00'::timestamptz); END IF;

  -- CC3041
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3041', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-21 00:00:00'::timestamptz, '2025-10-21 16:59:00'::timestamptz, '2025-10-21 16:59:00'::timestamptz, '2025-10-21 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-21 16:59:00'::timestamptz); END IF;

  -- CC3042
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3042', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-22 00:00:00'::timestamptz, '2025-10-22 15:51:00'::timestamptz, '2025-10-22 14:54:00'::timestamptz, '2025-10-22 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-22 14:54:00'::timestamptz); END IF;

  -- CC3043
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3043', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-22 00:00:00'::timestamptz, '2025-10-22 14:55:00'::timestamptz, '2025-10-22 14:54:00'::timestamptz, '2025-10-22 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-22 14:54:00'::timestamptz); END IF;

  -- CC3044
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 263;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3044', 'Luis Correa', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-10-22 00:00:00'::timestamptz, '2025-10-22 15:51:00'::timestamptz, '2025-10-22 15:50:00'::timestamptz, '2025-10-22 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-10-22 15:50:00'::timestamptz); END IF;

  -- CC3045
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3045', 'Leonel Visueti', false, 'completed', false, 7.54, 0.00, 0, 0.46, 8.00, 0.00, 0, 2, '', '2025-10-22 00:00:00'::timestamptz, '2025-10-22 16:23:00'::timestamptz, '2025-10-22 16:22:00'::timestamptz, '2025-10-22 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-22 16:22:00'::timestamptz); END IF;

  -- CC3046
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3046', 'German Alveo', false, 'completed', false, 8.01, 0.00, 0, 0.56, 8.57, 4.90, 1, 1, 'Lavandería', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 08:56:00'::timestamptz, '2025-10-23 08:38:00'::timestamptz, '2025-10-23 08:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.57 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.57, '2025-10-23 08:38:00'::timestamptz); END IF;

  -- CC3047
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 255;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3047', 'Glorianna Cochez', false, 'completed', false, 99.07, 0.00, 0, 6.93, 106.00, 0.00, 0, 18, 'lavabderia', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 09:33:00'::timestamptz, '2025-10-23 08:55:00'::timestamptz, '2025-10-23 08:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 106.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 106.00, '2025-10-23 08:55:00'::timestamptz); END IF;

  -- CC3048
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3048', 'Paula Perez', false, 'completed', false, 24.83, 0.00, 0, 1.67, 26.50, 1.80, 1, 11, 'lavanderia', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 12:30:00'::timestamptz, '2025-10-23 09:00:00'::timestamptz, '2025-10-23 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.50, '2025-10-23 09:00:00'::timestamptz); END IF;

  -- CC3049
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3049', 'Leonel Visueti', false, 'completed', false, 0.61, 0.00, 0, 0.04, 0.65, 0.00, 0, 2, '', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 09:36:00'::timestamptz, '2025-10-23 09:07:00'::timestamptz, '2025-10-23 09:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.65, '2025-10-23 09:07:00'::timestamptz); END IF;

  -- CC3050
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3050', 'German Alveo', false, 'completed', false, 64.51, 0.00, 0, 4.24, 68.75, 14.70, 6, 9, 'Lavandería', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 13:26:00'::timestamptz, '2025-10-23 11:39:00'::timestamptz, '2025-10-23 11:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 68.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 68.75, '2025-10-23 11:39:00'::timestamptz); END IF;

  -- CC3051
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3051', 'Karla Garibaldi', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 16:41:00'::timestamptz, '2025-10-23 12:44:00'::timestamptz, '2025-10-23 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-23 12:44:00'::timestamptz); END IF;

  -- CC3052
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3052', 'Yariela Phillips', false, 'completed', false, 11.96, 0.00, 0, 0.79, 12.75, 0.00, 0, 9, 'lavanderia', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 16:41:00'::timestamptz, '2025-10-23 15:13:00'::timestamptz, '2025-10-23 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.75, '2025-10-23 15:13:00'::timestamptz); END IF;

  -- CC3053
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3053', 'Leonel Visueti', false, 'completed', false, 9.53, 0.00, 0, 0.52, 10.05, 0.00, 0, 9, '', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 16:41:00'::timestamptz, '2025-10-23 15:30:00'::timestamptz, '2025-10-23 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.05, '2025-10-23 15:30:00'::timestamptz); END IF;

  -- CC3054
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3054', 'Retail', true, 'completed', false, 2.20, 0.00, 0, 0.00, 2.20, 0.00, 0, 4, '', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 00:00:00'::timestamptz, '2025-10-23 15:32:00'::timestamptz, '2025-10-23 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.20, '2025-10-23 15:32:00'::timestamptz); END IF;

  -- CC3055
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3055', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 00:00:00'::timestamptz, '2025-10-23 15:33:00'::timestamptz, '2025-10-23 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-10-23 15:33:00'::timestamptz); END IF;

  -- CC3056
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3056', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-23 00:00:00'::timestamptz, '2025-10-23 16:41:00'::timestamptz, '2025-10-23 15:50:00'::timestamptz, '2025-10-23 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-23 15:50:00'::timestamptz); END IF;

  -- CC3057
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3057', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 12:37:00'::timestamptz, '2025-10-24 10:56:00'::timestamptz, '2025-10-24 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-10-24 10:56:00'::timestamptz); END IF;

  -- CC3058
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 264;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3058', 'Anahi Rasines', false, 'completed', false, 11.92, 0.00, 0, 0.83, 12.75, 4.70, 1, 3, 'lavanderia', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 17:07:00'::timestamptz, '2025-10-24 11:30:00'::timestamptz, '2025-10-24 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.75, '2025-10-24 11:30:00'::timestamptz); END IF;

  -- CC3059
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3059', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '0', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 12:37:00'::timestamptz, '2025-10-24 12:37:00'::timestamptz, '2025-10-24 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-10-24 12:37:00'::timestamptz); END IF;

  -- CC3060
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3060', 'Luis Carlos Arosema', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'lavanderia', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 12:42:00'::timestamptz, '2025-10-24 12:40:00'::timestamptz, '2025-10-24 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-24 12:40:00'::timestamptz); END IF;

  -- CC3061
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3061', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 14:56:00'::timestamptz, '2025-10-24 13:45:00'::timestamptz, '2025-10-24 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-24 13:45:00'::timestamptz); END IF;

  -- CC3062
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3062', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 14:56:00'::timestamptz, '2025-10-24 14:54:00'::timestamptz, '2025-10-24 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-10-24 14:54:00'::timestamptz); END IF;

  -- CC3063
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3063', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 4, '', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 17:06:00'::timestamptz, '2025-10-24 15:10:00'::timestamptz, '2025-10-24 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-24 15:10:00'::timestamptz); END IF;

  -- CC3064
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3064', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 17:06:00'::timestamptz, '2025-10-24 16:08:00'::timestamptz, '2025-10-24 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-24 16:08:00'::timestamptz); END IF;

  -- CC3065
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3065', 'Renzo Mundo', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 7, 'Lavandería', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 17:06:00'::timestamptz, '2025-10-24 17:04:00'::timestamptz, '2025-10-24 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-10-24 17:04:00'::timestamptz); END IF;

  -- CC3066
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 155;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3066', 'Julissa', false, 'completed', false, 8.94, 0.00, 0, 0.56, 9.50, 3.40, 1, 2, '', '2025-10-24 00:00:00'::timestamptz, '2025-10-24 17:07:00'::timestamptz, '2025-10-24 17:05:00'::timestamptz, '2025-10-24 17:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.50, '2025-10-24 17:05:00'::timestamptz); END IF;

  -- CC3067
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3067', 'Israel Rentería', false, 'completed', false, 15.72, 0.00, 0, 1.03, 16.75, 6.30, 1, 2, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 08:09:00'::timestamptz, '2025-10-25 08:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.75, '2025-10-25 08:09:00'::timestamptz); END IF;

  -- CC3068
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3068', 'Fabio Nunez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 09:19:00'::timestamptz, '2025-10-25 09:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-25 09:19:00'::timestamptz); END IF;

  -- CC3069
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 262;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3069', 'Scott Schneider', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 0.00, 0, 5, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 10:20:00'::timestamptz, '2025-10-25 10:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.00, '2025-10-25 10:20:00'::timestamptz); END IF;

  -- CC3070
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3070', 'Gustavo Cumbrera', false, 'completed', false, 11.21, 2.00, 0, 0.79, 12.00, 0.00, 0, 7, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 10:47:00'::timestamptz, '2025-10-25 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-10-25 10:47:00'::timestamptz); END IF;

  -- CC3071
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3071', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 10:48:00'::timestamptz, '2025-10-25 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-25 10:48:00'::timestamptz); END IF;

  -- CC3072
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3072', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:12:00'::timestamptz, '2025-10-25 10:48:00'::timestamptz, '2025-10-25 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-25 10:48:00'::timestamptz); END IF;

  -- CC3073
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 17;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3073', 'Enrique Martínez', false, 'completed', false, 44.12, 0.00, 0, 2.88, 47.00, 17.60, 2, 4, '0', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:11:00'::timestamptz, '2025-10-25 11:09:00'::timestamptz, '2025-10-25 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 47.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 47.00, '2025-10-25 11:09:00'::timestamptz); END IF;

  -- CC3074
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3074', 'Cesar Malave', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 11:42:00'::timestamptz, '2025-10-25 11:41:00'::timestamptz, '2025-10-25 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-25 11:41:00'::timestamptz); END IF;

  -- CC3075
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 265;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3075', 'Jesus Robinson', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz, '2025-10-25 13:23:00'::timestamptz, '2025-10-25 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-25 13:23:00'::timestamptz); END IF;

  -- CC3076
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3076', 'Leonel Visueti', false, 'completed', false, 2.21, 0.00, 0, 0.09, 2.30, 0.00, 0, 5, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz, '2025-10-25 13:56:00'::timestamptz, '2025-10-25 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.30, '2025-10-25 13:56:00'::timestamptz); END IF;

  -- CC3077
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3077', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz, '2025-10-25 14:14:00'::timestamptz, '2025-10-25 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-10-25 14:14:00'::timestamptz); END IF;

  -- CC3078
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3078', 'Leonel Visueti', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz, '2025-10-25 14:15:00'::timestamptz, '2025-10-25 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-10-25 14:15:00'::timestamptz); END IF;

  -- CC3079
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3079', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 15:16:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz, '2025-10-25 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-10-25 14:32:00'::timestamptz); END IF;

  -- CC3080
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3080', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 15:16:00'::timestamptz, '2025-10-25 15:15:00'::timestamptz, '2025-10-25 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-10-25 15:15:00'::timestamptz); END IF;

  -- CC3081
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3081', 'Byron Moreno', false, 'completed', false, 11.62, 0.00, 0, 0.81, 12.43, 7.10, 1, 1, 'lavanderia', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 16:06:00'::timestamptz, '2025-10-25 16:05:00'::timestamptz, '2025-10-25 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.43, '2025-10-25 16:05:00'::timestamptz); END IF;

  -- CC3082
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3082', 'Renzo Mundo', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 5, 'Lavandería', '2025-10-25 00:00:00'::timestamptz, '2025-10-25 16:23:00'::timestamptz, '2025-10-25 16:21:00'::timestamptz, '2025-10-25 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-10-25 16:21:00'::timestamptz); END IF;

  -- CC3083
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3083', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-25 00:00:00'::timestamptz, '2025-10-27 10:11:00'::timestamptz, '2025-10-25 16:30:00'::timestamptz, '2025-10-25 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-25 16:30:00'::timestamptz); END IF;

  -- CC3084
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3084', 'Maribel Carruyo', false, 'completed', false, 12.21, 2.00, 0, 0.79, 13.00, 0.00, 0, 9, 'lavanderia', '2025-10-28 00:00:00'::timestamptz, '2025-10-27 10:11:00'::timestamptz, '2025-10-27 10:09:00'::timestamptz, '2025-10-27 10:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-10-27 10:09:00'::timestamptz); END IF;

  -- CC3085
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3085', 'German Alveo', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 2.40, 1, 3, 'Lavandería', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 12:03:00'::timestamptz, '2025-10-27 11:35:00'::timestamptz, '2025-10-27 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-10-27 11:35:00'::timestamptz); END IF;

  -- CC3086
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3086', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 13:07:00'::timestamptz, '2025-10-27 12:01:00'::timestamptz, '2025-10-27 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-10-27 12:01:00'::timestamptz); END IF;

  -- CC3087
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 266;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3087', 'Ulices Arroyo', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.40, 1, 2, 'lavanderia', '2025-10-27 00:00:00'::timestamptz, '2025-10-28 11:14:00'::timestamptz, '2025-10-27 12:59:00'::timestamptz, '2025-10-27 12:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-10-27 12:59:00'::timestamptz); END IF;

  -- CC3088
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3088', 'Leonel Visueti', false, 'completed', false, 15.45, 0.00, 0, 1.05, 16.50, 0.00, 0, 9, '', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 15:48:00'::timestamptz, '2025-10-27 13:15:00'::timestamptz, '2025-10-27 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.50, '2025-10-27 13:15:00'::timestamptz); END IF;

  -- CC3089
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3089', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 15:48:00'::timestamptz, '2025-10-27 14:25:00'::timestamptz, '2025-10-27 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-27 14:25:00'::timestamptz); END IF;

  -- CC3090
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3090', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 15:49:00'::timestamptz, '2025-10-27 14:25:00'::timestamptz, '2025-10-27 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-27 14:25:00'::timestamptz); END IF;

  -- CC3091
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3091', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 15:48:00'::timestamptz, '2025-10-27 15:47:00'::timestamptz, '2025-10-27 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-10-27 15:47:00'::timestamptz); END IF;

  -- CC3092
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3092', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-28 00:00:00'::timestamptz, '2025-10-27 15:49:00'::timestamptz, '2025-10-27 15:48:00'::timestamptz, '2025-10-27 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-10-27 15:48:00'::timestamptz); END IF;

  -- CC3093
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3093', 'Retail', true, 'completed', false, 1.05, 0.00, 0, 0.00, 1.05, 0.00, 0, 3, '', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 00:00:00'::timestamptz, '2025-10-27 16:00:00'::timestamptz, '2025-10-27 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.05, '2025-10-27 16:00:00'::timestamptz); END IF;

  -- CC3094
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3094', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-10-28 00:00:00'::timestamptz, '2025-10-27 16:29:00'::timestamptz, '2025-10-27 16:29:00'::timestamptz, '2025-10-27 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-10-27 16:29:00'::timestamptz); END IF;

  -- CC3095
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3095', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-10-27 00:00:00'::timestamptz, '2025-10-27 00:00:00'::timestamptz, '2025-10-27 16:31:00'::timestamptz, '2025-10-27 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-10-27 16:31:00'::timestamptz); END IF;

  -- CC3096
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 267;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3096', 'James Denhan', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 5, 'lavanderia', '2025-10-29 00:00:00'::timestamptz, '2025-10-28 15:49:00'::timestamptz, '2025-10-28 10:29:00'::timestamptz, '2025-10-28 10:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-28 10:29:00'::timestamptz); END IF;

  -- CC3097
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3097', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 10:31:00'::timestamptz, '2025-10-28 10:30:00'::timestamptz, '2025-10-28 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-28 10:30:00'::timestamptz); END IF;

  -- CC3098
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3098', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-28 10:32:00'::timestamptz, '2025-10-28 10:31:00'::timestamptz, '2025-10-28 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-28 10:31:00'::timestamptz); END IF;

  -- CC3099
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 268;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3099', 'Jeff Dunca', false, 'completed', false, 24.09, 0.00, 0, 1.69, 25.78, 3.91, 1, 4, 'lavanderia', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 11:10:00'::timestamptz, '2025-10-28 11:09:00'::timestamptz, '2025-10-28 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.78 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.78, '2025-10-28 11:09:00'::timestamptz); END IF;

  -- CC3100
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3100', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-28 11:30:00'::timestamptz, '2025-10-28 11:29:00'::timestamptz, '2025-10-28 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-28 11:29:00'::timestamptz); END IF;

  -- CC3101
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3101', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 15:49:00'::timestamptz, '2025-10-28 14:13:00'::timestamptz, '2025-10-28 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-28 14:13:00'::timestamptz); END IF;

  -- CC3102
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3102', 'Juan David VanSice', false, 'completed', false, 0.00, 27.25, 0, 0.00, 0.00, 10.90, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-10-28 00:00:00'::timestamptz, '2025-10-29 13:43:00'::timestamptz, '2025-10-28 14:14:00'::timestamptz, '2025-10-28 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-10-28 14:14:00'::timestamptz); END IF;

  -- CC3103
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3103', 'Leonel Visueti', false, 'completed', false, 2.10, 0.00, 0, 0.15, 2.25, 0.00, 0, 2, '', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 15:53:00'::timestamptz, '2025-10-28 15:52:00'::timestamptz, '2025-10-28 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.25, '2025-10-28 15:52:00'::timestamptz); END IF;

  -- CC3104
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 118;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3104', 'Sysco Panama', false, 'completed', false, 62.43, 0.00, 0, 3.95, 66.38, 24.15, 2, 7, 'Lavandería', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 16:49:00'::timestamptz, '2025-10-28 16:37:00'::timestamptz, '2025-10-28 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 66.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 66.38, '2025-10-28 16:37:00'::timestamptz); END IF;

  -- CC3105
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3105', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 17:00:00'::timestamptz, '2025-10-28 16:56:00'::timestamptz, '2025-10-28 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-28 16:56:00'::timestamptz); END IF;

  -- CC3106
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3106', 'Lina Perez', false, 'completed', false, 37.94, 2.00, 0, 2.06, 40.00, 3.60, 1, 22, 'Lavandería', '2025-10-28 00:00:00'::timestamptz, '2025-10-28 17:46:00'::timestamptz, '2025-10-28 17:29:00'::timestamptz, '2025-10-28 17:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 40.00, '2025-10-28 17:29:00'::timestamptz); END IF;

  -- CC3107
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3107', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-29 13:43:00'::timestamptz, '2025-10-29 11:09:00'::timestamptz, '2025-10-29 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-10-29 11:09:00'::timestamptz); END IF;

  -- CC3108
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3108', 'Leonel Visueti', false, 'completed', false, 8.89, 0.00, 0, 0.61, 9.50, 0.00, 0, 10, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-29 13:43:00'::timestamptz, '2025-10-29 12:50:00'::timestamptz, '2025-10-29 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.50, '2025-10-29 12:50:00'::timestamptz); END IF;

  -- CC3109
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3109', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-29 16:11:00'::timestamptz, '2025-10-29 16:11:00'::timestamptz, '2025-10-29 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-29 16:11:00'::timestamptz); END IF;

  -- CC3114
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3114', 'Karla Garibaldi', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 4, 'Lavandería', '2025-10-29 00:00:00'::timestamptz, '2025-10-29 16:39:00'::timestamptz, '2025-10-29 16:37:00'::timestamptz, '2025-10-29 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-10-29 16:37:00'::timestamptz); END IF;

  -- CC3115
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3115', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-10-29 00:00:00'::timestamptz, '2025-10-29 16:47:00'::timestamptz, '2025-10-29 16:45:00'::timestamptz, '2025-10-29 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-10-29 16:45:00'::timestamptz); END IF;

  -- CC3116
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 270;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3116', 'Oris Berrio', false, 'completed', false, 6.31, 0.00, 0, 0.44, 6.75, 2.70, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025103000000031161100129285333514, Fecha de autorización: 10/31/2025 9:43:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000096078', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:42:00'::timestamptz, '2025-10-30 11:33:00'::timestamptz, '2025-10-30 11:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.75, '2025-10-30 11:33:00'::timestamptz); END IF;

  -- CC3117
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3117', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025103000000031171100126741497783, Fecha de autorización: 10/30/2025 4:41:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000095600', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 15:15:00'::timestamptz, '2025-10-30 11:41:00'::timestamptz, '2025-10-30 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-10-30 11:41:00'::timestamptz); END IF;

  -- CC3118
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3118', 'German Alveo', false, 'completed', false, 51.87, 0.00, 0, 3.63, 55.50, 16.60, 7, 3, 'Lavandería', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 13:22:00'::timestamptz, '2025-10-30 11:44:00'::timestamptz, '2025-10-30 11:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 55.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 55.50, '2025-10-30 11:44:00'::timestamptz); END IF;

  -- CC3119
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3119', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025103000000031191100121781757855, Fecha de autorización: 10/30/2025 5:53:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000095625', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 15:14:00'::timestamptz, '2025-10-30 12:53:00'::timestamptz, '2025-10-30 12:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-10-30 12:53:00'::timestamptz); END IF;

  -- CC3120
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3120', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025103000000031201100127666940851, Fecha de autorización: 10/30/2025 6:00:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000095627', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 15:14:00'::timestamptz, '2025-10-30 13:00:00'::timestamptz, '2025-10-30 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-10-30 13:00:00'::timestamptz); END IF;

  -- CC3121
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3121', 'Julissa Rivera', false, 'completed', false, 11.98, 0.00, 0, 0.77, 12.75, 4.70, 1, 2, 'lavanderia', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 15:28:00'::timestamptz, '2025-10-30 13:10:00'::timestamptz, '2025-10-30 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.75, '2025-10-30 13:10:00'::timestamptz); END IF;

  -- CC3122
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3122', 'Karla Garibaldi', false, 'completed', false, 11.71, 0.00, 0, 0.79, 12.50, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025103000000031221100120153872735, Fecha de autorización: 10/30/2025 8:10:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000095658', '2025-10-30 00:00:00'::timestamptz, '2025-10-31 12:33:00'::timestamptz, '2025-10-30 15:10:00'::timestamptz, '2025-10-30 15:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.50, '2025-10-30 15:10:00'::timestamptz); END IF;

  -- CC3123
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3123', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025103000000031231100124532018464, Fecha de autorización: 10/30/2025 8:13:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000095659', '2025-10-30 00:00:00'::timestamptz, '2025-10-30 15:14:00'::timestamptz, '2025-10-30 15:13:00'::timestamptz, '2025-10-30 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-10-30 15:13:00'::timestamptz); END IF;

  -- CC3126
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3126', 'German Alveo', false, 'completed', false, 24.35, 0.00, 0, 1.70, 26.05, 7.50, 2, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025103100000031261100123368007860, Fecha de autorización: 10/31/2025 9:14:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000096065', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:14:00'::timestamptz, '2025-10-31 09:56:00'::timestamptz, '2025-10-31 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.05, '2025-10-31 09:56:00'::timestamptz); END IF;

  -- CC3127
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3127', 'Israel Rentería', false, 'completed', false, 15.72, 0.00, 0, 1.03, 16.75, 6.30, 1, 2, '  FE generada: FE0120000155737034-2-2023-3800002025103100000031271100126427345139, Fecha de autorización: 10/31/2025 4:04:15 p. m., Protocolo autorización 00001528364-1-65300620250000000000095946', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:42:00'::timestamptz, '2025-10-31 11:04:00'::timestamptz, '2025-10-31 11:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.75, '2025-10-31 11:04:00'::timestamptz); END IF;

  -- CC3128
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3128', 'Juan David VanSice', false, 'completed', false, 0.00, 32.00, 0, 0.00, 0.00, 12.80, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-11-01 00:00:00'::timestamptz, '2025-10-31 16:42:00'::timestamptz, '2025-10-31 12:31:00'::timestamptz, '2025-10-31 12:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-10-31 12:31:00'::timestamptz); END IF;

  -- CC3129
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 270;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3129', 'Oris Berrio', false, 'completed', false, 12.15, 0.00, 0, 0.85, 13.00, 5.20, 2, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025103100000031291100121861122639, Fecha de autorización: 10/31/2025 5:57:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000096012', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:42:00'::timestamptz, '2025-10-31 12:57:00'::timestamptz, '2025-10-31 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-10-31 12:57:00'::timestamptz); END IF;

  -- CC3130
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3130', 'Renzo Mundo', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025103100000031301100129452832695, Fecha de autorización: 10/31/2025 7:29:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000096042', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 14:32:00'::timestamptz, '2025-10-31 14:29:00'::timestamptz, '2025-10-31 14:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-10-31 14:29:00'::timestamptz); END IF;

  -- CC3131
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3131', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025103100000031311100121828245727, Fecha de autorización: 10/31/2025 7:32:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000096044', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 14:32:00'::timestamptz, '2025-10-31 14:32:00'::timestamptz, '2025-10-31 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.50, '2025-10-31 14:32:00'::timestamptz); END IF;

  -- CC3132
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3132', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '  FE generada: FE0120000155737034-2-2023-3800002025103100000031321100127505256688, Fecha de autorización: 10/31/2025 8:37:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000096056', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 15:37:00'::timestamptz, '2025-10-31 15:37:00'::timestamptz, '2025-10-31 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-10-31 15:37:00'::timestamptz); END IF;

  -- CC3133
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3133', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025103100000031331100123455762824, Fecha de autorización: 10/31/2025 9:04:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000096060', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:42:00'::timestamptz, '2025-10-31 16:04:00'::timestamptz, '2025-10-31 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-10-31 16:04:00'::timestamptz); END IF;

  -- CC3134
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3134', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025103100000031341100125465596687, Fecha de autorización: 10/31/2025 9:42:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000096076', '2025-10-31 00:00:00'::timestamptz, '2025-10-31 00:00:00'::timestamptz, '2025-10-31 16:41:00'::timestamptz, '2025-10-31 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-10-31 16:41:00'::timestamptz); END IF;

  -- CC3135
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3135', 'Leonel Willson', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '0  FE generada: FE0120000155737034-2-2023-3800002025110100000031351100120321385403, Fecha de autorización: 11/01/2025 1:43:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000096282', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 10:28:00'::timestamptz, '2025-11-01 08:43:00'::timestamptz, '2025-11-01 08:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-11-01 08:43:00'::timestamptz); END IF;

  -- CC3136
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 271;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3136', 'Reyneiro Santamaria', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031361100124905299187, Fecha de autorización: 11/01/2025 2:14:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000096289', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 12:35:00'::timestamptz, '2025-11-01 09:14:00'::timestamptz, '2025-11-01 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-01 09:14:00'::timestamptz); END IF;

  -- CC3137
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3137', 'Leonel Visueti', false, 'completed', false, 2.62, 0.00, 0, 0.13, 2.75, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031371100120792131730, Fecha de autorización: 11/01/2025 2:25:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000096292', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 10:28:00'::timestamptz, '2025-11-01 09:25:00'::timestamptz, '2025-11-01 09:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2025-11-01 09:25:00'::timestamptz); END IF;

  -- CC3138
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3138', 'Virginia Gonzalez', false, 'completed', false, 13.20, 2.00, 0, 0.80, 14.00, 0.00, 0, 9, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110100000031381100127566485795, Fecha de autorización: 11/01/2025 3:26:06 p. m., Protocolo autorización 00001528364-1-65300620250000000000096314', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 10:28:00'::timestamptz, '2025-11-01 10:26:00'::timestamptz, '2025-11-01 10:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-01 10:26:00'::timestamptz); END IF;

  -- CC3139
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3139', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031391100129788030127, Fecha de autorización: 11/01/2025 3:40:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000096321', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 12:35:00'::timestamptz, '2025-11-01 10:40:00'::timestamptz, '2025-11-01 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-01 10:40:00'::timestamptz); END IF;

  -- CC3140
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3140', 'Cesar Malave', false, 'completed', false, 15.07, 2.00, 0, 0.93, 16.00, 0.00, 0, 10, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025110100000031401100126259453157, Fecha de autorización: 11/01/2025 4:50:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000096349', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 12:35:00'::timestamptz, '2025-11-01 11:49:00'::timestamptz, '2025-11-01 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-11-01 11:49:00'::timestamptz); END IF;

  -- CC3141
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3141', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031411100121010459873, Fecha de autorización: 11/01/2025 6:17:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000096369', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 13:17:00'::timestamptz, '2025-11-01 13:16:00'::timestamptz, '2025-11-01 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-11-01 13:16:00'::timestamptz); END IF;

  -- CC3142
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3142', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031421100122977831830, Fecha de autorización: 11/01/2025 7:01:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000096380', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 15:39:00'::timestamptz, '2025-11-01 14:01:00'::timestamptz, '2025-11-01 14:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-01 14:01:00'::timestamptz); END IF;

  -- CC3143
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3143', 'Renzo Mundo', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110100000031431100125424680733, Fecha de autorización: 11/01/2025 8:13:45 p. m., Protocolo autorización 00001528364-1-65300620250000000000096411', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 15:39:00'::timestamptz, '2025-11-01 15:13:00'::timestamptz, '2025-11-01 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-01 15:13:00'::timestamptz); END IF;

  -- CC3144
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3144', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110100000031441100124390363506, Fecha de autorización: 11/01/2025 8:14:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000096413', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 15:39:00'::timestamptz, '2025-11-01 15:14:00'::timestamptz, '2025-11-01 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-01 15:14:00'::timestamptz); END IF;

  -- CC3145
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3145', 'Oscar Oropeza', false, 'completed', false, 16.82, 2.00, 0, 1.18, 18.00, 0.00, 0, 10, 'Lavandería', '2025-11-01 00:00:00'::timestamptz, '2025-11-01 15:39:00'::timestamptz, '2025-11-01 15:36:00'::timestamptz, '2025-11-01 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-11-01 15:36:00'::timestamptz); END IF;

  -- CC3146
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 272;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3146', 'Judith Adrian', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, '', '2025-11-01 00:00:00'::timestamptz, '2025-11-08 16:35:00'::timestamptz, '2025-11-01 15:46:00'::timestamptz, '2025-11-01 15:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-11-01 15:46:00'::timestamptz); END IF;

  -- CC3147
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3147', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025110100000031471100126147898228, Fecha de autorización: 11/01/2025 9:39:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000096452', '2025-11-01 00:00:00'::timestamptz, '2025-11-06 10:59:00'::timestamptz, '2025-11-01 16:39:00'::timestamptz, '2025-11-01 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-01 16:39:00'::timestamptz); END IF;

  -- CC3148
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3148', 'German Alveo', false, 'completed', false, 6.06, 0.00, 0, 0.42, 6.48, 3.70, 1, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110600000031481100126388038645, Fecha de autorización: 11/06/2025 8:13:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000097478', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 15:13:00'::timestamptz, '2025-11-06 10:41:00'::timestamptz, '2025-11-06 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.48, '2025-11-06 10:41:00'::timestamptz); END IF;

  -- CC3149
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3149', 'Leonel Visueti', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025110600000031491100126739151864, Fecha de autorización: 11/06/2025 3:57:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000097338', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 12:15:00'::timestamptz, '2025-11-06 10:57:00'::timestamptz, '2025-11-06 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-06 10:57:00'::timestamptz); END IF;

  -- CC3150
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3150', 'Maribel Carruyo', false, 'completed', false, 11.21, 2.00, 0, 0.79, 12.00, 0.00, 0, 7, 'lavanderia', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 11:26:00'::timestamptz, '2025-11-06 11:22:00'::timestamptz, '2025-11-06 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-11-06 11:22:00'::timestamptz); END IF;

  -- CC3151
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3151', 'Leonel Visueti', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, '  FE generada: FE0120000155737034-2-2023-3800002025110600000031511100128430382413, Fecha de autorización: 11/06/2025 5:14:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000097381', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 12:22:00'::timestamptz, '2025-11-06 12:14:00'::timestamptz, '2025-11-06 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-11-06 12:14:00'::timestamptz); END IF;

  -- CC3152
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3152', 'Maribel Carruyo', false, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, 'lavanderia', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 12:22:00'::timestamptz, '2025-11-06 12:18:00'::timestamptz, '2025-11-06 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-11-06 12:18:00'::timestamptz); END IF;

  -- CC3153
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3153', 'Julissa Rivera', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.10, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025110600000031531100122109287472, Fecha de autorización: 11/06/2025 5:29:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000097397', '2025-11-07 00:00:00'::timestamptz, '2025-11-06 16:48:00'::timestamptz, '2025-11-06 12:29:00'::timestamptz, '2025-11-06 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-11-06 12:29:00'::timestamptz); END IF;

  -- CC3154
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3154', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 15:34:00'::timestamptz, '2025-11-06 13:25:00'::timestamptz, '2025-11-06 13:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-06 13:25:00'::timestamptz); END IF;

  -- CC3155
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3155', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025110600000031551100121903694378, Fecha de autorización: 11/06/2025 7:26:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000097455', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 15:34:00'::timestamptz, '2025-11-06 14:26:00'::timestamptz, '2025-11-06 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-06 14:26:00'::timestamptz); END IF;

  -- CC3156
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3156', 'German Alveo', false, 'completed', false, 36.21, 0.00, 0, 2.54, 38.75, 15.50, 6, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110600000031561100125998335820, Fecha de autorización: 11/06/2025 8:13:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000097477', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 15:13:00'::timestamptz, '2025-11-06 14:44:00'::timestamptz, '2025-11-06 14:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 38.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 38.75, '2025-11-06 14:44:00'::timestamptz); END IF;

  -- CC3157
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3157', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 15:41:00'::timestamptz, '2025-11-06 15:40:00'::timestamptz, '2025-11-06 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-06 15:40:00'::timestamptz); END IF;

  -- CC3158
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3158', 'Leonel Visueti', false, 'completed', false, 5.84, 0.00, 0, 0.41, 6.25, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025110600000031581100123286953220, Fecha de autorización: 11/06/2025 9:48:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000097521', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 16:48:00'::timestamptz, '2025-11-06 16:21:00'::timestamptz, '2025-11-06 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.25, '2025-11-06 16:21:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 6: Imported orders 2501 to 3000';
END $$;
