-- ============================================================
-- Per-store E-Factura configuration  (Roadmap Phase B)
-- ============================================================
-- Each store/location is its own DGI "punto de facturación" under the company
-- RUC, so e-factura config moves from per-COMPANY to per-STORE. The company RUC
-- and DV are auto-filled by the PAC from the API key; what differs per location
-- is the `punto_facturacion` (e.g. '001', '002') and optionally the API key /
-- environment.
--
-- Migration: re-keys company_efactura_config from (company_id) to (store_id),
-- replicating the existing company-level config to every active store so no
-- store loses e-factura. company_id stays on each row for tenant RLS.
--
-- ⚠️ AFTER APPLYING: set each additional store's real `punto_facturacion` in
--    Settings → Facturación Electrónica (two stores can't share '001' under the
--    same RUC in production). Disable e-factura on any store that shouldn't emit.
--
-- Idempotent (re-key runs only while company-level rows still exist),
-- transactional. The proxy already reads per-store-first with a company-level
-- fallback, so emission keeps working before and after this is applied.
-- ============================================================

BEGIN;

ALTER TABLE company_efactura_config
  ADD COLUMN IF NOT EXISTS store_id UUID REFERENCES stores(id) ON DELETE CASCADE;

DO $$
BEGIN
  -- Only migrate while there are still company-level (store_id IS NULL) rows.
  IF EXISTS (SELECT 1 FROM company_efactura_config WHERE store_id IS NULL) THEN
    -- Allow multiple rows per company.
    ALTER TABLE company_efactura_config DROP CONSTRAINT IF EXISTS company_efactura_config_pkey;

    -- Replicate each company-level config to every active store of that company.
    INSERT INTO company_efactura_config
      (store_id, company_id, api_key, environment, punto_facturacion,
       default_cpbs_code, default_cpbs_code_short, enabled, created_at, updated_at)
    SELECT s.id, c.company_id, c.api_key, c.environment, c.punto_facturacion,
           c.default_cpbs_code, c.default_cpbs_code_short, c.enabled, now(), now()
    FROM company_efactura_config c
    JOIN stores s ON s.company_id = c.company_id AND s.is_active = true
    WHERE c.store_id IS NULL
      AND NOT EXISTS (SELECT 1 FROM company_efactura_config x WHERE x.store_id = s.id);

    -- Drop the old company-level rows.
    DELETE FROM company_efactura_config WHERE store_id IS NULL;

    -- New primary key on store_id.
    ALTER TABLE company_efactura_config ALTER COLUMN store_id SET NOT NULL;
    ALTER TABLE company_efactura_config ADD PRIMARY KEY (store_id);
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS company_efactura_config_company_idx
  ON company_efactura_config (company_id);

COMMIT;

-- Verify (after COMMIT):
-- SELECT s.name, c.punto_facturacion, c.environment, c.enabled, (c.api_key IS NOT NULL) AS has_key
-- FROM company_efactura_config c JOIN stores s ON s.id = c.store_id ORDER BY s.name;
