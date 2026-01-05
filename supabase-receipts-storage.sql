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

-- 2. Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Authenticated users can upload receipts" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can read receipts" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update receipts" ON storage.objects;
DROP POLICY IF EXISTS "Service role can manage receipts" ON storage.objects;
DROP POLICY IF EXISTS "Allow receipt uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow receipt reads" ON storage.objects;

-- 3. Create RLS policies for the receipts bucket
-- These policies allow both authenticated users and service role to manage receipts

-- Policy: Allow authenticated users to upload receipts
CREATE POLICY "Allow receipt uploads"
ON storage.objects
FOR INSERT
TO authenticated, anon
WITH CHECK (
  bucket_id = 'receipts'
);

-- Policy: Allow authenticated users to read receipts
CREATE POLICY "Allow receipt reads"
ON storage.objects
FOR SELECT
TO authenticated, anon
USING (
  bucket_id = 'receipts'
);

-- Policy: Allow users to update their receipts
CREATE POLICY "Authenticated users can update receipts"
ON storage.objects
FOR UPDATE
TO authenticated, anon
USING (
  bucket_id = 'receipts'
);

-- 4. Optional: Create a function to clean up old receipts (> 2 years)
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

-- 5. Add receipt_path column to orders table to store receipt reference
ALTER TABLE orders ADD COLUMN IF NOT EXISTS receipt_path VARCHAR(500);

-- 6. Create index for receipt lookups
CREATE INDEX IF NOT EXISTS idx_orders_receipt_path ON orders(receipt_path) WHERE receipt_path IS NOT NULL;

COMMENT ON COLUMN orders.receipt_path IS 'Path to the receipt file in Supabase Storage/receipts bucket';

-- ==============================================
-- Verification Queries (run these to check setup)
-- ==============================================

-- Check bucket exists:
SELECT * FROM storage.buckets WHERE id = 'receipts';

-- Check policies:
SELECT policyname, permissive, roles, cmd, qual 
FROM pg_policies 
WHERE tablename = 'objects' 
AND (policyname LIKE '%receipt%' OR policyname LIKE '%Receipt%');

-- Check column added:
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'orders' AND column_name = 'receipt_path';
