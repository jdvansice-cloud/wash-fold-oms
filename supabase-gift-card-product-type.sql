-- Add 'gift_card' to the product_type constraint so gift card denominations
-- can be stored as products and appear in the POS grid

ALTER TABLE products DROP CONSTRAINT IF EXISTS products_product_type_check;
ALTER TABLE products ADD CONSTRAINT products_product_type_check
  CHECK (product_type IN ('service', 'retail', 'delivery', 'gift_card'));

-- Verify
SELECT conname, pg_get_constraintdef(oid) FROM pg_constraint
WHERE conrelid = 'products'::regclass AND conname LIKE '%product_type%';
