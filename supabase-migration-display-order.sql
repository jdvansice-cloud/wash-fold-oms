-- =============================================
-- Migration: Add display_order to products table
-- Run this if you already have a database and need to add the display_order column
-- =============================================

-- Add display_order column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'products' AND column_name = 'display_order'
    ) THEN
        ALTER TABLE products ADD COLUMN display_order INTEGER DEFAULT 0;
        
        -- Set initial display_order based on current order
        WITH numbered AS (
            SELECT id, ROW_NUMBER() OVER (ORDER BY created_at) as rn
            FROM products
        )
        UPDATE products SET display_order = numbered.rn
        FROM numbered WHERE products.id = numbered.id;
        
        RAISE NOTICE 'Added display_order column to products table';
    ELSE
        RAISE NOTICE 'display_order column already exists';
    END IF;
END $$;

-- Add has_children column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'products' AND column_name = 'has_children'
    ) THEN
        ALTER TABLE products ADD COLUMN has_children BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added has_children column to products table';
    ELSE
        RAISE NOTICE 'has_children column already exists';
    END IF;
END $$;

SELECT 'Migration complete!' as status;
