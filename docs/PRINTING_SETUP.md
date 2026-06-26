# Printing & Factura Electrónica — Setup (Windows 11 + Epson TM-T20III)

Silent, dialog-free thermal printing for every order flow. Receipts and the
factura electrónica (representación impresa with QR + CUFE) are generated as
ESC/POS and sent straight to the printer — no browser print dialog.

## Transport: QZ Tray (recommended)

QZ Tray is a small local agent that lets the web app send raw ESC/POS to the
**Windows-installed** Epson driver by printer name. Any browser; the printer
stays shared with the rest of Windows.

1. Install the Epson TM-T20III Windows driver (Epson APD) normally and print a
   Windows test page so the printer works in Windows.
2. Install **QZ Tray** on the counter PC (https://qz.io/download). It runs in the
   tray and listens on `localhost`.
3. In the app: **Configuración → Impresora** → method **QZ Tray** → **Buscar
   impresoras** → pick the Epson → it's saved (localStorage `printer_name`).
4. **Imprimir Prueba** to confirm.

### Silent printing (no QZ trust prompt)

Out of the box QZ shows a one-time trust prompt per site (the operator can tick
"Remember"). For fully unattended printing, sign requests with a certificate:

1. Generate a self-signed cert + RSA key (see qz.io "Signing Messages").
2. Register the **public** cert with QZ Tray as an override
   (`%PROGRAMFILES%\QZ Tray\override.crt`) and restart QZ.
3. Store the cert + PKCS#8 private key in this browser's localStorage as
   `QZ_CERT` and `QZ_PRIVATE_KEY` (PEM). `printTransport.js` wires SHA-512
   RSASSA-PKCS1-v1_5 signing automatically when both are present.

> The private key sits in the browser on a dedicated POS machine you control.
> Do **not** commit it; do not deploy it to shared/public devices.

### WebUSB fallback

`Configuración → Impresora → WebUSB` keeps the legacy path (Chrome/Edge only).
On Windows it requires replacing the Epson driver with WinUSB (Zadig), which
makes the printer exclusive to the browser — prefer QZ Tray.

## What prints per flow

| Flow | E-Factura | Ticket |
|---|---|---|
| Paid sale (consumidor final / contribuyente / gobierno / extranjero) | Factura `01` | Representación impresa (QR + CUFE) once authorized; internal receipt if not yet authorized |
| Pay-on-pickup (unpaid) | Deferred to settle | Internal claim ticket |
| B2B account (`billing_type=account`) | Consolidated factura later | Internal order ticket |
| Gift card sale/top-up | **None** | Non-fiscal info ticket ("NO ES COMPROBANTE FISCAL") |
| Refund | Nota de crédito `06` | Credit-note ticket (reprint from order detail) |
| ITBMS-exempt customer | Factura `01`, tasa `00` | Representación impresa (exento) |

Reprints: order detail → **Imprimir** (silent thermal) or **Imprimir PDF**
(official CAFE PDF via the browser dialog).

## Tax-exempt (exonerado) customers

Toggle **Exonerado de ITBMS** in the customer profile. Tax is zeroed on that
customer's orders and the factura emits tasa `00` lines. The DGI requires the
exemption to be substantiated — capture the **Nº de oficio / resolución**,
**autoridad emisora** (MIRE for diplomats, MEF/DGI for entities), issue/expiry
dates, and upload the credential image(s) (stored in the private
`customer-documents` bucket). Government RUCs (No-Tributario, `-NT-`) emit as
receptor type GOBIERNO (`03`) automatically.

> Confirmed: an exempt factura needs **no *información de exoneración* block** in
> the payload — tasa-`00` lines are sufficient. The proof metadata/images are
> kept on the customer for the business's own records, not sent to the PAC.

## Migrations to run (Supabase SQL editor)

- `supabase-customer-tax-exempt.sql` — exemption flag + proof metadata on `customers`.
- `supabase-customer-documents.sql` — `customer-documents` bucket + `customer_documents` table.
