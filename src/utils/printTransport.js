/**
 * Print transport layer.
 *
 * Abstracts *how* raw ESC/POS bytes reach the Epson TM-T20III so the receipt
 * builders in receiptPrinter.js stay transport-agnostic. Two backends:
 *
 *   - 'qz'     — QZ Tray local agent (default). Sends raw bytes to the
 *                Windows-installed printer BY NAME over a localhost WebSocket.
 *                Fully silent (no browser print dialog), works in any browser,
 *                and the printer stays shared with the rest of Windows.
 *   - 'webusp' — WebUSB fallback (handled directly in receiptPrinter.js).
 *
 * The active transport + selected printer name are read from localStorage so
 * the choice survives reloads and is configured once in Settings → Impresora.
 *
 * --- QZ Tray silent printing ---
 * QZ shows a trust prompt unless requests are SIGNED. For a fixed POS, generate
 * a self-signed cert once, register the public cert with QZ (override.crt), and
 * store the cert + private key in localStorage (keys QZ_CERT / QZ_PRIVATE_KEY)
 * or expose them via Settings. When both are present we wire request signing and
 * QZ prints with no prompt. Without them, QZ still works but prompts once (the
 * operator can tick "Remember"). See docs for the one-time setup.
 */

import qz from 'qz-tray';
import { sha256 } from 'js-sha256';

const LS = {
  transport: 'printer_transport', // 'qz' | 'webusb'
  printerName: 'printer_name',
  cert: 'QZ_CERT',
  privateKey: 'QZ_PRIVATE_KEY',
};

let configured = false;
let connecting = null;

/** Reads the configured transport; defaults to QZ Tray. */
export function getActiveTransport() {
  try {
    return localStorage.getItem(LS.transport) || 'qz';
  } catch {
    return 'qz';
  }
}

export function setActiveTransport(t) {
  try {
    localStorage.setItem(LS.transport, t);
  } catch {
    /* ignore */
  }
}

export function getSelectedPrinter() {
  try {
    return localStorage.getItem(LS.printerName) || '';
  } catch {
    return '';
  }
}

export function setSelectedPrinter(name) {
  try {
    localStorage.setItem(LS.printerName, name || '');
  } catch {
    /* ignore */
  }
}

/** One-time QZ API wiring: promise + hashing + (optional) request signing. */
function configureQz() {
  if (configured) return;

  qz.api.setPromiseType((resolver) => new Promise(resolver));
  qz.api.setSha256Type((data) => sha256(data));

  let cert = '';
  let key = '';
  try {
    cert = localStorage.getItem(LS.cert) || '';
    key = localStorage.getItem(LS.privateKey) || '';
  } catch {
    /* ignore */
  }

  if (cert) {
    qz.security.setCertificatePromise((resolve) => resolve(cert));
  }
  if (cert && key) {
    // Sign each request with the stored private key so QZ never prompts.
    qz.security.setSignatureAlgorithm('SHA512');
    qz.security.setSignaturePromise((toSign) => async (resolve, reject) => {
      try {
        const pk = await importRsaPrivateKey(key);
        const sig = await crypto.subtle.sign(
          'RSASSA-PKCS1-v1_5',
          pk,
          new TextEncoder().encode(toSign),
        );
        resolve(btoa(String.fromCharCode(...new Uint8Array(sig))));
      } catch (err) {
        reject(err);
      }
    });
  }

  configured = true;
}

/** Imports a PEM PKCS#8 private key for RSASSA-PKCS1-v1_5 / SHA-512 signing. */
async function importRsaPrivateKey(pem) {
  const body = pem
    .replace(/-----BEGIN [^-]+-----/, '')
    .replace(/-----END [^-]+-----/, '')
    .replace(/\s+/g, '');
  const der = Uint8Array.from(atob(body), (c) => c.charCodeAt(0));
  return crypto.subtle.importKey(
    'pkcs8',
    der,
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-512' },
    false,
    ['sign'],
  );
}

export function isQzConnected() {
  try {
    return qz.websocket.isActive();
  } catch {
    return false;
  }
}

/** Connects to the QZ Tray agent (idempotent; retries with backoff). */
export function connectQz() {
  if (isQzConnected()) return Promise.resolve(true);
  if (connecting) return connecting;
  configureQz();
  connecting = qz.websocket
    .connect({ retries: 3, delay: 1 })
    .then(() => true)
    .finally(() => {
      connecting = null;
    });
  return connecting;
}

export async function disconnectQz() {
  try {
    if (isQzConnected()) await qz.websocket.disconnect();
  } catch {
    /* ignore */
  }
}

/** Lists printer names known to QZ Tray (for the Settings dropdown). */
export async function listPrinters() {
  await connectQz();
  const found = await qz.printers.find();
  return Array.isArray(found) ? found : [found].filter(Boolean);
}

export async function getDefaultPrinter() {
  await connectQz();
  return qz.printers.getDefault();
}

function toHex(bytes) {
  let out = '';
  for (let i = 0; i < bytes.length; i++) {
    out += (bytes[i] & 0xff).toString(16).padStart(2, '0');
  }
  return out;
}

/**
 * Sends a raw ESC/POS byte array to a named printer via QZ Tray.
 * Falls back to the selected/default printer when no name is passed.
 */
export async function printRaw(byteArray, printerName) {
  await connectQz();
  const name = printerName || getSelectedPrinter() || (await getDefaultPrinter());
  if (!name) throw new Error('No hay impresora seleccionada (Configuración → Impresora).');
  const cfg = qz.configs.create(name, { encoding: 'CP858' });
  await qz.print(cfg, [{ type: 'raw', format: 'hex', data: toHex(byteArray) }]);
  return true;
}
