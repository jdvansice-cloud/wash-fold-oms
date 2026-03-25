# Wash & Fold OMS - Development Brief

## Project Overview

A full-stack Order Management System for **American Laundry**, a wash-and-fold laundry business in Panama City. Built with **React 18 + Vite 5 + Supabase + Tailwind CSS**, deployed on **Vercel**. The system handles POS transactions, order workflow tracking (Kanban), customer management, loyalty programs, analytics, thermal receipt printing (WebUSB), and admin settings.

**Locale:** es-PA (Spanish, Panama) | **Currency:** Panamanian Balboa (B/) | **Tax:** ITBMS 7%

---

## Architecture Summary

```
Frontend:  React 18 SPA (Vite 5, ~18K LOC across 29 source files)
State:     React Context + useReducer (AppContext: 656 lines, 50+ actions)
Backend:   Supabase (PostgreSQL + Auth + REST API)
API:       1 Vercel Serverless Function (email via Nodemailer)
Styling:   Tailwind CSS 3.3 + custom component CSS layers
Printer:   WebUSB (Epson TM-T20III, ESC/POS commands)
Deploy:    Vercel (auto-deploy on git push)
```

### Key Files & Sizes

| File | Lines | Responsibility |
|------|-------|---------------|
| `src/pages/SettingsPage.jsx` | **5,124** | 11 settings sections in ONE file |
| `src/components/TicketPanel.jsx` | **1,696** | Order sidebar, calculations, loyalty, printing |
| `src/pages/CustomersPage.jsx` | **1,217** | Customer list, details, edit modals |
| `src/hooks/useDataLoader.js` | **1,150** | All Supabase queries, CRUD, email, loyalty |
| `src/pages/OrdersPage.jsx` | **909** | Order list, filters, detail view |
| `src/pages/EODPage.jsx` | **764** | End-of-day cash reconciliation |
| `src/context/AppContext.jsx` | **656** | Global state monolith (50+ action types) |
| `src/pages/POSScreen.jsx` | **600** | POS product grid, modals |
| `src/pages/AnalyticsPage.jsx` | **570** | Dashboard metrics, comparison |

---

## Current Feature Status

### Working (~85%)
- POS system (product grid, weight/quantity entry, express toggle)
- Order lifecycle (create → pending → washing → drying → folding → ready → completed)
- Kanban board with drag-and-drop status transitions
- Multi-payment processing (cash, card, Yappy, ACH, invoice, pickup, gift card)
- Customer management with Panama-specific validation (cedula, RUC, phone)
- Analytics dashboard with period comparison
- Sales-by-day report with CSV export
- End-of-day cash reconciliation with denomination counting
- Thermal receipt printing via WebUSB
- Email notifications (order created, ready, delivered)
- Staff auth with role-based access (admin/supervisor/operator)
- Promotion codes and manual discounts

### Partially Implemented (~10%)
- **Loyalty system** — Database tables and calculation logic exist, punch card and points earning/redemption coded in TicketPanel, but loyalty settings UI incomplete and integration untested
- **Gift cards** — Database tables exist, payment method listed, but no admin UI for issuance or balance management
- **Reports** — Only "Sales by Day" implemented; "By Product", "By Customer", "Payment Methods" commented out
- **Invoicing** — Table exists, menu item present, but no invoice generation or tracking UI

### Missing (New Requirement)
- **Customer portal** — No customer-facing interface exists
- **Pickup scheduling** — No scheduling system
- **Customer self-registration** — No customer auth flow
- **Real-time order tracking** — No Supabase Realtime subscriptions

---

## Performance Audit

### P0 — Critical

#### 1. No Data Caching Layer
**Problem:** `useDataLoader.js` refetches ALL data on every full page load. No cache, no deduplication, no background refresh. Navigation between pages triggers fresh queries for products, customers, orders, payment methods, and settings — every time.

**Impact:** 5-10 redundant Supabase requests per page navigation. Perceived lag on every click.

**Fix:** Replace with **TanStack Query (React Query v5)**. Provides automatic caching (configurable stale time), request deduplication, background refetching, and optimistic mutations. Eliminates 60-80% of network requests after initial load.

#### 2. Unbounded Order Loading
**Problem:** Initial load fetches up to 500 orders in one request, stored entirely in memory. `OrdersPage` then loads more in 500-order batches. A store with 5,000+ orders will see multi-second loads and high memory usage.

**Fix:** Server-side cursor-based pagination using Supabase `.range()`. Load only visible data + 1 page buffer. Add database indexes on `orders(store_id, created_at DESC)` and `orders(status)`.

#### 3. Ticket Calculations on Every Dispatch
**Problem:** `ticketCalculations()` in `AppContext.jsx` runs on EVERY reducer dispatch — including unrelated actions like toggling the sidebar or setting the active section. The function computes subtotal, discounts, tax (ITBMS), delivery, totals, promised date, weight aggregates.

**Fix:** Extract to `useMemo` scoped to ticket items, discount, express flag, and ITBMS rate. Or isolate into a dedicated `TicketContext` so POS re-renders don't cascade to non-POS pages.

#### 4. N+1 Customer Loyalty Queries
**Problem:** `TicketPanel.jsx` and `CustomersPage.jsx` fetch loyalty data per-customer in separate calls. Listing 50 customers = 51 database calls.

