/**
 * Receipt Printer Utility for Epson TM-T20III
 * Generates ESC/POS commands for thermal printing and sends them silently.
 *
 * Two transports (see printTransport.js): QZ Tray (default — raw print to the
 * Windows-installed printer by name, any browser, no dialog) and WebUSB
 * (fallback — Chrome/Edge only). The builders below are transport-agnostic;
 * only sendToPrinter() branches on the active transport.
 */

import {
  getActiveTransport,
  getSelectedPrinter,
  connectQz,
  isQzConnected,
  printRaw as qzPrintRaw,
} from './printTransport';

// ESC/POS Commands for Epson TM-T20III
const ESC = 0x1B;
const GS = 0x1D;
const LF = 0x0A;

const COMMANDS = {
  // Initialize printer
  INIT: [ESC, 0x40],
  
  // Text alignment
  ALIGN_LEFT: [ESC, 0x61, 0x00],
  ALIGN_CENTER: [ESC, 0x61, 0x01],
  ALIGN_RIGHT: [ESC, 0x61, 0x02],
  
  // Text size
  SIZE_NORMAL: [GS, 0x21, 0x00],
  SIZE_DOUBLE_HEIGHT: [GS, 0x21, 0x01],
  SIZE_DOUBLE_WIDTH: [GS, 0x21, 0x10],
  SIZE_DOUBLE: [GS, 0x21, 0x11], // Double height and width
  
  // Text style
  BOLD_ON: [ESC, 0x45, 0x01],
  BOLD_OFF: [ESC, 0x45, 0x00],
  UNDERLINE_ON: [ESC, 0x2D, 0x01],
  UNDERLINE_OFF: [ESC, 0x2D, 0x00],
  
  // Paper
  CUT: [GS, 0x56, 0x00], // Full cut
  PARTIAL_CUT: [GS, 0x56, 0x01],
  FEED_LINES: (n) => [ESC, 0x64, n], // Feed n lines
  
  // Cash drawer
  OPEN_DRAWER: [ESC, 0x70, 0x00, 0x19, 0xFA], // Open drawer (pin 2)
};

// Characters per line: Font A on 80mm paper is 48 columns — the full width the
// fiscal CAFE block (CUFE) already wraps at. Item columns sum to RECEIPT_WIDTH.
const RECEIPT_WIDTH = 48;
const COL_QTY = 6;
const COL_TOTAL = 14;
const COL_DESC = RECEIPT_WIDTH - COL_QTY - COL_TOTAL; // 28

// Printer connection state
let printerDevice = null;
let printerInterface = null;
let printerEndpoint = null;

/**
 * Connect to the printer using the active transport.
 * QZ Tray: opens the localhost websocket (printer is addressed by name per job).
 * WebUSB: requests + claims the USB device (legacy fallback).
 */
export async function connectPrinter() {
  if (getActiveTransport() === 'qz') {
    await connectQz();
    return true;
  }
  return connectWebUsbPrinter();
}

/**
 * Request and connect to the printer via WebUSB (fallback transport).
 */
export async function connectWebUsbPrinter() {
  try {
    // Check if WebUSB is supported
    if (!navigator.usb) {
      throw new Error('WebUSB no está soportado en este navegador. Use Chrome o Edge.');
    }
    
    // Request printer (Epson vendor ID: 0x04B8)
    printerDevice = await navigator.usb.requestDevice({
      filters: [
        { vendorId: 0x04B8 }, // Epson
        { vendorId: 0x0519 }, // Star Micronics (alternative)
      ]
    });
    
    await printerDevice.open();
    
    // Select configuration
    if (printerDevice.configuration === null) {
      await printerDevice.selectConfiguration(1);
    }
    
    // Claim interface
    const interfaces = printerDevice.configuration.interfaces;
    for (const iface of interfaces) {
      try {
        await printerDevice.claimInterface(iface.interfaceNumber);
        printerInterface = iface;
        
        // Find bulk OUT endpoint
        for (const alternate of iface.alternates) {
          for (const endpoint of alternate.endpoints) {
            if (endpoint.direction === 'out' && endpoint.type === 'bulk') {
              printerEndpoint = endpoint;
              break;
            }
          }
        }
        break;
      } catch (e) {
        console.log(`Could not claim interface ${iface.interfaceNumber}:`, e);
      }
    }
    
    if (!printerEndpoint) {
      throw new Error('No se encontró endpoint de impresión');
    }
    
    console.log('Printer connected:', printerDevice.productName);
    return true;
  } catch (error) {
    console.error('Error connecting to printer:', error);
    throw error;
  }
}

/**
 * Whether printing is currently possible.
 * QZ Tray: ready when a printer has been selected in Settings (the websocket is
 * (re)connected on demand per job). WebUSB: ready when the device is open.
 */
export function isPrinterConnected() {
  if (getActiveTransport() === 'qz') {
    return !!getSelectedPrinter() || isQzConnected();
  }
  return printerDevice !== null && printerDevice.opened;
}

/**
 * Disconnect from printer
 */
export async function disconnectPrinter() {
  if (printerDevice && printerDevice.opened) {
    try {
      if (printerInterface) {
        await printerDevice.releaseInterface(printerInterface.interfaceNumber);
      }
      await printerDevice.close();
    } catch (e) {
      console.error('Error disconnecting printer:', e);
    }
  }
  printerDevice = null;
  printerInterface = null;
  printerEndpoint = null;
}

/**
 * Send raw ESC/POS bytes to the printer using the active transport.
 */
async function sendToPrinter(data) {
  if (getActiveTransport() === 'qz') {
    await qzPrintRaw(data);
    return;
  }
  if (!printerDevice || !printerDevice.opened || !printerEndpoint) {
    throw new Error('Impresora no conectada');
  }
  const uint8Data = new Uint8Array(data);
  await printerDevice.transferOut(printerEndpoint.endpointNumber, uint8Data);
}

/**
 * Fold text to single-byte ASCII so it prints correctly on any printer codepage
 * and — critically — 1 character == 1 byte == 1 column. Accented letters would
 * otherwise be 2 UTF-8 bytes, both garbling the glyph and overflowing the fixed
 * column widths (pushing the line total onto a second line). Each source char
 * maps to exactly one ASCII char so column alignment / truncation stay exact.
 */
function foldAscii(text) {
  return String(text ?? '')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '') // strip diacritics: á->a, í->i, ñ->n, ü->u
    .replace(/¡/g, '!') // ¡
    .replace(/¿/g, '?') // ¿
    .replace(/[‘’]/g, "'") // curly single quotes
    .replace(/[“”«»]/g, '"') // curly/angle double quotes
    .replace(/[–—]/g, '-') // en/em dash
    .replace(/…/g, '.') // ellipsis
    .replace(/[^\x20-\x7E]/g, '?'); // any remaining non-ASCII -> single char
}

