# Panama E-Factura Integration Plan

Integration with **efacturapty** (the PAC) to emit DGI-authorized electronic
invoices (facturas electrónicas) and credit notes for every paid order.

## Decisions (locked)

- **Emission trigger:** auto-emit on every paid order. Consumidor final when the
  customer has no RUC; named invoice (receptor con RUC) when they do.
- **v1 document scope:** factura (`tipoDocumento` 01) + nota de crédito
  (`tipoDocumento` 06, wired to the existing refund flow).
- **Credentials:** ✅ obtained. Production account in **test mode** (`iAmb=2`,
  non-fiscal) — safe to emit test documents until go-live.

## What the PAC gives us (from Swagger `swagger/v1/swagger.json`)

- **Auth:** ✅ confirmed live — a single **API key sent as `Authorization: Bearer
  <key>`**. No OAuth token exchange needed (the Swagger advertises OAuth2 but the
  key works directly as a bearer token). The key lives server-side only.
- **Base API:** `https://api.efacturapty.com/api/v1`
- **Key endpoints:**
  - `POST /Invoices` — create + authorize through PAC→DGI. Returns `cufe`,
    `qrContent`, `qrContentImageBase64`, `protocoloAutorizacion`,
    `fechaAutorizacion`, `autorizada`, `secuence`, `xml`.
  - `GET /Invoices/Authorization/{cufe}` — poll authorization protocol + QR.
  - `GET /Invoices/{cufeId}/cafe-file` — CAFE PDF.
  - `GET /Invoices/{cufeId}/xml-file` — signed XML.
  - `POST /Invoices/{invoiceId}/mailto` — email the invoice to the receptor.
  - `POST /InvoiceEvents/CreateCancellation` — void a factura by CUFE.
  - `GET /Catalogs/{countries,currencies,locations,CPBSfams,CPBSsegs}` —
    reference data (location codes, product/service codification).

### Request shape (`InvoiceRequest`)
`{ datosGenerales, listaItems[], totales, detallePedido?, informacionLogistica?, datosLocal?, cufe? }`
matching the 8 examples in `Efactura PAC/`. Receptor types: `01` RUC,
`02` consumidor final, `03` gobierno, `04` extranjero.

## How it maps onto the existing app

- Reuse the **secure serverless-proxy pattern** from `api/send-email.js`:
  authenticate the Supabase session → derive the caller's company → read PAC
  secrets from the DB (never trust the client). PAC credentials live server-side.
- The **`invoices` feature flag** already exists (pro/enterprise) — gate UI on it.
- Data groundwork already present: `customer.ruc/dv/can_be_invoiced/id_type` +
  address fields, `company.ruc/dv/itbms_rate`, orders/items/payments.

## Phase 0 findings (validated live against the PAC, 2026-06-21)

1. ✅ **Auth** = `Authorization: Bearer <key>` (no OAuth). Other header forms 401.
2. ✅ **Numbering is PAC-owned.** Omitting `numeroDocumento` auto-increments the
   document number (verified: emitted three test invoices → doc `…0001 → 0002 →
   0003`, all `autorizada:true`). **No sequence table needed; we never send a
   document number or emisor `datosGenerales`.**
3. ✅ **Emisor auto-filled.** The minimal `consumidor_final.json` (receptor type
   `02` + país + `listaItems` + `totales`) emits and authorizes as-is.
4. ✅ **Emisor identity:** RUC `155737034-2-2023`, DV `38` (from existing invoices).
5. ✅ **Environment:** test (`iAmb=2`), QR → `dgi-fep-test.mef.gob.pa`.
6. ✅ Catalogs reachable: `countries`, `currencies`, `CPBSfams`/`CPBSsegs`
   (product codification), `locations`.

### Still to confirm before go-live
- Product/service **codification code** to use for laundry/wash-fold line items
  (pick from `CPBSfams`/`CPBSsegs`); confirm whether it's required for receptor
  type `02`.
- The `qrContentImageBase64`/`xml` fields came back empty on emit — fetch QR via
  `qrContent` URL and the PDF via `GET /Invoices/{cufeId}/cafe-file` instead.
- Reconcile numbering series: existing list shows `invoiceNumber` ~`0000003703`
  while fresh test emits started at `0000000001` (likely a separate test serie).

---

## Phases

### Phase 0 — Onboarding & end-to-end spike ✅ DONE
- Credentials obtained; auth, numbering, emisor auto-fill, and end-to-end
  emission validated live (see findings above). Three test invoices authorized.

