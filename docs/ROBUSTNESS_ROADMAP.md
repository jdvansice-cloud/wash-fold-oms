# Wash-Fold OMS — Robustness & Growth Roadmap

Comparative analysis (vs. Mimosa-Platform), security & performance audit, and a
phased plan to make the platform robust for multi-location operation. Plus a
competitor-driven enhancement backlog. Constraint: **keep the current look & feel,
the POS screen, product management, and all laundry-specific functionality** —
every change here is additive or in-place, no rewrites.

---

## 0. The keystone finding

There are **two disconnected "store" concepts**:

- `TenantContext.tsx` (TS, URL-slug driven) resolves `company`, `stores[]`,
  `activeStore`, and the `StoreSwitcher` writes to it.
- `AppContext.jsx` + `useDataLoader.js` (the POS engine) **ignore `activeStore`**
  and just load *the first active store* (`stores … limit:1`). All POS reads and
  writes are pinned to it.

So the app is **effectively single-store today**, and the top-bar switcher doesn't
actually move the POS. **Wiring `useDataLoader` to `TenantContext.activeStore` is
the single highest-leverage change** — it unblocks multi-location, per-store
e-factura, per-store EOD, and attendance simultaneously.

---

## 1. What to adopt from Mimosa (more recent build)

| Pattern | Mimosa implementation | Adopt for wash-fold |
|---|---|---|
| **Hard/soft location scoping** | RLS `auth_location_ids()` (hard boundary) + cookie-stored top-bar picker (soft filter that can only narrow within the hard set) | ✅ wash-fold already has `auth_store_ids()`; add the picker as the soft filter + optional per-user store assignment |
| **Per-location fiscal config** | `location.ruc/dv/punto_facturacion/efactura_credentials_ref`; secret stored as a *reference*, not inline | ✅ re-key `company_efactura_config` → per `store_id`; store key as a Vault reference (security item) |
| **Settings registry** | Defaults in code (`settings-registry.ts`), DB stores only overrides, 3-tier resolution (location ?? org ?? default) | ✅ great pattern for per-store toggles without a migration each time |
| **RBAC by permission-keys** | `permission`/`role`/`role_permission` tables; RLS gates writes on `auth_has_permission(key)`; client checks cosmetic | ◐ adopt the *principle* (enforce in RLS); start simpler with role-enforced policies, grow to permission-keys later |
| **Atomic checkout RPC** | `checkout_ticket` does order+items+tenders+counters in one SECURITY DEFINER transaction; recomputes totals server-side | ✅ fixes the client-trusted-totals security gap too |
| **Time-clock** | Dedicated PIN kiosk, bcrypt PIN in SECURITY DEFINER RPC, lockout, `time_entry` table | ◐ adopt the table + RPC security; surface in the **user menu** (your preference) instead of a kiosk |
| **Park/recall** | `localStorage` single open ticket + "open ticket" recall banner synced via storage/custom/focus events | ✅ matches your "one held transaction" requirement exactly |
| **Cashier vs station** | `ticket.cashier_id` (PIN-selected acting cashier) ≠ `opened_by` (station login) | ◐ optional; pairs with attendance |
| **Secret hygiene** | column-`REVOKE` on secret columns; secret tables with *no* RLS read policy; service-role-only RPCs | ✅ apply to `api_key`/`smtp_pass`/PINs |

---

## 2. Security audit — prioritized

