-- ============================================================
-- Search performance: pg_trgm indexes  (Roadmap Phase E)
-- ============================================================
-- Order and customer search use `ILIKE '%term%'` (leading wildcard), which a
-- btree can't serve — it falls back to a sequential scan. GIN trigram indexes
-- make these substring searches index-backed. Also adds a (store_id, created_at)
-- index for the lazy "recent customers" load that replaces eager-loading every
-- customer at startup. Idempotent.
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Order search (searchOrders): customer_name + legacy_order_number, ILIKE.
CREATE INDEX IF NOT EXISTS orders_customer_name_trgm
  ON orders USING gin (customer_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS orders_legacy_number_trgm
  ON orders USING gin (legacy_order_number gin_trgm_ops);

-- Customer search (POS quick-select + Clientes + B2B billing).
CREATE INDEX IF NOT EXISTS customers_first_name_trgm
  ON customers USING gin (first_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS customers_last_name_trgm
  ON customers USING gin (last_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS customers_company_trgm
  ON customers USING gin (company_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS customers_phone_trgm
  ON customers USING gin (phone gin_trgm_ops);

-- Recent-customers list (lazy initial load + search empty state).
CREATE INDEX IF NOT EXISTS customers_store_created_idx
  ON customers (store_id, created_at DESC);

-- Full-name search: match against the concatenated "first last company" so a
-- query like "Richard Emerson" (first + last) hits, which per-column ILIKE
-- can't. Expression trgm index backs it.
CREATE INDEX IF NOT EXISTS customers_fullname_trgm
  ON customers USING gin (
    (coalesce(first_name, '') || ' ' || coalesce(last_name, '') || ' ' || coalesce(company_name, '')) gin_trgm_ops
  );

-- search_customers(): full-name + company + phone substring search, RLS-scoped
-- (SECURITY INVOKER → the caller's customers RLS still applies).
CREATE OR REPLACE FUNCTION search_customers(p_store_id uuid, p_q text, p_limit int DEFAULT 25)
  RETURNS SETOF customers
  LANGUAGE sql STABLE SECURITY INVOKER SET search_path = public AS $$
  SELECT *
  FROM customers
  WHERE store_id = p_store_id
    AND is_active = true
    AND (
      (coalesce(first_name, '') || ' ' || coalesce(last_name, '') || ' ' || coalesce(company_name, ''))
        ILIKE '%' || p_q || '%'
      OR coalesce(phone, '') ILIKE '%' || p_q || '%'
    )
  ORDER BY first_name
  LIMIT least(greatest(p_limit, 1), 50);
$$;

-- Verify:
-- EXPLAIN SELECT * FROM orders WHERE store_id = '...' AND customer_name ILIKE '%lara%';
-- SELECT first_name, last_name FROM search_customers('<store>', 'richard emerson', 10);
