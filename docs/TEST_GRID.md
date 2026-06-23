# Operational Test Grid — American Laundry

Pre-launch QA matrix for the production environment. **All test data is disposable** (wiped before go‑live), so create freely.

**How to use:** run each row in the deployed app, mark **Status** (✅ pass / ❌ fail / ⏳ to‑run), note anything off. Items marked **[prod‑only]** require the deployed `/api` (factura electrónica, emails) and can't be exercised from local dev.

Legend for "Verified": **live** = exercised this session against the live DB · **prior** = verified in an earlier build session · **prod‑only** = must be run on the deployed site.

### QA run — 2026‑06‑24 (this session)
- **Retail order full lifecycle ✅** — order **#3511**: created (walk‑in, Cortinas B/10, cash) → advanced **pending → washing → drying → folding → ready → completed** via the UI; `ready_at` + `completed_at` stamped; **Pago = Pagado** the whole way. Covers **O1, O9, O10**.
- Earlier this session (same live DB): **O8** pay‑on‑pickup (unpaid + gated), **O10/Cobrar‑y‑entregar**, **O11** pickup waiting/reminder, **B1–B5** B2B credit + consolidated invoice + collect + statement, **F5** B2B excludes per‑order factura, **M1/M2** machines + usage, **P6** machine‑service links, **EOD1**, **RBAC1**, **C3** server search, **W1** WhatsApp config.
- **Blocked from here:** factura electrónica (F) + emails (E) need the deployed `/api`; the deployment URL is Vercel‑SSO‑protected and I won't send the session token to guessed domains. Run those rows on the deployed site (steps at the bottom), or share the production domain and I'll drive them.

---

## 1. Customers

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| C1 | Create retail customer | POS → Seleccionar Cliente → **+** (nuevo) → name, phone, email → Guardar | Customer saved, selectable; appears in Clientes | prior |  |
| C2 | Create B2B customer (RUC) | New customer → Tipo doc = **RUC** → company name, RUC, DV; or toggle **Cliente B2B (factura a crédito)** | `can_be_invoiced = true`; "Factura" term appears for them at checkout | prior |  |
| C3 | Search reaches full table | Clientes → search a customer NOT in the recent set | Found via server search (trgm) | live |  |
| C4 | Edit customer | Clientes → edit → change phone → save | Persists | prior |  |

## 2. Products & services

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| P1 | Retail product | Settings → Productos → + → name, section **Productos**, price, taxable | Sold as a fixed‑price item | prior |  |
| P2 | Individual service (quantity) | + → pricing **Cantidad**, price, ITBMS toggle, express price, días extra | Adds per‑unit; express price applies in Express mode | prior |  |
| P3 | Individual service (weight) | + → pricing **Peso (por kg)**, per‑kg price | Charges by weight (kg) | prior |  |
| P4 | Service options matrix | Toggle: taxable on/off, express price set/empty, días extra 0–3, machine (none/washer/dryer) | Each reflected at POS + promised date shifts by días extra | prior |  |
| P5 | Parent service + subcategory | + → **Producto padre (con hijos)** → add child products under it | Parent opens a sub‑menu of children at POS | prior |  |
| P6 | Machine‑service link | Service with Máquina = Lavadora → "Máquinas permitidas" all checked → uncheck some | POS only offers the checked machines | live |  |

## 3. Retail order (collection at counter)

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| O1 | Order, no discount | Add item(s) → pick customer/walk‑in → Procesar → pay Efectivo | Order created `status=pending`, `payment=Pagado` | **live #3511** | ✅ |
| O2 | Order with line discount | Add item → set Desc. (B/. or %) on the line | Subtotal/total reflect the discount | prior |  |
| O3 | Order with order‑level discount/promo | Ver Detalles → apply manual discount / promo code | Discount applied; promo validated | prior |  |
| O4 | Express order | Toggle Express → add item | Express price used; promised date sooner | prior |  |
| O5 | Free delivery / free services (loyalty) | Apply free wash/dry if customer has loyalty | Discount line added | prior |  |
| O6 | Payment — card / ACH / Yappy | Procesar → choose method → amount | Recorded under that method | prior |  |
| O7 | Payment — split / partial | Add a partial tender then a second | Multi‑tender sums to total; change on cash | prior |  |
| O8 | Payment — **Pagar al recoger** | Procesar → Pagar al Recoger (exclusive) | Order `unpaid`, `billing_type=pickup`; no invoice; **delivery gated** | live |  |
| O9 | Kanban reflects status | Máquinas board → drag/move pending→washing→drying→folding→**Listo** | Card moves; Orders list shows matching estado | **live #3511** | ✅ |
| O10 | Collection / hand‑over | On **Listo** card → **Entregar (recogido)**; or pay‑on‑pickup → **Cobrar y entregar** | Status → **Completado**; pickup collects payment first then completes | **live #3511, #3508/#3509** | ✅ |
| O11 | Pickup waiting + reminder | Order sits in Listo past promised date | "Esperando … · vencida" + **Recordar** stamps reminder | live |  |

## 4. Delivery order

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| D1 | Delivery order create | Add a delivery service (Entregas) + items → customer with address → process | `delivery_charge` on order; promised date set | prior |  |
| D2 | Delivery hand‑over | Process through kanban → Entregar | Status → Completado (delivered) | prior |  |

