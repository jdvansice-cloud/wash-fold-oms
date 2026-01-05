-- Migration: Add refund support to orders
-- Run this in Supabase SQL Editor

-- Add refund reference column to orders table
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS refund_for_order_id uuid REFERENCES orders(id);

-- Add index for faster lookups
CREATE INDEX IF NOT EXISTS idx_orders_refund_for_order_id 
ON orders(refund_for_order_id) WHERE refund_for_order_id IS NOT NULL;

-- Update status check constraint to include refund statuses
-- First drop the existing constraint if it exists
ALTER TABLE orders DROP CONSTRAINT IF EXISTS orders_status_check;

-- Add new constraint with refund statuses
ALTER TABLE orders ADD CONSTRAINT orders_status_check 
CHECK (status IN ('pending', 'washing', 'drying', 'folding', 'ready', 'completed', 'cancelled', 'refunded', 'refund'));

-- Add reference column to payments table for storing POS/bank reference numbers
ALTER TABLE payments 
ADD COLUMN IF NOT EXISTS reference varchar;

-- Verify the refunds table exists (should already exist from initial schema)
-- If not, create it:
CREATE TABLE IF NOT EXISTS refunds (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id uuid REFERENCES stores(id),
  order_id uuid REFERENCES orders(id),
  order_number integer,
  customer_name varchar,
  amount numeric NOT NULL,
  refund_type varchar DEFAULT 'full' CHECK (refund_type IN ('full', 'partial')),
  reason varchar,
  notes text,
  processed_by uuid REFERENCES users(id),
  created_at timestamptz DEFAULT now()
);

-- Enable RLS on refunds if not already enabled
ALTER TABLE refunds ENABLE ROW LEVEL SECURITY;

-- Create policy for refunds (allow all operations for authenticated users)
DROP POLICY IF EXISTS "Allow all operations for refunds" ON refunds;
CREATE POLICY "Allow all operations for refunds" ON refunds FOR ALL USING (true);

-- Add comment for documentation
COMMENT ON COLUMN orders.refund_for_order_id IS 'Reference to original order when this is a refund order';
COMMENT ON COLUMN orders.status IS 'Order status: pending, washing, drying, folding, ready, completed, cancelled, refunded (original order was refunded), refund (this is a refund order)';

-- Verify changes
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'orders' AND column_name IN ('refund_for_order_id', 'status');

SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'payments' AND column_name = 'reference';
