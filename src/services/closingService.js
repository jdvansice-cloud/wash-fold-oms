/**
 * Daily Closing Service
 * Handles end-of-day reconciliation reports
 */

import { supabase } from '../config/supabase';

const PAPER_WIDTH = 48;

// ============================================
// Report Formatting Utilities
// ============================================

function centerText(text, width = PAPER_WIDTH) {
  const padding = Math.max(0, Math.floor((width - text.length) / 2));
  return ' '.repeat(padding) + text;
}

function separatorLine(char = '-', width = PAPER_WIDTH) {
  return char.repeat(width);
}

function formatCurrency(amount) {
  return `B/${amount.toFixed(2)}`;
}

function formatLabelValue(label, value, width = PAPER_WIDTH) {
  const spaces = width - label.length - value.length;
  return label + ' '.repeat(Math.max(1, spaces)) + value;
}

function rightAlign(text, width = PAPER_WIDTH) {
  const padding = Math.max(0, width - text.length);
  return ' '.repeat(padding) + text;
}

// ============================================
// Report Generation
// ============================================

/**
 * Generate closing report content for printing
 */
export function generateClosingReportContent(data) {
  const {
    date,
    openingBalance,
    closingBalance,
    expectedCash,
    variance,
    totalSales,
    totalOrders,
    totalDiscounts,
    totalRefunds,
    netSales,
    salesByPayment,
    discountsByUser,
    refundsByUser,
    transactionsByUser,
    notes,
    closedAt,
    closedBy,
    companyInfo,
  } = data;

  const lines = [];
  const reportDate = new Date(date);
  const dateStr = reportDate.toLocaleDateString('es-PA', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  // Header
  lines.push('');
  lines.push(centerText(companyInfo?.name || 'AMERICAN LAUNDRY'));
  lines.push(centerText('CIERRE DEL DÍA'));
  lines.push('');
  lines.push(separatorLine('='));
  lines.push(centerText(dateStr));
  lines.push(separatorLine('='));
  lines.push('');

  // Summary
  lines.push('RESUMEN DE VENTAS');
  lines.push(separatorLine('-'));
  lines.push(formatLabelValue('Total de Órdenes:', totalOrders.toString()));
  lines.push(formatLabelValue('Ventas Brutas:', formatCurrency(totalSales)));
  lines.push(formatLabelValue('Descuentos:', `-${formatCurrency(totalDiscounts)}`));
  lines.push(formatLabelValue('Reembolsos:', `-${formatCurrency(totalRefunds)}`));
  lines.push(separatorLine('-'));
  lines.push(formatLabelValue('VENTAS NETAS:', formatCurrency(netSales)));
  lines.push('');

  // Sales by Payment Method
  lines.push('VENTAS POR MÉTODO DE PAGO');
  lines.push(separatorLine('-'));
  
  const paymentLabels = {
    cash: 'Efectivo',
    card: 'Tarjeta',
    yappy: 'Yappy',
    ach: 'ACH/Banco',
    check: 'Cheque',
    invoice: 'Factura Crédito',
    pickup: 'Pago en Recogida',
    gift_card: 'Tarjeta Regalo',
  };

  Object.entries(salesByPayment).forEach(([method, amount]) => {
    if (amount > 0) {
      const label = paymentLabels[method] || method;
      lines.push(formatLabelValue(`  ${label}:`, formatCurrency(amount)));
    }
  });
  lines.push('');

  // Cash Reconciliation
  lines.push('RECONCILIACIÓN DE CAJA');
  lines.push(separatorLine('-'));
  lines.push(formatLabelValue('Balance Apertura:', formatCurrency(openingBalance)));
  lines.push(formatLabelValue('+ Ventas Efectivo:', formatCurrency(salesByPayment.cash || 0)));
  lines.push(formatLabelValue('Efectivo Esperado:', formatCurrency(expectedCash)));
  lines.push(formatLabelValue('Efectivo Contado:', formatCurrency(closingBalance)));
  lines.push(separatorLine('-'));
  
  const varianceStr = variance >= 0 ? `+${formatCurrency(variance)}` : formatCurrency(variance);
  const varianceStatus = Math.abs(variance) < 0.01 ? '(CUADRA)' : 
                         Math.abs(variance) <= 5 ? '(MENOR)' : '(REVISAR)';
  lines.push(formatLabelValue('DIFERENCIA:', `${varianceStr} ${varianceStatus}`));
  lines.push('');

  // Discounts by User
  if (Object.keys(discountsByUser).length > 0) {
    lines.push('DESCUENTOS POR USUARIO');
    lines.push(separatorLine('-'));
    
    Object.entries(discountsByUser).forEach(([userId, userData]) => {
      lines.push(formatLabelValue(`  ${userData.name}:`, formatCurrency(userData.total)));
      userData.details.forEach(detail => {
        lines.push(`    #${detail.orderNumber}: -${formatCurrency(detail.amount)}`);
      });
    });
    lines.push('');
  }

  // Refunds by User
  if (Object.keys(refundsByUser).length > 0) {
    lines.push('REEMBOLSOS POR USUARIO');
    lines.push(separatorLine('-'));
    
    Object.entries(refundsByUser).forEach(([userId, userData]) => {
      lines.push(formatLabelValue(`  ${userData.name}:`, formatCurrency(userData.total)));
      userData.details.forEach(detail => {
        lines.push(`    #${detail.orderNumber}: -${formatCurrency(detail.amount)}`);
        if (detail.reason) {
          lines.push(`      Razón: ${detail.reason}`);
        }
      });
    });
    lines.push('');
  }

  // User Summary
  if (Object.keys(transactionsByUser).length > 0) {
    lines.push('RESUMEN POR USUARIO');
    lines.push(separatorLine('-'));
    
    Object.entries(transactionsByUser).forEach(([userId, userData]) => {
      lines.push(`  ${userData.name}`);
      lines.push(`    Órdenes: ${userData.orders} | Ventas: ${formatCurrency(userData.sales)}`);
      if (userData.discounts > 0 || userData.refunds > 0) {
        lines.push(`    Desc: -${formatCurrency(userData.discounts)} | Reemb: -${formatCurrency(userData.refunds)}`);
      }
    });
    lines.push('');
  }

  // Notes
  if (notes) {
    lines.push('NOTAS');
    lines.push(separatorLine('-'));
    const noteLines = notes.split('\n');
    noteLines.forEach(line => lines.push(line));
    lines.push('');
  }

  // Footer
  lines.push(separatorLine('='));
  if (closedAt) {
    const closedDate = new Date(closedAt);
    lines.push(centerText(`Cerrado: ${closedDate.toLocaleString('es-PA')}`));
  }
  if (closedBy) {
    lines.push(centerText(`Por: ${closedBy}`));
  }
  lines.push('');
  lines.push(centerText('*** FIN DEL REPORTE ***'));
  lines.push('');
  lines.push('');
  lines.push('');

  return lines.join('\n');
}

/**
 * Open browser print dialog with closing report
 */
export function generateClosingReport(data) {
  const content = generateClosingReportContent(data);
  
  const printWindow = window.open('', '_blank');
  printWindow.document.write(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Cierre del Día - ${data.date}</title>
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

/**
 * Print closing report using QZ Tray
 */
export async function printClosingReport(data, printerName = null) {
  if (typeof qz === 'undefined') {
    console.warn('QZ Tray not available, using browser print');
    generateClosingReport(data);
    return;
  }

  try {
    if (!qz.websocket.isActive()) {
      await qz.websocket.connect();
    }

    // Find printer
    let printer = printerName;
    if (!printer) {
      const printers = await qz.printers.find();
      printer = printers.find(p => 
        p.toLowerCase().includes('epson') || 
        p.toLowerCase().includes('tm-t20')
      ) || printers[0];
    }

    if (!printer) {
      throw new Error('No printer found');
    }

    const content = generateClosingReportContent(data);

    const config = qz.configs.create(printer, {
      encoding: 'UTF-8',
    });

    const escposData = [
      '\x1B\x40',          // Initialize
      '\x1B\x61\x00',      // Left align
      content,
      '\x1B\x64\x05',      // Feed 5 lines
      '\x1D\x56\x00',      // Full cut
    ];

    await qz.print(config, [{
      type: 'raw',
      format: 'plain',
      data: escposData.join('')
    }]);

    console.log('Closing report printed successfully');
  } catch (error) {
    console.error('Print error:', error);
    // Fallback to browser print
    generateClosingReport(data);
  }
}

/**
 * Save closing report to Supabase
 */
export async function saveClosingReport(data) {
  const {
    date,
    openingBalance,
    closingBalance,
    expectedCash,
    variance,
    totalSales,
    totalOrders,
    totalDiscounts,
    totalRefunds,
    netSales,
    salesByPayment,
    discountsByUser,
    refundsByUser,
    transactionsByUser,
    notes,
    closedAt,
    closedBy,
  } = data;

  try {
    // Save to daily_closings table
    const { data: savedData, error } = await supabase
      .from('daily_closings')
      .upsert({
        closing_date: date,
        opening_balance: openingBalance,
        closing_balance: closingBalance,
        expected_cash: expectedCash,
        variance: variance,
        total_sales: totalSales,
        total_orders: totalOrders,
        total_discounts: totalDiscounts,
        total_refunds: totalRefunds,
        net_sales: netSales,
        sales_by_payment: salesByPayment,
        discounts_by_user: discountsByUser,
        refunds_by_user: refundsByUser,
        transactions_by_user: transactionsByUser,
        notes: notes,
        closed_at: closedAt,
        closed_by: closedBy,
        status: 'closed',
      }, {
        onConflict: 'closing_date',
      })
      .select()
      .single();

    if (error) throw error;

    // Also save report as text file to storage
    const reportContent = generateClosingReportContent(data);
    const fileName = `closing_${date}.txt`;
    const filePath = `closings/${date.substring(0, 7)}/${fileName}`;

    const blob = new Blob([reportContent], { type: 'text/plain;charset=utf-8' });

    await supabase.storage
      .from('receipts')
      .upload(filePath, blob, {
        contentType: 'text/plain',
        upsert: true,
      });

    console.log('Closing report saved successfully');
    return savedData;
  } catch (error) {
    console.error('Error saving closing report:', error);
    throw error;
  }
}

/**
 * Get closing report for a specific date
 */
export async function getClosingReport(date) {
  try {
    const { data, error } = await supabase
      .from('daily_closings')
      .select('*')
      .eq('closing_date', date)
      .single();

    if (error && error.code !== 'PGRST116') throw error;
    return data;
  } catch (error) {
    console.error('Error fetching closing report:', error);
    return null;
  }
}

/**
 * Get closing reports for a date range
 */
export async function getClosingReports(startDate, endDate) {
  try {
    const { data, error } = await supabase
      .from('daily_closings')
      .select('*')
      .gte('closing_date', startDate)
      .lte('closing_date', endDate)
      .order('closing_date', { ascending: false });

    if (error) throw error;
    return data || [];
  } catch (error) {
    console.error('Error fetching closing reports:', error);
    return [];
  }
}

export default {
  generateClosingReportContent,
  generateClosingReport,
  printClosingReport,
  saveClosingReport,
  getClosingReport,
  getClosingReports,
};
