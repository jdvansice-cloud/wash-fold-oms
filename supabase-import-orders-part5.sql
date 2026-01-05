-- =============================================
-- CleanCloud Orders Import - Part 5 of 7
-- Orders 2001 to 2500 (of 3472)
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


  -- CC2146
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2146', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 12:24:00'::timestamptz, '2025-06-21 09:56:00'::timestamptz, '2025-06-21 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-06-21 09:56:00'::timestamptz); END IF;

  -- CC2147
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 171;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2147', 'Joel Ortega', false, 'completed', false, 6.78, 0.00, 0, 0.47, 7.25, 2.90, 2, 1, 'lavanderia', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 15:11:00'::timestamptz, '2025-06-21 10:15:00'::timestamptz, '2025-06-21 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.25, '2025-06-21 10:15:00'::timestamptz); END IF;

  -- CC2148
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2148', 'Fany Luz Salon', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-06-22 00:00:00'::timestamptz, '2025-06-21 12:24:00'::timestamptz, '2025-06-21 12:03:00'::timestamptz, '2025-06-21 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-21 12:03:00'::timestamptz); END IF;

  -- CC2149
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2149', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, '', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 13:10:00'::timestamptz, '2025-06-21 12:25:00'::timestamptz, '2025-06-21 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-06-21 12:25:00'::timestamptz); END IF;

  -- CC2150
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2150', 'Leonel Visueti', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 00:00:00'::timestamptz, '2025-06-21 12:50:00'::timestamptz, '2025-06-21 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-06-21 12:50:00'::timestamptz); END IF;

  -- CC2151
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2151', 'Josue Pernett', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavanderia', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 14:04:00'::timestamptz, '2025-06-21 14:02:00'::timestamptz, '2025-06-21 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-06-21 14:02:00'::timestamptz); END IF;

  -- CC2152
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2152', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 15:11:00'::timestamptz, '2025-06-21 14:16:00'::timestamptz, '2025-06-21 14:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-06-21 14:16:00'::timestamptz); END IF;

  -- CC2153
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2153', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 15:11:00'::timestamptz, '2025-06-21 14:17:00'::timestamptz, '2025-06-21 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-21 14:17:00'::timestamptz); END IF;

  -- CC2154
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2154', 'Lina Perez', false, 'completed', false, 23.82, 0.00, 0, 1.18, 25.00, 0.00, 0, 16, 'Lavandería', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 15:11:00'::timestamptz, '2025-06-21 15:09:00'::timestamptz, '2025-06-21 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 25.00, '2025-06-21 15:09:00'::timestamptz); END IF;

  -- CC2155
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2155', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 17:18:00'::timestamptz, '2025-06-21 15:57:00'::timestamptz, '2025-06-21 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-06-21 15:57:00'::timestamptz); END IF;

  -- CC2156
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2156', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 16:42:00'::timestamptz, '2025-06-21 16:41:00'::timestamptz, '2025-06-21 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-21 16:41:00'::timestamptz); END IF;

  -- CC2157
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2157', 'Gustavo Cumbrera', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 0.00, 0, 9, 'lavanderia', '2025-06-21 00:00:00'::timestamptz, '2025-06-21 17:18:00'::timestamptz, '2025-06-21 17:06:00'::timestamptz, '2025-06-21 17:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-06-21 17:06:00'::timestamptz); END IF;

  -- CC2158
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2158', 'Leonel Visueti', false, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, '', '2025-06-23 00:00:00'::timestamptz, '2025-06-23 08:58:00'::timestamptz, '2025-06-23 08:58:00'::timestamptz, '2025-06-23 08:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-06-23 08:58:00'::timestamptz); END IF;

  -- CC2159
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2159', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-23 00:00:00'::timestamptz, '2025-06-23 14:29:00'::timestamptz, '2025-06-23 09:24:00'::timestamptz, '2025-06-23 09:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-23 09:24:00'::timestamptz); END IF;

  -- CC2160
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2160', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-23 00:00:00'::timestamptz, '2025-06-23 14:29:00'::timestamptz, '2025-06-23 12:11:00'::timestamptz, '2025-06-23 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-06-23 12:11:00'::timestamptz); END IF;

  -- CC2161
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2161', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-23 00:00:00'::timestamptz, '2025-06-23 16:50:00'::timestamptz, '2025-06-23 15:30:00'::timestamptz, '2025-06-23 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-06-23 15:30:00'::timestamptz); END IF;

  -- CC2163
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2163', 'Cliente Lavandería', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, 'Lavandería', '2025-06-25 00:00:00'::timestamptz, '2025-06-24 10:44:00'::timestamptz, '2025-06-24 08:23:00'::timestamptz, '2025-06-24 08:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-06-24 08:23:00'::timestamptz); END IF;

  -- CC2164
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2164', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 10:44:00'::timestamptz, '2025-06-24 09:08:00'::timestamptz, '2025-06-24 09:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-06-24 09:08:00'::timestamptz); END IF;

  -- CC2165
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2165', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 11:32:00'::timestamptz, '2025-06-24 10:44:00'::timestamptz, '2025-06-24 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-06-24 10:44:00'::timestamptz); END IF;

  -- CC2166
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2166', 'Leonel Visueti', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 0.00, 0, 11, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 12:29:00'::timestamptz, '2025-06-24 12:28:00'::timestamptz, '2025-06-24 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.00, '2025-06-24 12:28:00'::timestamptz); END IF;

  -- CC2167
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2167', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 14:25:00'::timestamptz, '2025-06-24 13:54:00'::timestamptz, '2025-06-24 13:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-06-24 13:54:00'::timestamptz); END IF;

  -- CC2168
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2168', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, 'Lavandería', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 13:57:00'::timestamptz, '2025-06-24 13:56:00'::timestamptz, '2025-06-24 13:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-24 13:56:00'::timestamptz); END IF;

  -- CC2169
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2169', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 14:48:00'::timestamptz, '2025-06-24 14:24:00'::timestamptz, '2025-06-24 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-24 14:24:00'::timestamptz); END IF;

  -- CC2170
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2170', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 14:48:00'::timestamptz, '2025-06-24 14:27:00'::timestamptz, '2025-06-24 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-06-24 14:27:00'::timestamptz); END IF;

  -- CC2171
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2171', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-24 00:00:00'::timestamptz, '2025-06-24 16:32:00'::timestamptz, '2025-06-24 14:47:00'::timestamptz, '2025-06-24 14:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-24 14:47:00'::timestamptz); END IF;

  -- CC2172
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2172', 'Rafael Quintero', false, 'completed', false, 7.60, 0.00, 0, 0.53, 8.13, 3.25, 1, 1, '0', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 15:19:00'::timestamptz, '2025-06-25 09:24:00'::timestamptz, '2025-06-25 09:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.13, '2025-06-25 09:24:00'::timestamptz); END IF;

  -- CC2173
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 173;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2173', 'Migdalia Ramires', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'lavanderia', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 15:19:00'::timestamptz, '2025-06-25 10:25:00'::timestamptz, '2025-06-25 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-06-25 10:25:00'::timestamptz); END IF;

  -- CC2175
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2175', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 15:22:00'::timestamptz, '2025-06-25 15:19:00'::timestamptz, '2025-06-25 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-06-25 15:19:00'::timestamptz); END IF;

  -- CC2176
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2176', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 16:04:00'::timestamptz, '2025-06-25 15:22:00'::timestamptz, '2025-06-25 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-25 15:22:00'::timestamptz); END IF;

  -- CC2177
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2177', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 29.79, 0.00, 0, 2.09, 31.88, 12.75, 3, 1, 'Salón', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 16:17:00'::timestamptz, '2025-06-25 15:33:00'::timestamptz, '2025-06-25 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.88, '2025-06-25 15:33:00'::timestamptz); END IF;

  -- CC2178
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2178', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 15:54:00'::timestamptz, '2025-06-25 15:54:00'::timestamptz, '2025-06-25 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-25 15:54:00'::timestamptz); END IF;

  -- CC2179
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2179', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '', '2025-06-25 00:00:00'::timestamptz, '2025-06-25 00:00:00'::timestamptz, '2025-06-25 16:27:00'::timestamptz, '2025-06-25 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-06-25 16:27:00'::timestamptz); END IF;

  -- CC2180
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2180', 'German Alveo', false, 'completed', false, 52.93, 0.00, 0, 3.70, 56.63, 22.65, 7, 1, 'Lavandería', '2025-06-26 00:00:00'::timestamptz, '2025-06-26 16:36:00'::timestamptz, '2025-06-26 09:52:00'::timestamptz, '2025-06-26 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 56.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 56.63, '2025-06-26 09:52:00'::timestamptz); END IF;

  -- CC2181
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2181', 'German Alveo', false, 'completed', false, 7.60, 0.00, 0, 0.53, 8.13, 3.25, 1, 1, 'Lavandería', '2025-06-26 00:00:00'::timestamptz, '2025-06-26 16:36:00'::timestamptz, '2025-06-26 09:53:00'::timestamptz, '2025-06-26 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.13, '2025-06-26 09:53:00'::timestamptz); END IF;

  -- CC2182
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2182', 'Leonel Visueti', false, 'completed', false, 17.88, 0.00, 0, 1.25, 19.13, 7.65, 1, 1, '', '2025-06-27 00:00:00'::timestamptz, '2025-06-26 14:26:00'::timestamptz, '2025-06-26 14:23:00'::timestamptz, '2025-06-26 14:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.13, '2025-06-26 14:23:00'::timestamptz); END IF;

  -- CC2183
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2183', 'German Alveo', false, 'completed', false, 6.38, 0.00, 0, 0.45, 6.83, 3.90, 1, 1, 'Lavandería', '2025-06-26 00:00:00'::timestamptz, '2025-06-26 16:37:00'::timestamptz, '2025-06-26 15:16:00'::timestamptz, '2025-06-26 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.83 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.83, '2025-06-26 15:16:00'::timestamptz); END IF;

  -- CC2184
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2184', 'Lina Perez', false, 'completed', false, 18.05, 2.00, 0, 0.95, 19.00, 0.00, 0, 13, 'Lavandería', '2025-06-26 00:00:00'::timestamptz, '2025-06-26 16:33:00'::timestamptz, '2025-06-26 16:32:00'::timestamptz, '2025-06-26 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 19.00, '2025-06-26 16:32:00'::timestamptz); END IF;

  -- CC2185
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2185', 'Karla Garibaldi', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'Lavandería', '2025-06-26 00:00:00'::timestamptz, '2025-06-26 16:40:00'::timestamptz, '2025-06-26 16:39:00'::timestamptz, '2025-06-26 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-06-26 16:39:00'::timestamptz); END IF;

  -- CC2186
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2186', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 13:23:00'::timestamptz, '2025-06-27 09:46:00'::timestamptz, '2025-06-27 09:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-27 09:46:00'::timestamptz); END IF;

  -- CC2187
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2187', 'Lina Perez', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 10:57:00'::timestamptz, '2025-06-27 09:51:00'::timestamptz, '2025-06-27 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-27 09:51:00'::timestamptz); END IF;

  -- CC2188
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2188', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 12:31:00'::timestamptz, '2025-06-27 11:14:00'::timestamptz, '2025-06-27 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-27 11:14:00'::timestamptz); END IF;

  -- CC2189
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2189', 'Grethell Guevara', false, 'completed', false, 19.64, 0.00, 0, 1.24, 20.88, 7.55, 2, 3, 'Lavandería', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 15:32:00'::timestamptz, '2025-06-27 12:04:00'::timestamptz, '2025-06-27 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.88, '2025-06-27 12:04:00'::timestamptz); END IF;

  -- CC2190
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 174;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2190', 'Argelis Canate', false, 'completed', false, 10.60, 0.00, 0, 0.65, 11.25, 0.00, 0, 10, 'lavanderia', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 14:53:00'::timestamptz, '2025-06-27 12:29:00'::timestamptz, '2025-06-27 12:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.25, '2025-06-27 12:29:00'::timestamptz); END IF;

  -- CC2191
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2191', 'Karla Garibaldi', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, 'Lavandería', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 14:11:00'::timestamptz, '2025-06-27 12:37:00'::timestamptz, '2025-06-27 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-06-27 12:37:00'::timestamptz); END IF;

  -- CC2192
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2192', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 14:53:00'::timestamptz, '2025-06-27 14:07:00'::timestamptz, '2025-06-27 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-27 14:07:00'::timestamptz); END IF;

  -- CC2193
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2193', 'Leonel Visueti', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 8, '', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 15:32:00'::timestamptz, '2025-06-27 14:53:00'::timestamptz, '2025-06-27 14:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.00, '2025-06-27 14:53:00'::timestamptz); END IF;

  -- CC2194
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2194', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-06-27 00:00:00'::timestamptz, '2025-06-27 16:29:00'::timestamptz, '2025-06-27 16:09:00'::timestamptz, '2025-06-27 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-27 16:09:00'::timestamptz); END IF;

  -- CC2195
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2195', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 10:54:00'::timestamptz, '2025-06-28 09:43:00'::timestamptz, '2025-06-28 09:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-28 09:43:00'::timestamptz); END IF;

  -- CC2196
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2196', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 10:55:00'::timestamptz, '2025-06-28 10:06:00'::timestamptz, '2025-06-28 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-28 10:06:00'::timestamptz); END IF;

  -- CC2197
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2197', 'Leonel Willson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '0', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 11:25:00'::timestamptz, '2025-06-28 10:08:00'::timestamptz, '2025-06-28 10:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-28 10:08:00'::timestamptz); END IF;

  -- CC2198
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2198', 'Leonel Visueti', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 10:55:00'::timestamptz, '2025-06-28 10:12:00'::timestamptz, '2025-06-28 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.75, '2025-06-28 10:12:00'::timestamptz); END IF;

  -- CC2199
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2199', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 12:33:00'::timestamptz, '2025-06-28 10:56:00'::timestamptz, '2025-06-28 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-06-28 10:56:00'::timestamptz); END IF;

  -- CC2200
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2200', 'Marubenis Calderon', false, 'completed', false, 5.84, 0.00, 0, 0.41, 6.25, 0.00, 0, 5, 'm', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 13:06:00'::timestamptz, '2025-06-28 11:10:00'::timestamptz, '2025-06-28 11:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.25, '2025-06-28 11:10:00'::timestamptz); END IF;

  -- CC2201
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2201', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 13:06:00'::timestamptz, '2025-06-28 12:33:00'::timestamptz, '2025-06-28 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-06-28 12:33:00'::timestamptz); END IF;

  -- CC2202
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2202', 'Fany Luz Salon', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 13:08:00'::timestamptz, '2025-06-28 12:41:00'::timestamptz, '2025-06-28 12:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-28 12:41:00'::timestamptz); END IF;

  -- CC2203
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2203', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 4, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 14:33:00'::timestamptz, '2025-06-28 13:07:00'::timestamptz, '2025-06-28 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-28 13:07:00'::timestamptz); END IF;

  -- CC2204
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2204', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 14:33:00'::timestamptz, '2025-06-28 14:10:00'::timestamptz, '2025-06-28 14:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-06-28 14:10:00'::timestamptz); END IF;

  -- CC2205
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2205', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 14:50:00'::timestamptz, '2025-06-28 14:12:00'::timestamptz, '2025-06-28 14:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-28 14:12:00'::timestamptz); END IF;

  -- CC2206
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2206', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 14:50:00'::timestamptz, '2025-06-28 14:28:00'::timestamptz, '2025-06-28 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-06-28 14:28:00'::timestamptz); END IF;

  -- CC2207
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2207', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 15:26:00'::timestamptz, '2025-06-28 14:51:00'::timestamptz, '2025-06-28 14:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-06-28 14:51:00'::timestamptz); END IF;

  -- CC2208
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2208', 'Leonel Visueti', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 15:29:00'::timestamptz, '2025-06-28 15:26:00'::timestamptz, '2025-06-28 15:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.75, '2025-06-28 15:26:00'::timestamptz); END IF;

  -- CC2209
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2209', 'Virginia Gonzalez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 17:31:00'::timestamptz, '2025-06-28 16:13:00'::timestamptz, '2025-06-28 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-06-28 16:13:00'::timestamptz); END IF;

  -- CC2210
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2210', 'Leonel Visueti', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, '', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 17:31:00'::timestamptz, '2025-06-28 16:14:00'::timestamptz, '2025-06-28 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-06-28 16:14:00'::timestamptz); END IF;

  -- CC2211
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2211', 'Gustavo Cumbrera', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia', '2025-06-28 00:00:00'::timestamptz, '2025-06-28 17:47:00'::timestamptz, '2025-06-28 17:31:00'::timestamptz, '2025-06-28 17:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-06-28 17:31:00'::timestamptz); END IF;

  -- CC2212
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2212', 'Valery Rosas', false, 'completed', false, 13.35, 0.00, 0, 0.65, 14.00, 0.00, 0, 9, 'Lavanderia', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 10:16:00'::timestamptz, '2025-06-30 08:46:00'::timestamptz, '2025-06-30 08:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-06-30 08:46:00'::timestamptz); END IF;

  -- CC2213
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2213', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 08:59:00'::timestamptz, '2025-06-30 08:58:00'::timestamptz, '2025-06-30 08:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-30 08:58:00'::timestamptz); END IF;

  -- CC2214
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 170;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2214', 'Carlos Moreno', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 09:11:00'::timestamptz, '2025-06-30 09:10:00'::timestamptz, '2025-06-30 09:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-30 09:10:00'::timestamptz); END IF;

  -- CC2215
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2215', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 10:44:00'::timestamptz, '2025-06-30 10:16:00'::timestamptz, '2025-06-30 10:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-30 10:16:00'::timestamptz); END IF;

  -- CC2216
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2216', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-01 00:00:00'::timestamptz, '2025-06-30 14:01:00'::timestamptz, '2025-06-30 10:45:00'::timestamptz, '2025-06-30 10:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-06-30 10:45:00'::timestamptz); END IF;

  -- CC2217
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2217', 'Leonel Visueti', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, '', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 13:11:00'::timestamptz, '2025-06-30 10:46:00'::timestamptz, '2025-06-30 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-06-30 10:46:00'::timestamptz); END IF;

  -- CC2218
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2218', 'Cliente Lavandería', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 10:49:00'::timestamptz, '2025-06-30 10:49:00'::timestamptz, '2025-06-30 10:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-06-30 10:49:00'::timestamptz); END IF;

  -- CC2219
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2219', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 14:01:00'::timestamptz, '2025-06-30 13:12:00'::timestamptz, '2025-06-30 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-06-30 13:12:00'::timestamptz); END IF;

  -- CC2220
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2220', 'Leonel Visueti', false, 'completed', false, 2.12, 0.00, 0, 0.13, 2.25, 0.00, 0, 2, '', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 14:08:00'::timestamptz, '2025-06-30 13:14:00'::timestamptz, '2025-06-30 13:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.25, '2025-06-30 13:14:00'::timestamptz); END IF;

  -- CC2221
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 176;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2221', 'Nelly', false, 'completed', false, 6.20, 0.00, 0, 0.43, 6.63, 2.65, 1, 1, 'Lavanderia', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 14:50:00'::timestamptz, '2025-06-30 13:43:00'::timestamptz, '2025-06-30 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.63, '2025-06-30 13:43:00'::timestamptz); END IF;

  -- CC2222
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2222', 'Alvaro Martinez', false, 'completed', false, 26.29, 0.00, 0, 1.84, 28.13, 11.25, 2, 1, 'lavanderia', '2025-06-30 00:00:00'::timestamptz, '2025-07-05 15:22:00'::timestamptz, '2025-06-30 13:53:00'::timestamptz, '2025-06-30 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.13, '2025-06-30 13:53:00'::timestamptz); END IF;

  -- CC2223
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2223', 'Oscar Oropeza', false, 'completed', false, 26.17, 0.00, 0, 1.83, 28.00, 0.00, 0, 14, 'Lavandería', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 16:48:00'::timestamptz, '2025-06-30 16:38:00'::timestamptz, '2025-06-30 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.00, '2025-06-30 16:38:00'::timestamptz); END IF;

  -- CC2224
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2224', 'Carlos Arroyo', false, 'completed', false, 26.17, 0.00, 0, 1.83, 28.00, 0.00, 0, 14, 'lavanderia', '2025-06-30 00:00:00'::timestamptz, '2025-06-30 16:48:00'::timestamptz, '2025-06-30 16:42:00'::timestamptz, '2025-06-30 16:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.00, '2025-06-30 16:42:00'::timestamptz); END IF;

  -- CC2225
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 177;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2225', 'John Tukacan', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.95, 1, 1, 'Lavanderia', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 11:26:00'::timestamptz, '2025-07-01 11:25:00'::timestamptz, '2025-07-01 11:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-01 11:25:00'::timestamptz); END IF;

  -- CC2226
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2226', 'Leonel Visueti', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 2, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 11:27:00'::timestamptz, '2025-07-01 11:27:00'::timestamptz, '2025-07-01 11:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-01 11:27:00'::timestamptz); END IF;

  -- CC2227
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2227', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 00:00:00'::timestamptz, '2025-07-01 11:53:00'::timestamptz, '2025-07-01 11:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-01 11:53:00'::timestamptz); END IF;

  -- CC2228
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2228', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 13:28:00'::timestamptz, '2025-07-01 13:27:00'::timestamptz, '2025-07-01 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-07-01 13:27:00'::timestamptz); END IF;

  -- CC2229
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2229', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 13:29:00'::timestamptz, '2025-07-01 13:28:00'::timestamptz, '2025-07-01 13:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-01 13:28:00'::timestamptz); END IF;

  -- CC2230
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2230', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 16:58:00'::timestamptz, '2025-07-01 15:28:00'::timestamptz, '2025-07-01 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-07-01 15:28:00'::timestamptz); END IF;

  -- CC2231
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2231', 'Marubenis Calderon', false, 'completed', false, 4.67, 0.00, 0, 0.33, 5.00, 0.00, 0, 4, 'm', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 16:58:00'::timestamptz, '2025-07-01 15:29:00'::timestamptz, '2025-07-01 15:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-07-01 15:29:00'::timestamptz); END IF;

  -- CC2232
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2232', 'Leonel Visueti', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 1, '', '2025-07-01 00:00:00'::timestamptz, '2025-07-01 16:58:00'::timestamptz, '2025-07-01 16:54:00'::timestamptz, '2025-07-01 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-01 16:54:00'::timestamptz); END IF;

  -- CC2233
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2233', 'Leonel Visueti', false, 'completed', false, 4.67, 0.00, 0, 0.33, 5.00, 0.00, 0, 4, '', '2025-07-02 00:00:00'::timestamptz, '2025-07-02 11:46:00'::timestamptz, '2025-07-02 10:22:00'::timestamptz, '2025-07-02 10:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-02 10:22:00'::timestamptz); END IF;

  -- CC2235
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 178;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2235', 'Antoni Eneses', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 3, 'lavanderia', '2025-07-02 00:00:00'::timestamptz, '2025-07-02 17:43:00'::timestamptz, '2025-07-02 14:52:00'::timestamptz, '2025-07-02 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-02 14:52:00'::timestamptz); END IF;

  -- CC2236
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2236', 'Aaron Gutierrez', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-07-02 00:00:00'::timestamptz, '2025-07-02 17:43:00'::timestamptz, '2025-07-02 16:20:00'::timestamptz, '2025-07-02 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-07-02 16:20:00'::timestamptz); END IF;

  -- CC2237
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2237', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-03 00:00:00'::timestamptz, '2025-07-03 13:44:00'::timestamptz, '2025-07-03 11:04:00'::timestamptz, '2025-07-03 11:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-03 11:04:00'::timestamptz); END IF;

  -- CC2238
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2238', 'German Alveo', false, 'completed', false, 35.64, 0.00, 0, 2.49, 38.13, 15.25, 5, 1, 'Lavandería', '2025-07-03 00:00:00'::timestamptz, '2025-07-03 15:48:00'::timestamptz, '2025-07-03 13:45:00'::timestamptz, '2025-07-03 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 38.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 38.13, '2025-07-03 13:45:00'::timestamptz); END IF;

  -- CC2239
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2239', 'German Alveo', false, 'completed', false, 14.34, 0.00, 0, 1.00, 15.34, 6.60, 3, 2, 'Lavandería', '2025-07-03 00:00:00'::timestamptz, '2025-07-03 15:48:00'::timestamptz, '2025-07-03 14:14:00'::timestamptz, '2025-07-03 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.34, '2025-07-03 14:14:00'::timestamptz); END IF;

  -- CC2240
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2240', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 30.14, 0.00, 0, 2.11, 32.25, 12.90, 3, 1, 'Salón', '2025-07-03 00:00:00'::timestamptz, '2025-07-03 15:59:00'::timestamptz, '2025-07-03 15:49:00'::timestamptz, '2025-07-03 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 32.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 32.25, '2025-07-03 15:49:00'::timestamptz); END IF;

  -- CC2241
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2241', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-07-03 00:00:00'::timestamptz, '2025-07-03 16:03:00'::timestamptz, '2025-07-03 16:02:00'::timestamptz, '2025-07-03 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-03 16:02:00'::timestamptz); END IF;

  -- CC2242
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 179;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2242', 'Alba Munoz', false, 'completed', false, 20.19, 0.00, 0, 1.31, 21.50, 0.00, 0, 15, 'lavanderia', '2025-07-04 00:00:00'::timestamptz, '2025-07-04 12:22:00'::timestamptz, '2025-07-04 10:51:00'::timestamptz, '2025-07-04 10:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 21.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 21.50, '2025-07-04 10:51:00'::timestamptz); END IF;

  -- CC2243
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2243', 'Yariela Phillips', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia', '2025-07-04 00:00:00'::timestamptz, '2025-07-04 14:33:00'::timestamptz, '2025-07-04 12:25:00'::timestamptz, '2025-07-04 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-07-04 12:25:00'::timestamptz); END IF;

  -- CC2244
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2244', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2025-07-04 00:00:00'::timestamptz, '2025-07-04 16:08:00'::timestamptz, '2025-07-04 15:39:00'::timestamptz, '2025-07-04 15:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-07-04 15:39:00'::timestamptz); END IF;

  -- CC2245
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2245', 'Leonel Willson', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 5, '0', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 11:39:00'::timestamptz, '2025-07-05 10:19:00'::timestamptz, '2025-07-05 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-07-05 10:19:00'::timestamptz); END IF;

  -- CC2246
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2246', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 13:50:00'::timestamptz, '2025-07-05 10:37:00'::timestamptz, '2025-07-05 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-05 10:37:00'::timestamptz); END IF;

  -- CC2247
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2247', 'Alvaro Martinez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 4, 'lavanderia', '2025-07-06 00:00:00'::timestamptz, '2025-07-05 13:50:00'::timestamptz, '2025-07-05 12:34:00'::timestamptz, '2025-07-05 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-05 12:34:00'::timestamptz); END IF;

  -- CC2248
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2248', 'Leonel Visueti', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, '', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 13:50:00'::timestamptz, '2025-07-05 13:08:00'::timestamptz, '2025-07-05 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.75, '2025-07-05 13:08:00'::timestamptz); END IF;

  -- CC2249
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 182;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2249', 'Angie Prescott', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 10, 'lavanderia', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 13:51:00'::timestamptz, '2025-07-05 13:11:00'::timestamptz, '2025-07-05 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-07-05 13:11:00'::timestamptz); END IF;

  -- CC2250
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2250', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 13:52:00'::timestamptz, '2025-07-05 13:51:00'::timestamptz, '2025-07-05 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-05 13:51:00'::timestamptz); END IF;

  -- CC2251
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2251', 'Evelyn', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Salón', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 14:41:00'::timestamptz, '2025-07-05 13:52:00'::timestamptz, '2025-07-05 13:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-07-05 13:52:00'::timestamptz); END IF;

  -- CC2252
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2252', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 15:13:00'::timestamptz, '2025-07-05 15:12:00'::timestamptz, '2025-07-05 15:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-05 15:12:00'::timestamptz); END IF;

  -- CC2253
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2253', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 15:23:00'::timestamptz, '2025-07-05 15:22:00'::timestamptz, '2025-07-05 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-05 15:22:00'::timestamptz); END IF;

  -- CC2254
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2254', 'Fernando Ortega', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 16:01:00'::timestamptz, '2025-07-05 15:55:00'::timestamptz, '2025-07-05 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-07-05 15:55:00'::timestamptz); END IF;

  -- CC2255
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2255', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 16:22:00'::timestamptz, '2025-07-05 16:22:00'::timestamptz, '2025-07-05 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-05 16:22:00'::timestamptz); END IF;

  -- CC2256
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2256', 'Virginia Gonzalez', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'Lavandería', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 17:21:00'::timestamptz, '2025-07-05 16:29:00'::timestamptz, '2025-07-05 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-07-05 16:29:00'::timestamptz); END IF;

  -- CC2257
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2257', 'Oscar Oropeza', false, 'completed', false, 13.08, 2.00, 0, 0.92, 14.00, 0.00, 0, 8, 'Lavandería', '2025-07-06 00:00:00'::timestamptz, '2025-07-05 16:59:00'::timestamptz, '2025-07-05 16:58:00'::timestamptz, '2025-07-05 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-07-05 16:58:00'::timestamptz); END IF;

  -- CC2258
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2258', 'Gustavo Cumbrera', false, 'completed', false, 16.82, 2.00, 0, 1.18, 18.00, 0.00, 0, 10, 'lavanderia', '2025-07-05 00:00:00'::timestamptz, '2025-07-05 18:00:00'::timestamptz, '2025-07-05 17:47:00'::timestamptz, '2025-07-05 17:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-07-05 17:47:00'::timestamptz); END IF;

  -- CC2259
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2259', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-07-07 00:00:00'::timestamptz, '2025-07-07 10:15:00'::timestamptz, '2025-07-07 09:40:00'::timestamptz, '2025-07-07 09:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-07-07 09:40:00'::timestamptz); END IF;

  -- CC2260
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2260', 'Cliente Lavandería', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, 'Lavandería', '2025-07-07 00:00:00'::timestamptz, '2025-07-07 10:15:00'::timestamptz, '2025-07-07 09:42:00'::timestamptz, '2025-07-07 09:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-07-07 09:42:00'::timestamptz); END IF;

  -- CC2261
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2261', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-07-07 00:00:00'::timestamptz, '2025-07-07 11:40:00'::timestamptz, '2025-07-07 10:16:00'::timestamptz, '2025-07-07 10:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-07 10:16:00'::timestamptz); END IF;

  -- CC2262
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2262', 'Leonel Visueti', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 5, '', '2025-07-07 00:00:00'::timestamptz, '2025-07-07 13:08:00'::timestamptz, '2025-07-07 13:07:00'::timestamptz, '2025-07-07 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-07-07 13:07:00'::timestamptz); END IF;

  -- CC2263
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2263', 'Fany Luz Salon', false, 'completed', false, 6.24, 0.00, 0, 0.26, 6.50, 0.00, 0, 6, '0', '2025-07-07 00:00:00'::timestamptz, '2025-07-07 16:34:00'::timestamptz, '2025-07-07 16:21:00'::timestamptz, '2025-07-07 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2025-07-07 16:21:00'::timestamptz); END IF;

  -- CC2264
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2264', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-08 00:00:00'::timestamptz, '2025-07-08 13:42:00'::timestamptz, '2025-07-08 12:28:00'::timestamptz, '2025-07-08 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-08 12:28:00'::timestamptz); END IF;

  -- CC2265
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2265', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-08 00:00:00'::timestamptz, '2025-07-08 15:16:00'::timestamptz, '2025-07-08 13:42:00'::timestamptz, '2025-07-08 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-08 13:42:00'::timestamptz); END IF;

  -- CC2266
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2266', 'Marubenis Calderon', false, 'completed', false, 5.84, 0.00, 0, 0.41, 6.25, 0.00, 0, 5, 'm', '2025-07-08 00:00:00'::timestamptz, '2025-07-08 16:46:00'::timestamptz, '2025-07-08 15:15:00'::timestamptz, '2025-07-08 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.25, '2025-07-08 15:15:00'::timestamptz); END IF;

  -- CC2267
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2267', 'Alberto Campell', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, 'lavanderia', '2025-07-08 00:00:00'::timestamptz, '2025-07-08 00:00:00'::timestamptz, '2025-07-08 16:23:00'::timestamptz, '2025-07-08 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-08 16:23:00'::timestamptz); END IF;

  -- CC2268
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2268', 'Valery Rosas', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Lavanderia', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 11:01:00'::timestamptz, '2025-07-09 09:36:00'::timestamptz, '2025-07-09 09:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-07-09 09:36:00'::timestamptz); END IF;

  -- CC2269
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2269', 'Valery Rosas', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, 'Lavanderia', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 00:00:00'::timestamptz, '2025-07-09 09:49:00'::timestamptz, '2025-07-09 09:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-07-09 09:49:00'::timestamptz); END IF;

  -- CC2270
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2270', 'Valery Rosas', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavanderia', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 11:36:00'::timestamptz, '2025-07-09 11:36:00'::timestamptz, '2025-07-09 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-07-09 11:36:00'::timestamptz); END IF;

  -- CC2271
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2271', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 14:09:00'::timestamptz, '2025-07-09 14:08:00'::timestamptz, '2025-07-09 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-09 14:08:00'::timestamptz); END IF;

  -- CC2272
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2272', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 15:26:00'::timestamptz, '2025-07-09 14:27:00'::timestamptz, '2025-07-09 14:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-09 14:27:00'::timestamptz); END IF;

  -- CC2273
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2273', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 22.66, 0.00, 0, 1.59, 24.25, 9.70, 2, 1, 'Salón', '2025-07-09 00:00:00'::timestamptz, '2025-07-09 16:50:00'::timestamptz, '2025-07-09 16:04:00'::timestamptz, '2025-07-09 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.25, '2025-07-09 16:04:00'::timestamptz); END IF;

  -- CC2274
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2274', 'Leonel Visueti', false, 'completed', false, 10.10, 0.00, 0, 0.65, 10.75, 0.00, 0, 8, '', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 12:23:00'::timestamptz, '2025-07-10 12:22:00'::timestamptz, '2025-07-10 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.75, '2025-07-10 12:22:00'::timestamptz); END IF;

  -- CC2275
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2275', 'German Alveo', false, 'completed', false, 26.17, 0.00, 0, 1.83, 28.00, 11.20, 5, 1, 'Lavandería', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 16:35:00'::timestamptz, '2025-07-10 13:17:00'::timestamptz, '2025-07-10 13:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.00, '2025-07-10 13:17:00'::timestamptz); END IF;

  -- CC2276
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2276', 'German Alveo', false, 'completed', false, 19.28, 0.00, 0, 1.35, 20.63, 8.25, 2, 1, 'Lavandería', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 16:35:00'::timestamptz, '2025-07-10 13:28:00'::timestamptz, '2025-07-10 13:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.63, '2025-07-10 13:28:00'::timestamptz); END IF;

  -- CC2277
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 183;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2277', 'Juan Berrio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'lavanderia', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 14:16:00'::timestamptz, '2025-07-10 14:15:00'::timestamptz, '2025-07-10 14:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-10 14:15:00'::timestamptz); END IF;

  -- CC2278
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2278', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 4, '', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 16:53:00'::timestamptz, '2025-07-10 16:52:00'::timestamptz, '2025-07-10 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-10 16:52:00'::timestamptz); END IF;

  -- CC2279
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2279', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-10 00:00:00'::timestamptz, '2025-07-10 17:07:00'::timestamptz, '2025-07-10 17:06:00'::timestamptz, '2025-07-10 17:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-10 17:06:00'::timestamptz); END IF;

  -- CC2280
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2280', 'Alvaro Martinez', false, 'completed', false, 22.08, 0.00, 0, 1.55, 23.63, 9.45, 3, 1, 'lavanderia', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 13:39:00'::timestamptz, '2025-07-11 08:22:00'::timestamptz, '2025-07-11 08:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 23.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 23.63, '2025-07-11 08:22:00'::timestamptz); END IF;

  -- CC2281
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2281', 'German Alveo', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'Lavandería', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 10:35:00'::timestamptz, '2025-07-11 08:33:00'::timestamptz, '2025-07-11 08:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-07-11 08:33:00'::timestamptz); END IF;

  -- CC2282
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 184;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2282', 'La Barberia', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.10, 1, 1, 'lavanderia ', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 12:19:00'::timestamptz, '2025-07-11 09:34:00'::timestamptz, '2025-07-11 09:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-11 09:34:00'::timestamptz); END IF;

  -- CC2283
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2283', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 11:22:00'::timestamptz, '2025-07-11 11:21:00'::timestamptz, '2025-07-11 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-11 11:21:00'::timestamptz); END IF;

  -- CC2284
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2284', 'Leonel Visueti', false, 'completed', false, 2.12, 0.00, 0, 0.13, 2.25, 0.00, 0, 2, '', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 11:55:00'::timestamptz, '2025-07-11 11:23:00'::timestamptz, '2025-07-11 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.25, '2025-07-11 11:23:00'::timestamptz); END IF;

  -- CC2285
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2285', 'Julissa Rivera', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 3, 'lavanderia', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 17:01:00'::timestamptz, '2025-07-11 11:46:00'::timestamptz, '2025-07-11 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-07-11 11:46:00'::timestamptz); END IF;

  -- CC2286
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2286', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 12:51:00'::timestamptz, '2025-07-11 11:55:00'::timestamptz, '2025-07-11 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-11 11:55:00'::timestamptz); END IF;

  -- CC2287
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2287', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 12:51:00'::timestamptz, '2025-07-11 11:57:00'::timestamptz, '2025-07-11 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-11 11:57:00'::timestamptz); END IF;

  -- CC2288
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 186;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2288', 'Jose Alvarado', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 12:54:00'::timestamptz, '2025-07-11 12:54:00'::timestamptz, '2025-07-11 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-11 12:54:00'::timestamptz); END IF;

  -- CC2289
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2289', 'Leonel Visueti', false, 'completed', false, 4.91, 0.00, 0, 0.34, 5.25, 0.00, 0, 3, '', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 13:39:00'::timestamptz, '2025-07-11 13:38:00'::timestamptz, '2025-07-11 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.25, '2025-07-11 13:38:00'::timestamptz); END IF;

  -- CC2290
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2290', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, '', '2025-07-12 00:00:00'::timestamptz, '2025-07-11 13:47:00'::timestamptz, '2025-07-11 13:46:00'::timestamptz, '2025-07-11 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-07-11 13:46:00'::timestamptz); END IF;

  -- CC2291
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2291', 'Karla Garibaldi', false, 'completed', false, 3.37, 0.00, 0, 0.13, 3.50, 0.00, 0, 4, 'Lavandería', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 14:30:00'::timestamptz, '2025-07-11 14:29:00'::timestamptz, '2025-07-11 14:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.50, '2025-07-11 14:29:00'::timestamptz); END IF;

  -- CC2292
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 156;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2292', 'Carlos Arroyo', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-07-11 00:00:00'::timestamptz, '2025-07-11 17:02:00'::timestamptz, '2025-07-11 16:56:00'::timestamptz, '2025-07-11 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-07-11 16:56:00'::timestamptz); END IF;

  -- CC2293
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2293', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 09:03:00'::timestamptz, '2025-07-12 08:20:00'::timestamptz, '2025-07-12 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-12 08:20:00'::timestamptz); END IF;

  -- CC2294
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2294', 'Yariela Phillips', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 10:47:00'::timestamptz, '2025-07-12 09:16:00'::timestamptz, '2025-07-12 09:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-07-12 09:16:00'::timestamptz); END IF;

  -- CC2295
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2295', 'Rafael Quintero', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '0', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 10:47:00'::timestamptz, '2025-07-12 09:19:00'::timestamptz, '2025-07-12 09:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-12 09:19:00'::timestamptz); END IF;

  -- CC2296
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2296', 'Ileana', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 10:47:00'::timestamptz, '2025-07-12 10:13:00'::timestamptz, '2025-07-12 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-12 10:13:00'::timestamptz); END IF;

  -- CC2297
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 159;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2297', 'Brenda Paredes', false, 'completed', false, 56.07, 0.00, 0, 3.93, 60.00, 0.00, 0, 8, '0', '2025-07-12 00:00:00'::timestamptz, '2025-07-14 17:01:00'::timestamptz, '2025-07-12 10:40:00'::timestamptz, '2025-07-12 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 60.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 60.00, '2025-07-12 10:40:00'::timestamptz); END IF;

  -- CC2298
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2298', 'Rafael Quintero', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '0', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 00:00:00'::timestamptz, '2025-07-12 10:46:00'::timestamptz, '2025-07-12 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-07-12 10:46:00'::timestamptz); END IF;

  -- CC2299
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 187;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2299', 'Salon Hanny Stily', false, 'completed', false, 7.24, 0.00, 0, 0.51, 7.75, 3.10, 1, 1, 'lavanderia', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 11:34:00'::timestamptz, '2025-07-12 11:11:00'::timestamptz, '2025-07-12 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.75, '2025-07-12 11:11:00'::timestamptz); END IF;

  -- CC2300
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2300', 'Gustavo Cumbrera', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 12:38:00'::timestamptz, '2025-07-12 12:37:00'::timestamptz, '2025-07-12 12:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2025-07-12 12:37:00'::timestamptz); END IF;

  -- CC2301
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2301', 'Leonel Visueti', false, 'completed', false, 15.45, 0.00, 0, 1.05, 16.50, 0.00, 0, 9, '', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 13:13:00'::timestamptz, '2025-07-12 13:12:00'::timestamptz, '2025-07-12 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.50, '2025-07-12 13:12:00'::timestamptz); END IF;

  -- CC2302
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 174;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2302', 'Argelis Canate', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, 'lavanderia', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 15:01:00'::timestamptz, '2025-07-12 15:00:00'::timestamptz, '2025-07-12 15:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.75, '2025-07-12 15:00:00'::timestamptz); END IF;

  -- CC2303
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2303', 'Virginia Gonzalez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 17:18:00'::timestamptz, '2025-07-12 16:25:00'::timestamptz, '2025-07-12 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-12 16:25:00'::timestamptz); END IF;

  -- CC2304
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2304', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-12 00:00:00'::timestamptz, '2025-07-12 17:18:00'::timestamptz, '2025-07-12 16:39:00'::timestamptz, '2025-07-12 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-12 16:39:00'::timestamptz); END IF;

  -- CC2305
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2305', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 14.25, 0.00, 0, 1.00, 15.25, 6.10, 2, 1, 'Salón', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 14:03:00'::timestamptz, '2025-07-14 13:18:00'::timestamptz, '2025-07-14 13:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.25, '2025-07-14 13:18:00'::timestamptz); END IF;

  -- CC2306
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2306', 'Evelyn', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, 'Salón', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 17:01:00'::timestamptz, '2025-07-14 14:02:00'::timestamptz, '2025-07-14 14:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-14 14:02:00'::timestamptz); END IF;

  -- CC2307
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2307', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 17:01:00'::timestamptz, '2025-07-14 14:07:00'::timestamptz, '2025-07-14 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-07-14 14:07:00'::timestamptz); END IF;

  -- CC2308
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2308', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 17:01:00'::timestamptz, '2025-07-14 14:08:00'::timestamptz, '2025-07-14 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-14 14:08:00'::timestamptz); END IF;

  -- CC2309
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2309', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 00:00:00'::timestamptz, '2025-07-14 17:16:00'::timestamptz, '2025-07-14 17:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-14 17:16:00'::timestamptz); END IF;

  -- CC2310
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2310', 'Oscar Oropeza', false, 'completed', false, 13.08, 2.00, 0, 0.92, 14.00, 0.00, 0, 8, 'Lavandería', '2025-07-14 00:00:00'::timestamptz, '2025-07-14 17:37:00'::timestamptz, '2025-07-14 17:31:00'::timestamptz, '2025-07-14 17:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-07-14 17:31:00'::timestamptz); END IF;

  -- CC2311
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2311', 'Relax Cala,S.A', false, 'completed', false, 120.61, 0.00, 0, 8.44, 129.05, 58.40, 9, 2, 'Lavandería', '2025-07-15 00:00:00'::timestamptz, '2025-07-15 16:15:00'::timestamptz, '2025-07-15 15:53:00'::timestamptz, '2025-07-15 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 129.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 129.05, '2025-07-15 15:53:00'::timestamptz); END IF;

  -- CC2312
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2312', 'Justo Arosemena', false, 'completed', false, 4.99, 0.00, 0, 0.26, 5.25, 0.00, 0, 4, 'lavanderia', '2025-07-15 00:00:00'::timestamptz, '2025-07-15 16:10:00'::timestamptz, '2025-07-15 16:07:00'::timestamptz, '2025-07-15 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2025-07-15 16:07:00'::timestamptz); END IF;

  -- CC2313
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2313', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-15 00:00:00'::timestamptz, '2025-07-15 16:09:00'::timestamptz, '2025-07-15 16:08:00'::timestamptz, '2025-07-15 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-15 16:08:00'::timestamptz); END IF;

  -- CC2314
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2314', 'Valery Rosas', false, 'completed', false, 9.98, 0.00, 0, 0.52, 10.50, 0.00, 0, 7, 'Lavanderia', '2025-07-16 00:00:00'::timestamptz, '2025-07-16 13:07:00'::timestamptz, '2025-07-16 09:28:00'::timestamptz, '2025-07-16 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-07-16 09:28:00'::timestamptz); END IF;

  -- CC2315
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2315', 'Yara Rangel', false, 'completed', false, 8.61, 0.00, 0, 0.39, 9.00, 0.00, 0, 6, '0', '2025-07-16 00:00:00'::timestamptz, '2025-07-16 13:07:00'::timestamptz, '2025-07-16 11:05:00'::timestamptz, '2025-07-16 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.00, '2025-07-16 11:05:00'::timestamptz); END IF;

  -- CC2316
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2316', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '0', '2025-07-16 00:00:00'::timestamptz, '2025-07-16 16:22:00'::timestamptz, '2025-07-16 13:05:00'::timestamptz, '2025-07-16 13:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-07-16 13:05:00'::timestamptz); END IF;

  -- CC2317
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2317', 'German Alveo', false, 'completed', false, 35.03, 0.00, 0, 2.45, 37.48, 14.99, 6, 1, 'Lavandería', '2025-07-17 00:00:00'::timestamptz, '2025-07-17 13:32:00'::timestamptz, '2025-07-17 11:40:00'::timestamptz, '2025-07-17 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 37.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 37.48, '2025-07-17 11:40:00'::timestamptz); END IF;

  -- CC2318
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2318', 'German Alveo', false, 'completed', false, 6.71, 0.00, 0, 0.47, 7.18, 2.87, 1, 1, 'Lavandería', '2025-07-17 00:00:00'::timestamptz, '2025-07-17 13:32:00'::timestamptz, '2025-07-17 11:41:00'::timestamptz, '2025-07-17 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.18, '2025-07-17 11:41:00'::timestamptz); END IF;

  -- CC2319
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 188;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2319', 'Librada Mendoza', false, 'completed', false, 35.17, 0.00, 0, 1.83, 37.00, 0.00, 0, 23, 'lavandria', '2025-07-17 00:00:00'::timestamptz, '2025-07-17 13:32:00'::timestamptz, '2025-07-17 13:29:00'::timestamptz, '2025-07-17 13:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 37.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 37.00, '2025-07-17 13:29:00'::timestamptz); END IF;

  -- CC2320
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2320', 'Ileana', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, 'lavanderia', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 09:55:00'::timestamptz, '2025-07-18 08:36:00'::timestamptz, '2025-07-18 08:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-18 08:36:00'::timestamptz); END IF;

  -- CC2321
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 189;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2321', 'Liz Martinez', false, 'completed', false, 14.35, 0.00, 0, 0.65, 15.00, 0.00, 0, 13, 'lavanderia', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 11:16:00'::timestamptz, '2025-07-18 10:46:00'::timestamptz, '2025-07-18 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-07-18 10:46:00'::timestamptz); END IF;

  -- CC2322
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 190;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2322', 'Laura Aguilar', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 14:00:00'::timestamptz, '2025-07-18 10:58:00'::timestamptz, '2025-07-18 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-07-18 10:58:00'::timestamptz); END IF;

  -- CC2323
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2323', 'Aaron Gutierrez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavandería', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 11:37:00'::timestamptz, '2025-07-18 11:00:00'::timestamptz, '2025-07-18 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-18 11:00:00'::timestamptz); END IF;

  -- CC2324
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 191;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2324', 'Angely Sicolona', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 7.20, 2, 1, 'lavanderia', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 16:24:00'::timestamptz, '2025-07-18 14:37:00'::timestamptz, '2025-07-18 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-07-18 14:37:00'::timestamptz); END IF;

  -- CC2325
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2325', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 17:01:00'::timestamptz, '2025-07-18 14:40:00'::timestamptz, '2025-07-18 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-18 14:40:00'::timestamptz); END IF;

  -- CC2326
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2326', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 16:24:00'::timestamptz, '2025-07-18 14:41:00'::timestamptz, '2025-07-18 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-07-18 14:41:00'::timestamptz); END IF;

  -- CC2327
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2327', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-07-18 00:00:00'::timestamptz, '2025-07-18 17:01:00'::timestamptz, '2025-07-18 16:25:00'::timestamptz, '2025-07-18 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-18 16:25:00'::timestamptz); END IF;

  -- CC2328
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 192;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2328', 'Coromoto Roverse', false, 'completed', false, 22.73, 0.00, 0, 1.52, 24.25, 8.50, 2, 6, 'lavanderia', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 12:24:00'::timestamptz, '2025-07-19 09:00:00'::timestamptz, '2025-07-19 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.25, '2025-07-19 09:00:00'::timestamptz); END IF;

  -- CC2329
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2329', 'Alvaro Martinez', false, 'completed', false, 24.65, 0.00, 0, 1.73, 26.38, 10.55, 3, 1, 'lavanderia', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 15:30:00'::timestamptz, '2025-07-19 09:49:00'::timestamptz, '2025-07-19 09:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.38, '2025-07-19 09:49:00'::timestamptz); END IF;

  -- CC2330
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2330', 'Leonel Visueti', false, 'completed', false, 4.37, 0.00, 0, 0.13, 4.50, 0.00, 0, 5, '', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 11:44:00'::timestamptz, '2025-07-19 10:17:00'::timestamptz, '2025-07-19 10:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-07-19 10:17:00'::timestamptz); END IF;

  -- CC2331
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2331', 'Leonel Willson', false, 'completed', false, 10.35, 0.00, 0, 0.65, 11.00, 0.00, 0, 6, '0', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 12:24:00'::timestamptz, '2025-07-19 11:42:00'::timestamptz, '2025-07-19 11:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.00, '2025-07-19 11:42:00'::timestamptz); END IF;

  -- CC2332
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2332', 'German Alveo', false, 'completed', false, 20.79, 0.00, 0, 1.46, 22.25, 4.90, 2, 2, 'Lavandería', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 14:36:00'::timestamptz, '2025-07-19 13:10:00'::timestamptz, '2025-07-19 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.25, '2025-07-19 13:10:00'::timestamptz); END IF;

  -- CC2333
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2333', 'Cesar Malave', false, 'completed', false, 11.85, 0.00, 0, 0.65, 12.50, 0.00, 0, 8, 'lavanderia', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 13:18:00'::timestamptz, '2025-07-19 13:15:00'::timestamptz, '2025-07-19 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.50, '2025-07-19 13:15:00'::timestamptz); END IF;

  -- CC2334
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2334', 'Gustavo Cumbrera', false, 'completed', false, 14.08, 2.00, 0, 0.92, 15.00, 0.00, 0, 9, 'lavanderia', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 13:35:00'::timestamptz, '2025-07-19 13:34:00'::timestamptz, '2025-07-19 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-07-19 13:34:00'::timestamptz); END IF;

  -- CC2335
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 187;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2335', 'Salon Hanny Stily', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'lavanderia', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 14:36:00'::timestamptz, '2025-07-19 13:35:00'::timestamptz, '2025-07-19 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-19 13:35:00'::timestamptz); END IF;

  -- CC2336
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2336', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 14:37:00'::timestamptz, '2025-07-19 14:33:00'::timestamptz, '2025-07-19 14:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-19 14:33:00'::timestamptz); END IF;

  -- CC2337
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2337', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-07-20 00:00:00'::timestamptz, '2025-07-19 15:01:00'::timestamptz, '2025-07-19 14:59:00'::timestamptz, '2025-07-19 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-19 14:59:00'::timestamptz); END IF;

  -- CC2338
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2338', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-07-19 00:00:00'::timestamptz, '2025-07-19 00:00:00'::timestamptz, '2025-07-19 14:59:00'::timestamptz, '2025-07-19 14:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-19 14:59:00'::timestamptz); END IF;

  -- CC2339
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2339', 'Byron Moreno', false, 'completed', false, 29.14, 0.00, 0, 2.04, 31.18, 10.07, 2, 2, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-22 15:48:00'::timestamptz, '2025-07-21 08:54:00'::timestamptz, '2025-07-21 08:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 31.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 31.18, '2025-07-21 08:54:00'::timestamptz); END IF;

  -- CC2340
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2340', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 11:19:00'::timestamptz, '2025-07-21 10:04:00'::timestamptz, '2025-07-21 10:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-07-21 10:04:00'::timestamptz); END IF;

  -- CC2341
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 173;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2341', 'Migdalia Ramires', false, 'completed', false, 10.35, 0.00, 0, 0.65, 11.00, 0.00, 0, 6, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 11:19:00'::timestamptz, '2025-07-21 10:34:00'::timestamptz, '2025-07-21 10:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-07-21 10:34:00'::timestamptz); END IF;

  -- CC2342
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 173;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2342', 'Migdalia Ramires', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 11:19:00'::timestamptz, '2025-07-21 10:38:00'::timestamptz, '2025-07-21 10:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-07-21 10:38:00'::timestamptz); END IF;

  -- CC2343
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2343', 'Grethell Guevara', false, 'completed', false, 102.42, 0.00, 0, 6.33, 108.75, 38.70, 10, 13, 'Lavandería', '2025-07-21 00:00:00'::timestamptz, '2025-07-22 09:48:00'::timestamptz, '2025-07-21 15:48:00'::timestamptz, '2025-07-21 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 108.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 108.75, '2025-07-21 15:48:00'::timestamptz); END IF;

  -- CC2344
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 196;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2344', 'Zureima Vergara', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 16:00:00'::timestamptz, '2025-07-21 15:59:00'::timestamptz, '2025-07-21 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-07-21 15:59:00'::timestamptz); END IF;

  -- CC2345
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2345', 'Josue Rosales', false, 'completed', false, 6.54, 0.00, 0, 0.46, 7.00, 1.90, 1, 3, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 16:05:00'::timestamptz, '2025-07-21 16:03:00'::timestamptz, '2025-07-21 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-07-21 16:03:00'::timestamptz); END IF;

  -- CC2346
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2346', 'Evelyn', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Salón', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 16:05:00'::timestamptz, '2025-07-21 16:04:00'::timestamptz, '2025-07-21 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-07-21 16:04:00'::timestamptz); END IF;

  -- CC2347
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2347', 'Evelyn', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Salón', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 16:06:00'::timestamptz, '2025-07-21 16:06:00'::timestamptz, '2025-07-21 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-21 16:06:00'::timestamptz); END IF;

  -- CC2348
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2348', 'Leonel Visueti', false, 'completed', false, 7.98, 0.00, 0, 0.52, 8.50, 0.00, 0, 6, '', '2025-07-21 00:00:00'::timestamptz, '2025-07-21 16:07:00'::timestamptz, '2025-07-21 16:07:00'::timestamptz, '2025-07-21 16:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.50, '2025-07-21 16:07:00'::timestamptz); END IF;

  -- CC2349
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 198;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2349', 'Jorge Achito', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-07-21 00:00:00'::timestamptz, '2025-07-22 14:49:00'::timestamptz, '2025-07-21 17:31:00'::timestamptz, '2025-07-21 17:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-07-21 17:31:00'::timestamptz); END IF;

  -- CC2350
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 199;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2350', 'Yeimi', false, 'completed', false, 12.15, 0.00, 0, 0.85, 13.00, 2.40, 1, 6, '', '2025-07-22 00:00:00'::timestamptz, '2025-07-22 13:26:00'::timestamptz, '2025-07-22 13:26:00'::timestamptz, '2025-07-22 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-07-22 13:26:00'::timestamptz); END IF;

  -- CC2351
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2351', 'Cliente Lavandería', false, 'completed', false, 12.71, 0.00, 0, 0.79, 13.50, 0.00, 0, 8, 'Lavandería', '2025-07-22 00:00:00'::timestamptz, '2025-07-22 14:07:00'::timestamptz, '2025-07-22 14:07:00'::timestamptz, '2025-07-22 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.50, '2025-07-22 14:07:00'::timestamptz); END IF;

  -- CC2352
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2352', 'Cliente Lavandería', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, 'Lavandería', '2025-07-22 00:00:00'::timestamptz, '2025-07-22 00:00:00'::timestamptz, '2025-07-22 16:38:00'::timestamptz, '2025-07-22 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-07-22 16:38:00'::timestamptz); END IF;

  -- CC2353
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2353', 'Fany Luz Salon', false, 'completed', false, 6.24, 0.00, 0, 0.26, 6.50, 0.00, 0, 6, '0', '2025-07-23 00:00:00'::timestamptz, '2025-07-23 16:24:00'::timestamptz, '2025-07-23 14:13:00'::timestamptz, '2025-07-23 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.50, '2025-07-23 14:13:00'::timestamptz); END IF;

  -- CC2354
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2354', 'Yariela Phillips', false, 'completed', false, 11.96, 0.00, 0, 0.79, 12.75, 0.00, 0, 9, 'lavanderia', '2025-07-23 00:00:00'::timestamptz, '2025-07-23 16:53:00'::timestamptz, '2025-07-23 14:38:00'::timestamptz, '2025-07-23 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.75, '2025-07-23 14:38:00'::timestamptz); END IF;

  -- CC2355
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2355', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-07-23 00:00:00'::timestamptz, '2025-07-23 00:00:00'::timestamptz, '2025-07-23 15:53:00'::timestamptz, '2025-07-23 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-23 15:53:00'::timestamptz); END IF;

  -- CC2356
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2356', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2025-07-23 00:00:00'::timestamptz, '2025-07-23 00:00:00'::timestamptz, '2025-07-23 16:54:00'::timestamptz, '2025-07-23 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-07-23 16:54:00'::timestamptz); END IF;

  -- CC2357
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2357', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2025-07-23 00:00:00'::timestamptz, '2025-07-23 00:00:00'::timestamptz, '2025-07-23 16:54:00'::timestamptz, '2025-07-23 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-07-23 16:54:00'::timestamptz); END IF;

  -- CC2358
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2358', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 4, '', '2025-07-24 00:00:00'::timestamptz, '2025-07-25 16:39:00'::timestamptz, '2025-07-24 08:26:00'::timestamptz, '2025-07-24 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-24 08:26:00'::timestamptz); END IF;

  -- CC2359
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2359', 'Cliente Lavandería', false, 'completed', false, 6.54, 0.00, 0, 0.46, 7.00, 2.80, 1, 1, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-25 16:39:00'::timestamptz, '2025-07-24 08:28:00'::timestamptz, '2025-07-24 08:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-07-24 08:28:00'::timestamptz); END IF;

  -- CC2360
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2360', 'German Alveo', false, 'completed', false, 33.41, 0.00, 0, 2.34, 35.75, 14.30, 5, 1, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 14:09:00'::timestamptz, '2025-07-24 13:19:00'::timestamptz, '2025-07-24 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.75, '2025-07-24 13:19:00'::timestamptz); END IF;

  -- CC2361
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2361', 'German Alveo', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.40, 1, 1, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 14:09:00'::timestamptz, '2025-07-24 13:21:00'::timestamptz, '2025-07-24 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-24 13:21:00'::timestamptz); END IF;

  -- CC2362
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2362', 'Aaron Gutierrez', false, 'completed', false, 5.61, 2.00, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 14:10:00'::timestamptz, '2025-07-24 13:51:00'::timestamptz, '2025-07-24 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-24 13:51:00'::timestamptz); END IF;

  -- CC2363
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2363', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 14:47:00'::timestamptz, '2025-07-24 13:51:00'::timestamptz, '2025-07-24 13:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-24 13:51:00'::timestamptz); END IF;

  -- CC2364
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 200;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2364', 'Sara Ríos', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 2, '', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 15:28:00'::timestamptz, '2025-07-24 13:55:00'::timestamptz, '2025-07-24 13:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-07-24 13:55:00'::timestamptz); END IF;

  -- CC2365
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 24;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2365', 'Yara Rangel', false, 'completed', false, 27.17, 0.00, 0, 1.83, 29.00, 0.00, 0, 15, '0', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 15:28:00'::timestamptz, '2025-07-24 14:08:00'::timestamptz, '2025-07-24 14:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.00, '2025-07-24 14:08:00'::timestamptz); END IF;

  -- CC2366
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2366', 'German Alveo', false, 'completed', false, 7.20, 0.00, 0, 0.50, 7.70, 4.40, 1, 1, 'Lavandería', '2025-07-24 00:00:00'::timestamptz, '2025-07-24 15:48:00'::timestamptz, '2025-07-24 15:16:00'::timestamptz, '2025-07-24 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.70, '2025-07-24 15:16:00'::timestamptz); END IF;

  -- CC2367
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2367', 'Alvaro Martinez', false, 'completed', false, 11.80, 0.00, 0, 0.83, 12.63, 5.05, 2, 1, 'lavanderia', '2025-07-24 00:00:00'::timestamptz, '2025-07-29 16:34:00'::timestamptz, '2025-07-24 15:56:00'::timestamptz, '2025-07-24 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.63, '2025-07-24 15:56:00'::timestamptz); END IF;

  -- CC2368
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2368', 'Karla Garibaldi', false, 'completed', false, 50.00, 0.00, 0, 3.50, 53.50, 21.40, 5, 1, 'Lavandería', '2025-07-25 00:00:00'::timestamptz, '2025-07-26 13:37:00'::timestamptz, '2025-07-25 09:30:00'::timestamptz, '2025-07-25 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 53.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 53.50, '2025-07-25 09:30:00'::timestamptz); END IF;

  -- CC2369
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2369', 'Julissa Rivera', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 1.40, 1, 2, 'lavanderia', '2025-07-25 00:00:00'::timestamptz, '2025-07-25 17:09:00'::timestamptz, '2025-07-25 11:33:00'::timestamptz, '2025-07-25 11:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-07-25 11:33:00'::timestamptz); END IF;

  -- CC2370
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 201;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2370', 'Dalma Sanchez', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-07-25 00:00:00'::timestamptz, '2025-07-25 16:39:00'::timestamptz, '2025-07-25 12:21:00'::timestamptz, '2025-07-25 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-07-25 12:21:00'::timestamptz); END IF;

  -- CC2371
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2371', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-07-25 00:00:00'::timestamptz, '2025-07-25 17:09:00'::timestamptz, '2025-07-25 16:45:00'::timestamptz, '2025-07-25 16:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-25 16:45:00'::timestamptz); END IF;

  -- CC2372
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2372', 'Israel Rentería', false, 'completed', false, 13.55, 0.00, 0, 0.95, 14.50, 5.80, 1, 1, '', '2025-07-26 00:00:00'::timestamptz, '2025-07-28 14:06:00'::timestamptz, '2025-07-26 08:37:00'::timestamptz, '2025-07-26 08:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.50, '2025-07-26 08:37:00'::timestamptz); END IF;

  -- CC2373
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2373', 'Israel Rentería', false, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 09:26:00'::timestamptz, '2025-07-26 08:39:00'::timestamptz, '2025-07-26 08:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-26 08:39:00'::timestamptz); END IF;

  -- CC2374
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2374', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.10, 1, 1, '', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 16:16:00'::timestamptz, '2025-07-26 08:51:00'::timestamptz, '2025-07-26 08:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-07-26 08:51:00'::timestamptz); END IF;

  -- CC2375
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2375', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, '', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 10:21:00'::timestamptz, '2025-07-26 08:58:00'::timestamptz, '2025-07-26 08:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-07-26 08:58:00'::timestamptz); END IF;

  -- CC2376
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2376', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 09:14:00'::timestamptz, '2025-07-26 09:14:00'::timestamptz, '2025-07-26 09:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-26 09:14:00'::timestamptz); END IF;

  -- CC2377
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2377', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 10:21:00'::timestamptz, '2025-07-26 09:39:00'::timestamptz, '2025-07-26 09:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-07-26 09:39:00'::timestamptz); END IF;

  -- CC2378
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2378', 'Rafael Quintero', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '0', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 00:00:00'::timestamptz, '2025-07-26 10:27:00'::timestamptz, '2025-07-26 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-07-26 10:27:00'::timestamptz); END IF;

  -- CC2379
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 204;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2379', 'Aristides Sanchez', false, 'completed', false, 46.11, 0.00, 0, 3.02, 49.13, 18.45, 3, 4, '', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 16:00:00'::timestamptz, '2025-07-26 10:41:00'::timestamptz, '2025-07-26 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 49.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 49.13, '2025-07-26 10:41:00'::timestamptz); END IF;

  -- CC2380
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2380', 'Leonardo Salon', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'leonardo', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 16:00:00'::timestamptz, '2025-07-26 13:28:00'::timestamptz, '2025-07-26 13:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-26 13:28:00'::timestamptz); END IF;

  -- CC2381
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2381', 'Karla Garibaldi', false, 'completed', false, 8.01, 0.00, 0, 0.56, 8.57, 4.90, 1, 1, 'Lavandería', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 16:05:00'::timestamptz, '2025-07-26 13:37:00'::timestamptz, '2025-07-26 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.57 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.57, '2025-07-26 13:37:00'::timestamptz); END IF;

  -- CC2382
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2382', 'Gustavo Cumbrera', false, 'completed', false, 14.08, 0.00, 0, 0.92, 15.00, 0.00, 0, 8, 'lavanderia', '2025-07-26 00:00:00'::timestamptz, '2025-07-28 07:52:00'::timestamptz, '2025-07-26 15:53:00'::timestamptz, '2025-07-26 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-07-26 15:53:00'::timestamptz); END IF;

  -- CC2383
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2383', 'Virginia Gonzalez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería', '2025-07-26 00:00:00'::timestamptz, '2025-07-28 07:52:00'::timestamptz, '2025-07-26 16:20:00'::timestamptz, '2025-07-26 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-07-26 16:20:00'::timestamptz); END IF;

  -- CC2384
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2384', 'Virginia Gonzalez', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, 'Lavandería', '2025-07-26 00:00:00'::timestamptz, '2025-07-26 00:00:00'::timestamptz, '2025-07-26 16:24:00'::timestamptz, '2025-07-26 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2025-07-26 16:24:00'::timestamptz); END IF;

  -- CC2385
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2385', 'Josue Rosales', false, 'completed', false, 7.83, 0.00, 0, 0.55, 8.38, 2.95, 2, 3, 'lavanderia', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 16:43:00'::timestamptz, '2025-07-28 14:04:00'::timestamptz, '2025-07-28 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.38, '2025-07-28 14:04:00'::timestamptz); END IF;

  -- CC2386
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2386', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 14:06:00'::timestamptz, '2025-07-28 14:05:00'::timestamptz, '2025-07-28 14:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-28 14:05:00'::timestamptz); END IF;

  -- CC2387
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2387', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 16:02:00'::timestamptz, '2025-07-28 14:42:00'::timestamptz, '2025-07-28 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-28 14:42:00'::timestamptz); END IF;

  -- CC2388
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2388', 'Relax Cala,S.A', false, 'completed', false, 86.53, 0.00, 0, 6.06, 92.59, 41.15, 7, 1, 'Lavandería', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 16:02:00'::timestamptz, '2025-07-28 14:52:00'::timestamptz, '2025-07-28 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 92.59 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 92.59, '2025-07-28 14:52:00'::timestamptz); END IF;

  -- CC2389
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2389', 'Relax Cala,S.A', false, 'completed', false, 17.76, 0.00, 0, 1.24, 19.00, 0.00, 0, 11, 'Lavandería', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 16:02:00'::timestamptz, '2025-07-28 15:22:00'::timestamptz, '2025-07-28 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 19.00, '2025-07-28 15:22:00'::timestamptz); END IF;

  -- CC2390
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 205;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2390', 'Virginia Gayle', false, 'completed', false, 48.25, 0.00, 0, 3.38, 51.63, 20.65, 6, 1, 'lavanderia', '2025-07-28 00:00:00'::timestamptz, '2025-07-29 15:05:00'::timestamptz, '2025-07-28 16:00:00'::timestamptz, '2025-07-28 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 51.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 51.63, '2025-07-28 16:00:00'::timestamptz); END IF;

  -- CC2391
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 206;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2391', 'Wilmer Garvey', false, 'completed', false, 37.78, 0.00, 0, 2.22, 40.00, 0.00, 0, 23, 'lavanderia', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 17:51:00'::timestamptz, '2025-07-28 17:23:00'::timestamptz, '2025-07-28 17:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 40.00, '2025-07-28 17:23:00'::timestamptz); END IF;

  -- CC2392
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2392', 'Oscar Oropeza', false, 'completed', false, 24.30, 2.00, 0, 1.70, 26.00, 0.00, 0, 14, 'Lavandería', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 18:03:00'::timestamptz, '2025-07-28 17:49:00'::timestamptz, '2025-07-28 17:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.00, '2025-07-28 17:49:00'::timestamptz); END IF;

  -- CC2393
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 206;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2393', 'Wilmer Garvey', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, 'lavanderia', '2025-07-28 00:00:00'::timestamptz, '2025-07-28 00:00:00'::timestamptz, '2025-07-28 18:08:00'::timestamptz, '2025-07-28 18:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.25, '2025-07-28 18:08:00'::timestamptz); END IF;

  -- CC2394
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 207;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2394', 'Jesus Galvez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 13:42:00'::timestamptz, '2025-07-29 11:21:00'::timestamptz, '2025-07-29 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-29 11:21:00'::timestamptz); END IF;

  -- CC2395
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2395', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 13:48:00'::timestamptz, '2025-07-29 13:45:00'::timestamptz, '2025-07-29 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-29 13:45:00'::timestamptz); END IF;

  -- CC2396
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2396', 'Josue Rosales', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.35, 1, 1, 'lavanderia', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 16:33:00'::timestamptz, '2025-07-29 14:07:00'::timestamptz, '2025-07-29 14:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-29 14:07:00'::timestamptz); END IF;

  -- CC2397
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2397', 'Valery Rosas', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 14:28:00'::timestamptz, '2025-07-29 14:28:00'::timestamptz, '2025-07-29 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-29 14:28:00'::timestamptz); END IF;

  -- CC2398
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 208;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2398', 'Jane Reyes', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 14:33:00'::timestamptz, '2025-07-29 14:32:00'::timestamptz, '2025-07-29 14:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-07-29 14:32:00'::timestamptz); END IF;

  -- CC2399
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 148;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2399', 'Yul Pinto', false, 'completed', false, 8.41, 0.00, 0, 0.59, 9.00, 3.60, 1, 1, 'lavanderia', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 14:50:00'::timestamptz, '2025-07-29 14:48:00'::timestamptz, '2025-07-29 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.00, '2025-07-29 14:48:00'::timestamptz); END IF;

  -- CC2400
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2400', 'Leonel Visueti', false, 'completed', false, 0.61, 0.00, 0, 0.04, 0.65, 0.00, 0, 2, '', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 15:02:00'::timestamptz, '2025-07-29 15:01:00'::timestamptz, '2025-07-29 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.65, '2025-07-29 15:01:00'::timestamptz); END IF;

  -- CC2401
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 11;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2401', 'Maybelis Robinson', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Con Suavizante', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 00:00:00'::timestamptz, '2025-07-29 15:05:00'::timestamptz, '2025-07-29 15:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-07-29 15:05:00'::timestamptz); END IF;

  -- CC2402
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2402', 'Retail', true, 'completed', false, 0.25, 0.00, 0, 0.00, 0.25, 0.00, 0, 1, '', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 00:00:00'::timestamptz, '2025-07-29 16:33:00'::timestamptz, '2025-07-29 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.25, '2025-07-29 16:33:00'::timestamptz); END IF;

  -- CC2403
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2403', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-07-29 00:00:00'::timestamptz, '2025-07-29 16:35:00'::timestamptz, '2025-07-29 16:34:00'::timestamptz, '2025-07-29 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-07-29 16:34:00'::timestamptz); END IF;

  -- CC2404
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 209;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2404', 'Sarah Nelson', false, 'completed', false, 29.21, 0.00, 0, 2.04, 31.25, 9.50, 3, 3, 'Servicio completo lava y dobla', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 15:27:00'::timestamptz, '2025-07-30 10:45:00'::timestamptz, '2025-07-30 10:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 31.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 31.25, '2025-07-30 10:45:00'::timestamptz); END IF;

  -- CC2405
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2405', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 11:00:00'::timestamptz, '2025-07-30 10:46:00'::timestamptz, '2025-07-30 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-30 10:46:00'::timestamptz); END IF;

  -- CC2406
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2406', 'Leonel Visueti', false, 'completed', false, 3.99, 0.00, 0, 0.26, 4.25, 0.00, 0, 3, '', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 11:28:00'::timestamptz, '2025-07-30 10:56:00'::timestamptz, '2025-07-30 10:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2025-07-30 10:56:00'::timestamptz); END IF;

  -- CC2407
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 210;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2407', 'Jose Madrigales', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 14:14:00'::timestamptz, '2025-07-30 11:46:00'::timestamptz, '2025-07-30 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-07-30 11:46:00'::timestamptz); END IF;

  -- CC2408
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2408', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 14:14:00'::timestamptz, '2025-07-30 14:13:00'::timestamptz, '2025-07-30 14:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-30 14:13:00'::timestamptz); END IF;

  -- CC2409
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2409', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 16:01:00'::timestamptz, '2025-07-30 14:14:00'::timestamptz, '2025-07-30 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-30 14:14:00'::timestamptz); END IF;

  -- CC2410
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2410', 'Leonel Visueti', false, 'completed', false, 4.71, 0.00, 0, 0.29, 5.00, 0.00, 0, 5, '', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 16:47:00'::timestamptz, '2025-07-30 16:03:00'::timestamptz, '2025-07-30 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-30 16:03:00'::timestamptz); END IF;

  -- CC2411
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 211;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2411', 'Rolando Alvarado', false, 'completed', false, 11.48, 0.00, 0, 0.52, 12.00, 0.00, 0, 8, 'lavanderia', '2025-07-30 00:00:00'::timestamptz, '2025-07-30 16:47:00'::timestamptz, '2025-07-30 16:27:00'::timestamptz, '2025-07-30 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-07-30 16:27:00'::timestamptz); END IF;

  -- CC2412
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2412', 'Leonel Visueti', false, 'completed', false, 2.12, 0.00, 0, 0.13, 2.25, 0.00, 0, 2, '', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 11:35:00'::timestamptz, '2025-07-31 08:02:00'::timestamptz, '2025-07-31 08:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.25, '2025-07-31 08:02:00'::timestamptz); END IF;

  -- CC2413
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2413', 'Cliente Lavandería', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavandería', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 11:35:00'::timestamptz, '2025-07-31 08:02:00'::timestamptz, '2025-07-31 08:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-07-31 08:02:00'::timestamptz); END IF;

  -- CC2414
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 212;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2414', 'Juan Jose Rubio', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 1.85, 1, 4, 'lavanderia', '2025-07-31 00:00:00'::timestamptz, '2025-08-01 14:20:00'::timestamptz, '2025-07-31 08:15:00'::timestamptz, '2025-07-31 08:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-07-31 08:15:00'::timestamptz); END IF;

  -- CC2415
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2415', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 11:38:00'::timestamptz, '2025-07-31 11:36:00'::timestamptz, '2025-07-31 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-07-31 11:36:00'::timestamptz); END IF;

  -- CC2416
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2416', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 14:18:00'::timestamptz, '2025-07-31 11:40:00'::timestamptz, '2025-07-31 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-31 11:40:00'::timestamptz); END IF;

  -- CC2417
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2417', 'Alvaro Martinez', false, 'completed', false, 25.59, 0.00, 0, 1.79, 27.38, 9.35, 3, 2, 'lavanderia', '2025-07-31 00:00:00'::timestamptz, '2025-08-02 15:56:00'::timestamptz, '2025-07-31 14:06:00'::timestamptz, '2025-07-31 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 27.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 27.38, '2025-07-31 14:06:00'::timestamptz); END IF;

  -- CC2418
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2418', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-01 00:00:00'::timestamptz, '2025-07-31 14:18:00'::timestamptz, '2025-07-31 14:17:00'::timestamptz, '2025-07-31 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-07-31 14:17:00'::timestamptz); END IF;

  -- CC2419
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2419', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 16:46:00'::timestamptz, '2025-07-31 16:46:00'::timestamptz, '2025-07-31 16:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-07-31 16:46:00'::timestamptz); END IF;

  -- CC2420
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2420', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-07-31 00:00:00'::timestamptz, '2025-07-31 16:53:00'::timestamptz, '2025-07-31 16:52:00'::timestamptz, '2025-07-31 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-07-31 16:52:00'::timestamptz); END IF;

  -- CC2421
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2421', 'Juan Jose Rubio', false, 'completed', false, 10.00, 0.00, 0, 0.63, 10.63, 3.85, 1, 2, '', '2025-08-01 00:00:00'::timestamptz, '2025-08-02 16:57:00'::timestamptz, '2025-08-01 08:24:00'::timestamptz, '2025-08-01 08:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.63, '2025-08-01 08:24:00'::timestamptz); END IF;

  -- CC2422
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2422', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 14:22:00'::timestamptz, '2025-08-01 14:21:00'::timestamptz, '2025-08-01 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-01 14:21:00'::timestamptz); END IF;

  -- CC2423
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2423', 'German Alveo', false, 'completed', false, 38.08, 0.00, 0, 2.67, 40.75, 16.30, 6, 1, 'Lavandería', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 15:59:00'::timestamptz, '2025-08-01 14:29:00'::timestamptz, '2025-08-01 14:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.75, '2025-08-01 14:29:00'::timestamptz); END IF;

  -- CC2424
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2424', 'German Alveo', false, 'completed', false, 8.07, 0.00, 0, 0.56, 8.63, 3.45, 1, 1, 'Lavandería', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 16:00:00'::timestamptz, '2025-08-01 14:31:00'::timestamptz, '2025-08-01 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.63, '2025-08-01 14:31:00'::timestamptz); END IF;

  -- CC2425
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2425', 'Fany Luz Salon', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '0', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 15:16:00'::timestamptz, '2025-08-01 15:15:00'::timestamptz, '2025-08-01 15:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-01 15:15:00'::timestamptz); END IF;

  -- CC2426
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2426', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 16:57:00'::timestamptz, '2025-08-01 16:30:00'::timestamptz, '2025-08-01 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-01 16:30:00'::timestamptz); END IF;

  -- CC2427
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2427', 'Fany Luz Salon', false, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 2, '0', '2025-08-01 00:00:00'::timestamptz, '2025-08-01 16:43:00'::timestamptz, '2025-08-01 16:43:00'::timestamptz, '2025-08-01 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-08-01 16:43:00'::timestamptz); END IF;

  -- CC2428
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 61;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2428', 'Ana Castrellon', false, 'completed', false, 30.84, 0.00, 0, 2.16, 33.00, 0.00, 0, 9, '0', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 14:25:00'::timestamptz, '2025-08-02 08:45:00'::timestamptz, '2025-08-02 08:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 33.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 33.00, '2025-08-02 08:45:00'::timestamptz); END IF;

  -- CC2429
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2429', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.00, 1, 1, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 16:57:00'::timestamptz, '2025-08-02 09:52:00'::timestamptz, '2025-08-02 09:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-02 09:52:00'::timestamptz); END IF;

  -- CC2430
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2430', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 09:57:00'::timestamptz, '2025-08-02 09:56:00'::timestamptz, '2025-08-02 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-08-02 09:56:00'::timestamptz); END IF;

  -- CC2431
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2431', 'Israel Rentería', false, 'completed', false, 12.04, 0.00, 0, 0.84, 12.88, 5.15, 1, 1, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 15:56:00'::timestamptz, '2025-08-02 10:37:00'::timestamptz, '2025-08-02 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.88 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.88, '2025-08-02 10:37:00'::timestamptz); END IF;

  -- CC2432
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 149;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2432', 'Josue Pernett', false, 'completed', false, 16.05, 0.00, 0, 1.00, 17.05, 0.00, 0, 15, 'Lavanderia', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 11:25:00'::timestamptz, '2025-08-02 11:05:00'::timestamptz, '2025-08-02 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.05, '2025-08-02 11:05:00'::timestamptz); END IF;

  -- CC2433
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2433', 'Cesar Malave', false, 'completed', false, 14.08, 0.00, 0, 0.92, 15.00, 0.00, 0, 8, 'lavanderia', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 12:12:00'::timestamptz, '2025-08-02 12:11:00'::timestamptz, '2025-08-02 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-08-02 12:11:00'::timestamptz); END IF;

  -- CC2434
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2434', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 14:24:00'::timestamptz, '2025-08-02 13:06:00'::timestamptz, '2025-08-02 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-02 13:06:00'::timestamptz); END IF;

  -- CC2435
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2435', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 00:00:00'::timestamptz, '2025-08-02 13:07:00'::timestamptz, '2025-08-02 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-02 13:07:00'::timestamptz); END IF;

  -- CC2436
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2436', 'Ileana', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, 'lavanderia', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 13:35:00'::timestamptz, '2025-08-02 13:08:00'::timestamptz, '2025-08-02 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-08-02 13:08:00'::timestamptz); END IF;

  -- CC2437
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2437', 'Byron Moreno', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-08-02 00:00:00'::timestamptz, '2025-08-05 14:23:00'::timestamptz, '2025-08-02 13:35:00'::timestamptz, '2025-08-02 13:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-02 13:35:00'::timestamptz); END IF;

  -- CC2438
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2438', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 14:26:00'::timestamptz, '2025-08-02 14:25:00'::timestamptz, '2025-08-02 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-02 14:25:00'::timestamptz); END IF;

  -- CC2439
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2439', 'Oscar Oropeza', false, 'completed', false, 11.21, 2.00, 0, 0.79, 12.00, 0.00, 0, 7, 'Lavandería', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 15:56:00'::timestamptz, '2025-08-02 14:54:00'::timestamptz, '2025-08-02 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-02 14:54:00'::timestamptz); END IF;

  -- CC2440
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2440', 'Virginia Gonzalez', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 16:07:00'::timestamptz, '2025-08-02 16:06:00'::timestamptz, '2025-08-02 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-02 16:06:00'::timestamptz); END IF;

  -- CC2441
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2441', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 16:24:00'::timestamptz, '2025-08-02 16:21:00'::timestamptz, '2025-08-02 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-02 16:21:00'::timestamptz); END IF;

  -- CC2442
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2442', 'Gustavo Cumbrera', false, 'completed', false, 26.93, 0.00, 0, 1.57, 28.50, 0.00, 0, 17, 'lavanderia', '2025-08-02 00:00:00'::timestamptz, '2025-08-02 16:24:00'::timestamptz, '2025-08-02 16:23:00'::timestamptz, '2025-08-02 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.50, '2025-08-02 16:23:00'::timestamptz); END IF;

  -- CC2443
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2443', 'Yariela Phillips', false, 'completed', false, 15.95, 0.00, 0, 1.05, 17.00, 0.00, 0, 12, 'lavanderia', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 15:14:00'::timestamptz, '2025-08-04 10:57:00'::timestamptz, '2025-08-04 10:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.00, '2025-08-04 10:57:00'::timestamptz); END IF;

  -- CC2444
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2444', 'Fabio Nunez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'lavanderia', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 15:15:00'::timestamptz, '2025-08-04 12:42:00'::timestamptz, '2025-08-04 12:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-04 12:42:00'::timestamptz); END IF;

  -- CC2445
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2445', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 15:53:00'::timestamptz, '2025-08-04 15:16:00'::timestamptz, '2025-08-04 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-04 15:16:00'::timestamptz); END IF;

  -- CC2446
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2446', 'Evelyn', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Salón', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 15:53:00'::timestamptz, '2025-08-04 15:50:00'::timestamptz, '2025-08-04 15:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-04 15:50:00'::timestamptz); END IF;

  -- CC2447
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2447', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 15:55:00'::timestamptz, '2025-08-04 15:54:00'::timestamptz, '2025-08-04 15:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-04 15:54:00'::timestamptz); END IF;

  -- CC2448
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 211;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2448', 'Rolando Alvarado', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'lavanderia', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 16:42:00'::timestamptz, '2025-08-04 15:56:00'::timestamptz, '2025-08-04 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-04 15:56:00'::timestamptz); END IF;

  -- CC2449
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2449', 'Aaron Gutierrez', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavandería', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 16:42:00'::timestamptz, '2025-08-04 16:11:00'::timestamptz, '2025-08-04 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-04 16:11:00'::timestamptz); END IF;

  -- CC2450
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 214;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2450', 'Alexandra Lezcano', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-08-04 00:00:00'::timestamptz, '2025-08-04 16:42:00'::timestamptz, '2025-08-04 16:17:00'::timestamptz, '2025-08-04 16:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-04 16:17:00'::timestamptz); END IF;

  -- CC2451
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 215;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2451', 'Arturo Martinez', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 2, 'lavanderia', '2025-08-05 00:00:00'::timestamptz, '2025-08-06 10:38:00'::timestamptz, '2025-08-05 09:45:00'::timestamptz, '2025-08-05 09:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-08-05 09:45:00'::timestamptz); END IF;

  -- CC2452
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2452', 'Leonel Visueti', false, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, '', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 09:46:00'::timestamptz, '2025-08-05 09:46:00'::timestamptz, '2025-08-05 09:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.50, '2025-08-05 09:46:00'::timestamptz); END IF;

  -- CC2453
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2453', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 12:27:00'::timestamptz, '2025-08-05 09:53:00'::timestamptz, '2025-08-05 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-05 09:53:00'::timestamptz); END IF;

  -- CC2454
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2454', 'Relax Cala,S.A', false, 'completed', false, 159.17, 0.00, 0, 11.14, 170.31, 72.55, 12, 4, 'Lavandería', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 14:23:00'::timestamptz, '2025-08-05 12:26:00'::timestamptz, '2025-08-05 12:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 170.31 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 170.31, '2025-08-05 12:26:00'::timestamptz); END IF;

  -- CC2455
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2455', 'Josue Rosales', false, 'completed', false, 8.13, 0.00, 0, 0.50, 8.63, 2.65, 1, 4, 'lavanderia', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 16:23:00'::timestamptz, '2025-08-05 14:22:00'::timestamptz, '2025-08-05 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.63, '2025-08-05 14:22:00'::timestamptz); END IF;

  -- CC2456
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2456', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 15:06:00'::timestamptz, '2025-08-05 14:24:00'::timestamptz, '2025-08-05 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-05 14:24:00'::timestamptz); END IF;

  -- CC2457
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2457', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-05 00:00:00'::timestamptz, '2025-08-05 16:23:00'::timestamptz, '2025-08-05 15:17:00'::timestamptz, '2025-08-05 15:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-05 15:17:00'::timestamptz); END IF;

  -- CC2458
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 215;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2458', 'Arturo Martinez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'lavanderia', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 16:20:00'::timestamptz, '2025-08-06 09:12:00'::timestamptz, '2025-08-06 09:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-06 09:12:00'::timestamptz); END IF;

  -- CC2459
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2459', 'Leonel Visueti', false, 'completed', false, 4.71, 0.00, 0, 0.29, 5.00, 0.00, 0, 5, '', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 10:38:00'::timestamptz, '2025-08-06 09:24:00'::timestamptz, '2025-08-06 09:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-08-06 09:24:00'::timestamptz); END IF;

  -- CC2460
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 191;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2460', 'Angely Sicolona', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, 'lavanderia', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 12:21:00'::timestamptz, '2025-08-06 11:36:00'::timestamptz, '2025-08-06 11:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-06 11:36:00'::timestamptz); END IF;

  -- CC2461
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 164;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2461', 'Joel Iglesia', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.20, 1, 1, '0', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 16:20:00'::timestamptz, '2025-08-06 12:05:00'::timestamptz, '2025-08-06 12:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-06 12:05:00'::timestamptz); END IF;

  -- CC2462
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2462', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 12:10:00'::timestamptz, '2025-08-06 12:09:00'::timestamptz, '2025-08-06 12:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-06 12:09:00'::timestamptz); END IF;

  -- CC2463
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2463', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 16:20:00'::timestamptz, '2025-08-06 12:11:00'::timestamptz, '2025-08-06 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-06 12:11:00'::timestamptz); END IF;

  -- CC2464
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 191;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2464', 'Angely Sicolona', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'lavanderia', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 00:00:00'::timestamptz, '2025-08-06 12:24:00'::timestamptz, '2025-08-06 12:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-08-06 12:24:00'::timestamptz); END IF;

  -- CC2465
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2465', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-06 00:00:00'::timestamptz, '2025-08-06 16:23:00'::timestamptz, '2025-08-06 16:22:00'::timestamptz, '2025-08-06 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-06 16:22:00'::timestamptz); END IF;

  -- CC2466
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2466', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 10:45:00'::timestamptz, '2025-08-07 08:47:00'::timestamptz, '2025-08-07 08:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-07 08:47:00'::timestamptz); END IF;

  -- CC2467
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2467', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 09:20:00'::timestamptz, '2025-08-07 08:48:00'::timestamptz, '2025-08-07 08:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-07 08:48:00'::timestamptz); END IF;

  -- CC2468
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2468', 'German Alveo', false, 'completed', false, 33.88, 0.00, 0, 2.37, 36.25, 14.50, 6, 1, 'Lavandería', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 14:26:00'::timestamptz, '2025-08-07 10:43:00'::timestamptz, '2025-08-07 10:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 36.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 36.25, '2025-08-07 10:43:00'::timestamptz); END IF;

  -- CC2469
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2469', 'German Alveo', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 2.30, 1, 1, 'Lavandería', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 14:26:00'::timestamptz, '2025-08-07 10:43:00'::timestamptz, '2025-08-07 10:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-07 10:43:00'::timestamptz); END IF;

  -- CC2470
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2470', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.30, 1, 2, '', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 11:55:00'::timestamptz, '2025-08-07 10:46:00'::timestamptz, '2025-08-07 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-08-07 10:46:00'::timestamptz); END IF;

  -- CC2471
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2471', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 14:22:00'::timestamptz, '2025-08-07 13:11:00'::timestamptz, '2025-08-07 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-07 13:11:00'::timestamptz); END IF;

  -- CC2472
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2472', 'Rosa Arrocha', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavandería', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 14:22:00'::timestamptz, '2025-08-07 13:13:00'::timestamptz, '2025-08-07 13:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-07 13:13:00'::timestamptz); END IF;

  -- CC2473
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2473', 'Leonel Visueti', false, 'completed', false, 3.99, 0.00, 0, 0.26, 4.25, 0.00, 0, 3, '', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 14:26:00'::timestamptz, '2025-08-07 14:22:00'::timestamptz, '2025-08-07 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.25, '2025-08-07 14:22:00'::timestamptz); END IF;

  -- CC2474
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2474', 'Leonel Visueti', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, '', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 15:31:00'::timestamptz, '2025-08-07 15:31:00'::timestamptz, '2025-08-07 15:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-08-07 15:31:00'::timestamptz); END IF;

  -- CC2475
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 165;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2475', 'Marian Bequiz', false, 'completed', false, 12.50, 0.00, 0, 0.88, 13.38, 5.35, 3, 1, '0', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 15:49:00'::timestamptz, '2025-08-07 15:48:00'::timestamptz, '2025-08-07 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.38, '2025-08-07 15:48:00'::timestamptz); END IF;

  -- CC2476
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 214;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2476', 'Alexandra Lezcano', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-08-07 00:00:00'::timestamptz, '2025-08-07 16:11:00'::timestamptz, '2025-08-07 16:09:00'::timestamptz, '2025-08-07 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-07 16:09:00'::timestamptz); END IF;

  -- CC2477
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2477', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-08 00:00:00'::timestamptz, '2025-08-08 14:57:00'::timestamptz, '2025-08-08 08:26:00'::timestamptz, '2025-08-08 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-08 08:26:00'::timestamptz); END IF;

  -- CC2478
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2478', 'Cliente Lavandería', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-08-08 00:00:00'::timestamptz, '2025-08-08 09:05:00'::timestamptz, '2025-08-08 08:34:00'::timestamptz, '2025-08-08 08:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-08 08:34:00'::timestamptz); END IF;

  -- CC2479
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2479', 'Alvaro Martinez', false, 'completed', false, 25.93, 0.00, 0, 1.82, 27.75, 9.50, 3, 2, 'lavanderia', '2025-08-08 00:00:00'::timestamptz, '2025-08-09 16:51:00'::timestamptz, '2025-08-08 14:36:00'::timestamptz, '2025-08-08 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 27.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 27.75, '2025-08-08 14:36:00'::timestamptz); END IF;

  -- CC2480
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2480', 'Gustavo Cumbrera', false, 'completed', false, 14.08, 0.00, 0, 0.92, 15.00, 0.00, 0, 8, 'lavanderia', '2025-08-08 00:00:00'::timestamptz, '2025-08-08 14:57:00'::timestamptz, '2025-08-08 14:42:00'::timestamptz, '2025-08-08 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-08-08 14:42:00'::timestamptz); END IF;

  -- CC2481
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2481', 'Fany Luz Salon', false, 'completed', false, 6.24, 0.00, 0, 0.26, 6.50, 0.00, 0, 6, '0', '2025-08-08 00:00:00'::timestamptz, '2025-08-08 14:58:00'::timestamptz, '2025-08-08 14:57:00'::timestamptz, '2025-08-08 14:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-08-08 14:57:00'::timestamptz); END IF;

  -- CC2482
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2482', 'Cliente Lavandería', false, 'completed', false, 6.54, 0.00, 0, 0.46, 7.00, 2.80, 1, 1, 'Lavandería', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:06:00'::timestamptz, '2025-08-09 09:02:00'::timestamptz, '2025-08-09 09:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-08-09 09:02:00'::timestamptz); END IF;

  -- CC2483
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 212;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2483', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.80, 1, 1, 'lavanderia', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:06:00'::timestamptz, '2025-08-09 09:03:00'::timestamptz, '2025-08-09 09:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-09 09:03:00'::timestamptz); END IF;

  -- CC2484
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2484', 'Israel Rentería', false, 'completed', false, 19.28, 0.00, 0, 1.35, 20.63, 7.85, 1, 2, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:06:00'::timestamptz, '2025-08-09 09:37:00'::timestamptz, '2025-08-09 09:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.63, '2025-08-09 09:37:00'::timestamptz); END IF;

  -- CC2485
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2485', 'Leonel Willson', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 5, '0', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:06:00'::timestamptz, '2025-08-09 10:00:00'::timestamptz, '2025-08-09 10:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-08-09 10:00:00'::timestamptz); END IF;

  -- CC2486
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2486', 'Ileana', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'lavanderia', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:06:00'::timestamptz, '2025-08-09 10:53:00'::timestamptz, '2025-08-09 10:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-09 10:53:00'::timestamptz); END IF;

  -- CC2487
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 216;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2487', 'Elena Gomez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 3.20, 1, 1, 'lavanderia', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:12:00'::timestamptz, '2025-08-09 12:10:00'::timestamptz, '2025-08-09 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-09 12:10:00'::timestamptz); END IF;

  -- CC2488
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2488', 'Leonel Visueti', false, 'completed', false, 13.58, 0.00, 0, 0.92, 14.50, 0.00, 0, 8, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 12:45:00'::timestamptz, '2025-08-09 12:44:00'::timestamptz, '2025-08-09 12:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.50, '2025-08-09 12:44:00'::timestamptz); END IF;

  -- CC2489
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2489', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 13:00:00'::timestamptz, '2025-08-09 12:55:00'::timestamptz, '2025-08-09 12:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-09 12:55:00'::timestamptz); END IF;

  -- CC2490
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2490', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 13:01:00'::timestamptz, '2025-08-09 13:00:00'::timestamptz, '2025-08-09 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-09 13:00:00'::timestamptz); END IF;

  -- CC2491
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2491', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 14:37:00'::timestamptz, '2025-08-09 14:36:00'::timestamptz, '2025-08-09 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-09 14:36:00'::timestamptz); END IF;

  -- CC2492
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2492', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 15:21:00'::timestamptz, '2025-08-09 14:40:00'::timestamptz, '2025-08-09 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-09 14:40:00'::timestamptz); END IF;

  -- CC2493
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2493', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 15:21:00'::timestamptz, '2025-08-09 14:41:00'::timestamptz, '2025-08-09 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-09 14:41:00'::timestamptz); END IF;

  -- CC2494
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 217;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2494', 'Elsi Singh', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'lavanderia', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 14:53:00'::timestamptz, '2025-08-09 14:50:00'::timestamptz, '2025-08-09 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-08-09 14:50:00'::timestamptz); END IF;

  -- CC2495
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2495', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-08-09 00:00:00'::timestamptz, '2025-08-09 16:48:00'::timestamptz, '2025-08-09 15:47:00'::timestamptz, '2025-08-09 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-09 15:47:00'::timestamptz); END IF;

  -- CC2496
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2496', 'Valery Rosas', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavanderia', '2025-08-11 00:00:00'::timestamptz, '2025-08-11 00:00:00'::timestamptz, '2025-08-11 10:46:00'::timestamptz, '2025-08-11 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-08-11 10:46:00'::timestamptz); END IF;

  -- CC2497
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2497', 'Valery Rosas', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2025-08-11 00:00:00'::timestamptz, '2025-08-11 13:47:00'::timestamptz, '2025-08-11 10:46:00'::timestamptz, '2025-08-11 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-11 10:46:00'::timestamptz); END IF;

  -- CC2498
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2498', 'Josue Rosales', false, 'completed', false, 9.41, 0.00, 0, 0.59, 10.00, 3.60, 1, 2, 'lavanderia', '2025-08-11 00:00:00'::timestamptz, '2025-08-11 16:21:00'::timestamptz, '2025-08-11 13:46:00'::timestamptz, '2025-08-11 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-11 13:46:00'::timestamptz); END IF;

  -- CC2499
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2499', 'Oscar Oropeza', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 0.00, 0, 9, 'Lavandería', '2025-08-11 00:00:00'::timestamptz, '2025-08-11 16:22:00'::timestamptz, '2025-08-11 16:17:00'::timestamptz, '2025-08-11 16:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-08-11 16:17:00'::timestamptz); END IF;

  -- CC2500
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2500', 'Relax Cala,S.A', false, 'completed', false, 93.78, 0.00, 0, 6.56, 100.34, 40.15, 4, 3, 'Lavandería', '2025-08-12 00:00:00'::timestamptz, '2025-08-12 13:57:00'::timestamptz, '2025-08-12 08:15:00'::timestamptz, '2025-08-12 08:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 100.34 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 100.34, '2025-08-12 08:15:00'::timestamptz); END IF;

  -- CC2501
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2501', 'Tairis - Diego', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, '0', '2025-08-12 00:00:00'::timestamptz, '2025-08-12 16:25:00'::timestamptz, '2025-08-12 16:24:00'::timestamptz, '2025-08-12 16:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-12 16:24:00'::timestamptz); END IF;

  -- CC2502
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2502', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '', '2025-08-12 00:00:00'::timestamptz, '2025-08-12 16:32:00'::timestamptz, '2025-08-12 16:28:00'::timestamptz, '2025-08-12 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-08-12 16:28:00'::timestamptz); END IF;

  -- CC2503
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2503', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 3, '', '2025-08-13 00:00:00'::timestamptz, '2025-08-13 13:26:00'::timestamptz, '2025-08-13 13:23:00'::timestamptz, '2025-08-13 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.50, '2025-08-13 13:23:00'::timestamptz); END IF;

  -- CC2504
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2504', 'Aaron Gutierrez', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería', '2025-08-13 00:00:00'::timestamptz, '2025-08-13 14:24:00'::timestamptz, '2025-08-13 13:26:00'::timestamptz, '2025-08-13 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-13 13:26:00'::timestamptz); END IF;

  -- CC2505
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2505', 'Yariela Phillips', false, 'completed', false, 7.48, 4.00, 0, 0.52, 8.00, 0.00, 0, 6, 'lavanderia', '2025-08-13 00:00:00'::timestamptz, '2025-08-13 16:40:00'::timestamptz, '2025-08-13 14:42:00'::timestamptz, '2025-08-13 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-13 14:42:00'::timestamptz); END IF;

  -- CC2506
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2506', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-08-13 00:00:00'::timestamptz, '2025-08-13 16:04:00'::timestamptz, '2025-08-13 16:03:00'::timestamptz, '2025-08-13 16:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-13 16:03:00'::timestamptz); END IF;

  -- CC2507
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2507', 'Yariela Phillips', false, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 4, 'lavanderia', '2025-08-13 00:00:00'::timestamptz, '2025-08-13 16:07:00'::timestamptz, '2025-08-13 16:04:00'::timestamptz, '2025-08-13 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-08-13 16:04:00'::timestamptz); END IF;

  -- CC2508
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2508', 'Leonel Visueti', false, 'completed', false, 5.17, 0.00, 0, 0.33, 5.50, 0.00, 0, 5, '', '2025-08-14 00:00:00'::timestamptz, '2025-08-14 09:31:00'::timestamptz, '2025-08-14 08:31:00'::timestamptz, '2025-08-14 08:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.50, '2025-08-14 08:31:00'::timestamptz); END IF;

  -- CC2509
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2509', 'German Alveo', false, 'completed', false, 6.90, 0.00, 0, 0.48, 7.38, 2.95, 1, 1, 'Lavandería', '2025-08-14 00:00:00'::timestamptz, '2025-08-14 13:23:00'::timestamptz, '2025-08-14 11:30:00'::timestamptz, '2025-08-14 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.38, '2025-08-14 11:30:00'::timestamptz); END IF;

  -- CC2510
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2510', 'German Alveo', false, 'completed', false, 32.71, 0.00, 0, 2.29, 35.00, 14.00, 6, 1, 'Lavandería', '2025-08-14 00:00:00'::timestamptz, '2025-08-14 13:23:00'::timestamptz, '2025-08-14 11:32:00'::timestamptz, '2025-08-14 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.00, '2025-08-14 11:32:00'::timestamptz); END IF;

  -- CC2511
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2511', 'Byron Moreno', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-08-14 00:00:00'::timestamptz, '2025-08-14 17:04:00'::timestamptz, '2025-08-14 17:04:00'::timestamptz, '2025-08-14 17:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-14 17:04:00'::timestamptz); END IF;

  -- CC2512
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2512', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-08-14 00:00:00'::timestamptz, '2025-08-14 17:05:00'::timestamptz, '2025-08-14 17:05:00'::timestamptz, '2025-08-14 17:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-14 17:05:00'::timestamptz); END IF;

  -- CC2513
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2513', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.85, 1, 1, '', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 15:07:00'::timestamptz, '2025-08-15 08:26:00'::timestamptz, '2025-08-15 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-15 08:26:00'::timestamptz); END IF;

  -- CC2514
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2514', 'Juan Jose Rubio', false, 'completed', false, 7.71, 0.00, 0, 0.54, 8.25, 3.30, 1, 1, '', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 15:07:00'::timestamptz, '2025-08-15 08:26:00'::timestamptz, '2025-08-15 08:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.25, '2025-08-15 08:26:00'::timestamptz); END IF;

  -- CC2515
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 168;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2515', 'Alvaro Martinez', false, 'completed', false, 22.66, 0.00, 0, 1.59, 24.25, 9.70, 2, 1, 'lavanderia', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 15:07:00'::timestamptz, '2025-08-15 10:46:00'::timestamptz, '2025-08-15 10:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.25, '2025-08-15 10:46:00'::timestamptz); END IF;

  -- CC2516
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2516', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 7.20, 2, 1, 'Salón', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 11:11:00'::timestamptz, '2025-08-15 11:00:00'::timestamptz, '2025-08-15 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-08-15 11:00:00'::timestamptz); END IF;

  -- CC2517
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2517', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 15:52:00'::timestamptz, '2025-08-15 15:48:00'::timestamptz, '2025-08-15 15:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-15 15:48:00'::timestamptz); END IF;

  -- CC2518
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2518', 'Lina Perez', false, 'completed', false, 39.47, 4.00, 0, 2.03, 41.50, 0.00, 0, 29, 'Lavandería', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 17:18:00'::timestamptz, '2025-08-15 17:11:00'::timestamptz, '2025-08-15 17:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 41.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 41.50, '2025-08-15 17:11:00'::timestamptz); END IF;

  -- CC2519
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2519', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-08-15 00:00:00'::timestamptz, '2025-08-15 17:33:00'::timestamptz, '2025-08-15 17:32:00'::timestamptz, '2025-08-15 17:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-15 17:32:00'::timestamptz); END IF;

  -- CC2520
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2520', 'Israel Rentería', false, 'completed', false, 17.54, 0.00, 0, 1.09, 18.63, 5.85, 1, 4, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 11:36:00'::timestamptz, '2025-08-16 08:44:00'::timestamptz, '2025-08-16 08:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.63, '2025-08-16 08:44:00'::timestamptz); END IF;

  -- CC2521
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2521', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 10:02:00'::timestamptz, '2025-08-16 08:54:00'::timestamptz, '2025-08-16 08:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-16 08:54:00'::timestamptz); END IF;

  -- CC2522
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2522', 'Rafael Quintero', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 10:02:00'::timestamptz, '2025-08-16 08:54:00'::timestamptz, '2025-08-16 08:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-16 08:54:00'::timestamptz); END IF;

  -- CC2523
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2523', 'Cliente Lavandería', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 2, 'Lavandería', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 10:02:00'::timestamptz, '2025-08-16 09:28:00'::timestamptz, '2025-08-16 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-08-16 09:28:00'::timestamptz); END IF;

  -- CC2524
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2524', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 11:36:00'::timestamptz, '2025-08-16 09:56:00'::timestamptz, '2025-08-16 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-16 09:56:00'::timestamptz); END IF;

  -- CC2525
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2525', 'Leonel Willson', false, 'completed', false, 7.48, 4.00, 0, 0.52, 8.00, 0.00, 0, 6, '0', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 11:51:00'::timestamptz, '2025-08-16 10:09:00'::timestamptz, '2025-08-16 10:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-16 10:09:00'::timestamptz); END IF;

  -- CC2526
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2526', 'Cliente Lavandería', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 11:51:00'::timestamptz, '2025-08-16 11:19:00'::timestamptz, '2025-08-16 11:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-16 11:19:00'::timestamptz); END IF;

  -- CC2527
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2527', 'Cesar Malave', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, 'lavanderia', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 11:51:00'::timestamptz, '2025-08-16 11:23:00'::timestamptz, '2025-08-16 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-08-16 11:23:00'::timestamptz); END IF;

  -- CC2528
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2528', 'Israel Rentería', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 13:44:00'::timestamptz, '2025-08-16 11:25:00'::timestamptz, '2025-08-16 11:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-16 11:25:00'::timestamptz); END IF;

  -- CC2529
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2529', 'Fabio Nunez', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 12:53:00'::timestamptz, '2025-08-16 11:41:00'::timestamptz, '2025-08-16 11:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-16 11:41:00'::timestamptz); END IF;

  -- CC2530
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2530', 'Gustavo Cumbrera', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'lavanderia ', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 13:38:00'::timestamptz, '2025-08-16 12:45:00'::timestamptz, '2025-08-16 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-08-16 12:45:00'::timestamptz); END IF;

  -- CC2531
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2531', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 14:49:00'::timestamptz, '2025-08-16 13:46:00'::timestamptz, '2025-08-16 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-16 13:46:00'::timestamptz); END IF;

  -- CC2532
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 211;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2532', 'Rolando Alvarado', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'lavanderia', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 14:49:00'::timestamptz, '2025-08-16 14:48:00'::timestamptz, '2025-08-16 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-16 14:48:00'::timestamptz); END IF;

  -- CC2533
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2533', 'Leonel Visueti', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 15:13:00'::timestamptz, '2025-08-16 15:02:00'::timestamptz, '2025-08-16 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.75, '2025-08-16 15:02:00'::timestamptz); END IF;

  -- CC2534
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2534', 'Sandra Medina', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, '0', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 16:40:00'::timestamptz, '2025-08-16 15:12:00'::timestamptz, '2025-08-16 15:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-08-16 15:12:00'::timestamptz); END IF;

  -- CC2535
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2535', 'Leonel Visueti', false, 'completed', false, 16.82, 0.00, 0, 1.18, 18.00, 0.00, 0, 9, '', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 16:40:00'::timestamptz, '2025-08-16 16:36:00'::timestamptz, '2025-08-16 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-08-16 16:36:00'::timestamptz); END IF;

  -- CC2536
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2536', 'Tairis - Diego', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, '0', '2025-08-16 00:00:00'::timestamptz, '2025-08-16 16:42:00'::timestamptz, '2025-08-16 16:41:00'::timestamptz, '2025-08-16 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.50, '2025-08-16 16:41:00'::timestamptz); END IF;

  -- CC2537
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2537', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 10:08:00'::timestamptz, '2025-08-18 08:37:00'::timestamptz, '2025-08-18 08:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-18 08:37:00'::timestamptz); END IF;

  -- CC2538
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2538', 'Valery Rosas', false, 'completed', false, 21.86, 0.00, 0, 1.39, 23.25, 8.50, 2, 3, 'Lavanderia', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 15:28:00'::timestamptz, '2025-08-18 10:18:00'::timestamptz, '2025-08-18 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 23.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 23.25, '2025-08-18 10:18:00'::timestamptz); END IF;

  -- CC2539
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2539', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 13:35:00'::timestamptz, '2025-08-18 10:19:00'::timestamptz, '2025-08-18 10:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-18 10:19:00'::timestamptz); END IF;

  -- CC2540
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2540', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 13:35:00'::timestamptz, '2025-08-18 12:54:00'::timestamptz, '2025-08-18 12:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-18 12:54:00'::timestamptz); END IF;

  -- CC2541
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2541', 'Leonel Visueti', false, 'completed', false, 5.67, 0.00, 0, 0.33, 6.00, 0.00, 0, 5, '', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 13:40:00'::timestamptz, '2025-08-18 13:39:00'::timestamptz, '2025-08-18 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-18 13:39:00'::timestamptz); END IF;

  -- CC2542
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2542', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 15:29:00'::timestamptz, '2025-08-18 15:28:00'::timestamptz, '2025-08-18 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-18 15:28:00'::timestamptz); END IF;

  -- CC2543
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2543', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-18 00:00:00'::timestamptz, '2025-08-18 16:38:00'::timestamptz, '2025-08-18 16:11:00'::timestamptz, '2025-08-18 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-18 16:11:00'::timestamptz); END IF;

  -- CC2544
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2544', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.70, 1, 1, '', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 09:10:00'::timestamptz, '2025-08-19 08:17:00'::timestamptz, '2025-08-19 08:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-19 08:17:00'::timestamptz); END IF;

  -- CC2545
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2545', 'Relax Cala,S.A', false, 'completed', false, 128.16, 0.00, 0, 8.97, 137.13, 56.50, 5, 3, 'Lavandería', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 09:22:00'::timestamptz, '2025-08-19 08:58:00'::timestamptz, '2025-08-19 08:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 137.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 137.13, '2025-08-19 08:58:00'::timestamptz); END IF;

  -- CC2546
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 218;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2546', 'Shera Atsmony', false, 'completed', false, 27.57, 0.00, 0, 1.93, 29.50, 7.80, 2, 3, 'Lavanderia', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 09:39:00'::timestamptz, '2025-08-19 09:30:00'::timestamptz, '2025-08-19 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 29.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 29.50, '2025-08-19 09:30:00'::timestamptz); END IF;

  -- CC2547
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 164;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2547', 'Joel Iglesia', false, 'completed', false, 6.31, 0.00, 0, 0.44, 6.75, 2.70, 1, 1, '0', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:54:00'::timestamptz, '2025-08-19 09:31:00'::timestamptz, '2025-08-19 09:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.75, '2025-08-19 09:31:00'::timestamptz); END IF;

  -- CC2548
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 219;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2548', 'Keisy Torres', false, 'completed', false, 46.96, 0.00, 0, 3.29, 50.25, 20.10, 9, 1, 'lavanderia', '2025-08-19 00:00:00'::timestamptz, '2025-08-22 17:03:00'::timestamptz, '2025-08-19 12:04:00'::timestamptz, '2025-08-19 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 50.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 50.25, '2025-08-19 12:04:00'::timestamptz); END IF;

  -- CC2549
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2549', 'Karla Garibaldi', false, 'completed', false, 12.85, 0.00, 0, 0.65, 13.50, 0.00, 0, 10, 'Lavandería', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:50:00'::timestamptz, '2025-08-19 13:19:00'::timestamptz, '2025-08-19 13:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.50, '2025-08-19 13:19:00'::timestamptz); END IF;

  -- CC2550
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2550', 'Karla Garibaldi', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, 'Lavandería', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:36:00'::timestamptz, '2025-08-19 13:27:00'::timestamptz, '2025-08-19 13:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-19 13:27:00'::timestamptz); END IF;

  -- CC2551
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2551', 'Leonel Visueti', false, 'completed', false, 6.74, 0.00, 0, 0.26, 7.00, 0.00, 0, 5, '', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:50:00'::timestamptz, '2025-08-19 16:41:00'::timestamptz, '2025-08-19 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-08-19 16:41:00'::timestamptz); END IF;

  -- CC2552
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2552', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:54:00'::timestamptz, '2025-08-19 16:51:00'::timestamptz, '2025-08-19 16:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-19 16:51:00'::timestamptz); END IF;

  -- CC2553
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2553', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:54:00'::timestamptz, '2025-08-19 16:53:00'::timestamptz, '2025-08-19 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-19 16:53:00'::timestamptz); END IF;

  -- CC2554
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2554', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '', '2025-08-19 00:00:00'::timestamptz, '2025-08-19 16:59:00'::timestamptz, '2025-08-19 16:59:00'::timestamptz, '2025-08-19 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-08-19 16:59:00'::timestamptz); END IF;

  -- CC2555
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 220;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2555', 'Leslie Rudolph Simmonds', false, 'completed', false, 23.36, 0.00, 0, 1.64, 25.00, 6.00, 1, 3, 'Lavanderia', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 10:44:00'::timestamptz, '2025-08-20 09:29:00'::timestamptz, '2025-08-20 09:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.00, '2025-08-20 09:29:00'::timestamptz); END IF;

  -- CC2556
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 221;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2556', 'Yanis Hernandez', false, 'completed', false, 9.81, 0.00, 0, 0.69, 10.50, 4.20, 1, 1, 'lavanderia', '2025-08-20 00:00:00'::timestamptz, '2025-08-22 11:03:00'::timestamptz, '2025-08-20 09:47:00'::timestamptz, '2025-08-20 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-08-20 09:47:00'::timestamptz); END IF;

  -- CC2557
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2557', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 15:24:00'::timestamptz, '2025-08-20 11:09:00'::timestamptz, '2025-08-20 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-20 11:09:00'::timestamptz); END IF;

  -- CC2558
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2558', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 15:24:00'::timestamptz, '2025-08-20 14:39:00'::timestamptz, '2025-08-20 14:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-08-20 14:39:00'::timestamptz); END IF;

  -- CC2559
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2559', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 15:24:00'::timestamptz, '2025-08-20 15:24:00'::timestamptz, '2025-08-20 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-20 15:24:00'::timestamptz); END IF;

  -- CC2560
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2560', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 16:50:00'::timestamptz, '2025-08-20 15:59:00'::timestamptz, '2025-08-20 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-20 15:59:00'::timestamptz); END IF;

  -- CC2561
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2561', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 16:41:00'::timestamptz, '2025-08-20 16:01:00'::timestamptz, '2025-08-20 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-20 16:01:00'::timestamptz); END IF;

  -- CC2562
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2562', 'Alberto Campell', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.95, 1, 1, 'lavanderia', '2025-08-20 00:00:00'::timestamptz, '2025-08-20 16:32:00'::timestamptz, '2025-08-20 16:29:00'::timestamptz, '2025-08-20 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-20 16:29:00'::timestamptz); END IF;

  -- CC2563
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2563', 'German Alveo', false, 'completed', false, 33.41, 0.00, 0, 2.34, 35.75, 14.30, 6, 1, 'Lavandería', '2025-08-21 00:00:00'::timestamptz, '2025-08-21 13:19:00'::timestamptz, '2025-08-21 11:09:00'::timestamptz, '2025-08-21 11:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 35.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 35.75, '2025-08-21 11:09:00'::timestamptz); END IF;

  -- CC2564
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2564', 'German Alveo', false, 'completed', false, 6.90, 0.00, 0, 0.48, 7.38, 2.95, 1, 1, 'Lavandería', '2025-08-21 00:00:00'::timestamptz, '2025-08-21 13:18:00'::timestamptz, '2025-08-21 11:13:00'::timestamptz, '2025-08-21 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.38, '2025-08-21 11:13:00'::timestamptz); END IF;

  -- CC2565
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2565', 'German Alveo', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, 'Lavandería', '2025-08-21 00:00:00'::timestamptz, '2025-08-21 00:00:00'::timestamptz, '2025-08-21 13:20:00'::timestamptz, '2025-08-21 13:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-08-21 13:20:00'::timestamptz); END IF;

  -- CC2566
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2566', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.90, 1, 1, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-23 08:36:00'::timestamptz, '2025-08-22 08:18:00'::timestamptz, '2025-08-22 08:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-22 08:18:00'::timestamptz); END IF;

  -- CC2567
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2567', 'Leonel Visueti', false, 'completed', false, 7.13, 0.00, 0, 0.50, 7.63, 3.05, 1, 1, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-23 08:36:00'::timestamptz, '2025-08-22 08:19:00'::timestamptz, '2025-08-22 08:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.63, '2025-08-22 08:19:00'::timestamptz); END IF;

  -- CC2568
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2568', 'Cliente Lavandería', false, 'completed', false, 6.20, 0.00, 0, 0.43, 6.63, 2.65, 1, 1, 'Lavandería', '2025-08-22 00:00:00'::timestamptz, '2025-08-23 08:36:00'::timestamptz, '2025-08-22 08:20:00'::timestamptz, '2025-08-22 08:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.63 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.63, '2025-08-22 08:20:00'::timestamptz); END IF;

  -- CC2569
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2569', 'Israel Rentería', false, 'completed', false, 14.50, 0.00, 0, 0.88, 15.38, 5.35, 1, 3, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-22 17:03:00'::timestamptz, '2025-08-22 09:18:00'::timestamptz, '2025-08-22 09:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.38, '2025-08-22 09:18:00'::timestamptz); END IF;

  -- CC2570
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2570', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-22 11:59:00'::timestamptz, '2025-08-22 11:58:00'::timestamptz, '2025-08-22 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-22 11:58:00'::timestamptz); END IF;

  -- CC2571
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2571', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-22 00:00:00'::timestamptz, '2025-08-22 12:00:00'::timestamptz, '2025-08-22 12:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-08-22 12:00:00'::timestamptz); END IF;

  -- CC2572
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2572', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '', '2025-08-22 00:00:00'::timestamptz, '2025-08-22 17:03:00'::timestamptz, '2025-08-22 12:07:00'::timestamptz, '2025-08-22 12:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-22 12:07:00'::timestamptz); END IF;

  -- CC2573
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2573', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'leonardo', '2025-08-22 00:00:00'::timestamptz, '2025-08-22 17:03:00'::timestamptz, '2025-08-22 16:55:00'::timestamptz, '2025-08-22 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-08-22 16:55:00'::timestamptz); END IF;

  -- CC2574
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 131;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2574', 'Relax Cala,S.A', false, 'completed', false, 103.45, 0.00, 0, 7.24, 110.69, 44.75, 7, 3, 'Lavandería', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 08:36:00'::timestamptz, '2025-08-23 07:45:00'::timestamptz, '2025-08-23 07:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 110.69 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 110.69, '2025-08-23 07:45:00'::timestamptz); END IF;

  -- CC2575
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 222;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2575', 'Maria Lossada', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 2, 'lavanderia', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 16:25:00'::timestamptz, '2025-08-23 07:56:00'::timestamptz, '2025-08-23 07:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-23 07:56:00'::timestamptz); END IF;

  -- CC2576
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2576', 'Fabio Nunez', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'lavanderia', '2025-08-24 00:00:00'::timestamptz, '2025-08-23 09:53:00'::timestamptz, '2025-08-23 09:51:00'::timestamptz, '2025-08-23 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-08-23 09:51:00'::timestamptz); END IF;

  -- CC2577
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2577', 'Gustavo Cumbrera', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 10, 'lavanderia', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 11:27:00'::timestamptz, '2025-08-23 11:25:00'::timestamptz, '2025-08-23 11:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-08-23 11:25:00'::timestamptz); END IF;

  -- CC2578
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2578', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 11:29:00'::timestamptz, '2025-08-23 11:28:00'::timestamptz, '2025-08-23 11:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-23 11:28:00'::timestamptz); END IF;

  -- CC2579
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2579', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 4, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 00:00:00'::timestamptz, '2025-08-23 11:35:00'::timestamptz, '2025-08-23 11:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-08-23 11:35:00'::timestamptz); END IF;

  -- CC2580
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2580', 'Cesar Malave', false, 'completed', false, 9.46, 2.00, 0, 0.54, 10.00, 0.00, 0, 7, 'lavanderia', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 12:17:00'::timestamptz, '2025-08-23 12:14:00'::timestamptz, '2025-08-23 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-23 12:14:00'::timestamptz); END IF;

  -- CC2581
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2581', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 13:45:00'::timestamptz, '2025-08-23 13:45:00'::timestamptz, '2025-08-23 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-23 13:45:00'::timestamptz); END IF;

  -- CC2582
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2582', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 13:46:00'::timestamptz, '2025-08-23 13:46:00'::timestamptz, '2025-08-23 13:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-23 13:46:00'::timestamptz); END IF;

  -- CC2583
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2583', 'Leonel Visueti', false, 'completed', false, 2.12, 0.00, 0, 0.13, 2.25, 0.00, 0, 2, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 14:55:00'::timestamptz, '2025-08-23 13:47:00'::timestamptz, '2025-08-23 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.25, '2025-08-23 13:47:00'::timestamptz); END IF;

  -- CC2584
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2584', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.00, 1, 1, '', '2025-08-24 00:00:00'::timestamptz, '2025-08-23 16:25:00'::timestamptz, '2025-08-23 14:52:00'::timestamptz, '2025-08-23 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-23 14:52:00'::timestamptz); END IF;

  -- CC2585
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2585', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 00:00:00'::timestamptz, '2025-08-23 15:01:00'::timestamptz, '2025-08-23 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-23 15:01:00'::timestamptz); END IF;

  -- CC2586
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 159;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2586', 'Brenda Paredes', false, 'completed', false, 54.21, 0.00, 0, 3.79, 58.00, 0.00, 0, 6, '0', '2025-08-23 00:00:00'::timestamptz, '2025-08-26 10:32:00'::timestamptz, '2025-08-23 15:34:00'::timestamptz, '2025-08-23 15:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 58.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 58.00, '2025-08-23 15:34:00'::timestamptz); END IF;

  -- CC2587
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2587', 'Leonel Visueti', false, 'completed', false, 22.82, 0.00, 0, 1.18, 24.00, 0.00, 0, 15, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 16:25:00'::timestamptz, '2025-08-23 16:23:00'::timestamptz, '2025-08-23 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.00, '2025-08-23 16:23:00'::timestamptz); END IF;

  -- CC2588
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2588', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, '', '2025-08-23 00:00:00'::timestamptz, '2025-08-23 16:27:00'::timestamptz, '2025-08-23 16:26:00'::timestamptz, '2025-08-23 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-23 16:26:00'::timestamptz); END IF;

  -- CC2589
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2589', 'Yariela Phillips', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 09:50:00'::timestamptz, '2025-08-25 08:47:00'::timestamptz, '2025-08-25 08:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-08-25 08:47:00'::timestamptz); END IF;

  -- CC2590
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 184;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2590', 'La Barberia', false, 'completed', false, 5.84, 0.00, 0, 0.41, 6.25, 2.50, 1, 1, 'lavanderia', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 10:32:00'::timestamptz, '2025-08-25 10:24:00'::timestamptz, '2025-08-25 10:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.25, '2025-08-25 10:24:00'::timestamptz); END IF;

  -- CC2591
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 192;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2591', 'Coromoto Roverse', false, 'completed', false, 16.95, 0.00, 0, 1.05, 18.00, 0.00, 0, 4, 'lavanderia', '2025-08-25 00:00:00'::timestamptz, '2025-08-26 10:39:00'::timestamptz, '2025-08-25 11:31:00'::timestamptz, '2025-08-25 11:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-08-25 11:31:00'::timestamptz); END IF;

  -- CC2592
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2592', 'Lina Perez', false, 'completed', false, 33.27, 2.00, 0, 1.73, 35.00, 0.00, 0, 23, 'Lavandería', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 13:14:00'::timestamptz, '2025-08-25 12:40:00'::timestamptz, '2025-08-25 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.00, '2025-08-25 12:40:00'::timestamptz); END IF;

  -- CC2593
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2593', 'Alvaro Martinez @', false, 'completed', false, 36.21, 0.00, 0, 2.54, 38.75, 15.50, 4, 1, '', '2025-08-25 00:00:00'::timestamptz, '2025-08-26 11:50:00'::timestamptz, '2025-08-25 13:07:00'::timestamptz, '2025-08-25 13:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 38.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 38.75, '2025-08-25 13:07:00'::timestamptz); END IF;

  -- CC2594
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2594', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 15:48:00'::timestamptz, '2025-08-25 14:40:00'::timestamptz, '2025-08-25 14:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-25 14:40:00'::timestamptz); END IF;

  -- CC2595
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2595', 'Karla Garibaldi', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, 'Lavandería', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 15:48:00'::timestamptz, '2025-08-25 14:41:00'::timestamptz, '2025-08-25 14:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.50, '2025-08-25 14:41:00'::timestamptz); END IF;

  -- CC2596
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2596', 'Leonel Visueti', false, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 5, '', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 14:43:00'::timestamptz, '2025-08-25 14:43:00'::timestamptz, '2025-08-25 14:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-08-25 14:43:00'::timestamptz); END IF;

  -- CC2597
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2597', 'Aaron Gutierrez', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 15:48:00'::timestamptz, '2025-08-25 15:44:00'::timestamptz, '2025-08-25 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-25 15:44:00'::timestamptz); END IF;

  -- CC2598
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2598', 'Rafael Quintero', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '0', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 15:48:00'::timestamptz, '2025-08-25 15:44:00'::timestamptz, '2025-08-25 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-08-25 15:44:00'::timestamptz); END IF;

  -- CC2599
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2599', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '0', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 15:56:00'::timestamptz, '2025-08-25 15:55:00'::timestamptz, '2025-08-25 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-08-25 15:55:00'::timestamptz); END IF;

  -- CC2600
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 223;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2600', 'Juan Samaniego', false, 'completed', false, 20.92, 0.00, 0, 1.46, 22.38, 8.95, 2, 1, 'lavanderia', '2025-08-26 00:00:00'::timestamptz, '2025-08-26 16:41:00'::timestamptz, '2025-08-25 16:10:00'::timestamptz, '2025-08-25 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.38, '2025-08-25 16:10:00'::timestamptz); END IF;

  -- CC2601
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2601', 'Karla Garibaldi', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-08-25 00:00:00'::timestamptz, '2025-08-25 16:54:00'::timestamptz, '2025-08-25 16:53:00'::timestamptz, '2025-08-25 16:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-25 16:53:00'::timestamptz); END IF;

  -- CC2602
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 192;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2602', 'Coromoto Roverse', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 2, 'lavanderia', '2025-08-26 00:00:00'::timestamptz, '2025-08-28 13:25:00'::timestamptz, '2025-08-26 10:39:00'::timestamptz, '2025-08-26 10:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-08-26 10:39:00'::timestamptz); END IF;

  -- CC2603
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 159;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2603', 'Brenda Paredes', false, 'completed', false, 14.02, 0.00, 0, 0.98, 15.00, 0.00, 0, 2, '0', '2025-08-26 00:00:00'::timestamptz, '2025-08-26 11:50:00'::timestamptz, '2025-08-26 10:48:00'::timestamptz, '2025-08-26 10:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-08-26 10:48:00'::timestamptz); END IF;

  -- CC2604
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2604', 'Josue Rosales', false, 'completed', false, 7.78, 0.00, 0, 0.47, 8.25, 2.50, 1, 4, 'lavanderia', '2025-08-26 00:00:00'::timestamptz, '2025-08-26 16:41:00'::timestamptz, '2025-08-26 14:31:00'::timestamptz, '2025-08-26 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.25, '2025-08-26 14:31:00'::timestamptz); END IF;

  -- CC2605
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 159;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2605', 'Brenda Paredes', false, 'completed', false, 36.64, 0.00, 0, 2.36, 39.00, 0.00, 0, 8, '0', '2025-08-26 00:00:00'::timestamptz, '2025-08-30 16:08:00'::timestamptz, '2025-08-26 16:47:00'::timestamptz, '2025-08-26 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 39.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 39.00, '2025-08-26 16:47:00'::timestamptz); END IF;

  -- CC2606
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2606', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 3, '', '2025-08-26 00:00:00'::timestamptz, '2025-08-26 16:56:00'::timestamptz, '2025-08-26 16:55:00'::timestamptz, '2025-08-26 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-26 16:55:00'::timestamptz); END IF;

  -- CC2607
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 222;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2607', 'Maria Lossada', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, 'lavanderia', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 12:54:00'::timestamptz, '2025-08-27 12:13:00'::timestamptz, '2025-08-27 12:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-27 12:13:00'::timestamptz); END IF;

  -- CC2608
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2608', 'Leonel Visueti', false, 'completed', false, 18.89, 0.00, 0, 1.11, 20.00, 0.00, 0, 12, '', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 13:54:00'::timestamptz, '2025-08-27 13:53:00'::timestamptz, '2025-08-27 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-08-27 13:53:00'::timestamptz); END IF;

  -- CC2609
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2609', 'Paula Perez', false, 'completed', false, 27.47, 0.00, 0, 1.78, 29.25, 2.35, 1, 14, 'lavanderia', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 14:35:00'::timestamptz, '2025-08-27 14:03:00'::timestamptz, '2025-08-27 14:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.25, '2025-08-27 14:03:00'::timestamptz); END IF;

  -- CC2610
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2610', 'Leonel Visueti', false, 'completed', false, 6.74, 0.00, 0, 0.26, 7.00, 0.00, 0, 5, '', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 16:35:00'::timestamptz, '2025-08-27 16:34:00'::timestamptz, '2025-08-27 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-08-27 16:34:00'::timestamptz); END IF;

  -- CC2611
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2611', 'Leonel Visueti', false, 'completed', false, 3.87, 0.00, 0, 0.13, 4.00, 0.00, 0, 4, '', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 16:41:00'::timestamptz, '2025-08-27 16:39:00'::timestamptz, '2025-08-27 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-08-27 16:39:00'::timestamptz); END IF;

  -- CC2612
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2612', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '0', '2025-08-28 00:00:00'::timestamptz, '2025-08-27 17:02:00'::timestamptz, '2025-08-27 16:59:00'::timestamptz, '2025-08-27 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-08-27 16:59:00'::timestamptz); END IF;

  -- CC2613
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2613', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-27 00:00:00'::timestamptz, '2025-08-27 17:02:00'::timestamptz, '2025-08-27 16:59:00'::timestamptz, '2025-08-27 16:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-08-27 16:59:00'::timestamptz); END IF;

  -- CC2614
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2614', 'Rolando Mendoza', false, 'completed', false, 14.49, 0.00, 0, 1.01, 15.50, 6.20, 1, 1, 'lavanderia', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 16:02:00'::timestamptz, '2025-08-28 09:36:00'::timestamptz, '2025-08-28 09:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.50, '2025-08-28 09:36:00'::timestamptz); END IF;

  -- CC2615
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2615', 'Karla Garibaldi', false, 'completed', false, 28.49, 0.00, 0, 1.99, 30.48, 11.70, 2, 2, 'Lavandería', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 13:50:00'::timestamptz, '2025-08-28 10:30:00'::timestamptz, '2025-08-28 10:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.48 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.48, '2025-08-28 10:30:00'::timestamptz); END IF;

  -- CC2616
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2616', 'German Alveo', false, 'completed', false, 46.15, 0.00, 0, 3.23, 49.38, 19.75, 6, 1, 'Lavandería', '2025-08-29 00:00:00'::timestamptz, '2025-08-28 13:58:00'::timestamptz, '2025-08-28 10:44:00'::timestamptz, '2025-08-28 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 49.38 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 49.38, '2025-08-28 10:44:00'::timestamptz); END IF;

  -- CC2617
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2617', 'German Alveo', false, 'completed', false, 74.77, 0.00, 0, 5.23, 80.00, 0.00, 0, 10, 'Lavandería', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 13:57:00'::timestamptz, '2025-08-28 13:42:00'::timestamptz, '2025-08-28 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 80.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 80.00, '2025-08-28 13:42:00'::timestamptz); END IF;

  -- CC2618
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2618', 'Leonel Visueti', false, 'completed', false, 6.36, 0.00, 0, 0.39, 6.75, 0.00, 0, 6, '', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 15:36:00'::timestamptz, '2025-08-28 15:35:00'::timestamptz, '2025-08-28 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.75, '2025-08-28 15:35:00'::timestamptz); END IF;

  -- CC2619
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2619', 'Leonel Visueti', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 4, '', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 00:00:00'::timestamptz, '2025-08-28 16:01:00'::timestamptz, '2025-08-28 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.25, '2025-08-28 16:01:00'::timestamptz); END IF;

  -- CC2620
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 226;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2620', 'Renato Mejia', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 20, 'lavanderia', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 16:33:00'::timestamptz, '2025-08-28 16:19:00'::timestamptz, '2025-08-28 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-28 16:19:00'::timestamptz); END IF;

  -- CC2621
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2621', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '', '2025-08-28 00:00:00'::timestamptz, '2025-08-28 00:00:00'::timestamptz, '2025-08-28 16:31:00'::timestamptz, '2025-08-28 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-28 16:31:00'::timestamptz); END IF;

  -- CC2622
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2622', 'German Alveo', false, 'completed', false, 11.49, 0.00, 0, 0.80, 12.29, 2.45, 1, 2, 'Lavandería', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 08:34:00'::timestamptz, '2025-08-29 08:18:00'::timestamptz, '2025-08-29 08:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.29 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.29, '2025-08-29 08:18:00'::timestamptz); END IF;

  -- CC2623
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2623', 'Julissa Rivera', false, 'completed', false, 6.84, 0.00, 0, 0.41, 7.25, 2.50, 1, 2, 'lavanderia', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 14:05:00'::timestamptz, '2025-08-29 09:05:00'::timestamptz, '2025-08-29 09:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.25, '2025-08-29 09:05:00'::timestamptz); END IF;

  -- CC2624
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 16;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2624', 'Donde La Parce Salón Plaza Tocumen', false, 'completed', false, 13.79, 0.00, 0, 0.96, 14.75, 5.90, 1, 1, 'Salón', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 11:52:00'::timestamptz, '2025-08-29 10:12:00'::timestamptz, '2025-08-29 10:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.75, '2025-08-29 10:12:00'::timestamptz); END IF;

  -- CC2625
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2625', 'German Alveo', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 0.00, 0, 3, 'Lavandería', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 14:02:00'::timestamptz, '2025-08-29 10:26:00'::timestamptz, '2025-08-29 10:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2025-08-29 10:26:00'::timestamptz); END IF;

  -- CC2626
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 56;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2626', 'Liliana Zambrano', false, 'completed', false, 9.46, 2.00, 0, 0.54, 10.00, 0.00, 0, 7, '0', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 14:05:00'::timestamptz, '2025-08-29 11:49:00'::timestamptz, '2025-08-29 11:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-08-29 11:49:00'::timestamptz); END IF;

  -- CC2627
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 107;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2627', 'Grethell Guevara', false, 'completed', false, 30.29, 0.00, 0, 1.84, 32.13, 9.85, 1, 6, 'Lavandería', '2025-08-30 00:00:00'::timestamptz, '2025-08-29 14:06:00'::timestamptz, '2025-08-29 11:56:00'::timestamptz, '2025-08-29 11:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 32.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 32.13, '2025-08-29 11:56:00'::timestamptz); END IF;

  -- CC2628
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2628', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'leonardo', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 14:43:00'::timestamptz, '2025-08-29 14:42:00'::timestamptz, '2025-08-29 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-29 14:42:00'::timestamptz); END IF;

  -- CC2629
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2629', 'Leonel Visueti', false, 'completed', false, 1.93, 0.00, 0, 0.07, 2.00, 0.00, 0, 4, '', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 15:10:00'::timestamptz, '2025-08-29 15:09:00'::timestamptz, '2025-08-29 15:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-29 15:09:00'::timestamptz); END IF;

  -- CC2630
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2630', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-08-29 00:00:00'::timestamptz, '2025-08-29 16:54:00'::timestamptz, '2025-08-29 16:52:00'::timestamptz, '2025-08-29 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-29 16:52:00'::timestamptz); END IF;

  -- CC2631
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 212;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2631', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 1.40, 1, 1, 'lavanderia', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:08:00'::timestamptz, '2025-08-30 08:18:00'::timestamptz, '2025-08-30 08:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-30 08:18:00'::timestamptz); END IF;

  -- CC2632
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2632', 'Israel Rentería', false, 'completed', false, 17.12, 0.00, 0, 1.13, 18.25, 6.90, 1, 2, '', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:08:00'::timestamptz, '2025-08-30 09:20:00'::timestamptz, '2025-08-30 09:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.25, '2025-08-30 09:20:00'::timestamptz); END IF;

  -- CC2633
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2633', 'Fabio Nunez', false, 'completed', false, 5.61, 2.00, 0, 0.39, 6.00, 0.00, 0, 4, 'lavanderia', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 10:36:00'::timestamptz, '2025-08-30 09:51:00'::timestamptz, '2025-08-30 09:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-08-30 09:51:00'::timestamptz); END IF;

  -- CC2634
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2634', 'Oscar Oropeza', false, 'completed', false, 14.95, 2.00, 0, 1.05, 16.00, 0.00, 0, 9, 'Lavandería', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 11:21:00'::timestamptz, '2025-08-30 10:37:00'::timestamptz, '2025-08-30 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-08-30 10:37:00'::timestamptz); END IF;

  -- CC2635
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 221;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2635', 'Yanis Hernandez', false, 'completed', false, 27.80, 0.00, 0, 1.95, 29.75, 11.90, 4, 1, 'lavanderia', '2025-08-31 00:00:00'::timestamptz, '2025-09-01 14:53:00'::timestamptz, '2025-08-30 11:02:00'::timestamptz, '2025-08-30 11:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.75, '2025-08-30 11:02:00'::timestamptz); END IF;

  -- CC2636
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2636', 'Virginia Gonzalez', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería', '2025-08-30 00:00:00'::timestamptz, '2025-09-01 11:28:00'::timestamptz, '2025-08-30 11:05:00'::timestamptz, '2025-08-30 11:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-08-30 11:05:00'::timestamptz); END IF;

  -- CC2637
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2637', 'Leonel Willson', false, 'completed', false, 11.48, 0.00, 0, 0.52, 12.00, 0.00, 0, 9, '0', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 13:08:00'::timestamptz, '2025-08-30 11:38:00'::timestamptz, '2025-08-30 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-08-30 11:38:00'::timestamptz); END IF;

  -- CC2638
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2638', 'Cesar Malave', false, 'completed', false, 14.19, 2.00, 0, 0.81, 15.00, 0.00, 0, 10, 'lavanderia', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 13:08:00'::timestamptz, '2025-08-30 12:57:00'::timestamptz, '2025-08-30 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-08-30 12:57:00'::timestamptz); END IF;

  -- CC2639
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2639', 'Gustavo Cumbrera', false, 'completed', false, 16.41, 2.00, 0, 1.09, 17.50, 0.00, 0, 12, 'lavanderia', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 13:09:00'::timestamptz, '2025-08-30 13:05:00'::timestamptz, '2025-08-30 13:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 17.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 17.50, '2025-08-30 13:05:00'::timestamptz); END IF;

  -- CC2640
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 203;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2640', 'Juan Jose Rubio', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.65, 1, 1, '', '2025-08-30 00:00:00'::timestamptz, '2025-09-02 16:27:00'::timestamptz, '2025-08-30 15:18:00'::timestamptz, '2025-08-30 15:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-08-30 15:18:00'::timestamptz); END IF;

  -- CC2641
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 227;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2641', 'Daniela Gonzalez', false, 'completed', false, 7.94, 0.00, 0, 0.56, 8.50, 0.85, 1, 6, 'lavanderia', '2025-08-30 00:00:00'::timestamptz, '2025-09-01 16:42:00'::timestamptz, '2025-08-30 15:52:00'::timestamptz, '2025-08-30 15:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.50, '2025-08-30 15:52:00'::timestamptz); END IF;

  -- CC2642
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2642', 'Leonel Visueti', false, 'completed', false, 17.95, 0.00, 0, 1.05, 19.00, 0.00, 0, 11, '', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:07:00'::timestamptz, '2025-08-30 16:04:00'::timestamptz, '2025-08-30 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 19.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 19.00, '2025-08-30 16:04:00'::timestamptz); END IF;

  -- CC2643
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2643', 'Karla Garibaldi', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'Lavandería', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:07:00'::timestamptz, '2025-08-30 16:06:00'::timestamptz, '2025-08-30 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-08-30 16:06:00'::timestamptz); END IF;

  -- CC2644
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 25;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2644', 'Liliana', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, '0', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:40:00'::timestamptz, '2025-08-30 16:39:00'::timestamptz, '2025-08-30 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-08-30 16:39:00'::timestamptz); END IF;

  -- CC2645
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2645', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 3, '', '2025-08-30 00:00:00'::timestamptz, '2025-08-30 00:00:00'::timestamptz, '2025-08-30 16:40:00'::timestamptz, '2025-08-30 16:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-08-30 16:40:00'::timestamptz); END IF;

  -- CC2646
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 194;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2646', 'Angel Barberia', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 11:28:00'::timestamptz, '2025-09-01 09:47:00'::timestamptz, '2025-09-01 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-09-01 09:47:00'::timestamptz); END IF;

  -- CC2647
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2647', 'Valery Rosas', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 12:17:00'::timestamptz, '2025-09-01 12:16:00'::timestamptz, '2025-09-01 12:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-09-01 12:16:00'::timestamptz); END IF;

  -- CC2648
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC2648', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '', '2025-09-01 00:00:00'::timestamptz, '2025-09-01 12:21:00'::timestamptz, '2025-09-01 12:18:00'::timestamptz, '2025-09-01 12:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-09-01 12:18:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 5: Imported orders 2001 to 2500';
END $$;
