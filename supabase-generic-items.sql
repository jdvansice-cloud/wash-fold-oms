-- ============================================================
-- Generic (ad-hoc) sale lines
-- ============================================================
-- A "venta genérica" is an order_items row with product_id = NULL: the cashier
-- types a description, the final sale price and whether it carries ITBMS.
-- Since there is no product row to look the tax flag up from, persist it on
-- the line so the factura electrónica can mark exempt lines with tasa 00
-- instead of defaulting to taxable. NULL = unknown → treated as taxable
-- (matches all pre-existing rows, whose flag lives on their product).
-- Idempotent.
-- ============================================================

ALTER TABLE order_items ADD COLUMN IF NOT EXISTS is_taxable boolean;

-- EOD "Ventas genéricas (supervisión)" queries lines by product_id IS NULL for
-- a day's orders; the join is driven from orders (store+date indexes exist),
-- so no extra index is needed at this scale.
