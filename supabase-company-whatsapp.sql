-- ============================================================
-- Per-company WhatsApp (Meta Cloud API) config
-- ============================================================
-- Direct Meta Cloud API (cheapest: no BSP fee, Meta hosts free, pay per message;
-- service replies free). One config per company; the access token is a secret
-- read server-side only. Admin-only, mirroring company_smtp / company_efactura.
-- Idempotent.
-- ============================================================

CREATE TABLE IF NOT EXISTS company_whatsapp (
  company_id           UUID PRIMARY KEY REFERENCES companies(id) ON DELETE CASCADE,
  provider             VARCHAR(20) NOT NULL DEFAULT 'meta',
  phone_number_id      VARCHAR(50),
  access_token         TEXT,
  waba_id              VARCHAR(50),
  default_country_code VARCHAR(8) DEFAULT '507',
  enabled              BOOLEAN NOT NULL DEFAULT false,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE company_whatsapp ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS company_whatsapp_admin ON company_whatsapp;
CREATE POLICY company_whatsapp_admin ON company_whatsapp FOR ALL
  USING (company_id = auth_company_id() AND auth_is_admin())
  WITH CHECK (company_id = auth_company_id() AND auth_is_admin());

-- Verify:
-- SELECT company_id, enabled, phone_number_id, (access_token IS NOT NULL) AS has_token FROM company_whatsapp;
