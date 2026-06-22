-- ============================================================
-- Payment method "type" — drives the POS payment screen per method
-- ============================================================
-- Adds payment_type to payment_methods so the checkout flow knows which
-- form to show: cash (denominations + change), card (amount + reference),
-- or other (generic amount). Gift card and loyalty-points tenders are
-- handled as built-in app features, not rows here.
--
-- Idempotent. Existing rows are backfilled from their name.
-- ============================================================

BEGIN;

ALTER TABLE payment_methods
  ADD COLUMN IF NOT EXISTS payment_type VARCHAR(20) NOT NULL DEFAULT 'other'
    CHECK (payment_type IN ('cash', 'card', 'other'));

-- Backfill from the method name (only rows still at the default).
UPDATE payment_methods
SET payment_type = 'cash'
WHERE payment_type = 'other'
  AND name ~* '(efectivo|cash)';

UPDATE payment_methods
SET payment_type = 'card'
WHERE payment_type = 'other'
  AND name ~* '(tarjeta|card|visa|master|clave|d[eé]bito|cr[eé]dito)';

COMMIT;

-- Verify:
-- SELECT name, payment_type FROM payment_methods ORDER BY display_order;