/**
 * Convert string to printable single-byte bytes (ASCII-folded).
 */
function textToBytes(text) {
  const encoder = new TextEncoder();
  return Array.from(encoder.encode(foldAscii(text)));
}

/**
 * Format currency for receipt
 */
function formatCurrency(amount) {
  return `B/${Number(amount || 0).toFixed(2)}`;
}

/**
 * Format date for receipt
 */
function formatDate(dateStr) {
  const date = new Date(dateStr);
  return date.toLocaleDateString('es-PA', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
}

/**
 * Pad string to fixed width
 */
function padRight(str, width) {
  const s = String(str || '');
  return s.substring(0, width).padEnd(width);
}

function padLeft(str, width) {
  const s = String(str || '');
  return s.substring(0, width).padStart(width);
}

/**
 * Generate receipt data object
 */
export function generateReceiptData(order, company, store, items, payments, loyaltyInfo = null) {
  return {
    // Store and Company info
    storeName: store?.name || '',
    companyName: company?.name || 'American Laundry',
    companyRuc: company?.ruc ? `RUC: ${company.ruc}-${company.dv || ''}` : '',
    storeAddress: store?.address || '',
    storePhone: store?.phone || '',
    
    // Order info
    orderNumber: order.legacy_order_number || `#${order.order_number}`,
    date: formatDate(order.created_at || new Date()),
    customerName: order.customer_name || 'Walk-in',
    isExpress: order.is_express,
    promisedDate: order.promised_date ? formatDate(order.promised_date) : null,
    
    // Items — tolerant of both shapes: DB order_items (snake_case) and the live
    // POS cart item (camelCase, name/pricing under a nested `product`).
    items: (items || []).map(item => {
      const quantity = item.quantity || 1;
      const weight = item.total_weight ?? item.totalWeight ?? 0;
      // Fiscal representation: precio unitario and valor are SIN ITBMS (the DGI
      // factura desglosa el ITBMS aparte). Prices are stored ex-ITBMS already.
      const unitPrice = item.unit_price ?? item.unitPrice ?? item.price ?? 0;
      const total = item.line_total ?? item.lineTotal ?? (quantity * unitPrice) ?? 0;
      const isWeight =
        item.product?.pricing_type === 'weight' ||
        item.pricing_type === 'weight' ||
        weight > 0;
      // Per-line discount is only present on the live POS cart ({mode, value});
      // DB order_items don't carry it (it's folded into the order discount).
      const d = item.discount;
      const lineDiscount = d && d.value
        ? Math.min(Math.max(0, d.mode === 'pct' ? total * (d.value / 100) : Number(d.value) || 0), total)
        : 0;
      return {
        name: item.product_name || item.name || item.product?.name || 'Producto',
        quantity,
        weight,
        unitPrice,
        total,
        lineDiscount: Math.round((lineDiscount + Number.EPSILON) * 100) / 100,
        isWeight,
      };
    }),
    
    // Totals
    subtotal: order.subtotal || 0,
    discount: order.discount_amount || 0,
    delivery: order.delivery_charge || 0,
    tax: order.tax_amount || 0,
    total: order.total || 0,
    
    // Payments
    payments: (payments || []).map(p => ({
      method: p.method || 'cash',
      methodName: getPaymentMethodName(p.method || 'cash'),
      amount: p.amount || 0,
      reference: p.reference || '',
    })),
    totalPaid: (payments || []).reduce((sum, p) => sum + (p.amount || 0), 0),
    change: Math.max(0, (payments || []).reduce((sum, p) => sum + (p.amount || 0), 0) - (order.total || 0)),
    
    // Additional info
    notes: order.notes,
    totalWeight: order.total_weight || 0,
    totalBags: order.total_bags || 0,
    
    // Loyalty info (optional)
    loyalty: loyaltyInfo ? {
      pointsEarned: loyaltyInfo.pointsEarned || 0,
      pointsBalance: loyaltyInfo.pointsBalance || 0,
      pointsUsed: loyaltyInfo.pointsUsed || 0,
      washPunches: loyaltyInfo.washPunches || 0,
      dryPunches: loyaltyInfo.dryPunches || 0,
      washPunchesTotal: loyaltyInfo.washPunchesTotal || 0,
      dryPunchesTotal: loyaltyInfo.dryPunchesTotal || 0,
      punchesRequired: loyaltyInfo.punchesRequired || 10,
      freeWashesEarned: loyaltyInfo.freeWashesEarned || 0,
      freeDrysEarned: loyaltyInfo.freeDrysEarned || 0,
      freeWashesAvailable: loyaltyInfo.freeWashesAvailable || 0,
      freeDrysAvailable: loyaltyInfo.freeDrysAvailable || 0,
      freeServicesUsed: loyaltyInfo.freeServicesUsed || { washes: 0, drys: 0 },
    } : null,
  };
}

/**
 * Get payment method display name
 */
function getPaymentMethodName(method) {
  const names = {
    cash: 'Efectivo',
    card: 'Tarjeta',
    yappy: 'Yappy',
    ach: 'ACH / Transferencia',
    check: 'Cheque',
    invoice: 'Factura',
    pickup: 'Pagar en Recogida',
    gift_card: 'Tarjeta Regalo',
    loyalty_points: 'Puntos de Lealtad',
  };
  return names[method] || method;
}

/**
 * Generate plain text receipt (for storage)
 */
export function generateReceiptText(receiptData) {
  const LINE_WIDTH = RECEIPT_WIDTH; // Characters per line for 80mm paper
  const DIVIDER = '='.repeat(LINE_WIDTH);
  const THIN_DIVIDER = '-'.repeat(LINE_WIDTH);
  
  // Ensure receiptData has all required fields with defaults
  const data = {
    storeName: receiptData?.storeName || '',
    companyName: receiptData?.companyName || 'American Laundry',
    companyRuc: receiptData?.companyRuc || '',
    storeAddress: receiptData?.storeAddress || '',
    storePhone: receiptData?.storePhone || '',
    orderNumber: receiptData?.orderNumber || '#0',
    date: receiptData?.date || '',
    customerName: receiptData?.customerName || 'Walk-in',
    isExpress: receiptData?.isExpress || false,
    promisedDate: receiptData?.promisedDate || null,
    items: receiptData?.items || [],
    subtotal: receiptData?.subtotal || 0,
    discount: receiptData?.discount || 0,
    delivery: receiptData?.delivery || 0,
    tax: receiptData?.tax || 0,
    total: receiptData?.total || 0,
    payments: receiptData?.payments || [],
    change: receiptData?.change || 0,
    notes: receiptData?.notes || '',
    totalWeight: receiptData?.totalWeight || 0,
    totalBags: receiptData?.totalBags || 0,
    loyalty: receiptData?.loyalty || null,
  };
  
  let text = '';
  
  // Header - Store name first, then company, then RUC
  if (data.storeName) {
    text += centerText(data.storeName.toUpperCase(), LINE_WIDTH) + '\n';
  }
  text += centerText(data.companyName, LINE_WIDTH) + '\n';
  if (data.companyRuc) {
    text += centerText(data.companyRuc, LINE_WIDTH) + '\n';
  }
  if (data.storeAddress) {
    text += centerText(data.storeAddress, LINE_WIDTH) + '\n';
  }
  if (data.storePhone) {
    text += centerText(`Tel: ${data.storePhone}`, LINE_WIDTH) + '\n';
  }
  
  text += DIVIDER + '\n';
  
  // Order info
  text += `Orden: ${data.orderNumber}`;
  if (data.isExpress) text += ' [EXPRESS]';
  text += '\n';
  text += `Fecha: ${data.date}\n`;
  text += `Cliente: ${data.customerName}\n`;
  if (data.promisedDate) {
    text += `Listo para: ${data.promisedDate}\n`;
  }
  
  text += THIN_DIVIDER + '\n';
  
  // Items header
  text += padRight('CANT', 6) + padRight('DESCRIPCION', COL_DESC) + padLeft('TOTAL', 14) + '\n';
  text += THIN_DIVIDER + '\n';
  
  // Items — line 1: qty | name | total; line 2 (indented): unit price + discount.
  for (const item of data.items) {
    const qtyStr = item.isWeight
      ? `${(item.weight || 0).toFixed(2)}kg`
      : `${item.quantity || 1}x`;
    const totalStr = formatCurrency(item.total || 0);

    text += padRight(qtyStr, COL_QTY) + padRight(item.name || 'Producto', COL_DESC) + padLeft(totalStr, COL_TOTAL) + '\n';
    const showDetail = item.isWeight || (item.quantity || 1) > 1 || (item.lineDiscount || 0) > 0;
    if (showDetail) {
      let detail = item.isWeight
        ? `${formatCurrency(item.unitPrice || 0)}/kg`
        : `${formatCurrency(item.unitPrice || 0)} c/u`;
      if ((item.lineDiscount || 0) > 0) detail += `  Desc: -${formatCurrency(item.lineDiscount)}`;
      text += ' '.repeat(COL_QTY) + detail + '\n';
    }
  }
  
  text += THIN_DIVIDER + '\n';
  
  // Totals
  if (data.totalWeight > 0) {
    text += alignLeftRight('Peso Total:', `${data.totalWeight.toFixed(2)} kg`, LINE_WIDTH) + '\n';
  }
  if (data.totalBags > 0) {
    text += alignLeftRight('Bolsas:', data.totalBags.toString(), LINE_WIDTH) + '\n';
  }
  
  text += alignLeftRight('Subtotal:', formatCurrency(data.subtotal), LINE_WIDTH) + '\n';

  if (data.discount > 0) {
    text += alignLeftRight('Descuento:', `-${formatCurrency(data.discount)}`, LINE_WIDTH) + '\n';
  }
  if (data.delivery > 0) {
    text += alignLeftRight('Delivery:', formatCurrency(data.delivery), LINE_WIDTH) + '\n';
  }

  text += alignLeftRight('ITBMS:', formatCurrency(data.tax), LINE_WIDTH) + '\n';
  text += THIN_DIVIDER + '\n';
  text += alignLeftRight('TOTAL:', formatCurrency(data.total), LINE_WIDTH) + '\n';
  
  text += DIVIDER + '\n';
  
  // Payments
  text += centerText('FORMA DE PAGO', LINE_WIDTH) + '\n';
  for (const payment of data.payments) {
    let paymentLine = payment.methodName || payment.method || 'Pago';
    if (payment.reference) paymentLine += ` (${payment.reference})`;
    text += alignLeftRight(paymentLine, formatCurrency(payment.amount || 0), LINE_WIDTH) + '\n';
  }
  
  if (data.change > 0) {
    text += alignLeftRight('Cambio:', formatCurrency(data.change), LINE_WIDTH) + '\n';
  }
  
  text += DIVIDER + '\n';
  
  // Notes
  if (data.notes) {
    text += 'Notas: ' + data.notes + '\n';
    text += THIN_DIVIDER + '\n';
  }
  
  // Loyalty Section
  if (data.loyalty) {
    const loyalty = data.loyalty;
    const freeServicesUsed = loyalty.freeServicesUsed || { washes: 0, drys: 0 };
    const hasLoyaltyInfo = (loyalty.pointsEarned || 0) > 0 || (loyalty.pointsUsed || 0) > 0 || 
                           (loyalty.washPunches || 0) > 0 || (loyalty.dryPunches || 0) > 0 ||
                           (loyalty.freeWashesEarned || 0) > 0 || (loyalty.freeDrysEarned || 0) > 0 ||
                           (freeServicesUsed.washes || 0) > 0 || (freeServicesUsed.drys || 0) > 0;
    
    if (hasLoyaltyInfo) {
      text += centerText('*** PROGRAMA DE LEALTAD ***', LINE_WIDTH) + '\n';
      text += THIN_DIVIDER + '\n';
      
      // Free services used in this order
      if ((freeServicesUsed.washes || 0) > 0 || (freeServicesUsed.drys || 0) > 0) {
        text += centerText('SERVICIOS GRATIS APLICADOS', LINE_WIDTH) + '\n';
        if (freeServicesUsed.washes > 0) {
          text += alignLeftRight('  Lavados gratis:', freeServicesUsed.washes.toString(), LINE_WIDTH) + '\n';
        }
        if (freeServicesUsed.drys > 0) {
          text += alignLeftRight('  Secados gratis:', freeServicesUsed.drys.toString(), LINE_WIDTH) + '\n';
        }
        text += '\n';
      }
      
      // Points section
      if ((loyalty.pointsEarned || 0) > 0 || (loyalty.pointsUsed || 0) > 0 || (loyalty.pointsBalance || 0) > 0) {
        text += centerText('PUNTOS CASHBACK', LINE_WIDTH) + '\n';
        if ((loyalty.pointsUsed || 0) > 0) {
          text += alignLeftRight('  Puntos usados:', `-B/${(loyalty.pointsUsed || 0).toFixed(2)}`, LINE_WIDTH) + '\n';
        }
        if ((loyalty.pointsEarned || 0) > 0) {
          text += alignLeftRight('  Puntos ganados:', `+B/${(loyalty.pointsEarned || 0).toFixed(2)}`, LINE_WIDTH) + '\n';
        }
        text += alignLeftRight('  Saldo actual:', `B/${(loyalty.pointsBalance || 0).toFixed(2)}`, LINE_WIDTH) + '\n';
        text += '\n';
      }
      
      // Punch card section
      if ((loyalty.washPunches || 0) > 0 || (loyalty.dryPunches || 0) > 0 || 
          (loyalty.freeWashesEarned || 0) > 0 || (loyalty.freeDrysEarned || 0) > 0) {
        text += centerText('TARJETA DE SELLOS', LINE_WIDTH) + '\n';
        
        // Wash punches
        if ((loyalty.washPunches || 0) > 0 || (loyalty.washPunchesTotal || 0) > 0) {
          const washProgress = `${loyalty.washPunchesTotal || 0}/${loyalty.punchesRequired || 10}`;
          if ((loyalty.washPunches || 0) > 0) {
            text += alignLeftRight(`  Lavados (+${loyalty.washPunches}):`, washProgress, LINE_WIDTH) + '\n';
          } else {
            text += alignLeftRight('  Lavados:', washProgress, LINE_WIDTH) + '\n';
          }
        }
        
        // Dry punches
        if ((loyalty.dryPunches || 0) > 0 || (loyalty.dryPunchesTotal || 0) > 0) {
          const dryProgress = `${loyalty.dryPunchesTotal || 0}/${loyalty.punchesRequired || 10}`;
          if ((loyalty.dryPunches || 0) > 0) {
            text += alignLeftRight(`  Secados (+${loyalty.dryPunches}):`, dryProgress, LINE_WIDTH) + '\n';
          } else {
            text += alignLeftRight('  Secados:', dryProgress, LINE_WIDTH) + '\n';
          }
        }
        
        // Free services earned this order
        if ((loyalty.freeWashesEarned || 0) > 0) {
          text += centerText(`*** GANASTE ${loyalty.freeWashesEarned} LAVADO(S) GRATIS! ***`, LINE_WIDTH) + '\n';
        }
        if ((loyalty.freeDrysEarned || 0) > 0) {
          text += centerText(`*** GANASTE ${loyalty.freeDrysEarned} SECADO(S) GRATIS! ***`, LINE_WIDTH) + '\n';
        }
        
        // Available free services
        if ((loyalty.freeWashesAvailable || 0) > 0 || (loyalty.freeDrysAvailable || 0) > 0) {
          text += '\n';
          text += centerText('Servicios gratis disponibles:', LINE_WIDTH) + '\n';
          if ((loyalty.freeWashesAvailable || 0) > 0) {
            text += alignLeftRight('  Lavados:', (loyalty.freeWashesAvailable || 0).toString(), LINE_WIDTH) + '\n';
          }
          if ((loyalty.freeDrysAvailable || 0) > 0) {
            text += alignLeftRight('  Secados:', (loyalty.freeDrysAvailable || 0).toString(), LINE_WIDTH) + '\n';
          }
        }
      }
      
      text += THIN_DIVIDER + '\n';
    }
  }
  
  // Footer
  text += '\n';
  text += centerText('¡Gracias por su preferencia!', LINE_WIDTH) + '\n';
  text += centerText('www.americanlaundry.com', LINE_WIDTH) + '\n';
  text += '\n\n\n';
  
  return text;
}

// Helper functions for text formatting
function centerText(text, width) {
  const t = String(text || '');
  if (t.length >= width) return t.substring(0, width);
  const padding = Math.floor((width - t.length) / 2);
  return ' '.repeat(padding) + t + ' '.repeat(width - padding - t.length);
}

function alignLeftRight(left, right, width) {
  const l = String(left || '');
  const r = String(right || '');
  const leftLen = l.length;
  const rightLen = r.length;
  const spaces = width - leftLen - rightLen;
  if (spaces <= 0) return l.substring(0, width - rightLen - 1) + ' ' + r;
  return l + ' '.repeat(spaces) + r;
}

/**
 * Generate ESC/POS commands for thermal printing
 */
export function generateEscPosCommands(receiptData, options = {}) {
  const { cut = true } = options;
  let commands = [];

  // Initialize printer
  commands.push(...COMMANDS.INIT);
  
  // Header - Store name first (double size), then company, then RUC
  commands.push(...COMMANDS.ALIGN_CENTER);
  
  // Store name - large and bold
  if (receiptData.storeName) {
    commands.push(...COMMANDS.SIZE_DOUBLE);
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(receiptData.storeName.toUpperCase()));
    commands.push(LF);
    commands.push(...COMMANDS.SIZE_NORMAL);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  
  // Company name - normal size
  commands.push(...textToBytes(receiptData.companyName));
  commands.push(LF);
  
  // RUC
  if (receiptData.companyRuc) {
    commands.push(...textToBytes(receiptData.companyRuc));
    commands.push(LF);
  }
  
  // Address and phone
  if (receiptData.storeAddress) {
    commands.push(...textToBytes(receiptData.storeAddress));
    commands.push(LF);
  }
  if (receiptData.storePhone) {
    commands.push(...textToBytes(`Tel: ${receiptData.storePhone}`));
    commands.push(LF);
  }
  
  // Divider
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  
  // Order number — large & centered so it's easy to read when calling the
  // customer for pickup.
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('ORDEN'));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_DOUBLE);
  commands.push(...textToBytes(String(receiptData.orderNumber)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  if (receiptData.isExpress) {
    commands.push(...textToBytes('*** EXPRESS ***'));
    commands.push(LF);
  }
  commands.push(...COMMANDS.BOLD_OFF);

  // Order details - left aligned
  commands.push(...COMMANDS.ALIGN_LEFT);
  commands.push(...textToBytes(`Fecha: ${receiptData.date}`));
  commands.push(LF);
  commands.push(...textToBytes(`Cliente: ${receiptData.customerName}`));
  commands.push(LF);
  
  if (receiptData.promisedDate) {
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(`Listo para: ${receiptData.promisedDate}`));
    commands.push(LF);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  
  // Items divider
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  
  // Items header
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(padRight('CANT', 6) + padRight('DESCRIPCION', COL_DESC) + padLeft('TOTAL', 14)));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  
  // Items — line 1: qty | name | total; line 2 (indented): unit price + discount.
  for (const item of receiptData.items) {
    const qtyStr = item.isWeight
      ? `${item.weight.toFixed(2)}kg`
      : `${item.quantity}x`;
    const totalStr = formatCurrency(item.total);

    commands.push(...textToBytes(padRight(qtyStr, COL_QTY) + padRight(item.name.substring(0, COL_DESC), COL_DESC) + padLeft(totalStr, COL_TOTAL)));
    commands.push(LF);

    // Unit price (ITBMS-incl) + any per-line discount. Skip for a plain single
    // unit with no discount, where the line total already is the unit price.
    const showDetail = item.isWeight || (item.quantity || 1) > 1 || (item.lineDiscount || 0) > 0;
    if (showDetail) {
      let detail = item.isWeight
        ? `${formatCurrency(item.unitPrice)}/kg`
        : `${formatCurrency(item.unitPrice)} c/u`;
      if ((item.lineDiscount || 0) > 0) detail += `  Desc: -${formatCurrency(item.lineDiscount)}`;
      commands.push(...textToBytes(' '.repeat(COL_QTY) + detail));
      commands.push(LF);
    }
  }
  
  // Totals divider
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  
  // Weight and bags
  if (receiptData.totalWeight > 0) {
    commands.push(...textToBytes(alignLeftRight('Peso Total:', `${receiptData.totalWeight.toFixed(2)} kg`, RECEIPT_WIDTH)));
    commands.push(LF);
  }
  if (receiptData.totalBags > 0) {
    commands.push(...textToBytes(alignLeftRight('Bolsas:', receiptData.totalBags.toString(), RECEIPT_WIDTH)));
    commands.push(LF);
  }
  
  // Subtotals — prices above are SIN ITBMS; the ITBMS is desglosado below and
  // added to reach the total (DGI fiscal representation).
  commands.push(...textToBytes(alignLeftRight('Subtotal:', formatCurrency(receiptData.subtotal), RECEIPT_WIDTH)));
  commands.push(LF);

  if (receiptData.discount > 0) {
    commands.push(...textToBytes(alignLeftRight('Descuento:', `-${formatCurrency(receiptData.discount)}`, RECEIPT_WIDTH)));
    commands.push(LF);
  }
  if (receiptData.delivery > 0) {
    commands.push(...textToBytes(alignLeftRight('Delivery:', formatCurrency(receiptData.delivery), RECEIPT_WIDTH)));
    commands.push(LF);
  }

  commands.push(...textToBytes(alignLeftRight('ITBMS:', formatCurrency(receiptData.tax), RECEIPT_WIDTH)));
  commands.push(LF);
  
  // Total - bold and larger
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(alignLeftRight('TOTAL:', formatCurrency(receiptData.total), RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  commands.push(...COMMANDS.BOLD_OFF);
  
  // Payments section
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('FORMA DE PAGO'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...COMMANDS.ALIGN_LEFT);
  
  for (const payment of receiptData.payments) {
    let paymentLine = payment.methodName;
    if (payment.reference) paymentLine += ` (${payment.reference})`;
    commands.push(...textToBytes(alignLeftRight(paymentLine, formatCurrency(payment.amount), RECEIPT_WIDTH)));
    commands.push(LF);
  }
  
  if (receiptData.change > 0) {
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(alignLeftRight('Cambio:', formatCurrency(receiptData.change), RECEIPT_WIDTH)));
    commands.push(LF);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  
  // Notes
  if (receiptData.notes) {
    commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
    commands.push(LF);
    commands.push(...textToBytes('Notas: ' + receiptData.notes.substring(0, 100)));
    commands.push(LF);
  }
  
  // Loyalty Section
  if (receiptData.loyalty) {
    const loyalty = receiptData.loyalty;
    const hasLoyaltyInfo = loyalty.pointsEarned > 0 || loyalty.pointsUsed > 0 || 
                           loyalty.washPunches > 0 || loyalty.dryPunches > 0 ||
                           loyalty.freeWashesEarned > 0 || loyalty.freeDrysEarned > 0 ||
                           loyalty.freeServicesUsed.washes > 0 || loyalty.freeServicesUsed.drys > 0;
    
    if (hasLoyaltyInfo) {
      commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
      commands.push(LF);
      commands.push(...COMMANDS.ALIGN_CENTER);
      commands.push(...COMMANDS.BOLD_ON);
      commands.push(...textToBytes('*** PROGRAMA DE LEALTAD ***'));
      commands.push(LF);
      commands.push(...COMMANDS.BOLD_OFF);
      commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
      commands.push(LF);
      commands.push(...COMMANDS.ALIGN_LEFT);
      
      // Free services used in this order
      if (loyalty.freeServicesUsed.washes > 0 || loyalty.freeServicesUsed.drys > 0) {
        commands.push(...COMMANDS.ALIGN_CENTER);
        commands.push(...textToBytes('SERVICIOS GRATIS APLICADOS'));
        commands.push(LF);
        commands.push(...COMMANDS.ALIGN_LEFT);
        if (loyalty.freeServicesUsed.washes > 0) {
          commands.push(...textToBytes(alignLeftRight('  Lavados gratis:', loyalty.freeServicesUsed.washes.toString(), RECEIPT_WIDTH)));
          commands.push(LF);
        }
        if (loyalty.freeServicesUsed.drys > 0) {
          commands.push(...textToBytes(alignLeftRight('  Secados gratis:', loyalty.freeServicesUsed.drys.toString(), RECEIPT_WIDTH)));
          commands.push(LF);
        }
        commands.push(LF);
      }
      
      // Points section
      if (loyalty.pointsEarned > 0 || loyalty.pointsUsed > 0 || loyalty.pointsBalance > 0) {
        commands.push(...COMMANDS.ALIGN_CENTER);
        commands.push(...textToBytes('PUNTOS CASHBACK'));
        commands.push(LF);
        commands.push(...COMMANDS.ALIGN_LEFT);
        if (loyalty.pointsUsed > 0) {
          commands.push(...textToBytes(alignLeftRight('  Puntos usados:', `-B/${loyalty.pointsUsed.toFixed(2)}`, RECEIPT_WIDTH)));
          commands.push(LF);
        }
        if (loyalty.pointsEarned > 0) {
          commands.push(...textToBytes(alignLeftRight('  Puntos ganados:', `+B/${loyalty.pointsEarned.toFixed(2)}`, RECEIPT_WIDTH)));
          commands.push(LF);
        }
        commands.push(...textToBytes(alignLeftRight('  Saldo actual:', `B/${loyalty.pointsBalance.toFixed(2)}`, RECEIPT_WIDTH)));
        commands.push(LF);
        commands.push(LF);
      }
      
      // Punch card section
      if (loyalty.washPunches > 0 || loyalty.dryPunches > 0 || 
          loyalty.freeWashesEarned > 0 || loyalty.freeDrysEarned > 0) {
        commands.push(...COMMANDS.ALIGN_CENTER);
        commands.push(...textToBytes('TARJETA DE SELLOS'));
        commands.push(LF);
        commands.push(...COMMANDS.ALIGN_LEFT);
        
        // Wash punches
        if (loyalty.washPunches > 0 || loyalty.washPunchesTotal > 0) {
          const washProgress = `${loyalty.washPunchesTotal}/${loyalty.punchesRequired}`;
          if (loyalty.washPunches > 0) {
            commands.push(...textToBytes(alignLeftRight(`  Lavados (+${loyalty.washPunches}):`, washProgress, RECEIPT_WIDTH)));
          } else {
            commands.push(...textToBytes(alignLeftRight('  Lavados:', washProgress, RECEIPT_WIDTH)));
          }
          commands.push(LF);
        }
        
        // Dry punches
        if (loyalty.dryPunches > 0 || loyalty.dryPunchesTotal > 0) {
          const dryProgress = `${loyalty.dryPunchesTotal}/${loyalty.punchesRequired}`;
          if (loyalty.dryPunches > 0) {
            commands.push(...textToBytes(alignLeftRight(`  Secados (+${loyalty.dryPunches}):`, dryProgress, RECEIPT_WIDTH)));
          } else {
            commands.push(...textToBytes(alignLeftRight('  Secados:', dryProgress, RECEIPT_WIDTH)));
          }
          commands.push(LF);
        }
        
        // Free services earned this order
        if (loyalty.freeWashesEarned > 0) {
          commands.push(LF);
          commands.push(...COMMANDS.ALIGN_CENTER);
          commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
          commands.push(...COMMANDS.BOLD_ON);
          commands.push(...textToBytes(`GANASTE ${loyalty.freeWashesEarned} LAVADO(S) GRATIS!`));
          commands.push(LF);
          commands.push(...COMMANDS.SIZE_NORMAL);
          commands.push(...COMMANDS.BOLD_OFF);
          commands.push(...COMMANDS.ALIGN_LEFT);
        }
        if (loyalty.freeDrysEarned > 0) {
          commands.push(LF);
          commands.push(...COMMANDS.ALIGN_CENTER);
          commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
          commands.push(...COMMANDS.BOLD_ON);
          commands.push(...textToBytes(`GANASTE ${loyalty.freeDrysEarned} SECADO(S) GRATIS!`));
          commands.push(LF);
          commands.push(...COMMANDS.SIZE_NORMAL);
          commands.push(...COMMANDS.BOLD_OFF);
          commands.push(...COMMANDS.ALIGN_LEFT);
        }
        
        // Available free services
        if (loyalty.freeWashesAvailable > 0 || loyalty.freeDrysAvailable > 0) {
          commands.push(LF);
          commands.push(...COMMANDS.ALIGN_CENTER);
          commands.push(...textToBytes('Servicios gratis disponibles:'));
          commands.push(LF);
          commands.push(...COMMANDS.ALIGN_LEFT);
          if (loyalty.freeWashesAvailable > 0) {
            commands.push(...textToBytes(alignLeftRight('  Lavados:', loyalty.freeWashesAvailable.toString(), RECEIPT_WIDTH)));
            commands.push(LF);
          }
          if (loyalty.freeDrysAvailable > 0) {
            commands.push(...textToBytes(alignLeftRight('  Secados:', loyalty.freeDrysAvailable.toString(), RECEIPT_WIDTH)));
            commands.push(LF);
          }
        }
      }
      
      commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
      commands.push(LF);
    }
  }
  
  // Footer
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('¡Gracias por su preferencia!'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('www.americanlaundry.com'));
  commands.push(LF);

  // Feed and cut (skipped when a fiscal block will be appended before the cut).
  if (cut) {
    commands.push(...COMMANDS.FEED_LINES(4));
    commands.push(...COMMANDS.PARTIAL_CUT);
  }

  return commands;
}

/**
 * Print receipt to Epson TM-T20III
 */
export async function printReceipt(receiptData, openDrawer = false) {
  try {
    // Connect if not connected
    if (!isPrinterConnected()) {
      await connectPrinter();
    }
    
    // Generate ESC/POS commands
    const commands = generateEscPosCommands(receiptData);
    
    // Add cash drawer command if requested
    if (openDrawer) {
      commands.push(...COMMANDS.OPEN_DRAWER);
    }
    
    // Send to printer
    await sendToPrinter(commands);
    
    console.log('Receipt printed successfully');
    return true;
  } catch (error) {
    console.error('Error printing receipt:', error);
    throw error;
  }
}

/**
 * Open cash drawer
 */
export async function openCashDrawer() {
  try {
    if (!isPrinterConnected()) {
      await connectPrinter();
    }
    await sendToPrinter(COMMANDS.OPEN_DRAWER);
    return true;
  } catch (error) {
    console.error('Error opening cash drawer:', error);
    throw error;
  }
}

/**
 * Save receipt to Supabase Storage
 */
export async function saveReceiptToStorage(receiptText, orderNumber, storeId) {
  try {
    // Import supabase client dynamically to avoid circular dependencies
    const { supabase, isConfigured } = await import('../lib/supabase.js');
    
    if (!isConfigured) {
      console.warn('Supabase not configured for receipt storage');
      return null;
    }
    
    if (!storeId) {
      console.warn('No storeId provided for receipt storage, using "default"');
      storeId = 'default';
    }
    
    // Generate filename with date and order number
    const date = new Date();
    const dateStr = date.toISOString().split('T')[0]; // YYYY-MM-DD
    const timestamp = date.getTime();
    const safeOrderNumber = String(orderNumber).replace(/[^a-zA-Z0-9]/g, '');
    const filename = `${storeId}/${dateStr}/${safeOrderNumber}-${timestamp}.txt`;
    
    console.log('Saving receipt to storage:', filename);
    
    // Convert text to blob
    const blob = new Blob([receiptText], { type: 'text/plain' });
    
    // Upload to Supabase Storage using the client
    const { data, error } = await supabase.storage
      .from('receipts')
      .upload(filename, blob, {
        contentType: 'text/plain',
        upsert: true
      });
    
    if (error) {
      console.error('Receipt storage error:', error.message);
      
      // Common errors
      if (error.message.includes('not found') || error.message.includes('does not exist')) {
        console.error('The "receipts" bucket may not exist. Create it in Supabase Dashboard > Storage.');
      }
      if (error.message.includes('permission') || error.message.includes('policy')) {
        console.error('Permission denied. Run supabase-receipts-storage.sql to set up RLS policies.');
      }
      
      return null;
    }
    
    console.log('Receipt saved successfully:', data?.path || filename);
    return data?.path || filename;
  } catch (error) {
    console.error('Error saving receipt to storage:', error);
    return null;
  }
}

/**
 * Print test page
 */
export async function printTestPage() {
  const testData = {
    storeName: 'Costa del Este',
    companyName: 'American Laundry',
    companyRuc: 'RUC: 155737034-2-2023',
    storeAddress: 'Costa del Este, Panamá',
    storePhone: '+507 6000-0000',
    orderNumber: 'TEST-001',
    date: formatDate(new Date()),
    customerName: 'Prueba de Impresión',
    isExpress: true,
    promisedDate: formatDate(new Date(Date.now() + 86400000)),
    items: [
      { name: 'Lava y Dobla (por kg)', quantity: 1, weight: 4.5, unitPrice: 2.50, total: 11.25, isWeight: true },
      { name: 'Cortinas', quantity: 2, weight: 0, unitPrice: 10.00, total: 20.00, isWeight: false },
    ],
    subtotal: 31.25,
    discount: 0,
    delivery: 0,
    tax: 2.19,
    total: 33.44,
    payments: [
      { method: 'cash', methodName: 'Efectivo', amount: 40.00, reference: null },
    ],
    totalPaid: 40.00,
    change: 6.56,
    notes: '',
    totalWeight: 4.5,
    totalBags: 2,
    // Test loyalty info
    loyalty: {
      pointsEarned: 1.56,
      pointsBalance: 12.50,
      pointsUsed: 0,
      washPunches: 2,
      dryPunches: 1,
      washPunchesTotal: 7,
      dryPunchesTotal: 4,
      punchesRequired: 10,
      freeWashesEarned: 0,
      freeDrysEarned: 0,
      freeWashesAvailable: 1,
      freeDrysAvailable: 0,
      freeServicesUsed: { washes: 0, drys: 0 },
    },
  };
  
  return await printReceipt(testData, false);
}

// ============================================================
// Fiscal documents (factura electrónica / nota de crédito) + QR
// ============================================================

/**
 * Native Epson QR code (GS ( k, model 2). `text` is the DGI qr_content URL.
 * Module size 6, error-correction level M — scans reliably on 80mm paper.
 */
export function generateQrCommands(text) {
  const data = textToBytes(String(text || ''));
  const storeLen = data.length + 3;
  const pL = storeLen & 0xff;
  const pH = (storeLen >> 8) & 0xff;
  return [
    // Select model 2
    GS, 0x28, 0x6b, 0x04, 0x00, 0x31, 0x41, 0x32, 0x00,
    // Module size = 6
    GS, 0x28, 0x6b, 0x03, 0x00, 0x31, 0x43, 0x06,
    // Error correction level M (0x31)
    GS, 0x28, 0x6b, 0x03, 0x00, 0x31, 0x45, 0x31,
    // Store the data
    GS, 0x28, 0x6b, pL, pH, 0x31, 0x50, 0x30, ...data,
    // Print the symbol
    GS, 0x28, 0x6b, 0x03, 0x00, 0x31, 0x51, 0x30,
  ];
}

/** Normalizes an electronic_invoices row (snake_case) or a camelCase result. */
function normalizeInvoice(invoice = {}) {
  return {
    docType: invoice.doc_type || invoice.docType || '01',
    cufe: invoice.cufe || '',
    protocolo: invoice.protocolo_autorizacion || invoice.protocoloAutorizacion || '',
    fechaAutorizacion: invoice.fecha_autorizacion || invoice.fechaAutorizacion || '',
    qrContent: invoice.qr_content || invoice.qrContent || '',
    environment: invoice.environment || 'prod',
    referencedCufe: invoice.referenced_cufe || invoice.referencedCufe || '',
  };
}

/**
 * Builds the 80mm "representación impresa" of an authorized electronic document:
 * the normal receipt body followed by the fiscal block (title, CUFE, protocolo,
 * native QR). doc_type '06' renders as a nota de crédito. No print dialog — these
 * bytes go straight to the printer via the active transport.
 */
export function generateFiscalReceipt(receiptData, invoice) {
  const inv = normalizeInvoice(invoice);
  const isCredit = inv.docType === '06';

  // Receipt body without the final cut, so we can append the fiscal block.
  const commands = generateEscPosCommands(receiptData, { cut: false });

  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);

  if (inv.environment === 'test') {
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes('AMBIENTE DE PRUEBAS - SIN VALOR FISCAL'));
    commands.push(LF);
    commands.push(...COMMANDS.BOLD_OFF);
  }

  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(isCredit ? 'NOTA DE CREDITO ELECTRONICA' : 'FACTURA ELECTRONICA'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('Representacion Impresa del CAFE'));
  commands.push(LF);

  // Identifiers (left aligned; the CUFE wraps on the printer).
  commands.push(...COMMANDS.ALIGN_LEFT);
  if (inv.cufe) {
    commands.push(...textToBytes('CUFE:'));
    commands.push(LF);
    commands.push(...textToBytes(inv.cufe));
    commands.push(LF);
  }
  if (inv.protocolo) {
    commands.push(...textToBytes(`Protocolo: ${inv.protocolo}`));
    commands.push(LF);
  }
  if (inv.fechaAutorizacion) {
    commands.push(...textToBytes(`Autorizado: ${inv.fechaAutorizacion}`));
    commands.push(LF);
  }
  if (isCredit && inv.referencedCufe) {
    commands.push(...textToBytes('Doc. referenciado (CUFE):'));
    commands.push(LF);
    commands.push(...textToBytes(inv.referencedCufe));
    commands.push(LF);
  }

  // QR (DGI verification URL).
  if (inv.qrContent) {
    commands.push(LF);
    commands.push(...COMMANDS.ALIGN_CENTER);
    commands.push(...generateQrCommands(inv.qrContent));
    commands.push(LF);
    commands.push(...textToBytes('Consulte su factura en:'));
    commands.push(LF);
    commands.push(...textToBytes('dgi-fep.mef.gob.pa'));
    commands.push(LF);
    commands.push(...COMMANDS.ALIGN_LEFT);
  }

  commands.push(...COMMANDS.FEED_LINES(4));
  commands.push(...COMMANDS.PARTIAL_CUT);
  return commands;
}

