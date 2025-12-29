-- =============================================
-- Supabase Storage Setup for Assets
-- Run this in the Supabase SQL Editor
-- =============================================

-- Create the 'assets' bucket if it doesn't exist
-- Note: This needs to be done via the Supabase Dashboard or API
-- Go to Storage > New bucket > Name: "assets" > Make it public

-- After creating the bucket, run this to set up policies:

-- Allow public read access to assets
CREATE POLICY "Public read access for assets"
ON storage.objects FOR SELECT
USING (bucket_id = 'assets');

-- Allow authenticated users to upload
CREATE POLICY "Authenticated users can upload assets"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'assets');

-- Allow authenticated users to update their uploads
CREATE POLICY "Authenticated users can update assets"
ON storage.objects FOR UPDATE
USING (bucket_id = 'assets');

-- Allow authenticated users to delete assets
CREATE POLICY "Authenticated users can delete assets"
ON storage.objects FOR DELETE
USING (bucket_id = 'assets');

-- =============================================
-- MANUAL STEPS REQUIRED:
-- =============================================
-- 1. Go to Supabase Dashboard > Storage
-- 2. Click "New bucket"
-- 3. Name: "assets"
-- 4. Check "Public bucket" to allow public read access
-- 5. Click "Create bucket"
-- 6. Then run the policies above in the SQL Editor
-- =============================================
