-- =====================================================
-- SEED PRODUCTS FROM CLEANCLOUD EXPORT
-- Run this AFTER creating sections
-- =====================================================

-- First, let's get the store_id (assuming single store setup)
DO $$
DECLARE
    v_store_id uuid;
    v_section_lava_dobla uuid;
    v_section_lavamatico uuid;
    v_section_productos uuid;
    v_section_corporativo uuid;
    v_section_entregas uuid;
    
    -- Parent product IDs (we'll create these first, then reference them)
    v_parent_almohadas uuid;
    v_parent_sabanas uuid;
    v_parent_toallas uuid;
    v_parent_sobrecamas uuid;
    v_parent_planchado uuid;
    v_parent_productos_lavanderia uuid;
    v_parent_recogidas uuid;
    v_parent_entregas uuid;
    v_parent_cafe uuid;
    v_parent_bebidas uuid;
    v_parent_snacks uuid;
    v_parent_caramelos uuid;
    v_parent_chicles uuid;
BEGIN
    -- Get the store ID
    SELECT id INTO v_store_id FROM stores LIMIT 1;
    
    IF v_store_id IS NULL THEN
        RAISE EXCEPTION 'No store found. Please create a store first.';
    END IF;

    -- =====================================================
    -- CREATE SECTIONS
    -- =====================================================
    
    -- Delete existing sections and products for clean import
    DELETE FROM products WHERE store_id = v_store_id;
    DELETE FROM sections WHERE store_id = v_store_id;
    
    -- Create Lava y Dobla section
    INSERT INTO sections (store_id, name, color, display_order, is_active)
    VALUES (v_store_id, 'Lava y Dobla', '#0891b2', 1, true)
    RETURNING id INTO v_section_lava_dobla;
    
    -- Create Lavamático section
    INSERT INTO sections (store_id, name, color, display_order, is_active)
    VALUES (v_store_id, 'Lavamático', '#7c3aed', 2, true)
    RETURNING id INTO v_section_lavamatico;
    
    -- Create Productos section
    INSERT INTO sections (store_id, name, color, display_order, is_active)
    VALUES (v_store_id, 'Productos', '#059669', 3, true)
    RETURNING id INTO v_section_productos;
    
    -- Create Corporativo section
    INSERT INTO sections (store_id, name, color, display_order, is_active)
    VALUES (v_store_id, 'Corporativo', '#dc2626', 4, true)
    RETURNING id INTO v_section_corporativo;

    -- Create Entregas section (for delivery products)
    INSERT INTO sections (store_id, name, color, display_order, is_active)
    VALUES (v_store_id, 'Entregas', '#f59e0b', 5, true)
    RETURNING id INTO v_section_entregas;

    -- =====================================================
    -- CREATE PARENT PRODUCTS (Categories)
    -- =====================================================
    
    -- Almohadas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Almohadas', '🛏️', 'service', 'quantity', 0, 0, true, true, 1)
    RETURNING id INTO v_parent_almohadas;
    
    -- Sábanas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Sábanas', '🛏️', 'service', 'quantity', 0, 0, true, true, 2)
    RETURNING id INTO v_parent_sabanas;
    
    -- Toallas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Toallas', '🧴', 'service', 'quantity', 0, 0, true, true, 3)
    RETURNING id INTO v_parent_toallas;
    
    -- Sobrecamas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Sobrecamas', '🛏️', 'service', 'quantity', 0, 0, true, true, 4)
    RETURNING id INTO v_parent_sobrecamas;
    
    -- Planchado a Vapor (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Planchado a Vapor', '👔', 'service', 'quantity', 0, 0, true, true, 5)
    RETURNING id INTO v_parent_planchado;
    
    -- Recogidas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_entregas, 'Recogidas', '🚗', 'delivery', 'quantity', 0, 0, true, true, 1)
    RETURNING id INTO v_parent_recogidas;
    
    -- Entregas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_entregas, 'Entregas', '🚚', 'delivery', 'quantity', 0, 0, true, true, 2)
    RETURNING id INTO v_parent_entregas;
    
    -- Productos de Lavandería (Parent) - in Productos section
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Productos de Lavandería', '🧴', 'retail', 'quantity', 0, 0, false, true, 1)
    RETURNING id INTO v_parent_productos_lavanderia;
    
    -- Café (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Café', '☕', 'retail', 'quantity', 0, 0, false, true, 2)
    RETURNING id INTO v_parent_cafe;
    
    -- Bebidas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Bebidas', '🥤', 'retail', 'quantity', 0, 0, false, true, 3)
    RETURNING id INTO v_parent_bebidas;
    
    -- Snacks (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Snacks', '🍿', 'retail', 'quantity', 0, 0, false, true, 4)
    RETURNING id INTO v_parent_snacks;
    
    -- Caramelos y Chocolates (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Caramelos y Chocolates', '🍬', 'retail', 'quantity', 0, 0, false, true, 5)
    RETURNING id INTO v_parent_caramelos;
    
    -- Chicles y Mentas (Parent)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable, has_children, display_order)
    VALUES (v_store_id, v_section_productos, 'Chicles y Mentas', '🍬', 'retail', 'quantity', 0, 0, false, true, 6)
    RETURNING id INTO v_parent_chicles;

    -- =====================================================
    -- STANDALONE PRODUCTS (No Parent) - LAVA Y DOBLA
    -- =====================================================
    
    -- Lava y Dobla (por kg) - Main service product
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Lava y Dobla (por kg)', '👕', 'service', 'weight', 2.34, 2.34, 0, 1, true, 0);
    
    -- Seca y Dobla (por kg)
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Seca y Dobla (por kg)', '👕', 'service', 'weight', 1.64, 1.64, 0, 1, true, 0);
    
    -- Mantel
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Mantel', '🧣', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 10);
    
    -- Gorras
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Gorras', '🧢', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 11);
    
    -- Cortinas
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Cortinas', '🪟', 'service', 'quantity', 9.35, 9.35, 0, 1, true, 12);
    
    -- Zapatillas
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES (v_store_id, v_section_lava_dobla, 'Zapatillas', '👟', 'service', 'quantity', 9.35, 9.35, 0, 1, true, 13);

    -- =====================================================
    -- CHILD PRODUCTS - ALMOHADAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lava_dobla, v_parent_almohadas, 'Cobertura de almohada (Todas)', '🛏️', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 1),
    (v_store_id, v_section_lava_dobla, v_parent_almohadas, 'Almohada Grande (1 un)', '🛏️', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 2),
    (v_store_id, v_section_lava_dobla, v_parent_almohadas, 'Almohada Regular (2 un)', '🛏️', 'service', 'quantity', 5.61, 5.61, 0, 2, true, 3);

    -- =====================================================
    -- CHILD PRODUCTS - SÁBANAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lava_dobla, v_parent_sabanas, 'Set de Sábanas (Twin - Full)', '🛏️', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 1),
    (v_store_id, v_section_lava_dobla, v_parent_sabanas, 'Set de Sábanas (Queen - King)', '🛏️', 'service', 'quantity', 9.35, 9.35, 0, 1, true, 2);

    -- =====================================================
    -- CHILD PRODUCTS - TOALLAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lava_dobla, v_parent_toallas, 'Toalla (Manos - Cara)', '🧴', 'service', 'quantity', 1.40, 1.40, 0, 1, true, 1),
    (v_store_id, v_section_lava_dobla, v_parent_toallas, 'Toalla (Cuerpo - Playa)', '🧴', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 2);

    -- =====================================================
    -- CHILD PRODUCTS - SOBRECAMAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lava_dobla, v_parent_sobrecamas, 'Cobertura de sobrecama (Twin - Full)', '🛏️', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 1),
    (v_store_id, v_section_lava_dobla, v_parent_sobrecamas, 'Sobrecama (Twin - Full)', '🛏️', 'service', 'quantity', 5.61, 5.61, 0, 1, true, 2),
    (v_store_id, v_section_lava_dobla, v_parent_sobrecamas, 'Cobertura de Sobrecama (Queen - King)', '🛏️', 'service', 'quantity', 7.48, 7.48, 0, 1, true, 3),
    (v_store_id, v_section_lava_dobla, v_parent_sobrecamas, 'Sobrecama (Queen - King)', '🛏️', 'service', 'quantity', 9.35, 9.35, 0, 1, true, 4);

    -- =====================================================
    -- CHILD PRODUCTS - PLANCHADO A VAPOR
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lava_dobla, v_parent_planchado, 'Planchado regular (Camisas y Pantalones)', '👔', 'service', 'quantity', 0.47, 0.47, 0, 1, true, 1),
    (v_store_id, v_section_lava_dobla, v_parent_planchado, 'Planchado a vapor (Vestidos Cortos)', '👗', 'service', 'quantity', 0.93, 0.93, 0, 1, true, 2),
    (v_store_id, v_section_lava_dobla, v_parent_planchado, 'Planchado a vapor (Saco o Vestido largo)', '👔', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 3);

    -- =====================================================
    -- CHILD PRODUCTS - RECOGIDAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_entregas, v_parent_recogidas, 'Recogida $2.50', '🚗', 'delivery', 'quantity', 2.34, 2.34, 0, 1, true, 1),
    (v_store_id, v_section_entregas, v_parent_recogidas, 'Recogida $5.00', '🚗', 'delivery', 'quantity', 4.67, 4.67, 0, 1, true, 2),
    (v_store_id, v_section_entregas, v_parent_recogidas, 'Recogida $10.00', '🚗', 'delivery', 'quantity', 9.35, 9.35, 0, 1, true, 3);

    -- =====================================================
    -- CHILD PRODUCTS - ENTREGAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_entregas, v_parent_entregas, 'Entrega $2.50', '🚚', 'delivery', 'quantity', 2.34, 2.34, 0, 1, true, 1),
    (v_store_id, v_section_entregas, v_parent_entregas, 'Entrega $5.00', '🚚', 'delivery', 'quantity', 4.67, 4.67, 0, 1, true, 2),
    (v_store_id, v_section_entregas, v_parent_entregas, 'Entrega $10.00', '🚚', 'delivery', 'quantity', 9.35, 9.35, 0, 1, true, 3);

    -- =====================================================
    -- LAVAMÁTICO PRODUCTS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_lavamatico, 'Lavado', '🌀', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 1),
    (v_store_id, v_section_lavamatico, 'Secado', '💨', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 2);

    -- =====================================================
    -- CORPORATIVO PRODUCTS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_corporativo, 'Lava y Dobla $2.25 (por kg)', '👕', 'service', 'weight', 2.10, 2.10, 0, 1, true, 1),
    (v_store_id, v_section_corporativo, 'Toallas (Grandes y Chicas)', '🧴', 'service', 'quantity', 1.87, 1.87, 0, 1, true, 2),
    (v_store_id, v_section_corporativo, 'Cortinas Planchadas (Largas y Cortas)', '🪟', 'service', 'quantity', 2.10, 2.10, 0, 1, true, 3),
    (v_store_id, v_section_corporativo, 'Manteles Planchados (Largos y Cortos)', '🧣', 'service', 'quantity', 2.10, 2.10, 0, 1, true, 4),
    (v_store_id, v_section_corporativo, 'Planchado al Vapor Chico', '👔', 'service', 'quantity', 0.47, 0.47, 0, 1, true, 5),
    (v_store_id, v_section_corporativo, 'Planchado al Vapor Grande', '👔', 'service', 'quantity', 0.93, 0.93, 0, 1, true, 6);

    -- =====================================================
    -- CHILD PRODUCTS - PRODUCTOS DE LAVANDERÍA
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Bounce 1 hoja', '🧴', 'retail', 'quantity', 0.25, 0.25, 0, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Baby Castille (hipoalergénico) 2 oz', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 2),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Clorox 2 oz', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 3),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Lysol Sanitizer', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 4),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Orix Cloro Bleach', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 5),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Perlas de Olor', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 6),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Purex 2 oz', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 7),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Suavitel 2 oz', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 8),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Vanish 2 oz', '🧴', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 9),
    (v_store_id, v_section_productos, v_parent_productos_lavanderia, 'Tide 2 oz', '🧴', 'retail', 'quantity', 1.50, 1.50, 0, 1, false, 10);

    -- =====================================================
    -- CHILD PRODUCTS - CAFÉ
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_cafe, 'Café Negro', '☕', 'retail', 'quantity', 0.50, 0.50, 0, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_cafe, 'Café con leche', '☕', 'retail', 'quantity', 0.60, 0.60, 0, 1, false, 2);

    -- =====================================================
    -- CHILD PRODUCTS - BEBIDAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_bebidas, 'Agua Embotellada 500ml', '💧', 'retail', 'quantity', 0.50, 0.50, 0.14, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Gatorade 250ml', '🥤', 'retail', 'quantity', 0.50, 0.50, 0.32, 1, false, 2),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Jugo del Monte 200ml', '🧃', 'retail', 'quantity', 0.50, 0.50, 0.33, 1, false, 3),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Avena Nevada', '🥛', 'retail', 'quantity', 0.75, 0.75, 0, 1, false, 4),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Ginger Ale Canada Dry', '🥤', 'retail', 'quantity', 0.75, 0.75, 0.48, 1, false, 5),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Hawaiian Punch 10oz', '🧃', 'retail', 'quantity', 0.75, 0.75, 0, 1, false, 6),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Coca Cola 12 oz', '🥤', 'retail', 'quantity', 1.00, 1.00, 0.73, 1, false, 7),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Coca Cola Zero (Sin Calorías) 12oz', '🥤', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 8),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Fanta Surtidas', '🥤', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 9),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Raptor', '🥤', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 10),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Vitarain Zero', '🥤', 'retail', 'quantity', 1.00, 1.00, 0, 1, false, 11),
    (v_store_id, v_section_productos, v_parent_bebidas, 'Gatorade 600 ml', '🥤', 'retail', 'quantity', 1.25, 1.25, 0, 1, false, 12);

    -- =====================================================
    -- CHILD PRODUCTS - SNACKS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_snacks, 'Club Social 24g', '🍪', 'retail', 'quantity', 0.25, 0.25, 0.18, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_snacks, 'Rice Krispies Treats 0.78 oz', '🍪', 'retail', 'quantity', 0.25, 0.25, 0.17, 1, false, 2),
    (v_store_id, v_section_productos, v_parent_snacks, 'Wafer Bridge 1 oz', '🍪', 'retail', 'quantity', 0.25, 0.25, 0.13, 1, false, 3),
    (v_store_id, v_section_productos, v_parent_snacks, 'Crisp Pascual', '🍿', 'retail', 'quantity', 0.35, 0.35, 0.17, 1, false, 4),
    (v_store_id, v_section_productos, v_parent_snacks, 'Galletas Lance', '🍪', 'retail', 'quantity', 0.50, 0.50, 0, 1, false, 5),
    (v_store_id, v_section_productos, v_parent_snacks, 'Granola Soft & Chewy', '🥜', 'retail', 'quantity', 0.50, 0.50, 0.20, 1, false, 6),
    (v_store_id, v_section_productos, v_parent_snacks, 'Kellogs', '🥣', 'retail', 'quantity', 0.50, 0.50, 0.38, 1, false, 7),
    (v_store_id, v_section_productos, v_parent_snacks, 'Palomitas Kitty', '🍿', 'retail', 'quantity', 0.50, 0.50, 0, 1, false, 8),
    (v_store_id, v_section_productos, v_parent_snacks, 'Snacks Kitty', '🍿', 'retail', 'quantity', 0.50, 0.50, 0, 1, false, 9),
    (v_store_id, v_section_productos, v_parent_snacks, 'Twinkies y Cupcakes', '🧁', 'retail', 'quantity', 0.50, 0.50, 0.34, 1, false, 10),
    (v_store_id, v_section_productos, v_parent_snacks, 'Snacks Carles', '🍿', 'retail', 'quantity', 0.60, 0.60, 0, 1, false, 11),
    (v_store_id, v_section_productos, v_parent_snacks, 'Chips Ahoy Original 1.55 oz', '🍪', 'retail', 'quantity', 0.75, 0.75, 0.54, 1, false, 12),
    (v_store_id, v_section_productos, v_parent_snacks, 'Goldfish', '🐟', 'retail', 'quantity', 0.75, 0.75, 0.52, 1, false, 13),
    (v_store_id, v_section_productos, v_parent_snacks, 'Nature Valley Crunchy oats and Honey 1.49 oz', '🥜', 'retail', 'quantity', 0.75, 0.75, 0.45, 1, false, 14),
    (v_store_id, v_section_productos, v_parent_snacks, 'Nature Valley Trail Mix Fruit & Nut 1.20 oz', '🥜', 'retail', 'quantity', 0.75, 0.75, 0.45, 1, false, 15),
    (v_store_id, v_section_productos, v_parent_snacks, 'Oreo 6 Galletas 2.4 oz', '🍪', 'retail', 'quantity', 0.75, 0.75, 0.50, 1, false, 16),
    (v_store_id, v_section_productos, v_parent_snacks, 'Ritz Bits', '🍪', 'retail', 'quantity', 0.75, 0.75, 0.46, 1, false, 17),
    (v_store_id, v_section_productos, v_parent_snacks, 'Nueces Planters', '🥜', 'retail', 'quantity', 1.00, 1.00, 0.46, 1, false, 18),
    (v_store_id, v_section_productos, v_parent_snacks, 'Ritz Tubo', '🍪', 'retail', 'quantity', 1.00, 1.00, 0.67, 1, false, 19),
    (v_store_id, v_section_productos, v_parent_snacks, 'Pringles 1.4 oz', '🍟', 'retail', 'quantity', 1.25, 1.25, 0.92, 1, false, 20);

    -- =====================================================
    -- CHILD PRODUCTS - CARAMELOS Y CHOCOLATES
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_caramelos, 'Bon Bon Bum caramelo', '🍭', 'retail', 'quantity', 0.25, 0.25, 0.09, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Nucita', '🍫', 'retail', 'quantity', 0.25, 0.25, 0, 1, false, 2),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Tikys monedas 2 X 0.25', '🍫', 'retail', 'quantity', 0.25, 0.25, 0, 1, false, 3),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Vidal Sour Belts Rainbow 0.38 oz', '🍬', 'retail', 'quantity', 0.25, 0.25, 0.10, 1, false, 4),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Ring Pop 0.5 oz', '💍', 'retail', 'quantity', 0.50, 0.50, 0.34, 1, false, 5),
    (v_store_id, v_section_productos, v_parent_caramelos, 'M&M''s', '🍫', 'retail', 'quantity', 1.25, 1.25, 0.92, 1, false, 6),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Push Pop 0.5 oz', '🍭', 'retail', 'quantity', 1.25, 1.25, 1.27, 1, false, 7),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Snickers 1.86 oz', '🍫', 'retail', 'quantity', 1.25, 1.25, 0.83, 1, false, 8),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Hersheys Milk Chocolate 1.55 oz', '🍫', 'retail', 'quantity', 2.00, 2.00, 1.60, 1, false, 9),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Kinder Sorpresa Niña 20g', '🥚', 'retail', 'quantity', 2.00, 2.00, 2.67, 1, false, 10),
    (v_store_id, v_section_productos, v_parent_caramelos, 'Kinder Sorpresa Niño 20g', '🥚', 'retail', 'quantity', 2.00, 2.00, 2.67, 1, false, 11);

    -- =====================================================
    -- CHILD PRODUCTS - CHICLES Y MENTAS
    -- =====================================================
    
    INSERT INTO products (store_id, section_id, parent_id, name, icon, product_type, pricing_type, price, express_price, cost, pieces, is_taxable, display_order)
    VALUES 
    (v_store_id, v_section_productos, v_parent_chicles, 'Doublemint 15un', '🍬', 'retail', 'quantity', 1.25, 1.25, 0.79, 1, false, 1),
    (v_store_id, v_section_productos, v_parent_chicles, 'Winter Fresh 15un', '🍬', 'retail', 'quantity', 1.25, 1.25, 0.79, 1, false, 2);

    RAISE NOTICE 'Products seeded successfully!';
    RAISE NOTICE 'Store ID: %', v_store_id;
    
END $$;

-- =====================================================
-- VERIFY IMPORT
-- =====================================================

SELECT 'Sections:' as info;
SELECT id, name, color, display_order FROM sections ORDER BY display_order;

SELECT 'Parent Products:' as info;
SELECT id, name, section_id, has_children FROM products WHERE has_children = true ORDER BY display_order;

SELECT 'Product Count by Section:' as info;
SELECT s.name as section, COUNT(p.id) as product_count 
FROM sections s 
LEFT JOIN products p ON p.section_id = s.id 
GROUP BY s.name, s.display_order 
ORDER BY s.display_order;

SELECT 'Total Products:' as info;
SELECT COUNT(*) as total_products FROM products;
