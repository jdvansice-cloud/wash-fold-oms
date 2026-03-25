# Wash & Fold OMS - Implementation Plan

## Recommendation: Progressive Rebuild

### Why Not "Just Refactor"?

The codebase has **structural problems that compound** — isolated file-level fixes won't resolve them:

| Problem | Scope | Why Refactoring Fails |
|---------|-------|----------------------|
| SettingsPage.jsx (5,124 lines) | 1 file = 35% of all page code | Can't incrementally fix a file this large without breaking it |
| useDataLoader.js (1,150 lines) | Touches every page | Refactoring the data layer means rewriting every consumer anyway |
| 7 duplicated functions (formatters.js + helpers.js) | Global | Consolidating requires touching every import site |
| No tests | Global | Refactoring without tests = gambling. Writing tests for current architecture = wasted effort |
| AppContext monolith (656 lines, 50+ actions) | Global | Splitting context re-renders every component that consumes it |
| Customer portal needs separate auth flow | Architecture | Current auth assumes staff-only. Adding customer role touches AuthContext, routing, RLS |

### Why Not "Full Rewrite from Scratch"?

Significant assets worth preserving:
- **Supabase schema** — 17+ tables with proper foreign keys, well-designed for the domain
- **Business logic** — Ticket calculations, ITBMS tax, loyalty points/punch cards, receipt formatting
- **UI/UX design** — Tailwind theme, color palette, component styling, layout patterns
- **Receipt printer** — WebUSB/ESC-POS integration is battle-tested and working
- **Vercel deployment** — Infrastructure is configured and running
- **Domain knowledge** — Panama-specific validation (cedula, RUC, phone), localization, denomination counting

### The Approach: Rebuild the Shell, Migrate the Logic

| Keep | Rebuild | Build New |
|------|---------|-----------|
| Database schema + migrations | Application architecture | Customer portal |
| Supabase config + RLS | Routing (two route trees) | Pickup scheduling |
| Tailwind theme + CSS | State management | Customer auth flow |
| Vercel config | Data layer (TanStack Query) | TypeScript types |
| Business logic algorithms | Component structure | Test suite |
| Receipt printer commands | Auth system (staff + customer) | Real-time subscriptions |
| UI design language | File organization | CI/CD pipeline |

---

## Architecture: Before vs After

### Current
```
main.jsx
  └─ AppProvider (656-line monolith, 50+ actions, recalculates on every dispatch)
      └─ AuthProvider (staff-only, no customer support)
          └─ App.jsx (all routes eagerly imported, no code splitting)
              └─ useDataLoader (1,150 lines, fetches everything on mount)
                  └─ Pages (direct Supabase calls scattered + context consumption)
```

### Target
```
main.tsx
  └─ QueryClientProvider (TanStack Query — caching, dedup, background refresh)
      └─ AuthProvider (supports staff + customer roles)
          └─ RouterProvider (React Router v6, lazy-loaded route trees)
              ├─ /staff/*  → StaffLayout + staff pages
              │     └─ Domain hooks: useOrders(), useCustomers(), useProducts(), useTicket()
              └─ /portal/* → PortalLayout + customer pages
                    └─ Domain hooks: useMyOrders(), useMyLoyalty(), usePickupSlots()
```

### Key Architectural Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Data layer | TanStack Query v5 | Replaces useDataLoader entirely. Caching, dedup, background refresh, optimistic mutations |
| Server state | TanStack Query cache | No more storing orders/customers/products in Context |
| UI state | Small focused Contexts | UIContext (sidebar, modals), ToastContext. No AppContext monolith |
| POS state | useTicket hook (local) | Ticket is local to POS screen, not global |
| Routing | React Router v6 lazy routes | Two route trees: `/staff/*` and `/portal/*` with per-page code splitting |
| Types | TypeScript (gradual) | New files in `.tsx`. Migrate existing files as touched |
| Auth | Supabase Auth + RLS + role detection | Staff → `users` table lookup. Customer → `customer_auth` → `customers` table |
| Validation | Centralized `/lib/validation.ts` | Extracted from scattered locations in helpers.js, formatters.js, components |
| Testing | Vitest + React Testing Library | Business logic first, then critical UI flows |

---

## Database Changes for Customer Portal