| Sev | Finding | Fix |
|---|---|---|
| **Critical** | Legacy RLS migrations (`supabase-fix-rls.sql`, `-customer-auth-rls.sql`, `-rls-all-tables.sql`) disable RLS / `GRANT ALL TO anon` / `USING(true)`. Re-applying any re-opens all tenants. Anon key is public. | Quarantine/delete them; document `supabase-fix-rls-tenant-isolation.sql` as the single source of truth. |
| **Critical** | **No role enforcement in RLS** — `auth_is_staff()` treats operator = admin. An operator can edit SMTP, e-factura, refunds, settings via direct API. | Add `auth_is_admin()`; require it on `company_smtp`, `company_efactura_config`, `notification_settings`, `refunds`, `loyalty_settings`, `companies`, price writes. (Also delivers real RBAC.) |
| **High** | PostgREST `.or()` filter injection in order search (`useOrders.ts:55`, `useDataLoader.js:1105`) — raw user input interpolated. | Sanitize/escape the term or use parameterized `.ilike()` calls. |
| **High** | Customer self-update can **tenant-hop** (`customers_self_update` doesn't pin `store_id`). | Pin `store_id` in the `WITH CHECK`, or route updates through a SECURITY DEFINER RPC. |
| **High** | Order totals / `order_number` / refund amounts are **client-trusted** (read-max-then-insert race too). | Compute totals + next number in a SECURITY DEFINER RPC / sequence; ignore client money fields. |
| **Medium** | E-factura CAFE **IDOR** (`api/efactura/cafe.ts` accepts raw `?cufe=` with no ownership check). | Always resolve CUFE via `electronic_invoices` + `assertStoreInCompany`. |
| **Medium** | `company_efactura_config.api_key` & `company_smtp.smtp_pass` stored **plaintext**. | Move to Supabase Vault/pgsodium; restrict to `auth_is_admin()` meanwhile. |
| **Medium** | Live **service-role key** sits in working-tree `.env.test` (gitignored, not leaked). | Keep service-role keys only in Vercel env; rotate if the tree was shared. |
| **Low** | Self-XSS in email-template preview (`dangerouslySetInnerHTML`); templates are later emailed to customers. | Sanitize with DOMPurify before preview/send. |

## 3. Performance audit — prioritized

| Sev | Finding | Fix |
|---|---|---|
| **High** | No pagination on primary load: all customers + 500 orders + `select('*')` on every app start. | Paginate orders/customers; lazy-load customers; project explicit columns. |
| **High** | Missing **customer search indexes** (only `store_id`). Name/phone search = seq scan. | `pg_trgm` GIN on `customers(first_name,last_name,phone)`, `orders(customer_name)`. |
| **High** | `AppContext` value + `actions` rebuilt every render → app-wide re-renders. | `useMemo` the provider value; memoize `actions`; split state/dispatch contexts. |
| **Medium** | Large lists unvirtualized/unmemoized (Customers, Orders); `SettingsPage` 5.3k lines ships as one chunk. | Virtualize tables; `React.memo` rows; split SettingsPage into lazy per-tab chunks. |
| **Low** | `updateProductsOrder` = N parallel UPDATEs; supabase.js static+dynamic import warning. | Batch via single `upsert`; isolate supabase vendor chunk. |

*(EOD payment breakdown is NOT N+1 — verified fine.)*

---

## 4. Phased plan (for approval)

Each phase is independently shippable. Recommended order optimizes
risk-reduction first, then the operational features you asked for, then growth.

### Phase A — Security hardening *(do first; mostly low-effort, high risk-reduction)*
- Quarantine legacy RLS migrations; lock in the isolation migration.
- `auth_is_admin()` + tighten sensitive write policies → **real role enforcement**.
- Fix CAFE IDOR; sanitize order search; pin customer `store_id`.
- Move order create (totals + order_number) into a SECURITY DEFINER RPC.
- Restrict secret columns to admin (Vault as a follow-up).

### Phase B — Multi-location foundation *(the keystone)*
- **Wire `useDataLoader` → `TenantContext.activeStore`** (refetch on switch).
- Top-bar **location selector** scoping all operations (show for >1 store; mobile too).
- Optional per-user store assignment (`user_stores`) + hard/soft scoping.
- **Per-store e-factura config**: re-key `company_efactura_config` to `store_id`,
  thread `order.store_id` through the proxy, per-store settings UI.

### Phase C — POS operational UX *(small, high-value; matches your asks)*
- **Park/Hold + Recall** one in-progress transaction (localStorage + recall banner).
- **Last-customer** quick button next to Search / Walk-in.

### Phase D — Users, roles & attendance
- **User management UI** (list/invite/edit-role/deactivate) — invite plumbing exists.
- RBAC surfaced via a `usePermission`/`can()` helper (server-enforced from Phase A).
- **Time & attendance**: `time_entries` table, clock in/out in the **top-right user
  menu**, surfaced in **EOD** (+ `attendance_summary` snapshot on `eod_closings`).

### Phase E — Performance
- Pagination + column projection + lazy customer load.
- `pg_trgm` search indexes.
- `AppContext` memoization / context split; virtualize big tables; split SettingsPage.

### Phase F — Competitive growth backlog *(pick by ROI)*
Top 10 (from competitor research; app already has portal, P&D, loyalty, gift cards, e-factura):
1. **Barcode garment/order tagging + label printing** (foundational — unblocks 3,5,? )
2. **WhatsApp notifications (two-way)** — #1 regional lever in Panama
3. **Ready-for-pickup automation + reminders**
4. **Integrated card payments** (online + terminal; stored cards)
5. **B2B / corporate account billing + monthly statements** (pairs with e-factura)
6. **Analytics dashboard + KPIs** (owner cockpit beyond EOD)
7. **Online self-service booking** (leverages existing portal)
8. **Recurring / subscription plans** (MRR)
9. **Automated marketing / win-back + review/NPS requests**
10. **Rack/shelf location tracking** (extends barcode)

*(Fast-follows: SMS fallback channel, store credit/wallet, QuickBooks export, driver
app + live tracking, tip capture.)*

---

## 5. Notes
- **Decimals vs minor-units:** Mimosa uses integer minor units; wash-fold uses
  DECIMAL. Not worth converting — the e-factura builder already handles cent-safe
  rounding where it matters.
- All changes preserve the current design system, POS screen, and laundry domain
  logic. Multi-store and RBAC are additive; existing single-store installs keep
  working (defaults: one store, admin role).
</content>