/**
 * Non-fiscal info ticket for a gift-card sale/top-up. Gift cards are prepayment,
 * not a sale, so they never go to E-Factura — this ticket just tells the customer
 * the code, amount and balance, and is clearly marked NOT a tax document.
 */
export function generateGiftCardTicket(card, product, store, company) {
  const commands = [];
  commands.push(...COMMANDS.INIT);
  commands.push(...COMMANDS.ALIGN_CENTER);

  if (store?.name) {
    commands.push(...COMMANDS.SIZE_DOUBLE);
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(String(store.name).toUpperCase()));
    commands.push(LF);
    commands.push(...COMMANDS.SIZE_NORMAL);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  commands.push(...textToBytes(company?.name || 'American Laundry'));
  commands.push(LF);
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);

  commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('TARJETA DE REGALO'));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  commands.push(...COMMANDS.BOLD_OFF);

  commands.push(...COMMANDS.ALIGN_LEFT);
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(`Codigo: ${card?.code || ''}`));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes(alignLeftRight('Monto cargado:', formatCurrency(card?.amountLoaded ?? product?.price ?? 0), RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...textToBytes(alignLeftRight('Saldo actual:', formatCurrency(card?.current_balance ?? 0), RECEIPT_WIDTH)));
  commands.push(LF);
  if (card?.expires_at) {
    commands.push(...textToBytes(alignLeftRight('Vence:', formatDate(card.expires_at), RECEIPT_WIDTH)));
    commands.push(LF);
  }
  commands.push(...textToBytes(alignLeftRight('Fecha:', formatDate(new Date()), RECEIPT_WIDTH)));
  commands.push(LF);

  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('*** NO ES COMPROBANTE FISCAL ***'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('Documento informativo'));
  commands.push(LF);
  commands.push(...textToBytes('No valido como factura'));
  commands.push(LF);
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(LF);
  commands.push(...textToBytes('Gracias por su compra'));
  commands.push(LF);

  commands.push(...COMMANDS.FEED_LINES(4));
  commands.push(...COMMANDS.PARTIAL_CUT);
  return commands;
}

