/**
 * Receipt Printing Service
 * Uses QZ Tray for direct printing to Epson TM-T20III (80mm thermal printer)
 * Saves customer copy to Supabase Storage
 */

import { supabase } from '../lib/supabase';

// QZ Tray configuration
const PRINTER_NAME = 'EPSON TM-T20III Receipt'; // Adjust to match your printer name in Windows
const PAPER_WIDTH = 48; // Characters per line for 80mm paper

// ============================================
// QZ Tray Connection Management
// ============================================

let qzConnection = null;

/**
 * Initialize QZ Tray connection
 * QZ Tray must be installed on the PC: https://qz.io/download/
 */
export async function initQZTray() {
  if (typeof qz === 'undefined') {
    console.error('QZ Tray library not loaded. Add the script to your HTML.');
    return false;
  }

  try {
    if (!qz.websocket.isActive()) {
      await qz.websocket.connect();
      console.log('QZ Tray connected successfully');
    }
    qzConnection = true;
    return true;
  } catch (error) {
    console.error('Failed to connect to QZ Tray:', error);
    console.log('Make sure QZ Tray is running on this computer.');
    return false;
  }
}

/**
 * Disconnect from QZ Tray
 */
export async function disconnectQZTray() {
  if (typeof qz !== 'undefined' && qz.websocket.isActive()) {
    await qz.websocket.disconnect();
    qzConnection = null;
  }
}

/**
 * Get list of available printers
 */
export async function getAvailablePrinters() {
  if (!await initQZTray()) return [];
  
  try {
    const printers = await qz.printers.find();
    return printers;
  } catch (error) {
    console.error('Failed to get printers:', error);
    return [];
  }
}

// ============================================
// Receipt Formatting
// ============================================

/**
 * Center text for receipt
 */
function centerText(text, width = PAPER_WIDTH) {
  const padding = Math.max(0, Math.floor((width - text.length) / 2));
  return ' '.repeat(padding) + text;
}

/**
 * Create a separator line
 */
function separatorLine(char = '-', width = PAPER_WIDTH) {
  return char.repeat(width);
}

/**
 * Format currency
 */
function formatCurrency(amount) {
  return `B/${amount.toFixed(2)}`;
}

/**
 * Format line item with price aligned right
 */
function formatLineItem(description, price, width = PAPER_WIDTH) {
  const priceStr = formatCurrency(price);
  const maxDescLength = width - priceStr.length - 1;
  const desc = description.length > maxDescLength 
    ? description.substring(0, maxDescLength) 
    : description;
  const spaces = width - desc.length - priceStr.length;
  return desc + ' '.repeat(spaces) + priceStr;
}

/**
 * Format a label-value pair
 */
function formatLabelValue(label, value, width = PAPER_WIDTH) {
  const spaces = width - label.length - value.length;
  return label + ' '.repeat(Math.max(1, spaces)) + value;
}

/**
 * Word wrap text to fit paper width
 */
function wordWrap(text, width = PAPER_WIDTH) {
  const words = text.split(' ');
  const lines = [];
  let currentLine = '';

  words.forEach(word => {
    if ((currentLine + ' ' + word).trim().length <= width) {
      currentLine = (currentLine + ' ' + word).trim();
    } else {
      if (currentLine) lines.push(currentLine);
      currentLine = word;
    }
  });
  if (currentLine) lines.push(currentLine);
  return lines;
}

/**
 * Generate receipt content
 * @param {Object} orderData - Order information
 * @param {string} copyType - 'customer' or 'store'
 * @returns {string} Formatted receipt text
 */
