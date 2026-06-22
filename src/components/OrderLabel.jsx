import React, { useEffect, useRef } from 'react';
import JsBarcode from 'jsbarcode';
import { X, Printer, Tag } from 'lucide-react';

// Scannable value: the order number a USB scanner types back into the Orders
// search (searchOrders matches it). Legacy CC orders keep their printed code.
const barcodeValue = (order) =>
  order.legacy_order_number || String(order.order_number || '');

const displayNumber = (order) =>
  order.legacy_order_number || `#${order.order_number}`;

const fmtDate = (iso) =>
  iso ? new Date(iso).toLocaleDateString('es-PA', { day: '2-digit', month: 'short', year: 'numeric' }) : '';

/**
 * Printable garment/order tag: a Code128 barcode of the order number plus the
 * customer + key counts, so staff can label bags and scan them back at pickup.
 */
function OrderLabel({ order, companyName, onClose }) {
  const canvasRef = useRef(null);
  const value = barcodeValue(order);

  useEffect(() => {
    if (canvasRef.current && value) {
      JsBarcode(canvasRef.current, value, {
        format: 'CODE128',
        displayValue: true,
        fontSize: 16,
        height: 60,
        margin: 6,
      });
    }
  }, [value]);

  const handlePrint = () => {
    const dataUrl = canvasRef.current?.toDataURL('image/png');
    if (!dataUrl) return;
    // Isolate the print to just the label by opening a minimal document.
    const w = window.open('', '_blank', 'width=420,height=320');
    if (!w) {
      alert('Permite las ventanas emergentes para imprimir la etiqueta.');
      return;
    }
    w.document.write(`<!doctype html><html><head><title>Etiqueta ${displayNumber(order)}</title>
      <style>
        * { font-family: -apple-system, system-ui, sans-serif; }
        body { margin: 0; padding: 12px; }
        .label { width: 100%; text-align: center; }
        .meta { font-size: 13px; color: #111; }
        .meta .name { font-weight: 700; font-size: 15px; margin: 2px 0; }
        .counts { font-size: 12px; color: #444; margin-top: 4px; }
        img { max-width: 100%; }
        @media print { @page { margin: 6mm; } }
      </style></head><body>
      <div class="label">
        ${companyName ? `<div class="meta" style="font-size:12px;color:#666">${companyName}</div>` : ''}
        <img src="${dataUrl}" />
        <div class="meta"><div class="name">${(order.customer_name || 'Walk-in')}</div></div>
        <div class="counts">
          ${order.total_pieces ? `${order.total_pieces} pza` : ''}${order.total_bags ? ` · ${order.total_bags} bolsa(s)` : ''}
          ${order.promised_date ? ` · Entrega ${fmtDate(order.promised_date)}` : ''}
        </div>
      </div>
      <script>window.onload = function(){ window.print(); setTimeout(function(){ window.close(); }, 300); };<\/script>
      </body></html>`);
    w.document.close();
  };

  return (
    <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between border-b border-slate-100 p-4">
          <h2 className="text-lg font-semibold text-slate-800 flex items-center gap-2">
            <Tag className="w-5 h-5 text-primary-500" /> Etiqueta {displayNumber(order)}
          </h2>
          <button onClick={onClose} className="rounded-lg p-2 text-slate-400 hover:bg-slate-100">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-5">
          <div className="rounded-xl border border-slate-200 p-4 text-center">
            <canvas ref={canvasRef} className="mx-auto max-w-full" />
            <p className="mt-2 font-semibold text-slate-800">{order.customer_name || 'Walk-in'}</p>
            <p className="text-xs text-slate-500">
              {order.total_pieces ? `${order.total_pieces} pza` : ''}
              {order.total_bags ? ` · ${order.total_bags} bolsa(s)` : ''}
              {order.promised_date ? ` · Entrega ${fmtDate(order.promised_date)}` : ''}
            </p>
          </div>
        </div>

        <div className="flex items-center justify-end gap-3 border-t border-slate-100 p-4">
          <button onClick={onClose} className="btn-secondary">Cerrar</button>
          <button onClick={handlePrint} className="btn-primary">
            <Printer className="w-4 h-4" /> Imprimir etiqueta
          </button>
        </div>
      </div>
    </div>
  );
}

export default OrderLabel;
