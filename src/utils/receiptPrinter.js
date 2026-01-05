/**
 * Receipt Printer Utility for Epson TM-T20III
 * Uses WebUSB for direct printing without system dialog
 * Generates ESC/POS commands for thermal printing
 */

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

// Printer connection state
let printerDevice = null;
let printerInterface = null;
let printerEndpoint = null;

/**
 * Request and connect to the printer via WebUSB
 */
export async function connectPrinter() {
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
 * Check if printer is connected
 */
export function isPrinterConnected() {
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
 * Send raw data to printer
 */
async function sendToPrinter(data) {
  if (!printerDevice || !printerDevice.opened || !printerEndpoint) {
    throw new Error('Impresora no conectada');
  }
  
  const uint8Data = new Uint8Array(data);
  await printerDevice.transferOut(printerEndpoint.endpointNumber, uint8Data);
}

/**
 * Convert string to bytes (with Spanish character support)
 */
function textToBytes(text) {
  // Use Code Page 858 for Spanish characters
  const encoder = new TextEncoder();
  return Array.from(encoder.encode(text));
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
  return str.substring(0, width).padEnd(width);
}

function padLeft(str, width) {
  return str.substring(0, width).padStart(width);
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
    
    // Items
    items: items.map(item => ({
      name: item.product_name || item.name,
      quantity: item.quantity || 1,
      weight: item.total_weight || 0,
      unitPrice: item.unit_price || item.price,
      total: item.line_total || (item.quantity * item.price),
      isWeight: item.total_weight > 0,
    })),
    
    // Totals
    subtotal: order.subtotal || 0,
    discount: order.discount_amount || 0,
    delivery: order.delivery_charge || 0,
    tax: order.tax_amount || 0,
    total: order.total || 0,
    
    // Payments
    payments: payments.map(p => ({
      method: p.method,
      methodName: getPaymentMethodName(p.method),
      amount: p.amount,
      reference: p.reference,
    })),
    totalPaid: payments.reduce((sum, p) => sum + p.amount, 0),
    change: Math.max(0, payments.reduce((sum, p) => sum + p.amount, 0) - (order.total || 0)),
    
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
  const LINE_WIDTH = 42; // Characters per line for 80mm paper
  const DIVIDER = '='.repeat(LINE_WIDTH);
  const THIN_DIVIDER = '-'.repeat(LINE_WIDTH);
  
  let text = '';
  
  // Header - Store name first, then company, then RUC
  if (receiptData.storeName) {
    text += centerText(receiptData.storeName.toUpperCase(), LINE_WIDTH) + '\n';
  }
  text += centerText(receiptData.companyName, LINE_WIDTH) + '\n';
  if (receiptData.companyRuc) {
    text += centerText(receiptData.companyRuc, LINE_WIDTH) + '\n';
  }
  if (receiptData.storeAddress) {
    text += centerText(receiptData.storeAddress, LINE_WIDTH) + '\n';
  }
  if (receiptData.storePhone) {
    text += centerText(`Tel: ${receiptData.storePhone}`, LINE_WIDTH) + '\n';
  }
  
  text += DIVIDER + '\n';
  
  // Order info
  text += `Orden: ${receiptData.orderNumber}`;
  if (receiptData.isExpress) text += ' [EXPRESS]';
  text += '\n';
  text += `Fecha: ${receiptData.date}\n`;
  text += `Cliente: ${receiptData.customerName}\n`;
  if (receiptData.promisedDate) {
    text += `Listo para: ${receiptData.promisedDate}\n`;
  }
  
  text += THIN_DIVIDER + '\n';
  
  // Items header
  text += padRight('CANT', 6) + padRight('DESCRIPCION', 22) + padLeft('TOTAL', 14) + '\n';
  text += THIN_DIVIDER + '\n';
  
  // Items
  for (const item of receiptData.items) {
    const qtyStr = item.isWeight 
      ? `${item.weight.toFixed(2)}kg` 
      : `${item.quantity}x`;
    const totalStr = formatCurrency(item.total);
    
    text += padRight(qtyStr, 6) + padRight(item.name, 22) + padLeft(totalStr, 14) + '\n';
  }
  
  text += THIN_DIVIDER + '\n';
  
  // Totals
  if (receiptData.totalWeight > 0) {
    text += alignLeftRight('Peso Total:', `${receiptData.totalWeight.toFixed(2)} kg`, LINE_WIDTH) + '\n';
  }
  if (receiptData.totalBags > 0) {
    text += alignLeftRight('Bolsas:', receiptData.totalBags.toString(), LINE_WIDTH) + '\n';
  }
  
  text += alignLeftRight('Subtotal:', formatCurrency(receiptData.subtotal), LINE_WIDTH) + '\n';
  
  if (receiptData.discount > 0) {
    text += alignLeftRight('Descuento:', `-${formatCurrency(receiptData.discount)}`, LINE_WIDTH) + '\n';
  }
  if (receiptData.delivery > 0) {
    text += alignLeftRight('Delivery:', formatCurrency(receiptData.delivery), LINE_WIDTH) + '\n';
  }
  
  text += alignLeftRight('ITBMS:', formatCurrency(receiptData.tax), LINE_WIDTH) + '\n';
  text += THIN_DIVIDER + '\n';
  text += alignLeftRight('TOTAL:', formatCurrency(receiptData.total), LINE_WIDTH) + '\n';
  
  text += DIVIDER + '\n';
  
  // Payments
  text += centerText('FORMA DE PAGO', LINE_WIDTH) + '\n';
  for (const payment of receiptData.payments) {
    let paymentLine = payment.methodName;
    if (payment.reference) paymentLine += ` (${payment.reference})`;
    text += alignLeftRight(paymentLine, formatCurrency(payment.amount), LINE_WIDTH) + '\n';
  }
  
  if (receiptData.change > 0) {
    text += alignLeftRight('Cambio:', formatCurrency(receiptData.change), LINE_WIDTH) + '\n';
  }
  
  text += DIVIDER + '\n';
  
  // Notes
  if (receiptData.notes) {
    text += 'Notas: ' + receiptData.notes + '\n';
    text += THIN_DIVIDER + '\n';
  }
  
  // Loyalty Section
  if (receiptData.loyalty) {
    const loyalty = receiptData.loyalty;
    const hasLoyaltyInfo = loyalty.pointsEarned > 0 || loyalty.pointsUsed > 0 || 
                           loyalty.washPunches > 0 || loyalty.dryPunches > 0 ||
                           loyalty.freeWashesEarned > 0 || loyalty.freeDrysEarned > 0 ||
                           loyalty.freeServicesUsed.washes > 0 || loyalty.freeServicesUsed.drys > 0;
    
    if (hasLoyaltyInfo) {
      text += centerText('*** PROGRAMA DE LEALTAD ***', LINE_WIDTH) + '\n';
      text += THIN_DIVIDER + '\n';
      
      // Free services used in this order
      if (loyalty.freeServicesUsed.washes > 0 || loyalty.freeServicesUsed.drys > 0) {
        text += centerText('SERVICIOS GRATIS APLICADOS', LINE_WIDTH) + '\n';
        if (loyalty.freeServicesUsed.washes > 0) {
          text += alignLeftRight('  Lavados gratis:', loyalty.freeServicesUsed.washes.toString(), LINE_WIDTH) + '\n';
        }
        if (loyalty.freeServicesUsed.drys > 0) {
          text += alignLeftRight('  Secados gratis:', loyalty.freeServicesUsed.drys.toString(), LINE_WIDTH) + '\n';
        }
        text += '\n';
      }
      
      // Points section
      if (loyalty.pointsEarned > 0 || loyalty.pointsUsed > 0 || loyalty.pointsBalance > 0) {
        text += centerText('PUNTOS CASHBACK', LINE_WIDTH) + '\n';
        if (loyalty.pointsUsed > 0) {
          text += alignLeftRight('  Puntos usados:', `-B/${loyalty.pointsUsed.toFixed(2)}`, LINE_WIDTH) + '\n';
        }
        if (loyalty.pointsEarned > 0) {
          text += alignLeftRight('  Puntos ganados:', `+B/${loyalty.pointsEarned.toFixed(2)}`, LINE_WIDTH) + '\n';
        }
        text += alignLeftRight('  Saldo actual:', `B/${loyalty.pointsBalance.toFixed(2)}`, LINE_WIDTH) + '\n';
        text += '\n';
      }
      
      // Punch card section
      if (loyalty.washPunches > 0 || loyalty.dryPunches > 0 || 
          loyalty.freeWashesEarned > 0 || loyalty.freeDrysEarned > 0) {
        text += centerText('TARJETA DE SELLOS', LINE_WIDTH) + '\n';
        
        // Wash punches
        if (loyalty.washPunches > 0 || loyalty.washPunchesTotal > 0) {
          const washProgress = `${loyalty.washPunchesTotal}/${loyalty.punchesRequired}`;
          if (loyalty.washPunches > 0) {
            text += alignLeftRight(`  Lavados (+${loyalty.washPunches}):`, washProgress, LINE_WIDTH) + '\n';
          } else {
            text += alignLeftRight('  Lavados:', washProgress, LINE_WIDTH) + '\n';
          }
        }
        
        // Dry punches
        if (loyalty.dryPunches > 0 || loyalty.dryPunchesTotal > 0) {
          const dryProgress = `${loyalty.dryPunchesTotal}/${loyalty.punchesRequired}`;
          if (loyalty.dryPunches > 0) {
            text += alignLeftRight(`  Secados (+${loyalty.dryPunches}):`, dryProgress, LINE_WIDTH) + '\n';
          } else {
            text += alignLeftRight('  Secados:', dryProgress, LINE_WIDTH) + '\n';
          }
        }
        
        // Free services earned this order
        if (loyalty.freeWashesEarned > 0) {
          text += centerText(`*** GANASTE ${loyalty.freeWashesEarned} LAVADO(S) GRATIS! ***`, LINE_WIDTH) + '\n';
        }
        if (loyalty.freeDrysEarned > 0) {
          text += centerText(`*** GANASTE ${loyalty.freeDrysEarned} SECADO(S) GRATIS! ***`, LINE_WIDTH) + '\n';
        }
        
        // Available free services
        if (loyalty.freeWashesAvailable > 0 || loyalty.freeDrysAvailable > 0) {
          text += '\n';
          text += centerText('Servicios gratis disponibles:', LINE_WIDTH) + '\n';
          if (loyalty.freeWashesAvailable > 0) {
            text += alignLeftRight('  Lavados:', loyalty.freeWashesAvailable.toString(), LINE_WIDTH) + '\n';
          }
          if (loyalty.freeDrysAvailable > 0) {
            text += alignLeftRight('  Secados:', loyalty.freeDrysAvailable.toString(), LINE_WIDTH) + '\n';
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
  if (text.length >= width) return text.substring(0, width);
  const padding = Math.floor((width - text.length) / 2);
  return ' '.repeat(padding) + text + ' '.repeat(width - padding - text.length);
}

function alignLeftRight(left, right, width) {
  const leftLen = left.length;
  const rightLen = right.length;
  const spaces = width - leftLen - rightLen;
  if (spaces <= 0) return left.substring(0, width - rightLen - 1) + ' ' + right;
  return left + ' '.repeat(spaces) + right;
}

/**
 * Generate ESC/POS commands for thermal printing
 */
export function generateEscPosCommands(receiptData) {
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
  commands.push(...textToBytes('='.repeat(42)));
  commands.push(LF);
  
  // Order info - left aligned
  commands.push(...COMMANDS.ALIGN_LEFT);
  
  // Order number with express badge
  commands.push(...COMMANDS.BOLD_ON);
  let orderText = `Orden: ${receiptData.orderNumber}`;
  if (receiptData.isExpress) orderText += ' [EXPRESS]';
  commands.push(...textToBytes(orderText));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  
  commands.push(...textToBytes(`Fecha: ${receiptData.date}`));
  commands.push(LF);
  commands.push(...textToBytes(`Cliente: ${receiptData.customerName}`));
  commands.push(LF);
  
  if (receiptData.promisedDate) {
    commands.push(...textToBytes(`Listo para: ${receiptData.promisedDate}`));
    commands.push(LF);
  }
  
  // Items divider
  commands.push(...textToBytes('-'.repeat(42)));
  commands.push(LF);
  
  // Items header
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(padRight('CANT', 6) + padRight('DESCRIPCION', 22) + padLeft('TOTAL', 14)));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('-'.repeat(42)));
  commands.push(LF);
  
  // Items
  for (const item of receiptData.items) {
    const qtyStr = item.isWeight 
      ? `${item.weight.toFixed(2)}kg` 
      : `${item.quantity}x`;
    const totalStr = formatCurrency(item.total);
    
    commands.push(...textToBytes(padRight(qtyStr, 6) + padRight(item.name.substring(0, 22), 22) + padLeft(totalStr, 14)));
    commands.push(LF);
  }
  
  // Totals divider
  commands.push(...textToBytes('-'.repeat(42)));
  commands.push(LF);
  
  // Weight and bags
  if (receiptData.totalWeight > 0) {
    commands.push(...textToBytes(alignLeftRight('Peso Total:', `${receiptData.totalWeight.toFixed(2)} kg`, 42)));
    commands.push(LF);
  }
  if (receiptData.totalBags > 0) {
    commands.push(...textToBytes(alignLeftRight('Bolsas:', receiptData.totalBags.toString(), 42)));
    commands.push(LF);
  }
  
  // Subtotals
  commands.push(...textToBytes(alignLeftRight('Subtotal:', formatCurrency(receiptData.subtotal), 42)));
  commands.push(LF);
  
  if (receiptData.discount > 0) {
    commands.push(...textToBytes(alignLeftRight('Descuento:', `-${formatCurrency(receiptData.discount)}`, 42)));
    commands.push(LF);
  }
  if (receiptData.delivery > 0) {
    commands.push(...textToBytes(alignLeftRight('Delivery:', formatCurrency(receiptData.delivery), 42)));
    commands.push(LF);
  }
  
  commands.push(...textToBytes(alignLeftRight('ITBMS:', formatCurrency(receiptData.tax), 42)));
  commands.push(LF);
  
  // Total - bold and larger
  commands.push(...textToBytes('-'.repeat(42)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_DOUBLE_HEIGHT);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes(alignLeftRight('TOTAL:', formatCurrency(receiptData.total), 42)));
  commands.push(LF);
  commands.push(...COMMANDS.SIZE_NORMAL);
  commands.push(...COMMANDS.BOLD_OFF);
  
  // Payments section
  commands.push(...textToBytes('='.repeat(42)));
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
    commands.push(...textToBytes(alignLeftRight(paymentLine, formatCurrency(payment.amount), 42)));
    commands.push(LF);
  }
  
  if (receiptData.change > 0) {
    commands.push(...COMMANDS.BOLD_ON);
    commands.push(...textToBytes(alignLeftRight('Cambio:', formatCurrency(receiptData.change), 42)));
    commands.push(LF);
    commands.push(...COMMANDS.BOLD_OFF);
  }
  
  // Notes
  if (receiptData.notes) {
    commands.push(...textToBytes('='.repeat(42)));
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
      commands.push(...textToBytes('='.repeat(42)));
      commands.push(LF);
      commands.push(...COMMANDS.ALIGN_CENTER);
      commands.push(...COMMANDS.BOLD_ON);
      commands.push(...textToBytes('*** PROGRAMA DE LEALTAD ***'));
      commands.push(LF);
      commands.push(...COMMANDS.BOLD_OFF);
      commands.push(...textToBytes('-'.repeat(42)));
      commands.push(LF);
      commands.push(...COMMANDS.ALIGN_LEFT);
      
      // Free services used in this order
      if (loyalty.freeServicesUsed.washes > 0 || loyalty.freeServicesUsed.drys > 0) {
        commands.push(...COMMANDS.ALIGN_CENTER);
        commands.push(...textToBytes('SERVICIOS GRATIS APLICADOS'));
        commands.push(LF);
        commands.push(...COMMANDS.ALIGN_LEFT);
        if (loyalty.freeServicesUsed.washes > 0) {
          commands.push(...textToBytes(alignLeftRight('  Lavados gratis:', loyalty.freeServicesUsed.washes.toString(), 42)));
          commands.push(LF);
        }
        if (loyalty.freeServicesUsed.drys > 0) {
          commands.push(...textToBytes(alignLeftRight('  Secados gratis:', loyalty.freeServicesUsed.drys.toString(), 42)));
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
          commands.push(...textToBytes(alignLeftRight('  Puntos usados:', `-B/${loyalty.pointsUsed.toFixed(2)}`, 42)));
          commands.push(LF);
        }
        if (loyalty.pointsEarned > 0) {
          commands.push(...textToBytes(alignLeftRight('  Puntos ganados:', `+B/${loyalty.pointsEarned.toFixed(2)}`, 42)));
          commands.push(LF);
        }
        commands.push(...textToBytes(alignLeftRight('  Saldo actual:', `B/${loyalty.pointsBalance.toFixed(2)}`, 42)));
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
            commands.push(...textToBytes(alignLeftRight(`  Lavados (+${loyalty.washPunches}):`, washProgress, 42)));
          } else {
            commands.push(...textToBytes(alignLeftRight('  Lavados:', washProgress, 42)));
          }
          commands.push(LF);
        }
        
        // Dry punches
        if (loyalty.dryPunches > 0 || loyalty.dryPunchesTotal > 0) {
          const dryProgress = `${loyalty.dryPunchesTotal}/${loyalty.punchesRequired}`;
          if (loyalty.dryPunches > 0) {
            commands.push(...textToBytes(alignLeftRight(`  Secados (+${loyalty.dryPunches}):`, dryProgress, 42)));
          } else {
            commands.push(...textToBytes(alignLeftRight('  Secados:', dryProgress, 42)));
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
            commands.push(...textToBytes(alignLeftRight('  Lavados:', loyalty.freeWashesAvailable.toString(), 42)));
            commands.push(LF);
          }
          if (loyalty.freeDrysAvailable > 0) {
            commands.push(...textToBytes(alignLeftRight('  Secados:', loyalty.freeDrysAvailable.toString(), 42)));
            commands.push(LF);
          }
        }
      }
      
      commands.push(...textToBytes('-'.repeat(42)));
      commands.push(LF);
    }
  }
  
  // Footer
  commands.push(...textToBytes('='.repeat(42)));
  commands.push(LF);
  commands.push(...COMMANDS.ALIGN_CENTER);
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_ON);
  commands.push(...textToBytes('¡Gracias por su preferencia!'));
  commands.push(LF);
  commands.push(...COMMANDS.BOLD_OFF);
  commands.push(...textToBytes('www.americanlaundry.com'));
  commands.push(LF);
  
  // Feed and cut
  commands.push(...COMMANDS.FEED_LINES(4));
  commands.push(...COMMANDS.PARTIAL_CUT);
  
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

export default {
  connectPrinter,
  disconnectPrinter,
  isPrinterConnected,
  printReceipt,
  printTestPage,
  openCashDrawer,
  generateReceiptData,
  generateReceiptText,
  saveReceiptToStorage,
};
