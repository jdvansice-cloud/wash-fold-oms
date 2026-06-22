-- ============================================================
-- Analytics cockpit aggregations  (Roadmap Phase F #6)
-- ============================================================
-- DB-side aggregations so the owner dashboard is accurate over the full history
-- (the client only keeps ~recent orders in memory). All SECURITY INVOKER, so the
-- caller's RLS on orders/payments/order_items still scopes them to their stores.
-- Idempotent.
-- ============================================================

-- Daily net revenue + order count over a range (Panama local day).
CREATE OR REPLACE FUNCTION analytics_daily_revenue(p_store uuid, p_start timestamptz, p_end timestamptz)
  RETURNS TABLE(day date, revenue numeric, orders bigint)
  LANGUAGE sql STABLE SECURITY INVOKER SET search_path = public AS $$
  SELECT (created_at AT TIME ZONE 'America/Panama')::date AS day,
         COALESCE(sum(total), 0) AS revenue,
         count(*) AS orders
  FROM orders
  WHERE store_id = p_store
    AND created_at >= p_start AND created_at <= p_end
    AND status NOT IN ('refund', 'cancelled', 'refunded')
  GROUP BY 1
  ORDER BY 1;
$$;

-- Top services by revenue over a range.
CREATE OR REPLACE FUNCTION analytics_top_services(p_store uuid, p_start timestamptz, p_end timestamptz, p_limit int DEFAULT 5)
  RETURNS TABLE(product_name text, qty numeric, revenue numeric)
  LANGUAGE sql STABLE SECURITY INVOKER SET search_path = public AS $$
  SELECT COALESCE(oi.product_name, 'Otro') AS product_name,
         sum(oi.quantity) AS qty,
         sum(oi.line_total) AS revenue
  FROM order_items oi
  JOIN orders o ON o.id = oi.order_id
  WHERE o.store_id = p_store
    AND o.created_at >= p_start AND o.created_at <= p_end
    AND o.status NOT IN ('refund', 'cancelled', 'refunded')
  GROUP BY 1
  ORDER BY revenue DESC
  LIMIT least(greatest(p_limit, 1), 20);
$$;

-- Payment mix (collected, by method) over a range.
CREATE OR REPLACE FUNCTION analytics_payment_mix(p_store uuid, p_start timestamptz, p_end timestamptz)
  RETURNS TABLE(method text, amount numeric)
  LANGUAGE sql STABLE SECURITY INVOKER SET search_path = public AS $$
  SELECT COALESCE(p.payment_method, 'Otro') AS method, sum(p.amount) AS amount
  FROM payments p
  JOIN orders o ON o.id = p.order_id
  WHERE o.store_id = p_store
    AND p.created_at >= p_start AND p.created_at <= p_end
  GROUP BY 1
  ORDER BY amount DESC;
$$;

-- Verify:
-- SELECT * FROM analytics_daily_revenue('<store>', now() - interval '7 days', now());
-- SELECT * FROM analytics_top_services('<store>', now() - interval '30 days', now(), 5);