### Phase 1 — Data model & config ✅ DONE
- Migration: `supabase-efactura-migration.sql` (transactional, idempotent).
  - `company_efactura_config` (mirrors `company_smtp`): `api_key`, `environment`
    (test/prod), `punto_facturacion`, `default_cpbs_code(_short)`, `enabled`.
    Staff-only RLS; service-role bypasses.
  - `electronic_invoices`: store/order/refund links, `doc_type`, `status`
    (`pending|emitting|authorized|rejected|cancelled`), cufe, protocolo,
    qr_content, cafe_pdf_path, referenced_cufe, request/response JSONB, attempts.
    Unique CUFE; **partial unique index = one active factura per order**
    (idempotency). Read = staff of store OR owning customer; write = staff.
  - `products.cpbs_code` / `cpbs_code_short` columns added.
- TS types: `src/types/efactura.ts` (exported from `src/types`).
- ⚠️ Not yet applied to Supabase — run in the SQL editor against a backup first
  (helper fns `auth_company_id`/`auth_store_ids`/`auth_is_staff` must exist).

### Phase 2 — Serverless proxy (`/api/efactura/*`)
- ✅ **Payload builder DONE** — pure module in `src/lib/efactura/`
  (`types`, `constants`, `money`, `buildInvoice`). Maps order/items/payments/
  customer → `InvoiceRequest`; redistributes order-level discount + ITBMS to
  per-line values in integer cents with a hard reconciliation guard. 19 unit
  tests pass, and builder output was **emitted + authorized live** against the
  test PAC (doc `0000000004`). Receptor types 01/02/04 + credit notes supported.
  - Known gaps for later: `codigoUbicacion` (needs `Catalogs/locations` lookup),
    CPBS product codification default, NC→original-CUFE reference wiring.
- ✅ **Serverless proxy DONE** — `api/efactura/` (mirrors `api/send-email.js`
  auth: Supabase session → company → server-side key, never trusts the client).
  - `_shared.ts` — auth, config loader, tenant guard, PAC client, and
    `buildPayloadForOrder` (loads order+items+payments+customer, enriches lines
    with product `is_taxable`/CPBS, derives delivery from totals).
  - `emit.ts` — POST `{order_id, doc_type?}`; records `electronic_invoices`,
    emits, persists CUFE/QR/protocolo. Idempotent (returns an already-authorized
    doc; partial unique index prevents dupes).
  - `cancel.ts` — POST `{invoice_id|cufe, reason}` → PAC anulación.
  - `cafe.ts` — GET CAFE PDF (base64).
  - Client helpers: `src/lib/efactura/client.ts` (`emitInvoice`/`cancelInvoice`/
    `fetchCafePdf`). All bundle clean; 104 tests pass.
  - Not exercised end-to-end yet (needs the migration applied + a config row);
    the builder→PAC leg is already proven live.
- **Catalogs passthrough** (`Catalogs/locations`, CPBS) — deferred to when the
  Settings UI needs it (Phase 4).

### Phase 3 — Auto-emission pipeline ✅ DONE
- **Live trigger:** `addOrder` (src/hooks/useDataLoader.js) fires
  `emitInvoice(order.id)` fire-and-forget after a paid sale (total > 0). Never
  blocks checkout; errors are logged and left for the retry worker. Refund orders
  (negative, status `refund`) are excluded — credit notes are Phase 5.
- **Shared core:** `emitOrder()` in `_shared.ts` (build → upsert row → PAC →
  persist) is reused by both the live endpoint and the worker.
- **Retry worker:** `api/efactura/retry.ts` (Vercel Cron every 15 min, see
  `vercel.json`). Picks up `pending` / `rejected` / stuck-`emitting` rows,
  re-emits with the owning company's config, caps at 5 attempts, batch 25.
  Auth via `CRON_SECRET`; service-role key.
- `emit.ts` now no-ops cleanly (`skipped`) when E-Factura is unconfigured or
  disabled, so the fire-and-forget trigger is safe for every tenant.
- **Required env vars (Vercel):** `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY`
  (already set for email), and **`CRON_SECRET`** (new). Frequent cron needs a
  Vercel Pro plan; on Hobby it runs daily.
- ⏳ Deferred: storing the CAFE PDF in the `receipts` bucket (currently fetched
  on demand via `cafe.ts`).

### Phase 4 — UI (gated on `invoices` feature) ✅ DONE
- **Settings:** `src/components/settings/EFacturaSettings.tsx` — enable toggle,
  write-only API key, environment, punto facturación, CPBS codes. Added as a
  Settings tab gated on `useFeature('invoices')`.
- **Staff Orders:** `InvoiceStatus` (staff) in the order details modal — status
  badge, CUFE, Emitir / Reintentar / Descargar PDF / Anular. Hidden for refunds.
