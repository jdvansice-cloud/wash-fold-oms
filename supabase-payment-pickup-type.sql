-- ============================================================
-- "Pagar al recoger" as a first-class deferred payment type
-- ============================================================
-- Pay-on-pickup means the money is collected later, when the customer picks up
-- the order — so at checkout it must be an EXCLUSIVE term (the whole sale is
-- pay-on-pickup or it isn't), it emits NO electronic invoice, and it must NOT
-- count as collected in the EOD (it's pending).
--
-- We model it as a dedicated payment_type='pickup' on payment_methods so the
-- checkout, e-factura, and EOD code can detect it by type (robust against the
-- method being renamed). Idempotent + transactional.
-- ============================================================

BEGIN;

-- Allow the new type.
ALTER TABLE payment_methods DROP CONSTRAINT IF EXISTS payment_methods_payment_type_check;
ALTER TABLE payment_methods ADD CONSTRAINT payment_methods_payment_type_check
  CHECK (payment_type IN ('cash', 'card', 'other', 'pickup'));

-- Re-type any existing pay-on-pickup method.
UPDATE payment_methods
   SET payment_type = 'pickup'
 WHERE payment_type IS DISTINCT FROM 'pickup'
   AND (name ILIKE '%recoger%' OR name ILIKE '%al retirar%' OR name ILIKE '%pickup%');

COMMIT;

-- Verify:
-- SELECT name, payment_type, is_active FROM payment_methods WHERE payment_type='pickup';