**Fix:** Join loyalty data in customer queries: `.select('*, customer_loyalty(*)')`. Single query returns customer + loyalty data.

### P1 — Important

#### 5. No Code Splitting
**Problem:** All 10 pages and 4 modals are eagerly imported in `App.jsx`. The entire JS bundle downloads on first visit, even if the user only needs the login page.

**Fix:** `React.lazy()` + `Suspense` for route-level code splitting. Expected initial bundle reduction: 40-60%.

#### 6. No Search Debouncing
**Problem:** Search inputs in `OrdersPage`, `CustomersPage`, `POSScreen`, and `CustomerSearchModal` filter on every keystroke. Customer search triggers Supabase queries per character.

**Fix:** `useDebounce` hook (300ms for local filters, 500ms for server queries). Reduces query volume by 70-80% during typing.

#### 7. No Virtual Scrolling
**Problem:** Customer lists, order lists, and product grids render ALL items to DOM. With 1,000+ customers, this causes layout thrashing and slow scroll.

**Fix:** `@tanstack/react-virtual` for lists exceeding 100 items. Renders only visible rows (~30 DOM nodes vs thousands).

#### 8. Unmemoized Filter/Sort Chains
**Problem:** Several pages compute filtered/sorted lists on every render without `useMemo`. `OrdersPage` filters by status, date range, and search term on every state change.

**Fix:** Wrap all `filter()`/`sort()`/`map()` chains in `useMemo` with proper dependency arrays.

### P2 — Best Practice

#### 9. No Error Boundaries
A single component crash takes down the entire app. Add error boundaries at route level and around POS/TicketPanel.

#### 10. Memory Leak Risk
Several components fetch data in `useEffect` without cleanup. Unmounting before fetch completes causes React state-update-on-unmounted-component warnings. Fix with AbortController (or adopt TanStack Query which handles this).

#### 11. No Real-Time Sync
Multi-user scenarios (two operators, manager + cashier) require manual refresh to see order status changes. Enable Supabase Realtime on `orders` and `pickup_requests` tables.

#### 12. Missing Database Indexes
```sql
CREATE INDEX idx_orders_store_created ON orders(store_id, created_at DESC);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_customers_store ON customers(store_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
```

#### 13. WebUSB Printing Blocks UI
`receiptPrinter.js` performs synchronous-style WebUSB operations. Move print job assembly to a Web Worker or use non-blocking async patterns.

#### 14. Console Spam
Extensive `console.log` debugging statements throughout codebase. Strip for production.

---

## Code Quality Assessment

### Structural Problems

| Problem | Scope | Impact |
|---------|-------|--------|
| `SettingsPage.jsx` = 5,124 lines | 35% of all page code in ONE file | Unmaintainable, impossible to review or test |
| `useDataLoader.js` = 1,150 lines | Touches every page | God-hook: data loading, CRUD, email, loyalty, all mixed |
| `AppContext.jsx` = 656 lines, 50+ actions | Global | Monolith context: every dispatch re-renders all consumers |
| 7 duplicated functions | `helpers.js` + `formatters.js` | `formatCurrency`, `formatDate`, etc. exist in both files |
| Zero test coverage | Global | No unit, integration, or E2E tests |
| No TypeScript | Global | Runtime type errors, no IDE autocompletion for DB types |
| No linting config | Global | No ESLint or Prettier — inconsistent code style |

### What's Done Well
- Clean Tailwind theme with consistent design language
- Proper React patterns (hooks, context, controlled components)
- Comprehensive Panama-specific validation (cedula, RUC, phone formats)
- Well-structured database schema with proper foreign keys
- Thermal receipt formatting with ESC/POS commands
- Multi-payment split processing with change calculation

---

## Recommended Dependency Additions

| Category | Package | Purpose |
|----------|---------|---------|
| **Data layer** | `@tanstack/react-query` | Server state, caching, dedup, optimistic updates |
| **Virtual scroll** | `@tanstack/react-virtual` | Efficient rendering for large lists |
| **Type safety** | `typescript` | Gradual migration, DB type generation |
| **Unit testing** | `vitest` + `@testing-library/react` | Business logic and component tests |
| **E2E testing** | `@playwright/test` | Critical flow testing |
| **Linting** | `eslint` + `prettier` | Code consistency |
| **Monitoring** | `@sentry/react` | Error tracking in production |

No new runtime dependencies beyond TanStack Query. Everything else is dev tooling.

---

## Summary

The Wash & Fold OMS has **solid core functionality** and a **well-designed database schema**. The main problems are architectural: a monolithic state management approach, a god-hook for data loading, monster files (SettingsPage at 5K+ lines), zero tests, and no caching layer. These are **structural issues that compound** — they can't be fixed by patching individual files.

The highest-impact improvements are:

1. **TanStack Query** — Eliminates redundant fetches, adds caching (biggest single win)
2. **Context splitting** — Break AppContext monolith into domain-specific contexts
3. **Code splitting** — React.lazy routes cut initial load in half
4. **Database indexes** — Prevent query degradation as data grows
5. **File decomposition** — SettingsPage into 11+ files, TicketPanel into hooks + component

These five changes transform the app from "works for one operator at one store" to "scales reliably for multiple users across locations" — and set the foundation for the new customer portal.
