-- =============================================
-- CleanCloud Orders Import - Part 3 of 7
-- Orders 1001 to 1500 (of 3472)
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


  -- CC1138
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1138', 'Leonel Visueti', false, 'completed', false, 4.80, 0.07, 0, 0.20, 5.00, 0.00, 0, 4, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 17:28:00'::timestamptz, '2024-10-21 16:32:00'::timestamptz, '2024-10-21 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-21 16:32:00'::timestamptz); END IF;

  -- CC1139
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1139', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 5, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 00:00:00'::timestamptz, '2024-10-21 16:55:00'::timestamptz, '2024-10-21 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-21 16:55:00'::timestamptz); END IF;

  -- CC1140
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1140', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 4, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 00:00:00'::timestamptz, '2024-10-21 16:57:00'::timestamptz, '2024-10-21 16:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-10-21 16:57:00'::timestamptz); END IF;

  -- CC1141
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1141', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 2, '', '2024-10-21 00:00:00'::timestamptz, '2024-10-21 00:00:00'::timestamptz, '2024-10-21 17:00:00'::timestamptz, '2024-10-21 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-10-21 17:00:00'::timestamptz); END IF;

  -- CC1142
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1142', 'Leonel Visueti', false, 'completed', false, 4.21, 0.03, 0, 0.29, 4.50, 0.00, 0, 4, '', '2024-10-22 00:00:00'::timestamptz, '2024-10-23 11:47:00'::timestamptz, '2024-10-22 15:47:00'::timestamptz, '2024-10-22 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-10-22 15:47:00'::timestamptz); END IF;

  -- CC1143
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1143', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-10-22 00:00:00'::timestamptz, '2024-10-22 00:00:00'::timestamptz, '2024-10-22 15:49:00'::timestamptz, '2024-10-22 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-10-22 15:49:00'::timestamptz); END IF;

  -- CC1144
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1144', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.88, 0.00, 0, 1.11, 16.99, 6.35, 2, 1, 'Salón', '2024-10-23 00:00:00'::timestamptz, '2024-10-23 12:02:00'::timestamptz, '2024-10-23 11:45:00'::timestamptz, '2024-10-23 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.99, '2024-10-23 11:45:00'::timestamptz); END IF;

  -- CC1145
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1145', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2024-10-23 00:00:00'::timestamptz, '2024-10-25 13:20:00'::timestamptz, '2024-10-23 12:40:00'::timestamptz, '2024-10-23 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-23 12:40:00'::timestamptz); END IF;

  -- CC1146
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1146', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-10-23 00:00:00'::timestamptz, '2024-10-23 16:09:00'::timestamptz, '2024-10-23 14:32:00'::timestamptz, '2024-10-23 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-23 14:32:00'::timestamptz); END IF;

  -- CC1147
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1147', 'Retail', true, 'completed', false, 7.50, 0.00, 0, 0.00, 7.50, 0.00, 0, 9, '', '2024-10-23 00:00:00'::timestamptz, '2024-10-23 00:00:00'::timestamptz, '2024-10-23 15:00:00'::timestamptz, '2024-10-23 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2024-10-23 15:00:00'::timestamptz); END IF;

  -- CC1148
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1148', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 4, '', '2024-10-23 00:00:00'::timestamptz, '2024-10-23 00:00:00'::timestamptz, '2024-10-23 15:16:00'::timestamptz, '2024-10-23 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-10-23 15:16:00'::timestamptz); END IF;

  -- CC1149
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1149', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-24 00:00:00'::timestamptz, '2024-10-25 13:20:00'::timestamptz, '2024-10-24 13:37:00'::timestamptz, '2024-10-24 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-24 13:37:00'::timestamptz); END IF;

  -- CC1150
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1150', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2024-10-24 00:00:00'::timestamptz, '2024-10-24 00:00:00'::timestamptz, '2024-10-24 16:18:00'::timestamptz, '2024-10-24 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-24 16:18:00'::timestamptz); END IF;

  -- CC1151
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1151', 'Guzmán', false, 'completed', false, 17.25, 0.00, 0, 1.21, 18.46, 6.90, 3, 1, '', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 13:20:00'::timestamptz, '2024-10-25 12:10:00'::timestamptz, '2024-10-25 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.46, '2024-10-25 12:10:00'::timestamptz); END IF;

  -- CC1152
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1152', 'Guzmán', false, 'completed', false, 6.13, 0.00, 0, 0.43, 6.56, 2.45, 2, 1, '', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 13:20:00'::timestamptz, '2024-10-25 12:10:00'::timestamptz, '2024-10-25 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.56, '2024-10-25 12:10:00'::timestamptz); END IF;

  -- CC1153
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1153', 'Guzmán', false, 'completed', false, 7.35, 0.00, 0, 0.51, 7.86, 4.20, 1, 1, '', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 15:17:00'::timestamptz, '2024-10-25 14:38:00'::timestamptz, '2024-10-25 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.86 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.86, '2024-10-25 14:38:00'::timestamptz); END IF;

  -- CC1154
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1154', 'Aaron Gutierrez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 16:06:00'::timestamptz, '2024-10-25 14:39:00'::timestamptz, '2024-10-25 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-25 14:39:00'::timestamptz); END IF;

  -- CC1155
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1155', 'Erick Rodriguez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 16:06:00'::timestamptz, '2024-10-25 14:41:00'::timestamptz, '2024-10-25 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-25 14:41:00'::timestamptz); END IF;

  -- CC1156
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1156', 'Fany Luz Salon', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-10-25 00:00:00'::timestamptz, '2024-10-26 11:13:00'::timestamptz, '2024-10-25 15:56:00'::timestamptz, '2024-10-25 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-25 15:56:00'::timestamptz); END IF;

  -- CC1157
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1157', 'Tairis - Diego', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '0', '2024-10-25 00:00:00'::timestamptz, '2024-10-26 11:13:00'::timestamptz, '2024-10-25 16:04:00'::timestamptz, '2024-10-25 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-10-25 16:04:00'::timestamptz); END IF;

  -- CC1158
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1158', 'Retail', true, 'completed', false, 5.16, 0.09, 0, 0.09, 5.25, 0.00, 0, 9, '', '2024-10-25 00:00:00'::timestamptz, '2024-10-25 00:00:00'::timestamptz, '2024-10-25 17:14:00'::timestamptz, '2024-10-25 17:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2024-10-25 17:14:00'::timestamptz); END IF;

  -- CC1159
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1159', 'Yatzury Anderson', false, 'completed', false, 14.95, 0.01, 0, 1.05, 16.00, 0.00, 0, 8, '', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 12:38:00'::timestamptz, '2024-10-26 11:13:00'::timestamptz, '2024-10-26 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-10-26 11:13:00'::timestamptz); END IF;

  -- CC1160
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1160', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 12:18:00'::timestamptz, '2024-10-26 11:15:00'::timestamptz, '2024-10-26 11:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-26 11:15:00'::timestamptz); END IF;

  -- CC1161
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1161', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 12:20:00'::timestamptz, '2024-10-26 11:37:00'::timestamptz, '2024-10-26 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-26 11:37:00'::timestamptz); END IF;

  -- CC1162
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1162', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 13:00:00'::timestamptz, '2024-10-26 12:22:00'::timestamptz, '2024-10-26 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-26 12:22:00'::timestamptz); END IF;

  -- CC1163
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1163', 'Yatzury Anderson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 13:00:00'::timestamptz, '2024-10-26 12:39:00'::timestamptz, '2024-10-26 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-26 12:39:00'::timestamptz); END IF;

  -- CC1164
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1164', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 15:44:00'::timestamptz, '2024-10-26 12:42:00'::timestamptz, '2024-10-26 12:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-26 12:42:00'::timestamptz); END IF;

  -- CC1165
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 89;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1165', 'María Sandoval', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2024-10-26 00:00:00'::timestamptz, '2024-10-27 08:58:00'::timestamptz, '2024-10-26 16:00:00'::timestamptz, '2024-10-26 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-26 16:00:00'::timestamptz); END IF;

  -- CC1166
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1166', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 3, '', '2024-10-26 00:00:00'::timestamptz, '2024-10-26 00:00:00'::timestamptz, '2024-10-26 16:02:00'::timestamptz, '2024-10-26 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-26 16:02:00'::timestamptz); END IF;

  -- CC1167
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1167', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 10:06:00'::timestamptz, '2024-10-27 09:00:00'::timestamptz, '2024-10-27 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-27 09:00:00'::timestamptz); END IF;

  -- CC1168
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1168', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 10:59:00'::timestamptz, '2024-10-27 10:06:00'::timestamptz, '2024-10-27 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-27 10:06:00'::timestamptz); END IF;

  -- CC1169
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1169', 'Yatzury Anderson', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 2, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 10:59:00'::timestamptz, '2024-10-27 10:08:00'::timestamptz, '2024-10-27 10:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-10-27 10:08:00'::timestamptz); END IF;

  -- CC1170
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1170', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 6, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 12:28:00'::timestamptz, '2024-10-27 11:00:00'::timestamptz, '2024-10-27 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-27 11:00:00'::timestamptz); END IF;

  -- CC1171
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1171', 'Yatzury Anderson', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 12:28:00'::timestamptz, '2024-10-27 11:14:00'::timestamptz, '2024-10-27 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-10-27 11:14:00'::timestamptz); END IF;

  -- CC1172
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1172', 'Cliente Lavandería', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-10-28 00:00:00'::timestamptz, '2024-10-27 12:28:00'::timestamptz, '2024-10-27 11:38:00'::timestamptz, '2024-10-27 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-27 11:38:00'::timestamptz); END IF;

  -- CC1173
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1173', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 17.13, 0.00, 0, 1.20, 18.33, 6.85, 2, 1, 'Salón', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 12:40:00'::timestamptz, '2024-10-27 12:29:00'::timestamptz, '2024-10-27 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.33 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.33, '2024-10-27 12:29:00'::timestamptz); END IF;

  -- CC1174
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1174', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 13:33:00'::timestamptz, '2024-10-27 12:36:00'::timestamptz, '2024-10-27 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-27 12:36:00'::timestamptz); END IF;

  -- CC1175
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1175', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 13:33:00'::timestamptz, '2024-10-27 12:43:00'::timestamptz, '2024-10-27 12:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-27 12:43:00'::timestamptz); END IF;

  -- CC1176
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 110;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1176', 'Milagros Cedeno', false, 'completed', false, 18.69, 0.27, 0, 1.31, 20.00, 0.00, 0, 12, 'Lavandería', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 15:31:00'::timestamptz, '2024-10-27 13:38:00'::timestamptz, '2024-10-27 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-10-27 13:38:00'::timestamptz); END IF;

  -- CC1177
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1177', 'Oscar Oropeza', false, 'completed', false, 11.22, 0.00, 0, 0.79, 12.01, 0.00, 0, 6, 'Lavandería', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 15:36:00'::timestamptz, '2024-10-27 15:35:00'::timestamptz, '2024-10-27 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-10-27 15:35:00'::timestamptz); END IF;

  -- CC1178
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1178', 'Oscar Oropeza', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, 'Lavandería', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 15:39:00'::timestamptz, '2024-10-27 15:38:00'::timestamptz, '2024-10-27 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-10-27 15:38:00'::timestamptz); END IF;

  -- CC1179
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1179', 'Oscar Oropeza', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 16:28:00'::timestamptz, '2024-10-27 15:40:00'::timestamptz, '2024-10-27 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-27 15:40:00'::timestamptz); END IF;

  -- CC1180
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1180', 'Retail', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 00:00:00'::timestamptz, '2024-10-27 16:19:00'::timestamptz, '2024-10-27 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-10-27 16:19:00'::timestamptz); END IF;

  -- CC1181
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1181', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 16:40:00'::timestamptz, '2024-10-27 16:36:00'::timestamptz, '2024-10-27 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-27 16:36:00'::timestamptz); END IF;

  -- CC1182
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1182', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 2, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 00:00:00'::timestamptz, '2024-10-27 16:38:00'::timestamptz, '2024-10-27 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-10-27 16:38:00'::timestamptz); END IF;

  -- CC1183
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1183', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-10-27 00:00:00'::timestamptz, '2024-10-27 16:42:00'::timestamptz, '2024-10-27 16:41:00'::timestamptz, '2024-10-27 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-27 16:41:00'::timestamptz); END IF;

  -- CC1184
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1184', 'Lineth', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 11:31:00'::timestamptz, '2024-10-28 10:04:00'::timestamptz, '2024-10-28 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-10-28 10:04:00'::timestamptz); END IF;

  -- CC1185
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1185', 'Leonel Visueti', false, 'completed', false, 4.67, 0.20, 0, 0.33, 5.00, 0.00, 0, 4, '', '2024-10-29 00:00:00'::timestamptz, '2024-10-28 10:07:00'::timestamptz, '2024-10-28 10:06:00'::timestamptz, '2024-10-28 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-28 10:06:00'::timestamptz); END IF;

  -- CC1186
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1186', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 00:00:00'::timestamptz, '2024-10-28 10:28:00'::timestamptz, '2024-10-28 10:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-10-28 10:28:00'::timestamptz); END IF;

  -- CC1187
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1187', 'Lineth', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 13:59:00'::timestamptz, '2024-10-28 11:32:00'::timestamptz, '2024-10-28 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-28 11:32:00'::timestamptz); END IF;

  -- CC1188
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1188', 'Academia Jireh', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 0.80, 1, 4, '0', '2024-10-28 00:00:00'::timestamptz, '2024-10-29 13:16:00'::timestamptz, '2024-10-28 11:44:00'::timestamptz, '2024-10-28 11:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-10-28 11:44:00'::timestamptz); END IF;

  -- CC1189
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1189', 'Lineth', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 16:10:00'::timestamptz, '2024-10-28 16:02:00'::timestamptz, '2024-10-28 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-28 16:02:00'::timestamptz); END IF;

  -- CC1190
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1190', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 16:18:00'::timestamptz, '2024-10-28 16:12:00'::timestamptz, '2024-10-28 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-28 16:12:00'::timestamptz); END IF;

  -- CC1191
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1191', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-29 00:00:00'::timestamptz, '2024-10-28 16:37:00'::timestamptz, '2024-10-28 16:35:00'::timestamptz, '2024-10-28 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-28 16:35:00'::timestamptz); END IF;

  -- CC1192
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1192', 'Yara Rangel', false, 'completed', false, 23.43, 0.01, 0, 1.57, 25.00, 0.00, 0, 13, '0', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 16:38:00'::timestamptz, '2024-10-28 16:36:00'::timestamptz, '2024-10-28 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.00, '2024-10-28 16:36:00'::timestamptz); END IF;

  -- CC1193
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1193', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 16:41:00'::timestamptz, '2024-10-28 16:39:00'::timestamptz, '2024-10-28 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-28 16:39:00'::timestamptz); END IF;

  -- CC1194
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1194', 'Yatzury Anderson', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 16:41:00'::timestamptz, '2024-10-28 16:40:00'::timestamptz, '2024-10-28 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-28 16:40:00'::timestamptz); END IF;

  -- CC1195
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1195', 'Leonel Visueti', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 17:24:00'::timestamptz, '2024-10-28 16:42:00'::timestamptz, '2024-10-28 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-10-28 16:42:00'::timestamptz); END IF;

  -- CC1196
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1196', 'Yatzury Anderson', false, 'completed', false, 7.86, 0.00, 0, 0.39, 8.25, 0.00, 0, 5, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 17:24:00'::timestamptz, '2024-10-28 17:23:00'::timestamptz, '2024-10-28 17:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.25, '2024-10-28 17:23:00'::timestamptz); END IF;

  -- CC1197
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1197', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-10-28 00:00:00'::timestamptz, '2024-10-28 00:00:00'::timestamptz, '2024-10-28 17:29:00'::timestamptz, '2024-10-28 17:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-10-28 17:29:00'::timestamptz); END IF;

  -- CC1198
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1198', 'Aaron Gutierrez', false, 'completed', false, 11.22, 0.26, 0, 0.79, 12.01, 0.00, 0, 8, 'Lavandería', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 13:27:00'::timestamptz, '2024-10-29 13:19:00'::timestamptz, '2024-10-29 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-10-29 13:19:00'::timestamptz); END IF;

  -- CC1199
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1199', 'Aaron Gutierrez', false, 'completed', false, 5.67, 0.07, 0, 0.33, 6.00, 0.00, 0, 8, 'Lavandería', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 13:27:00'::timestamptz, '2024-10-29 13:23:00'::timestamptz, '2024-10-29 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-29 13:23:00'::timestamptz); END IF;

  -- CC1200
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1200', 'Leonel Visueti', false, 'completed', false, 16.82, 0.27, 0, 1.18, 18.00, 0.00, 0, 11, '', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 13:27:00'::timestamptz, '2024-10-29 13:26:00'::timestamptz, '2024-10-29 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-10-29 13:26:00'::timestamptz); END IF;

  -- CC1201
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1201', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 14:45:00'::timestamptz, '2024-10-29 13:28:00'::timestamptz, '2024-10-29 13:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-29 13:28:00'::timestamptz); END IF;

  -- CC1202
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1202', 'Cliente Lavandería', false, 'completed', false, 7.94, 0.04, 0, 0.56, 8.50, 0.00, 0, 6, 'Lavandería', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 15:48:00'::timestamptz, '2024-10-29 14:51:00'::timestamptz, '2024-10-29 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-10-29 14:51:00'::timestamptz); END IF;

  -- CC1203
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1203', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.00, 0.00, 0, 1.12, 17.12, 6.40, 2, 1, 'Salón', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 16:36:00'::timestamptz, '2024-10-29 15:50:00'::timestamptz, '2024-10-29 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.12 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.12, '2024-10-29 15:50:00'::timestamptz); END IF;

  -- CC1204
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1204', 'Leonel Visueti', false, 'completed', false, 6.26, 0.08, 0, 0.34, 6.60, 0.00, 0, 6, '', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 15:59:00'::timestamptz, '2024-10-29 15:58:00'::timestamptz, '2024-10-29 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.60, '2024-10-29 15:58:00'::timestamptz); END IF;

  -- CC1205
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1205', 'Leonel Visueti', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 4, '', '2024-10-29 00:00:00'::timestamptz, '2024-10-29 16:54:00'::timestamptz, '2024-10-29 16:54:00'::timestamptz, '2024-10-29 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-10-29 16:54:00'::timestamptz); END IF;

  -- CC1206
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1206', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-10-30 00:00:00'::timestamptz, '2024-10-30 16:52:00'::timestamptz, '2024-10-30 12:20:00'::timestamptz, '2024-10-30 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-30 12:20:00'::timestamptz); END IF;

  -- CC1207
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1207', 'Manuel Rueda', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-10-30 00:00:00'::timestamptz, '2024-10-30 13:35:00'::timestamptz, '2024-10-30 13:24:00'::timestamptz, '2024-10-30 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-30 13:24:00'::timestamptz); END IF;

  -- CC1208
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1208', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 6, '', '2024-10-30 00:00:00'::timestamptz, '2024-10-30 00:00:00'::timestamptz, '2024-10-30 16:02:00'::timestamptz, '2024-10-30 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-30 16:02:00'::timestamptz); END IF;

  -- CC1209
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1209', 'Leonel Visueti', false, 'completed', false, 5.64, 0.10, 0, 0.36, 6.00, 0.00, 0, 6, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 11:11:00'::timestamptz, '2024-10-31 09:28:00'::timestamptz, '2024-10-31 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-31 09:28:00'::timestamptz); END IF;

  -- CC1210
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1210', 'Yatzury Anderson', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 09:30:00'::timestamptz, '2024-10-31 09:29:00'::timestamptz, '2024-10-31 09:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-10-31 09:29:00'::timestamptz); END IF;

  -- CC1211
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1211', 'Retail', true, 'completed', false, 1.35, 0.00, 0, 0.00, 1.35, 0.00, 0, 2, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 00:00:00'::timestamptz, '2024-10-31 10:00:00'::timestamptz, '2024-10-31 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.35, '2024-10-31 10:00:00'::timestamptz); END IF;

  -- CC1212
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1212', 'Guzmán', false, 'completed', false, 1.93, 0.00, 0, 0.14, 2.07, 1.10, 1, 1, '', '2024-11-01 00:00:00'::timestamptz, '2024-10-31 14:27:00'::timestamptz, '2024-10-31 10:04:00'::timestamptz, '2024-10-31 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.07, '2024-10-31 10:04:00'::timestamptz); END IF;

  -- CC1213
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1213', 'Guzmán', false, 'completed', false, 7.00, 0.00, 0, 0.49, 7.49, 2.80, 2, 1, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 14:27:00'::timestamptz, '2024-10-31 11:08:00'::timestamptz, '2024-10-31 11:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.49, '2024-10-31 11:08:00'::timestamptz); END IF;

  -- CC1214
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1214', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 14:37:00'::timestamptz, '2024-10-31 11:13:00'::timestamptz, '2024-10-31 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-10-31 11:13:00'::timestamptz); END IF;

  -- CC1215
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1215', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 14:38:00'::timestamptz, '2024-10-31 14:37:00'::timestamptz, '2024-10-31 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-31 14:37:00'::timestamptz); END IF;

  -- CC1216
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1216', 'Liliana Zambrano', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 15:56:00'::timestamptz, '2024-10-31 15:28:00'::timestamptz, '2024-10-31 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-10-31 15:28:00'::timestamptz); END IF;

  -- CC1217
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1217', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 15:56:00'::timestamptz, '2024-10-31 15:29:00'::timestamptz, '2024-10-31 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-31 15:29:00'::timestamptz); END IF;

  -- CC1218
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1218', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-10-31 00:00:00'::timestamptz, '2024-11-01 08:16:00'::timestamptz, '2024-10-31 15:56:00'::timestamptz, '2024-10-31 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-10-31 15:56:00'::timestamptz); END IF;

  -- CC1219
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1219', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-10-31 00:00:00'::timestamptz, '2024-10-31 16:57:00'::timestamptz, '2024-10-31 16:16:00'::timestamptz, '2024-10-31 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-10-31 16:16:00'::timestamptz); END IF;

  -- CC1220
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1220', 'Guzmán', false, 'completed', false, 16.63, 0.00, 0, 1.16, 17.79, 6.65, 3, 1, '', '2024-11-01 00:00:00'::timestamptz, '2024-11-01 15:10:00'::timestamptz, '2024-11-01 12:33:00'::timestamptz, '2024-11-01 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.79, '2024-11-01 12:33:00'::timestamptz); END IF;

  -- CC1221
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1221', 'Yatzury Anderson', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-11-01 00:00:00'::timestamptz, '2024-11-01 13:35:00'::timestamptz, '2024-11-01 12:54:00'::timestamptz, '2024-11-01 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-01 12:54:00'::timestamptz); END IF;

  -- CC1222
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1222', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.50, 0.00, 0, 1.09, 16.59, 6.20, 2, 1, 'Salón', '2024-11-01 00:00:00'::timestamptz, '2024-11-01 14:18:00'::timestamptz, '2024-11-01 13:36:00'::timestamptz, '2024-11-01 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.59, '2024-11-01 13:36:00'::timestamptz); END IF;

  -- CC1223
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1223', 'Leonel Visueti', false, 'completed', false, 10.28, 0.20, 0, 0.72, 11.00, 0.00, 0, 7, '', '2024-11-01 00:00:00'::timestamptz, '2024-11-01 16:35:00'::timestamptz, '2024-11-01 14:19:00'::timestamptz, '2024-11-01 14:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-11-01 14:19:00'::timestamptz); END IF;

  -- CC1224
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1224', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-11-01 00:00:00'::timestamptz, '2024-11-01 16:35:00'::timestamptz, '2024-11-01 15:13:00'::timestamptz, '2024-11-01 15:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-01 15:13:00'::timestamptz); END IF;

  -- CC1225
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1225', 'Leonel Visueti', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '', '2024-11-03 00:00:00'::timestamptz, '2024-11-02 15:03:00'::timestamptz, '2024-11-02 15:03:00'::timestamptz, '2024-11-02 15:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-02 15:03:00'::timestamptz); END IF;

  -- CC1226
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1226', 'Yatzury Anderson', false, 'completed', false, 12.15, 0.20, 0, 0.85, 13.00, 0.00, 0, 8, '', '2024-11-02 00:00:00'::timestamptz, '2024-11-06 11:09:00'::timestamptz, '2024-11-02 15:15:00'::timestamptz, '2024-11-02 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2024-11-02 15:15:00'::timestamptz); END IF;

  -- CC1227
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1227', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-11-02 00:00:00'::timestamptz, '2024-11-06 11:09:00'::timestamptz, '2024-11-02 15:49:00'::timestamptz, '2024-11-02 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-02 15:49:00'::timestamptz); END IF;

  -- CC1228
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1228', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-02 00:00:00'::timestamptz, '2024-11-02 16:34:00'::timestamptz, '2024-11-02 15:51:00'::timestamptz, '2024-11-02 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-02 15:51:00'::timestamptz); END IF;

  -- CC1229
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1229', 'Lina Perez', false, 'completed', false, 16.72, 0.00, 0, 1.00, 17.72, 0.00, 0, 11, 'Lavandería', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 11:09:00'::timestamptz, '2024-11-06 09:30:00'::timestamptz, '2024-11-06 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.72 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.72, '2024-11-06 09:30:00'::timestamptz); END IF;

  -- CC1230
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1230', 'Leonel Willson', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 8, '0', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 14:42:00'::timestamptz, '2024-11-06 11:13:00'::timestamptz, '2024-11-06 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-06 11:13:00'::timestamptz); END IF;

  -- CC1231
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1231', 'Evy Ortega', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 2, '0', '2024-11-06 00:00:00'::timestamptz, '2024-11-07 10:07:00'::timestamptz, '2024-11-06 11:57:00'::timestamptz, '2024-11-06 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-11-06 11:57:00'::timestamptz); END IF;

  -- CC1232
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1232', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.90, 1, 1, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 15:17:00'::timestamptz, '2024-11-06 12:30:00'::timestamptz, '2024-11-06 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-11-06 12:30:00'::timestamptz); END IF;

  -- CC1233
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1233', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 14:44:00'::timestamptz, '2024-11-06 14:43:00'::timestamptz, '2024-11-06 14:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-06 14:43:00'::timestamptz); END IF;

  -- CC1234
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1234', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 16:29:00'::timestamptz, '2024-11-06 15:17:00'::timestamptz, '2024-11-06 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-06 15:17:00'::timestamptz); END IF;

  -- CC1235
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1235', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 13.50, 0.00, 0, 0.95, 14.45, 5.40, 1, 1, 'Salón', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 16:30:00'::timestamptz, '2024-11-06 15:36:00'::timestamptz, '2024-11-06 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.45 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.45, '2024-11-06 15:36:00'::timestamptz); END IF;

  -- CC1236
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1236', 'Erick Rodriguez', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, 'Lavandería', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 17:17:00'::timestamptz, '2024-11-06 15:43:00'::timestamptz, '2024-11-06 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-11-06 15:43:00'::timestamptz); END IF;

  -- CC1237
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1237', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 16:29:00'::timestamptz, '2024-11-06 15:45:00'::timestamptz, '2024-11-06 15:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-06 15:45:00'::timestamptz); END IF;

  -- CC1238
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1238', 'Retail', true, 'completed', false, 5.50, 0.00, 0, 0.00, 5.50, 0.00, 0, 8, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 00:00:00'::timestamptz, '2024-11-06 15:48:00'::timestamptz, '2024-11-06 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-11-06 15:48:00'::timestamptz); END IF;

  -- CC1239
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1239', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 17:17:00'::timestamptz, '2024-11-06 16:31:00'::timestamptz, '2024-11-06 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-06 16:31:00'::timestamptz); END IF;

  -- CC1240
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1240', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2024-11-06 00:00:00'::timestamptz, '2024-11-06 00:00:00'::timestamptz, '2024-11-06 16:52:00'::timestamptz, '2024-11-06 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-11-06 16:52:00'::timestamptz); END IF;

  -- CC1241
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1241', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 11:05:00'::timestamptz, '2024-11-07 10:07:00'::timestamptz, '2024-11-07 10:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-07 10:07:00'::timestamptz); END IF;

  -- CC1242
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1242', 'Liliana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 11:05:00'::timestamptz, '2024-11-07 10:13:00'::timestamptz, '2024-11-07 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-07 10:13:00'::timestamptz); END IF;

  -- CC1243
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1243', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 15:13:00'::timestamptz, '2024-11-07 11:33:00'::timestamptz, '2024-11-07 11:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-07 11:33:00'::timestamptz); END IF;

  -- CC1244
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1244', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-11-08 00:00:00'::timestamptz, '2024-11-07 16:38:00'::timestamptz, '2024-11-07 11:47:00'::timestamptz, '2024-11-07 11:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-07 11:47:00'::timestamptz); END IF;

  -- CC1245
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1245', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 00:00:00'::timestamptz, '2024-11-07 12:09:00'::timestamptz, '2024-11-07 12:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-07 12:09:00'::timestamptz); END IF;

  -- CC1246
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1246', 'Sheila Simons', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 15:13:00'::timestamptz, '2024-11-07 13:05:00'::timestamptz, '2024-11-07 13:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-11-07 13:05:00'::timestamptz); END IF;

  -- CC1247
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 28;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1247', 'Sheila Simons', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-11-07 00:00:00'::timestamptz, '2024-11-07 16:14:00'::timestamptz, '2024-11-07 15:14:00'::timestamptz, '2024-11-07 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-07 15:14:00'::timestamptz); END IF;

  -- CC1248
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1248', 'Guzmán', false, 'completed', false, 17.75, 0.00, 0, 1.24, 18.99, 7.10, 3, 1, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 15:25:00'::timestamptz, '2024-11-08 11:24:00'::timestamptz, '2024-11-08 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.99, '2024-11-08 11:24:00'::timestamptz); END IF;

  -- CC1249
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1249', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 00:00:00'::timestamptz, '2024-11-08 11:48:00'::timestamptz, '2024-11-08 11:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-08 11:48:00'::timestamptz); END IF;

  -- CC1250
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1250', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 00:00:00'::timestamptz, '2024-11-08 11:49:00'::timestamptz, '2024-11-08 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-08 11:49:00'::timestamptz); END IF;

  -- CC1251
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1251', 'Leonel Visueti', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 15:27:00'::timestamptz, '2024-11-08 15:26:00'::timestamptz, '2024-11-08 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-11-08 15:26:00'::timestamptz); END IF;

  -- CC1252
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1252', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 15:33:00'::timestamptz, '2024-11-08 15:31:00'::timestamptz, '2024-11-08 15:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-08 15:31:00'::timestamptz); END IF;

  -- CC1253
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1253', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 15:34:00'::timestamptz, '2024-11-08 15:33:00'::timestamptz, '2024-11-08 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-08 15:33:00'::timestamptz); END IF;

  -- CC1254
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1254', 'Renzo Mundo', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 17:12:00'::timestamptz, '2024-11-08 15:37:00'::timestamptz, '2024-11-08 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-08 15:37:00'::timestamptz); END IF;

  -- CC1255
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1255', 'Rene Guiñez', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-11-09 00:00:00'::timestamptz, '2024-11-08 17:12:00'::timestamptz, '2024-11-08 15:38:00'::timestamptz, '2024-11-08 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-08 15:38:00'::timestamptz); END IF;

  -- CC1256
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1256', 'Guzmán', false, 'completed', false, 8.22, 0.00, 0, 0.58, 8.80, 4.70, 1, 1, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 15:59:00'::timestamptz, '2024-11-08 15:40:00'::timestamptz, '2024-11-08 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.80 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.80, '2024-11-08 15:40:00'::timestamptz); END IF;

  -- CC1257
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1257', 'Guzmán', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 00:00:00'::timestamptz, '2024-11-08 16:15:00'::timestamptz, '2024-11-08 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-08 16:15:00'::timestamptz); END IF;

  -- CC1258
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1258', 'Oscar Oropeza', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 17:12:00'::timestamptz, '2024-11-08 16:17:00'::timestamptz, '2024-11-08 16:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-11-08 16:17:00'::timestamptz); END IF;

  -- CC1259
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1259', 'Oscar Oropeza', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 17:49:00'::timestamptz, '2024-11-08 17:13:00'::timestamptz, '2024-11-08 17:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-08 17:13:00'::timestamptz); END IF;

  -- CC1260
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1260', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-11-08 00:00:00'::timestamptz, '2024-11-08 17:22:00'::timestamptz, '2024-11-08 17:21:00'::timestamptz, '2024-11-08 17:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-08 17:21:00'::timestamptz); END IF;

  -- CC1261
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1261', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 12.50, 0.00, 0, 0.88, 13.38, 5.00, 2, 1, 'Salón', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 12:39:00'::timestamptz, '2024-11-09 12:00:00'::timestamptz, '2024-11-09 12:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.38, '2024-11-09 12:00:00'::timestamptz); END IF;

  -- CC1262
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1262', 'Yatzury Anderson', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 13:59:00'::timestamptz, '2024-11-09 12:25:00'::timestamptz, '2024-11-09 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-09 12:25:00'::timestamptz); END IF;

  -- CC1263
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1263', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 13:59:00'::timestamptz, '2024-11-09 12:25:00'::timestamptz, '2024-11-09 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-09 12:25:00'::timestamptz); END IF;

  -- CC1264
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1264', 'Cliente Lavandería', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 13:59:00'::timestamptz, '2024-11-09 12:27:00'::timestamptz, '2024-11-09 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-09 12:27:00'::timestamptz); END IF;

  -- CC1265
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1265', 'Yatzury Anderson', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 15:31:00'::timestamptz, '2024-11-09 14:14:00'::timestamptz, '2024-11-09 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-09 14:14:00'::timestamptz); END IF;

  -- CC1266
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1266', 'Leonel Visueti', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 17:01:00'::timestamptz, '2024-11-09 15:33:00'::timestamptz, '2024-11-09 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-11-09 15:33:00'::timestamptz); END IF;

  -- CC1267
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1267', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 2, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 00:00:00'::timestamptz, '2024-11-09 15:56:00'::timestamptz, '2024-11-09 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-11-09 15:56:00'::timestamptz); END IF;

  -- CC1268
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1268', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-11-09 00:00:00'::timestamptz, '2024-11-09 00:00:00'::timestamptz, '2024-11-09 16:21:00'::timestamptz, '2024-11-09 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-09 16:21:00'::timestamptz); END IF;

  -- CC1269
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1269', 'Sara Charles', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, 'Lavandería', '2024-11-10 00:00:00'::timestamptz, '2024-11-10 13:10:00'::timestamptz, '2024-11-10 12:21:00'::timestamptz, '2024-11-10 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-10 12:21:00'::timestamptz); END IF;

  -- CC1270
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1270', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-11-10 00:00:00'::timestamptz, '2024-11-10 00:00:00'::timestamptz, '2024-11-10 12:22:00'::timestamptz, '2024-11-10 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-11-10 12:22:00'::timestamptz); END IF;

  -- CC1271
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1271', 'Leonel Visueti', false, 'completed', false, 2.00, 0.00, 0, 0.14, 2.14, 0.00, 0, 4, '', '2024-11-10 00:00:00'::timestamptz, '2024-11-10 13:10:00'::timestamptz, '2024-11-10 12:23:00'::timestamptz, '2024-11-10 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.14 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.14, '2024-11-10 12:23:00'::timestamptz); END IF;

  -- CC1272
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1272', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 2, '', '2024-11-10 00:00:00'::timestamptz, '2024-11-10 00:00:00'::timestamptz, '2024-11-10 12:32:00'::timestamptz, '2024-11-10 12:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2024-11-10 12:32:00'::timestamptz); END IF;

  -- CC1273
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1273', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2024-11-10 00:00:00'::timestamptz, '2024-11-10 00:00:00'::timestamptz, '2024-11-10 12:36:00'::timestamptz, '2024-11-10 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-10 12:36:00'::timestamptz); END IF;

  -- CC1274
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 53;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1274', 'Miguel', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-11-12 00:00:00'::timestamptz, '2024-11-11 09:16:00'::timestamptz, '2024-11-11 08:06:00'::timestamptz, '2024-11-11 08:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-11 08:06:00'::timestamptz); END IF;

  -- CC1275
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1275', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 09:16:00'::timestamptz, '2024-11-11 08:24:00'::timestamptz, '2024-11-11 08:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-11 08:24:00'::timestamptz); END IF;

  -- CC1276
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1276', 'Leonel Visueti', false, 'completed', false, 20.94, 0.53, 0, 1.31, 22.25, 0.00, 0, 16, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 11:03:00'::timestamptz, '2024-11-11 11:02:00'::timestamptz, '2024-11-11 11:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.25, '2024-11-11 11:02:00'::timestamptz); END IF;

  -- CC1277
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1277', 'Leonel Visueti', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 11:39:00'::timestamptz, '2024-11-11 11:04:00'::timestamptz, '2024-11-11 11:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-11 11:04:00'::timestamptz); END IF;

  -- CC1278
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1278', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 11:39:00'::timestamptz, '2024-11-11 11:05:00'::timestamptz, '2024-11-11 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-11 11:05:00'::timestamptz); END IF;

  -- CC1279
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1279', 'Renzo Mundo', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, 'Lavandería', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 16:41:00'::timestamptz, '2024-11-11 11:16:00'::timestamptz, '2024-11-11 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-11 11:16:00'::timestamptz); END IF;

  -- CC1280
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1280', 'Retail', true, 'completed', false, 1.35, 0.00, 0, 0.00, 1.35, 0.00, 0, 3, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 00:00:00'::timestamptz, '2024-11-11 11:18:00'::timestamptz, '2024-11-11 11:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.35, '2024-11-11 11:18:00'::timestamptz); END IF;

  -- CC1281
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 113;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1281', 'Aneth Villamonte', false, 'completed', false, 9.35, 1.87, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 16:41:00'::timestamptz, '2024-11-11 11:43:00'::timestamptz, '2024-11-11 11:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-11-11 11:43:00'::timestamptz); END IF;

  -- CC1282
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 110;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1282', 'Milagros Cedeno', false, 'completed', false, 19.07, 0.01, 0, 1.18, 20.25, 0.00, 0, 12, 'Lavandería', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 16:41:00'::timestamptz, '2024-11-11 14:49:00'::timestamptz, '2024-11-11 14:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.25, '2024-11-11 14:49:00'::timestamptz); END IF;

  -- CC1283
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1283', 'Liliana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 16:41:00'::timestamptz, '2024-11-11 15:08:00'::timestamptz, '2024-11-11 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-11 15:08:00'::timestamptz); END IF;

  -- CC1284
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1284', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 00:00:00'::timestamptz, '2024-11-11 15:17:00'::timestamptz, '2024-11-11 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-11 15:17:00'::timestamptz); END IF;

  -- CC1285
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1285', 'Liliana', true, 'completed', false, 0.93, 0.07, 0, 0.07, 1.00, 0.00, 0, 1, '0', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 00:00:00'::timestamptz, '2024-11-11 15:32:00'::timestamptz, '2024-11-11 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-11-11 15:32:00'::timestamptz); END IF;

  -- CC1286
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1286', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-11-11 00:00:00'::timestamptz, '2024-11-11 00:00:00'::timestamptz, '2024-11-11 15:35:00'::timestamptz, '2024-11-11 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-11 15:35:00'::timestamptz); END IF;

  -- CC1287
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1287', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.40, 1, 1, '', '2024-11-12 00:00:00'::timestamptz, '2024-11-12 14:30:00'::timestamptz, '2024-11-12 11:30:00'::timestamptz, '2024-11-12 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-11-12 11:30:00'::timestamptz); END IF;

  -- CC1288
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1288', 'Leonel Visueti', false, 'completed', false, 8.24, 0.02, 0, 0.51, 8.75, 0.00, 0, 11, '', '2024-11-12 00:00:00'::timestamptz, '2024-11-12 17:32:00'::timestamptz, '2024-11-12 13:43:00'::timestamptz, '2024-11-12 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.75, '2024-11-12 13:43:00'::timestamptz); END IF;

  -- CC1289
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 114;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1289', 'Nuvia Melendez', false, 'completed', false, 90.40, 22.60, 0, 6.33, 96.73, 45.20, 11, 1, 'Lavandería', '2024-11-12 00:00:00'::timestamptz, '2024-11-12 17:07:00'::timestamptz, '2024-11-12 16:16:00'::timestamptz, '2024-11-12 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 96.73 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 96.73, '2024-11-12 16:16:00'::timestamptz); END IF;

  -- CC1290
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1290', 'Erick Rodriguez', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, 'Lavandería', '2024-11-12 00:00:00'::timestamptz, '2024-11-12 17:32:00'::timestamptz, '2024-11-12 16:52:00'::timestamptz, '2024-11-12 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-11-12 16:52:00'::timestamptz); END IF;

  -- CC1291
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1291', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 15:54:00'::timestamptz, '2024-11-13 11:11:00'::timestamptz, '2024-11-13 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-13 11:11:00'::timestamptz); END IF;

  -- CC1292
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 115;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1292', 'Nelsi Luque', false, 'completed', false, 14.02, 0.20, 0, 0.98, 15.00, 0.00, 0, 9, '0', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 15:54:00'::timestamptz, '2024-11-13 14:00:00'::timestamptz, '2024-11-13 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-11-13 14:00:00'::timestamptz); END IF;

  -- CC1293
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1293', 'Lineth', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 15:54:00'::timestamptz, '2024-11-13 14:18:00'::timestamptz, '2024-11-13 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-13 14:18:00'::timestamptz); END IF;

  -- CC1294
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1294', 'Guzmán', false, 'completed', false, 3.59, 0.00, 0, 0.25, 3.84, 2.05, 1, 1, '', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 16:11:00'::timestamptz, '2024-11-13 15:19:00'::timestamptz, '2024-11-13 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.84, '2024-11-13 15:19:00'::timestamptz); END IF;

  -- CC1295
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1295', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 00:00:00'::timestamptz, '2024-11-13 15:55:00'::timestamptz, '2024-11-13 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-11-13 15:55:00'::timestamptz); END IF;

  -- CC1296
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1296', 'Retail', true, 'completed', false, 1.35, 0.00, 0, 0.00, 1.35, 0.00, 0, 2, '', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 00:00:00'::timestamptz, '2024-11-13 15:56:00'::timestamptz, '2024-11-13 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.35, '2024-11-13 15:56:00'::timestamptz); END IF;

  -- CC1297
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 114;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1297', 'Nuvia Melendez', false, 'completed', false, 30.00, 0.00, 0, 2.10, 32.10, 12.00, 2, 1, 'Lavandería', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 17:23:00'::timestamptz, '2024-11-13 15:57:00'::timestamptz, '2024-11-13 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 32.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 32.10, '2024-11-13 15:57:00'::timestamptz); END IF;

  -- CC1298
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1298', 'Yatzury Anderson', false, 'completed', false, 1.30, 0.00, 0, 0.09, 1.39, 0.00, 0, 4, '', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 16:15:00'::timestamptz, '2024-11-13 16:14:00'::timestamptz, '2024-11-13 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.39 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.39, '2024-11-13 16:14:00'::timestamptz); END IF;

  -- CC1299
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1299', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 00:00:00'::timestamptz, '2024-11-13 17:04:00'::timestamptz, '2024-11-13 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-13 17:04:00'::timestamptz); END IF;

  -- CC1300
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 114;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1300', 'Nuvia Melendez', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 2, 'Lavandería', '2024-11-13 00:00:00'::timestamptz, '2024-11-13 00:00:00'::timestamptz, '2024-11-13 17:22:00'::timestamptz, '2024-11-13 17:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.75, '2024-11-13 17:22:00'::timestamptz); END IF;

  -- CC1301
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 89;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1301', 'María Sandoval', false, 'completed', false, 14.09, 2.00, 0, 0.99, 15.08, 0.00, 0, 10, '0', '2024-11-14 00:00:00'::timestamptz, '2024-11-14 10:15:00'::timestamptz, '2024-11-14 08:41:00'::timestamptz, '2024-11-14 08:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.08 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.08, '2024-11-14 08:41:00'::timestamptz); END IF;

  -- CC1302
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1302', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.25, 0.00, 0, 1.28, 19.53, 7.30, 2, 1, 'Salón', '2024-11-14 00:00:00'::timestamptz, '2024-11-14 14:05:00'::timestamptz, '2024-11-14 10:44:00'::timestamptz, '2024-11-14 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.53 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.53, '2024-11-14 10:44:00'::timestamptz); END IF;

  -- CC1303
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1303', 'Sara Charles', false, 'completed', false, 4.30, 0.07, 0, 0.20, 4.50, 0.00, 0, 5, 'Lavandería', '2024-11-15 00:00:00'::timestamptz, '2024-11-14 14:06:00'::timestamptz, '2024-11-14 11:54:00'::timestamptz, '2024-11-14 11:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-11-14 11:54:00'::timestamptz); END IF;

  -- CC1304
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1304', 'Renzo Mundo', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2024-11-14 00:00:00'::timestamptz, '2024-11-14 16:51:00'::timestamptz, '2024-11-14 16:37:00'::timestamptz, '2024-11-14 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-14 16:37:00'::timestamptz); END IF;

  -- CC1305
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 31;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1305', 'Lineth', false, 'completed', false, 7.31, 0.00, 0, 0.39, 7.70, 0.00, 0, 6, '0', '2024-11-14 00:00:00'::timestamptz, '2024-11-14 16:57:00'::timestamptz, '2024-11-14 16:56:00'::timestamptz, '2024-11-14 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.70, '2024-11-14 16:56:00'::timestamptz); END IF;

  -- CC1306
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1306', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2024-11-14 00:00:00'::timestamptz, '2024-11-14 17:01:00'::timestamptz, '2024-11-14 17:00:00'::timestamptz, '2024-11-14 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-14 17:00:00'::timestamptz); END IF;

  -- CC1307
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1307', 'Guzmán', false, 'completed', false, 17.25, 0.00, 0, 1.21, 18.46, 6.90, 3, 1, '', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 13:42:00'::timestamptz, '2024-11-15 12:13:00'::timestamptz, '2024-11-15 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.46 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.46, '2024-11-15 12:13:00'::timestamptz); END IF;

  -- CC1308
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1308', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 13:28:00'::timestamptz, '2024-11-15 12:25:00'::timestamptz, '2024-11-15 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-15 12:25:00'::timestamptz); END IF;

  -- CC1309
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1309', 'Retail', true, 'completed', false, 3.25, 0.00, 0, 0.00, 3.25, 0.00, 0, 5, '', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 00:00:00'::timestamptz, '2024-11-15 14:26:00'::timestamptz, '2024-11-15 14:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-11-15 14:26:00'::timestamptz); END IF;

  -- CC1310
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1310', 'Tairis - Diego', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 15:34:00'::timestamptz, '2024-11-15 14:28:00'::timestamptz, '2024-11-15 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-15 14:28:00'::timestamptz); END IF;

  -- CC1311
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1311', 'Guzmán', false, 'completed', false, 7.44, 0.00, 0, 0.52, 7.96, 4.25, 1, 1, '', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 15:43:00'::timestamptz, '2024-11-15 15:09:00'::timestamptz, '2024-11-15 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.96, '2024-11-15 15:09:00'::timestamptz); END IF;

  -- CC1312
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1312', 'Erick Rodriguez', false, 'completed', false, 1.40, 3.84, 0, 0.10, 1.50, 0.00, 0, 5, 'Lavandería', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 17:02:00'::timestamptz, '2024-11-15 15:33:00'::timestamptz, '2024-11-15 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-11-15 15:33:00'::timestamptz); END IF;

  -- CC1313
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1313', 'Renzo Mundo', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, 'Lavandería', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 17:02:00'::timestamptz, '2024-11-15 16:02:00'::timestamptz, '2024-11-15 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-15 16:02:00'::timestamptz); END IF;

  -- CC1314
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 33;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1314', 'Rene Guiñez', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, '0', '2024-11-15 00:00:00'::timestamptz, '2024-11-15 17:16:00'::timestamptz, '2024-11-15 17:03:00'::timestamptz, '2024-11-15 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-15 17:03:00'::timestamptz); END IF;

  -- CC1315
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1315', 'Manuel Rueda', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 12:30:00'::timestamptz, '2024-11-16 08:32:00'::timestamptz, '2024-11-16 08:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-16 08:32:00'::timestamptz); END IF;

  -- CC1316
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1316', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 10:44:00'::timestamptz, '2024-11-16 08:38:00'::timestamptz, '2024-11-16 08:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-16 08:38:00'::timestamptz); END IF;

  -- CC1317
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1317', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.65, 1, 1, '', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 14:31:00'::timestamptz, '2024-11-16 11:59:00'::timestamptz, '2024-11-16 11:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-11-16 11:59:00'::timestamptz); END IF;

  -- CC1318
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1318', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 12:56:00'::timestamptz, '2024-11-16 12:03:00'::timestamptz, '2024-11-16 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-16 12:03:00'::timestamptz); END IF;

  -- CC1319
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1319', 'Renzo Mundo', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 12:55:00'::timestamptz, '2024-11-16 12:04:00'::timestamptz, '2024-11-16 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-16 12:04:00'::timestamptz); END IF;

  -- CC1320
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1320', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 14:37:00'::timestamptz, '2024-11-16 12:56:00'::timestamptz, '2024-11-16 12:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-16 12:56:00'::timestamptz); END IF;

  -- CC1321
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1321', 'Cliente Lavandería', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, 'Lavandería', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 15:42:00'::timestamptz, '2024-11-16 14:38:00'::timestamptz, '2024-11-16 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-16 14:38:00'::timestamptz); END IF;

  -- CC1322
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1322', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-11-16 00:00:00'::timestamptz, '2024-11-17 10:08:00'::timestamptz, '2024-11-16 17:03:00'::timestamptz, '2024-11-16 17:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-16 17:03:00'::timestamptz); END IF;

  -- CC1323
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1323', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.04, 0.54, 0.00, 0, 1, '', '2024-11-16 00:00:00'::timestamptz, '2024-11-16 00:00:00'::timestamptz, '2024-11-16 17:06:00'::timestamptz, '2024-11-16 17:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.54, '2024-11-16 17:06:00'::timestamptz); END IF;

  -- CC1324
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1324', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.01, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 10:08:00'::timestamptz, '2024-11-17 08:53:00'::timestamptz, '2024-11-17 08:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2024-11-17 08:53:00'::timestamptz); END IF;

  -- CC1325
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1325', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 12:37:00'::timestamptz, '2024-11-17 11:05:00'::timestamptz, '2024-11-17 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-17 11:05:00'::timestamptz); END IF;

  -- CC1326
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1326', 'Yatzury Anderson', false, 'completed', false, 7.48, 0.26, 0, 0.52, 8.00, 0.00, 0, 6, '', '2024-11-18 00:00:00'::timestamptz, '2024-11-17 12:37:00'::timestamptz, '2024-11-17 12:10:00'::timestamptz, '2024-11-17 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-17 12:10:00'::timestamptz); END IF;

  -- CC1327
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1327', 'Leonel Visueti', false, 'completed', false, 16.95, 0.27, 0, 1.05, 18.00, 0.00, 0, 12, '', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 16:11:00'::timestamptz, '2024-11-17 12:39:00'::timestamptz, '2024-11-17 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-11-17 12:39:00'::timestamptz); END IF;

  -- CC1328
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1328', 'Lina Perez', false, 'completed', false, 18.21, 4.00, 0, 1.09, 19.30, 0.00, 0, 15, 'Lavandería', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 16:11:00'::timestamptz, '2024-11-17 12:42:00'::timestamptz, '2024-11-17 12:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.30, '2024-11-17 12:42:00'::timestamptz); END IF;

  -- CC1329
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1329', 'Gisselle', false, 'completed', false, 11.88, 0.00, 0, 0.83, 12.71, 4.75, 1, 1, '0', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 11:21:00'::timestamptz, '2024-11-17 15:30:00'::timestamptz, '2024-11-17 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.71 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.71, '2024-11-17 15:30:00'::timestamptz); END IF;

  -- CC1330
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1330', 'Liliana', false, 'completed', false, 6.54, 0.20, 0, 0.46, 7.00, 0.00, 0, 5, '0', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 16:11:00'::timestamptz, '2024-11-17 15:58:00'::timestamptz, '2024-11-17 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-17 15:58:00'::timestamptz); END IF;

  -- CC1331
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 22;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1331', 'Tamara Collado', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '0', '2024-11-18 00:00:00'::timestamptz, '2024-11-17 16:11:00'::timestamptz, '2024-11-17 16:00:00'::timestamptz, '2024-11-17 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-11-17 16:00:00'::timestamptz); END IF;

  -- CC1332
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1332', 'Retail', true, 'completed', false, 2.75, 0.00, 0, 0.00, 2.75, 0.00, 0, 4, '', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 00:00:00'::timestamptz, '2024-11-17 16:02:00'::timestamptz, '2024-11-17 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2024-11-17 16:02:00'::timestamptz); END IF;

  -- CC1333
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1333', 'Cliente Lavandería', false, 'completed', false, 6.86, 0.00, 0, 0.39, 7.25, 0.00, 0, 4, 'Lavandería', '2024-11-17 00:00:00'::timestamptz, '2024-11-17 16:11:00'::timestamptz, '2024-11-17 16:04:00'::timestamptz, '2024-11-17 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.25, '2024-11-17 16:04:00'::timestamptz); END IF;

  -- CC1334
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1334', 'Manuel Rueda', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, 'Lavandería', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 08:59:00'::timestamptz, '2024-11-18 08:15:00'::timestamptz, '2024-11-18 08:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-18 08:15:00'::timestamptz); END IF;

  -- CC1335
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1335', 'Liliana', false, 'completed', false, 1.87, 1.87, 0, 0.13, 2.00, 0.00, 0, 2, '0', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 10:21:00'::timestamptz, '2024-11-18 09:04:00'::timestamptz, '2024-11-18 09:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-18 09:04:00'::timestamptz); END IF;

  -- CC1336
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1336', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.75, 0.00, 0, 1.31, 20.06, 7.50, 2, 1, 'Salón', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 12:03:00'::timestamptz, '2024-11-18 11:22:00'::timestamptz, '2024-11-18 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.06, '2024-11-18 11:22:00'::timestamptz); END IF;

  -- CC1337
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1337', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 12:03:00'::timestamptz, '2024-11-18 12:01:00'::timestamptz, '2024-11-18 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-18 12:01:00'::timestamptz); END IF;

  -- CC1338
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1338', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 00:00:00'::timestamptz, '2024-11-18 12:16:00'::timestamptz, '2024-11-18 12:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-18 12:16:00'::timestamptz); END IF;

  -- CC1339
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1339', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 00:00:00'::timestamptz, '2024-11-18 12:49:00'::timestamptz, '2024-11-18 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-11-18 12:49:00'::timestamptz); END IF;

  -- CC1340
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1340', 'Blanca', false, 'completed', false, 1.87, 1.87, 0, 0.13, 2.00, 0.00, 0, 2, '0', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 15:38:00'::timestamptz, '2024-11-18 13:16:00'::timestamptz, '2024-11-18 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-18 13:16:00'::timestamptz); END IF;

  -- CC1341
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1341', 'Retail', true, 'completed', false, 2.75, 0.00, 0, 0.00, 2.75, 0.00, 0, 4, '', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 00:00:00'::timestamptz, '2024-11-18 16:40:00'::timestamptz, '2024-11-18 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.75, '2024-11-18 16:40:00'::timestamptz); END IF;

  -- CC1342
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1342', 'Leonel Visueti', false, 'completed', false, 4.21, 0.03, 0, 0.29, 4.50, 0.00, 0, 3, '', '2024-11-18 00:00:00'::timestamptz, '2024-11-18 17:28:00'::timestamptz, '2024-11-18 16:42:00'::timestamptz, '2024-11-18 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-11-18 16:42:00'::timestamptz); END IF;

  -- CC1343
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1343', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-11-19 00:00:00'::timestamptz, '2024-11-19 16:54:00'::timestamptz, '2024-11-19 10:01:00'::timestamptz, '2024-11-19 10:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-19 10:01:00'::timestamptz); END IF;

  -- CC1344
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1344', 'Fany Luz Salon', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-11-19 00:00:00'::timestamptz, '2024-11-19 16:54:00'::timestamptz, '2024-11-19 13:50:00'::timestamptz, '2024-11-19 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-19 13:50:00'::timestamptz); END IF;

  -- CC1345
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1345', 'Yara Rangel', false, 'completed', false, 19.73, 4.10, 0, 1.26, 20.99, 0.00, 0, 16, '0', '2024-11-19 00:00:00'::timestamptz, '2024-11-19 16:53:00'::timestamptz, '2024-11-19 15:40:00'::timestamptz, '2024-11-19 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.99, '2024-11-19 15:40:00'::timestamptz); END IF;

  -- CC1346
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1346', 'Cliente Lavandería', false, 'completed', false, 9.66, 0.20, 0, 0.59, 10.25, 0.00, 0, 7, 'Lavandería', '2024-11-19 00:00:00'::timestamptz, '2024-11-19 16:54:00'::timestamptz, '2024-11-19 16:02:00'::timestamptz, '2024-11-19 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.25, '2024-11-19 16:02:00'::timestamptz); END IF;

  -- CC1347
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1347', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-11-19 00:00:00'::timestamptz, '2024-11-20 14:54:00'::timestamptz, '2024-11-19 16:55:00'::timestamptz, '2024-11-19 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-19 16:55:00'::timestamptz); END IF;

  -- CC1348
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1348', 'Guzmán', false, 'completed', false, 9.71, 0.00, 0, 0.68, 10.39, 5.55, 1, 1, '', '2024-11-20 00:00:00'::timestamptz, '2024-11-20 14:54:00'::timestamptz, '2024-11-20 12:24:00'::timestamptz, '2024-11-20 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.39 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.39, '2024-11-20 12:24:00'::timestamptz); END IF;

  -- CC1349
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1349', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.00, 1, 1, '', '2024-11-20 00:00:00'::timestamptz, '2024-11-20 14:54:00'::timestamptz, '2024-11-20 13:51:00'::timestamptz, '2024-11-20 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-11-20 13:51:00'::timestamptz); END IF;

  -- CC1350
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1350', 'Yatzury Anderson', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-11-20 00:00:00'::timestamptz, '2024-11-20 16:57:00'::timestamptz, '2024-11-20 16:28:00'::timestamptz, '2024-11-20 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-11-20 16:28:00'::timestamptz); END IF;

  -- CC1351
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 116;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1351', 'Ivonet', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 0.00, 0, 1, 'Lavandería', '2024-11-21 00:00:00'::timestamptz, '2024-11-22 14:29:00'::timestamptz, '2024-11-21 08:16:00'::timestamptz, '2024-11-21 08:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-11-21 08:16:00'::timestamptz); END IF;

  -- CC1352
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1352', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-11-21 00:00:00'::timestamptz, '2024-11-21 00:00:00'::timestamptz, '2024-11-21 15:35:00'::timestamptz, '2024-11-21 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-11-21 15:35:00'::timestamptz); END IF;

  -- CC1353
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1353', 'Sara Charles', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-11-21 00:00:00'::timestamptz, '2024-11-21 16:21:00'::timestamptz, '2024-11-21 15:40:00'::timestamptz, '2024-11-21 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-21 15:40:00'::timestamptz); END IF;

  -- CC1354
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1354', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-11-21 00:00:00'::timestamptz, '2024-11-21 16:21:00'::timestamptz, '2024-11-21 15:49:00'::timestamptz, '2024-11-21 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-21 15:49:00'::timestamptz); END IF;

  -- CC1355
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1355', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-11-21 00:00:00'::timestamptz, '2024-11-21 00:00:00'::timestamptz, '2024-11-21 15:50:00'::timestamptz, '2024-11-21 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-11-21 15:50:00'::timestamptz); END IF;

  -- CC1356
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1356', 'Leonel Visueti', false, 'completed', false, 11.22, 0.26, 0, 0.79, 12.01, 0.00, 0, 8, '', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 10:58:00'::timestamptz, '2024-11-22 10:13:00'::timestamptz, '2024-11-22 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.01, '2024-11-22 10:13:00'::timestamptz); END IF;

  -- CC1357
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1357', 'Guzmán', false, 'completed', false, 17.13, 0.00, 0, 1.20, 18.33, 6.85, 3, 1, '', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 13:56:00'::timestamptz, '2024-11-22 11:16:00'::timestamptz, '2024-11-22 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.33 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.33, '2024-11-22 11:16:00'::timestamptz); END IF;

  -- CC1358
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1358', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 15:25:00'::timestamptz, '2024-11-22 11:32:00'::timestamptz, '2024-11-22 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-22 11:32:00'::timestamptz); END IF;

  -- CC1359
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1359', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.50, 0.00, 0, 1.16, 17.66, 6.60, 2, 1, 'Salón', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 14:35:00'::timestamptz, '2024-11-22 13:50:00'::timestamptz, '2024-11-22 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.66 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.66, '2024-11-22 13:50:00'::timestamptz); END IF;

  -- CC1360
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1360', 'Leonel Visueti', false, 'completed', false, 5.80, 0.07, 0, 0.20, 6.00, 0.00, 0, 7, '', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 15:25:00'::timestamptz, '2024-11-22 14:49:00'::timestamptz, '2024-11-22 14:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-22 14:49:00'::timestamptz); END IF;

  -- CC1361
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1361', 'Guzmán', false, 'completed', false, 7.35, 0.00, 0, 0.51, 7.86, 4.20, 1, 1, '', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 15:59:00'::timestamptz, '2024-11-22 15:36:00'::timestamptz, '2024-11-22 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.86 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.86, '2024-11-22 15:36:00'::timestamptz); END IF;

  -- CC1362
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1362', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.45, 1, 1, '', '2024-11-22 00:00:00'::timestamptz, '2024-11-22 15:59:00'::timestamptz, '2024-11-22 15:42:00'::timestamptz, '2024-11-22 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-11-22 15:42:00'::timestamptz); END IF;

  -- CC1363
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1363', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 12:10:00'::timestamptz, '2024-11-23 10:39:00'::timestamptz, '2024-11-23 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-23 10:39:00'::timestamptz); END IF;

  -- CC1364
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1364', 'Evelyn', false, 'completed', false, 8.01, 0.10, 0, 0.49, 8.50, 0.00, 0, 8, 'Salón', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 12:10:00'::timestamptz, '2024-11-23 10:47:00'::timestamptz, '2024-11-23 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-11-23 10:47:00'::timestamptz); END IF;

  -- CC1365
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1365', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 8, '', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 00:00:00'::timestamptz, '2024-11-23 12:11:00'::timestamptz, '2024-11-23 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-23 12:11:00'::timestamptz); END IF;

  -- CC1366
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1366', 'Leonel Visueti', false, 'completed', false, 14.02, 0.20, 0, 0.98, 15.00, 0.00, 0, 9, '', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 13:25:00'::timestamptz, '2024-11-23 12:19:00'::timestamptz, '2024-11-23 12:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2024-11-23 12:19:00'::timestamptz); END IF;

  -- CC1367
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1367', 'Gisselle', false, 'completed', false, 10.25, 0.00, 0, 0.72, 10.97, 4.10, 1, 1, '0', '2024-11-23 00:00:00'::timestamptz, '2024-11-24 10:58:00'::timestamptz, '2024-11-23 14:18:00'::timestamptz, '2024-11-23 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.97, '2024-11-23 14:18:00'::timestamptz); END IF;

  -- CC1368
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1368', 'Renzo Mundo', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, 'Lavandería', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 16:13:00'::timestamptz, '2024-11-23 16:12:00'::timestamptz, '2024-11-23 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-23 16:12:00'::timestamptz); END IF;

  -- CC1369
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1369', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 6, '', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 00:00:00'::timestamptz, '2024-11-23 16:19:00'::timestamptz, '2024-11-23 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-23 16:19:00'::timestamptz); END IF;

  -- CC1370
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1370', 'Leonel Visueti', false, 'completed', false, 6.08, 0.03, 0, 0.43, 6.51, 0.00, 0, 5, '', '2024-11-23 00:00:00'::timestamptz, '2024-11-23 16:32:00'::timestamptz, '2024-11-23 16:30:00'::timestamptz, '2024-11-23 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.51 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.51, '2024-11-23 16:30:00'::timestamptz); END IF;

  -- CC1371
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1371', 'Fernando Ortega', false, 'completed', false, 6.11, 0.00, 0, 0.39, 6.50, 0.00, 0, 4, '', '2024-11-24 00:00:00'::timestamptz, '2024-11-24 09:24:00'::timestamptz, '2024-11-24 08:43:00'::timestamptz, '2024-11-24 08:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-11-24 08:43:00'::timestamptz); END IF;

  -- CC1372
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1372', 'Leonel Visueti', false, 'completed', false, 7.98, 0.00, 0, 0.52, 8.50, 0.00, 0, 5, '', '2024-11-24 00:00:00'::timestamptz, '2024-11-24 13:04:00'::timestamptz, '2024-11-24 08:44:00'::timestamptz, '2024-11-24 08:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2024-11-24 08:44:00'::timestamptz); END IF;

  -- CC1373
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1373', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2024-11-25 00:00:00'::timestamptz, '2024-11-24 11:36:00'::timestamptz, '2024-11-24 10:59:00'::timestamptz, '2024-11-24 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-24 10:59:00'::timestamptz); END IF;

  -- CC1374
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1374', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-11-25 00:00:00'::timestamptz, '2024-11-24 13:04:00'::timestamptz, '2024-11-24 11:50:00'::timestamptz, '2024-11-24 11:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-24 11:50:00'::timestamptz); END IF;

  -- CC1375
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1375', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 11.25, 0.00, 0, 0.79, 12.04, 4.50, 1, 1, 'Salón', '2024-11-25 00:00:00'::timestamptz, '2024-11-24 12:42:00'::timestamptz, '2024-11-24 12:05:00'::timestamptz, '2024-11-24 12:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.04 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.04, '2024-11-24 12:05:00'::timestamptz); END IF;

  -- CC1376
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1376', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-11-24 00:00:00'::timestamptz, '2024-11-24 00:00:00'::timestamptz, '2024-11-24 12:35:00'::timestamptz, '2024-11-24 12:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-11-24 12:35:00'::timestamptz); END IF;

  -- CC1377
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1377', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-11-25 00:00:00'::timestamptz, '2024-11-24 14:40:00'::timestamptz, '2024-11-24 13:11:00'::timestamptz, '2024-11-24 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-24 13:11:00'::timestamptz); END IF;

  -- CC1378
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1378', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-11-25 00:00:00'::timestamptz, '2024-11-24 14:40:00'::timestamptz, '2024-11-24 13:37:00'::timestamptz, '2024-11-24 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-24 13:37:00'::timestamptz); END IF;

  -- CC1379
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1379', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 15:03:00'::timestamptz, '2024-11-25 12:52:00'::timestamptz, '2024-11-25 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-25 12:52:00'::timestamptz); END IF;

  -- CC1380
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1380', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 15:17:00'::timestamptz, '2024-11-25 14:05:00'::timestamptz, '2024-11-25 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-11-25 14:05:00'::timestamptz); END IF;

  -- CC1381
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1381', 'Fany Luz Salon', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 17:00:00'::timestamptz, '2024-11-25 15:15:00'::timestamptz, '2024-11-25 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-25 15:15:00'::timestamptz); END IF;

  -- CC1382
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1382', 'Fany Luz Salon', true, 'completed', false, 0.47, 0.03, 0, 0.03, 0.50, 0.00, 0, 2, '0', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 00:00:00'::timestamptz, '2024-11-25 15:16:00'::timestamptz, '2024-11-25 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2024-11-25 15:16:00'::timestamptz); END IF;

  -- CC1383
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1383', 'Erick Rodriguez', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, 'Lavandería', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 17:00:00'::timestamptz, '2024-11-25 15:30:00'::timestamptz, '2024-11-25 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-11-25 15:30:00'::timestamptz); END IF;

  -- CC1384
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1384', 'Renzo Mundo', false, 'completed', false, 6.54, 0.07, 0, 0.46, 7.00, 0.00, 0, 4, 'Lavandería', '2024-11-25 00:00:00'::timestamptz, '2024-11-25 17:00:00'::timestamptz, '2024-11-25 16:59:00'::timestamptz, '2024-11-25 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-11-25 16:59:00'::timestamptz); END IF;

  -- CC1385
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1385', 'Leonel Visueti', false, 'completed', false, 6.38, 0.00, 0, 0.45, 6.83, 2.55, 1, 1, '', '2024-11-26 00:00:00'::timestamptz, '2024-11-26 15:09:00'::timestamptz, '2024-11-26 10:58:00'::timestamptz, '2024-11-26 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.83 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.83, '2024-11-26 10:58:00'::timestamptz); END IF;

  -- CC1386
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 84;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1386', 'Julia Sandoval', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2024-11-26 00:00:00'::timestamptz, '2024-11-26 15:47:00'::timestamptz, '2024-11-26 14:02:00'::timestamptz, '2024-11-26 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-11-26 14:02:00'::timestamptz); END IF;

  -- CC1387
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1387', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-11-26 00:00:00'::timestamptz, '2024-11-26 15:09:00'::timestamptz, '2024-11-26 14:21:00'::timestamptz, '2024-11-26 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-11-26 14:21:00'::timestamptz); END IF;

  -- CC1388
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1388', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-11-26 00:00:00'::timestamptz, '2024-11-26 00:00:00'::timestamptz, '2024-11-26 15:53:00'::timestamptz, '2024-11-26 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-11-26 15:53:00'::timestamptz); END IF;

  -- CC1389
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1389', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 18.88, 0.00, 0, 1.32, 20.20, 7.55, 2, 1, 'Salón', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 13:20:00'::timestamptz, '2024-11-27 12:21:00'::timestamptz, '2024-11-27 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.20, '2024-11-27 12:21:00'::timestamptz); END IF;

  -- CC1390
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1390', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 14:21:00'::timestamptz, '2024-11-27 13:36:00'::timestamptz, '2024-11-27 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-27 13:36:00'::timestamptz); END IF;

  -- CC1391
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1391', 'Guzmán', false, 'completed', false, 6.13, 0.00, 0, 0.43, 6.56, 2.45, 1, 1, '', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 15:57:00'::timestamptz, '2024-11-27 13:53:00'::timestamptz, '2024-11-27 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.56 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.56, '2024-11-27 13:53:00'::timestamptz); END IF;

  -- CC1392
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1392', 'Guzmán', false, 'completed', false, 6.91, 0.00, 0, 0.48, 7.39, 3.95, 1, 1, '', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 15:57:00'::timestamptz, '2024-11-27 13:58:00'::timestamptz, '2024-11-27 13:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.39 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.39, '2024-11-27 13:58:00'::timestamptz); END IF;

  -- CC1393
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 117;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1393', 'United Airlines INC.', false, 'completed', false, 10.00, 0.00, 0, 0.70, 10.70, 2.40, 1, 9, 'Lavandería', '2024-11-28 00:00:00'::timestamptz, '2024-11-27 16:43:00'::timestamptz, '2024-11-27 16:11:00'::timestamptz, '2024-11-27 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.70, '2024-11-27 16:11:00'::timestamptz); END IF;

  -- CC1394
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1394', 'Yatzury Anderson', false, 'completed', false, 22.43, 0.66, 0, 1.57, 24.00, 0.00, 0, 17, '', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 17:14:00'::timestamptz, '2024-11-27 16:18:00'::timestamptz, '2024-11-27 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.00, '2024-11-27 16:18:00'::timestamptz); END IF;

  -- CC1395
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1395', 'Guzmán', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 3, '', '2024-11-27 00:00:00'::timestamptz, '2024-11-27 00:00:00'::timestamptz, '2024-11-27 16:29:00'::timestamptz, '2024-11-27 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2024-11-27 16:29:00'::timestamptz); END IF;

  -- CC1396
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1396', 'Guzmán', false, 'completed', false, 10.63, 0.00, 0, 0.74, 11.37, 4.25, 3, 1, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:10:00'::timestamptz, '2024-11-29 12:20:00'::timestamptz, '2024-11-29 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.37 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.37, '2024-11-29 12:20:00'::timestamptz); END IF;

  -- CC1398
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1398', 'Guzmán', false, 'completed', false, 20.00, 0.00, 0, 1.40, 21.40, 2.15, 1, 3, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:11:00'::timestamptz, '2024-11-29 12:31:00'::timestamptz, '2024-11-29 12:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.40 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.40, '2024-11-29 12:31:00'::timestamptz); END IF;

  -- CC1399
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1399', 'Guzmán', false, 'completed', false, 16.88, 0.00, 0, 1.18, 18.06, 6.75, 3, 1, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:11:00'::timestamptz, '2024-11-29 13:55:00'::timestamptz, '2024-11-29 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.06, '2024-11-29 13:55:00'::timestamptz); END IF;

  -- CC1400
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1400', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 11.38, 0.00, 0, 0.80, 12.18, 4.55, 1, 1, 'Salón', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 14:14:00'::timestamptz, '2024-11-29 14:00:00'::timestamptz, '2024-11-29 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.18, '2024-11-29 14:00:00'::timestamptz); END IF;

  -- CC1401
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1401', 'Guzmán', false, 'completed', false, 16.80, 0.00, 0, 1.18, 17.98, 9.60, 3, 1, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:11:00'::timestamptz, '2024-11-29 15:15:00'::timestamptz, '2024-11-29 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.98, '2024-11-29 15:15:00'::timestamptz); END IF;

  -- CC1402
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1402', 'Erick Rodriguez', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, 'Lavandería', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:51:00'::timestamptz, '2024-11-29 15:35:00'::timestamptz, '2024-11-29 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-11-29 15:35:00'::timestamptz); END IF;

  -- CC1403
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1403', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:20:00'::timestamptz, '2024-11-29 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-11-29 16:20:00'::timestamptz); END IF;

  -- CC1404
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1404', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 6, '', '2024-11-29 00:00:00'::timestamptz, '2024-11-29 00:00:00'::timestamptz, '2024-11-29 16:36:00'::timestamptz, '2024-11-29 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-11-29 16:36:00'::timestamptz); END IF;

  -- CC1405
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1405', 'Leonel Visueti', false, 'completed', false, 5.80, 0.07, 0, 0.20, 6.00, 0.00, 0, 5, '', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 12:22:00'::timestamptz, '2024-11-30 11:46:00'::timestamptz, '2024-11-30 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-11-30 11:46:00'::timestamptz); END IF;

  -- CC1406
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1406', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 00:00:00'::timestamptz, '2024-11-30 11:49:00'::timestamptz, '2024-11-30 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-11-30 11:49:00'::timestamptz); END IF;

  -- CC1407
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1407', 'Yatzury Anderson', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, '', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 16:22:00'::timestamptz, '2024-11-30 12:23:00'::timestamptz, '2024-11-30 12:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-11-30 12:23:00'::timestamptz); END IF;

  -- CC1408
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1408', 'Cliente Lavandería', false, 'completed', false, 17.20, 0.40, 0, 1.05, 18.25, 0.00, 0, 13, 'Lavandería', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 16:22:00'::timestamptz, '2024-11-30 13:13:00'::timestamptz, '2024-11-30 13:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.25, '2024-11-30 13:13:00'::timestamptz); END IF;

  -- CC1409
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1409', 'Oscar Oropeza', false, 'completed', false, 16.82, 1.88, 0, 1.18, 18.00, 0.00, 0, 10, 'Lavandería', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 16:22:00'::timestamptz, '2024-11-30 13:24:00'::timestamptz, '2024-11-30 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-11-30 13:24:00'::timestamptz); END IF;

  -- CC1410
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1410', 'Gisselle', false, 'completed', false, 11.38, 0.00, 0, 0.80, 12.18, 4.55, 1, 1, '0', '2024-11-30 00:00:00'::timestamptz, '2024-12-01 13:40:00'::timestamptz, '2024-11-30 13:50:00'::timestamptz, '2024-11-30 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.18, '2024-11-30 13:50:00'::timestamptz); END IF;

  -- CC1411
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1411', 'Leonel Visueti', false, 'completed', false, 17.76, 2.07, 0, 1.24, 19.00, 0.00, 0, 12, '', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 17:16:00'::timestamptz, '2024-11-30 16:23:00'::timestamptz, '2024-11-30 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.00, '2024-11-30 16:23:00'::timestamptz); END IF;

  -- CC1412
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1412', 'Yatzury Anderson', false, 'completed', false, 11.53, 0.33, 0, 0.72, 12.25, 0.00, 0, 9, '', '2024-11-30 00:00:00'::timestamptz, '2024-11-30 17:16:00'::timestamptz, '2024-11-30 17:15:00'::timestamptz, '2024-11-30 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.25, '2024-11-30 17:15:00'::timestamptz); END IF;

  -- CC1413
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1413', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.63, 0.00, 0, 1.09, 16.72, 6.25, 2, 1, 'Salón', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 13:20:00'::timestamptz, '2024-12-01 12:54:00'::timestamptz, '2024-12-01 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.72 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.72, '2024-12-01 12:54:00'::timestamptz); END IF;

  -- CC1414
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1414', 'Yatzury Anderson', false, 'completed', false, 16.82, 0.27, 0, 1.18, 18.00, 0.00, 0, 11, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:02:00'::timestamptz, '2024-12-01 13:53:00'::timestamptz, '2024-12-01 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2024-12-01 13:53:00'::timestamptz); END IF;

  -- CC1415
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1415', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:02:00'::timestamptz, '2024-12-01 13:54:00'::timestamptz, '2024-12-01 13:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-01 13:54:00'::timestamptz); END IF;

  -- CC1416
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1416', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:02:00'::timestamptz, '2024-12-01 13:54:00'::timestamptz, '2024-12-01 13:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-01 13:54:00'::timestamptz); END IF;

  -- CC1417
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1417', 'Yatzury Anderson', false, 'completed', false, 8.41, 0.20, 0, 0.59, 9.00, 0.00, 0, 6, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:03:00'::timestamptz, '2024-12-01 13:58:00'::timestamptz, '2024-12-01 13:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-12-01 13:58:00'::timestamptz); END IF;

  -- CC1418
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1418', 'Liliana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:03:00'::timestamptz, '2024-12-01 13:59:00'::timestamptz, '2024-12-01 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-01 13:59:00'::timestamptz); END IF;

  -- CC1419
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1419', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:03:00'::timestamptz, '2024-12-01 14:00:00'::timestamptz, '2024-12-01 14:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-01 14:00:00'::timestamptz); END IF;

  -- CC1420
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1420', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:05:00'::timestamptz, '2024-12-01 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-12-01 14:05:00'::timestamptz); END IF;

  -- CC1421
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1421', 'Cliente Lavandería', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavandería', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:48:00'::timestamptz, '2024-12-01 14:06:00'::timestamptz, '2024-12-01 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-12-01 14:06:00'::timestamptz); END IF;

  -- CC1422
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1422', 'Yatzury Anderson', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:48:00'::timestamptz, '2024-12-01 14:14:00'::timestamptz, '2024-12-01 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-01 14:14:00'::timestamptz); END IF;

  -- CC1423
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1423', 'Leonel Visueti', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, '', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 14:48:00'::timestamptz, '2024-12-01 14:16:00'::timestamptz, '2024-12-01 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-12-01 14:16:00'::timestamptz); END IF;

  -- CC1424
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1424', 'Cliente Lavandería', false, 'completed', false, 15.08, 0.14, 0, 0.92, 16.00, 0.00, 0, 10, 'Lavandería', '2024-12-01 00:00:00'::timestamptz, '2024-12-05 07:55:00'::timestamptz, '2024-12-01 14:50:00'::timestamptz, '2024-12-01 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-12-01 14:50:00'::timestamptz); END IF;

  -- CC1425
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 104;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1425', 'Carlos Abrego', false, 'completed', false, 5.91, 0.08, 0, 0.34, 6.25, 0.00, 0, 6, 'Lavandería', '2024-12-01 00:00:00'::timestamptz, '2024-12-01 15:49:00'::timestamptz, '2024-12-01 14:53:00'::timestamptz, '2024-12-01 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.25, '2024-12-01 14:53:00'::timestamptz); END IF;

  -- CC1426
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1426', 'Aaron Gutierrez', false, 'completed', false, 9.88, 0.23, 0, 0.62, 10.50, 0.00, 0, 10, 'Lavandería', '2024-12-02 00:00:00'::timestamptz, '2024-12-02 14:13:00'::timestamptz, '2024-12-02 12:41:00'::timestamptz, '2024-12-02 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.50, '2024-12-02 12:41:00'::timestamptz); END IF;

  -- CC1427
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1427', 'Fany Luz Salon', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-12-02 00:00:00'::timestamptz, '2024-12-02 15:30:00'::timestamptz, '2024-12-02 13:00:00'::timestamptz, '2024-12-02 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-02 13:00:00'::timestamptz); END IF;

  -- CC1428
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 118;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1428', 'Sysco Panama', false, 'completed', false, 6.75, 0.00, 0, 0.47, 7.22, 2.70, 1, 1, 'Lavandería', '2024-12-02 00:00:00'::timestamptz, '2024-12-03 11:37:00'::timestamptz, '2024-12-02 13:55:00'::timestamptz, '2024-12-02 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.22 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.22, '2024-12-02 13:55:00'::timestamptz); END IF;

  -- CC1429
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1429', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 6, '', '2024-12-02 00:00:00'::timestamptz, '2024-12-02 15:30:00'::timestamptz, '2024-12-02 14:14:00'::timestamptz, '2024-12-02 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-02 14:14:00'::timestamptz); END IF;

  -- CC1430
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1430', 'Tairis - Diego', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-12-02 00:00:00'::timestamptz, '2024-12-02 16:31:00'::timestamptz, '2024-12-02 16:22:00'::timestamptz, '2024-12-02 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-02 16:22:00'::timestamptz); END IF;

  -- CC1431
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1431', 'Leonel Visueti', false, 'completed', false, 10.35, 0.13, 0, 0.66, 11.01, 0.00, 0, 11, '', '2024-12-03 00:00:00'::timestamptz, '2024-12-02 16:31:00'::timestamptz, '2024-12-02 16:29:00'::timestamptz, '2024-12-02 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.01, '2024-12-02 16:29:00'::timestamptz); END IF;

  -- CC1432
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1432', 'Leonel Visueti', false, 'completed', false, 47.49, 0.67, 0, 3.01, 50.50, 0.00, 0, 33, '', '2024-12-04 00:00:00'::timestamptz, '2024-12-03 12:05:00'::timestamptz, '2024-12-03 11:38:00'::timestamptz, '2024-12-03 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 50.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 50.50, '2024-12-03 11:38:00'::timestamptz); END IF;

  -- CC1433
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1433', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-12-04 00:00:00'::timestamptz, '2024-12-04 16:41:00'::timestamptz, '2024-12-04 13:38:00'::timestamptz, '2024-12-04 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-04 13:38:00'::timestamptz); END IF;

  -- CC1434
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1434', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 15.63, 0.00, 0, 1.09, 16.72, 6.25, 2, 1, 'Salón', '2024-12-04 00:00:00'::timestamptz, '2024-12-04 16:10:00'::timestamptz, '2024-12-04 14:10:00'::timestamptz, '2024-12-04 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.72 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.72, '2024-12-04 14:10:00'::timestamptz); END IF;

  -- CC1435
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1435', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-05 00:00:00'::timestamptz, '2024-12-05 16:59:00'::timestamptz, '2024-12-05 15:04:00'::timestamptz, '2024-12-05 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-05 15:04:00'::timestamptz); END IF;

  -- CC1436
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1436', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 13.25, 0.00, 0, 0.93, 14.18, 5.30, 2, 1, 'Salón', '2024-12-05 00:00:00'::timestamptz, '2024-12-05 17:09:00'::timestamptz, '2024-12-05 16:58:00'::timestamptz, '2024-12-05 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.18, '2024-12-05 16:58:00'::timestamptz); END IF;

  -- CC1437
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1437', 'Retail', true, 'completed', false, 4.11, 0.14, 0, 0.14, 4.25, 0.00, 0, 4, '', '2024-12-05 00:00:00'::timestamptz, '2024-12-05 00:00:00'::timestamptz, '2024-12-05 17:02:00'::timestamptz, '2024-12-05 17:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2024-12-05 17:02:00'::timestamptz); END IF;

  -- CC1438
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1438', 'Guzmán', false, 'completed', false, 12.98, 0.00, 0, 0.91, 13.89, 5.19, 2, 1, '', '2024-12-06 00:00:00'::timestamptz, '2024-12-06 15:48:00'::timestamptz, '2024-12-06 10:51:00'::timestamptz, '2024-12-06 10:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.89 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.89, '2024-12-06 10:51:00'::timestamptz); END IF;

  -- CC1439
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1439', 'Rosa Arrocha', false, 'completed', false, 7.88, 0.00, 0, 0.55, 8.43, 3.15, 1, 1, 'Lavandería', '2024-12-06 00:00:00'::timestamptz, '2024-12-06 13:49:00'::timestamptz, '2024-12-06 11:24:00'::timestamptz, '2024-12-06 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.43, '2024-12-06 11:24:00'::timestamptz); END IF;

  -- CC1440
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1440', 'Guzmán', false, 'completed', false, 16.88, 0.00, 0, 1.18, 18.06, 6.75, 3, 1, '', '2024-12-06 00:00:00'::timestamptz, '2024-12-06 15:48:00'::timestamptz, '2024-12-06 11:48:00'::timestamptz, '2024-12-06 11:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.06 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.06, '2024-12-06 11:48:00'::timestamptz); END IF;

  -- CC1441
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1441', 'Yatzury Anderson', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 1.65, 1, 1, '', '2024-12-06 00:00:00'::timestamptz, '2024-12-06 16:46:00'::timestamptz, '2024-12-06 13:38:00'::timestamptz, '2024-12-06 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-12-06 13:38:00'::timestamptz); END IF;

  -- CC1442
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1442', 'Blanca', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '0', '2024-12-06 00:00:00'::timestamptz, '2024-12-06 16:46:00'::timestamptz, '2024-12-06 16:12:00'::timestamptz, '2024-12-06 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-06 16:12:00'::timestamptz); END IF;

  -- CC1443
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1443', 'Yatzury Anderson', false, 'completed', false, 25.80, 6.45, 0, 1.81, 27.61, 12.90, 2, 1, 'Lavandería', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 16:58:00'::timestamptz, '2024-12-07 11:44:00'::timestamptz, '2024-12-07 11:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.61, '2024-12-07 11:44:00'::timestamptz); END IF;

  -- CC1444
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1444', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 21.88, 0.00, 0, 1.53, 23.41, 8.75, 2, 1, 'Salón', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 12:59:00'::timestamptz, '2024-12-07 12:19:00'::timestamptz, '2024-12-07 12:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.41 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.41, '2024-12-07 12:19:00'::timestamptz); END IF;

  -- CC1445
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1445', 'Leonel Visueti', false, 'completed', false, 10.29, 0.32, 0, 0.72, 11.01, 0.00, 0, 8, '', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 13:47:00'::timestamptz, '2024-12-07 13:10:00'::timestamptz, '2024-12-07 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.01 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.01, '2024-12-07 13:10:00'::timestamptz); END IF;

  -- CC1446
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 120;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1446', 'Odilia Guzman', false, 'completed', false, 24.06, 0.00, 0, 1.68, 25.74, 13.75, 4, 1, 'Lavandería', '2024-12-08 00:00:00'::timestamptz, '2024-12-07 14:41:00'::timestamptz, '2024-12-07 14:02:00'::timestamptz, '2024-12-07 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.74, '2024-12-07 14:02:00'::timestamptz); END IF;

  -- CC1447
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1447', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 15:08:00'::timestamptz, '2024-12-07 14:51:00'::timestamptz, '2024-12-07 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-07 14:51:00'::timestamptz); END IF;

  -- CC1448
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 121;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1448', 'Yamy Victoria', false, 'completed', false, 20.00, 0.95, 0, 1.25, 21.25, 0.00, 0, 12, 'Lavandería', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 17:42:00'::timestamptz, '2024-12-07 15:35:00'::timestamptz, '2024-12-07 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.25, '2024-12-07 15:35:00'::timestamptz); END IF;

  -- CC1449
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1449', 'Retail', true, 'completed', false, 6.17, 0.33, 0, 0.33, 6.50, 0.00, 0, 8, '', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 00:00:00'::timestamptz, '2024-12-07 16:30:00'::timestamptz, '2024-12-07 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2024-12-07 16:30:00'::timestamptz); END IF;

  -- CC1450
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 121;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1450', 'Yamy Victoria', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, 'Lavandería', '2024-12-07 00:00:00'::timestamptz, '2024-12-07 00:00:00'::timestamptz, '2024-12-07 16:45:00'::timestamptz, '2024-12-07 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2024-12-07 16:45:00'::timestamptz); END IF;

  -- CC1451
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 122;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1451', 'Luis Mancilla', false, 'completed', false, 22.90, 5.73, 0, 1.60, 24.50, 10.65, 2, 3, '', '2024-12-11 00:00:00'::timestamptz, '2024-12-10 16:50:00'::timestamptz, '2024-12-10 09:14:00'::timestamptz, '2024-12-10 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.50, '2024-12-10 09:14:00'::timestamptz); END IF;

  -- CC1452
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1452', 'Academia Jireh', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 3, '0', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 12:43:00'::timestamptz, '2024-12-10 09:42:00'::timestamptz, '2024-12-10 09:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-12-10 09:42:00'::timestamptz); END IF;

  -- CC1453
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1453', 'Renzo Mundo', false, 'completed', false, 18.69, 0.14, 0, 1.31, 20.00, 0.00, 0, 11, 'Lavandería', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 12:43:00'::timestamptz, '2024-12-10 11:51:00'::timestamptz, '2024-12-10 11:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-12-10 11:51:00'::timestamptz); END IF;

  -- CC1454
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1454', 'Aaron Gutierrez', false, 'completed', false, 12.65, 0.20, 0, 0.85, 13.50, 0.00, 0, 9, 'Lavandería', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 13:58:00'::timestamptz, '2024-12-10 13:56:00'::timestamptz, '2024-12-10 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.50, '2024-12-10 13:56:00'::timestamptz); END IF;

  -- CC1455
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1455', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 28.38, 0.00, 0, 1.99, 30.37, 11.35, 3, 1, 'Salón', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 16:21:00'::timestamptz, '2024-12-10 15:06:00'::timestamptz, '2024-12-10 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.37 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.37, '2024-12-10 15:06:00'::timestamptz); END IF;

  -- CC1456
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 104;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1456', 'Carlos Abrego', false, 'completed', false, 6.70, 0.04, 0, 0.29, 6.99, 0.00, 0, 7, 'Lavandería', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 16:50:00'::timestamptz, '2024-12-10 16:09:00'::timestamptz, '2024-12-10 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.99, '2024-12-10 16:09:00'::timestamptz); END IF;

  -- CC1457
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1457', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2024-12-10 00:00:00'::timestamptz, '2024-12-10 00:00:00'::timestamptz, '2024-12-10 16:32:00'::timestamptz, '2024-12-10 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-10 16:32:00'::timestamptz); END IF;

  -- CC1458
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1458', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-12-11 00:00:00'::timestamptz, '2024-12-11 16:37:00'::timestamptz, '2024-12-11 15:01:00'::timestamptz, '2024-12-11 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-11 15:01:00'::timestamptz); END IF;

  -- CC1459
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1459', 'Cliente Lavandería', false, 'completed', false, 9.85, 0.14, 0, 0.40, 10.25, 0.00, 0, 8, 'Lavandería', '2024-12-11 00:00:00'::timestamptz, '2024-12-11 16:37:00'::timestamptz, '2024-12-11 15:42:00'::timestamptz, '2024-12-11 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.25, '2024-12-11 15:42:00'::timestamptz); END IF;

  -- CC1460
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1460', 'Erick Rodriguez', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-12-11 00:00:00'::timestamptz, '2024-12-12 11:01:00'::timestamptz, '2024-12-11 16:29:00'::timestamptz, '2024-12-11 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-11 16:29:00'::timestamptz); END IF;

  -- CC1461
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1461', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, '', '2024-12-12 00:00:00'::timestamptz, '2024-12-12 14:19:00'::timestamptz, '2024-12-12 11:01:00'::timestamptz, '2024-12-12 11:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-12 11:01:00'::timestamptz); END IF;

  -- CC1462
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 121;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1462', 'Yamy Victoria', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-12-12 00:00:00'::timestamptz, '2024-12-12 16:08:00'::timestamptz, '2024-12-12 14:19:00'::timestamptz, '2024-12-12 14:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-12 14:19:00'::timestamptz); END IF;

  -- CC1463
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1463', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-12 00:00:00'::timestamptz, '2024-12-12 16:08:00'::timestamptz, '2024-12-12 14:34:00'::timestamptz, '2024-12-12 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-12 14:34:00'::timestamptz); END IF;

  -- CC1464
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1464', 'Renzo Mundo', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-12 00:00:00'::timestamptz, '2024-12-12 16:09:00'::timestamptz, '2024-12-12 16:07:00'::timestamptz, '2024-12-12 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-12 16:07:00'::timestamptz); END IF;

  -- CC1465
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 96;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1465', 'Evy Ortega', false, 'completed', false, 26.00, 0.00, 0, 1.82, 27.82, 0.00, 0, 3, '0', '2024-12-13 00:00:00'::timestamptz, '2024-12-13 14:17:00'::timestamptz, '2024-12-13 10:44:00'::timestamptz, '2024-12-13 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.82 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.82, '2024-12-13 10:44:00'::timestamptz); END IF;

  -- CC1466
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1466', 'Retail', true, 'completed', false, 3.75, 0.00, 0, 0.00, 3.75, 0.00, 0, 5, '', '2024-12-13 00:00:00'::timestamptz, '2024-12-13 00:00:00'::timestamptz, '2024-12-13 12:20:00'::timestamptz, '2024-12-13 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2024-12-13 12:20:00'::timestamptz); END IF;

  -- CC1467
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1467', 'Guzmán', false, 'completed', false, 15.75, 0.00, 0, 1.10, 16.85, 6.30, 3, 1, '', '2024-12-13 00:00:00'::timestamptz, '2024-12-13 14:16:00'::timestamptz, '2024-12-13 12:34:00'::timestamptz, '2024-12-13 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.85, '2024-12-13 12:34:00'::timestamptz); END IF;

  -- CC1468
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1468', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.25, 1, 1, '', '2024-12-13 00:00:00'::timestamptz, '2024-12-13 14:16:00'::timestamptz, '2024-12-13 13:03:00'::timestamptz, '2024-12-13 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-12-13 13:03:00'::timestamptz); END IF;

  -- CC1469
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1469', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-12-13 00:00:00'::timestamptz, '2024-12-14 10:52:00'::timestamptz, '2024-12-13 13:41:00'::timestamptz, '2024-12-13 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-13 13:41:00'::timestamptz); END IF;

  -- CC1470
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1470', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 28.38, 0.00, 0, 1.99, 30.37, 11.35, 3, 1, 'Salón', '2024-12-13 00:00:00'::timestamptz, '2024-12-14 10:53:00'::timestamptz, '2024-12-13 15:23:00'::timestamptz, '2024-12-13 15:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.37 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.37, '2024-12-13 15:23:00'::timestamptz); END IF;

  -- CC1471
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 123;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1471', 'Javier Ortega', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 0.00, 0, 1, '0', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 14:35:00'::timestamptz, '2024-12-14 10:52:00'::timestamptz, '2024-12-14 10:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-12-14 10:52:00'::timestamptz); END IF;

  -- CC1472
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1472', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 13:39:00'::timestamptz, '2024-12-14 12:10:00'::timestamptz, '2024-12-14 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-14 12:10:00'::timestamptz); END IF;

  -- CC1473
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1473', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 14:35:00'::timestamptz, '2024-12-14 12:29:00'::timestamptz, '2024-12-14 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-12-14 12:29:00'::timestamptz); END IF;

  -- CC1474
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1474', 'Cliente Lavandería', false, 'completed', false, 10.28, 0.46, 0, 0.72, 11.00, 0.00, 0, 9, 'Lavandería', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 13:39:00'::timestamptz, '2024-12-14 13:02:00'::timestamptz, '2024-12-14 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-12-14 13:02:00'::timestamptz); END IF;

  -- CC1475
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1475', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 00:00:00'::timestamptz, '2024-12-14 13:37:00'::timestamptz, '2024-12-14 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-14 13:37:00'::timestamptz); END IF;

  -- CC1476
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 58;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1476', 'Erick Rodriguez', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, 'Lavandería', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 15:47:00'::timestamptz, '2024-12-14 13:38:00'::timestamptz, '2024-12-14 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-12-14 13:38:00'::timestamptz); END IF;

  -- CC1477
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 41;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1477', 'Claudia Londoño', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 14:35:00'::timestamptz, '2024-12-14 13:40:00'::timestamptz, '2024-12-14 13:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-14 13:40:00'::timestamptz); END IF;

  -- CC1478
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1478', 'Leonel Visueti', false, 'completed', false, 18.95, 0.27, 0, 1.05, 20.00, 0.00, 0, 14, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 15:47:00'::timestamptz, '2024-12-14 13:51:00'::timestamptz, '2024-12-14 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2024-12-14 13:51:00'::timestamptz); END IF;

  -- CC1479
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 124;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1479', 'Optima Ingierería', false, 'completed', false, 11.50, 0.00, 0, 0.81, 12.31, 4.20, 1, 2, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 17:52:00'::timestamptz, '2024-12-14 13:55:00'::timestamptz, '2024-12-14 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.31 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.31, '2024-12-14 13:55:00'::timestamptz); END IF;

  -- CC1480
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1480', 'Retail', true, 'completed', false, 5.25, 0.00, 0, 0.00, 5.25, 0.00, 0, 6, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 00:00:00'::timestamptz, '2024-12-14 15:20:00'::timestamptz, '2024-12-14 15:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2024-12-14 15:20:00'::timestamptz); END IF;

  -- CC1481
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1481', 'Gisselle', false, 'completed', false, 11.63, 0.00, 0, 0.81, 12.44, 4.65, 1, 1, '0', '2024-12-14 00:00:00'::timestamptz, '2024-12-15 13:47:00'::timestamptz, '2024-12-14 15:25:00'::timestamptz, '2024-12-14 15:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.44 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.44, '2024-12-14 15:25:00'::timestamptz); END IF;

  -- CC1482
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 120;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1482', 'Odilia Guzman', false, 'completed', false, 24.06, 0.00, 0, 1.68, 25.74, 13.75, 4, 1, 'Lavandería', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 16:02:00'::timestamptz, '2024-12-14 15:38:00'::timestamptz, '2024-12-14 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.74 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.74, '2024-12-14 15:38:00'::timestamptz); END IF;

  -- CC1483
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1483', 'Leonel Visueti', false, 'completed', false, 5.67, 0.07, 0, 0.33, 6.00, 0.00, 0, 5, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 16:59:00'::timestamptz, '2024-12-14 15:59:00'::timestamptz, '2024-12-14 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-14 15:59:00'::timestamptz); END IF;

  -- CC1484
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1484', 'Blanca', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 5, '0', '2024-12-15 00:00:00'::timestamptz, '2024-12-14 19:31:00'::timestamptz, '2024-12-14 17:53:00'::timestamptz, '2024-12-14 17:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-14 17:53:00'::timestamptz); END IF;

  -- CC1485
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1485', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 19:31:00'::timestamptz, '2024-12-14 17:54:00'::timestamptz, '2024-12-14 17:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-14 17:54:00'::timestamptz); END IF;

  -- CC1486
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1486', 'Retail', true, 'completed', false, 3.12, 0.13, 0, 0.13, 3.25, 0.00, 0, 3, '', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 00:00:00'::timestamptz, '2024-12-14 18:18:00'::timestamptz, '2024-12-14 18:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.25, '2024-12-14 18:18:00'::timestamptz); END IF;

  -- CC1487
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 125;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1487', 'Yisel Acosta', false, 'completed', false, 14.95, 1.88, 0, 1.05, 16.00, 0.00, 0, 9, 'Lavandería', '2024-12-14 00:00:00'::timestamptz, '2024-12-14 20:05:00'::timestamptz, '2024-12-14 19:13:00'::timestamptz, '2024-12-14 19:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-12-14 19:13:00'::timestamptz); END IF;

  -- CC1488
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1488', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 00:00:00'::timestamptz, '2024-12-14 19:16:00'::timestamptz, '2024-12-14 19:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-12-14 19:16:00'::timestamptz); END IF;

  -- CC1489
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1489', 'Leonel Visueti', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 11:02:00'::timestamptz, '2024-12-15 08:59:00'::timestamptz, '2024-12-15 08:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-15 08:59:00'::timestamptz); END IF;

  -- CC1490
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1490', 'Leonel Willson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 13:47:00'::timestamptz, '2024-12-15 09:50:00'::timestamptz, '2024-12-15 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-15 09:50:00'::timestamptz); END IF;

  -- CC1491
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1491', 'Cliente Lavandería', false, 'completed', false, 5.61, 3.87, 0, 0.39, 6.00, 0.00, 0, 6, 'Lavandería', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 13:47:00'::timestamptz, '2024-12-15 10:24:00'::timestamptz, '2024-12-15 10:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-15 10:24:00'::timestamptz); END IF;

  -- CC1492
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 127;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1492', 'Arturo Moreno', false, 'completed', false, 7.63, 0.00, 0, 0.53, 8.16, 2.45, 1, 4, '0', '2024-12-15 00:00:00'::timestamptz, '2024-12-16 11:34:00'::timestamptz, '2024-12-15 11:14:00'::timestamptz, '2024-12-15 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.16 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.16, '2024-12-15 11:14:00'::timestamptz); END IF;

  -- CC1493
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 128;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1493', 'Irsa Biscomb', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 13:47:00'::timestamptz, '2024-12-15 11:26:00'::timestamptz, '2024-12-15 11:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-15 11:26:00'::timestamptz); END IF;

  -- CC1494
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1494', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 1, '', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 00:00:00'::timestamptz, '2024-12-15 12:12:00'::timestamptz, '2024-12-15 12:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2024-12-15 12:12:00'::timestamptz); END IF;

  -- CC1495
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1495', 'Retail', true, 'completed', false, 4.36, 0.14, 0, 0.14, 4.50, 0.00, 0, 4, '', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 00:00:00'::timestamptz, '2024-12-15 14:41:00'::timestamptz, '2024-12-15 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2024-12-15 14:41:00'::timestamptz); END IF;

  -- CC1496
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1496', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 4, '', '2024-12-15 00:00:00'::timestamptz, '2024-12-15 00:00:00'::timestamptz, '2024-12-15 14:53:00'::timestamptz, '2024-12-15 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-15 14:53:00'::timestamptz); END IF;

  -- CC1497
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1497', 'Academia Jireh', false, 'completed', false, 26.00, 0.00, 0, 1.82, 27.82, 1.15, 1, 6, '0', '2024-12-17 00:00:00'::timestamptz, '2024-12-16 12:30:00'::timestamptz, '2024-12-16 09:36:00'::timestamptz, '2024-12-16 09:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 27.82 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 27.82, '2024-12-16 09:36:00'::timestamptz); END IF;

  -- CC1498
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1498', 'Rosa Arrocha', false, 'completed', false, 7.63, 0.00, 0, 0.53, 8.16, 3.05, 1, 1, 'Lavandería', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 15:15:00'::timestamptz, '2024-12-16 10:36:00'::timestamptz, '2024-12-16 10:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.16 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.16, '2024-12-16 10:36:00'::timestamptz); END IF;

  -- CC1499
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 97;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1499', 'Cesar Beltrán', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, '0', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 13:14:00'::timestamptz, '2024-12-16 12:48:00'::timestamptz, '2024-12-16 12:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-16 12:48:00'::timestamptz); END IF;

  -- CC1500
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1500', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-12-17 00:00:00'::timestamptz, '2024-12-16 15:15:00'::timestamptz, '2024-12-16 13:00:00'::timestamptz, '2024-12-16 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-16 13:00:00'::timestamptz); END IF;

  -- CC1501
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1501', 'Grethell Guevara', false, 'completed', false, 79.88, 0.00, 0, 5.59, 85.47, 29.15, 7, 8, 'Lavandería', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 16:43:00'::timestamptz, '2024-12-16 15:17:00'::timestamptz, '2024-12-16 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 85.47 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 85.47, '2024-12-16 15:17:00'::timestamptz); END IF;

  -- CC1502
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1502', 'Aaron Gutierrez', false, 'completed', false, 8.91, 0.20, 0, 0.59, 9.50, 0.00, 0, 7, 'Lavandería', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 17:26:00'::timestamptz, '2024-12-16 16:30:00'::timestamptz, '2024-12-16 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.50, '2024-12-16 16:30:00'::timestamptz); END IF;

  -- CC1503
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1503', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 16:32:00'::timestamptz, '2024-12-16 16:31:00'::timestamptz, '2024-12-16 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-16 16:31:00'::timestamptz); END IF;

  -- CC1504
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1504', 'Retail', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, '', '2024-12-16 00:00:00'::timestamptz, '2024-12-16 00:00:00'::timestamptz, '2024-12-16 16:47:00'::timestamptz, '2024-12-16 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2024-12-16 16:47:00'::timestamptz); END IF;

  -- CC1505
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1505', 'Manuel Rueda', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-12-17 00:00:00'::timestamptz, '2024-12-17 14:14:00'::timestamptz, '2024-12-17 11:34:00'::timestamptz, '2024-12-17 11:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-17 11:34:00'::timestamptz); END IF;

  -- CC1506
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1506', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-12-17 00:00:00'::timestamptz, '2024-12-17 14:14:00'::timestamptz, '2024-12-17 11:35:00'::timestamptz, '2024-12-17 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-17 11:35:00'::timestamptz); END IF;

  -- CC1507
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1507', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 47.13, 0.00, 0, 3.30, 50.43, 18.85, 5, 1, 'Salón', '2024-12-17 00:00:00'::timestamptz, '2024-12-17 15:08:00'::timestamptz, '2024-12-17 14:06:00'::timestamptz, '2024-12-17 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 50.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 50.43, '2024-12-17 14:06:00'::timestamptz); END IF;

  -- CC1508
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1508', 'Leonel Visueti', false, 'completed', false, 3.43, 0.07, 0, 0.07, 3.50, 0.00, 0, 6, '', '2024-12-17 00:00:00'::timestamptz, '2024-12-18 08:04:00'::timestamptz, '2024-12-17 16:50:00'::timestamptz, '2024-12-17 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-12-17 16:50:00'::timestamptz); END IF;

  -- CC1509
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1509', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-12-18 00:00:00'::timestamptz, '2024-12-18 14:53:00'::timestamptz, '2024-12-18 12:55:00'::timestamptz, '2024-12-18 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-18 12:55:00'::timestamptz); END IF;

  -- CC1510
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1510', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2024-12-18 00:00:00'::timestamptz, '2024-12-19 08:18:00'::timestamptz, '2024-12-18 14:53:00'::timestamptz, '2024-12-18 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-12-18 14:53:00'::timestamptz); END IF;

  -- CC1511
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1511', 'Academia Jireh', false, 'completed', false, 18.00, 0.00, 0, 1.26, 19.26, 0.00, 0, 3, '0', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 15:16:00'::timestamptz, '2024-12-19 10:23:00'::timestamptz, '2024-12-19 10:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.26 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.26, '2024-12-19 10:23:00'::timestamptz); END IF;

  -- CC1512
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1512', 'Guzmán', false, 'completed', false, 12.00, 0.00, 0, 0.84, 12.84, 1.50, 1, 2, '', '2024-12-20 00:00:00'::timestamptz, '2024-12-19 15:16:00'::timestamptz, '2024-12-19 12:59:00'::timestamptz, '2024-12-19 12:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.84 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.84, '2024-12-19 12:59:00'::timestamptz); END IF;

  -- CC1513
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1513', 'Guzmán', false, 'completed', false, 13.00, 0.00, 0, 0.91, 13.91, 5.20, 3, 1, '', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 15:16:00'::timestamptz, '2024-12-19 14:28:00'::timestamptz, '2024-12-19 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.91 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.91, '2024-12-19 14:28:00'::timestamptz); END IF;

  -- CC1514
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1514', 'Guzmán', false, 'completed', false, 6.21, 0.00, 0, 0.43, 6.64, 3.55, 1, 1, '', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 16:03:00'::timestamptz, '2024-12-19 15:17:00'::timestamptz, '2024-12-19 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.64 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.64, '2024-12-19 15:17:00'::timestamptz); END IF;

  -- CC1515
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1515', 'Leonel Visueti', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, '', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 16:51:00'::timestamptz, '2024-12-19 15:42:00'::timestamptz, '2024-12-19 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-12-19 15:42:00'::timestamptz); END IF;

  -- CC1516
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1516', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 17:16:00'::timestamptz, '2024-12-19 15:43:00'::timestamptz, '2024-12-19 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-19 15:43:00'::timestamptz); END IF;

  -- CC1517
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1517', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 16:25:00'::timestamptz, '2024-12-19 15:47:00'::timestamptz, '2024-12-19 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-19 15:47:00'::timestamptz); END IF;

  -- CC1518
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1518', 'Renzo Mundo', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 17:16:00'::timestamptz, '2024-12-19 15:48:00'::timestamptz, '2024-12-19 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-19 15:48:00'::timestamptz); END IF;

  -- CC1519
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1519', 'Retail', true, 'completed', false, 3.50, 0.00, 0, 0.00, 3.50, 0.00, 0, 3, '', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 00:00:00'::timestamptz, '2024-12-19 16:25:00'::timestamptz, '2024-12-19 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2024-12-19 16:25:00'::timestamptz); END IF;

  -- CC1520
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1520', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 4, '', '2024-12-19 00:00:00'::timestamptz, '2024-12-19 00:00:00'::timestamptz, '2024-12-19 17:00:00'::timestamptz, '2024-12-19 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-19 17:00:00'::timestamptz); END IF;

  -- CC1521
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1521', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 16:29:00'::timestamptz, '2024-12-20 14:24:00'::timestamptz, '2024-12-20 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-20 14:24:00'::timestamptz); END IF;

  -- CC1522
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1522', 'Cliente Lavandería', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 16:29:00'::timestamptz, '2024-12-20 14:24:00'::timestamptz, '2024-12-20 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-20 14:24:00'::timestamptz); END IF;

  -- CC1523
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1523', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 16:30:00'::timestamptz, '2024-12-20 14:25:00'::timestamptz, '2024-12-20 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-12-20 14:25:00'::timestamptz); END IF;

  -- CC1524
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1524', 'Oscar Oropeza', false, 'completed', false, 14.95, 0.01, 0, 1.05, 16.00, 0.00, 0, 8, 'Lavandería', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 16:29:00'::timestamptz, '2024-12-20 15:01:00'::timestamptz, '2024-12-20 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2024-12-20 15:01:00'::timestamptz); END IF;

  -- CC1525
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1525', 'Lina Perez', false, 'completed', false, 36.89, 0.80, 0, 2.36, 39.25, 0.00, 0, 27, 'Lavandería', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 16:30:00'::timestamptz, '2024-12-20 16:05:00'::timestamptz, '2024-12-20 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 39.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 39.25, '2024-12-20 16:05:00'::timestamptz); END IF;

  -- CC1526
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1526', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 18:41:00'::timestamptz, '2024-12-20 16:30:00'::timestamptz, '2024-12-20 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-20 16:30:00'::timestamptz); END IF;

  -- CC1527
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1527', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 20.88, 0.00, 0, 1.46, 22.34, 8.35, 3, 1, 'Salón', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 18:40:00'::timestamptz, '2024-12-20 18:06:00'::timestamptz, '2024-12-20 18:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.34, '2024-12-20 18:06:00'::timestamptz); END IF;

  -- CC1528
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1528', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, '', '2024-12-20 00:00:00'::timestamptz, '2024-12-20 00:00:00'::timestamptz, '2024-12-20 18:17:00'::timestamptz, '2024-12-20 18:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2024-12-20 18:17:00'::timestamptz); END IF;

  -- CC1529
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1529', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 00:00:00'::timestamptz, '2024-12-21 09:28:00'::timestamptz, '2024-12-21 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-12-21 09:28:00'::timestamptz); END IF;

  -- CC1530
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 113;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1530', 'Aneth Villamonte', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 12:30:00'::timestamptz, '2024-12-21 09:32:00'::timestamptz, '2024-12-21 09:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-21 09:32:00'::timestamptz); END IF;

  -- CC1531
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1531', 'Octavio Cherigo', false, 'completed', false, 18.50, 0.00, 0, 1.30, 19.80, 6.60, 1, 3, 'Lavandería', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 14:28:00'::timestamptz, '2024-12-21 10:43:00'::timestamptz, '2024-12-21 10:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.80 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.80, '2024-12-21 10:43:00'::timestamptz); END IF;

  -- CC1532
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1532', 'Leonel Visueti', false, 'completed', false, 7.99, 0.00, 0, 0.26, 8.25, 0.00, 0, 9, '', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 18:33:00'::timestamptz, '2024-12-21 14:32:00'::timestamptz, '2024-12-21 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.25, '2024-12-21 14:32:00'::timestamptz); END IF;

  -- CC1533
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1533', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.30, 4.54, 0.00, 0, 3, '', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 18:33:00'::timestamptz, '2024-12-21 16:00:00'::timestamptz, '2024-12-21 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.54 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.54, '2024-12-21 16:00:00'::timestamptz); END IF;

  -- CC1534
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1534', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-12-21 00:00:00'::timestamptz, '2024-12-21 18:56:00'::timestamptz, '2024-12-21 18:34:00'::timestamptz, '2024-12-21 18:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-21 18:34:00'::timestamptz); END IF;

  -- CC1535
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1535', 'Leonardo Salon', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'leonardo', '2024-12-22 00:00:00'::timestamptz, '2024-12-22 14:27:00'::timestamptz, '2024-12-22 12:27:00'::timestamptz, '2024-12-22 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-22 12:27:00'::timestamptz); END IF;

  -- CC1536
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1536', 'Gisselle', false, 'completed', false, 10.25, 0.00, 0, 0.72, 10.97, 4.10, 1, 1, '0', '2024-12-23 00:00:00'::timestamptz, '2024-12-22 15:32:00'::timestamptz, '2024-12-22 13:21:00'::timestamptz, '2024-12-22 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.97 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.97, '2024-12-22 13:21:00'::timestamptz); END IF;

  -- CC1537
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1537', 'Leonel Visueti', false, 'completed', false, 13.15, 0.33, 0, 0.85, 14.00, 0.00, 0, 11, '', '2024-12-22 00:00:00'::timestamptz, '2024-12-22 15:32:00'::timestamptz, '2024-12-22 14:06:00'::timestamptz, '2024-12-22 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2024-12-22 14:06:00'::timestamptz); END IF;

  -- CC1538
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1538', 'Leonel Visueti', false, 'completed', false, 17.76, 0.33, 0, 1.24, 19.00, 0.00, 0, 12, '', '2024-12-23 00:00:00'::timestamptz, '2024-12-23 15:44:00'::timestamptz, '2024-12-23 13:44:00'::timestamptz, '2024-12-23 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.00, '2024-12-23 13:44:00'::timestamptz); END IF;

  -- CC1539
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1539', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 2, '', '2024-12-23 00:00:00'::timestamptz, '2024-12-23 00:00:00'::timestamptz, '2024-12-23 13:58:00'::timestamptz, '2024-12-23 13:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2024-12-23 13:58:00'::timestamptz); END IF;

  -- CC1540
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1540', 'Rafael Quintero', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-12-24 00:00:00'::timestamptz, '2024-12-23 16:58:00'::timestamptz, '2024-12-23 14:35:00'::timestamptz, '2024-12-23 14:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-23 14:35:00'::timestamptz); END IF;

  -- CC1541
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1541', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-24 00:00:00'::timestamptz, '2024-12-23 16:33:00'::timestamptz, '2024-12-23 14:36:00'::timestamptz, '2024-12-23 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-23 14:36:00'::timestamptz); END IF;

  -- CC1542
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1542', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 33.63, 0.00, 0, 2.35, 35.98, 13.45, 5, 1, 'Salón', '2024-12-23 00:00:00'::timestamptz, '2024-12-23 16:35:00'::timestamptz, '2024-12-23 16:24:00'::timestamptz, '2024-12-23 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.98, '2024-12-23 16:24:00'::timestamptz); END IF;

  -- CC1543
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1543', 'Rafael Quintero', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2024-12-23 00:00:00'::timestamptz, '2024-12-23 16:58:00'::timestamptz, '2024-12-23 16:27:00'::timestamptz, '2024-12-23 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-23 16:27:00'::timestamptz); END IF;

  -- CC1544
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1544', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 14:11:00'::timestamptz, '2024-12-24 09:39:00'::timestamptz, '2024-12-24 09:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-12-24 09:39:00'::timestamptz); END IF;

  -- CC1545
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1545', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 11:19:00'::timestamptz, '2024-12-24 09:40:00'::timestamptz, '2024-12-24 09:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-24 09:40:00'::timestamptz); END IF;

  -- CC1546
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1546', 'Yara Rangel', false, 'completed', false, 11.21, 0.01, 0, 0.79, 12.00, 0.00, 0, 6, '0', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 10:55:00'::timestamptz, '2024-12-24 09:41:00'::timestamptz, '2024-12-24 09:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2024-12-24 09:41:00'::timestamptz); END IF;

  -- CC1547
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1547', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 14:11:00'::timestamptz, '2024-12-24 11:42:00'::timestamptz, '2024-12-24 11:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2024-12-24 11:42:00'::timestamptz); END IF;

  -- CC1548
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1548', 'Yara Rangel', false, 'completed', false, 10.28, 0.20, 0, 0.72, 11.00, 0.00, 0, 7, '0', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 14:11:00'::timestamptz, '2024-12-24 13:11:00'::timestamptz, '2024-12-24 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2024-12-24 13:11:00'::timestamptz); END IF;

  -- CC1549
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 92;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1549', 'Manuel Rueda', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2024-12-24 00:00:00'::timestamptz, '2024-12-24 14:11:00'::timestamptz, '2024-12-24 13:13:00'::timestamptz, '2024-12-24 13:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-24 13:13:00'::timestamptz); END IF;

  -- CC1550
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1550', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 12:49:00'::timestamptz, '2024-12-26 10:47:00'::timestamptz, '2024-12-26 10:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-26 10:47:00'::timestamptz); END IF;

  -- CC1551
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 83;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1551', 'Sara Charles', false, 'completed', false, 4.67, 0.07, 0, 0.33, 5.00, 0.00, 0, 3, 'Lavandería', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 13:42:00'::timestamptz, '2024-12-26 11:55:00'::timestamptz, '2024-12-26 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-26 11:55:00'::timestamptz); END IF;

  -- CC1552
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1552', 'Guzmán', false, 'completed', false, 19.13, 0.00, 0, 1.34, 20.47, 7.65, 4, 1, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 15:15:00'::timestamptz, '2024-12-26 12:55:00'::timestamptz, '2024-12-26 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.47 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.47, '2024-12-26 12:55:00'::timestamptz); END IF;

  -- CC1553
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1553', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 15:16:00'::timestamptz, '2024-12-26 13:12:00'::timestamptz, '2024-12-26 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2024-12-26 13:12:00'::timestamptz); END IF;

  -- CC1554
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1554', 'Aaron Gutierrez', false, 'completed', false, 14.52, 0.20, 0, 0.98, 15.50, 0.00, 0, 10, 'Lavandería', '2024-12-27 00:00:00'::timestamptz, '2024-12-26 15:16:00'::timestamptz, '2024-12-26 13:39:00'::timestamptz, '2024-12-26 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.50, '2024-12-26 13:39:00'::timestamptz); END IF;

  -- CC1555
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1555', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 00:00:00'::timestamptz, '2024-12-26 13:41:00'::timestamptz, '2024-12-26 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-12-26 13:41:00'::timestamptz); END IF;

  -- CC1556
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1556', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 00:00:00'::timestamptz, '2024-12-26 15:52:00'::timestamptz, '2024-12-26 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2024-12-26 15:52:00'::timestamptz); END IF;

  -- CC1557
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1557', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '', '2024-12-26 00:00:00'::timestamptz, '2024-12-26 00:00:00'::timestamptz, '2024-12-26 16:06:00'::timestamptz, '2024-12-26 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2024-12-26 16:06:00'::timestamptz); END IF;

  -- CC1558
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1558', 'Rosa Arrocha', false, 'completed', false, 8.05, 0.00, 0, 0.56, 8.61, 3.10, 1, 3, 'Lavandería', '2024-12-28 00:00:00'::timestamptz, '2024-12-27 14:41:00'::timestamptz, '2024-12-27 10:56:00'::timestamptz, '2024-12-27 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.61 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.61, '2024-12-27 10:56:00'::timestamptz); END IF;

  -- CC1559
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 130;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1559', 'Ana Quesada', false, 'completed', false, 17.82, 0.14, 0, 1.18, 19.00, 0.00, 0, 12, '', '2024-12-27 00:00:00'::timestamptz, '2024-12-27 14:41:00'::timestamptz, '2024-12-27 10:59:00'::timestamptz, '2024-12-27 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.00, '2024-12-27 10:59:00'::timestamptz); END IF;

  -- CC1560
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1560', 'Guzmán', false, 'completed', false, 17.75, 0.00, 0, 1.24, 18.99, 7.10, 3, 1, '', '2024-12-27 00:00:00'::timestamptz, '2024-12-27 14:41:00'::timestamptz, '2024-12-27 13:19:00'::timestamptz, '2024-12-27 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.99, '2024-12-27 13:19:00'::timestamptz); END IF;

  -- CC1561
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1561', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 44.63, 0.00, 0, 3.12, 47.75, 17.85, 6, 1, 'Salón', '2024-12-27 00:00:00'::timestamptz, '2024-12-27 16:19:00'::timestamptz, '2024-12-27 15:56:00'::timestamptz, '2024-12-27 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 47.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 47.75, '2024-12-27 15:56:00'::timestamptz); END IF;

  -- CC1562
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1562', 'Cliente Lavandería', false, 'completed', false, 8.41, 0.07, 0, 0.59, 9.00, 0.00, 0, 5, 'Lavandería', '2024-12-27 00:00:00'::timestamptz, '2024-12-27 16:48:00'::timestamptz, '2024-12-27 16:08:00'::timestamptz, '2024-12-27 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-12-27 16:08:00'::timestamptz); END IF;

  -- CC1563
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1563', 'Blanca', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2024-12-27 00:00:00'::timestamptz, '2024-12-27 16:22:00'::timestamptz, '2024-12-27 16:08:00'::timestamptz, '2024-12-27 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-27 16:08:00'::timestamptz); END IF;

  -- CC1564
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1564', 'Renzo Mundo', false, 'completed', false, 8.41, 0.07, 0, 0.59, 9.00, 0.00, 0, 5, 'Lavandería', '2024-12-28 00:00:00'::timestamptz, '2024-12-29 12:32:00'::timestamptz, '2024-12-28 13:23:00'::timestamptz, '2024-12-28 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2024-12-28 13:23:00'::timestamptz); END IF;

  -- CC1565
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1565', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.66, 10.14, 0.00, 0, 6, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 13:25:00'::timestamptz, '2024-12-28 13:24:00'::timestamptz, '2024-12-28 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.14 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.14, '2024-12-28 13:24:00'::timestamptz); END IF;

  -- CC1566
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1566', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:04:00'::timestamptz, '2024-12-28 13:27:00'::timestamptz, '2024-12-28 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-28 13:27:00'::timestamptz); END IF;

  -- CC1567
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1567', 'Cliente Lavandería', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2024-12-29 00:00:00'::timestamptz, '2024-12-28 15:04:00'::timestamptz, '2024-12-28 13:30:00'::timestamptz, '2024-12-28 13:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2024-12-28 13:30:00'::timestamptz); END IF;

  -- CC1568
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1568', 'Leonel Visueti', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:04:00'::timestamptz, '2024-12-28 13:37:00'::timestamptz, '2024-12-28 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-12-28 13:37:00'::timestamptz); END IF;

  -- CC1569
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1569', 'Guzmán', false, 'completed', false, 2.19, 0.00, 0, 0.15, 2.34, 1.25, 1, 1, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:48:00'::timestamptz, '2024-12-28 14:17:00'::timestamptz, '2024-12-28 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.34, '2024-12-28 14:17:00'::timestamptz); END IF;

  -- CC1570
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1570', 'Leonel Visueti', false, 'completed', false, 28.97, 0.47, 0, 2.03, 31.00, 0.00, 0, 19, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:04:00'::timestamptz, '2024-12-28 14:34:00'::timestamptz, '2024-12-28 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.00, '2024-12-28 14:34:00'::timestamptz); END IF;

  -- CC1571
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1571', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:48:00'::timestamptz, '2024-12-28 14:36:00'::timestamptz, '2024-12-28 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2024-12-28 14:36:00'::timestamptz); END IF;

  -- CC1572
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1572', 'Guzmán', false, 'completed', false, 4.64, 0.00, 0, 0.32, 4.96, 2.65, 1, 1, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:48:00'::timestamptz, '2024-12-28 14:38:00'::timestamptz, '2024-12-28 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.96 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.96, '2024-12-28 14:38:00'::timestamptz); END IF;

  -- CC1573
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1573', 'Guzmán', false, 'completed', false, 6.00, 0.00, 0, 0.42, 6.42, 2.20, 1, 1, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-28 15:47:00'::timestamptz, '2024-12-28 15:44:00'::timestamptz, '2024-12-28 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.42 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.42, '2024-12-28 15:44:00'::timestamptz); END IF;

  -- CC1574
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1574', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2024-12-28 00:00:00'::timestamptz, '2024-12-29 12:32:00'::timestamptz, '2024-12-28 16:55:00'::timestamptz, '2024-12-28 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-28 16:55:00'::timestamptz); END IF;

  -- CC1575
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1575', 'Relax Cala,S.A', false, 'completed', false, 176.84, 0.00, 0, 12.38, 189.22, 60.15, 1, 65, 'Lavandería', '2024-12-29 00:00:00'::timestamptz, '2024-12-30 17:55:00'::timestamptz, '2024-12-29 11:58:00'::timestamptz, '2024-12-29 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 189.22 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 189.22, '2024-12-29 11:58:00'::timestamptz); END IF;

  -- CC1576
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1576', 'Lina Perez', false, 'completed', false, 30.94, 0.00, 0, 2.06, 33.00, 0.00, 0, 21, 'Lavandería', '2024-12-29 00:00:00'::timestamptz, '2024-12-29 12:32:00'::timestamptz, '2024-12-29 12:30:00'::timestamptz, '2024-12-29 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 33.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 33.00, '2024-12-29 12:30:00'::timestamptz); END IF;

  -- CC1577
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1577', 'Cliente Lavandería', false, 'completed', false, 28.10, 0.86, 0, 1.90, 30.00, 0.00, 0, 22, 'Lavandería', '2024-12-30 00:00:00'::timestamptz, '2024-12-29 15:46:00'::timestamptz, '2024-12-29 14:01:00'::timestamptz, '2024-12-29 14:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.00, '2024-12-29 14:01:00'::timestamptz); END IF;

  -- CC1578
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1578', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2024-12-29 00:00:00'::timestamptz, '2024-12-29 00:00:00'::timestamptz, '2024-12-29 14:04:00'::timestamptz, '2024-12-29 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2024-12-29 14:04:00'::timestamptz); END IF;

  -- CC1579
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1579', 'Leonel Visueti', false, 'completed', false, 13.76, 0.12, 0, 0.82, 14.58, 3.95, 1, 5, '', '2024-12-29 00:00:00'::timestamptz, '2024-12-29 15:46:00'::timestamptz, '2024-12-29 14:30:00'::timestamptz, '2024-12-29 14:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.58 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.58, '2024-12-29 14:30:00'::timestamptz); END IF;

  -- CC1580
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1580', 'Leonel Visueti', false, 'completed', false, 6.61, 0.13, 0, 0.39, 7.00, 0.00, 0, 6, '', '2024-12-29 00:00:00'::timestamptz, '2024-12-29 15:49:00'::timestamptz, '2024-12-29 14:46:00'::timestamptz, '2024-12-29 14:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2024-12-29 14:46:00'::timestamptz); END IF;

  -- CC1581
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1581', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 6, '', '2024-12-29 00:00:00'::timestamptz, '2024-12-29 00:00:00'::timestamptz, '2024-12-29 16:03:00'::timestamptz, '2024-12-29 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-29 16:03:00'::timestamptz); END IF;

  -- CC1582
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1582', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 29.25, 0.00, 0, 2.05, 31.30, 11.70, 5, 1, 'Salón', '2024-12-30 00:00:00'::timestamptz, '2024-12-30 17:55:00'::timestamptz, '2024-12-30 17:44:00'::timestamptz, '2024-12-30 17:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.30 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.30, '2024-12-30 17:44:00'::timestamptz); END IF;

  -- CC1583
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1583', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 6, '', '2024-12-30 00:00:00'::timestamptz, '2024-12-30 00:00:00'::timestamptz, '2024-12-30 17:49:00'::timestamptz, '2024-12-30 17:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-30 17:49:00'::timestamptz); END IF;

  -- CC1584
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1584', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2024-12-30 00:00:00'::timestamptz, '2024-12-31 08:13:00'::timestamptz, '2024-12-30 17:52:00'::timestamptz, '2024-12-30 17:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-30 17:52:00'::timestamptz); END IF;

  -- CC1585
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1585', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.50, 0.00, 0, 1.02, 15.52, 5.80, 3, 1, 'Salón', '2025-01-31 00:00:00'::timestamptz, '2024-12-31 13:30:00'::timestamptz, '2024-12-31 11:34:00'::timestamptz, '2024-12-31 11:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.52 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.52, '2024-12-31 11:34:00'::timestamptz); END IF;

  -- CC1586
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1586', 'Fany Luz Salon', false, 'completed', false, 5.14, 0.10, 0, 0.36, 5.50, 0.00, 0, 5, '0', '2024-12-31 00:00:00'::timestamptz, '2024-12-31 13:30:00'::timestamptz, '2024-12-31 11:49:00'::timestamptz, '2024-12-31 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2024-12-31 11:49:00'::timestamptz); END IF;

  -- CC1587
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1587', 'Leonel Visueti', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, '', '2024-12-31 00:00:00'::timestamptz, '2024-12-31 14:39:00'::timestamptz, '2024-12-31 13:30:00'::timestamptz, '2024-12-31 13:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2024-12-31 13:30:00'::timestamptz); END IF;

  -- CC1588
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1588', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 7, '', '2024-12-31 00:00:00'::timestamptz, '2024-12-31 00:00:00'::timestamptz, '2024-12-31 14:38:00'::timestamptz, '2024-12-31 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2024-12-31 14:38:00'::timestamptz); END IF;

  -- CC1589
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1589', 'Relax Cala,S.A', false, 'completed', false, 76.16, 0.00, 0, 5.33, 81.49, 21.85, 6, 37, 'Lavandería', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:28:00'::timestamptz, '2025-01-03 10:21:00'::timestamptz, '2025-01-03 10:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 81.49 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 81.49, '2025-01-03 10:21:00'::timestamptz); END IF;

  -- CC1590
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1590', 'Guzmán', false, 'completed', false, 17.75, 0.00, 0, 1.24, 18.99, 7.10, 3, 1, '', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:29:00'::timestamptz, '2025-01-03 11:45:00'::timestamptz, '2025-01-03 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.99, '2025-01-03 11:45:00'::timestamptz); END IF;

  -- CC1591
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1591', 'Guzmán', false, 'completed', false, 6.75, 0.00, 0, 0.47, 7.22, 2.70, 1, 1, '', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:29:00'::timestamptz, '2025-01-03 12:03:00'::timestamptz, '2025-01-03 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.22 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.22, '2025-01-03 12:03:00'::timestamptz); END IF;

  -- CC1592
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1592', 'Retail', true, 'completed', false, 4.00, 0.00, 0, 0.00, 4.00, 0.00, 0, 5, '', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:30:00'::timestamptz, '2025-01-03 18:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-03 18:30:00'::timestamptz); END IF;

  -- CC1593
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1593', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:34:00'::timestamptz, '2025-01-03 18:31:00'::timestamptz, '2025-01-03 18:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-03 18:31:00'::timestamptz); END IF;

  -- CC1594
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1594', 'Sandra Medina', false, 'completed', false, 11.21, 0.27, 0, 0.78, 11.99, 0.00, 0, 8, '0', '2025-01-03 00:00:00'::timestamptz, '2025-01-03 18:34:00'::timestamptz, '2025-01-03 18:33:00'::timestamptz, '2025-01-03 18:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.99, '2025-01-03 18:33:00'::timestamptz); END IF;

  -- CC1595
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1595', 'Relax Cala,S.A', false, 'completed', false, 205.50, 0.00, 0, 14.39, 219.89, 59.00, 13, 99, 'Lavandería', '2025-01-04 00:00:00'::timestamptz, '2025-01-05 16:09:00'::timestamptz, '2025-01-04 08:43:00'::timestamptz, '2025-01-04 08:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 219.89 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 219.89, '2025-01-04 08:43:00'::timestamptz); END IF;

  -- CC1596
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1596', 'Guzmán', false, 'completed', false, 13.64, 0.00, 0, 0.95, 14.59, 6.55, 2, 2, '', '2025-01-04 00:00:00'::timestamptz, '2025-01-04 15:20:00'::timestamptz, '2025-01-04 14:34:00'::timestamptz, '2025-01-04 14:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.59, '2025-01-04 14:34:00'::timestamptz); END IF;

  -- CC1597
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1597', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 17.00, 0.00, 0, 1.19, 18.19, 6.80, 4, 1, 'Salón', '2025-01-04 00:00:00'::timestamptz, '2025-01-04 15:42:00'::timestamptz, '2025-01-04 15:17:00'::timestamptz, '2025-01-04 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.19 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.19, '2025-01-04 15:17:00'::timestamptz); END IF;

  -- CC1598
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1598', 'Relax Cala,S.A', false, 'completed', false, 99.38, 0.00, 0, 6.96, 106.34, 26.75, 7, 48, 'Lavandería', '2025-01-05 00:00:00'::timestamptz, '2025-01-05 16:09:00'::timestamptz, '2025-01-05 09:53:00'::timestamptz, '2025-01-05 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 106.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 106.34, '2025-01-05 09:53:00'::timestamptz); END IF;

  -- CC1599
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1599', 'Leonel Visueti', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, '', '2025-01-05 00:00:00'::timestamptz, '2025-01-05 16:09:00'::timestamptz, '2025-01-05 16:07:00'::timestamptz, '2025-01-05 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-05 16:07:00'::timestamptz); END IF;

  -- CC1600
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1600', 'Relax Cala,S.A', false, 'completed', false, 175.00, 0.00, 0, 12.25, 187.25, 50.60, 9, 80, 'Lavandería', '2025-01-06 00:00:00'::timestamptz, '2025-01-06 18:25:00'::timestamptz, '2025-01-06 12:24:00'::timestamptz, '2025-01-06 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 187.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 187.25, '2025-01-06 12:24:00'::timestamptz); END IF;

  -- CC1601
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1601', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.13, 0, 0.65, 10.00, 0.00, 0, 6, 'Lavandería', '2025-01-06 00:00:00'::timestamptz, '2025-01-06 18:25:00'::timestamptz, '2025-01-06 18:22:00'::timestamptz, '2025-01-06 18:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-06 18:22:00'::timestamptz); END IF;

  -- CC1602
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1602', 'Relax Cala,S.A', false, 'completed', false, 185.76, 0.00, 0, 13.00, 198.76, 57.45, 12, 96, 'Lavandería', '2025-01-07 00:00:00'::timestamptz, '2025-01-07 16:38:00'::timestamptz, '2025-01-07 13:53:00'::timestamptz, '2025-01-07 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 198.76 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 198.76, '2025-01-07 13:53:00'::timestamptz); END IF;

  -- CC1603
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1603', 'Leonardo Salon', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'leonardo', '2025-01-07 00:00:00'::timestamptz, '2025-01-07 16:38:00'::timestamptz, '2025-01-07 15:40:00'::timestamptz, '2025-01-07 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-07 15:40:00'::timestamptz); END IF;

  -- CC1604
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1604', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-01-07 00:00:00'::timestamptz, '2025-01-07 16:38:00'::timestamptz, '2025-01-07 15:41:00'::timestamptz, '2025-01-07 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-07 15:41:00'::timestamptz); END IF;

  -- CC1605
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1605', 'Leonel Visueti', false, 'completed', false, 7.48, 0.26, 0, 0.52, 8.00, 0.00, 0, 6, '', '2025-01-07 00:00:00'::timestamptz, '2025-01-07 16:38:00'::timestamptz, '2025-01-07 15:42:00'::timestamptz, '2025-01-07 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-07 15:42:00'::timestamptz); END IF;

  -- CC1606
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1606', 'Relax Cala,S.A', false, 'completed', false, 102.63, 0.00, 0, 7.18, 109.81, 30.05, 5, 38, 'Lavandería', '2025-01-08 00:00:00'::timestamptz, '2025-01-08 16:59:00'::timestamptz, '2025-01-08 16:50:00'::timestamptz, '2025-01-08 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 109.81 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 109.81, '2025-01-08 16:50:00'::timestamptz); END IF;

  -- CC1607
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1607', 'Leonel Visueti', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 2, '', '2025-01-08 00:00:00'::timestamptz, '2025-01-08 17:13:00'::timestamptz, '2025-01-08 17:00:00'::timestamptz, '2025-01-08 17:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-01-08 17:00:00'::timestamptz); END IF;

  -- CC1608
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1608', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 25.00, 0.00, 0, 1.75, 26.75, 10.00, 3, 1, 'Salón', '2025-01-09 00:00:00'::timestamptz, '2025-01-09 15:07:00'::timestamptz, '2025-01-09 13:39:00'::timestamptz, '2025-01-09 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.75, '2025-01-09 13:39:00'::timestamptz); END IF;

  -- CC1609
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1609', 'Octavio Cherigo', false, 'completed', false, 12.50, 0.00, 0, 0.88, 13.38, 4.60, 1, 2, 'Lavandería', '2025-01-09 00:00:00'::timestamptz, '2025-01-09 16:35:00'::timestamptz, '2025-01-09 14:57:00'::timestamptz, '2025-01-09 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.38, '2025-01-09 14:57:00'::timestamptz); END IF;

  -- CC1610
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1610', 'Leonel Visueti', false, 'completed', false, 4.74, 0.13, 0, 0.26, 5.00, 0.00, 0, 4, '', '2025-01-09 00:00:00'::timestamptz, '2025-01-09 15:44:00'::timestamptz, '2025-01-09 15:09:00'::timestamptz, '2025-01-09 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-01-09 15:09:00'::timestamptz); END IF;

  -- CC1611
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1611', 'Guzmán', false, 'completed', false, 15.75, 0.00, 0, 1.10, 16.85, 6.30, 3, 1, '', '2025-01-10 00:00:00'::timestamptz, '2025-01-10 15:23:00'::timestamptz, '2025-01-10 13:05:00'::timestamptz, '2025-01-10 13:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.85, '2025-01-10 13:05:00'::timestamptz); END IF;

  -- CC1612
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1612', 'Leonel Visueti', false, 'completed', false, 4.80, 0.07, 0, 0.20, 5.00, 0.00, 0, 6, '', '2025-01-10 00:00:00'::timestamptz, '2025-01-10 14:30:00'::timestamptz, '2025-01-10 13:06:00'::timestamptz, '2025-01-10 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-01-10 13:06:00'::timestamptz); END IF;

  -- CC1613
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1613', 'Guzmán', false, 'completed', false, 24.48, 0.00, 0, 1.71, 26.19, 11.05, 3, 2, '', '2025-01-10 00:00:00'::timestamptz, '2025-01-10 15:23:00'::timestamptz, '2025-01-10 13:09:00'::timestamptz, '2025-01-10 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.19 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.19, '2025-01-10 13:09:00'::timestamptz); END IF;

  -- CC1614
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1614', 'Guzmán', false, 'completed', false, 2.01, 0.00, 0, 0.14, 2.15, 1.15, 1, 1, '', '2025-01-10 00:00:00'::timestamptz, '2025-01-10 15:28:00'::timestamptz, '2025-01-10 15:24:00'::timestamptz, '2025-01-10 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.15 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.15, '2025-01-10 15:24:00'::timestamptz); END IF;

  -- CC1615
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1615', 'Leonel Visueti', false, 'completed', false, 7.48, 0.13, 0, 0.52, 8.00, 0.00, 0, 5, '', '2025-01-10 00:00:00'::timestamptz, '2025-01-10 16:43:00'::timestamptz, '2025-01-10 15:29:00'::timestamptz, '2025-01-10 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-10 15:29:00'::timestamptz); END IF;

  -- CC1616
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1616', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-01-11 00:00:00'::timestamptz, '2025-01-11 15:52:00'::timestamptz, '2025-01-11 11:30:00'::timestamptz, '2025-01-11 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-11 11:30:00'::timestamptz); END IF;

  -- CC1617
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1617', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.13, 0, 0.26, 4.00, 0.00, 0, 3, 'Lavandería', '2025-01-11 00:00:00'::timestamptz, '2025-01-11 15:52:00'::timestamptz, '2025-01-11 14:54:00'::timestamptz, '2025-01-11 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-11 14:54:00'::timestamptz); END IF;

  -- CC1618
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1618', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 2, '', '2025-01-11 00:00:00'::timestamptz, '2025-01-11 00:00:00'::timestamptz, '2025-01-11 15:24:00'::timestamptz, '2025-01-11 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-01-11 15:24:00'::timestamptz); END IF;

  -- CC1619
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1619', 'Leonel Visueti', false, 'completed', false, 11.21, 0.27, 0, 0.78, 11.99, 0.00, 0, 8, '', '2025-01-12 00:00:00'::timestamptz, '2025-01-12 16:13:00'::timestamptz, '2025-01-12 16:07:00'::timestamptz, '2025-01-12 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.99 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.99, '2025-01-12 16:07:00'::timestamptz); END IF;

  -- CC1620
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1620', 'Retail', true, 'completed', false, 4.75, 0.00, 0, 0.00, 4.75, 0.00, 0, 7, '', '2025-01-12 00:00:00'::timestamptz, '2025-01-12 00:00:00'::timestamptz, '2025-01-12 16:12:00'::timestamptz, '2025-01-12 16:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.75, '2025-01-12 16:12:00'::timestamptz); END IF;

  -- CC1621
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1621', 'Relax Cala,S.A', false, 'completed', false, 166.42, 0.00, 0, 11.65, 178.07, 59.30, 12, 49, 'Lavandería', '2025-01-13 00:00:00'::timestamptz, '2025-01-13 17:12:00'::timestamptz, '2025-01-13 13:11:00'::timestamptz, '2025-01-13 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 178.07 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 178.07, '2025-01-13 13:11:00'::timestamptz); END IF;

  -- CC1622
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1622', 'Cliente Lavandería', false, 'completed', false, 9.35, 0.26, 0, 0.65, 10.00, 0.00, 0, 7, 'Lavandería', '2025-01-13 00:00:00'::timestamptz, '2025-01-13 17:12:00'::timestamptz, '2025-01-13 17:11:00'::timestamptz, '2025-01-13 17:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-01-13 17:11:00'::timestamptz); END IF;

  -- CC1623
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1623', 'Lina Perez', false, 'completed', false, 25.23, 0.60, 0, 1.77, 27.00, 0.00, 0, 18, 'Lavandería', '2025-01-14 00:00:00'::timestamptz, '2025-01-15 13:35:00'::timestamptz, '2025-01-14 14:03:00'::timestamptz, '2025-01-14 14:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 27.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 27.00, '2025-01-14 14:03:00'::timestamptz); END IF;

  -- CC1624
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1624', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-01-14 00:00:00'::timestamptz, '2025-01-15 13:35:00'::timestamptz, '2025-01-14 15:11:00'::timestamptz, '2025-01-14 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-14 15:11:00'::timestamptz); END IF;

  -- CC1625
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1625', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-01-14 00:00:00'::timestamptz, '2025-01-14 00:00:00'::timestamptz, '2025-01-14 15:11:00'::timestamptz, '2025-01-14 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-01-14 15:11:00'::timestamptz); END IF;

  -- CC1626
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1626', 'Leonel Visueti', false, 'completed', false, 12.15, 0.20, 0, 0.85, 13.00, 0.00, 0, 8, '', '2025-01-14 00:00:00'::timestamptz, '2025-01-15 13:35:00'::timestamptz, '2025-01-14 17:02:00'::timestamptz, '2025-01-14 17:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-01-14 17:02:00'::timestamptz); END IF;

  -- CC1627
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1627', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-01-15 00:00:00'::timestamptz, '2025-01-15 16:17:00'::timestamptz, '2025-01-15 13:36:00'::timestamptz, '2025-01-15 13:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-01-15 13:36:00'::timestamptz); END IF;

  -- CC1628
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1628', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2025-01-15 00:00:00'::timestamptz, '2025-01-15 16:17:00'::timestamptz, '2025-01-15 14:09:00'::timestamptz, '2025-01-15 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-01-15 14:09:00'::timestamptz); END IF;

  -- CC1629
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1629', 'Leonel Visueti', false, 'completed', false, 2.80, 0.07, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-01-15 00:00:00'::timestamptz, '2025-01-15 16:17:00'::timestamptz, '2025-01-15 16:04:00'::timestamptz, '2025-01-15 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-15 16:04:00'::timestamptz); END IF;

  -- CC1630
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 73;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1630', 'Noel Hidalgo', false, 'completed', false, 5.61, 0.13, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2025-01-16 00:00:00'::timestamptz, '2025-01-16 11:34:00'::timestamptz, '2025-01-16 10:59:00'::timestamptz, '2025-01-16 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-01-16 10:59:00'::timestamptz); END IF;

  -- CC1631
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1631', 'Yara Rangel', false, 'completed', false, 16.82, 0.01, 0, 1.18, 18.00, 0.00, 0, 9, '0', '2025-01-16 00:00:00'::timestamptz, '2025-01-16 14:46:00'::timestamptz, '2025-01-16 11:34:00'::timestamptz, '2025-01-16 11:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-01-16 11:34:00'::timestamptz); END IF;

  -- CC1632
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 8;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1632', 'Guzmán', false, 'completed', false, 16.63, 0.00, 0, 1.16, 17.79, 6.65, 3, 1, '', '2025-01-17 00:00:00'::timestamptz, '2025-01-17 14:09:00'::timestamptz, '2025-01-17 12:17:00'::timestamptz, '2025-01-17 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.79 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.79, '2025-01-17 12:17:00'::timestamptz); END IF;

  -- CC1633
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1633', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-01-17 00:00:00'::timestamptz, '2025-01-17 00:00:00'::timestamptz, '2025-01-17 16:35:00'::timestamptz, '2025-01-17 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-01-17 16:35:00'::timestamptz); END IF;

  -- CC1634
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1634', 'Rosa Arrocha', false, 'completed', false, 11.75, 0.00, 0, 0.82, 12.57, 4.30, 1, 2, 'Lavandería', '2025-01-18 00:00:00'::timestamptz, '2025-01-18 16:50:00'::timestamptz, '2025-01-18 10:59:00'::timestamptz, '2025-01-18 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.57 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.57, '2025-01-18 10:59:00'::timestamptz); END IF;

  -- CC1635
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 21;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1635', 'Gisselle', false, 'completed', false, 11.90, 0.00, 0, 0.54, 12.44, 2.66, 1, 7, '0', '2025-01-18 00:00:00'::timestamptz, '2025-01-18 16:50:00'::timestamptz, '2025-01-18 13:00:00'::timestamptz, '2025-01-18 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.44 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.44, '2025-01-18 13:00:00'::timestamptz); END IF;

  -- CC1636
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1636', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-01-18 00:00:00'::timestamptz, '2025-01-18 00:00:00'::timestamptz, '2025-01-18 13:59:00'::timestamptz, '2025-01-18 13:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-01-18 13:59:00'::timestamptz); END IF;

  -- CC1637
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1637', 'Retail', true, 'completed', false, 5.00, 0.00, 0, 0.00, 5.00, 0.00, 0, 6, '', '2025-01-18 00:00:00'::timestamptz, '2025-01-18 00:00:00'::timestamptz, '2025-01-18 16:55:00'::timestamptz, '2025-01-18 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-01-18 16:55:00'::timestamptz); END IF;

  -- CC1638
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC1638', 'Relax Cala,S.A', false, 'completed', false, 146.71, 0.00, 0, 10.27, 156.98, 51.65, 6, 44, 'Lavandería', '2025-01-19 00:00:00'::timestamptz, '2025-01-19 14:41:00'::timestamptz, '2025-01-19 09:44:00'::timestamptz, '2025-01-19 09:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 156.98 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 156.98, '2025-01-19 09:44:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 3: Imported orders 1001 to 1500';
END $$;