- **Customer portal `OrderDetail`:** `InvoiceStatus` (view-only) — status,
  Descargar/Imprimir PDF, Ver en DGI.
- **Print / reprint CAFE:** `printCafe()` opens the PDF via a hidden iframe and
  fires the print dialog (popup-blocker-safe; works for first print and any
  reprint). Surfaced as an "Imprimir" button wherever a factura is authorized.
- **Reports → "Facturas Electrónicas":** `ElectronicInvoicesReport` — per-document
  list for the date range (fecha, tipo, orden, cliente, total, estado, CUFE) with
  summary cards (autorizadas / pendientes-rechazadas / total facturado),
  per-row Descargar·Imprimir·Ver-en-DGI, and CSV export. New report type gated on
  `useFeature('invoices')`.
- **EOD reconciliation:** `EFacturaReconciliation` in the End-of-Day page —
  confirms every sale of the day was billed to the DGI. Counters
  (autorizadas / en proceso / rechazadas / sin factura), a ventas-vs-facturado
  reconciliation line, a "requieren atención" list with one-click Emitir/
  Reintentar (+ "Emitir todas"), and reprint of authorized CAFEs. Gated on
  `useFeature('invoices')`.
- Shared: `src/components/efactura/InvoiceStatus.tsx`,
  `ElectronicInvoicesReport.tsx`, `EFacturaReconciliation.tsx`,
  `src/hooks/queries/useElectronicInvoice.ts` (order + store + per-order-set
  queries, emit/cancel, download/print helpers).
- ⏳ Deferred: inline QR image rendering (currently links to the DGI QR URL +
  CAFE PDF, which embeds the QR) — add a `qrcode` dep if an on-page QR is wanted.

### Phase 5 — credit notes & rollout ✅ DONE
- **Refunds → nota de crédito:** `createRefund` (useDataLoader.js) looks up the
  original order's authorized factura CUFE and fire-and-forget emits a NC
  (`doc_type 06`, `referenced_cufe`) for the refund order. Skipped if the
  original was never e-invoiced.
- **Sign normalization:** `buildPayloadForOrder` emits NCs as positive
  magnitudes (refund orders store negative amounts) — `abs()` is a no-op for
  sales, normalizes refunds.
- **Staff view:** refund order detail shows the NC (status + download/print),
  with `canEmit={false}` so no stray "emit factura" button. NCs also appear in
  the Reports "Facturas Electrónicas" list (labelled Nota Crédito).
- ⏳ Follow-up: NC is emitted as a *generic* credit note (matches the sanctioned
  `nota_credito_generica.json`); `referenced_cufe` is stored locally but the
  formal `documentosFiscalesReferenciados` block isn't sent yet — validate that
  against the PAC before relying on it for formal DGI referencing.

---

## Live verification (2026-06-21, test env)
- Ran the real `emitOrder` path against a real order through the test PAC.
- **Bug found & fixed:** `codigoInternoItem` was the product UUID (36 chars) →
  DGI rejected with `10103: …no debe superar los 20 caracteres`. Fixed to use
  the product **SKU** (truncated to 20, UUID fallback). Also now surfaces the
  real DGI rejection message (`gResProc`) instead of a generic "PAC HTTP 200".
- After the fix: order #3497 → `autorizada: true`, CUFE + protocolo + QR
  persisted; CAFE PDF downloads (138 KB). Leftover test row cleaned up.

## Go-live checklist
1. ✅ Apply `supabase-efactura-migration.sql` — DONE & verified (tables +
   `products.cpbs_code` present; dry-run payload build reconciles on real orders).
2. Set Vercel env: `CRON_SECRET` (and confirm `SUPABASE_URL` /
   `SUPABASE_SERVICE_ROLE_KEY`). Frequent cron needs Vercel Pro.
3. In Settings → Facturación Electrónica: paste the API key, set
   `punto_facturacion`, pick the laundry CPBS code, choose environment, enable.
4. **Rotate** the API key that was stored in plaintext during development.
5. Smoke test in `test` env: take a paid order → confirm `authorized` + CUFE,
   download/print CAFE, run a refund → confirm NC, check EOD reconciliation.
6. Flip environment to `prod` only when ready for fiscal documents.

### Phase 5 — Testing & rollout
- Unit tests for payload mapping against the example fixtures.
- Sandbox integration tests for emit / poll / cancel / NC.
- Per-company enablement, gradual rollout, monitoring of `rejected` invoices.

## Suggested build order
Phase 0 → 1 → 2 (proxy + builder) → 3 (auto-emission) → 4 (UI) → 5 (NC + rollout).
