-- ============================================================
-- GO-LIVE DATA WIPE — transactional data only  (run ONCE, at go-live)
-- ============================================================
-- Replaces the OLD supabase-cleanup-fresh-start.sql, which did
-- `TRUNCATE stores CASCADE; TRUNCATE companies CASCADE` — that cascades into
-- EVERY referencing table and would destroy users, products, payment_methods,
-- sections, machines, loyalty_settings, and the company_efactura/smtp/whatsapp
-- config. DO NOT run that one.
--
-- This wipes only TEST TRANSACTIONS and PRESERVES all configuration:
--   preserved: companies, stores, users, products, sections, payment_methods,
--              machines, loyalty_settings, company_efactura_config,
--              company_smtp, company_whatsapp, customers (see note).
--   wiped:     orders, order_items, payments, refunds, electronic_invoices,
--              b2b_invoices, eod_closings, gift_cards (+ tx),
--              loyalty_transactions, customer_loyalty (balances),
--              machine_usage, machine_maintenance, time_entries,
--              stock_movements, pickup_requests.
--
-- CASCADE here only reaches the transactional set (no preserved/config table
-- references these), and RESTART IDENTITY resets their own identity columns.
-- Run inside a transaction so it's all-or-nothing.
-- ============================================================

BEGIN;

TRUNCATE TABLE
  orders,
  order_items,
  payments,
  refunds,
  electronic_invoices,
  b2b_invoices,
  eod_closings,
  gift_cards,
  gift_card_transactions,
  loyalty_transactions,
  customer_loyalty,
  machine_usage,
  machine_maintenance,
  time_entries,
  stock_movements,
  pickup_requests
RESTART IDENTITY CASCADE;

-- Order numbers are a GLOBAL sequence shared by both stores. Restart at 1 so the
-- first real sale is #1. (Comment this out to keep numbering continuous from the
-- current value.)
ALTER SEQUENCE orders_order_number_seq RESTART WITH 1;

-- Customers: PRESERVED by default (keeps the imported CleanCloud customer base).
-- To also wipe the customer roster for a truly blank start, uncomment:
--   TRUNCATE TABLE customers CASCADE;   -- also clears customer_loyalty/orders links

COMMIT;

-- ---- Verify config survived + transactions are empty -------------------------
-- SELECT 'companies' t, count(*) FROM companies
-- UNION ALL SELECT 'stores', count(*) FROM stores
-- UNION ALL SELECT 'users', count(*) FROM users
-- UNION ALL SELECT 'products', count(*) FROM products
-- UNION ALL SELECT 'payment_methods', count(*) FROM payment_methods
-- UNION ALL SELECT 'sections', count(*) FROM sections
-- UNION ALL SELECT 'company_efactura_config', count(*) FROM company_efactura_config
-- UNION ALL SELECT 'customers', count(*) FROM customers
-- UNION ALL SELECT 'orders (should be 0)', count(*) FROM orders
-- UNION ALL SELECT 'payments (should be 0)', count(*) FROM payments
-- UNION ALL SELECT 'gift_cards (should be 0)', count(*) FROM gift_cards;
