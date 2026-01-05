-- =============================================
-- CleanCloud Orders Import - Part 7 of 7
-- Orders 3001 to 3472 (of 3472)
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


  -- CC3159
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3159', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025110600000031591100123050385657, Fecha de autorización: 11/06/2025 9:31:11 p. m., Protocolo autorización 00001528364-1-65300620250000000000097514', '2025-11-06 00:00:00'::timestamptz, '2025-11-06 16:48:00'::timestamptz, '2025-11-06 16:31:00'::timestamptz, '2025-11-06 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-06 16:31:00'::timestamptz); END IF;

  -- CC3160
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3160', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025110700000031601100120193502293, Fecha de autorización: 11/07/2025 4:29:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000097844', '2025-11-07 00:00:00'::timestamptz, '2025-11-07 11:31:00'::timestamptz, '2025-11-07 11:29:00'::timestamptz, '2025-11-07 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-07 11:29:00'::timestamptz); END IF;

  -- CC3161
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3161', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025110700000031611100128056119856, Fecha de autorización: 11/07/2025 4:30:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000097845', '2025-11-07 00:00:00'::timestamptz, '2025-11-07 11:31:00'::timestamptz, '2025-11-07 11:30:00'::timestamptz, '2025-11-07 11:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-07 11:30:00'::timestamptz); END IF;

  -- CC3162
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3162', 'Juan David VanSice', false, 'completed', false, 0.00, 26.50, 0, 0.00, 0.00, 10.60, 2, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante  FE generada: FE0120000155737034-2-2023-3800002025110700000031621100128219691972, Fecha de autorización: 11/07/2025 6:20:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000097915', '2025-11-07 00:00:00'::timestamptz, '2025-11-07 16:53:00'::timestamptz, '2025-11-07 13:20:00'::timestamptz, '2025-11-07 13:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.00, '2025-11-07 13:20:00'::timestamptz); END IF;

  -- CC3163
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3163', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025110700000031631100123612480627, Fecha de autorización: 11/07/2025 9:52:45 p. m., Protocolo autorización 00001528364-1-65300620250000000000097998', '2025-11-07 00:00:00'::timestamptz, '2025-11-07 16:53:00'::timestamptz, '2025-11-07 16:52:00'::timestamptz, '2025-11-07 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-07 16:52:00'::timestamptz); END IF;

  -- CC3164
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3164', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025110700000031641100120599020946, Fecha de autorización: 11/07/2025 9:54:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000097999', '2025-11-07 00:00:00'::timestamptz, '2025-11-07 00:00:00'::timestamptz, '2025-11-07 16:54:00'::timestamptz, '2025-11-07 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-11-07 16:54:00'::timestamptz); END IF;

  -- CC3165
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3165', 'Leonel Willson', false, 'completed', false, 3.74, 4.00, 0, 0.26, 4.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025110800000031651100125085784788, Fecha de autorización: 11/08/2025 2:21:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000098145', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 10:38:00'::timestamptz, '2025-11-08 09:21:00'::timestamptz, '2025-11-08 09:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-08 09:21:00'::timestamptz); END IF;

  -- CC3166
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 193;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3166', 'Cesar Malave', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025110800000031661100128996047088, Fecha de autorización: 11/08/2025 3:16:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000098165', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 10:38:00'::timestamptz, '2025-11-08 10:15:00'::timestamptz, '2025-11-08 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-11-08 10:15:00'::timestamptz); END IF;

  -- CC3167
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3167', 'Virginia Gonzalez', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110800000031671100128018188042, Fecha de autorización: 11/08/2025 3:22:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000098175', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 12:51:00'::timestamptz, '2025-11-08 10:22:00'::timestamptz, '2025-11-08 10:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-11-08 10:22:00'::timestamptz); END IF;

  -- CC3168
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3168', 'Luis Carlos Arosema', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'lavanderia', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 10:38:00'::timestamptz, '2025-11-08 10:37:00'::timestamptz, '2025-11-08 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-08 10:37:00'::timestamptz); END IF;

  -- CC3169
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3169', 'Leonel Visueti', false, 'completed', false, 14.56, 0.00, 0, 0.79, 15.35, 0.00, 0, 10, '  FE generada: FE0120000155737034-2-2023-3800002025110800000031691100125200199918, Fecha de autorización: 11/08/2025 4:32:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000098207', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 12:51:00'::timestamptz, '2025-11-08 11:32:00'::timestamptz, '2025-11-08 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.35, '2025-11-08 11:32:00'::timestamptz); END IF;

  -- CC3170
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3170', 'Leonel Visueti', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025110800000031701100124173455065, Fecha de autorización: 11/08/2025 5:52:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000098249', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 13:56:00'::timestamptz, '2025-11-08 12:52:00'::timestamptz, '2025-11-08 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-11-08 12:52:00'::timestamptz); END IF;

  -- CC3171
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3171', 'Fabio Nunez', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 14:12:00'::timestamptz, '2025-11-08 13:52:00'::timestamptz, '2025-11-08 13:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-11-08 13:52:00'::timestamptz); END IF;

  -- CC3172
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3172', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025110800000031721100120531950209, Fecha de autorización: 11/08/2025 7:06:04 p. m., Protocolo autorización 00001528364-1-65300620250000000000098278', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 14:07:00'::timestamptz, '2025-11-08 14:06:00'::timestamptz, '2025-11-08 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-11-08 14:06:00'::timestamptz); END IF;

  -- CC3173
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 274;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3173', 'Flor De Rey', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025110800000031731100129124384774, Fecha de autorización: 11/08/2025 7:23:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000098289', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 14:24:00'::timestamptz, '2025-11-08 14:09:00'::timestamptz, '2025-11-08 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-08 14:09:00'::timestamptz); END IF;

  -- CC3174
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 273;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3174', 'Isaac Guevara', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 8.00, 1, 1, 'lava y dobla  FE generada: FE0120000155737034-2-2023-3800002025110800000031741100125365166002, Fecha de autorización: 11/08/2025 7:21:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000098286', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 14:23:00'::timestamptz, '2025-11-08 14:21:00'::timestamptz, '2025-11-08 14:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-11-08 14:21:00'::timestamptz); END IF;

  -- CC3175
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 273;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3175', 'Isaac Guevara', false, 'completed', false, 4.25, 0.00, 0, 0.00, 4.25, 0.00, 0, 8, 'lava y dobla  FE generada: FE0120000155737034-2-2023-3800002025110800000031751100125649634139, Fecha de autorización: 11/08/2025 7:22:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000098288', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 14:23:00'::timestamptz, '2025-11-08 14:22:00'::timestamptz, '2025-11-08 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.25, '2025-11-08 14:22:00'::timestamptz); END IF;

  -- CC3176
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3176', 'Oscar Oropeza', false, 'completed', false, 11.21, 2.00, 0, 0.79, 12.00, 0.00, 0, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025110800000031761100120645731376, Fecha de autorización: 11/08/2025 10:17:18 p. m., Protocolo autorización 00001528364-1-65300620250000000000098315', '2025-11-08 00:00:00'::timestamptz, '2025-11-08 17:17:00'::timestamptz, '2025-11-08 17:15:00'::timestamptz, '2025-11-08 17:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-11-08 17:15:00'::timestamptz); END IF;

  -- CC3177
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3177', 'Yariela Phillips', false, 'completed', false, 19.94, 0.00, 0, 1.31, 21.25, 0.00, 0, 15, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111000000031771100128145097268, Fecha de autorización: 11/10/2025 1:48:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000098729', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 11:33:00'::timestamptz, '2025-11-10 08:48:00'::timestamptz, '2025-11-10 08:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 21.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 21.25, '2025-11-10 08:48:00'::timestamptz); END IF;

  -- CC3178
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3178', 'Leonel Visueti', false, 'completed', false, 17.08, 0.00, 0, 0.92, 18.00, 0.00, 0, 11, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031781100126957586005, Fecha de autorización: 11/10/2025 3:41:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000098736', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 11:33:00'::timestamptz, '2025-11-10 10:41:00'::timestamptz, '2025-11-10 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 18.00, '2025-11-10 10:41:00'::timestamptz); END IF;

  -- CC3179
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3179', 'Fabio Nunez', false, 'completed', false, 6.10, 2.00, 0, 0.40, 6.50, 0.00, 0, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111000000031791100124818553941, Fecha de autorización: 11/10/2025 4:00:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000098738', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 11:33:00'::timestamptz, '2025-11-10 11:00:00'::timestamptz, '2025-11-10 11:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-11-10 11:00:00'::timestamptz); END IF;

  -- CC3180
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3180', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031801100129633149020, Fecha de autorización: 11/10/2025 4:32:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000098742', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 13:00:00'::timestamptz, '2025-11-10 11:32:00'::timestamptz, '2025-11-10 11:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-11-10 11:32:00'::timestamptz); END IF;

  -- CC3181
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3181', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031811100125463769621, Fecha de autorización: 11/10/2025 5:27:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000098748', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 13:00:00'::timestamptz, '2025-11-10 12:27:00'::timestamptz, '2025-11-10 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-10 12:27:00'::timestamptz); END IF;

  -- CC3182
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3182', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031821100122979949242, Fecha de autorización: 11/10/2025 5:53:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000098749', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 13:00:00'::timestamptz, '2025-11-10 12:53:00'::timestamptz, '2025-11-10 12:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-10 12:53:00'::timestamptz); END IF;

  -- CC3183
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3183', 'Leonel Visueti', false, 'completed', false, 14.35, 0.00, 0, 0.65, 15.00, 0.00, 0, 13, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031831100123089379113, Fecha de autorización: 11/10/2025 7:33:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000098759', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 14:37:00'::timestamptz, '2025-11-10 14:33:00'::timestamptz, '2025-11-10 14:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-11-10 14:33:00'::timestamptz); END IF;

  -- CC3184
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3184', 'Evelyn', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025111000000031841100125898483373, Fecha de autorización: 11/10/2025 8:30:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000098763', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 15:31:00'::timestamptz, '2025-11-10 15:30:00'::timestamptz, '2025-11-10 15:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-11-10 15:30:00'::timestamptz); END IF;

  -- CC3185
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3185', 'Retail', true, 'completed', false, 2.70, 0.00, 0, 0.00, 2.70, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031851100122890240967, Fecha de autorización: 11/10/2025 8:33:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000098764', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 00:00:00'::timestamptz, '2025-11-10 15:32:00'::timestamptz, '2025-11-10 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.70 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.70, '2025-11-10 15:32:00'::timestamptz); END IF;

  -- CC3186
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3186', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031861100126273146120, Fecha de autorización: 11/10/2025 8:33:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000098765', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 15:34:00'::timestamptz, '2025-11-10 15:33:00'::timestamptz, '2025-11-10 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-10 15:33:00'::timestamptz); END IF;

  -- CC3187
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3187', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111000000031871100129737636123, Fecha de autorización: 11/10/2025 9:22:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000098766', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 16:53:00'::timestamptz, '2025-11-10 16:21:00'::timestamptz, '2025-11-10 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-10 16:21:00'::timestamptz); END IF;

  -- CC3188
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 261;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3188', 'Genesis Samaniego', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111000000031881100122822276094, Fecha de autorización: 11/10/2025 9:25:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000098767', '2025-11-10 00:00:00'::timestamptz, '2025-11-10 16:53:00'::timestamptz, '2025-11-10 16:25:00'::timestamptz, '2025-11-10 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-11-10 16:25:00'::timestamptz); END IF;

  -- CC3189
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 275;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3189', 'Loris Abrego', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'cobertura de cama  FE generada: FE0120000155737034-2-2023-3800002025111100000031891100128349910105, Fecha de autorización: 11/11/2025 2:49:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000098882', '2025-11-11 00:00:00'::timestamptz, '2025-11-12 15:45:00'::timestamptz, '2025-11-11 09:49:00'::timestamptz, '2025-11-11 09:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-11 09:49:00'::timestamptz); END IF;

  -- CC3190
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 276;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3190', 'Itzel Carrera', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111100000031901100124216533655, Fecha de autorización: 11/11/2025 5:10:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000098993', '2025-11-11 00:00:00'::timestamptz, '2025-11-12 11:44:00'::timestamptz, '2025-11-11 12:10:00'::timestamptz, '2025-11-11 12:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-11 12:10:00'::timestamptz); END IF;

  -- CC3191
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3191', 'Aaron Gutierrez', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111100000031911100128270570056, Fecha de autorización: 11/11/2025 6:14:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000099058', '2025-11-11 00:00:00'::timestamptz, '2025-11-11 13:15:00'::timestamptz, '2025-11-11 13:14:00'::timestamptz, '2025-11-11 13:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-11 13:14:00'::timestamptz); END IF;

  -- CC3192
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3192', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111100000031921100128496342859, Fecha de autorización: 11/11/2025 8:11:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000099110', '2025-11-11 00:00:00'::timestamptz, '2025-11-11 15:12:00'::timestamptz, '2025-11-11 15:11:00'::timestamptz, '2025-11-11 15:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-11 15:11:00'::timestamptz); END IF;

  -- CC3193
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3193', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111100000031931100124095557277, Fecha de autorización: 11/11/2025 9:19:24 p. m., Protocolo autorización 00001528364-1-65300620250000000000099123', '2025-11-11 00:00:00'::timestamptz, '2025-11-11 16:19:00'::timestamptz, '2025-11-11 16:19:00'::timestamptz, '2025-11-11 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-11 16:19:00'::timestamptz); END IF;

  -- CC3194
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3194', 'Maribel Carruyo', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111200000031941100123444877426, Fecha de autorización: 11/12/2025 4:26:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000099214', '2025-11-12 00:00:00'::timestamptz, '2025-11-12 11:44:00'::timestamptz, '2025-11-12 11:26:00'::timestamptz, '2025-11-12 11:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-12 11:26:00'::timestamptz); END IF;

  -- CC3195
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3195', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111200000031951100126414833542, Fecha de autorización: 11/12/2025 4:37:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000099215', '2025-11-12 00:00:00'::timestamptz, '2025-11-12 11:44:00'::timestamptz, '2025-11-12 11:37:00'::timestamptz, '2025-11-12 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-12 11:37:00'::timestamptz); END IF;

  -- CC3196
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3196', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111200000031961100123458349666, Fecha de autorización: 11/12/2025 4:55:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000099221', '2025-11-12 00:00:00'::timestamptz, '2025-11-12 15:45:00'::timestamptz, '2025-11-12 11:55:00'::timestamptz, '2025-11-12 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-12 11:55:00'::timestamptz); END IF;

  -- CC3197
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 276;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3197', 'Itzel Carrera', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111300000031971100120073433758, Fecha de autorización: 11/13/2025 2:03:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000099576', '2025-11-13 00:00:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz, '2025-11-13 09:03:00'::timestamptz, '2025-11-13 09:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-11-13 09:03:00'::timestamptz); END IF;

  -- CC3198
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3198', 'Juan David VanSice', false, 'completed', false, 0.00, 36.88, 0, 0.00, 0.00, 12.75, 3, 6, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 10:30:00'::timestamptz, '2025-11-13 10:29:00'::timestamptz, '2025-11-13 10:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-11-13 10:29:00'::timestamptz); END IF;

  -- CC3199
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 278;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3199', 'Richo Emiliani', false, 'completed', false, 22.43, 0.00, 0, 1.57, 24.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111300000031991100128146167335, Fecha de autorización: 11/13/2025 5:45:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000099679', '2025-11-13 00:00:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz, '2025-11-13 12:45:00'::timestamptz, '2025-11-13 12:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.00, '2025-11-13 12:45:00'::timestamptz); END IF;

  -- CC3200
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3200', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 12:57:00'::timestamptz, '2025-11-13 12:57:00'::timestamptz, '2025-11-13 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-13 12:57:00'::timestamptz); END IF;

  -- CC3201
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3201', 'Leonel Visueti', false, 'completed', false, 8.61, 0.00, 0, 0.39, 9.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025111300000032011100122901650490, Fecha de autorización: 11/13/2025 5:58:11 p. m., Protocolo autorización 00001528364-1-65300620250000000000099683', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 12:58:00'::timestamptz, '2025-11-13 12:58:00'::timestamptz, '2025-11-13 12:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-11-13 12:58:00'::timestamptz); END IF;

  -- CC3202
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3202', 'German Alveo', false, 'completed', false, 41.82, 0.00, 0, 2.93, 44.75, 15.50, 6, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111300000032021100126132988263, Fecha de autorización: 11/13/2025 7:07:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000099698', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 14:07:00'::timestamptz, '2025-11-13 13:00:00'::timestamptz, '2025-11-13 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 44.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 44.75, '2025-11-13 13:00:00'::timestamptz); END IF;

  -- CC3203
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3203', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 13:27:00'::timestamptz, '2025-11-13 13:26:00'::timestamptz, '2025-11-13 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-13 13:26:00'::timestamptz); END IF;

  -- CC3204
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3204', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111300000032041100123482920564, Fecha de autorización: 11/13/2025 7:14:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000099702', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 16:13:00'::timestamptz, '2025-11-13 14:14:00'::timestamptz, '2025-11-13 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-13 14:14:00'::timestamptz); END IF;

  -- CC3205
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3205', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111300000032051100121405959155, Fecha de autorización: 11/13/2025 7:20:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000099705', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 14:22:00'::timestamptz, '2025-11-13 14:20:00'::timestamptz, '2025-11-13 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-13 14:20:00'::timestamptz); END IF;

  -- CC3206
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3206', 'Nicole Flores', true, 'completed', false, 1.35, 0.00, 0, 0.00, 1.35, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111300000032061100123600339349, Fecha de autorización: 11/13/2025 8:22:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000099742', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 00:00:00'::timestamptz, '2025-11-13 15:22:00'::timestamptz, '2025-11-13 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.35, '2025-11-13 15:22:00'::timestamptz); END IF;

  -- CC3207
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3207', 'Juan David VanSice', false, 'completed', false, 0.00, 15.50, 0, 0.00, 0.00, 5.40, 1, 3, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-11-13 00:00:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz, '2025-11-13 15:32:00'::timestamptz, '2025-11-13 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-11-13 15:32:00'::timestamptz); END IF;

  -- CC3208
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3208', 'Nicole Flores', false, 'completed', false, 17.08, 0.00, 0, 0.92, 18.00, 0.00, 0, 11, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111300000032081100123234969238, Fecha de autorización: 11/13/2025 9:58:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000099816', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 17:00:00'::timestamptz, '2025-11-13 16:58:00'::timestamptz, '2025-11-13 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-11-13 16:58:00'::timestamptz); END IF;

  -- CC3209
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 70;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3209', 'Octavio Cherigo', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111300000032091100126780146324, Fecha de autorización: 11/13/2025 10:07:35 p. m., Protocolo autorización 00001528364-1-65300620250000000000099829', '2025-11-13 00:00:00'::timestamptz, '2025-11-13 17:07:00'::timestamptz, '2025-11-13 17:07:00'::timestamptz, '2025-11-13 17:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-13 17:07:00'::timestamptz); END IF;

  -- CC3210
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 235;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3210', 'Tamika Johnson', false, 'completed', false, 11.11, 0.00, 0, 0.64, 11.75, 3.90, 1, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111400000032101100128530312111, Fecha de autorización: 11/14/2025 2:44:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000100042', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 09:47:00'::timestamptz, '2025-11-14 09:44:00'::timestamptz, '2025-11-14 09:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.75, '2025-11-14 09:44:00'::timestamptz); END IF;

  -- CC3211
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 274;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3211', 'Flor De Rey', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025111400000032111100128303798008, Fecha de autorización: 11/14/2025 3:40:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000100074', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 10:45:00'::timestamptz, '2025-11-14 10:40:00'::timestamptz, '2025-11-14 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-14 10:40:00'::timestamptz); END IF;

  -- CC3212
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3212', 'Valery Rosas', false, 'completed', false, 11.64, 0.00, 0, 0.56, 12.20, 0.00, 0, 11, 'Lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111400000032121100122191128070, Fecha de autorización: 11/14/2025 5:36:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000100130', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 12:37:00'::timestamptz, '2025-11-14 12:36:00'::timestamptz, '2025-11-14 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.20, '2025-11-14 12:36:00'::timestamptz); END IF;

  -- CC3213
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 279;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3213', 'Jose Ramires', false, 'completed', false, 24.30, 0.00, 0, 1.70, 26.00, 0.00, 0, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111400000032131100128094324749, Fecha de autorización: 11/14/2025 5:57:53 p. m., Protocolo autorización 00001528364-1-65300620250000000000100135', '2025-11-14 00:00:00'::timestamptz, '2025-11-15 15:46:00'::timestamptz, '2025-11-14 12:57:00'::timestamptz, '2025-11-14 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.00, '2025-11-14 12:57:00'::timestamptz); END IF;

  -- CC3214
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3214', 'Lina Perez', false, 'completed', false, 51.04, 4.00, 0, 2.56, 53.60, 0.00, 0, 37, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111400000032141100120425388518, Fecha de autorización: 11/14/2025 7:09:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000100167', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz, '2025-11-14 14:09:00'::timestamptz, '2025-11-14 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 53.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 53.60, '2025-11-14 14:09:00'::timestamptz); END IF;

  -- CC3215
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3215', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111400000032151100125124006922, Fecha de autorización: 11/14/2025 7:55:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000100176', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz, '2025-11-14 14:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-14 14:55:00'::timestamptz); END IF;

  -- CC3216
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3216', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111400000032161100128961585106, Fecha de autorización: 11/14/2025 8:20:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000100191', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 16:26:00'::timestamptz, '2025-11-14 15:20:00'::timestamptz, '2025-11-14 15:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-14 15:20:00'::timestamptz); END IF;

  -- CC3217
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3217', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111400000032171100123014751101, Fecha de autorización: 11/14/2025 8:54:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000100214', '2025-11-14 00:00:00'::timestamptz, '2025-11-14 15:55:00'::timestamptz, '2025-11-14 15:53:00'::timestamptz, '2025-11-14 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-14 15:53:00'::timestamptz); END IF;

  -- CC3218
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 233;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3218', 'Ilma Beluche', false, 'completed', false, 10.35, 0.00, 0, 0.65, 11.00, 0.00, 0, 6, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111500000032181100125898867232, Fecha de autorización: 11/15/2025 1:28:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000100474', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 10:36:00'::timestamptz, '2025-11-15 08:27:00'::timestamptz, '2025-11-15 08:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-11-15 08:27:00'::timestamptz); END IF;

  -- CC3219
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3219', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032191100129287276020, Fecha de autorización: 11/15/2025 1:32:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000100479', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 10:36:00'::timestamptz, '2025-11-15 08:32:00'::timestamptz, '2025-11-15 08:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-15 08:32:00'::timestamptz); END IF;

  -- CC3220
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3220', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032201100128584271152, Fecha de autorización: 11/15/2025 2:10:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000100496', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 10:36:00'::timestamptz, '2025-11-15 09:10:00'::timestamptz, '2025-11-15 09:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-15 09:10:00'::timestamptz); END IF;

  -- CC3221
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3221', 'Leonel Visueti', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, '', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 10:36:00'::timestamptz, '2025-11-15 09:30:00'::timestamptz, '2025-11-15 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-11-15 09:30:00'::timestamptz); END IF;

  -- CC3222
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 91;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3222', 'Virginia Gonzalez', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111500000032221100123735247043, Fecha de autorización: 11/15/2025 3:34:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000100538', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 11:37:00'::timestamptz, '2025-11-15 10:34:00'::timestamptz, '2025-11-15 10:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-15 10:34:00'::timestamptz); END IF;

  -- CC3223
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 119;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3223', 'Rosa Arrocha', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111500000032231100124760650407, Fecha de autorización: 11/15/2025 4:30:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000100568', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 11:37:00'::timestamptz, '2025-11-15 11:29:00'::timestamptz, '2025-11-15 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-15 11:29:00'::timestamptz); END IF;

  -- CC3224
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3224', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111500000032241100120380490157, Fecha de autorización: 11/15/2025 4:45:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000100577', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 12:33:00'::timestamptz, '2025-11-15 11:45:00'::timestamptz, '2025-11-15 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-15 11:45:00'::timestamptz); END IF;

  -- CC3225
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3225', 'Leonel Visueti', false, 'completed', false, 8.61, 0.00, 0, 0.39, 9.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032251100129516202229, Fecha de autorización: 11/15/2025 5:01:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000100585', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 12:33:00'::timestamptz, '2025-11-15 12:01:00'::timestamptz, '2025-11-15 12:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-11-15 12:01:00'::timestamptz); END IF;

  -- CC3226
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3226', 'Leonel Visueti', false, 'completed', false, 8.61, 0.00, 0, 0.39, 9.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032261100123334524400, Fecha de autorización: 11/15/2025 5:33:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000100607', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 13:09:00'::timestamptz, '2025-11-15 12:33:00'::timestamptz, '2025-11-15 12:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-11-15 12:33:00'::timestamptz); END IF;

  -- CC3227
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3227', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032271100121345346135, Fecha de autorización: 11/15/2025 6:08:57 p. m., Protocolo autorización 00001528364-1-65300620250000000000100628', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 13:42:00'::timestamptz, '2025-11-15 13:08:00'::timestamptz, '2025-11-15 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-15 13:08:00'::timestamptz); END IF;

  -- CC3228
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3228', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032281100124899089910, Fecha de autorización: 11/15/2025 6:09:43 p. m., Protocolo autorización 00001528364-1-65300620250000000000100631', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 13:42:00'::timestamptz, '2025-11-15 13:09:00'::timestamptz, '2025-11-15 13:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-15 13:09:00'::timestamptz); END IF;

  -- CC3229
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3229', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032291100129772995033, Fecha de autorización: 11/15/2025 6:42:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000100662', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz, '2025-11-15 13:42:00'::timestamptz, '2025-11-15 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-15 13:42:00'::timestamptz); END IF;

  -- CC3230
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3230', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032301100123100236035, Fecha de autorización: 11/15/2025 8:37:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000100733', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz, '2025-11-15 15:36:00'::timestamptz, '2025-11-15 15:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-15 15:36:00'::timestamptz); END IF;

  -- CC3231
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3231', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032311100123288892475, Fecha de autorización: 11/15/2025 8:37:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000100734', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz, '2025-11-15 15:37:00'::timestamptz, '2025-11-15 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-11-15 15:37:00'::timestamptz); END IF;

  -- CC3232
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3232', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111500000032321100122238761326, Fecha de autorización: 11/15/2025 8:38:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000100736', '2025-11-15 00:00:00'::timestamptz, '2025-11-15 00:00:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz, '2025-11-15 15:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-11-15 15:38:00'::timestamptz); END IF;

  -- CC3233
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3233', 'Fernando Rios', false, 'completed', false, 10.28, 0.00, 0, 0.72, 11.00, 4.00, 2, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111700000032331100124583331579, Fecha de autorización: 11/17/2025 1:38:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000101358', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 16:37:00'::timestamptz, '2025-11-17 08:37:00'::timestamptz, '2025-11-17 08:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-11-17 08:37:00'::timestamptz); END IF;

  -- CC3234
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3234', 'Yariela Phillips', false, 'completed', false, 12.20, 4.00, 0, 0.80, 13.00, 0.00, 0, 12, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111700000032341100129450160786, Fecha de autorización: 11/17/2025 2:10:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000101367', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 10:59:00'::timestamptz, '2025-11-17 09:10:00'::timestamptz, '2025-11-17 09:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-11-17 09:10:00'::timestamptz); END IF;

  -- CC3235
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 235;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3235', 'Tamika Johnson', false, 'completed', false, 19.42, 0.00, 0, 1.08, 20.50, 6.60, 2, 5, 'lavanderia', '2025-11-17 00:00:00'::timestamptz, '2025-11-18 13:36:00'::timestamptz, '2025-11-17 10:10:00'::timestamptz, '2025-11-17 10:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.50, '2025-11-17 10:10:00'::timestamptz); END IF;

  -- CC3236
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3236', 'Leonel Visueti', false, 'completed', false, 4.99, 0.00, 0, 0.26, 5.25, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032361100128302693612, Fecha de autorización: 11/17/2025 3:58:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000101401', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 10:59:00'::timestamptz, '2025-11-17 10:58:00'::timestamptz, '2025-11-17 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.25, '2025-11-17 10:58:00'::timestamptz); END IF;

  -- CC3237
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3237', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032371100123910750564, Fecha de autorización: 11/17/2025 4:37:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000101416', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 11:37:00'::timestamptz, '2025-11-17 11:37:00'::timestamptz, '2025-11-17 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-17 11:37:00'::timestamptz); END IF;

  -- CC3238
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3238', 'Maribel Carruyo', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111700000032381100124423094812, Fecha de autorización: 11/17/2025 5:17:40 p. m., Protocolo autorización 00001528364-1-65300620250000000000101432', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 12:23:00'::timestamptz, '2025-11-17 12:17:00'::timestamptz, '2025-11-17 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-11-17 12:17:00'::timestamptz); END IF;

  -- CC3239
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 279;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3239', 'Jose Ramires', false, 'completed', false, 10.98, 0.00, 0, 0.77, 11.75, 4.70, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111700000032391100122334097857, Fecha de autorización: 11/17/2025 5:59:57 p. m., Protocolo autorización 00001528364-1-65300620250000000000101446', '2025-11-17 00:00:00'::timestamptz, '2025-11-19 08:20:00'::timestamptz, '2025-11-17 12:59:00'::timestamptz, '2025-11-17 12:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.75, '2025-11-17 12:59:00'::timestamptz); END IF;

  -- CC3240
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3240', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032401100125119239450, Fecha de autorización: 11/17/2025 6:15:43 p. m., Protocolo autorización 00001528364-1-65300620250000000000101451', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 14:15:00'::timestamptz, '2025-11-17 13:15:00'::timestamptz, '2025-11-17 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-17 13:15:00'::timestamptz); END IF;

  -- CC3241
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3241', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032411100123696065454, Fecha de autorización: 11/17/2025 7:18:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000101472', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 00:00:00'::timestamptz, '2025-11-17 14:18:00'::timestamptz, '2025-11-17 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-17 14:18:00'::timestamptz); END IF;

  -- CC3242
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3242', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032421100120723563062, Fecha de autorización: 11/17/2025 7:20:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000101475', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 00:00:00'::timestamptz, '2025-11-17 14:19:00'::timestamptz, '2025-11-17 14:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-11-17 14:19:00'::timestamptz); END IF;

  -- CC3243
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3243', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032431100125744595612, Fecha de autorización: 11/17/2025 7:20:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000101476', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 00:00:00'::timestamptz, '2025-11-17 14:20:00'::timestamptz, '2025-11-17 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-11-17 14:20:00'::timestamptz); END IF;

  -- CC3244
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3244', 'Oscar Oropeza', false, 'completed', false, 14.95, 2.00, 0, 1.05, 16.00, 0.00, 0, 9, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111700000032441100128296599205, Fecha de autorización: 11/17/2025 7:28:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000101484', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 17:35:00'::timestamptz, '2025-11-17 14:28:00'::timestamptz, '2025-11-17 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-11-17 14:28:00'::timestamptz); END IF;

  -- CC3245
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3245', 'Leonel Visueti', false, 'completed', false, 9.61, 0.00, 0, 0.39, 10.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032451100120951643914, Fecha de autorización: 11/17/2025 7:48:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000101491', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 15:23:00'::timestamptz, '2025-11-17 14:48:00'::timestamptz, '2025-11-17 14:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-11-17 14:48:00'::timestamptz); END IF;

  -- CC3246
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3246', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032461100126700323079, Fecha de autorización: 11/17/2025 8:22:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000101498', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 16:37:00'::timestamptz, '2025-11-17 15:22:00'::timestamptz, '2025-11-17 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-17 15:22:00'::timestamptz); END IF;

  -- CC3247
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3247', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032471100123341756071, Fecha de autorización: 11/17/2025 8:24:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000101500', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 15:52:00'::timestamptz, '2025-11-17 15:24:00'::timestamptz, '2025-11-17 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-17 15:24:00'::timestamptz); END IF;

  -- CC3248
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3248', 'Aaron Gutierrez', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111700000032481100123902433697, Fecha de autorización: 11/17/2025 8:49:36 p. m., Protocolo autorización 00001528364-1-65300620250000000000101507', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 15:52:00'::timestamptz, '2025-11-17 15:49:00'::timestamptz, '2025-11-17 15:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-11-17 15:49:00'::timestamptz); END IF;

  -- CC3249
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3249', 'Aaron Gutierrez', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025111700000032491100124996201031, Fecha de autorización: 11/17/2025 8:51:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000101508', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 15:52:00'::timestamptz, '2025-11-17 15:51:00'::timestamptz, '2025-11-17 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-17 15:51:00'::timestamptz); END IF;

  -- CC3250
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3250', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032501100120813115905, Fecha de autorización: 11/17/2025 9:10:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000101514', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 16:10:00'::timestamptz, '2025-11-17 16:09:00'::timestamptz, '2025-11-17 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-11-17 16:09:00'::timestamptz); END IF;

  -- CC3251
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3251', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032511100126663213095, Fecha de autorización: 11/17/2025 9:36:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000101521', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 16:37:00'::timestamptz, '2025-11-17 16:36:00'::timestamptz, '2025-11-17 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-17 16:36:00'::timestamptz); END IF;

  -- CC3252
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3252', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111700000032521100123367322750, Fecha de autorización: 11/17/2025 10:07:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000101527', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 00:00:00'::timestamptz, '2025-11-17 17:07:00'::timestamptz, '2025-11-17 17:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-17 17:07:00'::timestamptz); END IF;

  -- CC3253
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3253', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025111700000032531100122821369315, Fecha de autorización: 11/17/2025 10:34:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000101532', '2025-11-17 00:00:00'::timestamptz, '2025-11-17 17:38:00'::timestamptz, '2025-11-17 17:34:00'::timestamptz, '2025-11-17 17:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-17 17:34:00'::timestamptz); END IF;

  -- CC3254
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3254', 'Alvaro Martinez @', false, 'completed', false, 18.46, 0.00, 0, 1.29, 19.75, 7.90, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111800000032541100125094842981, Fecha de autorización: 11/18/2025 3:18:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000101612', '2025-11-18 00:00:00'::timestamptz, '2025-11-18 13:36:00'::timestamptz, '2025-11-18 08:48:00'::timestamptz, '2025-11-18 08:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 19.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 19.75, '2025-11-18 08:48:00'::timestamptz); END IF;

  -- CC3255
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3255', 'Rolando Mendoza', false, 'completed', false, 11.68, 0.00, 0, 0.82, 12.50, 5.00, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111800000032551100125501242816, Fecha de autorización: 11/18/2025 2:59:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000101606', '2025-11-18 00:00:00'::timestamptz, '2025-11-19 14:11:00'::timestamptz, '2025-11-18 09:01:00'::timestamptz, '2025-11-18 09:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.50, '2025-11-18 09:01:00'::timestamptz); END IF;

  -- CC3256
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 281;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3256', 'Sandra Estrada', false, 'completed', false, 20.56, 0.00, 0, 1.44, 22.00, 0.00, 0, 3, 'lavanderia', '2025-11-18 00:00:00'::timestamptz, '2025-11-20 12:41:00'::timestamptz, '2025-11-18 09:38:00'::timestamptz, '2025-11-18 09:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.00, '2025-11-18 09:38:00'::timestamptz); END IF;

  -- CC3257
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3257', 'Juan David VanSice', false, 'completed', false, 0.00, 37.75, 0, 0.00, 0.00, 15.10, 3, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-11-18 00:00:00'::timestamptz, '2025-11-18 16:51:00'::timestamptz, '2025-11-18 10:28:00'::timestamptz, '2025-11-18 10:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-11-18 10:28:00'::timestamptz); END IF;

  -- CC3258
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3258', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111800000032581100122084980273, Fecha de autorización: 11/18/2025 6:34:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000101675', '2025-11-18 00:00:00'::timestamptz, '2025-11-18 13:36:00'::timestamptz, '2025-11-18 13:34:00'::timestamptz, '2025-11-18 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-11-18 13:34:00'::timestamptz); END IF;

  -- CC3259
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3259', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025111800000032591100125751184524, Fecha de autorización: 11/18/2025 7:07:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000101685', '2025-11-18 00:00:00'::timestamptz, '2025-11-18 14:07:00'::timestamptz, '2025-11-18 14:06:00'::timestamptz, '2025-11-18 14:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-18 14:06:00'::timestamptz); END IF;

  -- CC3260
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 282;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3260', 'Manoj M', false, 'completed', false, 22.79, 0.00, 0, 1.46, 24.25, 4.90, 1, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111900000032601100128304071970, Fecha de autorización: 11/19/2025 1:14:27 p. m., Protocolo autorización 00001528364-1-65300620250000000000101749', '2025-11-19 00:00:00'::timestamptz, '2025-11-19 08:20:00'::timestamptz, '2025-11-19 08:14:00'::timestamptz, '2025-11-19 08:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.25, '2025-11-19 08:14:00'::timestamptz); END IF;

  -- CC3261
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 266;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3261', 'Ulices Arroyo', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 1.30, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111900000032611100127317137967, Fecha de autorización: 11/19/2025 3:44:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000101787', '2025-11-19 00:00:00'::timestamptz, '2025-11-19 17:22:00'::timestamptz, '2025-11-19 10:44:00'::timestamptz, '2025-11-19 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-11-19 10:44:00'::timestamptz); END IF;

  -- CC3262
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3262', 'Leonel Visueti', false, 'completed', false, 4.44, 0.00, 0, 0.31, 4.75, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025111900000032621100126576950093, Fecha de autorización: 11/19/2025 5:58:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000101820', '2025-11-19 00:00:00'::timestamptz, '2025-11-19 12:59:00'::timestamptz, '2025-11-19 12:58:00'::timestamptz, '2025-11-19 12:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.75, '2025-11-19 12:58:00'::timestamptz); END IF;

  -- CC3263
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3263', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025111900000032631100126954042421, Fecha de autorización: 11/19/2025 7:37:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000101832', '2025-11-19 00:00:00'::timestamptz, '2025-11-19 14:39:00'::timestamptz, '2025-11-19 14:37:00'::timestamptz, '2025-11-19 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-19 14:37:00'::timestamptz); END IF;

  -- CC3264
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 283;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3264', 'Judy Morales', false, 'completed', false, 17.42, 0.00, 0, 1.18, 18.60, 0.00, 0, 10, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025111900000032641100126503143463, Fecha de autorización: 11/19/2025 10:21:35 p. m., Protocolo autorización 00001528364-1-65300620250000000000101867', '2025-11-19 00:00:00'::timestamptz, '2025-11-19 17:22:00'::timestamptz, '2025-11-19 17:21:00'::timestamptz, '2025-11-19 17:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.60, '2025-11-19 17:21:00'::timestamptz); END IF;

  -- CC3265
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 282;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3265', 'Manoj M', false, 'completed', false, 19.06, 0.00, 0, 1.19, 20.25, 3.30, 1, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112000000032651100128244657450, Fecha de autorización: 11/20/2025 3:26:24 p. m., Protocolo autorización 00001528364-1-65300620250000000000102089', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 10:26:00'::timestamptz, '2025-11-20 08:55:00'::timestamptz, '2025-11-20 08:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.25, '2025-11-20 08:55:00'::timestamptz); END IF;

  -- CC3266
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3266', 'Karla Garibaldi', false, 'completed', false, 43.46, 0.00, 0, 3.04, 46.50, 18.60, 3, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112000000032661100120561006766, Fecha de autorización: 11/20/2025 3:13:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000102082', '2025-11-20 00:00:00'::timestamptz, '2025-11-21 16:53:00'::timestamptz, '2025-11-20 10:13:00'::timestamptz, '2025-11-20 10:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 46.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 46.50, '2025-11-20 10:13:00'::timestamptz); END IF;

  -- CC3267
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 284;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3267', 'Sandra Vergara', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 10, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112000000032671100129737205748, Fecha de autorización: 11/20/2025 5:40:58 p. m., Protocolo autorización 00001528364-1-65300620250000000000102170', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 12:41:00'::timestamptz, '2025-11-20 12:40:00'::timestamptz, '2025-11-20 12:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-11-20 12:40:00'::timestamptz); END IF;

  -- CC3268
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3268', 'German Alveo', false, 'completed', false, 37.85, 0.00, 0, 2.65, 40.50, 16.20, 6, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112000000032681100128241008225, Fecha de autorización: 11/20/2025 9:35:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000102305', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 16:35:00'::timestamptz, '2025-11-20 13:34:00'::timestamptz, '2025-11-20 13:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.50, '2025-11-20 13:34:00'::timestamptz); END IF;

  -- CC3269
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3269', 'Luis Carlos Arosema', false, 'completed', false, 5.96, 0.00, 0, 0.39, 6.35, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112000000032691100128756650048, Fecha de autorización: 11/20/2025 9:34:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000102304', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 16:35:00'::timestamptz, '2025-11-20 16:34:00'::timestamptz, '2025-11-20 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.35, '2025-11-20 16:34:00'::timestamptz); END IF;

  -- CC3270
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3270', 'Julissa Rivera', false, 'completed', false, 11.05, 0.00, 0, 0.70, 11.75, 4.30, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112000000032701100122224391340, Fecha de autorización: 11/20/2025 9:43:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000102310', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 17:14:00'::timestamptz, '2025-11-20 16:43:00'::timestamptz, '2025-11-20 16:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 11.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 11.75, '2025-11-20 16:43:00'::timestamptz); END IF;

  -- CC3271
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3271', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112000000032711100127915324509, Fecha de autorización: 11/20/2025 10:13:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000102319', '2025-11-20 00:00:00'::timestamptz, '2025-11-20 17:14:00'::timestamptz, '2025-11-20 17:13:00'::timestamptz, '2025-11-20 17:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-20 17:13:00'::timestamptz); END IF;

  -- CC3272
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3272', 'German Alveo', false, 'completed', false, 7.52, 0.00, 0, 0.53, 8.05, 4.60, 1, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112100000032721100122879959927, Fecha de autorización: 11/21/2025 1:09:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000102388', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 09:09:00'::timestamptz, '2025-11-21 08:09:00'::timestamptz, '2025-11-21 08:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.05, '2025-11-21 08:09:00'::timestamptz); END IF;

  -- CC3273
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 285;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3273', 'Dilia Valdes', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112100000032731100121433126758, Fecha de autorización: 11/21/2025 3:14:15 p. m., Protocolo autorización 00001528364-1-65300620250000000000102419', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 12:59:00'::timestamptz, '2025-11-21 10:14:00'::timestamptz, '2025-11-21 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-21 10:14:00'::timestamptz); END IF;

  -- CC3274
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3274', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112100000032741100128031582513, Fecha de autorización: 11/21/2025 3:18:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000102421', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 12:59:00'::timestamptz, '2025-11-21 10:18:00'::timestamptz, '2025-11-21 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-21 10:18:00'::timestamptz); END IF;

  -- CC3275
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3275', 'German Alveo', false, 'completed', false, 63.55, 0.00, 0, 4.45, 68.00, 0.00, 0, 18, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112100000032751100122029654862, Fecha de autorización: 11/21/2025 6:48:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000102477', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 13:47:00'::timestamptz, '2025-11-21 10:33:00'::timestamptz, '2025-11-21 10:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 68.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 68.00, '2025-11-21 10:33:00'::timestamptz); END IF;

  -- CC3276
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 286;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3276', 'Ruth Torres', false, 'completed', false, 74.77, 0.00, 0, 5.23, 80.00, 10.40, 2, 10, 'lava y dobla  FE generada: FE0120000155737034-2-2023-3800002025112100000032761100121993806077, Fecha de autorización: 11/21/2025 4:55:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000102444', '2025-11-21 00:00:00'::timestamptz, '2025-11-25 11:12:00'::timestamptz, '2025-11-21 11:55:00'::timestamptz, '2025-11-21 11:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 80.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 80.00, '2025-11-21 11:55:00'::timestamptz); END IF;

  -- CC3277
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3277', 'Leonel Visueti', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025112100000032771100122615235322, Fecha de autorización: 11/21/2025 5:07:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000102452', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 12:59:00'::timestamptz, '2025-11-21 12:07:00'::timestamptz, '2025-11-21 12:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.00, '2025-11-21 12:07:00'::timestamptz); END IF;

  -- CC3278
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3278', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112100000032781100128072583418, Fecha de autorización: 11/21/2025 5:25:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000102457', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 13:53:00'::timestamptz, '2025-11-21 12:25:00'::timestamptz, '2025-11-21 12:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-11-21 12:25:00'::timestamptz); END IF;

  -- CC3279
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3279', 'Renzo Mundo', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112100000032791100128405296638, Fecha de autorización: 11/21/2025 7:28:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000102484', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 14:28:00'::timestamptz, '2025-11-21 14:28:00'::timestamptz, '2025-11-21 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-21 14:28:00'::timestamptz); END IF;

  -- CC3280
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3280', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112100000032801100122140098240, Fecha de autorización: 11/21/2025 8:47:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000102521', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 17:33:00'::timestamptz, '2025-11-21 15:47:00'::timestamptz, '2025-11-21 15:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-21 15:47:00'::timestamptz); END IF;

  -- CC3281
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 287;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3281', 'Yanisel Maure', false, 'completed', false, 24.30, 0.00, 0, 1.70, 26.00, 0.00, 0, 13, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112100000032811100122224395636, Fecha de autorización: 11/21/2025 9:14:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000102540', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 16:53:00'::timestamptz, '2025-11-21 16:14:00'::timestamptz, '2025-11-21 16:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.00, '2025-11-21 16:14:00'::timestamptz); END IF;

  -- CC3282
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3282', 'Alvaro Martinez @', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 2, 'lavanderia', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 16:53:00'::timestamptz, '2025-11-21 16:50:00'::timestamptz, '2025-11-21 16:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-11-21 16:50:00'::timestamptz); END IF;

  -- CC3283
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3283', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112100000032831100123072848138, Fecha de autorización: 11/21/2025 9:54:36 p. m., Protocolo autorización 00001528364-1-65300620250000000000102564', '2025-11-21 00:00:00'::timestamptz, '2025-11-21 17:33:00'::timestamptz, '2025-11-21 16:54:00'::timestamptz, '2025-11-21 16:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-21 16:54:00'::timestamptz); END IF;

  -- CC3284
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 282;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3284', 'Manoj M', false, 'completed', false, 26.30, 0.00, 0, 1.70, 28.00, 6.40, 1, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032841100124714130669, Fecha de autorización: 11/22/2025 1:22:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000102767', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 09:58:00'::timestamptz, '2025-11-22 08:22:00'::timestamptz, '2025-11-22 08:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 28.00, '2025-11-22 08:22:00'::timestamptz); END IF;

  -- CC3285
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 288;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3285', 'Ana Irene Altimari', false, 'completed', false, 27.29, 0.00, 0, 1.91, 29.20, 0.00, 0, 16, 'Servicio de Planchado  FE generada: FE0120000155737034-2-2023-3800002025112200000032851100129437591278, Fecha de autorización: 11/22/2025 3:45:27 p. m., Protocolo autorización 00001528364-1-65300620250000000000102840', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 10:45:00'::timestamptz, '2025-11-22 10:06:00'::timestamptz, '2025-11-22 10:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.20 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.20, '2025-11-22 10:06:00'::timestamptz); END IF;

  -- CC3286
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3286', 'Rolando Mendoza', false, 'completed', false, 11.45, 0.00, 0, 0.80, 12.25, 4.90, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032861100122080160755, Fecha de autorización: 11/22/2025 3:59:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000102848', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:54:00'::timestamptz, '2025-11-22 10:59:00'::timestamptz, '2025-11-22 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.25, '2025-11-22 10:59:00'::timestamptz); END IF;

  -- CC3287
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3287', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032871100125906015763, Fecha de autorización: 11/22/2025 4:16:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000102858', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 11:42:00'::timestamptz, '2025-11-22 11:16:00'::timestamptz, '2025-11-22 11:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-22 11:16:00'::timestamptz); END IF;

  -- CC3288
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3288', 'Fabio Nunez', false, 'completed', false, 13.08, 2.00, 0, 0.92, 14.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032881100128294495752, Fecha de autorización: 11/22/2025 4:21:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000102862', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 12:02:00'::timestamptz, '2025-11-22 11:21:00'::timestamptz, '2025-11-22 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-22 11:21:00'::timestamptz); END IF;

  -- CC3289
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3289', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032891100124362343486, Fecha de autorización: 11/22/2025 4:25:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000102865', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 11:42:00'::timestamptz, '2025-11-22 11:25:00'::timestamptz, '2025-11-22 11:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-22 11:25:00'::timestamptz); END IF;

  -- CC3290
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 289;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3290', 'Yatzuri Anderson', false, 'completed', false, 13.71, 0.00, 0, 0.79, 14.50, 0.00, 0, 9, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032901100122834043723, Fecha de autorización: 11/22/2025 4:44:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000102875', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:54:00'::timestamptz, '2025-11-22 11:43:00'::timestamptz, '2025-11-22 11:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.50, '2025-11-22 11:43:00'::timestamptz); END IF;

  -- CC3291
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3291', 'Ileana', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032911100124412105253, Fecha de autorización: 11/22/2025 4:45:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000102877', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 12:40:00'::timestamptz, '2025-11-22 11:45:00'::timestamptz, '2025-11-22 11:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-22 11:45:00'::timestamptz); END IF;

  -- CC3292
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3292', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032921100127329388713, Fecha de autorización: 11/22/2025 5:22:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000102889', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:54:00'::timestamptz, '2025-11-22 12:21:00'::timestamptz, '2025-11-22 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-22 12:21:00'::timestamptz); END IF;

  -- CC3293
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3293', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032931100127913873996, Fecha de autorización: 11/22/2025 5:36:11 p. m., Protocolo autorización 00001528364-1-65300620250000000000102893', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 12:40:00'::timestamptz, '2025-11-22 12:36:00'::timestamptz, '2025-11-22 12:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-22 12:36:00'::timestamptz); END IF;

  -- CC3294
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3294', 'Retail', true, 'completed', false, 0.70, 0.00, 0, 0.05, 0.75, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032941100128371438412, Fecha de autorización: 11/22/2025 5:38:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000102896', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 00:00:00'::timestamptz, '2025-11-22 12:38:00'::timestamptz, '2025-11-22 12:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 0.75, '2025-11-22 12:38:00'::timestamptz); END IF;

  -- CC3295
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 289;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3295', 'Yatzuri Anderson', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032951100125796901106, Fecha de autorización: 11/22/2025 5:39:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000102898', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:54:00'::timestamptz, '2025-11-22 12:39:00'::timestamptz, '2025-11-22 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-22 12:39:00'::timestamptz); END IF;

  -- CC3296
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 291;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3296', 'Manuel Aguilar', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'lava dobla  FE generada: FE0120000155737034-2-2023-3800002025112200000032961100122693669349, Fecha de autorización: 11/22/2025 8:51:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000103002', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 17:31:00'::timestamptz, '2025-11-22 15:51:00'::timestamptz, '2025-11-22 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-22 15:51:00'::timestamptz); END IF;

  -- CC3297
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 292;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3297', 'Dudiben Jimenez', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112200000032971100122288465797, Fecha de autorización: 11/22/2025 8:53:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000103003', '2025-11-22 00:00:00'::timestamptz, '2025-11-24 12:45:00'::timestamptz, '2025-11-22 15:53:00'::timestamptz, '2025-11-22 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-11-22 15:53:00'::timestamptz); END IF;

  -- CC3298
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3298', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112200000032981100123215323298, Fecha de autorización: 11/22/2025 8:55:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000103004', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 16:34:00'::timestamptz, '2025-11-22 15:55:00'::timestamptz, '2025-11-22 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-22 15:55:00'::timestamptz); END IF;

  -- CC3299
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3299', 'Yatzury Anderson', false, 'completed', false, 1.61, 0.00, 0, 0.04, 1.65, 0.00, 0, 3, 'Lavandería', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:57:00'::timestamptz, '2025-11-22 15:57:00'::timestamptz, '2025-11-22 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.65, '2025-11-22 15:57:00'::timestamptz); END IF;

  -- CC3300
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3300', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112200000033001100126462455982, Fecha de autorización: 11/22/2025 8:59:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000103006', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 15:59:00'::timestamptz, '2025-11-22 15:58:00'::timestamptz, '2025-11-22 15:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-11-22 15:58:00'::timestamptz); END IF;

  -- CC3301
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3301', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112200000033011100120102563858, Fecha de autorización: 11/22/2025 9:45:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000103017', '2025-11-22 00:00:00'::timestamptz, '2025-11-22 16:45:00'::timestamptz, '2025-11-22 16:35:00'::timestamptz, '2025-11-22 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-22 16:35:00'::timestamptz); END IF;

  -- CC3302
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3302', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033021100127595879086, Fecha de autorización: 11/24/2025 3:58:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000103409', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 12:23:00'::timestamptz, '2025-11-24 10:58:00'::timestamptz, '2025-11-24 10:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-11-24 10:58:00'::timestamptz); END IF;

  -- CC3303
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3303', 'Leonel Visueti', false, 'completed', false, 4.24, 0.00, 0, 0.26, 4.50, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033031100123764759208, Fecha de autorización: 11/24/2025 3:59:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000103410', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 12:23:00'::timestamptz, '2025-11-24 10:59:00'::timestamptz, '2025-11-24 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.50, '2025-11-24 10:59:00'::timestamptz); END IF;

  -- CC3304
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3304', 'Leonel Visueti', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033041100122887381683, Fecha de autorización: 11/24/2025 5:28:27 p. m., Protocolo autorización 00001528364-1-65300620250000000000103444', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 12:44:00'::timestamptz, '2025-11-24 12:28:00'::timestamptz, '2025-11-24 12:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-11-24 12:28:00'::timestamptz); END IF;

  -- CC3305
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3305', 'Leonel Visueti', false, 'completed', false, 1.54, 0.00, 0, 0.11, 1.65, 0.00, 0, 11, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033051100125146157884, Fecha de autorización: 11/24/2025 6:42:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000103467', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 14:21:00'::timestamptz, '2025-11-24 13:42:00'::timestamptz, '2025-11-24 13:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.65 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.65, '2025-11-24 13:42:00'::timestamptz); END IF;

  -- CC3306
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 293;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3306', 'Lisseth Arango', false, 'completed', false, 12.21, 0.00, 0, 0.79, 13.00, 0.00, 0, 7, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112400000033061100124490458187, Fecha de autorización: 11/24/2025 7:14:30 p. m., Protocolo autorización 00001528364-1-65300620250000000000103474', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 14:16:00'::timestamptz, '2025-11-24 14:14:00'::timestamptz, '2025-11-24 14:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-11-24 14:14:00'::timestamptz); END IF;

  -- CC3307
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3307', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033071100126416344119, Fecha de autorización: 11/24/2025 7:22:27 p. m., Protocolo autorización 00001528364-1-65300620250000000000103479', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 14:22:00'::timestamptz, '2025-11-24 14:22:00'::timestamptz, '2025-11-24 14:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-24 14:22:00'::timestamptz); END IF;

  -- CC3308
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3308', 'Aaron Gutierrez', false, 'completed', false, 5.61, 2.00, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112400000033081100121032155071, Fecha de autorización: 11/24/2025 8:04:56 p. m., Protocolo autorización 00001528364-1-65300620250000000000103497', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 15:05:00'::timestamptz, '2025-11-24 15:04:00'::timestamptz, '2025-11-24 15:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-24 15:04:00'::timestamptz); END IF;

  -- CC3309
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3309', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033091100123688613022, Fecha de autorización: 11/24/2025 8:06:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000103498', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 15:07:00'::timestamptz, '2025-11-24 15:06:00'::timestamptz, '2025-11-24 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-24 15:06:00'::timestamptz); END IF;

  -- CC3310
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3310', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033101100128439047922, Fecha de autorización: 11/24/2025 8:06:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000103499', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 15:07:00'::timestamptz, '2025-11-24 15:06:00'::timestamptz, '2025-11-24 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-24 15:06:00'::timestamptz); END IF;

  -- CC3311
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3311', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112400000033111100121266392304, Fecha de autorización: 11/24/2025 9:20:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000103518', '2025-11-24 00:00:00'::timestamptz, '2025-11-24 16:51:00'::timestamptz, '2025-11-24 16:19:00'::timestamptz, '2025-11-24 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-24 16:19:00'::timestamptz); END IF;

  -- CC3312
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3312', 'Israel Rentería', false, 'completed', false, 23.66, 0.00, 0, 1.59, 25.25, 9.70, 1, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033121100127110226380, Fecha de autorización: 11/25/2025 2:09:53 p. m., Protocolo autorización 00001528364-1-65300620250000000000103627', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 14:18:00'::timestamptz, '2025-11-25 09:09:00'::timestamptz, '2025-11-25 09:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.25, '2025-11-25 09:09:00'::timestamptz); END IF;

  -- CC3313
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3313', 'Rafael Quintero', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033131100127414169939, Fecha de autorización: 11/25/2025 4:11:57 p. m., Protocolo autorización 00001528364-1-65300620250000000000103723', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 11:12:00'::timestamptz, '2025-11-25 11:11:00'::timestamptz, '2025-11-25 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-25 11:11:00'::timestamptz); END IF;

  -- CC3314
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3314', 'Juan David VanSice', false, 'completed', false, 0.00, 45.25, 0, 0.00, 0.00, 14.10, 2, 2, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 13:14:00'::timestamptz, '2025-11-25 11:20:00'::timestamptz, '2025-11-25 11:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-11-25 11:20:00'::timestamptz); END IF;

  -- CC3315
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3315', 'Maribel Carruyo', false, 'completed', false, 13.58, 0.00, 0, 0.92, 14.50, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112500000033151100129280446548, Fecha de autorización: 11/25/2025 4:22:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000103727', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 11:24:00'::timestamptz, '2025-11-25 11:22:00'::timestamptz, '2025-11-25 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.50, '2025-11-25 11:22:00'::timestamptz); END IF;

  -- CC3316
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3316', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033161100122166064856, Fecha de autorización: 11/25/2025 5:27:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000103773', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 13:14:00'::timestamptz, '2025-11-25 12:27:00'::timestamptz, '2025-11-25 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-11-25 12:27:00'::timestamptz); END IF;

  -- CC3317
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3317', 'Retail', true, 'completed', false, 2.05, 0.00, 0, 0.00, 2.05, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033171100122851392157, Fecha de autorización: 11/25/2025 6:08:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000103801', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 00:00:00'::timestamptz, '2025-11-25 13:08:00'::timestamptz, '2025-11-25 13:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.05, '2025-11-25 13:08:00'::timestamptz); END IF;

  -- CC3318
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3318', 'German Alveo', false, 'completed', false, 37.38, 0.00, 0, 2.62, 40.00, 16.00, 6, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112500000033181100121058615336, Fecha de autorización: 11/25/2025 7:18:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000103830', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 14:18:00'::timestamptz, '2025-11-25 13:10:00'::timestamptz, '2025-11-25 13:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 40.00, '2025-11-25 13:10:00'::timestamptz); END IF;

  -- CC3319
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3319', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033191100129492410908, Fecha de autorización: 11/25/2025 6:13:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000103803', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 13:14:00'::timestamptz, '2025-11-25 13:13:00'::timestamptz, '2025-11-25 13:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-25 13:13:00'::timestamptz); END IF;

  -- CC3320
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3320', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033201100126402407500, Fecha de autorización: 11/25/2025 6:21:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000103806', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 14:18:00'::timestamptz, '2025-11-25 13:21:00'::timestamptz, '2025-11-25 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-25 13:21:00'::timestamptz); END IF;

  -- CC3321
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3321', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033211100127784844988, Fecha de autorización: 11/25/2025 6:22:04 p. m., Protocolo autorización 00001528364-1-65300620250000000000103807', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 13:22:00'::timestamptz, '2025-11-25 13:21:00'::timestamptz, '2025-11-25 13:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-25 13:21:00'::timestamptz); END IF;

  -- CC3322
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3322', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033221100126187278033, Fecha de autorización: 11/25/2025 7:18:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000103831', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 15:38:00'::timestamptz, '2025-11-25 14:18:00'::timestamptz, '2025-11-25 14:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-11-25 14:18:00'::timestamptz); END IF;

  -- CC3323
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3323', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033231100124082081569, Fecha de autorización: 11/25/2025 7:45:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000103841', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 00:00:00'::timestamptz, '2025-11-25 14:45:00'::timestamptz, '2025-11-25 14:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-11-25 14:45:00'::timestamptz); END IF;

  -- CC3324
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3324', 'Evelyn', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025112500000033241100124224661814, Fecha de autorización: 11/25/2025 9:13:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000103859', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 16:50:00'::timestamptz, '2025-11-25 16:13:00'::timestamptz, '2025-11-25 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-11-25 16:13:00'::timestamptz); END IF;

  -- CC3325
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3325', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033251100122732568231, Fecha de autorización: 11/25/2025 9:31:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000103862', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 16:50:00'::timestamptz, '2025-11-25 16:31:00'::timestamptz, '2025-11-25 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-25 16:31:00'::timestamptz); END IF;

  -- CC3326
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3326', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112500000033261100128658474667, Fecha de autorización: 11/25/2025 9:39:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000103863', '2025-11-25 00:00:00'::timestamptz, '2025-11-25 16:50:00'::timestamptz, '2025-11-25 16:39:00'::timestamptz, '2025-11-25 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-25 16:39:00'::timestamptz); END IF;

  -- CC3327
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3327', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033271100122439464608, Fecha de autorización: 11/26/2025 4:21:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000103962', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 11:21:00'::timestamptz, '2025-11-26 11:21:00'::timestamptz, '2025-11-26 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-26 11:21:00'::timestamptz); END IF;

  -- CC3328
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3328', 'Leonel Visueti', false, 'completed', false, 6.07, 0.00, 0, 0.43, 6.50, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033281100126010014681, Fecha de autorización: 11/26/2025 7:24:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000104013', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 14:24:00'::timestamptz, '2025-11-26 14:24:00'::timestamptz, '2025-11-26 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.50, '2025-11-26 14:24:00'::timestamptz); END IF;

  -- CC3329
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 295;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3329', 'Liselotte Salinas', false, 'completed', false, 27.57, 0.00, 0, 1.93, 29.50, 0.00, 0, 12, 'Servicio completo de lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112600000033291100122229100014, Fecha de autorización: 11/26/2025 7:42:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000104015', '2025-11-26 00:00:00'::timestamptz, '2025-11-27 09:41:00'::timestamptz, '2025-11-26 14:42:00'::timestamptz, '2025-11-26 14:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.50, '2025-11-26 14:42:00'::timestamptz); END IF;

  -- CC3330
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 294;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3330', 'Ruth Gallegos', false, 'completed', false, 32.48, 0.00, 0, 2.27, 34.75, 9.90, 1, 3, 'servicio cpmpleto de lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112600000033301100120109484513, Fecha de autorización: 11/26/2025 7:50:40 p. m., Protocolo autorización 00001528364-1-65300620250000000000104018', '2025-11-26 00:00:00'::timestamptz, '2025-11-27 09:41:00'::timestamptz, '2025-11-26 14:50:00'::timestamptz, '2025-11-26 14:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 34.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 34.75, '2025-11-26 14:50:00'::timestamptz); END IF;

  -- CC3331
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3331', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033311100122290284198, Fecha de autorización: 11/26/2025 7:52:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000104019', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 14:53:00'::timestamptz, '2025-11-26 14:52:00'::timestamptz, '2025-11-26 14:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-11-26 14:52:00'::timestamptz); END IF;

  -- CC3332
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3332', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033321100123974770071, Fecha de autorización: 11/26/2025 7:55:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000104020', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 14:56:00'::timestamptz, '2025-11-26 14:55:00'::timestamptz, '2025-11-26 14:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-26 14:55:00'::timestamptz); END IF;

  -- CC3333
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3333', 'Julissa Rivera', false, 'completed', false, 7.31, 0.00, 0, 0.44, 7.75, 2.70, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112600000033331100129746958497, Fecha de autorización: 11/26/2025 9:01:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000104053', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 16:18:00'::timestamptz, '2025-11-26 16:00:00'::timestamptz, '2025-11-26 16:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.75, '2025-11-26 16:00:00'::timestamptz); END IF;

  -- CC3334
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3334', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033341100126248100908, Fecha de autorización: 11/26/2025 9:32:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000104068', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 17:47:00'::timestamptz, '2025-11-26 16:32:00'::timestamptz, '2025-11-26 16:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-26 16:32:00'::timestamptz); END IF;

  -- CC3335
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3335', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112600000033351100129979110608, Fecha de autorización: 11/26/2025 9:36:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000104070', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 00:00:00'::timestamptz, '2025-11-26 16:36:00'::timestamptz, '2025-11-26 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-11-26 16:36:00'::timestamptz); END IF;

  -- CC3336
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3336', 'Karla Garibaldi', false, 'completed', false, 22.43, 0.00, 0, 1.57, 24.00, 0.00, 0, 9, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112600000033361100127766494382, Fecha de autorización: 11/26/2025 10:30:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000104099', '2025-11-26 00:00:00'::timestamptz, '2025-11-26 17:47:00'::timestamptz, '2025-11-26 17:30:00'::timestamptz, '2025-11-26 17:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 24.00, '2025-11-26 17:30:00'::timestamptz); END IF;

  -- CC3337
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3337', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033371100126181845341, Fecha de autorización: 11/27/2025 1:40:35 p. m., Protocolo autorización 00001528364-1-65300620250000000000104253', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 09:48:00'::timestamptz, '2025-11-27 08:40:00'::timestamptz, '2025-11-27 08:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-27 08:40:00'::timestamptz); END IF;

  -- CC3338
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3338', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033381100124646515178, Fecha de autorización: 11/27/2025 1:41:06 p. m., Protocolo autorización 00001528364-1-65300620250000000000104254', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 09:42:00'::timestamptz, '2025-11-27 08:41:00'::timestamptz, '2025-11-27 08:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-27 08:41:00'::timestamptz); END IF;

  -- CC3339
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3339', 'Leonel Visueti', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033391100120995248873, Fecha de autorización: 11/27/2025 2:55:06 p. m., Protocolo autorización 00001528364-1-65300620250000000000104293', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 12:55:00'::timestamptz, '2025-11-27 09:55:00'::timestamptz, '2025-11-27 09:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-27 09:55:00'::timestamptz); END IF;

  -- CC3340
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3340', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033401100124717187234, Fecha de autorización: 11/27/2025 3:18:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000104304', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 11:22:00'::timestamptz, '2025-11-27 10:18:00'::timestamptz, '2025-11-27 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-27 10:18:00'::timestamptz); END IF;

  -- CC3341
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3341', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033411100129320542906, Fecha de autorización: 11/27/2025 3:41:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000104312', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 12:55:00'::timestamptz, '2025-11-27 10:41:00'::timestamptz, '2025-11-27 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-27 10:41:00'::timestamptz); END IF;

  -- CC3342
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 274;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3342', 'Flor De Rey', false, 'completed', false, 36.28, 0.00, 0, 2.22, 38.50, 0.00, 0, 33, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033421100126051528418, Fecha de autorización: 11/27/2025 6:25:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000104358', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 15:27:00'::timestamptz, '2025-11-27 13:24:00'::timestamptz, '2025-11-27 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 38.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 38.50, '2025-11-27 13:24:00'::timestamptz); END IF;

  -- CC3343
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3343', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033431100121167702626, Fecha de autorización: 11/27/2025 6:41:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000104363', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 15:27:00'::timestamptz, '2025-11-27 13:41:00'::timestamptz, '2025-11-27 13:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-11-27 13:41:00'::timestamptz); END IF;

  -- CC3344
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3344', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 15:30:00'::timestamptz, '2025-11-27 15:27:00'::timestamptz, '2025-11-27 15:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-27 15:27:00'::timestamptz); END IF;

  -- CC3345
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3345', 'Lina Perez', false, 'completed', false, 31.96, 4.00, 0, 1.64, 33.60, 0.00, 0, 24, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112700000033451100129628686732, Fecha de autorización: 11/27/2025 8:32:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000104390', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 16:42:00'::timestamptz, '2025-11-27 15:32:00'::timestamptz, '2025-11-27 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 33.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 33.60, '2025-11-27 15:32:00'::timestamptz); END IF;

  -- CC3346
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3346', 'Retail', true, 'completed', false, 3.75, 0.00, 0, 0.00, 3.75, 0.00, 0, 8, '  FE generada: FE0120000155737034-2-2023-3800002025112700000033461100124212204728, Fecha de autorización: 11/27/2025 9:33:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000104436', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 00:00:00'::timestamptz, '2025-11-27 16:33:00'::timestamptz, '2025-11-27 16:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.75, '2025-11-27 16:33:00'::timestamptz); END IF;

  -- CC3347
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3347', 'Alberto Campell', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, 'lavanderia', '2025-11-27 00:00:00'::timestamptz, '2025-11-27 00:00:00'::timestamptz, '2025-11-27 16:34:00'::timestamptz, '2025-11-27 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-11-27 16:34:00'::timestamptz); END IF;

  -- CC3348
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3348', 'Leonel Willson', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033481100126874362781, Fecha de autorización: 11/29/2025 3:27:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000104813', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 10:27:00'::timestamptz, '2025-11-29 10:27:00'::timestamptz, '2025-11-29 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-11-29 10:27:00'::timestamptz); END IF;

  -- CC3349
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3349', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033491100122281910196, Fecha de autorización: 11/29/2025 3:28:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000104815', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 10:28:00'::timestamptz, '2025-11-29 10:28:00'::timestamptz, '2025-11-29 10:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-11-29 10:28:00'::timestamptz); END IF;

  -- CC3350
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3350', 'Ileana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112900000033501100129803123907, Fecha de autorización: 11/29/2025 3:28:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000104816', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 10:29:00'::timestamptz, '2025-11-29 10:28:00'::timestamptz, '2025-11-29 10:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-29 10:28:00'::timestamptz); END IF;

  -- CC3351
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 296;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3351', 'Antony', false, 'completed', false, 8.48, 0.00, 0, 0.52, 9.00, 0.00, 0, 4, 'lavadob asistido  FE generada: FE0120000155737034-2-2023-3800002025112900000033511100124525914682, Fecha de autorización: 11/29/2025 3:37:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000104826', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 10:37:00'::timestamptz, '2025-11-29 10:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-11-29 10:37:00'::timestamptz); END IF;

  -- CC3352
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3352', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033521100123838821740, Fecha de autorización: 11/29/2025 3:44:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000104830', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 10:44:00'::timestamptz, '2025-11-29 10:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-11-29 10:44:00'::timestamptz); END IF;

  -- CC3353
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 247;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3353', 'Joel Armando', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 4.80, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025112900000033531100124674048298, Fecha de autorización: 11/29/2025 4:23:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000104851', '2025-11-29 00:00:00'::timestamptz, '2025-12-02 11:35:00'::timestamptz, '2025-11-29 11:23:00'::timestamptz, '2025-11-29 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-11-29 11:23:00'::timestamptz); END IF;

  -- CC3354
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3354', 'German Alveo', false, 'completed', false, 201.17, 0.00, 0, 14.08, 215.25, 4.50, 1, 35, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112900000033541100129296109575, Fecha de autorización: 11/29/2025 8:11:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000104991', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 12:16:00'::timestamptz, '2025-11-29 12:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 215.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 215.25, '2025-11-29 12:16:00'::timestamptz); END IF;

  -- CC3355
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3355', 'Yatzury Anderson', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112900000033551100124940754727, Fecha de autorización: 11/29/2025 5:49:30 p. m., Protocolo autorización 00001528364-1-65300620250000000000104896', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 12:49:00'::timestamptz, '2025-11-29 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-11-29 12:49:00'::timestamptz); END IF;

  -- CC3356
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3356', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033561100123245617463, Fecha de autorización: 11/29/2025 5:51:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000104897', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 12:50:00'::timestamptz, '2025-11-29 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-11-29 12:50:00'::timestamptz); END IF;

  -- CC3357
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3357', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033571100121708089781, Fecha de autorización: 11/29/2025 7:04:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000104963', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 15:11:00'::timestamptz, '2025-11-29 14:04:00'::timestamptz, '2025-11-29 14:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-11-29 14:04:00'::timestamptz); END IF;

  -- CC3358
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3358', 'Karla Garibaldi', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025112900000033581100121480252648, Fecha de autorización: 11/29/2025 8:24:56 p. m., Protocolo autorización 00001528364-1-65300620250000000000105001', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 16:12:00'::timestamptz, '2025-11-29 15:24:00'::timestamptz, '2025-11-29 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-29 15:24:00'::timestamptz); END IF;

  -- CC3359
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3359', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033591100128365865625, Fecha de autorización: 11/29/2025 9:02:58 p. m., Protocolo autorización 00001528364-1-65300620250000000000105023', '2025-11-30 00:00:00'::timestamptz, '2025-11-29 16:12:00'::timestamptz, '2025-11-29 16:02:00'::timestamptz, '2025-11-29 16:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-11-29 16:02:00'::timestamptz); END IF;

  -- CC3360
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3360', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033601100122908379001, Fecha de autorización: 11/29/2025 9:04:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000105025', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 00:00:00'::timestamptz, '2025-11-29 16:04:00'::timestamptz, '2025-11-29 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2025-11-29 16:04:00'::timestamptz); END IF;

  -- CC3361
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3361', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025112900000033611100129136646290, Fecha de autorización: 11/29/2025 9:25:40 p. m., Protocolo autorización 00001528364-1-65300620250000000000105043', '2025-11-29 00:00:00'::timestamptz, '2025-11-29 16:29:00'::timestamptz, '2025-11-29 16:25:00'::timestamptz, '2025-11-29 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-11-29 16:25:00'::timestamptz); END IF;

  -- CC3362
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 297;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3362', 'Jamal Jota', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavado de zapatilla  FE generada: FE0120000155737034-2-2023-3800002025120100000033621100121392136900, Fecha de autorización: 12/01/2025 5:52:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000105728', '2025-12-01 00:00:00'::timestamptz, '2025-12-03 16:22:00'::timestamptz, '2025-12-01 12:52:00'::timestamptz, '2025-12-01 12:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-01 12:52:00'::timestamptz); END IF;

  -- CC3363
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3363', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033631100125224901067, Fecha de autorización: 12/01/2025 6:15:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000105734', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 14:18:00'::timestamptz, '2025-12-01 13:15:00'::timestamptz, '2025-12-01 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-01 13:15:00'::timestamptz); END IF;

  -- CC3364
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3364', 'Leonel Visueti', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033641100124658736270, Fecha de autorización: 12/01/2025 6:16:06 p. m., Protocolo autorización 00001528364-1-65300620250000000000105735', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 13:17:00'::timestamptz, '2025-12-01 13:16:00'::timestamptz, '2025-12-01 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-12-01 13:16:00'::timestamptz); END IF;

  -- CC3365
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 279;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3365', 'Jose Ramires', false, 'completed', false, 21.03, 0.00, 0, 1.47, 22.50, 9.00, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120100000033651100126739066444, Fecha de autorización: 12/01/2025 7:09:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000105756', '2025-12-01 00:00:00'::timestamptz, '2025-12-05 13:35:00'::timestamptz, '2025-12-01 14:09:00'::timestamptz, '2025-12-01 14:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 22.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 22.50, '2025-12-01 14:09:00'::timestamptz); END IF;

  -- CC3366
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3366', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033661100126298616547, Fecha de autorización: 12/01/2025 7:17:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000105761', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 14:18:00'::timestamptz, '2025-12-01 14:17:00'::timestamptz, '2025-12-01 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-01 14:17:00'::timestamptz); END IF;

  -- CC3367
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3367', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033671100120905375505, Fecha de autorización: 12/01/2025 9:06:57 p. m., Protocolo autorización 00001528364-1-65300620250000000000105793', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:07:00'::timestamptz, '2025-12-01 16:06:00'::timestamptz, '2025-12-01 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-01 16:06:00'::timestamptz); END IF;

  -- CC3368
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3368', 'Leonel Visueti', false, 'completed', false, 7.61, 0.00, 0, 0.39, 8.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033681100128620080572, Fecha de autorización: 12/01/2025 9:24:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000105799', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:38:00'::timestamptz, '2025-12-01 16:23:00'::timestamptz, '2025-12-01 16:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-12-01 16:23:00'::timestamptz); END IF;

  -- CC3369
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3369', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033691100120695449641, Fecha de autorización: 12/01/2025 9:25:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000105800', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:38:00'::timestamptz, '2025-12-01 16:25:00'::timestamptz, '2025-12-01 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-01 16:25:00'::timestamptz); END IF;

  -- CC3370
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3370', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033701100226819349380, Fecha de autorización: 12/01/2025 9:27:49 p. m., Protocolo autorización ', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:27:00'::timestamptz, '2025-12-01 16:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-01 16:27:00'::timestamptz); END IF;

  -- CC3371
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3371', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025120100000033711100226141817814, Fecha de autorización: 12/01/2025 9:28:34 p. m., Protocolo autorización ', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:28:00'::timestamptz, '2025-12-01 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-01 16:28:00'::timestamptz); END IF;

  -- CC3372
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3372', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '', '2025-12-01 00:00:00'::timestamptz, '2025-12-01 00:00:00'::timestamptz, '2025-12-01 16:29:00'::timestamptz, '2025-12-01 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-12-01 16:29:00'::timestamptz); END IF;

  -- CC3373
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3373', 'Paula Perez', false, 'completed', false, 28.50, 0.00, 0, 2.00, 30.50, 3.20, 1, 13, 'lavanderia', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 11:35:00'::timestamptz, '2025-12-02 10:11:00'::timestamptz, '2025-12-02 10:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 30.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 30.50, '2025-12-02 10:11:00'::timestamptz); END IF;

  -- CC3374
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3374', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120200000033741100128763378107, Fecha de autorización: 12/02/2025 3:15:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000105915', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 11:35:00'::timestamptz, '2025-12-02 10:15:00'::timestamptz, '2025-12-02 10:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-02 10:15:00'::timestamptz); END IF;

  -- CC3375
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3375', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025120200000033751100121213568160, Fecha de autorización: 12/02/2025 4:11:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000105945', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 11:35:00'::timestamptz, '2025-12-02 11:11:00'::timestamptz, '2025-12-02 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-02 11:11:00'::timestamptz); END IF;

  -- CC3376
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 285;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3376', 'Dilia Valdes', false, 'completed', false, 24.30, 0.00, 0, 1.70, 26.00, 10.40, 2, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120200000033761100125280401477, Fecha de autorización: 12/02/2025 4:29:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000105959', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 16:45:00'::timestamptz, '2025-12-02 11:29:00'::timestamptz, '2025-12-02 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 26.00, '2025-12-02 11:29:00'::timestamptz); END IF;

  -- CC3377
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 298;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3377', 'Derissa Simons', false, 'completed', false, 47.90, 0.00, 0, 3.35, 51.25, 12.90, 2, 7, 'lava y dobla  FE generada: FE0120000155737034-2-2023-3800002025120200000033771100126603814098, Fecha de autorización: 12/02/2025 6:11:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000106023', '2025-12-02 00:00:00'::timestamptz, '2025-12-03 18:02:00'::timestamptz, '2025-12-02 13:11:00'::timestamptz, '2025-12-02 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 51.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 51.25, '2025-12-02 13:11:00'::timestamptz); END IF;

  -- CC3378
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3378', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025120200000033781100123309243283, Fecha de autorización: 12/02/2025 6:44:35 p. m., Protocolo autorización 00001528364-1-65300620250000000000106042', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 14:32:00'::timestamptz, '2025-12-02 13:44:00'::timestamptz, '2025-12-02 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-02 13:44:00'::timestamptz); END IF;

  -- CC3379
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3379', 'Sandra Medina', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '0  FE generada: FE0120000155737034-2-2023-3800002025120200000033791100128337686634, Fecha de autorización: 12/02/2025 6:45:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000106043', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 14:32:00'::timestamptz, '2025-12-02 13:45:00'::timestamptz, '2025-12-02 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-12-02 13:45:00'::timestamptz); END IF;

  -- CC3380
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3380', 'Aaron Gutierrez', false, 'completed', false, 7.48, 2.00, 0, 0.52, 8.00, 0.00, 0, 5, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120200000033801100120293071973, Fecha de autorización: 12/02/2025 7:31:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000106058', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 14:32:00'::timestamptz, '2025-12-02 14:31:00'::timestamptz, '2025-12-02 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-02 14:31:00'::timestamptz); END IF;

  -- CC3381
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3381', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120200000033811100126511906212, Fecha de autorización: 12/02/2025 8:39:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000106086', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 15:40:00'::timestamptz, '2025-12-02 15:39:00'::timestamptz, '2025-12-02 15:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-02 15:39:00'::timestamptz); END IF;

  -- CC3382
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3382', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120200000033821100125489773314, Fecha de autorización: 12/02/2025 8:42:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000106087', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 00:00:00'::timestamptz, '2025-12-02 15:42:00'::timestamptz, '2025-12-02 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-12-02 15:42:00'::timestamptz); END IF;

  -- CC3383
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3383', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025120200000033831100125702813094, Fecha de autorización: 12/02/2025 9:44:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000107044', '2025-12-02 00:00:00'::timestamptz, '2025-12-02 16:45:00'::timestamptz, '2025-12-02 16:44:00'::timestamptz, '2025-12-02 16:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-02 16:44:00'::timestamptz); END IF;

  -- CC3384
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3384', 'Leonel Visueti', false, 'completed', false, 21.06, 0.00, 0, 1.44, 22.50, 0.00, 0, 12, '  FE generada: FE0120000155737034-2-2023-3800002025120300000033841100123907296429, Fecha de autorización: 12/03/2025 3:34:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000107159', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 12:51:00'::timestamptz, '2025-12-03 10:34:00'::timestamptz, '2025-12-03 10:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 22.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 22.50, '2025-12-03 10:34:00'::timestamptz); END IF;

  -- CC3385
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3385', 'Maribel Carruyo', false, 'completed', false, 9.85, 0.00, 0, 0.65, 10.50, 0.00, 0, 6, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033851100122105248330, Fecha de autorización: 12/03/2025 3:51:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000107170', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 12:51:00'::timestamptz, '2025-12-03 10:51:00'::timestamptz, '2025-12-03 10:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-12-03 10:51:00'::timestamptz); END IF;

  -- CC3386
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 197;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3386', 'Josue Rosales', false, 'completed', false, 7.54, 0.00, 0, 0.46, 8.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033861100121847973287, Fecha de autorización: 12/03/2025 5:49:28 p. m., Protocolo autorización 00001528364-1-65300620250000000000107213', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 16:22:00'::timestamptz, '2025-12-03 12:49:00'::timestamptz, '2025-12-03 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-03 12:49:00'::timestamptz); END IF;

  -- CC3387
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3387', 'Fernando Rios', false, 'completed', false, 10.75, 0.00, 0, 0.75, 11.50, 4.20, 2, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033871100121603570912, Fecha de autorización: 12/03/2025 6:14:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000107221', '2025-12-03 00:00:00'::timestamptz, '2025-12-05 13:35:00'::timestamptz, '2025-12-03 13:14:00'::timestamptz, '2025-12-03 13:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.50, '2025-12-03 13:14:00'::timestamptz); END IF;

  -- CC3388
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 189;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3388', 'Liz Martinez', false, 'completed', false, 16.95, 0.00, 0, 1.05, 18.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033881100126937447231, Fecha de autorización: 12/03/2025 7:26:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000107244', '2025-12-04 00:00:00'::timestamptz, '2025-12-11 15:27:00'::timestamptz, '2025-12-03 14:25:00'::timestamptz, '2025-12-03 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-12-03 14:25:00'::timestamptz); END IF;

  -- CC3389
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3389', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033891100127428109735, Fecha de autorización: 12/03/2025 8:35:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000107279', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 16:22:00'::timestamptz, '2025-12-03 15:35:00'::timestamptz, '2025-12-03 15:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-03 15:35:00'::timestamptz); END IF;

  -- CC3390
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3390', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025120300000033901100122660921621, Fecha de autorización: 12/03/2025 9:36:43 p. m., Protocolo autorización 00001528364-1-65300620250000000000107314', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 17:11:00'::timestamptz, '2025-12-03 16:36:00'::timestamptz, '2025-12-03 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-03 16:36:00'::timestamptz); END IF;

  -- CC3391
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3391', 'Retail', true, 'completed', false, 2.50, 0.00, 0, 0.00, 2.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025120300000033911100124917954073, Fecha de autorización: 12/03/2025 9:38:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000107315', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 00:00:00'::timestamptz, '2025-12-03 16:38:00'::timestamptz, '2025-12-03 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-12-03 16:38:00'::timestamptz); END IF;

  -- CC3392
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3392', 'Julissa Rivera', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.40, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120300000033921100125251386920, Fecha de autorización: 12/03/2025 9:41:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000107317', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 16:48:00'::timestamptz, '2025-12-03 16:41:00'::timestamptz, '2025-12-03 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-12-03 16:41:00'::timestamptz); END IF;

  -- CC3393
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3393', 'Leonel Visueti', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120300000033931100124614427777, Fecha de autorización: 12/03/2025 9:55:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000107323', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 17:11:00'::timestamptz, '2025-12-03 16:55:00'::timestamptz, '2025-12-03 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-12-03 16:55:00'::timestamptz); END IF;

  -- CC3394
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3394', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025120300000033941100122317553187, Fecha de autorización: 12/03/2025 9:56:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000107324', '2025-12-03 00:00:00'::timestamptz, '2025-12-03 17:11:00'::timestamptz, '2025-12-03 16:56:00'::timestamptz, '2025-12-03 16:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-03 16:56:00'::timestamptz); END IF;

  -- CC3395
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 298;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3395', 'Derissa Simons', false, 'completed', false, 10.28, 0.00, 0, 0.72, 11.00, 4.40, 1, 1, 'lava y dobla  FE generada: FE0120000155737034-2-2023-3800002025120400000033951100126455119303, Fecha de autorización: 12/04/2025 2:50:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000107509', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 10:00:00'::timestamptz, '2025-12-04 09:50:00'::timestamptz, '2025-12-04 09:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-12-04 09:50:00'::timestamptz); END IF;

  -- CC3396
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 215;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3396', 'Arturo Martinez', false, 'completed', false, 22.56, 0.00, 0, 1.44, 24.00, 0.00, 0, 5, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120400000033961100127990208048, Fecha de autorización: 12/04/2025 4:46:53 p. m., Protocolo autorización 00001528364-1-65300620250000000000107573', '2025-12-04 00:00:00'::timestamptz, '2025-12-24 11:57:00'::timestamptz, '2025-12-04 11:46:00'::timestamptz, '2025-12-04 11:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.00, '2025-12-04 11:46:00'::timestamptz); END IF;

  -- CC3397
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3397', 'German Alveo', false, 'completed', false, 69.56, 0.00, 0, 4.87, 74.43, 28.40, 9, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120400000033971100125667783193, Fecha de autorización: 12/04/2025 7:28:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000108876', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 14:42:00'::timestamptz, '2025-12-04 14:28:00'::timestamptz, '2025-12-04 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 74.43 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 74.43, '2025-12-04 14:28:00'::timestamptz); END IF;

  -- CC3398
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3398', 'Retail', true, 'completed', false, 3.00, 0.00, 0, 0.00, 3.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120400000033981100125327127335, Fecha de autorización: 12/04/2025 7:54:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000108897', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 00:00:00'::timestamptz, '2025-12-04 14:54:00'::timestamptz, '2025-12-04 14:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-12-04 14:54:00'::timestamptz); END IF;

  -- CC3399
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3399', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120400000033991100124311695950, Fecha de autorización: 12/04/2025 7:55:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000108899', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 14:56:00'::timestamptz, '2025-12-04 14:55:00'::timestamptz, '2025-12-04 14:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-04 14:55:00'::timestamptz); END IF;

  -- CC3400
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3400', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120400000034001100129857983618, Fecha de autorización: 12/04/2025 7:56:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000108901', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 00:00:00'::timestamptz, '2025-12-04 14:56:00'::timestamptz, '2025-12-04 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-04 14:56:00'::timestamptz); END IF;

  -- CC3401
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 184;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3401', 'La Barberia', false, 'completed', false, 9.11, 0.00, 0, 0.64, 9.75, 3.90, 1, 1, 'lavanderia', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 16:20:00'::timestamptz, '2025-12-04 16:06:00'::timestamptz, '2025-12-04 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.75, '2025-12-04 16:06:00'::timestamptz); END IF;

  -- CC3402
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3402', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120400000034021100129204503968, Fecha de autorización: 12/04/2025 9:18:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000108919', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 16:20:00'::timestamptz, '2025-12-04 16:18:00'::timestamptz, '2025-12-04 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-04 16:18:00'::timestamptz); END IF;

  -- CC3403
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3403', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120400000034031100129203817186, Fecha de autorización: 12/04/2025 9:20:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000108921', '2025-12-04 00:00:00'::timestamptz, '2025-12-04 16:20:00'::timestamptz, '2025-12-04 16:20:00'::timestamptz, '2025-12-04 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-04 16:20:00'::timestamptz); END IF;

  -- CC3404
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3404', 'Leonel Visueti', false, 'completed', false, 2.87, 0.00, 0, 0.13, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034041100126827777257, Fecha de autorización: 12/05/2025 3:20:36 p. m., Protocolo autorización 00001528364-1-65300620250000000000109130', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 13:35:00'::timestamptz, '2025-12-05 10:20:00'::timestamptz, '2025-12-05 10:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-12-05 10:20:00'::timestamptz); END IF;

  -- CC3405
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3405', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034051100128909200926, Fecha de autorización: 12/05/2025 3:21:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000109131', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 13:35:00'::timestamptz, '2025-12-05 10:21:00'::timestamptz, '2025-12-05 10:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-05 10:21:00'::timestamptz); END IF;

  -- CC3406
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3406', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034061100120468906083, Fecha de autorización: 12/05/2025 5:49:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000109165', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 13:34:00'::timestamptz, '2025-12-05 12:49:00'::timestamptz, '2025-12-05 12:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-05 12:49:00'::timestamptz); END IF;

  -- CC3407
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3407', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 3, '', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 00:00:00'::timestamptz, '2025-12-05 12:50:00'::timestamptz, '2025-12-05 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-12-05 12:50:00'::timestamptz); END IF;

  -- CC3408
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3408', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034081100127802172890, Fecha de autorización: 12/05/2025 5:51:11 p. m., Protocolo autorización 00001528364-1-65300620250000000000109167', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 00:00:00'::timestamptz, '2025-12-05 12:51:00'::timestamptz, '2025-12-05 12:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-05 12:51:00'::timestamptz); END IF;

  -- CC3409
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3409', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034091100124909173805, Fecha de autorización: 12/05/2025 6:29:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000109187', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 13:34:00'::timestamptz, '2025-12-05 13:29:00'::timestamptz, '2025-12-05 13:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-05 13:29:00'::timestamptz); END IF;

  -- CC3410
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3410', 'Fany Luz Salon', false, 'completed', false, 7.24, 0.00, 0, 0.26, 7.50, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034101100126809111113, Fecha de autorización: 12/05/2025 6:53:58 p. m., Protocolo autorización 00001528364-1-65300620250000000000109199', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 13:55:00'::timestamptz, '2025-12-05 13:53:00'::timestamptz, '2025-12-05 13:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-12-05 13:53:00'::timestamptz); END IF;

  -- CC3411
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3411', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034111100123342643313, Fecha de autorización: 12/05/2025 7:56:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000109222', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 14:57:00'::timestamptz, '2025-12-05 14:56:00'::timestamptz, '2025-12-05 14:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-05 14:56:00'::timestamptz); END IF;

  -- CC3412
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 299;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3412', 'Dhalia Araujo', false, 'completed', false, 18.22, 0.00, 0, 1.28, 19.50, 3.40, 1, 5, 'Servicio completo de lavanderia', '2025-12-05 00:00:00'::timestamptz, '2025-12-06 09:14:00'::timestamptz, '2025-12-05 15:07:00'::timestamptz, '2025-12-05 15:07:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.50, '2025-12-05 15:07:00'::timestamptz); END IF;

  -- CC3413
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3413', 'Retail', true, 'completed', false, 1.75, 0.00, 0, 0.00, 1.75, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025120500000034131100126920101131, Fecha de autorización: 12/05/2025 9:52:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000109280', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 00:00:00'::timestamptz, '2025-12-05 16:52:00'::timestamptz, '2025-12-05 16:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.75, '2025-12-05 16:52:00'::timestamptz); END IF;

  -- CC3414
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3414', 'Leonel Visueti', false, 'completed', false, 31.43, 0.00, 0, 1.57, 33.00, 0.00, 0, 21, '', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 17:42:00'::timestamptz, '2025-12-05 17:18:00'::timestamptz, '2025-12-05 17:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 33.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 33.00, '2025-12-05 17:18:00'::timestamptz); END IF;

  -- CC3415
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3415', 'Yatzury Anderson', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 2.40, 1, 2, 'Lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120500000034151100125582003047, Fecha de autorización: 12/05/2025 10:39:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000109301', '2025-12-05 00:00:00'::timestamptz, '2025-12-05 17:42:00'::timestamptz, '2025-12-05 17:39:00'::timestamptz, '2025-12-05 17:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-12-05 17:39:00'::timestamptz); END IF;

  -- CC3416
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 180;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3416', 'Yariela Phillips', false, 'completed', false, 11.96, 0.00, 0, 0.79, 12.75, 0.00, 0, 9, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120600000034161100126054836243, Fecha de autorización: 12/06/2025 2:47:19 p. m., Protocolo autorización 00001528364-1-65300620250000000000109512', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 09:54:00'::timestamptz, '2025-12-06 09:47:00'::timestamptz, '2025-12-06 09:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.75, '2025-12-06 09:47:00'::timestamptz); END IF;

  -- CC3417
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3417', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120600000034171100124911626526, Fecha de autorización: 12/06/2025 2:53:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000109515', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 09:54:00'::timestamptz, '2025-12-06 09:53:00'::timestamptz, '2025-12-06 09:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-06 09:53:00'::timestamptz); END IF;

  -- CC3418
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3418', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025120600000034181100127953691083, Fecha de autorización: 12/06/2025 2:54:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000109516', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 09:55:00'::timestamptz, '2025-12-06 09:54:00'::timestamptz, '2025-12-06 09:54:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-06 09:54:00'::timestamptz); END IF;

  -- CC3419
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3419', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 11:11:00'::timestamptz, '2025-12-06 11:04:00'::timestamptz, '2025-12-06 11:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-12-06 11:04:00'::timestamptz); END IF;

  -- CC3420
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3420', 'Luis Carlos Arosema', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120600000034201100126050166664, Fecha de autorización: 12/06/2025 4:13:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000109546', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 11:17:00'::timestamptz, '2025-12-06 11:13:00'::timestamptz, '2025-12-06 11:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.00, '2025-12-06 11:13:00'::timestamptz); END IF;

  -- CC3421
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3421', 'Gustavo Cumbrera', false, 'completed', false, 13.31, 2.00, 0, 0.69, 14.00, 0.00, 0, 10, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120600000034211100124622504388, Fecha de autorización: 12/06/2025 4:52:40 p. m., Protocolo autorización 00001528364-1-65300620250000000000109570', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 11:58:00'::timestamptz, '2025-12-06 11:52:00'::timestamptz, '2025-12-06 11:52:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-12-06 11:52:00'::timestamptz); END IF;

  -- CC3422
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3422', 'Retail', true, 'completed', false, 0.70, 0.00, 0, 0.05, 0.75, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120600000034221100123142020114, Fecha de autorización: 12/06/2025 4:57:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000109573', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 00:00:00'::timestamptz, '2025-12-06 11:57:00'::timestamptz, '2025-12-06 11:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2025-12-06 11:57:00'::timestamptz); END IF;

  -- CC3423
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3423', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 16:35:00'::timestamptz, '2025-12-06 15:02:00'::timestamptz, '2025-12-06 15:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-06 15:02:00'::timestamptz); END IF;

  -- CC3424
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 51;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3424', 'Judy De Morales', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120600000034241100122172633208, Fecha de autorización: 12/06/2025 8:28:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000109681', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 15:43:00'::timestamptz, '2025-12-06 15:28:00'::timestamptz, '2025-12-06 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-06 15:28:00'::timestamptz); END IF;

  -- CC3425
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 26;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3425', 'Daniel Camarena', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '0  FE generada: FE0120000155737034-2-2023-3800002025120600000034251100125457558601, Fecha de autorización: 12/06/2025 8:42:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000109683', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 16:35:00'::timestamptz, '2025-12-06 15:42:00'::timestamptz, '2025-12-06 15:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-06 15:42:00'::timestamptz); END IF;

  -- CC3426
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3426', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025120600000034261100124378490696, Fecha de autorización: 12/06/2025 8:43:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000109684', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 00:00:00'::timestamptz, '2025-12-06 15:43:00'::timestamptz, '2025-12-06 15:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-12-06 15:43:00'::timestamptz); END IF;

  -- CC3427
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3427', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120600000034271100125141576678, Fecha de autorización: 12/06/2025 9:18:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000109690', '2025-12-06 00:00:00'::timestamptz, '2025-12-06 16:19:00'::timestamptz, '2025-12-06 16:18:00'::timestamptz, '2025-12-06 16:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-06 16:18:00'::timestamptz); END IF;

  -- CC3428
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3428', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025120900000034281100123348452054, Fecha de autorización: 12/09/2025 4:38:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000110170', '2025-12-09 00:00:00'::timestamptz, '2025-12-09 11:39:00'::timestamptz, '2025-12-09 11:38:00'::timestamptz, '2025-12-09 11:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-12-09 11:38:00'::timestamptz); END IF;

  -- CC3429
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3429', 'Aaron Gutierrez', false, 'completed', false, 11.35, 0.00, 0, 0.65, 12.00, 0.00, 0, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120900000034291100127433318202, Fecha de autorización: 12/09/2025 4:40:55 p. m., Protocolo autorización 00001528364-1-65300620250000000000110171', '2025-12-09 00:00:00'::timestamptz, '2025-12-09 11:41:00'::timestamptz, '2025-12-09 11:40:00'::timestamptz, '2025-12-09 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-12-09 11:40:00'::timestamptz); END IF;

  -- CC3430
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 295;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3430', 'Liselotte Salinas', false, 'completed', false, 45.33, 0.00, 0, 3.17, 48.50, 0.00, 0, 19, 'Servicio completo de lavanderia  FE generada: FE0120000155737034-2-2023-3800002025120900000034301100128581864903, Fecha de autorización: 12/09/2025 9:01:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000110254', '2025-12-09 00:00:00'::timestamptz, '2025-12-10 14:46:00'::timestamptz, '2025-12-09 16:01:00'::timestamptz, '2025-12-09 16:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 48.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 48.50, '2025-12-09 16:01:00'::timestamptz); END IF;

  -- CC3431
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3431', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025120900000034311100125368804887, Fecha de autorización: 12/09/2025 9:05:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000110257', '2025-12-09 00:00:00'::timestamptz, '2025-12-09 16:06:00'::timestamptz, '2025-12-09 16:05:00'::timestamptz, '2025-12-09 16:05:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-09 16:05:00'::timestamptz); END IF;

  -- CC3432
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3432', 'Renzo Mundo', false, 'completed', false, 2.34, 0.00, 0, 0.16, 2.50, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025120900000034321100123951010979, Fecha de autorización: 12/09/2025 9:08:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000110259', '2025-12-09 00:00:00'::timestamptz, '2025-12-09 16:10:00'::timestamptz, '2025-12-09 16:08:00'::timestamptz, '2025-12-09 16:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-12-09 16:08:00'::timestamptz); END IF;

  -- CC3433
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3433', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025120900000034331100123723036293, Fecha de autorización: 12/09/2025 9:09:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000110260', '2025-12-09 00:00:00'::timestamptz, '2025-12-09 16:09:00'::timestamptz, '2025-12-09 16:09:00'::timestamptz, '2025-12-09 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-09 16:09:00'::timestamptz); END IF;

  -- CC3434
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3434', 'Juan David VanSice', false, 'completed', false, 0.00, 15.50, 0, 0.00, 0.00, 6.20, 1, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 14:46:00'::timestamptz, '2025-12-10 09:38:00'::timestamptz, '2025-12-10 09:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-12-10 09:38:00'::timestamptz); END IF;

  -- CC3435
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3435', 'Karla Garibaldi', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121000000034351100122591415501, Fecha de autorización: 12/10/2025 7:24:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000110560', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 14:46:00'::timestamptz, '2025-12-10 14:24:00'::timestamptz, '2025-12-10 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-10 14:24:00'::timestamptz); END IF;

  -- CC3436
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3436', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121000000034361100125165011878, Fecha de autorización: 12/10/2025 7:25:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000110561', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 14:46:00'::timestamptz, '2025-12-10 14:25:00'::timestamptz, '2025-12-10 14:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-10 14:25:00'::timestamptz); END IF;

  -- CC3437
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 226;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3437', 'Renato Mejia', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 20, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121000000034371100125130944632, Fecha de autorización: 12/10/2025 9:26:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000110610', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 16:37:00'::timestamptz, '2025-12-10 16:25:00'::timestamptz, '2025-12-10 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-10 16:25:00'::timestamptz); END IF;

  -- CC3438
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3438', 'Karla Garibaldi', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121000000034381100121622788693, Fecha de autorización: 12/10/2025 9:38:40 p. m., Protocolo autorización 00001528364-1-65300620250000000000110617', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 16:40:00'::timestamptz, '2025-12-10 16:38:00'::timestamptz, '2025-12-10 16:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.50, '2025-12-10 16:38:00'::timestamptz); END IF;

  -- CC3439
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3439', 'Evelyn', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025121000000034391100122471295219, Fecha de autorización: 12/10/2025 9:39:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000110618', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 16:40:00'::timestamptz, '2025-12-10 16:39:00'::timestamptz, '2025-12-10 16:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-12-10 16:39:00'::timestamptz); END IF;

  -- CC3440
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3440', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121000000034401100120831813678, Fecha de autorización: 12/10/2025 9:41:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000110620', '2025-12-10 00:00:00'::timestamptz, '2025-12-10 00:00:00'::timestamptz, '2025-12-10 16:41:00'::timestamptz, '2025-12-10 16:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-12-10 16:41:00'::timestamptz); END IF;

  -- CC3441
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3441', 'Tairis - Diego', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121100000034411100120424822167, Fecha de autorización: 12/11/2025 5:02:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000110841', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 12:05:00'::timestamptz, '2025-12-11 12:02:00'::timestamptz, '2025-12-11 12:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.00, '2025-12-11 12:02:00'::timestamptz); END IF;

  -- CC3442
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3442', 'Nicole Flores', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121100000034421100123315779529, Fecha de autorización: 12/11/2025 5:02:53 p. m., Protocolo autorización 00001528364-1-65300620250000000000110842', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 12:06:00'::timestamptz, '2025-12-11 12:02:00'::timestamptz, '2025-12-11 12:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-12-11 12:02:00'::timestamptz); END IF;

  -- CC3443
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3443', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121100000034431100121249221492, Fecha de autorización: 12/11/2025 5:03:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000110843', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 12:05:00'::timestamptz, '2025-12-11 12:03:00'::timestamptz, '2025-12-11 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-11 12:03:00'::timestamptz); END IF;

  -- CC3444
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3444', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 12:06:00'::timestamptz, '2025-12-11 12:04:00'::timestamptz, '2025-12-11 12:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-11 12:04:00'::timestamptz); END IF;

  -- CC3445
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3445', 'German Alveo', false, 'completed', false, 41.12, 0.00, 0, 2.88, 44.00, 17.60, 5, 1, 'Lavandería', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 15:27:00'::timestamptz, '2025-12-11 12:30:00'::timestamptz, '2025-12-11 12:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 44.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 44.00, '2025-12-11 12:30:00'::timestamptz); END IF;

  -- CC3446
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3446', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121100000034461100124043892150, Fecha de autorización: 12/11/2025 8:28:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000110970', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 16:45:00'::timestamptz, '2025-12-11 15:27:00'::timestamptz, '2025-12-11 15:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-11 15:27:00'::timestamptz); END IF;

  -- CC3447
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 155;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3447', 'Julissa', false, 'completed', false, 9.94, 0.00, 0, 0.56, 10.50, 3.40, 2, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121100000034471100129062941662, Fecha de autorización: 12/11/2025 9:29:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000110994', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 16:45:00'::timestamptz, '2025-12-11 16:29:00'::timestamptz, '2025-12-11 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-12-11 16:29:00'::timestamptz); END IF;

  -- CC3448
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 37;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3448', 'Fernando Ortega', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '', '2025-12-11 00:00:00'::timestamptz, '2025-12-11 16:45:00'::timestamptz, '2025-12-11 16:30:00'::timestamptz, '2025-12-11 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-12-11 16:30:00'::timestamptz); END IF;

  -- CC3449
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3449', 'Paula Perez', false, 'completed', false, 28.22, 0.00, 0, 1.91, 30.13, 2.65, 1, 14, 'lavanderia', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 16:45:00'::timestamptz, '2025-12-12 09:35:00'::timestamptz, '2025-12-12 09:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.13, '2025-12-12 09:35:00'::timestamptz); END IF;

  -- CC3450
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 111;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3450', 'Academia Jireh', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, '0  FE generada: FE0120000155737034-2-2023-3800002025121200000034501100121594983380, Fecha de autorización: 12/12/2025 3:15:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000111188', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 10:28:00'::timestamptz, '2025-12-12 10:14:00'::timestamptz, '2025-12-12 10:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-12 10:14:00'::timestamptz); END IF;

  -- CC3451
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3451', 'Tairis - Diego', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034511100128354414364, Fecha de autorización: 12/12/2025 3:27:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000111192', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 10:28:00'::timestamptz, '2025-12-12 10:27:00'::timestamptz, '2025-12-12 10:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-12 10:27:00'::timestamptz); END IF;

  -- CC3452
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 252;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3452', 'Maribel Carruyo', false, 'completed', false, 11.71, 0.00, 0, 0.79, 12.50, 0.00, 0, 7, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121200000034521100126293244800, Fecha de autorización: 12/12/2025 3:59:15 p. m., Protocolo autorización 00001528364-1-65300620250000000000111200', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 12:14:00'::timestamptz, '2025-12-12 10:59:00'::timestamptz, '2025-12-12 10:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.50, '2025-12-12 10:59:00'::timestamptz); END IF;

  -- CC3453
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3453', 'Leonel Visueti', false, 'completed', false, 5.74, 0.00, 0, 0.26, 6.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034531100123765037100, Fecha de autorización: 12/12/2025 4:02:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000111204', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 11:03:00'::timestamptz, '2025-12-12 11:02:00'::timestamptz, '2025-12-12 11:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-12 11:02:00'::timestamptz); END IF;

  -- CC3454
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 300;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3454', 'Iraima Maradey', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'Servicio de lavanderia', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 14:38:00'::timestamptz, '2025-12-12 11:24:00'::timestamptz, '2025-12-12 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-12 11:24:00'::timestamptz); END IF;

  -- CC3455
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 274;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3455', 'Flor De Rey', false, 'completed', false, 22.64, 0.00, 0, 1.31, 23.95, 0.00, 0, 21, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034551100121394594333, Fecha de autorización: 12/12/2025 5:14:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000111245', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 12:47:00'::timestamptz, '2025-12-12 12:14:00'::timestamptz, '2025-12-12 12:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 23.95 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 23.95, '2025-12-12 12:14:00'::timestamptz); END IF;

  -- CC3456
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3456', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034561100123879963602, Fecha de autorización: 12/12/2025 5:17:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000111246', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 12:47:00'::timestamptz, '2025-12-12 12:17:00'::timestamptz, '2025-12-12 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-12 12:17:00'::timestamptz); END IF;

  -- CC3457
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 274;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3457', 'Flor De Rey', false, 'completed', false, 1.82, 0.00, 0, 0.13, 1.95, 0.00, 0, 13, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034571100123119161321, Fecha de autorización: 12/12/2025 6:00:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000111268', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 13:00:00'::timestamptz, '2025-12-12 13:00:00'::timestamptz, '2025-12-12 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 1.95 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 1.95, '2025-12-12 13:00:00'::timestamptz); END IF;

  -- CC3458
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3458', 'Fany Luz Salon', false, 'completed', false, 7.24, 0.00, 0, 0.26, 7.50, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034581100120952599731, Fecha de autorización: 12/12/2025 7:37:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000111307', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 17:03:00'::timestamptz, '2025-12-12 14:37:00'::timestamptz, '2025-12-12 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-12-12 14:37:00'::timestamptz); END IF;

  -- CC3459
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3459', 'Leonardo Salon', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034591100124935071593, Fecha de autorización: 12/12/2025 8:28:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000111332', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 17:03:00'::timestamptz, '2025-12-12 15:28:00'::timestamptz, '2025-12-12 15:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-12-12 15:28:00'::timestamptz); END IF;

  -- CC3460
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3460', 'Leonel Visueti', false, 'completed', false, 2.34, 0.00, 0, 0.16, 2.50, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034601100129361783154, Fecha de autorización: 12/12/2025 9:46:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000111357', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 17:02:00'::timestamptz, '2025-12-12 16:46:00'::timestamptz, '2025-12-12 16:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2025-12-12 16:46:00'::timestamptz); END IF;

  -- CC3461
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3461', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121200000034611100127572995053, Fecha de autorización: 12/12/2025 9:47:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000111358', '2025-12-12 00:00:00'::timestamptz, '2025-12-12 00:00:00'::timestamptz, '2025-12-12 16:47:00'::timestamptz, '2025-12-12 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-12-12 16:47:00'::timestamptz); END IF;

  -- CC3462
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 279;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3462', 'Jose Ramires', false, 'completed', false, 15.21, 0.00, 0, 0.79, 16.00, 0.00, 0, 6, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034621100125738398111, Fecha de autorización: 12/13/2025 1:42:19 p. m., Protocolo autorización 00001528364-1-65300620250000000000111510', '2025-12-13 00:00:00'::timestamptz, '2025-12-19 13:09:00'::timestamptz, '2025-12-13 08:42:00'::timestamptz, '2025-12-13 08:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 16.00, '2025-12-13 08:42:00'::timestamptz); END IF;

  -- CC3463
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3463', 'Alvaro Martinez @', false, 'completed', false, 26.17, 0.00, 0, 1.83, 28.00, 11.20, 2, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034631100122812170200, Fecha de autorización: 12/13/2025 2:28:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000111525', '2025-12-13 00:00:00'::timestamptz, '2025-12-15 17:26:00'::timestamptz, '2025-12-13 09:28:00'::timestamptz, '2025-12-13 09:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.00, '2025-12-13 09:28:00'::timestamptz); END IF;

  -- CC3464
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3464', 'Leonel Willson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034641100121364553721, Fecha de autorización: 12/13/2025 2:59:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000111545', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 09:59:00'::timestamptz, '2025-12-13 09:59:00'::timestamptz, '2025-12-13 09:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-13 09:59:00'::timestamptz); END IF;

  -- CC3465
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3465', 'Leonel Visueti', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034651100121491502640, Fecha de autorización: 12/13/2025 4:17:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000111579', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 11:17:00'::timestamptz, '2025-12-13 11:17:00'::timestamptz, '2025-12-13 11:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2025-12-13 11:17:00'::timestamptz); END IF;

  -- CC3466
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 301;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3466', 'Hair Colors Salon', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034661100128604492576, Fecha de autorización: 12/13/2025 4:20:27 p. m., Protocolo autorización 00001528364-1-65300620250000000000111581', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 13:39:00'::timestamptz, '2025-12-13 11:20:00'::timestamptz, '2025-12-13 11:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-13 11:20:00'::timestamptz); END IF;

  -- CC3467
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3467', 'German Alveo', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 4.00, 2, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121300000034671100124519951334, Fecha de autorización: 12/13/2025 8:42:24 p. m., Protocolo autorización 00001528364-1-65300620250000000000111703', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 15:42:00'::timestamptz, '2025-12-13 11:29:00'::timestamptz, '2025-12-13 11:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-12-13 11:29:00'::timestamptz); END IF;

  -- CC3468
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3468', 'Gustavo Cumbrera', false, 'completed', false, 13.08, 2.00, 0, 0.92, 14.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034681100121800467532, Fecha de autorización: 12/13/2025 5:17:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000111611', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 12:18:00'::timestamptz, '2025-12-13 12:17:00'::timestamptz, '2025-12-13 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-12-13 12:17:00'::timestamptz); END IF;

  -- CC3469
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3469', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034691100125501206072, Fecha de autorización: 12/13/2025 5:34:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000111616', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 13:39:00'::timestamptz, '2025-12-13 12:34:00'::timestamptz, '2025-12-13 12:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-13 12:34:00'::timestamptz); END IF;

  -- CC3470
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3470', 'Yatzury Anderson', false, 'completed', false, 26.56, 0.00, 0, 1.44, 28.00, 0.00, 0, 17, 'Lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034701100122869377527, Fecha de autorización: 12/13/2025 6:37:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000111654', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 13:39:00'::timestamptz, '2025-12-13 13:37:00'::timestamptz, '2025-12-13 13:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 28.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 28.00, '2025-12-13 13:37:00'::timestamptz); END IF;

  -- CC3471
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 302;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3471', 'Elio Thyme', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034711100120665636178, Fecha de autorización: 12/13/2025 8:40:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000111700', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 15:42:00'::timestamptz, '2025-12-13 15:40:00'::timestamptz, '2025-12-13 15:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-13 15:40:00'::timestamptz); END IF;

  -- CC3472
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 213;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3472', 'Fabio Nunez', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121300000034721100127482871655, Fecha de autorización: 12/13/2025 8:46:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000111705', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 16:43:00'::timestamptz, '2025-12-13 15:46:00'::timestamptz, '2025-12-13 15:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-12-13 15:46:00'::timestamptz); END IF;

  -- CC3473
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3473', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034731100126855220929, Fecha de autorización: 12/13/2025 8:51:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000111708', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 16:43:00'::timestamptz, '2025-12-13 15:51:00'::timestamptz, '2025-12-13 15:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-13 15:51:00'::timestamptz); END IF;

  -- CC3474
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3474', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034741100122141309815, Fecha de autorización: 12/13/2025 8:56:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000111710', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 16:43:00'::timestamptz, '2025-12-13 15:56:00'::timestamptz, '2025-12-13 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-13 15:56:00'::timestamptz); END IF;

  -- CC3475
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3475', 'Retail', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034751100126655991420, Fecha de autorización: 12/13/2025 8:57:12 p. m., Protocolo autorización 00001528364-1-65300620250000000000111711', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 00:00:00'::timestamptz, '2025-12-13 15:56:00'::timestamptz, '2025-12-13 15:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-13 15:56:00'::timestamptz); END IF;

  -- CC3476
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3476', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034761100126401918437, Fecha de autorización: 12/13/2025 8:57:58 p. m., Protocolo autorización 00001528364-1-65300620250000000000111712', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 00:00:00'::timestamptz, '2025-12-13 15:57:00'::timestamptz, '2025-12-13 15:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-13 15:57:00'::timestamptz); END IF;

  -- CC3477
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3477', 'Karla Garibaldi', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121300000034771100121950823608, Fecha de autorización: 12/13/2025 9:10:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000111718', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 16:43:00'::timestamptz, '2025-12-13 16:10:00'::timestamptz, '2025-12-13 16:10:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-13 16:10:00'::timestamptz); END IF;

  -- CC3478
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3478', 'Leonel Visueti', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 10, '  FE generada: FE0120000155737034-2-2023-3800002025121300000034781100124195298478, Fecha de autorización: 12/13/2025 9:20:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000111720', '2025-12-13 00:00:00'::timestamptz, '2025-12-13 16:43:00'::timestamptz, '2025-12-13 16:20:00'::timestamptz, '2025-12-13 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 15.00, '2025-12-13 16:20:00'::timestamptz); END IF;

  -- CC3479
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3479', 'Juan David VanSice', false, 'washing', false, 9.47, 0.00, 0, 0.66, 10.13, 4.05, 3, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante  FE generada: FE0120000155737034-2-2023-3800002025121400000034791100128419352795, Fecha de autorización: 12/14/2025 9:26:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000111985', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 00:00:00'::timestamptz, '2025-12-14 16:26:00'::timestamptz, '2025-12-14 16:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.13 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.13, '2025-12-14 16:26:00'::timestamptz); END IF;

  -- CC3480
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3480', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034801100123826257774, Fecha de autorización: 12/15/2025 10:25:15 p. m., Protocolo autorización 00001528364-1-65300620250000000000112271', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:26:00'::timestamptz, '2025-12-15 17:25:00'::timestamptz, '2025-12-15 17:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-15 17:25:00'::timestamptz); END IF;

  -- CC3481
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3481', 'Leonel Visueti', false, 'completed', false, 33.04, 0.00, 0, 1.96, 35.00, 0.00, 0, 17, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034811100121388493372, Fecha de autorización: 12/15/2025 10:28:15 p. m., Protocolo autorización 00001528364-1-65300620250000000000112272', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:28:00'::timestamptz, '2025-12-15 17:28:00'::timestamptz, '2025-12-15 17:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.00, '2025-12-15 17:28:00'::timestamptz); END IF;

  -- CC3482
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3482', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034821100122839807664, Fecha de autorización: 12/15/2025 10:29:01 p. m., Protocolo autorización 00001528364-1-65300620250000000000112274', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:29:00'::timestamptz, '2025-12-15 17:28:00'::timestamptz, '2025-12-15 17:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-15 17:28:00'::timestamptz); END IF;

  -- CC3483
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3483', 'Oscar Oropeza', false, 'completed', false, 29.91, 4.00, 0, 2.09, 32.00, 0.00, 0, 18, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121500000034831100120302161303, Fecha de autorización: 12/15/2025 10:30:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000112276', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:32:00'::timestamptz, '2025-12-15 17:30:00'::timestamptz, '2025-12-15 17:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 32.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 32.00, '2025-12-15 17:30:00'::timestamptz); END IF;

  -- CC3484
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 195;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3484', 'Byron Moreno', false, 'completed', false, 13.25, 0.00, 0, 0.93, 14.18, 8.10, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121500000034841100124073018550, Fecha de autorización: 12/15/2025 10:33:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000112281', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:33:00'::timestamptz, '2025-12-15 17:32:00'::timestamptz, '2025-12-15 17:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.18 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.18, '2025-12-15 17:32:00'::timestamptz); END IF;

  -- CC3485
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3485', 'Leonel Visueti', false, 'completed', false, 10.35, 0.00, 0, 0.65, 11.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034851100126470874476, Fecha de autorización: 12/15/2025 10:37:35 p. m., Protocolo autorización 00001528364-1-65300620250000000000112284', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:42:00'::timestamptz, '2025-12-15 17:37:00'::timestamptz, '2025-12-15 17:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-12-15 17:37:00'::timestamptz); END IF;

  -- CC3486
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3486', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034861100125004729775, Fecha de autorización: 12/15/2025 10:39:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000112287', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:42:00'::timestamptz, '2025-12-15 17:39:00'::timestamptz, '2025-12-15 17:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-15 17:39:00'::timestamptz); END IF;

  -- CC3487
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3487', 'Aaron Gutierrez', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121500000034871100123999876130, Fecha de autorización: 12/15/2025 10:42:04 p. m., Protocolo autorización 00001528364-1-65300620250000000000112288', '2025-12-15 00:00:00'::timestamptz, '2025-12-15 17:42:00'::timestamptz, '2025-12-15 17:41:00'::timestamptz, '2025-12-15 17:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-15 17:41:00'::timestamptz); END IF;

  -- CC3488
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3488', 'Fany Luz Salon', false, 'completed', false, 7.24, 0.00, 0, 0.26, 7.50, 0.00, 0, 7, '  FE generada: FE0120000155737034-2-2023-3800002025121500000034881100128572731775, Fecha de autorización: 12/15/2025 10:48:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000112291', '2025-12-15 00:00:00'::timestamptz, '2025-12-16 15:09:00'::timestamptz, '2025-12-15 17:48:00'::timestamptz, '2025-12-15 17:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 7.50, '2025-12-15 17:48:00'::timestamptz); END IF;

  -- CC3489
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 303;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3489', 'Rafael Fernamdez', false, 'completed', false, 151.92, 0.00, 0, 9.58, 161.50, 52.60, 8, 22, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121600000034891100127138448229, Fecha de autorización: 12/16/2025 9:24:26 p. m., Protocolo autorización 00001528364-1-65300620250000000000112535', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 16:24:00'::timestamptz, '2025-12-16 11:24:00'::timestamptz, '2025-12-16 11:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 161.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 161.50, '2025-12-16 11:24:00'::timestamptz); END IF;

  -- CC3490
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3490', 'Lina Perez', false, 'completed', false, 23.82, 0.00, 0, 1.18, 25.00, 0.00, 0, 16, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121600000034901100127967615465, Fecha de autorización: 12/16/2025 6:38:24 p. m., Protocolo autorización 00001528364-1-65300620250000000000112439', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 15:09:00'::timestamptz, '2025-12-16 13:38:00'::timestamptz, '2025-12-16 13:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 25.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 25.00, '2025-12-16 13:38:00'::timestamptz); END IF;

  -- CC3491
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3491', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121600000034911100122201652506, Fecha de autorización: 12/16/2025 8:07:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000112487', '2025-12-17 00:00:00'::timestamptz, '2025-12-16 15:09:00'::timestamptz, '2025-12-16 15:06:00'::timestamptz, '2025-12-16 15:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-16 15:06:00'::timestamptz); END IF;

  -- CC3492
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3492', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 15:09:00'::timestamptz, '2025-12-16 15:08:00'::timestamptz, '2025-12-16 15:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-16 15:08:00'::timestamptz); END IF;

  -- CC3493
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3493', 'Evelyn', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025121600000034931100121153468422, Fecha de autorización: 12/16/2025 8:14:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000112498', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 15:15:00'::timestamptz, '2025-12-16 15:14:00'::timestamptz, '2025-12-16 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-16 15:14:00'::timestamptz); END IF;

  -- CC3494
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3494', 'Leonel Visueti', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025121600000034941100121515339310, Fecha de autorización: 12/16/2025 8:16:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000112500', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 15:17:00'::timestamptz, '2025-12-16 15:16:00'::timestamptz, '2025-12-16 15:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-16 15:16:00'::timestamptz); END IF;

  -- CC3495
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 18;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3495', 'Sandra Medina', false, 'completed', false, 7.73, 0.00, 0, 0.52, 8.25, 0.00, 0, 5, '', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 17:17:00'::timestamptz, '2025-12-16 16:31:00'::timestamptz, '2025-12-16 16:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.25, '2025-12-16 16:31:00'::timestamptz); END IF;

  -- CC3496
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3496', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121600000034961100122559300547, Fecha de autorización: 12/16/2025 9:35:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000112538', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 00:00:00'::timestamptz, '2025-12-16 16:35:00'::timestamptz, '2025-12-16 16:35:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-12-16 16:35:00'::timestamptz); END IF;

  -- CC3497
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3497', 'Leonel Visueti', false, 'completed', false, 2.12, 0.00, 0, 0.13, 2.25, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121600000034971100125309905233, Fecha de autorización: 12/16/2025 9:36:24 p. m., Protocolo autorización 00001528364-1-65300620250000000000112539', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 17:17:00'::timestamptz, '2025-12-16 16:36:00'::timestamptz, '2025-12-16 16:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-12-16 16:36:00'::timestamptz); END IF;

  -- CC3498
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3498', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121600000034981100127371219583, Fecha de autorización: 12/16/2025 9:37:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000112540', '2025-12-16 00:00:00'::timestamptz, '2025-12-16 00:00:00'::timestamptz, '2025-12-16 16:37:00'::timestamptz, '2025-12-16 16:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-12-16 16:37:00'::timestamptz); END IF;

  -- CC3499
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 304;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3499', 'Julia Blanco', false, 'completed', false, 24.69, 0.00, 0, 1.31, 26.00, 0.00, 0, 16, 'lavandera  FE generada: FE0120000155737034-2-2023-3800002025121700000034991100129157478886, Fecha de autorización: 12/17/2025 2:59:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000112669', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 10:30:00'::timestamptz, '2025-12-17 09:59:00'::timestamptz, '2025-12-17 09:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 26.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 26.00, '2025-12-17 09:59:00'::timestamptz); END IF;

  -- CC3500
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 62;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3500', 'Juan David VanSice', false, 'completed', false, 0.00, 44.50, 0, 0.00, 0.00, 17.80, 3, 1, 'Perlas de Olor: Media,Tipo De Suavizante: Sin suavizante', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 12:21:00'::timestamptz, '2025-12-17 10:31:00'::timestamptz, '2025-12-17 10:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_factura IS NOT NULL AND 0.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_factura, 'Factura', 0.00, '2025-12-17 10:31:00'::timestamptz); END IF;

  -- CC3501
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3501', 'Yatzury Anderson', false, 'completed', false, 10.11, 0.00, 0, 0.39, 10.50, 0.00, 0, 9, 'Lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121700000035011100126484268713, Fecha de autorización: 12/17/2025 4:58:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000112721', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 12:58:00'::timestamptz, '2025-12-17 11:58:00'::timestamptz, '2025-12-17 11:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.50, '2025-12-17 11:58:00'::timestamptz); END IF;

  -- CC3502
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3502', 'Rafael Quintero', false, 'completed', false, 7.86, 0.00, 0, 0.39, 8.25, 0.00, 0, 5, '', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 12:21:00'::timestamptz, '2025-12-17 12:21:00'::timestamptz, '2025-12-17 12:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.25, '2025-12-17 12:21:00'::timestamptz); END IF;

  -- CC3503
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3503', 'Tairis - Diego', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121700000035031100127065759011, Fecha de autorización: 12/17/2025 5:22:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000112728', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 12:23:00'::timestamptz, '2025-12-17 12:22:00'::timestamptz, '2025-12-17 12:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 3.00, '2025-12-17 12:22:00'::timestamptz); END IF;

  -- CC3504
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 285;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3504', 'Dilia Valdes', false, 'completed', false, 41.36, 0.00, 0, 2.89, 44.25, 17.70, 3, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121700000035041100121016489181, Fecha de autorización: 12/17/2025 5:31:38 p. m., Protocolo autorización 00001528364-1-65300620250000000000112737', '2025-12-17 00:00:00'::timestamptz, '2025-12-19 13:09:00'::timestamptz, '2025-12-17 12:31:00'::timestamptz, '2025-12-17 12:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 44.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 44.25, '2025-12-17 12:31:00'::timestamptz); END IF;

  -- CC3505
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 175;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3505', 'Valery Rosas', false, 'completed', false, 33.45, 0.00, 0, 1.80, 35.25, 0.00, 0, 24, 'Lavanderia', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 13:00:00'::timestamptz, '2025-12-17 12:56:00'::timestamptz, '2025-12-17 12:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 35.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 35.25, '2025-12-17 12:56:00'::timestamptz); END IF;

  -- CC3506
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3506', 'Karla Garibaldi', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 6, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121700000035061100129315362833, Fecha de autorización: 12/17/2025 7:24:25 p. m., Protocolo autorización 00001528364-1-65300620250000000000112756', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 15:32:00'::timestamptz, '2025-12-17 14:24:00'::timestamptz, '2025-12-17 14:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-17 14:24:00'::timestamptz); END IF;

  -- CC3507
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3507', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121700000035071100125886829308, Fecha de autorización: 12/17/2025 8:32:43 p. m., Protocolo autorización 00001528364-1-65300620250000000000112786', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 16:37:00'::timestamptz, '2025-12-17 15:32:00'::timestamptz, '2025-12-17 15:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-17 15:32:00'::timestamptz); END IF;

  -- CC3508
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3508', 'Renzo Mundo', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121700000035081100120572239226, Fecha de autorización: 12/17/2025 8:33:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000112787', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 15:43:00'::timestamptz, '2025-12-17 15:33:00'::timestamptz, '2025-12-17 15:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-17 15:33:00'::timestamptz); END IF;

  -- CC3509
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3509', 'Luis Carlos Arosema', false, 'completed', false, 3.74, 2.00, 0, 0.26, 4.00, 0.00, 0, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121700000035091100129381169929, Fecha de autorización: 12/17/2025 8:42:00 p. m., Protocolo autorización 00001528364-1-65300620250000000000112794', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 15:43:00'::timestamptz, '2025-12-17 15:41:00'::timestamptz, '2025-12-17 15:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-17 15:41:00'::timestamptz); END IF;

  -- CC3510
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 7;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3510', 'Yatzury Anderson', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121700000035101100129182674603, Fecha de autorización: 12/17/2025 8:45:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000112798', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 15:45:00'::timestamptz, '2025-12-17 15:44:00'::timestamptz, '2025-12-17 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-17 15:44:00'::timestamptz); END IF;

  -- CC3511
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 51;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3511', 'Judy De Morales', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121700000035111100127071199350, Fecha de autorización: 12/17/2025 9:51:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000112845', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 16:51:00'::timestamptz, '2025-12-17 16:51:00'::timestamptz, '2025-12-17 16:51:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-17 16:51:00'::timestamptz); END IF;

  -- CC3512
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3512', 'Leonel Visueti', false, 'completed', false, 0.93, 0.00, 0, 0.07, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121700000035121100128937674767, Fecha de autorización: 12/17/2025 10:27:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000112866', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 17:34:00'::timestamptz, '2025-12-17 17:27:00'::timestamptz, '2025-12-17 17:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-17 17:27:00'::timestamptz); END IF;

  -- CC3513
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3513', 'Retail', true, 'completed', false, 0.75, 0.00, 0, 0.00, 0.75, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025121700000035131100126591437421, Fecha de autorización: 12/17/2025 10:28:09 p. m., Protocolo autorización 00001528364-1-65300620250000000000112867', '2025-12-17 00:00:00'::timestamptz, '2025-12-17 00:00:00'::timestamptz, '2025-12-17 17:28:00'::timestamptz, '2025-12-17 17:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.75, '2025-12-17 17:28:00'::timestamptz); END IF;

  -- CC3514
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3514', 'German Alveo', false, 'completed', false, 7.52, 0.00, 0, 0.53, 8.05, 4.60, 1, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121800000035141100126907417784, Fecha de autorización: 12/18/2025 8:43:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000113104', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 15:43:00'::timestamptz, '2025-12-18 08:41:00'::timestamptz, '2025-12-18 08:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.05 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.05, '2025-12-18 08:41:00'::timestamptz); END IF;

  -- CC3515
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3515', 'Paula Perez', false, 'completed', false, 23.66, 0.00, 0, 1.59, 25.25, 2.35, 1, 10, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121800000035151100121258294535, Fecha de autorización: 12/18/2025 4:02:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000113017', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 11:02:00'::timestamptz, '2025-12-18 09:30:00'::timestamptz, '2025-12-18 09:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 25.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 25.25, '2025-12-18 09:30:00'::timestamptz); END IF;

  -- CC3516
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3516', 'Leonel Visueti', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, '  FE generada: FE0120000155737034-2-2023-3800002025121800000035161100120762832086, Fecha de autorización: 12/18/2025 4:03:50 p. m., Protocolo autorización 00001528364-1-65300620250000000000113018', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 11:04:00'::timestamptz, '2025-12-18 11:03:00'::timestamptz, '2025-12-18 11:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-18 11:03:00'::timestamptz); END IF;

  -- CC3517
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 247;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3517', 'Joel Armando', false, 'completed', false, 18.93, 0.00, 0, 1.32, 20.25, 8.10, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121800000035171100124631574357, Fecha de autorización: 12/18/2025 5:04:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000113034', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 12:05:00'::timestamptz, '2025-12-18 12:03:00'::timestamptz, '2025-12-18 12:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.25, '2025-12-18 12:03:00'::timestamptz); END IF;

  -- CC3518
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3518', 'Nicole Flores', false, 'completed', false, 10.48, 0.00, 0, 0.52, 11.00, 0.00, 0, 7, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121800000035181100120213926162, Fecha de autorización: 12/18/2025 6:23:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000113059', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 13:24:00'::timestamptz, '2025-12-18 13:23:00'::timestamptz, '2025-12-18 13:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 11.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 11.00, '2025-12-18 13:23:00'::timestamptz); END IF;

  -- CC3519
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3519', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121800000035191100126551192498, Fecha de autorización: 12/18/2025 6:24:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000113061', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 13:25:00'::timestamptz, '2025-12-18 13:24:00'::timestamptz, '2025-12-18 13:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-18 13:24:00'::timestamptz); END IF;

  -- CC3520
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3520', 'German Alveo', false, 'completed', false, 106.54, 0.00, 0, 7.46, 114.00, 21.60, 7, 11, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025121800000035201100120099178488, Fecha de autorización: 12/18/2025 8:42:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000113103', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 15:42:00'::timestamptz, '2025-12-18 15:22:00'::timestamptz, '2025-12-18 15:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 114.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 114.00, '2025-12-18 15:22:00'::timestamptz); END IF;

  -- CC3521
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 163;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3521', 'Justo Arosemena', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121800000035211100124419480912, Fecha de autorización: 12/18/2025 8:44:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000113105', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 16:08:00'::timestamptz, '2025-12-18 15:44:00'::timestamptz, '2025-12-18 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-18 15:44:00'::timestamptz); END IF;

  -- CC3522
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3522', 'Leonel Visueti', false, 'completed', false, 0.47, 0.00, 0, 0.03, 0.50, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121800000035221100127833507516, Fecha de autorización: 12/18/2025 8:44:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000113106', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 16:08:00'::timestamptz, '2025-12-18 15:44:00'::timestamptz, '2025-12-18 15:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-12-18 15:44:00'::timestamptz); END IF;

  -- CC3523
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3523', 'Fany Luz Salon', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 12, '  FE generada: FE0120000155737034-2-2023-3800002025121800000035231100129842860133, Fecha de autorización: 12/18/2025 9:08:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000113116', '2025-12-18 00:00:00'::timestamptz, '2025-12-18 16:07:00'::timestamptz, '2025-12-18 16:04:00'::timestamptz, '2025-12-18 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-18 16:04:00'::timestamptz); END IF;

  -- CC3524
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3524', 'German Alveo', false, 'washing', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 7, 'Lavandería ', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 00:00:00'::timestamptz, '2025-12-19 13:11:00'::timestamptz, '2025-12-19 13:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2025-12-19 13:11:00'::timestamptz); END IF;

  -- CC3525
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3525', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121900000035251100128031937550, Fecha de autorización: 12/19/2025 6:12:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000113319', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 16:11:00'::timestamptz, '2025-12-19 13:12:00'::timestamptz, '2025-12-19 13:12:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-19 13:12:00'::timestamptz); END IF;

  -- CC3526
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3526', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121900000035261100127095835550, Fecha de autorización: 12/19/2025 8:14:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000113349', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 16:15:00'::timestamptz, '2025-12-19 15:14:00'::timestamptz, '2025-12-19 15:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-19 15:14:00'::timestamptz); END IF;

  -- CC3527
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3527', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025121900000035271100127285437265, Fecha de autorización: 12/19/2025 9:13:30 p. m., Protocolo autorización 00001528364-1-65300620250000000000113371', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 16:14:00'::timestamptz, '2025-12-19 16:13:00'::timestamptz, '2025-12-19 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-19 16:13:00'::timestamptz); END IF;

  -- CC3528
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3528', 'Retail', true, 'completed', false, 1.50, 0.00, 0, 0.00, 1.50, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025121900000035281100129960208135, Fecha de autorización: 12/19/2025 9:23:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000113373', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 00:00:00'::timestamptz, '2025-12-19 16:22:00'::timestamptz, '2025-12-19 16:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.50, '2025-12-19 16:22:00'::timestamptz); END IF;

  -- CC3529
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3529', 'Leonel Visueti', false, 'completed', false, 8.96, 0.00, 0, 0.39, 9.35, 0.00, 0, 9, '  FE generada: FE0120000155737034-2-2023-3800002025121900000035291100122434177670, Fecha de autorización: 12/19/2025 9:34:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000113378', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 17:16:00'::timestamptz, '2025-12-19 16:34:00'::timestamptz, '2025-12-19 16:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 9.35 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 9.35, '2025-12-19 16:34:00'::timestamptz); END IF;

  -- CC3530
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 12;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3530', 'Marubenis Calderon', false, 'completed', false, 1.17, 0.00, 0, 0.08, 1.25, 0.00, 0, 1, 'm', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 16:50:00'::timestamptz, '2025-12-19 16:47:00'::timestamptz, '2025-12-19 16:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-12-19 16:47:00'::timestamptz); END IF;

  -- CC3531
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 158;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3531', 'Alberto Campell', true, 'completed', false, 2.00, 0.00, 0, 0.00, 2.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025121900000035311100128854677699, Fecha de autorización: 12/19/2025 10:02:20 p. m., Protocolo autorización 00001528364-1-65300620250000000000113389', '2025-12-19 00:00:00'::timestamptz, '2025-12-19 00:00:00'::timestamptz, '2025-12-19 17:02:00'::timestamptz, '2025-12-19 17:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-19 17:02:00'::timestamptz); END IF;

  -- CC3532
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 202;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3532', 'Israel Rentería', false, 'completed', false, 18.46, 0.00, 0, 1.29, 19.75, 7.90, 1, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035321100120025604227, Fecha de autorización: 12/22/2025 2:01:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000113763', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 13:27:00'::timestamptz, '2025-12-22 09:01:00'::timestamptz, '2025-12-22 09:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 19.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 19.75, '2025-12-22 09:01:00'::timestamptz); END IF;

  -- CC3533
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3533', 'Alvaro Martinez @', false, 'completed', false, 9.58, 0.00, 0, 0.67, 10.25, 4.10, 1, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122200000035331100125083468810, Fecha de autorización: 12/22/2025 2:20:19 p. m., Protocolo autorización 00001528364-1-65300620250000000000113767', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 13:27:00'::timestamptz, '2025-12-22 09:20:00'::timestamptz, '2025-12-22 09:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.25, '2025-12-22 09:20:00'::timestamptz); END IF;

  -- CC3534
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3534', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035341100124695749112, Fecha de autorización: 12/22/2025 3:08:10 p. m., Protocolo autorización 00001528364-1-65300620250000000000113775', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 10:08:00'::timestamptz, '2025-12-22 10:08:00'::timestamptz, '2025-12-22 10:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-22 10:08:00'::timestamptz); END IF;

  -- CC3535
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3535', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035351100126213909168, Fecha de autorización: 12/22/2025 4:23:51 p. m., Protocolo autorización 00001528364-1-65300620250000000000113794', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 11:24:00'::timestamptz, '2025-12-22 11:23:00'::timestamptz, '2025-12-22 11:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-22 11:23:00'::timestamptz); END IF;

  -- CC3536
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3536', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035361100122385033944, Fecha de autorización: 12/22/2025 6:26:22 p. m., Protocolo autorización 00001528364-1-65300620250000000000113828', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 13:27:00'::timestamptz, '2025-12-22 13:26:00'::timestamptz, '2025-12-22 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-22 13:26:00'::timestamptz); END IF;

  -- CC3537
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3537', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035371100129909691718, Fecha de autorización: 12/22/2025 6:26:56 p. m., Protocolo autorización 00001528364-1-65300620250000000000113829', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 13:27:00'::timestamptz, '2025-12-22 13:26:00'::timestamptz, '2025-12-22 13:26:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-22 13:26:00'::timestamptz); END IF;

  -- CC3538
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3538', 'Leonel Visueti', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035381100128760290676, Fecha de autorización: 12/22/2025 7:36:08 p. m., Protocolo autorización 00001528364-1-65300620250000000000113867', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 14:36:00'::timestamptz, '2025-12-22 14:36:00'::timestamptz, '2025-12-22 14:36:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-22 14:36:00'::timestamptz); END IF;

  -- CC3539
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 306;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3539', 'Bar Restaurante Tropicalli', false, 'completed', false, 29.91, 0.00, 0, 2.09, 32.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122200000035391100121327617514, Fecha de autorización: 12/22/2025 9:09:13 p. m., Protocolo autorización 00001528364-1-65300620250000000000113895', '2025-12-22 00:00:00'::timestamptz, '2025-12-23 13:30:00'::timestamptz, '2025-12-22 16:09:00'::timestamptz, '2025-12-22 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 32.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 32.00, '2025-12-22 16:09:00'::timestamptz); END IF;

  -- CC3540
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3540', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122200000035401100120058815229, Fecha de autorización: 12/22/2025 9:19:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000113900', '2025-12-22 00:00:00'::timestamptz, '2025-12-22 00:00:00'::timestamptz, '2025-12-22 16:19:00'::timestamptz, '2025-12-22 16:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-22 16:19:00'::timestamptz); END IF;

  -- CC3541
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3541', 'Leonel Visueti', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, '  FE generada: FE0120000155737034-2-2023-3800002025122300000035411100127136154743, Fecha de autorización: 12/23/2025 6:26:07 p. m., Protocolo autorización 00001528364-1-65300620250000000000114137', '2025-12-23 00:00:00'::timestamptz, '2025-12-23 15:34:00'::timestamptz, '2025-12-23 13:25:00'::timestamptz, '2025-12-23 13:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-23 13:25:00'::timestamptz); END IF;

  -- CC3542
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3542', 'German Alveo', false, 'completed', false, 52.10, 0.00, 0, 3.65, 55.75, 22.30, 6, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122300000035421100122346970243, Fecha de autorización: 12/23/2025 8:33:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000114234', '2025-12-23 00:00:00'::timestamptz, '2025-12-23 15:33:00'::timestamptz, '2025-12-23 13:29:00'::timestamptz, '2025-12-23 13:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 55.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 55.75, '2025-12-23 13:29:00'::timestamptz); END IF;

  -- CC3543
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 198;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3543', 'Jorge Achito', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia', '2025-12-23 00:00:00'::timestamptz, '2025-12-24 13:38:00'::timestamptz, '2025-12-23 15:19:00'::timestamptz, '2025-12-23 15:19:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-23 15:19:00'::timestamptz); END IF;

  -- CC3544
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 225;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3544', 'Rolando Mendoza', false, 'completed', false, 28.74, 0.00, 0, 2.01, 30.75, 8.30, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122300000035441100127029105379, Fecha de autorización: 12/23/2025 8:20:29 p. m., Protocolo autorización 00001528364-1-65300620250000000000114228', '2025-12-23 00:00:00'::timestamptz, '2025-12-23 15:34:00'::timestamptz, '2025-12-23 15:20:00'::timestamptz, '2025-12-23 15:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.75, '2025-12-23 15:20:00'::timestamptz); END IF;

  -- CC3545
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3545', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122300000035451100128492794391, Fecha de autorización: 12/23/2025 9:58:14 p. m., Protocolo autorización 00001528364-1-65300620250000000000114282', '2025-12-23 00:00:00'::timestamptz, '2025-12-23 00:00:00'::timestamptz, '2025-12-23 16:58:00'::timestamptz, '2025-12-23 16:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-23 16:58:00'::timestamptz); END IF;

  -- CC3546
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3546', 'Nicole Flores', false, 'completed', false, 22.43, 0.00, 0, 1.57, 24.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122400000035461100124423981734, Fecha de autorización: 12/24/2025 3:25:54 p. m., Protocolo autorización 00001528364-1-65300620250000000000114433', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 10:26:00'::timestamptz, '2025-12-24 10:25:00'::timestamptz, '2025-12-24 10:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 24.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 24.00, '2025-12-24 10:25:00'::timestamptz); END IF;

  -- CC3547
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3547', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025122400000035471100127131648437, Fecha de autorización: 12/24/2025 4:14:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000114463', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 11:21:00'::timestamptz, '2025-12-24 11:14:00'::timestamptz, '2025-12-24 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-12-24 11:14:00'::timestamptz); END IF;

  -- CC3548
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3548', 'Leonel Visueti', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122400000035481100126569158900, Fecha de autorización: 12/24/2025 4:22:18 p. m., Protocolo autorización 00001528364-1-65300620250000000000114473', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 11:57:00'::timestamptz, '2025-12-24 11:22:00'::timestamptz, '2025-12-24 11:22:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-24 11:22:00'::timestamptz); END IF;

  -- CC3549
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3549', 'Leonel Visueti', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122400000035491100124327678631, Fecha de autorización: 12/24/2025 4:33:59 p. m., Protocolo autorización 00001528364-1-65300620250000000000114477', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 11:57:00'::timestamptz, '2025-12-24 11:33:00'::timestamptz, '2025-12-24 11:33:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-24 11:33:00'::timestamptz); END IF;

  -- CC3550
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3550', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122400000035501100120182846434, Fecha de autorización: 12/24/2025 5:00:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000114485', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 12:05:00'::timestamptz, '2025-12-24 12:00:00'::timestamptz, '2025-12-24 12:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-24 12:00:00'::timestamptz); END IF;

  -- CC3551
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3551', 'Leonel Visueti', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122400000035511100126651691200, Fecha de autorización: 12/24/2025 5:27:34 p. m., Protocolo autorización 00001528364-1-65300620250000000000114494', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 12:50:00'::timestamptz, '2025-12-24 12:27:00'::timestamptz, '2025-12-24 12:27:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-24 12:27:00'::timestamptz); END IF;

  -- CC3552
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 10;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3552', 'Leonel Visueti', false, 'completed', false, 28.30, 0.00, 0, 1.70, 30.00, 0.00, 0, 21, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122400000035521100121691306447, Fecha de autorización: 12/24/2025 5:40:04 p. m., Protocolo autorización 00001528364-1-65300620250000000000114501', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 12:42:00'::timestamptz, '2025-12-24 12:39:00'::timestamptz, '2025-12-24 12:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.00, '2025-12-24 12:39:00'::timestamptz); END IF;

  -- CC3553
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3553', 'Cliente Lavanderia American Laundry', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'American Laundry', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 13:03:00'::timestamptz, '2025-12-24 13:02:00'::timestamptz, '2025-12-24 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-24 13:02:00'::timestamptz); END IF;

  -- CC3554
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3554', 'Evelyn', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025122400000035541100125507910944, Fecha de autorización: 12/24/2025 6:04:05 p. m., Protocolo autorización 00001528364-1-65300620250000000000114517', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 13:08:00'::timestamptz, '2025-12-24 13:03:00'::timestamptz, '2025-12-24 13:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2025-12-24 13:03:00'::timestamptz); END IF;

  -- CC3555
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 106;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3555', 'Oscar Oropeza', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 0.00, 0, 7, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122400000035551100127949444135, Fecha de autorización: 12/24/2025 6:32:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000114532', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 13:38:00'::timestamptz, '2025-12-24 13:32:00'::timestamptz, '2025-12-24 13:32:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-12-24 13:32:00'::timestamptz); END IF;

  -- CC3556
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3556', 'Retail', true, 'completed', false, 0.50, 0.00, 0, 0.00, 0.50, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122400000035561100123396945517, Fecha de autorización: 12/24/2025 6:39:17 p. m., Protocolo autorización 00001528364-1-65300620250000000000114536', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 00:00:00'::timestamptz, '2025-12-24 13:39:00'::timestamptz, '2025-12-24 13:39:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 0.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 0.50, '2025-12-24 13:39:00'::timestamptz); END IF;

  -- CC3557
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 105;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3557', 'Karla Garibaldi', false, 'completed', false, 44.86, 0.00, 0, 3.14, 48.00, 19.20, 5, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122400000035571100123053701210, Fecha de autorización: 12/24/2025 6:50:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000114540', '2025-12-24 00:00:00'::timestamptz, '2025-12-24 13:52:00'::timestamptz, '2025-12-24 13:50:00'::timestamptz, '2025-12-24 13:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 48.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 48.00, '2025-12-24 13:50:00'::timestamptz); END IF;

  -- CC3558
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3558', 'Julissa Rivera', false, 'completed', false, 10.11, 0.00, 0, 0.64, 10.75, 3.90, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122600000035581100125519805615, Fecha de autorización: 12/26/2025 3:40:37 p. m., Protocolo autorización 00001528364-1-65300620250000000000114667', '2025-12-26 00:00:00'::timestamptz, '2025-12-27 10:31:00'::timestamptz, '2025-12-26 10:40:00'::timestamptz, '2025-12-26 10:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.75 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.75, '2025-12-26 10:40:00'::timestamptz); END IF;

  -- CC3559
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 233;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3559', 'Ilma Beluche', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'lavanderia', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 14:35:00'::timestamptz, '2025-12-26 10:53:00'::timestamptz, '2025-12-26 10:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 12.00, '2025-12-26 10:53:00'::timestamptz); END IF;

  -- CC3560
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3560', 'Cliente Lavanderia American Laundry', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 14:35:00'::timestamptz, '2025-12-26 12:08:00'::timestamptz, '2025-12-26 12:08:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-26 12:08:00'::timestamptz); END IF;

  -- CC3561
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3561', 'Cliente Lavanderia American Laundry', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Lavanderia', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 14:35:00'::timestamptz, '2025-12-26 14:31:00'::timestamptz, '2025-12-26 14:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-12-26 14:31:00'::timestamptz); END IF;

  -- CC3562
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3562', 'Retail', true, 'completed', false, 2.10, 0.00, 0, 0.00, 2.10, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122600000035621100129195513406, Fecha de autorización: 12/26/2025 7:38:18 p. m., Protocolo autorización 00001528364-1-65300620250000000000114713', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 00:00:00'::timestamptz, '2025-12-26 14:38:00'::timestamptz, '2025-12-26 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.10 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.10, '2025-12-26 14:38:00'::timestamptz); END IF;

  -- CC3563
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 256;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3563', 'Nicole Flores', false, 'completed', false, 17.08, 0.00, 0, 0.92, 18.00, 0.00, 0, 11, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122600000035631100125782732655, Fecha de autorización: 12/26/2025 9:00:03 p. m., Protocolo autorización 00001528364-1-65300620250000000000114730', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 16:00:00'::timestamptz, '2025-12-26 15:59:00'::timestamptz, '2025-12-26 15:59:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 18.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 18.00, '2025-12-26 15:59:00'::timestamptz); END IF;

  -- CC3564
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3564', 'Retail', true, 'completed', false, 1.25, 0.00, 0, 0.00, 1.25, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122600000035641100127732061390, Fecha de autorización: 12/26/2025 9:04:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000114732', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 00:00:00'::timestamptz, '2025-12-26 16:04:00'::timestamptz, '2025-12-26 16:04:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.25, '2025-12-26 16:04:00'::timestamptz); END IF;

  -- CC3565
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3565', 'Cliente Lavanderia American Laundry', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 16:25:00'::timestamptz, '2025-12-26 16:17:00'::timestamptz, '2025-12-26 16:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-26 16:17:00'::timestamptz); END IF;

  -- CC3566
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3566', 'Cliente Lavanderia American Laundry', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavanderia', '2025-12-26 00:00:00'::timestamptz, '2025-12-26 16:25:00'::timestamptz, '2025-12-26 16:25:00'::timestamptz, '2025-12-26 16:25:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-26 16:25:00'::timestamptz); END IF;

  -- CC3567
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3567', 'Leonel Willson', false, 'completed', false, 13.21, 0.00, 0, 0.79, 14.00, 0.00, 0, 8, '  FE generada: FE0120000155737034-2-2023-3800002025122700000035671100123826779027, Fecha de autorización: 12/27/2025 3:18:45 p. m., Protocolo autorización 00001528364-1-65300620250000000000114785', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 10:31:00'::timestamptz, '2025-12-27 10:18:00'::timestamptz, '2025-12-27 10:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 14.00, '2025-12-27 10:18:00'::timestamptz); END IF;

  -- CC3568
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 75;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3568', 'Genesis Hassan', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122700000035681100128714429618, Fecha de autorización: 12/27/2025 3:41:44 p. m., Protocolo autorización 00001528364-1-65300620250000000000114787', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 11:22:00'::timestamptz, '2025-12-27 10:41:00'::timestamptz, '2025-12-27 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-27 10:41:00'::timestamptz); END IF;

  -- CC3569
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 309;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3569', 'Javier Perez', false, 'completed', false, 6.61, 0.00, 0, 0.39, 7.00, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122700000035691100120153431790, Fecha de autorización: 12/27/2025 4:22:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000114795', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 11:22:00'::timestamptz, '2025-12-27 11:21:00'::timestamptz, '2025-12-27 11:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.00, '2025-12-27 11:21:00'::timestamptz); END IF;

  -- CC3570
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3570', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025122700000035701100124135380890, Fecha de autorización: 12/27/2025 5:57:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000114853', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 12:59:00'::timestamptz, '2025-12-27 12:57:00'::timestamptz, '2025-12-27 12:57:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-27 12:57:00'::timestamptz); END IF;

  -- CC3571
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3571', 'Cliente Lavanderia American Laundry', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 13:01:00'::timestamptz, '2025-12-27 13:00:00'::timestamptz, '2025-12-27 13:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2025-12-27 13:00:00'::timestamptz); END IF;

  -- CC3572
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3572', 'Cliente Lavanderia American Laundry', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 13:02:00'::timestamptz, '2025-12-27 13:02:00'::timestamptz, '2025-12-27 13:02:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-27 13:02:00'::timestamptz); END IF;

  -- CC3573
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3573', 'Cliente Lavanderia American Laundry', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavanderia', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 14:24:00'::timestamptz, '2025-12-27 14:23:00'::timestamptz, '2025-12-27 14:23:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-12-27 14:23:00'::timestamptz); END IF;

  -- CC3574
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3574', 'Blanca', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122700000035741100127699231108, Fecha de autorización: 12/27/2025 8:01:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000114906', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 16:33:00'::timestamptz, '2025-12-27 15:01:00'::timestamptz, '2025-12-27 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 2.00, '2025-12-27 15:01:00'::timestamptz); END IF;

  -- CC3575
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3575', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122700000035751100125612480116, Fecha de autorización: 12/27/2025 8:53:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000114968', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 00:00:00'::timestamptz, '2025-12-27 15:53:00'::timestamptz, '2025-12-27 15:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-27 15:53:00'::timestamptz); END IF;

  -- CC3576
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3576', 'Ileana', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, 'lavanderia', '2025-12-27 00:00:00'::timestamptz, '2025-12-27 16:33:00'::timestamptz, '2025-12-27 15:55:00'::timestamptz, '2025-12-27 15:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-12-27 15:55:00'::timestamptz); END IF;

  -- CC3577
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 134;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3577', 'Alvaro Martinez @', false, 'completed', false, 13.08, 0.00, 0, 0.92, 14.00, 8.00, 2, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035771100129809315305, Fecha de autorización: 12/29/2025 1:54:02 p. m., Protocolo autorización 00001528364-1-65300620250000000000115044', '2025-12-29 00:00:00'::timestamptz, '2025-12-30 12:10:00'::timestamptz, '2025-12-29 08:53:00'::timestamptz, '2025-12-29 08:53:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 14.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 14.00, '2025-12-29 08:53:00'::timestamptz); END IF;

  -- CC3578
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 307;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3578', 'Joshua Holness', false, 'completed', false, 66.62, 0.00, 0, 4.38, 71.00, 21.20, 3, 7, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035781100126455428787, Fecha de autorización: 12/29/2025 2:00:47 p. m., Protocolo autorización 00001528364-1-65300620250000000000115045', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 11:15:00'::timestamptz, '2025-12-29 09:00:00'::timestamptz, '2025-12-29 09:00:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 71.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 71.00, '2025-12-29 09:00:00'::timestamptz); END IF;

  -- CC3579
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 244;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3579', 'Fernando Rios', false, 'completed', false, 12.38, 0.00, 0, 0.87, 13.25, 4.90, 2, 3, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035791100120355627092, Fecha de autorización: 12/29/2025 2:56:23 p. m., Protocolo autorización 00001528364-1-65300620250000000000115048', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 17:02:00'::timestamptz, '2025-12-29 09:56:00'::timestamptz, '2025-12-29 09:56:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 13.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 13.25, '2025-12-29 09:56:00'::timestamptz); END IF;

  -- CC3580
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 50;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3580', 'Tairis - Diego', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122900000035801100121830696881, Fecha de autorización: 12/29/2025 3:21:52 p. m., Protocolo autorización 00001528364-1-65300620250000000000115050', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 12:59:00'::timestamptz, '2025-12-29 10:21:00'::timestamptz, '2025-12-29 10:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-29 10:21:00'::timestamptz); END IF;

  -- CC3581
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 123;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3581', 'Javier Ortega', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, '0  FE generada: FE0120000155737034-2-2023-3800002025122900000035811100127291245976, Fecha de autorización: 12/29/2025 4:14:39 p. m., Protocolo autorización 00001528364-1-65300620250000000000115051', '2025-12-29 00:00:00'::timestamptz, '2025-12-31 11:12:00'::timestamptz, '2025-12-29 11:14:00'::timestamptz, '2025-12-29 11:14:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-29 11:14:00'::timestamptz); END IF;

  -- CC3582
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 310;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3582', 'Cristian Prediger', false, 'completed', false, 18.69, 0.00, 0, 1.31, 20.00, 0.00, 0, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035821100123530882363, Fecha de autorización: 12/29/2025 5:58:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000115062', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 12:59:00'::timestamptz, '2025-12-29 12:58:00'::timestamptz, '2025-12-29 12:58:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 20.00, '2025-12-29 12:58:00'::timestamptz); END IF;

  -- CC3583
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3583', 'Cliente Lavanderia American Laundry', false, 'completed', false, 8.54, 0.00, 0, 0.46, 9.00, 0.00, 0, 6, 'Lavanderia', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 14:47:00'::timestamptz, '2025-12-29 13:43:00'::timestamptz, '2025-12-29 13:43:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 9.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 9.00, '2025-12-29 13:43:00'::timestamptz); END IF;

  -- CC3584
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3584', 'Retail', true, 'completed', false, 1.00, 0.00, 0, 0.00, 1.00, 0.00, 0, 1, '  FE generada: FE0120000155737034-2-2023-3800002025122900000035841100121196326327, Fecha de autorización: 12/29/2025 6:49:32 p. m., Protocolo autorización 00001528364-1-65300620250000000000115109', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 00:00:00'::timestamptz, '2025-12-29 13:49:00'::timestamptz, '2025-12-29 13:49:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.00, '2025-12-29 13:49:00'::timestamptz); END IF;

  -- CC3585
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3585', 'Cliente Lavanderia American Laundry', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavanderia', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 14:47:00'::timestamptz, '2025-12-29 14:17:00'::timestamptz, '2025-12-29 14:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-29 14:17:00'::timestamptz); END IF;

  -- CC3586
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 19;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3586', 'Rafael Quintero', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025122900000035861100125566173902, Fecha de autorización: 12/29/2025 7:46:33 p. m., Protocolo autorización 00001528364-1-65300620250000000000115110', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 14:47:00'::timestamptz, '2025-12-29 14:46:00'::timestamptz, '2025-12-29 14:46:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2025-12-29 14:46:00'::timestamptz); END IF;

  -- CC3587
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 52;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3587', 'Aaron Gutierrez', false, 'completed', false, 5.61, 2.00, 0, 0.39, 6.00, 0.00, 0, 4, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025122900000035871100120154125975, Fecha de autorización: 12/29/2025 9:09:49 p. m., Protocolo autorización 00001528364-1-65300620250000000000115115', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 16:12:00'::timestamptz, '2025-12-29 16:09:00'::timestamptz, '2025-12-29 16:09:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-29 16:09:00'::timestamptz); END IF;

  -- CC3588
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 192;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3588', 'Coromoto Roverse', false, 'completed', false, 27.10, 0.00, 0, 1.90, 29.00, 6.00, 2, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035881100120264754267, Fecha de autorización: 12/29/2025 9:15:46 p. m., Protocolo autorización 00001528364-1-65300620250000000000115116', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 16:17:00'::timestamptz, '2025-12-29 16:15:00'::timestamptz, '2025-12-29 16:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 29.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 29.00, '2025-12-29 16:15:00'::timestamptz); END IF;

  -- CC3589
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 48;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3589', 'Evelyn', false, 'completed', false, 14.21, 0.00, 0, 0.79, 15.00, 0.00, 0, 9, 'Salón  FE generada: FE0120000155737034-2-2023-3800002025122900000035891100126250000259, Fecha de autorización: 12/29/2025 9:55:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000115121', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 17:27:00'::timestamptz, '2025-12-29 16:55:00'::timestamptz, '2025-12-29 16:55:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 15.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 15.00, '2025-12-29 16:55:00'::timestamptz); END IF;

  -- CC3590
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 259;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3590', 'Luis Carlos Arosema', false, 'completed', false, 6.21, 0.00, 0, 0.39, 6.60, 0.00, 0, 4, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002025122900000035901100124265934064, Fecha de autorización: 12/29/2025 10:01:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000115123', '2025-12-29 00:00:00'::timestamptz, '2025-12-29 17:02:00'::timestamptz, '2025-12-29 17:01:00'::timestamptz, '2025-12-29 17:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.60 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.60, '2025-12-29 17:01:00'::timestamptz); END IF;

  -- CC3591
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3591', 'Cliente Lavandería', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025123000000035911100121064811895, Fecha de autorización: 12/30/2025 2:38:31 p. m., Protocolo autorización 00001528364-1-65300620250000000000115180', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 12:10:00'::timestamptz, '2025-12-30 09:38:00'::timestamptz, '2025-12-30 09:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 6.00, '2025-12-30 09:38:00'::timestamptz); END IF;

  -- CC3592
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 144;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3592', 'German Alveo', false, 'completed', false, 34.81, 0.00, 0, 2.44, 37.25, 14.90, 5, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025123000000035921100124134682535, Fecha de autorización: 12/30/2025 7:13:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000115235', '2025-12-31 00:00:00'::timestamptz, '2025-12-30 14:13:00'::timestamptz, '2025-12-30 12:11:00'::timestamptz, '2025-12-30 12:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 37.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 37.25, '2025-12-30 12:11:00'::timestamptz); END IF;

  -- CC3593
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3593', 'Cliente Lavanderia American Laundry', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavanderia', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 13:16:00'::timestamptz, '2025-12-30 12:17:00'::timestamptz, '2025-12-30 12:17:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 8.00, '2025-12-30 12:17:00'::timestamptz); END IF;

  -- CC3594
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3594', 'Cliente Lavanderia American Laundry', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 1, 'Lavanderia', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 16:31:00'::timestamptz, '2025-12-30 12:20:00'::timestamptz, '2025-12-30 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2025-12-30 12:20:00'::timestamptz); END IF;

  -- CC3595
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3595', 'Cliente Lavanderia American Laundry', false, 'completed', false, 7.11, 0.00, 0, 0.39, 7.50, 0.00, 0, 5, 'Lavanderia', '2025-12-31 00:00:00'::timestamptz, '2025-12-30 13:15:00'::timestamptz, '2025-12-30 13:15:00'::timestamptz, '2025-12-30 13:15:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 7.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 7.50, '2025-12-30 13:15:00'::timestamptz); END IF;

  -- CC3596
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3596', 'Renzo Mundo', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025123000000035961100120139092049, Fecha de autorización: 12/30/2025 6:16:42 p. m., Protocolo autorización 00001528364-1-65300620250000000000115218', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 15:33:00'::timestamptz, '2025-12-30 13:16:00'::timestamptz, '2025-12-30 13:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-30 13:16:00'::timestamptz); END IF;

  -- CC3597
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 13;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3597', 'Cliente Lavandería', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025123000000035971100120394422856, Fecha de autorización: 12/30/2025 8:01:30 p. m., Protocolo autorización 00001528364-1-65300620250000000000115255', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 15:33:00'::timestamptz, '2025-12-30 15:01:00'::timestamptz, '2025-12-30 15:01:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-30 15:01:00'::timestamptz); END IF;

  -- CC3598
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3598', 'Cliente Lavanderia American Laundry', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Lavanderia', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 15:35:00'::timestamptz, '2025-12-30 15:34:00'::timestamptz, '2025-12-30 15:34:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2025-12-30 15:34:00'::timestamptz); END IF;

  -- CC3599
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 20;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3599', 'Fany Luz Salon', false, 'completed', false, 5.24, 0.00, 0, 0.26, 5.50, 0.00, 0, 5, '  FE generada: FE0120000155737034-2-2023-3800002025123000000035991100123675352964, Fecha de autorización: 12/30/2025 9:06:16 p. m., Protocolo autorización 00001528364-1-65300620250000000000115281', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 16:06:00'::timestamptz, '2025-12-30 16:06:00'::timestamptz, '2025-12-30 16:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.50, '2025-12-30 16:06:00'::timestamptz); END IF;

  -- CC3600
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3600', 'Cliente Lavanderia American Laundry', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavanderia', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 16:28:00'::timestamptz, '2025-12-30 16:28:00'::timestamptz, '2025-12-30 16:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2025-12-30 16:28:00'::timestamptz); END IF;

  -- CC3601
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3601', 'Retail', true, 'completed', false, 1.85, 0.00, 0, 0.00, 1.85, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025123000000036011100126156879286, Fecha de autorización: 12/30/2025 9:29:48 p. m., Protocolo autorización 00001528364-1-65300620250000000000115283', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 00:00:00'::timestamptz, '2025-12-30 16:29:00'::timestamptz, '2025-12-30 16:29:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 1.85 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 1.85, '2025-12-30 16:29:00'::timestamptz); END IF;

  -- CC3602
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3602', 'Cliente Lavanderia American Laundry', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavanderia', '2025-12-30 00:00:00'::timestamptz, '2025-12-30 16:31:00'::timestamptz, '2025-12-30 16:30:00'::timestamptz, '2025-12-30 16:30:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-30 16:30:00'::timestamptz); END IF;

  -- CC3603
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3603', 'Cliente Lavanderia American Laundry', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2026-01-01 00:00:00'::timestamptz, '2025-12-31 11:14:00'::timestamptz, '2025-12-31 10:03:00'::timestamptz, '2025-12-31 10:03:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2025-12-31 10:03:00'::timestamptz); END IF;

  -- CC3604
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 15;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3604', 'Leonardo Salon', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002025123100000036041100125541180141, Fecha de autorización: 12/31/2025 4:11:41 p. m., Protocolo autorización 00001528364-1-65300620250000000000115309', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 11:14:00'::timestamptz, '2025-12-31 11:11:00'::timestamptz, '2025-12-31 11:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-31 11:11:00'::timestamptz); END IF;

  -- CC3605
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3605', 'Cliente Lavanderia American Laundry', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavanderia', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 13:07:00'::timestamptz, '2025-12-31 11:37:00'::timestamptz, '2025-12-31 11:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-31 11:37:00'::timestamptz); END IF;

  -- CC3606
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3606', 'Cliente Lavanderia American Laundry', false, 'completed', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 5, 'Lavanderia', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 12:30:00'::timestamptz, '2025-12-31 11:40:00'::timestamptz, '2025-12-31 11:40:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 10.00, '2025-12-31 11:40:00'::timestamptz); END IF;

  -- CC3607
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 98;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3607', 'Renzo Mundo', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 2, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002025123100000036071100126919572528, Fecha de autorización: 12/31/2025 5:20:57 p. m., Protocolo autorización 00001528364-1-65300620250000000000115312', '2026-01-01 00:00:00'::timestamptz, '2025-12-31 12:29:00'::timestamptz, '2025-12-31 12:20:00'::timestamptz, '2025-12-31 12:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2025-12-31 12:20:00'::timestamptz); END IF;

  -- CC3608
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3608', 'Cliente Lavanderia American Laundry', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'Lavanderia', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 13:07:00'::timestamptz, '2025-12-31 12:31:00'::timestamptz, '2025-12-31 12:31:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2025-12-31 12:31:00'::timestamptz); END IF;

  -- CC3609
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3609', 'Cliente Lavanderia American Laundry', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, 'Lavanderia', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 13:07:00'::timestamptz, '2025-12-31 13:06:00'::timestamptz, '2025-12-31 13:06:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2025-12-31 13:06:00'::timestamptz); END IF;

  -- CC3610
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3610', 'Cliente Lavanderia American Laundry', false, 'completed', false, 21.82, 0.00, 0, 1.18, 23.00, 0.00, 0, 14, 'Lavanderia', '2026-01-01 00:00:00'::timestamptz, '2025-12-31 14:20:00'::timestamptz, '2025-12-31 13:44:00'::timestamptz, '2025-12-31 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 23.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 23.00, '2025-12-31 13:44:00'::timestamptz); END IF;

  -- CC3611
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 1;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3611', 'Retail', true, 'completed', false, 2.25, 0.00, 0, 0.00, 2.25, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002025123100000036111100124488342757, Fecha de autorización: 12/31/2025 6:48:21 p. m., Protocolo autorización 00001528364-1-65300620250000000000115318', '2025-12-31 00:00:00'::timestamptz, '2025-12-31 00:00:00'::timestamptz, '2025-12-31 13:48:00'::timestamptz, '2025-12-31 13:48:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.25, '2025-12-31 13:48:00'::timestamptz); END IF;

  -- CC3612
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 112;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3612', 'Lina Perez', false, 'completed', false, 16.46, 0.00, 0, 0.79, 17.25, 0.00, 0, 11, 'Lavandería  FE generada: FE0120000155737034-2-2023-3800002026010200000036121100126199345397, Fecha de autorización: 01/02/2026 6:18:58 p. m., Protocolo autorización 00001528364-1-65300620260000000000000073', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 13:28:00'::timestamptz, '2026-01-02 13:18:00'::timestamptz, '2026-01-02 13:18:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 17.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 17.25, '2026-01-02 13:18:00'::timestamptz); END IF;

  -- CC3613
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3613', 'Cliente Lavanderia American Laundry', false, 'completed', false, 11.21, 0.00, 0, 0.79, 12.00, 0.00, 0, 6, 'Lavanderia', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 14:29:00'::timestamptz, '2026-01-02 14:28:00'::timestamptz, '2026-01-02 14:28:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 12.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 12.00, '2026-01-02 14:28:00'::timestamptz); END IF;

  -- CC3614
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 188;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3614', 'Librada Mendoza', false, 'completed', false, 37.97, 0.00, 0, 2.03, 40.00, 0.00, 0, 25, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010200000036141100122637949591, Fecha de autorización: 01/02/2026 8:24:23 p. m., Protocolo autorización 00001528364-1-65300620260000000000000080', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 16:14:00'::timestamptz, '2026-01-02 15:24:00'::timestamptz, '2026-01-02 15:24:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 40.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 40.00, '2026-01-02 15:24:00'::timestamptz); END IF;

  -- CC3615
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 185;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3615', 'Julissa Rivera', false, 'completed', false, 9.64, 0.00, 0, 0.61, 10.25, 3.70, 1, 2, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010200000036151100125219620620, Fecha de autorización: 01/02/2026 9:11:29 p. m., Protocolo autorización 00001528364-1-65300620260000000000000114', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 16:14:00'::timestamptz, '2026-01-02 16:11:00'::timestamptz, '2026-01-02 16:11:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.25 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.25, '2026-01-02 16:11:00'::timestamptz); END IF;

  -- CC3616
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3616', 'Cliente Lavanderia American Laundry', false, 'completed', false, 7.48, 0.00, 0, 0.52, 8.00, 0.00, 0, 4, 'Lavanderia', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 16:14:00'::timestamptz, '2026-01-02 16:13:00'::timestamptz, '2026-01-02 16:13:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 8.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 8.00, '2026-01-02 16:13:00'::timestamptz); END IF;

  -- CC3617
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3617', 'Cliente Lavanderia American Laundry', false, 'completed', false, 2.37, 0.00, 0, 0.13, 2.50, 0.00, 0, 2, 'Lavanderia', '2026-01-02 00:00:00'::timestamptz, '2026-01-02 16:16:00'::timestamptz, '2026-01-02 16:16:00'::timestamptz, '2026-01-02 16:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.50 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.50, '2026-01-02 16:16:00'::timestamptz); END IF;

  -- CC3618
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 312;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3618', 'Joe Cordiano', false, 'completed', false, 18.76, 0.00, 0, 1.24, 20.00, 3.60, 1, 4, 'Servicio de lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010300000036181100128663372934, Fecha de autorización: 01/03/2026 3:40:52 p. m., Protocolo autorización 00001528364-1-65300620260000000000000174', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 10:40:00'::timestamptz, '2026-01-03 08:16:00'::timestamptz, '2026-01-03 08:16:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 20.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 20.00, '2026-01-03 08:16:00'::timestamptz); END IF;

  -- CC3619
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 94;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3619', 'Leonel Willson', false, 'completed', false, 5.61, 0.00, 0, 0.39, 6.00, 0.00, 0, 3, '  FE generada: FE0120000155737034-2-2023-3800002026010300000036191100124956893784, Fecha de autorización: 01/03/2026 3:41:23 p. m., Protocolo autorización 00001528364-1-65300620260000000000000175', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 12:51:00'::timestamptz, '2026-01-03 10:41:00'::timestamptz, '2026-01-03 10:41:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 6.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 6.00, '2026-01-03 10:41:00'::timestamptz); END IF;

  -- CC3620
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3620', 'Cliente Lavanderia American Laundry', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, 'Lavanderia', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 12:51:00'::timestamptz, '2026-01-03 10:42:00'::timestamptz, '2026-01-03 10:42:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 4.00, '2026-01-03 10:42:00'::timestamptz); END IF;

  -- CC3621
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 172;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3621', 'Gustavo Cumbrera', false, 'completed', false, 14.95, 0.00, 0, 1.05, 16.00, 0.00, 0, 8, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010300000036211100129060903151, Fecha de autorización: 01/03/2026 5:50:47 p. m., Protocolo autorización 00001528364-1-65300620260000000000000180', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 12:51:00'::timestamptz, '2026-01-03 12:50:00'::timestamptz, '2026-01-03 12:50:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 16.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 16.00, '2026-01-03 12:50:00'::timestamptz); END IF;

  -- CC3622
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 27;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3622', 'Blanca', false, 'completed', false, 3.74, 0.00, 0, 0.26, 4.00, 0.00, 0, 2, '  FE generada: FE0120000155737034-2-2023-3800002026010300000036221100120748428959, Fecha de autorización: 01/03/2026 7:20:48 p. m., Protocolo autorización 00001528364-1-65300620260000000000000186', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 14:32:00'::timestamptz, '2026-01-03 14:20:00'::timestamptz, '2026-01-03 14:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 4.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 4.00, '2026-01-03 14:20:00'::timestamptz); END IF;

  -- CC3623
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 224;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3623', 'Paula Perez', false, 'completed', false, 28.04, 0.00, 0, 1.96, 30.00, 2.50, 1, 12, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010300000036231100124950748699, Fecha de autorización: 01/03/2026 9:17:25 p. m., Protocolo autorización 00001528364-1-65300620260000000000000196', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 16:17:00'::timestamptz, '2026-01-03 14:37:00'::timestamptz, '2026-01-03 14:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 30.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 30.00, '2026-01-03 14:37:00'::timestamptz); END IF;

  -- CC3624
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 310;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3624', 'Cristian Prediger', false, 'washing', false, 9.35, 0.00, 0, 0.65, 10.00, 0.00, 0, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010300000036241100126877455737, Fecha de autorización: 01/03/2026 7:38:20 p. m., Protocolo autorización 00001528364-1-65300620260000000000000188', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 00:00:00'::timestamptz, '2026-01-03 14:38:00'::timestamptz, '2026-01-03 14:38:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2026-01-03 14:38:00'::timestamptz); END IF;

  -- CC3625
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3625', 'Cliente Lavanderia American Laundry', false, 'completed', false, 12.35, 0.00, 0, 0.65, 13.00, 0.00, 0, 8, 'Lavanderia', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 15:38:00'::timestamptz, '2026-01-03 15:37:00'::timestamptz, '2026-01-03 15:37:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 13.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 13.00, '2026-01-03 15:37:00'::timestamptz); END IF;

  -- CC3626
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 181;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3626', 'Ileana', false, 'completed', false, 1.87, 0.00, 0, 0.13, 2.00, 0.00, 0, 1, 'lavanderia  FE generada: FE0120000155737034-2-2023-3800002026010300000036261100123799772305, Fecha de autorización: 01/03/2026 9:20:53 p. m., Protocolo autorización 00001528364-1-65300620260000000000000197', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 16:21:00'::timestamptz, '2026-01-03 16:20:00'::timestamptz, '2026-01-03 16:20:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 2.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 2.00, '2026-01-03 16:20:00'::timestamptz); END IF;

  -- CC3627
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3627', 'Cliente Lavanderia American Laundry', false, 'completed', false, 9.48, 0.00, 0, 0.52, 10.00, 0.00, 0, 6, 'Lavanderia', '2026-01-03 00:00:00'::timestamptz, '2026-01-03 16:35:00'::timestamptz, '2026-01-03 16:21:00'::timestamptz, '2026-01-03 16:21:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 10.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 10.00, '2026-01-03 16:21:00'::timestamptz); END IF;

  -- CC3628
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3628', 'Cliente Lavanderia American Laundry', false, 'completed', false, 2.80, 0.00, 0, 0.20, 3.00, 0.00, 0, 6, 'Lavanderia', '2026-01-05 00:00:00'::timestamptz, '2026-01-05 13:45:00'::timestamptz, '2026-01-05 13:44:00'::timestamptz, '2026-01-05 13:44:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 3.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 3.00, '2026-01-05 13:44:00'::timestamptz); END IF;

  -- CC3629
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3629', 'Cliente Lavanderia American Laundry', false, 'completed', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavanderia', '2026-01-05 00:00:00'::timestamptz, '2026-01-05 13:47:00'::timestamptz, '2026-01-05 13:45:00'::timestamptz, '2026-01-05 13:45:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_ach IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_ach, 'ACH', 5.00, '2026-01-05 13:45:00'::timestamptz); END IF;

  -- CC3630
  v_customer_id := NULL;
  SELECT id INTO v_customer_id FROM customers WHERE store_id = v_store_id AND (preferences->>'cc_id')::int = 308;
  INSERT INTO orders (store_id, customer_id, legacy_order_number, customer_name, is_walk_in, status, is_express, subtotal, discount_amount, delivery_charge, tax_amount, total, total_weight, total_bags, total_pieces, notes, promised_date, completed_at, created_at, updated_at)
  VALUES (v_store_id, v_customer_id, 'CC3630', 'Cliente Lavanderia American Laundry', false, 'washing', false, 4.74, 0.00, 0, 0.26, 5.00, 0.00, 0, 3, 'Lavanderia', '2026-01-05 00:00:00'::timestamptz, '2026-01-05 00:00:00'::timestamptz, '2026-01-05 13:47:00'::timestamptz, '2026-01-05 13:47:00'::timestamptz) RETURNING id INTO v_order_id;
  IF v_pm_efectivo IS NOT NULL AND 5.00 > 0 THEN INSERT INTO payments (order_id, payment_method_id, payment_method, amount, created_at) VALUES (v_order_id, v_pm_efectivo, 'Efectivo', 5.00, '2026-01-05 13:47:00'::timestamptz); END IF;


  RAISE NOTICE 'Part 7: Imported orders 3001 to 3472';
END $$;
