-- ============================================================
-- E-Factura (Panama DGI / efacturapty PAC) — Phase 1 schema
-- ============================================================
-- Adds:
--   1. company_efactura_config — per-company PAC credentials & settings
--      (secrets table, mirrors company_smtp; never publicly readable).
--   2. electronic_invoices — one row per emitted factura / nota de crédito,
--      tracking the emission lifecycle and the PAC/DGI response (CUFE, QR…).
--   3. CPBS product-codification columns on products.
--
-- Tenant isolation reuses the helper functions from
-- supabase-fix-rls-tenant-isolation.sql (auth_company_id, auth_store_ids,
-- auth_is_staff). The emission worker uses the service-role key, which
-- bypasses RLS.
--
-- Idempotent and transactional. Safe to re-run. TEST ON A BACKUP FIRST.
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- 1. Per-company PAC configuration (secrets — staff-only)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS company_efactura_config (
  company_id          UUID PRIMARY KEY REFERENCES companies(id) ON DELETE CASCADE,
  -- efacturapty API key, sent server-side as `Authorization: Bearer <key>`.
  api_key             TEXT,
  -- 'test' (ambiente de pruebas, iAmb=2) or 'prod' (fiscal).
  environment         TEXT NOT NULL DEFAULT 'test'
                        CHECK (environment IN ('test', 'prod')),
  punto_facturacion   TEXT NOT NULL DEFAULT '001',
  -- Default DGI product/service codification for laundry line items
  -- (codigoItemCodificacionPanamena / ...Abreviada). Pick from Catalogs/CPBS*.
  default_cpbs_code        INTEGER,
  default_cpbs_code_short  INTEGER,
  -- Master switch: auto-emission only runs when this is true.
  enabled             BOOLEAN NOT NULL DEFAULT false,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE company_efactura_config ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS company_efactura_config_staff ON company_efactura_config;
CREATE POLICY company_efactura_config_staff ON company_efactura_config FOR ALL
  USING (company_id = auth_company_id() AND auth_is_staff())
  WITH CHECK (company_id = auth_company_id() AND auth_is_staff());

-- ------------------------------------------------------------
-- 2. Emitted electronic documents
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS electronic_invoices (
  id                      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id                UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  order_id                UUID REFERENCES orders(id) ON DELETE SET NULL,
  refund_id               UUID REFERENCES refunds(id) ON DELETE SET NULL,

  -- tipoDocumento: 01 factura, 06 nota de crédito, 07 nota de débito.
  doc_type                VARCHAR(2) NOT NULL DEFAULT '01',
  -- Environment the document was emitted into (snapshotted from config).
  environment             TEXT NOT NULL DEFAULT 'test'
                            CHECK (environment IN ('test', 'prod')),

  status                  TEXT NOT NULL DEFAULT 'pending'
                            CHECK (status IN
                              ('pending', 'emitting', 'authorized', 'rejected', 'cancelled')),

  -- PAC / DGI response
  cufe                    TEXT,
  protocolo_autorizacion  TEXT,
  fecha_autorizacion      TIMESTAMPTZ,
  qr_content              TEXT,
  cafe_pdf_path           TEXT,   -- path in the receipts storage bucket
  -- For a nota de crédito: the CUFE of the factura it amends.
  referenced_cufe         TEXT,

  -- Auditing / retries
  request_payload         JSONB,
  response_payload        JSONB,
  error                   TEXT,
  attempts                INTEGER NOT NULL DEFAULT 0,
  emitted_at              TIMESTAMPTZ,

  created_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at              TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS electronic_invoices_store_idx  ON electronic_invoices (store_id);
CREATE INDEX IF NOT EXISTS electronic_invoices_order_idx  ON electronic_invoices (order_id);
CREATE INDEX IF NOT EXISTS electronic_invoices_status_idx ON electronic_invoices (status);
CREATE UNIQUE INDEX IF NOT EXISTS electronic_invoices_cufe_idx
  ON electronic_invoices (cufe) WHERE cufe IS NOT NULL;

-- Idempotency: at most one *active* factura per order. A rejected attempt can
-- be retried (it is excluded), and a cancelled document frees the slot.
CREATE UNIQUE INDEX IF NOT EXISTS electronic_invoices_one_active_factura
  ON electronic_invoices (order_id)
  WHERE doc_type = '01' AND order_id IS NOT NULL
    AND status IN ('pending', 'emitting', 'authorized');

ALTER TABLE electronic_invoices ENABLE ROW LEVEL SECURITY;

-- Read: staff of the store, or the customer who owns the linked order
-- (orders RLS already scopes `SELECT id FROM orders` to the caller).
DROP POLICY IF EXISTS electronic_invoices_read ON electronic_invoices;
CREATE POLICY electronic_invoices_read ON electronic_invoices FOR SELECT
  USING (
    store_id IN (SELECT auth_store_ids())
    OR order_id IN (SELECT id FROM orders)
  );

-- Write: staff of the store. (The worker uses the service-role key and bypasses
-- RLS for the actual PAC emission / status updates.)
DROP POLICY IF EXISTS electronic_invoices_staff ON electronic_invoices;
CREATE POLICY electronic_invoices_staff ON electronic_invoices FOR ALL
  USING (store_id IN (SELECT auth_store_ids()) AND auth_is_staff())
  WITH CHECK (store_id IN (SELECT auth_store_ids()) AND auth_is_staff());

-- ------------------------------------------------------------
-- 3. CPBS product codification on products
-- ------------------------------------------------------------
ALTER TABLE products
  ADD COLUMN IF NOT EXISTS cpbs_code       INTEGER,
  ADD COLUMN IF NOT EXISTS cpbs_code_short INTEGER;

COMMIT;

-- ------------------------------------------------------------
-- Verification (run after COMMIT)
-- ------------------------------------------------------------
-- SELECT table_name FROM information_schema.tables
--   WHERE table_name IN ('company_efactura_config','electronic_invoices');
-- SELECT policyname, tablename FROM pg_policies
--   WHERE tablename IN ('company_efactura_config','electronic_invoices');
-- SELECT column_name FROM information_schema.columns
--   WHERE table_name='products' AND column_name LIKE 'cpbs%';
