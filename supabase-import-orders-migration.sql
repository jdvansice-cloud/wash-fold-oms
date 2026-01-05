-- =============================================
-- CleanCloud Orders Import - Schema Migration
-- Run this FIRST before importing orders
-- =============================================

-- Add legacy_order_number column to orders table
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS legacy_order_number VARCHAR(50);

-- Add index for faster lookups
CREATE INDEX IF NOT EXISTS idx_orders_legacy_order_number 
ON orders(legacy_order_number);

-- Ensure payment methods exist
DO $$
DECLARE
  v_store_id UUID;
BEGIN
  SELECT id INTO v_store_id FROM stores LIMIT 1;
  
  IF v_store_id IS NOT NULL THEN
    INSERT INTO payment_methods (store_id, name, icon, is_active, display_order)
    VALUES 
      (v_store_id, 'Efectivo', '💵', true, 1),
      (v_store_id, 'Tarjeta', '💳', true, 2),
      (v_store_id, 'Yappy', '📱', true, 3),
      (v_store_id, 'ACH', '🏦', true, 4),
      (v_store_id, 'Factura', '📄', true, 5)
    ON CONFLICT DO NOTHING;
  END IF;
END $$;

-- Verify migration
SELECT 'Migration complete. Column legacy_order_number added.' as status;
