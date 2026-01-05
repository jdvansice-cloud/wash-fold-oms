-- ==============================================
-- Supabase Storage Setup for Receipts
-- ==============================================
-- 
-- IMPORTANT: You may need to create the bucket manually first!
-- Go to Supabase Dashboard > Storage > Create new bucket
-- Name: receipts
-- Public: No (unchecked)
-- File size limit: 50MB
-- Allowed MIME types: text/plain
--
-- After creating the bucket, run this SQL to set up policies:
-- ==============================================

-- 1. Try to create the receipts bucket (may fail if bucket already exists or if using dashboard)
DO $$
BEGIN
  INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  VALUES (
    'receipts',
    'receipts',
    false,
    52428800,
    ARRAY['text/plain']::text[]
  )
  ON CONFLICT (id) DO UPDATE SET
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Bucket creation skipped (may already exist or need manual creation): %', SQLERRM;
END $$;

-- 2. Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Authenticated users can upload receipts" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can read receipts" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update receipts" ON storage.objects;
DROP POLICY IF EXISTS "Service role can manage receipts" ON storage.objects;
DROP POLICY IF EXISTS "Allow receipt uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow receipt reads" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can upload receipts" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can read receipts" ON storage.objects;

-- 3. Create RLS policies for the receipts bucket
-- These allow both authenticated and anonymous users (using anon key) to upload/read

-- Policy: Allow anyone with valid API key to upload receipts
CREATE POLICY "Anyone can upload receipts"
ON storage.objects
FOR INSERT
TO public
WITH CHECK (bucket_id = 'receipts');

-- Policy: Allow anyone with valid API key to read receipts  
CREATE POLICY "Anyone can read receipts"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'receipts');

-- Policy: Allow anyone to update receipts (for upsert)
CREATE POLICY "Anyone can update receipts"
ON storage.objects
FOR UPDATE
TO public
USING (bucket_id = 'receipts');

-- 4. Add receipt_path column to orders table
ALTER TABLE orders ADD COLUMN IF NOT EXISTS receipt_path VARCHAR(500);

-- 5. Create index for receipt lookups
CREATE INDEX IF NOT EXISTS idx_orders_receipt_path ON orders(receipt_path) WHERE receipt_path IS NOT NULL;

COMMENT ON COLUMN orders.receipt_path IS 'Path to the receipt file in Supabase Storage/receipts bucket';

-- ==============================================
-- Verification Queries (run these to check setup)
-- ==============================================

-- Check bucket exists:
SELECT id, name, public, file_size_limit, allowed_mime_types 
FROM storage.buckets 
WHERE id = 'receipts';

-- Check policies exist:
SELECT policyname, permissive, roles, cmd 
FROM pg_policies 
WHERE tablename = 'objects' 
AND schemaname = 'storage';

-- Check column added:
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'orders' AND column_name = 'receipt_path';

-- ==============================================
-- If bucket doesn't show up after running SQL:
-- 1. Go to Supabase Dashboard
-- 2. Click on "Storage" in left sidebar
-- 3. Click "New bucket"
-- 4. Name: receipts
-- 5. Public bucket: OFF
-- 6. Click "Create bucket"
-- 7. Re-run this SQL for the policies
-- ==============================================