/**
 * Prints the fiscal representación impresa (factura or nota de crédito).
 * `openDrawer` opens the cash drawer (cash sales only).
 */
export async function printFiscalReceipt(receiptData, invoice, openDrawer = false) {
  if (!isPrinterConnected()) {
    await connectPrinter();
  }
  const commands = generateFiscalReceipt(receiptData, invoice);
  if (openDrawer) commands.push(...COMMANDS.OPEN_DRAWER);
  await sendToPrinter(commands);
  return true;
}

/** Prints a nota de crédito ticket (alias of printFiscalReceipt with doc_type 06). */
export async function printCreditNote(receiptData, invoice) {
  return printFiscalReceipt(receiptData, { ...invoice, doc_type: invoice?.doc_type || '06' }, false);
}

/** Prints the non-fiscal gift-card info ticket. */
export async function printGiftCardTicket(card, product, store, company) {
  if (!isPrinterConnected()) {
    await connectPrinter();
  }
  const commands = generateGiftCardTicket(card, product, store, company);
  await sendToPrinter(commands);
  return true;
}

/**
 * Non-fiscal refund slip, printed when a refund has no electronic nota de
 * crédito (the original order was never factured). Clearly marked NOT a fiscal
 * document. `data` = { refundNumber, originalNumber, items, total, reason, date }.
 */
