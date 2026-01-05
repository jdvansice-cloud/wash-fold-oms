-- ==============================================
-- Supabase Storage Setup for Receipts
-- ==============================================
-- Run this in the Supabase SQL Editor

-- 1. Create the receipts bucket
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'receipts',
  'receipts',
  false, -- Private bucket
  52428800, -- 50MB limit
  ARRAY['text/plain']::text[]
)
ON CONFLICT (id) DO UPDATE SET
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

-- 2. Create RLS policies for the receipts bucket

-- Policy: Allow authenticated users to upload receipts
CREATE POLICY "Authenticated users can upload receipts"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'receipts'
);

-- Policy: Allow authenticated users to read receipts
CREATE POLICY "Authenticated users can read receipts"
ON storage.objects
FOR SELECT
TO authenticated
USING (
  bucket_id = 'receipts'
);

-- Policy: Allow users to update their receipts
CREATE POLICY "Authenticated users can update receipts"
ON storage.objects
FOR UPDATE
TO authenticated
USING (
  bucket_id = 'receipts'
);

-- 3. Optional: Create a function to clean up old receipts (> 2 years)
CREATE OR REPLACE FUNCTION cleanup_old_receipts()
RETURNS void AS $$
DECLARE
  cutoff_date timestamp;
BEGIN
  cutoff_date := NOW() - INTERVAL '2 years';
  
  DELETE FROM storage.objects
  WHERE bucket_id = 'receipts'
    AND created_at < cutoff_date;
    
  RAISE NOTICE 'Cleaned up receipts older than %', cutoff_date;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Add receipt_path column to orders table to store receipt reference
ALTER TABLE orders ADD COLUMN IF NOT EXISTS receipt_path VARCHAR(500);

-- 5. Create index for receipt lookups
CREATE INDEX IF NOT EXISTS idx_orders_receipt_path ON orders(receipt_path) WHERE receipt_path IS NOT NULL;

COMMENT ON COLUMN orders.receipt_path IS 'Path to the receipt file in Supabase Storage/receipts bucket';

-- ==============================================
-- Verification Queries
-- ==============================================

-- Check bucket exists:
-- SELECT * FROM storage.buckets WHERE id = 'receipts';

-- Check policies:
-- SELECT * FROM pg_policies WHERE tablename = 'objects' AND policyname LIKE '%receipts%';

-- Check column added:
-- SELECT column_name, data_type FROM information_schema.columns 
-- WHERE table_name = 'orders' AND column_name = 'receipt_path';
