# Printing & Factura Electrónica — Setup (Windows / macOS + Epson TM-T20III)

Silent, dialog-free thermal printing for every order flow. Receipts and the
factura electrónica (representación impresa with QR + CUFE) are generated as
ESC/POS and sent straight to the printer — no browser print dialog.

## Transport: QZ Tray (recommended)

QZ Tray is a small local agent that lets the web app send raw ESC/POS to the
**OS-installed** Epson driver by printer name. Any browser; the printer stays
shared with the rest of the OS. QZ runs on Windows and macOS alike.

1. Install the Epson TM-T20III driver (Epson APD on Windows; the macOS driver on
   Mac) and print an OS test page so the printer works outside the browser.
2. Install **QZ Tray** on the counter machine (https://qz.io/download). It runs in
   the tray / menu bar and listens on `localhost` (ports 8181/8182).
3. In the app: **Configuración → Impresora** → method **QZ Tray** → **Buscar
   impresoras** → pick the Epson → it's saved (localStorage `printer_name`).
4. **Imprimir Prueba** to confirm.

> Quick hardware check, bypassing the app/QZ — confirm the printer + driver work
> with a raw ESC/POS slip straight through the OS spooler:
> `printf '\x1B\x40Test\n\n\n\x1D\x56\x42\x00' | lp -d EPSON_TM_T20III -o raw`
> (macOS/CUPS; the printer name comes from `lpstat -p`).

### Silent printing (no QZ trust prompt)

Out of the box QZ shows a one-time trust prompt per site (the operator can tick
"Remember"). For fully unattended printing, sign the requests with a certificate.
The app uses **RSASSA-PKCS1-v1_5 / SHA-512** with a **PKCS#8** private key — match
those exactly or QZ will reject the signature.

**1. Generate the key pair** (once per POS machine). The key must be PKCS#8
(`-----BEGIN PRIVATE KEY-----`, not `BEGIN RSA PRIVATE KEY`):

```bash
mkdir -p ~/qz-pos-cert && cd ~/qz-pos-cert
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out private-key.pem
openssl req -x509 -new -key private-key.pem -sha256 -days 7300 \
  -out digital-certificate.txt \
  -subj "/CN=American Laundry POS/O=American Laundry/OU=POS/C=PA"
```

**2. Register the public cert with QZ Tray** so it auto-trusts our signature, via
the `authcert.override` property, then restart QZ.

- **macOS** — the properties file is root-owned inside the app bundle:
  ```bash
  echo "authcert.override=$HOME/qz-pos-cert/digital-certificate.txt" | \
    sudo tee -a "/Applications/QZ Tray.app/Contents/Resources/qz-tray.properties"
  osascript -e 'quit app "QZ Tray"'; sleep 2; open -a "QZ Tray"
  ```
- **Windows** — add the line to `%PROGRAMFILES%\QZ Tray\qz-tray.properties`
  (`authcert.override=C:\path\to\digital-certificate.txt`) and restart QZ, or drop
  the cert as `%PROGRAMFILES%\QZ Tray\override.crt`.

> A QZ Tray update can overwrite the properties file — re-apply this line after
> upgrading.

**3. Load the cert + key into the app.** In **Configuración → Impresora** open the
**"Impresión silenciosa (certificado)"** panel and paste both (helpers to copy
without echoing the key into a terminal: `pbcopy < digital-certificate.txt`, then
`pbcopy < private-key.pem`). **Guardar firma**, then reconnect. The panel stores
them in this browser's localStorage as `QZ_CERT` / `QZ_PRIVATE_KEY`;
`printTransport.js` then signs every request and QZ stops prompting. The key is
write-only in the UI (never re-displayed); leave it blank to keep the saved one.

> The private key sits in **one browser** on a POS machine you control. It is
> per-browser and per-origin: if you run the POS from a different browser or from
> the production URL, repeat step 3 there (steps 1–2 are per-machine). Do **not**
> commit it; do not load it on shared/public devices.

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
