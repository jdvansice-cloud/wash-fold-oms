-- ============================================================
-- Customer-level ITBMS exemption (exoneración)
-- ============================================================
-- A customer can be flagged tax-exempt (diplomats, exonerated public/NGO
-- entities). When set, the POS zeroes ITBMS for that customer's orders and the
-- emitted factura carries tasa "00" lines. The DGI requires the exemption to be
-- substantiated, so we store the supporting credential metadata here and the
-- scanned images via supabase-customer-documents.sql.
--
-- NOTE: receptor TYPE (gobierno/contribuyente/extranjero) is derived separately
-- from the RUC shape at emit time — tax_exempt is ONLY about zeroing ITBMS.
-- ============================================================

ALTER TABLE customers
  ADD COLUMN IF NOT EXISTS tax_exempt          BOOLEAN DEFAULT false,
  -- diplomatic | public_entity | ngo | other
  ADD COLUMN IF NOT EXISTS tax_exempt_reason   VARCHAR(50),
  -- número de oficio / resolución / nota de exoneración
  ADD COLUMN IF NOT EXISTS tax_exempt_doc_number VARCHAR(120),
  -- issuing authority, e.g. MIRE / MEF / DGI
  ADD COLUMN IF NOT EXISTS tax_exempt_authority  VARCHAR(120),
  ADD COLUMN IF NOT EXISTS tax_exempt_issued_at  DATE,
  ADD COLUMN IF NOT EXISTS tax_exempt_expires_at DATE;

COMMENT ON COLUMN customers.tax_exempt IS 'ITBMS exempt (exonerado): zeroes tax on this customer''s orders. Requires proof (tax_exempt_doc_number + a customer_documents image).';
COMMENT ON COLUMN customers.tax_exempt_reason IS 'diplomatic | public_entity | ngo | other';
COMMENT ON COLUMN customers.tax_exempt_doc_number IS 'Número de oficio / resolución / nota de exoneración that authorizes the exemption.';
COMMENT ON COLUMN customers.tax_exempt_authority IS 'Authority that issued the exemption (MIRE/Cancillería for diplomats, MEF/DGI for entities).';

-- Verify:
-- SELECT column_name, data_type FROM information_schema.columns
-- WHERE table_name='customers' AND column_name LIKE 'tax_exempt%';