export function generateRefundTicket(data, store, company) {
  const commands = [];
  commands.push(...COMMANDS.INIT);
  commands.push(...COMMANDS.ALIGN_CENTER);

  if (store?.name) {
    commands.push(...COMMANDS.SIZE_DOUBLE);
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(String(store.name).toUpperCase()));
    commands.push(LF);
    commands.push(...COMMANDS.SIZE_NORMAL);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  commands.push(...textToBytes(company?.name || 'American Laundry'));
  commands.push(LF);
  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);

  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('COMPROBANTE DE REEMBOLSO'));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_DOUBLE);
  commands.push(...textToBytes(String(data.refundNumber || '')));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  commands.push(...COMMANDS.BOLD_OFF);

  commands.push(...COMMANDS.ALIGN_LEFT);
  commands.push(...textToBytes(`Fecha: ${data.date || formatDate(new Date())}`));
  commands.push(LF);
  if (data.originalNumber) {
    commands.push(...textToBytes(`Reembolso de Orden: ${data.originalNumber}`));
    commands.push(LF);
  }
  if (data.reason) {
    commands.push(...textToBytes(`Motivo: ${data.reason}`));
    commands.push(LF);
  }

  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  for (const item of data.items || []) {
    const qtyStr = item.isWeight ? `${(item.weight || 0).toFixed(2)}kg` : `${item.quantity || 1}x`;
    const name = String(item.name || 'Producto').substring(0, COL_DESC);
    commands.push(...textToBytes(padRight(qtyStr, COL_QTY) + padRight(name, COL_DESC) + padLeft(formatCurrency(Math.abs(item.total || 0)), COL_TOTAL)));
    commands.push(LF);
  }
  commands.push(...textToBytes('-'.repeat(RECEIPT_WIDTH)));
  commands.push(LF);

  commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(alignLeftRight('REEMBOLSADO:', formatCurrency(Math.abs(data.total || 0)), RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  commands.push(...COMMANDS.BOLD_OFF);

  commands.push(...textToBytes('='.repeat(RECEIPT_WIDTH)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('*** NO ES COMPROBANTE FISCAL ***'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('Documento informativo'));
  commands.push(LF);

  commands.push(...COMMANDS.FEED_LINES(4));
  commands.push(...COMMANDS.PARTIAL_CUT);
  return commands;
}

/** Prints the non-fiscal refund slip. */
export async function printRefundTicket(data, store, company) {
  if (!isPrinterConnected()) {
    await connectPrinter();
  }
  const commands = generateRefundTicket(data, store, company);
  await sendToPrinter(commands);
  return true;
}

export default {
  connectPrinter,
  disconnectPrinter,
  isPrinterConnected,
  printReceipt,
  printFiscalReceipt,
  printCreditNote,
  printGiftCardTicket,
  printRefundTicket,
  printTestPage,
  openCashDrawer,
  generateReceiptData,
  generateReceiptText,
  generateFiscalReceipt,
  generateGiftCardTicket,
  generateQrCommands,
  saveReceiptToStorage,
};