export function generateReceiptContent(orderData, copyType = 'customer') {
  const {
    orderNumber,
    customer,
    items,
    subtotal,
    taxAmount,
    discountAmount,
    discountReason,
    deliveryCharge,
    total,
    paymentMethod,
    cashTendered,
    changeGiven,
    isExpress,
    promisedDate,
    notes,
    companyInfo,
    createdAt,
  } = orderData;

  const lines = [];
  const now = new Date(createdAt || Date.now());
  const dateStr = now.toLocaleDateString('es-PA', { 
    year: 'numeric', 
    month: '2-digit', 
    day: '2-digit' 
  });
  const timeStr = now.toLocaleTimeString('es-PA', { 
    hour: '2-digit', 
    minute: '2-digit' 
  });

  // Header
  lines.push('');
  lines.push(centerText(companyInfo?.name || 'WASH & FOLD'));
  if (companyInfo?.address) {
    wordWrap(companyInfo.address).forEach(line => lines.push(centerText(line)));
  }
  if (companyInfo?.phone) {
    lines.push(centerText(`Tel: ${companyInfo.phone}`));
  }
  if (companyInfo?.ruc) {
    lines.push(centerText(`RUC: ${companyInfo.ruc}-${companyInfo.dv || ''}`));
  }
  lines.push('');
  lines.push(separatorLine('='));
  
  // Copy type indicator
  lines.push(centerText(copyType === 'customer' ? '*** COPIA CLIENTE ***' : '*** COPIA TIENDA ***'));
  lines.push(separatorLine('='));
  lines.push('');

  // Order info
  lines.push(formatLabelValue('Orden:', orderNumber));
  lines.push(formatLabelValue('Fecha:', `${dateStr} ${timeStr}`));
  lines.push('');
  
  // Customer info
  lines.push('CLIENTE:');
  if (customer && customer.first_name) {
    lines.push(`  ${customer.first_name} ${customer.last_name}`);
    if (customer.phone) {
      lines.push(`  Tel: ${customer.phone_country_code || ''} ${customer.phone}`);
    }
    if (copyType === 'store' && customer.address_street) {
      lines.push(`  ${customer.address_street}`);
    }
  } else {
    lines.push('  Walk-in');
  }
  lines.push('');

  // Express indicator
  if (isExpress) {
    lines.push(centerText('*** SERVICIO EXPRESS ***'));
    lines.push('');
  }

  // Promised date
  if (promisedDate) {
    const promised = new Date(promisedDate);
    const promisedStr = promised.toLocaleDateString('es-PA', {
      weekday: 'short',
      day: 'numeric',
      month: 'short'
    });
    lines.push(formatLabelValue('Fecha Prometida:', promisedStr));
    lines.push('');
  }

  lines.push(separatorLine('-'));
  lines.push('DETALLE:');
  lines.push(separatorLine('-'));

  // Line items
  items.forEach(item => {
    const productName = item.product?.name || item.name || 'Producto';
    
    if (item.totalWeight) {
      // Weight-based item
      lines.push(productName);
      lines.push(formatLineItem(
        `  ${item.totalWeight.toFixed(2)}kg x ${formatCurrency(item.unitPrice)}/kg`,
        item.lineTotal
      ));
      if (item.weightEntries && item.weightEntries.length > 1) {
        item.weightEntries.forEach((entry, i) => {
          lines.push(`    Bolsa ${i + 1}: ${entry.weight}kg`);
        });
      }
    } else {
      // Quantity-based item
      if (item.quantity > 1) {
        lines.push(productName);
        lines.push(formatLineItem(
          `  ${item.quantity} x ${formatCurrency(item.unitPrice)}`,
          item.lineTotal
        ));
      } else {
        lines.push(formatLineItem(productName, item.lineTotal));
      }
    }
  });

  lines.push(separatorLine('-'));

  // Totals
  lines.push(formatLabelValue('Subtotal:', formatCurrency(subtotal)));
  
  if (discountAmount > 0) {
    lines.push(formatLabelValue('Descuento:', `-${formatCurrency(discountAmount)}`));
    if (discountReason && copyType === 'store') {
      lines.push(`  (${discountReason})`);
    }
  }
  
  if (deliveryCharge > 0) {
    lines.push(formatLabelValue('Delivery:', formatCurrency(deliveryCharge)));
  }
  
  lines.push(formatLabelValue('ITBMS (7%):', formatCurrency(taxAmount)));
  lines.push(separatorLine('-'));
  lines.push(formatLabelValue('TOTAL:', formatCurrency(total)));
  lines.push(separatorLine('='));

  // Payment info
  lines.push('');
  const paymentMethodNames = {
    cash: 'Efectivo',
    card: 'Tarjeta',
    yappy: 'Yappy',
    ach: 'ACH',
    check: 'Cheque',
    invoice: 'Factura a Crédito',
    pickup: 'Pago en Recogida',
    gift_card: 'Tarjeta Regalo',
  };
  lines.push(formatLabelValue('Método de Pago:', paymentMethodNames[paymentMethod] || paymentMethod));
  
  if (paymentMethod === 'cash' && cashTendered) {
    lines.push(formatLabelValue('Efectivo:', formatCurrency(cashTendered)));
    lines.push(formatLabelValue('Cambio:', formatCurrency(changeGiven || 0)));
  }

  // Notes (store copy only)
  if (copyType === 'store' && notes) {
    lines.push('');
    lines.push(separatorLine('-'));
    lines.push('NOTAS:');
    wordWrap(notes).forEach(line => lines.push(line));
  }

  // Footer
  lines.push('');
  lines.push(separatorLine('-'));
  lines.push('');
  
  if (copyType === 'customer') {
    lines.push(centerText('¡Gracias por su preferencia!'));
    lines.push('');
    lines.push(centerText('Conserve este recibo para'));
    lines.push(centerText('retirar su pedido.'));
  } else {
    lines.push(centerText('COPIA PARA ARCHIVO'));
  }
  
  lines.push('');
  lines.push('');
  lines.push(''); // Extra space before cut

  return lines.join('\n');
}

