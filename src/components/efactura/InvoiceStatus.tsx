import React, { useState } from 'react';
import { FileText, Download, Printer, ExternalLink, RefreshCw, Ban, Loader2 } from 'lucide-react';
import { Badge } from '../ui/Badge';
import {
  useOrderInvoice,
  useEmitInvoice,
  useCancelInvoice,
  downloadCafe,
  printCafe,
  reprintFiscalReceipt,
} from '../../hooks/queries/useElectronicInvoice';
import type { EInvoiceStatus } from '../../types';
import { usePermission } from '../../hooks/usePermission';

const STATUS_META: Record<EInvoiceStatus, { label: string; variant: 'default' | 'success' | 'warning' | 'error' | 'info' }> = {
  pending: { label: 'Pendiente', variant: 'warning' },
  emitting: { label: 'Emitiendo…', variant: 'info' },
  authorized: { label: 'Autorizada', variant: 'success' },
  rejected: { label: 'Rechazada', variant: 'error' },
  cancelled: { label: 'Anulada', variant: 'default' },
};

interface Props {
  orderId: string;
  /** Staff get emit/retry/cancel actions; customers only view/download. */
  staff?: boolean;
  /** Set false for refund orders (the credit note is auto-emitted; don't offer
   * a manual "emit factura"). Defaults to true. */
  canEmit?: boolean;
}

export function InvoiceStatus({ orderId, staff = false, canEmit = true }: Props) {
  const { data: invoice, isLoading } = useOrderInvoice(orderId);
  const emit = useEmitInvoice(orderId);
  const cancel = useCancelInvoice(orderId);
  const { can } = usePermission();
  // Voiding an authorized factura is restricted to the owner (admin).
  const canVoid = can('efactura.void');
  const [busy, setBusy] = useState<string | null>(null);

  if (isLoading) return null;

  const handleDownload = async () => {
    if (!invoice) return;
    setBusy('download');
    try {
      await downloadCafe({ invoiceId: invoice.id }, `factura-${invoice.cufe || invoice.id}.pdf`);
    } catch (e) {
      alert('No se pudo descargar la factura: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  // Silent thermal reprint (representación impresa with QR). Falls back to the
  // PDF print dialog if the thermal printer/transport isn't available.
  const handlePrint = async () => {
    if (!invoice) return;
    setBusy('print');
    try {
      await reprintFiscalReceipt(orderId, invoice);
    } catch (e) {
      console.warn('Thermal reprint failed, falling back to PDF:', e);
      try {
        await printCafe({ invoiceId: invoice.id });
      } catch (e2) {
        alert('No se pudo imprimir la factura: ' + (e2 as Error).message);
      }
    } finally {
      setBusy(null);
    }
  };

  // Explicit PDF print (browser dialog) — kept as a secondary option.
  const handlePrintPdf = async () => {
    if (!invoice) return;
    setBusy('print-pdf');
    try {
      await printCafe({ invoiceId: invoice.id });
    } catch (e) {
      alert('No se pudo imprimir el PDF: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  const handleEmit = async () => {
    setBusy('emit');
    try {
      await emit.mutateAsync();
    } catch (e) {
      alert('No se pudo emitir la factura: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  const handleCancel = async () => {
    if (!invoice?.cufe) return;
    const reason = prompt('Motivo de anulación:');
    if (!reason) return;
    setBusy('cancel');
    try {
      await cancel.mutateAsync({ invoiceId: invoice.id, reason });
    } catch (e) {
      alert('No se pudo anular: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  // No document yet.
  if (!invoice) {
    if (!staff || !canEmit) return null;
    return (
      <div className="flex items-center justify-between">
        <span className="text-sm text-slate-500 flex items-center gap-1.5">
          <FileText className="w-4 h-4" /> Sin factura electrónica
        </span>
        <button onClick={handleEmit} disabled={busy === 'emit'} className="btn-secondary text-sm">
          {busy === 'emit' ? <Loader2 className="w-4 h-4 animate-spin" /> : <FileText className="w-4 h-4" />}
          Emitir factura
        </button>
      </div>
    );
  }

  const meta = STATUS_META[invoice.status];

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm font-semibold text-slate-900 flex items-center gap-1.5">
          <FileText className="w-4 h-4 text-primary-500" /> Factura Electrónica
        </span>
        <Badge variant={meta.variant}>{meta.label}</Badge>
      </div>

      {invoice.cufe && (
        <p className="text-xs text-slate-400 break-all font-mono">CUFE: {invoice.cufe}</p>
      )}

      {invoice.status === 'rejected' && invoice.error && (
        <p className="text-xs text-red-600">{invoice.error}</p>
      )}

      <div className="flex flex-wrap gap-2 pt-1">
        {invoice.status === 'authorized' && (
          <>
            <button onClick={handleDownload} disabled={busy === 'download'} className="btn-secondary text-sm">
              {busy === 'download' ? <Loader2 className="w-4 h-4 animate-spin" /> : <Download className="w-4 h-4" />}
              Descargar PDF
            </button>
            <button onClick={handlePrint} disabled={busy === 'print'} className="btn-secondary text-sm">
              {busy === 'print' ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
              Imprimir
            </button>
            <button onClick={handlePrintPdf} disabled={busy === 'print-pdf'} className="btn-secondary text-sm">
              {busy === 'print-pdf' ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
              Imprimir PDF
            </button>
            {invoice.qr_content && (
              <a
                href={invoice.qr_content}
                target="_blank"
                rel="noreferrer"
                className="btn-secondary text-sm"
              >
                <ExternalLink className="w-4 h-4" /> Ver en DGI
              </a>
            )}
            {staff && canVoid && (
              <button onClick={handleCancel} disabled={busy === 'cancel'} className="btn-secondary text-sm text-red-600">
                {busy === 'cancel' ? <Loader2 className="w-4 h-4 animate-spin" /> : <Ban className="w-4 h-4" />}
                Anular
              </button>
            )}
          </>
        )}

        {staff && canEmit && invoice.status === 'rejected' && (
          <button onClick={handleEmit} disabled={busy === 'emit'} className="btn-secondary text-sm">
            {busy === 'emit' ? <Loader2 className="w-4 h-4 animate-spin" /> : <RefreshCw className="w-4 h-4" />}
            Reintentar
          </button>
        )}
      </div>
    </div>
  );
}
