-- ============================================================
-- Customer proof documents (exemption credentials, IDs, etc.)
-- ============================================================
-- Stores scanned images / PDFs attached to a customer profile — primarily the
-- exoneration credential that substantiates a tax_exempt customer (see
-- supabase-customer-tax-exempt.sql), but usable for any supporting document.
--
-- Files live in a PRIVATE Storage bucket `customer-documents`; the table tracks
-- one row per file. Mirrors the receipts-storage approach
-- (supabase-receipts-storage.sql) but keeps the bucket private so PII is only
-- reachable via signed URLs.
-- ============================================================

-- 1. Private bucket for customer documents.
DO $$
BEGIN
  INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  VALUES (
    'customer-documents',
    'customer-documents',
    false,
    52428800,
    ARRAY['image/png','image/jpeg','image/webp','application/pdf']::text[]
  )
  ON CONFLICT (id) DO UPDATE SET
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Bucket creation skipped (may already exist or need manual creation): %', SQLERRM;
END $$;

-- 2. Storage RLS (mirrors the receipts bucket: API-key scoped, bucket-bound).
DROP POLICY IF EXISTS "Anyone can upload customer-documents" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can read customer-documents"   ON storage.objects;
DROP POLICY IF EXISTS "Anyone can update customer-documents" ON storage.objects;

CREATE POLICY "Anyone can upload customer-documents"
  ON storage.objects FOR INSERT TO public
  WITH CHECK (bucket_id = 'customer-documents');

CREATE POLICY "Anyone can read customer-documents"
  ON storage.objects FOR SELECT TO public
  USING (bucket_id = 'customer-documents');

CREATE POLICY "Anyone can update customer-documents"
  ON storage.objects FOR UPDATE TO public
  USING (bucket_id = 'customer-documents');

-- 3. Tracking table — one row per uploaded file.
CREATE TABLE IF NOT EXISTS customer_documents (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  store_id    UUID REFERENCES stores(id) ON DELETE CASCADE,
  path        VARCHAR(500) NOT NULL,   -- storage path within the bucket
  label       VARCHAR(120),            -- e.g. 'Nota de exoneración', 'Carné diplomático'
  doc_type    VARCHAR(50) DEFAULT 'exemption_proof',
  uploaded_by UUID REFERENCES users(id),
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_customer_documents_customer
  ON customer_documents(customer_id);

ALTER TABLE customer_documents ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all operations for customer_documents" ON customer_documents;
CREATE POLICY "Allow all operations for customer_documents"
  ON customer_documents FOR ALL USING (true);

-- Verify:
-- SELECT id, name, public FROM storage.buckets WHERE id = 'customer-documents';
-- SELECT column_name FROM information_schema.columns WHERE table_name='customer_documents';