// ============================================
// Printing Functions
// ============================================

/**
 * Print receipt using QZ Tray
 * @param {string} content - Receipt text content
 * @param {string} printerName - Printer name (optional, uses default)
 */
export async function printReceipt(content, printerName = PRINTER_NAME) {
  if (!await initQZTray()) {
    throw new Error('QZ Tray no está disponible. Asegúrese de que esté instalado y ejecutándose.');
  }

  try {
    // Find the printer
    const printer = await qz.printers.find(printerName);
    
    if (!printer) {
      // Try to find any Epson printer
      const allPrinters = await qz.printers.find();
      const epsonPrinter = allPrinters.find(p => 
        p.toLowerCase().includes('epson') || 
        p.toLowerCase().includes('tm-t20')
      );
      
      if (!epsonPrinter) {
        throw new Error(`Impresora "${printerName}" no encontrada. Impresoras disponibles: ${allPrinters.join(', ')}`);
      }
      printerName = epsonPrinter;
    }

    // Configure print job
    const config = qz.configs.create(printerName, {
      encoding: 'UTF-8',
      altPrinting: false,
    });

    // ESC/POS commands for Epson TM-T20III
    const escposData = [
      '\x1B\x40',          // Initialize printer
      '\x1B\x61\x00',      // Left align
      '\x1B\x4D\x00',      // Font A
      content,
      '\x1B\x64\x05',      // Feed 5 lines
      '\x1D\x56\x00',      // Full cut
    ];

    await qz.print(config, [{
      type: 'raw',
      format: 'plain',
      data: escposData.join('')
    }]);

    console.log('Receipt printed successfully');
    return true;
  } catch (error) {
    console.error('Print error:', error);
    throw error;
  }
}

/**
 * Print both customer and store copies
 */
export async function printOrderReceipts(orderData) {
  const customerReceipt = generateReceiptContent(orderData, 'customer');
  const storeReceipt = generateReceiptContent(orderData, 'store');

  // Print customer copy first
  await printReceipt(customerReceipt);
  
  // Small delay between prints
  await new Promise(resolve => setTimeout(resolve, 500));
  
  // Print store copy
  await printReceipt(storeReceipt);

  return { customerReceipt, storeReceipt };
}

