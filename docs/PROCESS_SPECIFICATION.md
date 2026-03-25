# Wash & Fold OMS - Process Specification

**System:** American Laundry Order Management System
**Version:** 2.0 (with Customer Portal)
**Locale:** es-PA (Spanish, Panama)
**Currency:** Panamanian Balboa (B/)
**Tax:** ITBMS (Impuesto de Transferencia de Bienes Muebles y Servicios)

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Authentication & Session Management](#2-authentication--session-management)
3. [User Roles & Permissions](#3-user-roles--permissions)
4. [Point of Sale (POS)](#4-point-of-sale-pos)
5. [Pricing & Tax Calculations](#5-pricing--tax-calculations)
6. [Order Lifecycle](#6-order-lifecycle)
7. [Kanban Workflow (Machines)](#7-kanban-workflow-machines)
8. [Customer Management](#8-customer-management)
9. [Loyalty Program](#9-loyalty-program)
10. [Payment Processing](#10-payment-processing)
11. [End-of-Day Reconciliation](#11-end-of-day-reconciliation)
12. [Analytics Dashboard](#12-analytics-dashboard)
13. [Reports & Export](#13-reports--export)
14. [Admin Settings](#14-admin-settings)
15. [Email Notifications](#15-email-notifications)
16. [Receipt Printing](#16-receipt-printing)
17. [Customer Portal](#17-customer-portal)
18. [Pickup Scheduling](#18-pickup-scheduling)
19. [Database Schema Reference](#19-database-schema-reference)
20. [Appendices](#20-appendices)

---

## 1. System Overview

### 1.1 Purpose
A web-based Order Management System for a wash-and-fold laundry business operating in Panama City. The system handles the complete lifecycle of laundry orders — from customer intake through washing, drying, folding, and pickup/delivery — including point-of-sale transactions, customer loyalty programs, business analytics, and a customer self-service portal.

### 1.2 Business Model
American Laundry operates two service types:

| Service | Description | Pricing |
|---------|-------------|---------|
| **Wash & Fold (Lava y Dobla)** | Full-service laundry — drop off dirty clothes, pick up clean and folded | Per kilogram (weight-based) |
| **Self-Service (Lavamatico)** | Customer uses on-site washers and dryers | Per machine use (quantity-based) |

Additional revenue: retail products (detergent, softener), delivery services, and specialty items (curtains, pillows, bedsheets).

### 1.3 Technology Stack
| Layer | Technology |
|-------|-----------|
| Frontend | React 18.2 SPA |
| Build | Vite 5.0 |
| Styling | Tailwind CSS 3.3 |
| Database | Supabase (PostgreSQL) |
| Auth | Supabase Auth |
| API | Supabase REST + Vercel Serverless |
| Printer | WebUSB (ESC/POS) |
| Deployment | Vercel |

### 1.4 User Types
| Type | Access Point | Description |
|------|-------------|-------------|
| Admin | `/staff/*` | Full system access — settings, users, refunds, analytics |
| Supervisor | `/staff/*` | Operational access — orders, reports, machines |
| Operator | `/staff/*` | POS, basic order management, EOD |
| Customer | `/portal/*` | Self-service — view orders, schedule pickups, loyalty |

### 1.5 Localization
- **Language:** Spanish (Panama)
- **Currency:** `B/{amount}` (e.g., B/12.50) — Panamanian Balboa (at parity with USD)
- **Date locale:** `es-PA` via date-fns
- **Phone format:** `+507 6789-0000` (8-digit, mobile starts with 6)
- **Tax:** ITBMS at 7% (configurable per company)
- **ID types:** Cedula (national ID), Passport, RUC (tax registration)
- **Address:** Street, Building, Corregimiento, District, Province

---

## 2. Authentication & Session Management

### 2.1 Staff Login Flow
```
User navigates to /login
  → Enters email + password
  → supabase.auth.signInWithPassword({ email, password })
    → On success: auth session created (JWT stored in localStorage)
      → System looks up user by auth_id in `users` table
        → If not found by auth_id: looks up by email, then links auth_id
      → User record loaded with role, store_id, company info
      → Redirect to "/" (POS screen)
    → On failure: display localized error message
```

**Error Messages:**
| Supabase Error | Display (Spanish) |
|----------------|-------------------|
| "Invalid login credentials" | "Credenciales invalidas. Verifica tu email y contrasena." |
| "Email not confirmed" | "Email no confirmado. Revisa tu bandeja de entrada." |
| Other | "Error al iniciar sesion" |

### 2.2 Customer Login Flow
```
Customer navigates to /portal/login
  → Enters email + password
  → supabase.auth.signInWithPassword({ email, password })
    → On success: auth session created
      → System looks up customer_auth by auth_id → gets customer_id
      → Customer record loaded from `customers` table
      → Redirect to /portal/dashboard
    → On failure: display error, link to registration
```

### 2.3 Customer Registration Flow
```
Customer navigates to /portal/register
  → Form fields:
    Required: first_name, last_name, email, phone, password, confirm_password
    Optional: address_street, address_building, address_corregimiento, address_district
    Defaults: phone_country = '+507', address_district = 'Panama', address_province = 'Panama'
  → Validation: all password rules (2.5), phone format, email format
  → supabase.auth.signUp({ email, password })
  → Create customer record in `customers` table (store_id from URL or default)
  → Create customer_auth mapping { auth_id, customer_id }
  → Send welcome email (if notification enabled)
  → Auto-login → redirect to /portal/dashboard
```

### 2.4 User Invitation Flow (Staff)
```
Admin creates user in Settings → Users
  → System creates Supabase Auth account:
    Primary: supabase.auth.admin.inviteUserByEmail()
    Fallback: supabase.auth.signUp() with temp password + reset email
  → Invitation email sent with link to /set-password
  → User clicks link → Set Password page
    → Session validated from URL hash (access_token, refresh_token)
    → User sets password meeting all requirements
    → auth_id linked to user record
    → Redirect to /login
```

### 2.5 Password Requirements
| Rule | Check |
|------|-------|
| Minimum 8 characters | `password.length >= 8` |
| At least 1 uppercase | `/[A-Z]/.test(password)` |
| At least 1 lowercase | `/[a-z]/.test(password)` |
| At least 1 number | `/[0-9]/.test(password)` |

All four rules must pass. Password must match confirmation field.

### 2.6 Password Reset Flow
```
User clicks "Olvidaste tu contrasena?" on login page
  → Enters email address
  → supabase.auth.resetPasswordForEmail(email, { redirectTo: origin + '/set-password' })
  → Confirmation page displayed
  → Email received with reset link
  → Same Set Password flow as invitation (2.4)
```

### 2.7 Session Management
- **Persistence:** `localStorage` via Supabase client (auto JWT refresh)
- **Loading timeout:** 2 seconds for initial auth state resolution
- **Session listener:** `supabase.auth.onAuthStateChange()` fires on login/logout/token refresh
- **Route protection:** Staff routes require `users` table match; portal routes require `customer_auth` match

### 2.8 In-App Password Change
```
User clicks avatar → "Cambiar Contrasena"
  → Modal: new password + confirmation (current password not validated locally)
  → Same password rules as 2.5
  → supabase.auth.updateUser({ password })
  → Success toast
```

---

## 3. User Roles & Permissions

### 3.1 Role Definitions
| Role | Label (Spanish) | Description | Badge Color |
|------|----------------|-------------|-------------|
| `admin` | Administrador | Full access | Purple |
| `supervisor` | Supervisor | Operations + reports | Blue |
| `operator` | Operador | POS + basic orders | Slate |
| `customer` | Cliente | Self-service portal | Green |

### 3.2 Staff Permission Matrix
| Feature | Admin | Supervisor | Operator |
|---------|-------|------------|----------|
| POS — Create orders | Yes | Yes | Yes |
| POS — Process payments | Yes | Yes | Yes |
| Orders — View all | Yes | Yes | Yes |
| Orders — Create refund | **Yes** | No | No |
| Machines — Kanban board | Yes | Yes | Yes |
| Machines — Update status | Yes | Yes | Yes |
| Customers — View/manage | Yes | Yes | Yes |
| Analytics — Dashboard | Yes | Yes | No |
| Reports — View/export | Yes | Yes | No |
| EOD — Create closing | Yes | Yes | Yes |
| EOD — Modify existing | **Yes** | No | No |
| Settings — All sections | **Yes** | No | No |
| Pickup Requests — Manage | Yes | Yes | No |

### 3.3 Customer Permissions
| Feature | Access |
|---------|--------|
| View own orders (current + past) | Yes |
| View own loyalty balance/history | Yes |
| Schedule pickup requests | Yes |
| Cancel own pending pickup | Yes |
| Edit own profile | Yes |
| View other customers' data | **No** (RLS enforced) |

### 3.4 User Status Indicators
| State | Badge | Meaning |
|-------|-------|---------|
| `auth_id` populated | "Confirmado" (green) | User has set password |
| `auth_id` null | "Pendiente" (amber) | Invitation pending |
| `is_active` = false | "Inactivo" (red) | Account deactivated |

---

## 4. Point of Sale (POS)

### 4.1 POS Screen Layout
```
+------------------------------------------+------------------+
|  Section Tabs (categories)               |                  |
|  [Lava y Dobla] [Lavamatico] [Productos] |  TICKET PANEL    |
|                                          |                  |
|  Product Grid                            |  Customer info   |
|  +------+ +------+ +------+             |  Order items     |
|  | Prod | | Prod | | Prod |             |  Calculations    |
|  | 2.50 | | 1.75 | | 10.0 |             |  [Procesar]      |
|  +------+ +------+ +------+             |                  |
+------------------------------------------+------------------+
```

### 4.2 Product Types
| Type | `pricing_type` | `product_type` | Behavior on Click |
|------|---------------|----------------|-------------------|
| Weight-based service | `weight` | `service` | Opens Weight Entry Modal |
| Quantity-based service | `quantity` | `service` | Adds 1 unit, increments on repeat |
| Retail product | `quantity` | `retail` | Adds 1 unit |
| Delivery | `quantity` | `delivery` | Adds delivery charge |
| Parent product | `has_children = true` | any | Opens Child Products Modal |

### 4.3 Adding Items to Ticket

**Weight-Based Product:**
```
User clicks product tile
  → IF product.has_children: open ChildProductsModal first
  → IF product.pricing_type === 'weight': open WeightEntryModal
    → User enters:
      - weight (kg) — required
      - pieces count — optional
      - notes — optional
      - wet weight flag — optional
    → Can add multiple weight entries (bags) in same modal
    → On confirm, item added with:
      totalWeight = sum(all entry weights)
      bags = count(entries)
      pieces = sum(entry pieces)
      unitPrice = isExpress ? (express_price || price) : price
      lineTotal = totalWeight * unitPrice
      weightEntries = [{ weight, pieces, notes, isWetWeight }, ...]
```

**Quantity-Based Product:**
```
User clicks product tile
  → IF item already in ticket: quantity += 1
  → ELSE: add new item with quantity = 1
  lineTotal = quantity * unitPrice
```

**Child Product:**
```
User clicks parent product tile
  → ChildProductsModal opens showing all child products (where parent_id = this product)
  → User selects a child product
  → Normal add flow based on child's pricing_type
```

### 4.4 Ticket Item Operations
| Action | Effect |
|--------|--------|
| Increment (+) | `quantity += 1`, recalculate lineTotal |
| Decrement (-) | `quantity -= 1`, remove if quantity reaches 0 |
| Remove (X) | Remove item from ticket entirely |
| Edit weight | Reopen WeightEntryModal (weight-based items only) |

### 4.5 Express Service Toggle
```
User toggles Express switch on ticket panel
  → ticket.isExpress = !ticket.isExpress
  → ALL items recalculated:
    FOR each item:
      newUnitPrice = isExpress ? (product.express_price || product.price) : product.price
      IF pricing_type === 'weight':
        lineTotal = totalWeight * newUnitPrice
      ELSE:
        lineTotal = quantity * newUnitPrice
  → Promised date recalculated:
    express uses express_completion_days (default: 0 = same day)
    standard uses default_completion_days (default: 1)
```

### 4.6 Customer Selection

**Registered Customer:**
```
User clicks "Seleccionar Cliente" → CustomerSearchModal opens
  → Search by name, phone, or email (substring, case-insensitive)
  → Default: first 10 customers if search empty
  → Select customer → ticket.customer = selected, ticket.customerConfirmed = true
```

**Walk-In Customer:**
```
User clicks "Walk-in" button
  → ticket.customer = null
  → ticket.isWalkIn = true
  → ticket.customerConfirmed = true
```

**Create New Customer (inline in search modal):**
```
User clicks "Agregar Cliente" in search modal
  → Inline form:
    Required: first_name, last_name, phone
    Optional: email, id_type, id_number, address fields
    Defaults: phone_country = '+507', city = 'Panama', district = 'Panama'
  → On save: customer created in database, auto-selected as ticket customer
```

### 4.7 Manual Discount
```
Percentage mode:
  User enters value (0-100)
  → productDiscountAmount = productsTotal * (value / 100)

Fixed amount mode:
  User enters dollar amount
  → productDiscountAmount = min(value, productsTotal)
```

### 4.8 Promotion Code
```
User enters code in promotion field
  → Lookup in promotions table: code match (case-insensitive)
  → Validate: is_active = true, within valid_from/valid_until, uses_count < max_uses
  → IF discount_type = 'percentage':
      promotionDiscountAmount = productsTotal * (discount_value / 100)
  → IF discount_type = 'amount':
      promotionDiscountAmount = min(discount_value, productsTotal)
  → On invalid: toast error, no discount applied
```

### 4.9 Delivery Charge
```
IF delivery items exist in ticket (product_type = 'delivery'):
  deliveryTotal = sum(delivery item lineTotals)
ELSE IF deliveryProduct is set (from settings):
  deliveryTotal = deliveryProduct.price
ELSE:
  deliveryTotal = 0

Free delivery toggle:
  deliveryDiscountAmount = freeDelivery ? deliveryTotal : 0
```

### 4.10 Processing Requirements
An order can ONLY be processed when:
1. `ticket.items.length > 0` — at least one item
2. `ticket.customerConfirmed === true` — customer selected or walk-in confirmed
3. Payment fully covers the total (see Section 10)

---

## 5. Pricing & Tax Calculations

### 5.1 Full Calculation Pipeline
```
INPUTS:
  items[]           - All ticket items
  manualDiscount    - { type: 'percentage'|'amount', value } or null
  promotion         - { discount_type, discount_value } or null
  deliveryProduct   - Product or null
  freeDelivery      - boolean
  isExpress         - boolean
  itbms_rate        - number (default: 7.00)

STEP 1: Separate items by type
  productItems  = items WHERE product_type !== 'delivery'
  deliveryItems = items WHERE product_type === 'delivery'

STEP 2: Product subtotal
  productsTotal = sum(productItems.lineTotal)

STEP 3: Delivery total
  IF deliveryItems exist:  deliveryTotal = sum(deliveryItems.lineTotal)
  ELSE IF deliveryProduct: deliveryTotal = deliveryProduct.price
  ELSE:                    deliveryTotal = 0

STEP 4: Manual discount
  IF type = 'percentage': productDiscountAmount = productsTotal * (value / 100)
  IF type = 'amount':     productDiscountAmount = min(value, productsTotal)
  ELSE:                   productDiscountAmount = 0

STEP 5: Promotion discount
  IF type = 'percentage': promotionDiscountAmount = productsTotal * (discount_value / 100)
  IF type = 'amount':     promotionDiscountAmount = min(discount_value, productsTotal)
  ELSE:                   promotionDiscountAmount = 0

STEP 6: Aggregate discounts
  totalProductDiscount = productDiscountAmount + promotionDiscountAmount
  deliveryDiscountAmount = freeDelivery ? deliveryTotal : 0

STEP 7: Subtotal after discounts
  productsAfterDiscount = productsTotal - totalProductDiscount
  deliveryAfterDiscount = deliveryTotal - deliveryDiscountAmount
  subtotal = productsAfterDiscount + deliveryAfterDiscount

STEP 8: ITBMS tax calculation
  taxableProductsAmount = sum(lineTotal) for items WHERE is_taxable !== false
  taxableDiscountRatio = productsTotal > 0 ? totalProductDiscount / productsTotal : 0
  taxableProductsAfterDiscount = taxableProductsAmount * (1 - taxableDiscountRatio)
  taxableDelivery = deliveryAfterDiscount  // Delivery is always taxable
  taxableAmount = taxableProductsAfterDiscount + taxableDelivery
  taxAmount = taxableAmount * (itbms_rate / 100)

STEP 9: Grand total
  total = subtotal + taxAmount

STEP 10: Aggregates
  totalWeight = sum(productItems.totalWeight)
  totalBags = sum(productItems.bags)
  totalPieces = sum(productItems.pieces || productItems.quantity)
```

### 5.2 Tax Rules (ITBMS)
- Tax rate is configurable per company (`itbms_rate`, default 7%)
- Products can be marked `is_taxable = false` for exemption
- Tax is applied AFTER discounts
- Discount is proportionally distributed: if 20% of products are non-taxable, 20% of the discount is excluded from tax calculation
- Delivery charges are ALWAYS taxable
- All monetary values use banker's rounding: `Math.round(value * 100) / 100`

### 5.3 Free Services Adjustment (Loyalty)
```
When punch card free services are applied at checkout:
  adjustedTotal = max(0, total - freeServicesApplied.totalDiscount)
  where totalDiscount = baseDiscount + taxDiscount per free service
```

### 5.4 Promised Date Calculation
```
IF isExpress:
  days = settings.express_completion_days (default: 0 = same day)
ELSE:
  days = settings.default_completion_days (default: 1)

promisedDate = today + days
promisedDate.setHours(12, 0, 0, 0)  // Always set to noon
```

---

## 6. Order Lifecycle

### 6.1 Status Values
| Status | Label (Spanish) | Description | Badge Color |
|--------|----------------|-------------|-------------|
| `pending` | Pendiente | Order created, awaiting processing | amber |
| `washing` | Lavando | Items in washing machine | blue |
| `drying` | Secando | Items in dryer | cyan |
| `folding` | Doblando | Items being folded | indigo |
| `ready` | Listo | Ready for customer pickup | emerald |
| `completed` | Completado | Delivered/picked up | slate |
| `cancelled` | Cancelado | Order cancelled | red |
| `refunded` | Reembolsado | Original order that was refunded | red |
| `refund` | Reembolso | Refund record (negative total) | rose |

### 6.2 Status Transitions
```
Normal flow (sequential):
  pending → washing → drying → folding → ready → completed

Special transitions:
  any → cancelled (admin/supervisor implied)
  any (except refunded/refund/cancelled) → refunded (via refund process)
```

### 6.3 Order Creation Process
```
1. Generate order_number = max(existing) + 1 (or 1 if first)
2. Create order record:
   { store_id, customer_id, order_number, customer_name,
     is_walk_in, is_express, status: 'pending',
     subtotal, discount_amount, delivery_charge, tax_amount, total,
     total_weight, total_bags, total_pieces,
     notes, promised_date, created_by }
3. Create order_items records (one per ticket item)
4. Create payment records (one per payment method used)
5. Process loyalty (if registered customer):
   a. Redeem free services (if applied)
   b. Redeem loyalty points (if used as payment)
   c. Add loyalty points earned
   d. Add punch card punches
6. Generate receipt text
7. Save receipt to Supabase Storage (receipts/{storeId}/{orderId}.txt)
8. Print receipt (if WebUSB printer connected)
9. Send order_created email notification (if enabled and customer has email)
10. Clear ticket state
```

### 6.4 Order Display Number
```
IF order.legacy_order_number exists:
  display = order.legacy_order_number  // e.g., "CC1234" (migrated from old system)
ELSE:
  display = "#" + order.order_number   // e.g., "#157"
```

### 6.5 Order Filtering (Orders Page)

**Status filter:** Dropdown with all 9 statuses + "Todos" (all)

**Date range presets:**
| Preset | Range |
|--------|-------|
| Hoy (Today) | Today 00:00 to now |
| 7 dias | Today - 6 days to today |
| 30 dias | Today - 29 days to today |
| Todo | No date filter |

**Custom date range:** Start and end date pickers

**Search:**
- Minimum 2 characters to trigger database search
- Searches: order_number, legacy_order_number, customer_name
- Returns up to 100 results
- When search active, status and date filters are bypassed

**Pagination:**
- Initial load: up to 500 orders
- Load more: 500 per batch
- Note: this should be migrated to cursor-based pagination (see Dev Brief)

### 6.6 Refund Process
```
PRECONDITIONS:
  - User must be admin role
  - Order status NOT IN ('refunded', 'refund', 'cancelled')
  - Order total > 0

PROCESS:
1. Admin clicks "Reembolsar" on order detail
2. Confirmation modal with optional reason text
3. On confirm:
   a. Create refund record in `refunds` table:
      { store_id, order_id, order_number, customer_name, amount: order.total,
        refund_type: 'full', reason, processed_by }
   b. Create refund order in `orders` table:
      { store_id, customer_id, customer_name, status: 'refund',
        total: -order.total, notes: "Reembolso - Orden #{number}. Razon: {reason}",
        refund_for_order_id: order.id }
   c. Update original order status to 'refunded'
   d. Reverse ALL loyalty transactions for the order (see 6.7)
```

### 6.7 Loyalty Reversal on Refund
For each `loyalty_transaction` linked to the refunded order:
| Transaction Type | Reversal Action |
|-----------------|-----------------|
| `points_earned` | Subtract `points_amount` from balance and total_earned |
| `points_redeemed` | Add `points_amount` back to balance, reduce total_redeemed |
| `punch_wash` | Subtract `punch_count` from wash_punches |
| `punch_dry` | Subtract `punch_count` from dry_punches |
| `free_wash_earned` | Subtract from pending_free_washes, total_free_washes_earned |
| `free_dry_earned` | Subtract from pending_free_drys, total_free_drys_earned |
| `redeem_free_wash` | Add back to pending_free_washes, reduce total_free_washes_redeemed |
| `redeem_free_dry` | Add back to pending_free_drys, reduce total_free_drys_redeemed |

---

## 7. Kanban Workflow (Machines)

### 7.1 Board Layout
```
+------------+------------+------------+------------+------------+
| Por Hacer  | Lavadoras  | Secadoras  | Doblando   | Completada |
| (pending)  | (washing)  | (drying)   | (folding)  | (ready)    |
|            |            |            |            |            |
| [Order]    | [Order]    | [Order]    | [Order]    | [Order]    |
| [Order]    |            |            |            |            |
+------------+------------+------------+------------+------------+
```

### 7.2 Order Card Display
Each card shows:
- Order number (with express badge if applicable)
- Customer name
- Item count and total weight
- Hours remaining until promised date
- Urgency indicator (color-coded left border)

### 7.3 Urgency Indicators
| Condition | Visual | Color |
|-----------|--------|-------|
| Overdue (`hoursRemaining < 0`) | Red left border (4px) | `border-l-error-500` |
| Urgent (`0 < hoursRemaining < 4`) | Orange left border (4px) | `border-l-warning-500` |
| Normal (`hoursRemaining >= 4`) | No border | Default |

**Hours remaining:** `(promisedDate - now) / (1000 * 60 * 60)` → displayed as `X.X hrs`

### 7.4 Sorting Options
- **By promised date** (default) — closest to deadline first
- **By creation date** — most recent first

### 7.5 Drag & Drop
```
User drags order card from Column A to Column B
  → Validate: source status !== target status
  → Update order.status to target column's status
  → Card moves to target column
  → Visual feedback: target column shows ring highlight during drag
```

### 7.6 Quick Advance Button
```
Each card has a "next status" arrow button
  statusOrder = ['pending', 'washing', 'drying', 'folding', 'ready', 'completed']
  currentIndex = statusOrder.indexOf(order.status)
  nextStatus = statusOrder[currentIndex + 1]
  → Click advances order one step
```

---

## 8. Customer Management

### 8.1 Customer Data Model

**Required Fields:**
| Field | Type | Validation |
|-------|------|-----------|
| `first_name` | VARCHAR(255) | Required, non-empty |
| `last_name` | VARCHAR(255) | Required, non-empty |
| `phone` | VARCHAR(50) | Required, non-empty |

**Optional Fields:**
| Field | Type | Default |
|-------|------|---------|
| `phone_country` | VARCHAR(10) | `+507` |
| `email` | VARCHAR(255) | null |
| `address_street` | TEXT | null |
| `address_building` | VARCHAR(255) | null |
| `address_corregimiento` | VARCHAR(255) | null |
| `address_district` | VARCHAR(255) | `Panama` |
| `address_province` | VARCHAR(255) | `Panama` |
| `id_type` | ENUM | null (`cedula`, `passport`, `ruc`) |
| `id_number` | VARCHAR(100) | null |
| `company_name` | VARCHAR(255) | null (RUC customers only) |
| `ruc` | VARCHAR(50) | null (RUC customers only) |
| `dv` | VARCHAR(5) | null (RUC customers only) |
| `can_be_invoiced` | BOOLEAN | `true` if id_type = `ruc` |
| `account_balance` | DECIMAL(10,2) | 0 |
| `notes` | TEXT | null |
| `preferences` | JSONB | `{ scent: 'Sin preferencia', softener: 'Sin preferencia' }` |

### 8.2 Panama-Specific ID Validation

**Cedula formats:**
| Pattern | Example | Description |
|---------|---------|-------------|
| `/^\d{1,2}-\d{1,4}-\d{1,6}$/` | `8-123-4567` | Regular cedula |
| `/^PE-\d{1,4}-\d{1,6}$/i` | `PE-12-3456` | Panama Este |
| `/^E-\d{1,4}-\d{1,6}$/i` | `E-12-34567` | Extranjero |
| `/^N-\d{1,4}-\d{1,6}$/i` | `N-12-34567` | Naturalizado |
| `/^[A-Z]{1,2}-\d{1,4}-\d{1,6}$/i` | `AV-12-34567` | Other prefixes |

**RUC format:** `/^\d+-\d+-\d+$/` (e.g., `155737034-2-2023`)

**Phone validation:** 8 digits starting with 5 or 6 (Panama mobile)

### 8.3 Phone Country Codes
| Code | Country |
|------|---------|
| +507 | Panama (default) |
| +1 | USA/Canada |
| +57 | Colombia |

### 8.4 Districts (Panama)
Panama, San Miguelito, Arraijan, La Chorrera

### 8.5 Customer Search
```
IF search query empty:
  Return first 10 customers ordered by first_name
ELSE:
  Filter where: full_name OR phone OR email CONTAINS query (case-insensitive)
```

### 8.6 Customer Details View
- Contact info (name, phone, email, address)
- ID info (cedula/passport/RUC)
- Account balance (if > 0)
- Laundry preferences (scent, softener)
- Loyalty status (points, punch card progress)
- Order history (all orders for this customer)
- Pending orders count

---

## 9. Loyalty Program

### 9.1 Program Overview
Two independent loyalty systems, each can be enabled/disabled separately:

| Program | Setting | Mechanism |
|---------|---------|-----------|
| **Punch Card** | `punch_card_enabled` | Buy N services, get 1 free (wash/dry) |
| **Points** | `points_enabled` | Earn currency-value points on purchases |

### 9.2 Punch Card System

**Configuration:**
| Setting | Default | Description |
|---------|---------|-------------|
| `wash_punches_required` | 9 | Punches needed for free wash |
| `dry_punches_required` | 9 | Punches needed for free dry |
| `punch_card_expiry_days` | 365 | Days until punches expire |

**Earning Punches:**
```
ONLY items in "Lavamatico" section are eligible
ONLY items with "lavado" in name → wash punches
ONLY items with "secado" in name → dry punches
ONLY paid services (free service redemptions do NOT earn punches)

washPunches = count(quantity) for "lavado" items - freeWashesUsed
dryPunches = count(quantity) for "secado" items - freeDrysUsed
```

**Earning Free Services:**
```
WHILE wash_punches >= wash_punches_required:
  pending_free_washes += 1
  wash_punches -= wash_punches_required

WHILE dry_punches >= dry_punches_required:
  pending_free_drys += 1
  dry_punches -= dry_punches_required
```

**Redeeming Free Services (automatic at checkout):**
```
FOR each ticket item in Lavamatico section:
  IF name includes "lavado" AND pending_free_washes > 0:
    freeCount = min(item.quantity, pending_free_washes)
    discount = freeCount * item.unitPrice
    taxDiscount = is_taxable ? discount * (itbms_rate / 100) : 0

  IF name includes "secado" AND pending_free_drys > 0:
    freeCount = min(item.quantity, pending_free_drys)
    discount = freeCount * item.unitPrice
    taxDiscount = is_taxable ? discount * (itbms_rate / 100) : 0

totalFreeDiscount = sum(discounts) + sum(taxDiscounts)
adjustedTotal = max(0, orderTotal - totalFreeDiscount)
```

### 9.3 Points System

**Configuration:**
| Setting | Default | Description |
|---------|---------|-------------|
| `points_per_dollar` | 0.05 | Points (in B/) earned per B/1 spent = 5% back |
| `min_redemption_amount` | 5.00 | Minimum B/ value to redeem |
| `points_expiry_days` | 365 | Days until points expire |

**Earning Points:**
```
EXCLUDED from eligible subtotal:
  1. Lavamatico section subtotal (self-service machines)
  2. Loyalty points used as payment
  3. Free services discount amount

eligibleSubtotal = subtotal - lavamaticSubtotal - loyaltyPayment - freeServicesDiscount
pointsEarned = round(eligibleSubtotal * points_per_dollar * 100) / 100
newBalance = round((currentBalance + pointsEarned) * 100) / 100
```

**Redeeming Points:**
```
PRECONDITIONS:
  - points_balance >= min_redemption_amount
  - No existing loyalty_points payment in current transaction

redemptionAmount = min(requestedAmount, remainingBalance, pointsBalance)
Applied as payment method 'loyalty_points'
newBalance = round((currentBalance - redemptionAmount) * 100) / 100
```

### 9.4 Loyalty Data Model
```
customer_loyalty {
  wash_punches, dry_punches,
  pending_free_washes, pending_free_drys,
  total_free_washes_earned, total_free_drys_earned,
  total_free_washes_redeemed, total_free_drys_redeemed,
  points_balance, total_points_earned, total_points_redeemed,
  last_punch_date, last_points_date
}
```

### 9.5 Loyalty Transaction Types
| Type | Direction | Description |
|------|-----------|-------------|
| `punch_wash` | Earn | Wash punches added |
| `punch_dry` | Earn | Dry punches added |
| `free_wash_earned` | Earn | Free wash reward triggered |
| `free_dry_earned` | Earn | Free dry reward triggered |
| `redeem_free_wash` | Spend | Free wash applied |
| `redeem_free_dry` | Spend | Free dry applied |
| `points_earned` | Earn | Points added from purchase |
| `points_redeemed` | Spend | Points used as payment |
| `points_expired` | System | Automated expiry |
| `punches_expired` | System | Automated expiry |
| `manual_adjustment` | Admin | Manual correction |

---

## 10. Payment Processing

### 10.1 Payment Methods
| Method Key | Display Name | Icon | Notes |
|-----------|-------------|------|-------|
| `cash` | Efectivo | Banknote | Change calculation |
| `card` | Tarjeta | CreditCard | Requires reference number |
| `yappy` | Yappy | Smartphone | Panama mobile payment (Banco General) |
| `ach` | ACH | Building | Bank transfer |
| `check` | Cheque | - | Check payment |
| `invoice` | Factura | FileText | Pay later (account credit) |
| `pickup` | Pagar en Recogida | - | Pay on pickup |
| `gift_card` | Tarjeta Regalo | Gift | Gift card redemption |
| `loyalty_points` | Puntos de Lealtad | Coins | If enabled and sufficient balance |

### 10.2 Payment Flow
```
1. User clicks "Procesar Orden" on TicketPanel
2. PaymentModal opens showing order total and available methods
3. User adds one or more payments:
   - Select method → enter amount
   - IF cash: optional cash tendered field for change calculation
   - IF card: required reference number (non-empty)
   - IF loyalty_points: amount = min(requested, remaining, pointsBalance)
     must be >= min_redemption_amount
4. Payment tracking:
   totalPaid = round(sum(payments.amount) * 100) / 100
   remaining = round(max(0, total - totalPaid) * 100) / 100
   overpaid = round(max(0, totalPaid - total) * 100) / 100
5. Process condition: canProcess = (remaining === 0)
6. Cash change: cashChange = max(0, cashTendered - cashAmount)
```

### 10.3 Split Payment
Multiple methods can be combined. Each stored as separate record in `payments` table.

### 10.4 Card Reference Validation
```
IF payment_method = 'card':
  cardReference.trim().length > 0  // Must not be empty
```

---

## 11. End-of-Day Reconciliation

### 11.1 Daily Statistics Calculation
```
INPUTS: All orders for selected date, filtered by store_id

regularOrders = WHERE status NOT IN ('refund', 'cancelled')
refundOrders = WHERE status = 'refund'

totalSales = sum(regularOrders.total)
totalRefunds = sum(abs(refundOrders.total))
netSales = totalSales - totalRefunds
totalTransactions = count(regularOrders)
refundCount = count(refundOrders)
avgTicket = totalSales / totalTransactions (or 0 if none)
totalWeight = sum(regularOrders.total_weight)
totalDiscounts = sum(regularOrders.discount_amount)
```

### 11.2 Payment Breakdown
```
Load all payments for the day's orders
Group by payment_method
Sum amounts per method
Display methods with amount > 0, sorted by amount descending
totalCollected = sum(all payment amounts)
```

### 11.3 Cash Counting (Panamanian Denominations)
| Denomination | Multiplier |
|-------------|------------|
| B/0.05 (nickel) | count * 0.05 |
| B/0.10 (dime) | count * 0.10 |
| B/0.25 (quarter) | count * 0.25 |
| B/0.50 (50 centesimos) | count * 0.50 |
| B/1 | count * 1 |
| B/5 | count * 5 |
| B/10 | count * 10 |
| B/20 | count * 20 |
| B/50 | count * 50 |
| B/100 | count * 100 |

### 11.4 Cash Reconciliation
```
countedCash = sum(denomination * count)
expectedCash = cashStart + cashPaymentsReceived
cashDifference = countedCash - expectedCash

Display:
  difference = 0  → green "Cuadre perfecto"
  difference > 0  → blue "Sobrante +B/{amount}"
  difference < 0  → red "Faltante -B/{amount}"
```

### 11.5 EOD Record
```
{ store_id, closing_date, total_sales, total_transactions, avg_ticket, total_weight,
  cash_start, cash_counted, cash_difference, payment_breakdown (JSON),
  total_discounts, total_refunds, notes, closed_by, closed_at }
```

### 11.6 EOD Permissions
| Action | Admin | Supervisor | Operator |
|--------|-------|------------|----------|
| Create new closing | Yes | Yes | Yes |
| Modify existing | Yes | No | No |
| View history | Yes | Yes | Yes |

---

## 12. Analytics Dashboard

### 12.1 Date Ranges
| Preset | Calculation |
|--------|-------------|
| Hoy | `startOfDay(today)` to `now` |
| Esta Semana | `today - 6 days` to `today` |
| Este Mes | `today - 29 days` to `today` |
| Custom | User-selected start/end dates |

### 12.2 KPI Cards
| KPI | Formula | Format |
|-----|---------|--------|
| Ventas Netas | `grossSales - totalRefunds` | B/{amount} |
| Total Ordenes | `count(regularOrders)` | Integer |
| Ticket Promedio | `grossSales / totalOrders` | B/{amount} |
| Peso Total | `sum(total_weight)` | {amount} kg |
| Ordenes Express | `count(is_express = true)` | Integer (% rate) |
| Clientes Unicos | `count(distinct customer_id)` | Integer |
| Peso Promedio | `totalWeight / totalOrders` | {amount} kg |
| Reembolsos | `count(refundOrders)` | Integer (B/{total}) |

### 12.3 Comparison Periods
| Type | Calculation |
|------|-------------|
| Periodo Anterior | Same duration, immediately prior |
| Ano Anterior | Same dates, year - 1 |
| Personalizado | User-selected comparison range |

### 12.4 Growth Calculation
```
IF previousValue = 0: growth = currentValue > 0 ? 100 : 0
ELSE: growth = ((currentValue - previousValue) / previousValue) * 100
Display: abs(growth).toFixed(1) + "%" with TrendingUp (green) or TrendingDown (red) icon
```

---

## 13. Reports & Export

### 13.1 Sales by Day Report
```
FOR each order in date range (excluding cancelled and refund):
  dateKey = YYYY-MM-DD from created_at
  Group by dateKey

PER day:
  qty, productsSubtotal, deliverySubtotal, totalItbms, total
Sort: dates descending
```

### 13.2 CSV Export
```
Headers: Fecha,Cantidad,Productos Subtotal,Delivery Subtotal,ITBMS,Total
Final row: TOTAL with column sums
Filename: ventas-por-dia-{startDate}-{endDate}.csv
Encoding: UTF-8 with BOM (\uFEFF prefix for Excel compatibility)
```

### 13.3 Planned Reports (Not Yet Implemented)
- Sales by Product
- Sales by Customer
- Payment Methods breakdown
- Loyalty program report
- Pickup scheduling report

---

## 14. Admin Settings

### 14.1 Company Settings
| Field | Type | Description |
|-------|------|-------------|
| `name` | Text | Business name |
| `ruc` | Text | Tax ID (RUC) |
| `dv` | Text | Verification digit |
| `address` | Text | Business address |
| `phone` | Text | Business phone |
| `itbms_rate` | Number | Tax rate % (default: 7%) |
| `logo_url` | URL | Company logo (max 2MB, PNG/JPG) |

### 14.2 Store Settings
| Field | Type | Description |
|-------|------|-------------|
| `name` | Text | Store location name |
| `address` | Text | Store address |
| `phone` | Text | Store phone |
| `opening_hours` | JSON | Per-day open/close times |
| `geolocation` | JSON | Lat/lng coordinates |

**Opening Hours Defaults:**
| Day | Open | Close | Closed? |
|-----|------|-------|---------|
| Monday-Friday | 07:00 | 20:00 | No |
| Saturday | 08:00 | 18:00 | No |
| Sunday | 09:00 | 15:00 | Yes |

### 14.3 Workflow Settings
| Field | Options | Default |
|-------|---------|---------|
| `default_completion_days` | 0 (Same day), 1, 2, 3 | 1 |
| `express_completion_days` | 0 (Same day), 1 | 0 |

### 14.4 User Management
- View all staff users for the store
- Invite new users (sends email invitation)
- Toggle active/inactive status
- Assign roles (admin, supervisor, operator)
- Resend invitation for pending users

### 14.5 Payment Methods
- Enable/disable payment methods
- Add custom methods (name + icon)
- Drag-and-drop reorder
- Default: Efectivo, Tarjeta, Yappy, ACH, Pagar al Recoger, Facturar

### 14.6 Printer Settings
- Connect/disconnect WebUSB thermal printer
- Supported: Epson TM-T20III, TM-T88, Star Micronics TSP
- Browser requirement: Chrome 61+ or Edge 79+
- Test print and cash drawer open

### 14.7 Product Management
- Organize products into sections (categories)
- Drag-and-drop reorder within sections
- Fields: name, price, express_price, pricing_type, product_type, is_taxable, is_active
- Parent/child relationships (variants)
- Section management: name, color, display_order, is_active

### 14.8 Promotions & Gift Cards
Status: "Proximamente" (Coming Soon) — placeholder UI

### 14.9 Loyalty Configuration
See Section 9.2 and 9.3 for punch card and points settings.

### 14.10 Pickup Schedule Configuration (New)
See Section 18 for full pickup scheduling specification.

---

## 15. Email Notifications

### 15.1 SMTP Configuration
| Field | Default | Description |
|-------|---------|-------------|
| `smtp_host` | - | SMTP server hostname |
| `smtp_port` | 587 | Port (465 for SSL) |
| `smtp_user` | - | SMTP username |
| `smtp_pass` | - | SMTP password |
| `smtp_from_name` | Company name | Sender display name |
| `smtp_from_email` | smtp_user | Sender email |
| `smtp_secure` | true | TLS enabled |

### 15.2 Email Templates
| Template ID | Trigger | Subject Pattern |
|-------------|---------|-----------------|
| `welcome` | New customer created | "Bienvenido a {company_name}!" |
| `order_created` | Order processed | "Tu orden #{order_number} ha sido recibida" |
| `order_ready` | Status → 'ready' | "Tu orden #{order_number} esta lista!" |
| `order_delivered` | Status → 'completed' | "Orden #{order_number} entregada" |
| `pickup_confirmed` | Pickup request confirmed | "Tu recogida ha sido confirmada" |
| `pickup_reminder` | Day before scheduled pickup | "Recordatorio: recogida programada manana" |

### 15.3 Template Variables
| Variable | Description |
|----------|-------------|
| `{company_name}` | Business name |
| `{customer_name}` | Customer full name |
| `{order_number}` | Order display number |
| `{total}` | Order total (formatted) |
| `{promised_date}` | Estimated completion date |
| `{store_phone}` | Store phone number |
| `{logo_url}` | Company logo URL |
| `{pickup_date}` | Scheduled pickup date |
| `{pickup_time}` | Scheduled pickup time slot |

### 15.4 Email API
```
POST /api/send-email
Body: { to, subject, html, text, company_id }
Response: { success: true, messageId } or { error: string }
SMTP credentials fetched from companies table by company_id
```

---

## 16. Receipt Printing

### 16.1 Printer Connection
```
WebUSB API:
  navigator.usb.requestDevice({ filters: [
    { vendorId: 0x04B8 },  // Epson
    { vendorId: 0x0519 }   // Star Micronics
  ]})
```

### 16.2 Receipt Layout (42-char width, 80mm thermal paper)
```
==========================================
          STORE NAME
         Company Name
        RUC: 155737034-2
      Address line here
       Phone: +507 xxxx
==========================================
Orden: #157              Fecha: 25 Mar 26
Cliente: Maria Gonzalez
Tipo: Express
==========================================
CANT   DESCRIPCION            TOTAL
------------------------------------------
2.5kg  Lava y Dobla           B/6.25
1      Cortinas               B/10.00
------------------------------------------
                Peso:        2.50 kg
             Subtotal:       B/16.25
             Descuento:      -B/2.00
             Delivery:       B/3.00
             ITBMS (7%):     B/1.21
             ──────────────────────
             TOTAL:          B/18.46
==========================================
PAGOS:
  Efectivo                   B/20.00
  Cambio                     B/1.54
==========================================
LEALTAD:
  Puntos ganados: +B/0.82
  Balance: B/5.82
  Sellos lavado: 3/9
  Sellos secado: 1/9
==========================================
  Fecha estimada: 25 Mar 2026

     Gracias por su preferencia!
      www.americanlaundry.com


                                    (cut)
```

### 16.3 ESC/POS Commands
| Command | Hex | Purpose |
|---------|-----|---------|
| Initialize | `1B 40` | Reset printer |
| Center | `1B 61 01` | Center align |
| Left | `1B 61 00` | Left align |
| Right | `1B 61 02` | Right align |
| Bold On | `1B 45 01` | Bold text |
| Bold Off | `1B 45 00` | Normal text |
| Double Size | `1D 21 11` | Large text |
| Normal Size | `1D 21 00` | Standard text |
| Feed | `1B 64 {n}` | Feed n lines |
| Partial Cut | `1D 56 01` | Cut paper |
| Open Drawer | `1B 70 00 19 FA` | Kick cash drawer |

### 16.4 Receipt Storage
```
Bucket: receipts
Path: {storeId}/{orderId}.txt
Format: Plain text
Updated on order: receipt_path = path
```

---

## 17. Customer Portal

### 17.1 Overview
A customer-facing web interface at `/portal/*` where registered customers can:
- View their active and past orders with real-time status tracking
- Schedule laundry pickup at available time slots set by the store
- Track loyalty points balance and punch card progress
- Manage their profile and delivery addresses

### 17.2 Portal Dashboard (`/portal/dashboard`)
Displays:
- **Active orders** — status != completed/cancelled, with color-coded status badges
- **Loyalty summary** — points balance, pending free services count
- **"Schedule Pickup" CTA** — primary action button
- **Quick links** — order history, loyalty details, profile

### 17.3 My Orders (`/portal/orders`)
```
TABS: Activas | Completadas

Active orders:
  WHERE customer_id = current AND status NOT IN ('completed', 'cancelled')
  Sorted by created_at DESC

Completed orders:
  WHERE customer_id = current AND status IN ('completed', 'cancelled')
  Sorted by created_at DESC
  Paginated: 20 per page

Each order card shows:
  - Order number + express badge
  - Date created
  - Status badge (color-coded)
  - Item summary (count, total weight)
  - Total amount
```

### 17.4 Order Detail (`/portal/orders/:id`)
- Full item list with quantities and prices
- Payment breakdown
- **Status timeline** — visual progress bar: Created → Washing → Drying → Folding → Ready → Completed
- Promised date
- Notes

### 17.5 My Loyalty (`/portal/loyalty`)
```
POINTS SECTION (if points_enabled):
  - Current balance: B/{points_balance}
  - Rate: "Ganas B/{points_per_dollar} por cada B/1.00"
  - Min redemption: B/{min_redemption_amount}
  - Transaction history table: Date | Type | Amount | Balance After
    (paginated, most recent first)

PUNCH CARD SECTION (if punch_card_enabled):
  - Wash progress: visual bar {wash_punches}/{wash_punches_required}
  - Dry progress: visual bar {dry_punches}/{dry_punches_required}
  - Available: "{pending_free_washes} lavado(s) gratis"
  - Available: "{pending_free_drys} secado(s) gratis"
```

### 17.6 My Profile (`/portal/profile`)
```
Editable: first_name, last_name, phone, email, address fields, preferences (scent, softener)
Read-only: id_type, id_number, account_balance
Password change: new password + confirm (same rules as staff, Section 2.5)
```

### 17.7 Portal Security (RLS Policies)
- Customers can ONLY see their own orders (`customer_id` matches `customer_auth.customer_id`)
- Customers can ONLY see their own loyalty data
- Customers can ONLY create/view/cancel their own pickup requests
- Pickup schedules are public-read (anyone can see available slots)
- Customers CANNOT see other customers' data, staff data, or admin settings

---

## 18. Pickup Scheduling

### 18.1 Overview
The pickup scheduling system allows customers to request laundry pickup at their address during time slots defined by the store. Staff can configure the weekly schedule, block dates, and manage incoming pickup requests.

### 18.2 Store Schedule Configuration (Admin)

**Weekly Schedule (`pickup_schedules` table):**
| Field | Type | Description |
|-------|------|-------------|
| `day_of_week` | INT (0-6) | 0=Sunday, 1=Monday, ..., 6=Saturday |
| `start_time` | TIME | Earliest pickup slot (e.g., 08:00) |
| `end_time` | TIME | Latest pickup slot end (e.g., 17:00) |
| `slot_duration_minutes` | INT | Length of each slot (default: 30) |
| `max_pickups_per_slot` | INT | Max concurrent bookings per slot (default: 3) |
| `is_active` | BOOLEAN | Enable/disable this day |

**Example Configuration:**
| Day | Start | End | Slots | Max/Slot |
|-----|-------|-----|-------|----------|
| Monday | 08:00 | 17:00 | 30 min | 3 |
| Tuesday | 08:00 | 17:00 | 30 min | 3 |
| Wednesday | 08:00 | 17:00 | 30 min | 3 |
| Thursday | 08:00 | 17:00 | 30 min | 3 |
| Friday | 08:00 | 17:00 | 30 min | 3 |
| Saturday | 09:00 | 14:00 | 30 min | 2 |
| Sunday | — | — | — | Disabled |

**Blocked Dates (`pickup_blocked_dates` table):**
- Store can block specific dates (holidays, closures, events)
- Each blocked date has an optional reason text
- Blocked dates override the weekly schedule

### 18.3 Customer Scheduling Flow

```
1. CALENDAR VIEW (/portal/schedule-pickup)
   - Shows next 14 days (configurable window)
   - Each day color-coded:
     GREEN = available slots exist
     GRAY  = store closed (from opening_hours) or blocked date
     RED   = fully booked (all slots at capacity)
   - Past dates are not selectable
   - Today is selectable only if current time < last slot start time

2. TIME SLOT SELECTION
   Customer selects a date → available slots appear

   Slot generation algorithm:
   FOR selected day_of_week:
     schedule = pickup_schedules WHERE day_of_week = selected AND is_active = true
     IF no schedule: day is unavailable
     slots = generate from start_time to end_time at slot_duration_minutes intervals
     Example: 08:00-17:00 at 30min = [08:00, 08:30, 09:00, ..., 16:30]

   Availability check per slot:
     existingBookings = COUNT(pickup_requests WHERE
       requested_date = selected_date AND
       requested_time_slot = slot_time AND
       status IN ('pending', 'confirmed'))
     isAvailable = existingBookings < max_pickups_per_slot

   Display: available slots as selectable buttons, full slots grayed out

3. ADDRESS & NOTES
   - Address pre-filled from customer profile (if set)
   - Editable: address_line (street + building), district, city
   - Optional notes field (e.g., "Leave at front desk", "Ring buzzer #3")

4. CONFIRMATION SCREEN
   Summary: selected date, time slot, delivery address, notes
   Customer confirms → pickup_request created:
     { customer_id, store_id, requested_date, requested_time_slot,
       status: 'pending', address_line, district, city, notes }

5. POST-CONFIRMATION
   - Success screen with pickup details
   - Email notification sent to customer (if enabled)
   - Notification to staff (if real-time enabled)
   - Customer can view request in "My Orders" or "My Pickups"
```

### 18.4 Pickup Request Statuses
| Status | Description | Who Changes |
|--------|-------------|-------------|
| `pending` | Customer requested, awaiting store confirmation | Customer creates |
| `confirmed` | Store confirmed, pickup scheduled | Staff confirms |
| `picked_up` | Laundry has been collected from customer | Staff marks |
| `cancelled` | Request cancelled | Customer or staff |

### 18.5 Status Transitions
```
pending → confirmed (staff confirms)
pending → cancelled (customer or staff cancels)
confirmed → picked_up (staff marks after collection)
confirmed → cancelled (staff cancels, e.g., driver unavailable)
```

### 18.6 Customer Pickup Cancellation
```
Customer can cancel their own pickup IF:
  - status = 'pending' OR status = 'confirmed'
  - requested_date is in the future (not today or past)

On cancel:
  - pickup_request.status → 'cancelled'
  - Slot freed (booking count decreases)
  - Cancellation confirmation displayed
```

### 18.7 Staff Pickup Management

**Pickup Requests View (new tab on Orders page or dedicated page):**
- List of pickup_requests for the store
- Filter by: status (pending, confirmed, picked_up, cancelled), date range
- Sort by: requested_date + requested_time_slot

**Staff Actions:**
| Action | Effect |
|--------|--------|
| Confirm | status → 'confirmed', email sent to customer |
| Mark Picked Up | status → 'picked_up', optionally link to POS order |
| Cancel | status → 'cancelled', reason required, email sent |
| Link to Order | Sets pickup_request.order_id → existing order |

**Processing Pickup → Order:**
```
When staff marks pickup as "picked_up":
  → Option 1: Create new POS order for this customer (opens POS with customer pre-selected)
  → Option 2: Link to existing order (if order was already created)
  pickup_request.order_id = linked order ID
```

### 18.8 Edge Cases
| Scenario | Behavior |
|----------|----------|
| Customer books last slot | Slot immediately becomes unavailable for others |
| Two customers book simultaneously | Database-level check: count bookings before insert |
| Store blocks a date with existing bookings | Existing confirmed bookings NOT auto-cancelled; staff must handle |
| Customer tries to book past slot today | Slots before current time are filtered out |
| Holiday with no schedule | Day appears as unavailable (gray) on calendar |

---

## 19. Database Schema Reference

### 19.1 Core Tables

**companies** — Business entity
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | UUID | PK | |
| name | VARCHAR(255) | - | NOT NULL |
| ruc | VARCHAR(50) | - | Tax ID |
| dv | VARCHAR(5) | - | Verification digit |
| address | TEXT | - | |
| phone | VARCHAR(50) | - | |
| logo_url | TEXT | - | |
| itbms_rate | DECIMAL(5,2) | 7.00 | Tax rate |
| default_completion_days | INTEGER | 1 | |
| express_completion_days | INTEGER | 0 | |
| smtp_host/port/user/pass/from_name/from_email/secure | various | - | Email config |
| created_at, updated_at | TIMESTAMPTZ | NOW() | |

**stores** — Physical locations
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | UUID | PK | |
| company_id | UUID | - | FK → companies, CASCADE |
| name | VARCHAR(255) | - | NOT NULL |
| address | TEXT | - | |
| phone | VARCHAR(50) | - | |
| opening_hours | JSONB | - | Per-day hours |
| geolocation | JSONB | - | Lat/lng |
| is_active | BOOLEAN | true | |

**users** — Staff accounts
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | UUID | PK | |
| auth_id | UUID | - | UNIQUE, links to Supabase Auth |
| store_id | UUID | - | FK → stores |
| email | VARCHAR(255) | - | UNIQUE, NOT NULL |
| full_name | VARCHAR(255) | - | NOT NULL |
| role | VARCHAR(50) | 'operator' | CHECK (admin, supervisor, operator) |
| is_active | BOOLEAN | true | |

**customers** — Customer records
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | UUID | PK | |
| store_id | UUID | - | FK → stores, CASCADE |
| first_name | VARCHAR(255) | - | NOT NULL |
| last_name | VARCHAR(255) | - | |
| email | VARCHAR(255) | - | |
| phone | VARCHAR(50) | - | |
| phone_country | VARCHAR(10) | '+507' | |
| address_* | various | - | street, building, corregimiento, district, province |
| id_type | VARCHAR(50) | - | cedula, passport, ruc |
| id_number | VARCHAR(100) | - | |
| company_name, ruc, dv | various | - | For RUC customers |
| can_be_invoiced | BOOLEAN | false | |
| account_balance | DECIMAL(10,2) | 0 | |
| preferences | JSONB | '{}' | scent, softener |
| is_active | BOOLEAN | true | |

**sections** — Product categories
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores |
| name | VARCHAR(255) | NOT NULL |
| color | VARCHAR(20) | Default: '#0077B6' |
| display_order | INTEGER | |
| is_active, is_online | BOOLEAN | |

**products** — Services and retail items
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores |
| section_id | UUID | FK → sections |
| parent_id | UUID | FK → products (self-referencing for variants) |
| name | VARCHAR(255) | NOT NULL |
| product_type | VARCHAR(50) | service, retail, delivery |
| pricing_type | VARCHAR(50) | weight, quantity |
| price, express_price, cost | DECIMAL(10,2) | |
| is_active, is_online, is_taxable | BOOLEAN | |
| has_children | BOOLEAN | |
| display_order | INTEGER | |

**orders** — Order records
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores |
| customer_id | UUID | FK → customers |
| order_number | SERIAL | Sequential |
| legacy_order_number | VARCHAR | Migrated orders |
| customer_name | VARCHAR(255) | Denormalized |
| status | VARCHAR(50) | 9 values (see 6.1) |
| is_walk_in, is_express | BOOLEAN | |
| subtotal, discount_amount, delivery_charge, tax_amount, total | DECIMAL(10,2) | |
| total_weight | DECIMAL(10,2) | |
| total_bags, total_pieces | INTEGER | |
| notes | TEXT | |
| promised_date | TIMESTAMPTZ | |
| refund_for_order_id | UUID | FK → orders |
| receipt_path | TEXT | |
| created_by | UUID | FK → users |

**order_items** — Line items per order
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| order_id | UUID | FK → orders, CASCADE |
| product_id | UUID | FK → products |
| product_name | VARCHAR(255) | Denormalized |
| quantity | INTEGER | |
| total_weight | DECIMAL(10,2) | |
| bags, pieces | INTEGER | |
| unit_price, line_total | DECIMAL(10,2) | |
| weight_entries | JSONB | Array of { weight, pieces, notes, isWetWeight } |

**payments** — Payment records
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| order_id | UUID | FK → orders, CASCADE |
| payment_method_id | UUID | FK → payment_methods |
| payment_method | VARCHAR(100) | Method name |
| amount | DECIMAL(10,2) | NOT NULL |
| reference | VARCHAR(255) | Card reference, etc. |
| change_amount | DECIMAL(10,2) | Cash change |

### 19.2 Loyalty Tables

**loyalty_settings** — per store configuration
| Column | Type | Default |
|--------|------|---------|
| punch_card_enabled | BOOLEAN | false |
| wash/dry_punches_required | INTEGER | 9 |
| punch_card_expiry_days | INTEGER | 365 |
| points_enabled | BOOLEAN | false |
| points_per_dollar | NUMERIC(10,4) | 0.05 |
| min_redemption_amount | NUMERIC(10,2) | 5.00 |
| points_expiry_days | INTEGER | 365 |

**customer_loyalty** — per customer balances
All integer/numeric fields for punches, free services, points (see Section 9.4)

**loyalty_transactions** — audit trail
Fields: customer_id, store_id, order_id, transaction_type, punch_count, points_amount, balance_before, balance_after, notes, created_by, created_at

### 19.3 Support Tables

**payment_methods** — store-configurable methods
**eod_closings** — daily closing records
**notification_settings** — email template config per company
**refunds** — refund records
**invoices** — invoice tracking (placeholder)
**gift_cards** + **gift_card_transactions** — gift card system (placeholder)
**promotions** — discount codes
**machines** — washer/dryer equipment tracking
**stock_movements** — inventory tracking (placeholder)

### 19.4 New Tables (Customer Portal)

**customer_auth** — links Supabase Auth to customer records
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| auth_id | UUID | UNIQUE, NOT NULL |
| customer_id | UUID | FK → customers, NOT NULL |

**pickup_schedules** — weekly pickup slot configuration
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores, NOT NULL |
| day_of_week | INT | 0-6, NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| slot_duration_minutes | INT | Default: 30 |
| max_pickups_per_slot | INT | Default: 3 |
| is_active | BOOLEAN | Default: true |

**pickup_blocked_dates** — holiday/closure dates
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores, NOT NULL |
| blocked_date | DATE | NOT NULL |
| reason | TEXT | Optional |

**pickup_requests** — customer pickup bookings
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| store_id | UUID | FK → stores, NOT NULL |
| customer_id | UUID | FK → customers, NOT NULL |
| order_id | UUID | FK → orders (linked after processing) |
| requested_date | DATE | NOT NULL |
| requested_time_slot | TIME | NOT NULL |
| status | TEXT | pending, confirmed, picked_up, cancelled |
| address_line | TEXT | Pickup address |
| district | TEXT | |
| city | TEXT | |
| notes | TEXT | Customer notes |

### 19.5 Required Indexes
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

### 19.6 RLS Policies (Customer Portal)
```sql
-- Customers see only their own pickup requests
CREATE POLICY "customers_own_pickups" ON pickup_requests
  FOR ALL USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

-- Customers see only their own orders
CREATE POLICY "customers_own_orders" ON orders
  FOR SELECT USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

-- Customers see only their own loyalty data
CREATE POLICY "customers_own_loyalty" ON customer_loyalty
  FOR SELECT USING (customer_id IN (
    SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
  ));

-- Pickup schedules are publicly readable
CREATE POLICY "public_read_schedules" ON pickup_schedules
  FOR SELECT USING (is_active = true);
```

---

## 20. Appendices

### 20.1 Seed Data

**Default Company:**
American Laundry | RUC: 155737034-2 | Panama | ITBMS: 7%

**Default Sections:**
| Name | Color | Order |
|------|-------|-------|
| Lava y Dobla | #0077B6 (Blue) | 0 |
| Lavamatico | #38B000 (Green) | 1 |
| Productos | #F48C06 (Orange) | 2 |
| Entregas | #9333EA (Purple) | 3 |

**Default Products — Lava y Dobla:**
| Name | Price | Express | Type |
|------|-------|---------|------|
| Lava y Dobla (por kg) | B/2.50 | B/3.50 | weight |
| Seca y Dobla (por kg) | B/1.75 | B/2.50 | weight |
| Cortinas | B/10.00 | B/15.00 | quantity |
| Almohadas | B/6.00 | B/8.00 | quantity |
| Sabanas | B/8.00 | B/12.00 | quantity |
| Toallas | B/2.00 | B/3.00 | quantity |
| Sobrecamas | B/15.00 | B/20.00 | quantity |
| Mantel | B/5.00 | B/7.00 | quantity |

**Default Products — Lavamatico (Self-Service):**
| Name | Price | Type |
|------|-------|------|
| Lavadora Pequena | B/3.00 | quantity |
| Lavadora Grande | B/5.00 | quantity |
| Secadora 30min | B/2.00 | quantity |

**Default Products — Retail:**
| Name | Price | Cost | SKU |
|------|-------|------|-----|
| Detergente (1L) | B/5.50 | B/3.00 | DET-001 |
| Suavizante (1L) | B/4.50 | B/2.50 | SUV-001 |
| Bolsa de Lavanderia | B/8.00 | B/4.00 | BOL-001 |

**Default Products — Delivery:**
| Name | Price | Type |
|------|-------|------|
| Recogida Local | B/3.00 | delivery |
| Entrega Local | B/3.00 | delivery |
| Recogida + Entrega | B/5.00 | delivery |

**Default Payment Methods:**
Efectivo, Tarjeta, Yappy, ACH, Pagar en Recogida, Factura

### 20.2 Status Color Reference
| Status | Background | Text |
|--------|-----------|------|
| pending | amber-100 | amber-700 |
| washing | blue-100 | blue-700 |
| drying | cyan-100 | cyan-700 |
| folding | indigo-100 | indigo-700 |
| ready | emerald-100 | emerald-700 |
| completed | slate-100 | slate-600 |
| cancelled | red-100 | red-700 |
| refunded | red-100 | red-700 |
| refund | rose-100 | rose-700 |

### 20.3 Formatting Reference
| Function | Example | Output |
|----------|---------|--------|
| formatCurrency(12.5) | 12.5 | "B/12.50" |
| formatWeight(2.5) | 2.5 | "2.50 kg" |
| formatPhone('+507', '67890000') | - | "+507 6789-0000" |
| formatPercentage(7.5, 1) | 7.5 | "7.5%" |
| formatOrderNumber(157) | 157 | "#157" |
| getInitials('Maria', 'Gonzalez') | - | "MG" |

### 20.4 Browser Requirements
| Feature | Minimum |
|---------|---------|
| WebUSB (Printer) | Chrome 61+, Edge 79+ |
| General App | Any modern browser (ES2020+) |
| Customer Portal | Any modern browser |

---

*End of Process Specification v2.0*