## 5. B2B order + consolidated billing

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| B1 | B2B credit order | B2B customer → Procesar → **Factura** (credit) | Order `unpaid`, `billing_type=account`; delivered on account (NOT gated); shows **B2B** in history | live |  |
| B2 | B2B shows "Pagado" once invoiced | Generate a consolidated invoice for it | Order Pago column → Pagado even before collection | live |  |
| B3 | Consolidated invoice | Facturación B2B → pick customer → select orders → **Generar factura** | One invoice; orders are its line items (number + amount) | live |  |
| B4 | Collect B2B invoice | Invoice → **Cobrar** (payment screen: cash/card/ACH/Yappy) | Records payment; invoice + orders Pagada; shows in EOD collected | live |  |
| B5 | Estado de cuenta | Invoice modal → Imprimir | Statement lists order line items + totals | live |  |
| B6 | B2B factura electrónica **[prod‑only]** | After Cobrar → invoice modal e‑factura status / Emitir factura | Consolidated factura authorizes at PAC; CUFE shown | prod‑only | ⏳ |

## 6. Factura electrónica (DGI) — **[prod‑only]**

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| F1 | Auto‑emit on paid order | Create a paid retail order (customer w/ RUC ideal) | electronic_invoices row → **authorized**, CUFE returned (test env) | prior (authorized #3498/#3501) | ⏳ re‑run |
| F2 | View / reprint CAFE | Orders → order → Factura electrónica → Descargar / Imprimir CAFE | CAFE PDF downloads | prior | ⏳ |
| F3 | Nota de crédito (refund) | Refund an order (admin) | Nota de crédito (doc 06) emitted | prior | ⏳ |
| F4 | EOD reconciliation | Cierre del Día → Conciliación de Facturación Electrónica | Authorized / pending / rejected counts match | prior | ⏳ |
| F5 | B2B excluded from per‑order | Open a B2B order detail | No factura section; note "se factura en la factura consolidada" | live |  |

> Config check (live DB): both stores have e‑factura **enabled**, env=**test**, API key set, punto **001**. Note: both share punto 001 — give each a distinct punto before production under the same RUC.

## 7. Notification emails — **[prod‑only]**

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| E1 | Order created email | Create order for a customer **with email** | `order_created` email sent (SMTP) | prod‑only | ⏳ |
| E2 | Order ready email | Advance order → **Listo** | `order_ready` email sent | prod‑only | ⏳ |
| E3 | Order delivered email | Advance → **Completado** | `order_delivered` email sent | prod‑only | ⏳ |
| E4 | Pickup reminder (cron) | Order left ready & overdue; daily cron `pickup-reminders` (9am Panamá) | Reminder email; `pickup_reminder_at` stamped | prod‑only | ⏳ |
| E5 | Manual reminder | Listo card → **Recordar** | Reminder email + ✓ recordado | live (stamp) / prod (email) |  |

> Config check (live DB): SMTP configured, from = `NoReply@lavaydobla.com`.

## 8. WhatsApp — **[prod‑only, needs Meta creds]**

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| W1 | Configure | Settings → WhatsApp → phone number id + token → Guardar | Saved (token masked) | live |  |
| W2 | Test message | Enviar prueba (hello_world) to a test recipient | WhatsApp received | prod‑only | ⏳ |
| W3 | Order notifications | (slice 2 — needs approved utility templates) | — | not built | — |

## 9. Time & attendance / machines / EOD

| # | Test | Steps | Expected | Verified | Status |
|---|------|-------|----------|----------|--------|
| T1 | Clock in/out | Top‑right user menu → Marcar Entrada/Salida | time_entry created/closed; worked time shown | prior |  |
| T2 | Weekly hours | Settings → Usuarios → edit → horario semanal | weekly_hours saved | prior |  |
| T3 | EOD attendance card | Cierre del Día → Asistencia | Worked vs scheduled per staff | prior |  |
| M1 | Machine inventory + maintenance | Settings → Máquinas → create, set interval, Registrar mantenimiento | Cycles/since‑service/due; maintenance resets | live |  |
| M2 | Machine usage on sale | Sell a Lavamático service → assign machine | Cycle recorded against that machine, linked to order | live |  |
| EOD1 | Daily close | Cierre del Día → counts, payment breakdown, pendiente (pickup/B2B), cash cuadre | Totals correct; pending split shown | live |  |
| RBAC1 | Role gating | Set a user to operator/supervisor | Operator: no analytics/B2B/settings; supervisor: no settings/refund | live |  |

---

## Production‑only items — how to run F/E/W

These need the deployed site (the `/api` functions and real PAC/SMTP/Meta), which can't run in local dev:

1. **Factura electrónica (F1–F4):** create a paid order on the deployed app → open the order → the *Factura electrónica* panel should show **authorized** + a CUFE (test env), with **Descargar/Imprimir CAFE**. (Per‑order facturas authorized successfully in an earlier session — #3498, #3501.) For B2B (B6), collect a consolidated invoice and emit.
2. **Emails (E1–E4):** use a customer with a **real email** you control; advance the order through statuses and confirm receipt. The pickup‑reminder cron runs daily at 9am Panamá.
3. **WhatsApp (W2):** in Settings → WhatsApp enter your Meta test‑number phone‑number‑id + token, then *Enviar prueba* to a registered test recipient.

If you give me the **production domain**, I can drive F/E with the session token directly and fill in these rows.