// ============================================
// Supabase Storage Functions
// ============================================

/**
 * Save receipt to Supabase Storage
 * @param {string} content - Receipt content
 * @param {string} orderNumber - Order number for filename
 * @param {Date} orderDate - Order date for filename
 * @returns {string} Public URL of saved file
 */
export async function saveReceiptToStorage(content, orderNumber, orderDate = new Date()) {
  const dateStr = orderDate.toISOString().split('T')[0]; // YYYY-MM-DD
  const orderNum = orderNumber.replace('#', '').trim();
  const fileName = `${dateStr}_order-${orderNum}.txt`;
  const filePath = `receipts/${dateStr.substring(0, 7)}/${fileName}`; // Organize by month

  try {
    // Convert content to blob
    const blob = new Blob([content], { type: 'text/plain;charset=utf-8' });

    // Upload to Supabase Storage
    const { data, error } = await supabase.storage
      .from('receipts')
      .upload(filePath, blob, {
        contentType: 'text/plain',
        upsert: true // Overwrite if exists
      });

    if (error) {
      throw error;
    }

    // Get public URL
    const { data: urlData } = supabase.storage
      .from('receipts')
      .getPublicUrl(filePath);

    console.log('Receipt saved to storage:', filePath);
    return urlData.publicUrl;
  } catch (error) {
    console.error('Failed to save receipt to storage:', error);
    throw error;
  }
}

/**
 * Complete order receipt handling:
 * 1. Print customer copy
 * 2. Print store copy
 * 3. Save customer copy to Supabase Storage
 */
export async function processOrderReceipts(orderData) {
  const results = {
    printed: false,
    saved: false,
    storageUrl: null,
    error: null,
  };

  try {
    // Generate receipts
    const customerReceipt = generateReceiptContent(orderData, 'customer');
    const storeReceipt = generateReceiptContent(orderData, 'store');

    // Try to print
    try {
      await printReceipt(customerReceipt);
      await new Promise(resolve => setTimeout(resolve, 500));
      await printReceipt(storeReceipt);
      results.printed = true;
    } catch (printError) {
      console.error('Printing failed:', printError);
      results.error = printError.message;
    }

    // Save customer receipt to storage
    try {
      const url = await saveReceiptToStorage(
        customerReceipt,
        orderData.orderNumber,
        new Date(orderData.createdAt || Date.now())
      );
      results.saved = true;
      results.storageUrl = url;
    } catch (saveError) {
      console.error('Storage save failed:', saveError);
      if (!results.error) {
        results.error = saveError.message;
      }
    }

    return results;
  } catch (error) {
    results.error = error.message;
    return results;
  }
}

// ============================================
// Fallback Browser Print (for testing)
// ============================================

/**
 * Fallback: Open print dialog with receipt preview
 * Use this when QZ Tray is not available
 */
export function browserPrintReceipt(content) {
  const printWindow = window.open('', '_blank');
  printWindow.document.write(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Recibo</title>
      <style>
        body {
          font-family: 'Courier New', monospace;
          font-size: 12px;
          width: 80mm;
          margin: 0 auto;
          padding: 10px;
          white-space: pre-wrap;
          word-wrap: break-word;
        }
        @media print {
          body { margin: 0; padding: 5mm; }
          @page { size: 80mm auto; margin: 0; }
        }
      </style>
    </head>
    <body>${content}</body>
    </html>
  `);
  printWindow.document.close();
  printWindow.focus();
  printWindow.print();
}

export default {
  initQZTray,
  disconnectQZTray,
  getAvailablePrinters,
  generateReceiptContent,
  printReceipt,
  printOrderReceipts,
  saveReceiptToStorage,
  processOrderReceipts,
  browserPrintReceipt,
};