### New Tables
```sql
-- Links Supabase Auth accounts to customer records
CREATE TABLE customer_auth (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  auth_id UUID UNIQUE NOT NULL,
  customer_id UUID REFERENCES customers(id) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Weekly pickup schedule per store
CREATE TABLE pickup_schedules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id UUID REFERENCES stores(id) NOT NULL,
  day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  slot_duration_minutes INT NOT NULL DEFAULT 30,
  max_pickups_per_slot INT NOT NULL DEFAULT 3,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Blocked dates (holidays, closures)
CREATE TABLE pickup_blocked_dates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id UUID REFERENCES stores(id) NOT NULL,
  blocked_date DATE NOT NULL,
  reason TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Customer pickup requests
CREATE TABLE pickup_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id UUID REFERENCES stores(id) NOT NULL,
  customer_id UUID REFERENCES customers(id) NOT NULL,
  order_id UUID REFERENCES orders(id),
  requested_date DATE NOT NULL,
  requested_time_slot TIME NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','confirmed','picked_up','cancelled')),
  address_line TEXT,
  district TEXT,
  city TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### New Indexes
```sql
CREATE INDEX idx_orders_store_created ON orders(store_id, created_at DESC);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_customers_store ON customers(store_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_pickup_requests_customer ON pickup_requests(customer_id, requested_date);
CREATE INDEX idx_pickup_requests_store_date ON pickup_requests(store_id, requested_date, status);
CREATE INDEX idx_pickup_schedules_store ON pickup_schedules(store_id, day_of_week);
CREATE INDEX idx_customer_auth_auth ON customer_auth(auth_id);
```

### New RLS Policies
```sql
-- Customers see only their own data
ALTER TABLE pickup_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "customers_own_pickups" ON pickup_requests
  FOR ALL USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

CREATE POLICY "customers_own_orders" ON orders
  FOR SELECT USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

CREATE POLICY "customers_own_loyalty" ON customer_loyalty
  FOR SELECT USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

CREATE POLICY "public_read_schedules" ON pickup_schedules
  FOR SELECT USING (is_active = true);
```

---

## Target File Structure

```
src/
├── main.tsx                          # Entry: QueryClient + AuthProvider + RouterProvider
├── router.tsx                        # Route definitions (staff + portal, lazy-loaded)
│
├── lib/
│   ├── supabase.ts                   # Supabase client (kept, add types)
│   ├── queryClient.ts                # TanStack Query config
│   └── validation.ts                 # All validators consolidated
│
├── types/
│   ├── database.ts                   # Supabase-generated types
│   ├── ticket.ts                     # POS ticket types
│   └── pickup.ts                     # Pickup scheduling types
│
├── utils/
│   ├── formatters.ts                 # SINGLE source: currency, date, phone, weight
│   ├── calculations.ts              # Tax, discount, ticket totals (extracted from AppContext)
│   └── receiptPrinter.ts            # WebUSB printer (refactored, class-based)
│
├── hooks/
│   ├── queries/                      # TanStack Query hooks (replaces useDataLoader)
│   │   ├── useOrders.ts
│   │   ├── useCustomers.ts
│   │   ├── useProducts.ts
│   │   ├── useLoyalty.ts
│   │   ├── usePaymentMethods.ts
│   │   ├── usePickupSchedule.ts
│   │   └── usePickupRequests.ts
│   ├── useTicket.ts                  # POS ticket state (local, not global)
│   ├── useAuth.ts                    # Auth hook (staff + customer)
│   └── usePrinter.ts                # Printer connection state
│
├── contexts/
│   ├── AuthContext.tsx                # Auth only (supports two roles)
│   ├── UIContext.tsx                  # Sidebar, active section, modals
│   └── ToastContext.tsx              # Toast notifications
│
├── components/
│   ├── ui/                           # Shared primitives
│   │   ├── Button.tsx, Modal.tsx, Input.tsx, Badge.tsx
│   │   ├── Spinner.tsx, ErrorBoundary.tsx, EmptyState.tsx
│   │   └── ...
│   ├── staff/                        # Staff-specific
│   │   ├── Layout.tsx, Header.tsx, Sidebar.tsx
│   │   ├── TicketPanel.tsx           # Slimmed: uses useTicket + useLoyalty
│   │   ├── CustomerSearchModal.tsx
│   │   ├── PaymentModal.tsx
│   │   ├── WeightEntryModal.tsx
│   │   └── ChildProductsModal.tsx
│   └── portal/                       # Customer portal
│       ├── PortalLayout.tsx, PortalHeader.tsx
│       ├── PickupCalendar.tsx, TimeSlotPicker.tsx
│       ├── OrderCard.tsx, OrderTimeline.tsx
│       └── LoyaltyCard.tsx
│
├── pages/
│   ├── staff/
│   │   ├── POSScreen.tsx
│   │   ├── OrdersPage.tsx
│   │   ├── MachinesPage.tsx
│   │   ├── CustomersPage.tsx
│   │   ├── AnalyticsPage.tsx
│   │   ├── ReportsPage.tsx
│   │   ├── EODPage.tsx
│   │   └── settings/                 # SettingsPage EXPLODED into 11+ files
│   │       ├── index.tsx             # Shell + tab navigation only
│   │       ├── CompanySettings.tsx
│   │       ├── StoreSettings.tsx
│   │       ├── WorkflowSettings.tsx
│   │       ├── UsersSettings.tsx
│   │       ├── PaymentSettings.tsx
│   │       ├── PrinterSettings.tsx
│   │       ├── NotificationSettings.tsx
│   │       ├── ProductSettings.tsx
│   │       ├── PromotionSettings.tsx
│   │       ├── GiftCardSettings.tsx
│   │       ├── LoyaltySettings.tsx
│   │       └── PickupScheduleSettings.tsx  # NEW
│   ├── portal/
│   │   ├── PortalDashboard.tsx       # Active orders + loyalty + pickup CTA
│   │   ├── SchedulePickup.tsx        # Calendar → slots → address → confirm
│   │   ├── MyOrders.tsx              # Active + completed tabs
│   │   ├── OrderDetail.tsx           # Status timeline
│   │   ├── MyLoyalty.tsx             # Points + punch card
│   │   └── MyProfile.tsx            # Edit info, change password
│   └── auth/
│       ├── StaffLogin.tsx
│       ├── CustomerLogin.tsx          # NEW
│       ├── CustomerRegister.tsx       # NEW
│       ├── SetPassword.tsx
│       └── ForgotPassword.tsx
│
└── index.css                         # Kept (Tailwind + custom classes)
```

---

## Implementation Phases

### Phase 1: Foundation (Infrastructure + Auth + Data Layer)
**Goal:** New architecture running. Both staff and customer auth working. Data flows through TanStack Query.

#### 1.1 Project Setup
- [ ] Install: `@tanstack/react-query`, `typescript`, `vitest`, `@testing-library/react`, `eslint`, `prettier`
- [ ] Add `tsconfig.json` (strict mode, path aliases `@/` → `src/`)
- [ ] Add `.eslintrc.cjs` + `.prettierrc`
- [ ] Generate `/src/types/database.ts` from Supabase schema
- [ ] Create `/src/lib/queryClient.ts`

#### 1.2 Shared Utilities (Deduplicate)
- [ ] Create `/src/utils/formatters.ts` — consolidate all 7 duplicated functions
- [ ] Create `/src/utils/calculations.ts` — extract `ticketCalculations` from AppContext (101 lines of pure logic)
- [ ] Create `/src/lib/validation.ts` — consolidate cedula, RUC, phone validators
- [ ] Create `/src/components/ui/` primitives (Modal, Button, Input, Badge, Spinner, ErrorBoundary)
- [ ] Write unit tests for formatters, calculations, validators (**first tests in the project**)

#### 1.3 Auth Rebuild
- [ ] Run database migrations: `customer_auth` table, new RLS policies
- [ ] Rebuild `/src/contexts/AuthContext.tsx`:
  - `staff` role → looked up in `users` table (existing flow)
  - `customer` role → looked up in `customer_auth` → `customers` table (new flow)
- [ ] Create `/src/hooks/useAuth.ts`
- [ ] Build `/src/pages/auth/CustomerLogin.tsx` + `CustomerRegister.tsx`
- [ ] Build `/src/router.tsx` with two lazy-loaded route trees:
  - `/staff/*` — protected by staff role
  - `/portal/*` — protected by customer role
  - `/login`, `/portal/login`, `/portal/register` — public

#### 1.4 Data Layer (Replace useDataLoader)
- [ ] Create TanStack Query hooks:
  - `useOrders.ts` — paginated, filterable, cached
  - `useCustomers.ts` — search, CRUD, joined loyalty data
  - `useProducts.ts` — sections + products
  - `useLoyalty.ts` — consolidated loyalty logic (currently duplicated 3x)
  - `usePaymentMethods.ts`
- [ ] Each hook: typed responses, error handling, optimistic updates
- [ ] Old pages temporarily wrapped to consume new hooks (coexistence)

**Deliverable:** App boots with new architecture. Staff login works. Data loads via TanStack Query with caching. Old pages still functional.

**Risk:** Low — new files only, old code untouched.

---

### Phase 2: Customer Portal (New Feature)
**Goal:** Customers can register, schedule pickups, view orders, check loyalty.

#### 2.1 Database: Pickup Scheduling
- [ ] Run migrations: `pickup_schedules`, `pickup_blocked_dates`, `pickup_requests` tables + indexes
- [ ] Add RLS policies for customer access
- [ ] Create `usePickupSchedule.ts` hook (available slots calculation)
- [ ] Create `usePickupRequests.ts` hook (customer pickup CRUD)

#### 2.2 Admin: Pickup Schedule Configuration
- [ ] Build `PickupScheduleSettings.tsx`:
  - Weekly schedule editor (day → start/end time, slot duration, max per slot)
  - Blocked dates manager (add/remove holidays, closures)
  - Toggle pickup service on/off per store

#### 2.3 Portal Pages
- [ ] `PortalLayout.tsx` + `PortalHeader.tsx` — clean, mobile-friendly customer design
- [ ] `PortalDashboard.tsx` — active orders, loyalty card, "Schedule Pickup" CTA
- [ ] `SchedulePickup.tsx`:
  - Calendar (14-day window, available/unavailable/full days)
  - Time slot picker (available slots, gray out full)
  - Address form (prefilled from profile)
  - Notes field
  - Confirmation step with summary
- [ ] `MyOrders.tsx` — Active/Completed tabs, order cards
- [ ] `OrderDetail.tsx` — full timeline, items, payments
- [ ] `MyLoyalty.tsx` — points balance, transaction history, punch card progress
- [ ] `MyProfile.tsx` — edit info, change password

#### 2.4 Staff-Side Pickup Management
- [ ] Pickup requests view (new tab or section in staff interface)
- [ ] Staff actions: confirm, mark picked up, cancel (with reason)
- [ ] Link pickup to POS order when processing

#### 2.5 Email Notifications for Pickups
- [ ] `pickup_confirmed` template
- [ ] `pickup_reminder` template (day before)

**Deliverable:** Full customer portal live. Customers register, book pickups, track orders, view loyalty.

**Risk:** Low — entirely new feature, no existing functionality affected.

---

### Phase 3: Staff Pages Migration
**Goal:** Migrate all existing pages to new architecture. Delete AppContext monolith.

#### 3.1 POS System
- [ ] Create `useTicket.ts` — replaces AppContext ticket slice
  - Local state (not global) scoped to POS
  - Uses `calculations.ts` for totals
  - Integrates with `useLoyalty.ts`
- [ ] Rebuild `POSScreen.tsx` using `useTicket` + `useProducts`
- [ ] Rebuild `TicketPanel.tsx` (1,696 → target ~400 lines):
  - Loyalty → `useLoyalty.ts` hook
  - Calculations → `useTicket.ts` hook
  - Printing → `usePrinter.ts` hook
- [ ] Rebuild payment modals using shared UI primitives

#### 3.2 Order Management
- [ ] Rebuild `OrdersPage.tsx` (909 → target ~300 lines):
  - `useOrders({ status, dateRange, search })` with server-side filtering
  - Cursor-based pagination
  - Extract `OrderDetailModal` to separate file
- [ ] Rebuild `MachinesPage.tsx` (already clean, just migrate to hooks)
- [ ] Add Supabase Realtime subscription for order status changes

#### 3.3 Customers
- [ ] Rebuild `CustomersPage.tsx` (1,217 → target ~300 lines):
  - Extract modals to separate files
  - `useCustomers` + `useLoyalty` hooks
  - Server-side search with debounce

#### 3.4 Settings Decomposition
- [ ] Explode `SettingsPage.jsx` (5,124 lines) into 13 files under `pages/staff/settings/`
- [ ] Each section: own file, own data hook, own form state
- [ ] `index.tsx` handles only tab navigation shell

#### 3.5 Analytics, Reports & EOD
- [ ] Rebuild `AnalyticsPage.tsx` with `useAnalytics` query hook
- [ ] Rebuild `ReportsPage.tsx` — extract CSV export to utility
- [ ] Rebuild `EODPage.tsx` (764 → target ~300 lines) — extract cash counting component

#### 3.6 Delete Legacy Code
- [ ] Delete `AppContext.jsx` (replaced by TanStack Query + useTicket + UIContext)
- [ ] Delete `useDataLoader.js` (replaced by domain query hooks)
- [ ] Delete `helpers.js` (consolidated into formatters.ts + validation.ts)
- [ ] Delete old `formatters.js` (replaced by formatters.ts)

**Deliverable:** All pages on new architecture. Every file under 400 lines. Zero god-components.

**Risk:** Medium — page-by-page migration. Each migrated page is a standalone PR.

---

### Phase 4: Polish & Quality
**Goal:** Production-ready with tests, monitoring, and verified performance.

#### 4.1 Testing
- [ ] Unit tests: formatters, calculations, validators, loyalty logic (~90% coverage on utils)
- [ ] Integration tests: auth flows (staff + customer), pickup scheduling, order lifecycle
- [ ] E2E tests (Playwright): POS complete sale, customer portal pickup flow

#### 4.2 Performance Verification
- [ ] `npx vite-bundle-visualizer` — verify code splitting
- [ ] Lighthouse audit on portal pages (target: 90+ performance)
- [ ] TanStack Query DevTools — verify cache hit rates
- [ ] Load test: concurrent pickup slot booking

#### 4.3 Production Hardening
- [ ] Sentry error tracking integration
- [ ] CSP headers in `vercel.json`
- [ ] Rate limit `/api/send-email.js`
- [ ] Verify all RLS policies with test customer accounts
- [ ] GitHub Actions CI: lint + type-check + test on PR

#### 4.4 Real-Time Features
- [ ] Supabase Realtime on `orders` for live Kanban updates
- [ ] Supabase Realtime on `pickup_requests` for staff notifications
- [ ] Customer portal: real-time order status updates

**Deliverable:** Production-ready app with test coverage, monitoring, and real-time sync.

**Risk:** Low — tests and monitoring, no feature changes.

---

## Migration Safety

Each phase is **independently deployable**:

| Phase | Risk | Rollback |
|-------|------|----------|
| 1 — Foundation | Low | New files only, old code untouched |
| 2 — Portal | Low | New feature, no existing functionality touched |
| 3 — Migration | Medium | Page-by-page. Revert one file to restore old behavior |
| 4 — Polish | Low | Tests and monitoring only |

### Coexistence Strategy (Phases 1-2)
During Phases 1 and 2, old and new code coexist:
- Old pages continue using AppContext + useDataLoader
- New portal pages use TanStack Query hooks
- Shared utilities (`formatters.ts`, `validation.ts`) used by both
- Auth system rebuilt once and serves both staff + customer

Phase 3 migrates old pages one at a time. Each page migration is a standalone PR.

---

## Metrics: Current → Target

| Metric | Current | Target |
|--------|---------|--------|
| Largest file | 5,124 lines (SettingsPage) | < 400 lines |
| Duplicated functions | 7 functions × 2-4 copies | 0 |
| God components | 3 (Settings, TicketPanel, useDataLoader) | 0 |
| Test coverage | 0% | 80%+ on business logic |
| Initial bundle (est.) | ~350KB (no splitting) | ~120KB (lazy routes) |
| Data re-fetches per nav | Every page load | Cached, background refresh |
| Customer self-service | None | Full portal + pickup scheduling |
| TypeScript coverage | 0% | 100% new code, 60%+ overall |
| Real-time sync | None | Orders + pickups via Supabase Realtime |

---

## Dependencies to Add

```json
{
  "@tanstack/react-query": "^5.x",
  "@tanstack/react-query-devtools": "^5.x",
  "typescript": "^5.x",
  "vitest": "^2.x",
  "@testing-library/react": "^16.x",
  "@testing-library/jest-dom": "^6.x",
  "eslint": "^9.x",
  "prettier": "^3.x",
  "@playwright/test": "^1.x",
  "@sentry/react": "^8.x"
}
```

Only **one** new runtime dependency (TanStack Query). Everything else is dev tooling.

---

## Getting Started

To begin Phase 1:

```bash
# Install new dependencies
npm install @tanstack/react-query @tanstack/react-query-devtools
npm install -D typescript @types/react @types/react-dom vitest @testing-library/react eslint prettier

# Generate TypeScript config
npx tsc --init

# Generate Supabase types
npx supabase gen types typescript --project-id YOUR_PROJECT_ID > src/types/database.ts

# Run database migrations for customer portal
# (apply the SQL from "Database Changes" section above)
```

Then follow Phase 1 checklist items in order. Each produces a small, reviewable PR.
