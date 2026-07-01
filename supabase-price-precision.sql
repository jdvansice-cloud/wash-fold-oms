-- ============================================================
-- Tax-inclusive price precision
-- ============================================================
-- Products are priced by entering the FINAL, ITBMS-included price; the app
-- stores the ex-ITBMS BASE (price / 1.07). At numeric(10,2) the base was
-- rounded to 2 decimals (e.g. 2.50 incl -> base 2.34), so base * 1.07 no longer
-- reconstructed 2.50 and a "1 cent" drift appeared on weight lines and totals.
--
-- Widen the base-price columns so the ex-tax base keeps enough precision for
-- base * 1.07 to round-trip to the entered inclusive price. Order totals and the
-- DGI factura are unaffected (they reconcile off the 2-decimal order.total).
-- Idempotent.
-- ============================================================

ALTER TABLE products ALTER COLUMN price         TYPE numeric(12,6);
ALTER TABLE products ALTER COLUMN express_price TYPE numeric(12,6);

-- Repair existing TAXABLE products: re-derive the base from the inclusive price
-- they were meant to represent (round2(base*1.07)), at full precision. Leaves
-- non-taxable products (whose stored price is the actual price) untouched.
UPDATE products
   SET price = ROUND(ROUND(price * 1.07, 2) / 1.07, 6)
 WHERE is_taxable IS NOT FALSE
   AND price IS NOT NULL
   AND price > 0;

UPDATE products
   SET express_price = ROUND(ROUND(express_price * 1.07, 2) / 1.07, 6)
 WHERE is_taxable IS NOT FALSE
   AND express_price IS NOT NULL
   AND express_price > 0;

-- NOTE: 1.07 hardcodes the 7% ITBMS rate used across the app's price helpers.
-- Verify:
-- SELECT id, name, price, ROUND(price*1.07,2) AS incl FROM products WHERE is_taxable IS NOT FALSE LIMIT 10;
