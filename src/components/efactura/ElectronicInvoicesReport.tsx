import React, { useState } from 'react';
import { Download, Printer, ExternalLink, FileText } from 'lucide-react';
import { Badge } from '../ui/Badge';
import {
  useStoreInvoices,
  downloadCafe,
  printCafe,
  type InvoiceWithOrder,
} from '../../hooks/queries/useElectronicInvoice';
import type { EInvoiceStatus } from '../../types';

const STATUS_META: Record<EInvoiceStatus, { label: string; variant: 'default' | 'success' | 'warning' | 'error' | 'info' }> = {
  pending: { label: 'Pendiente', variant: 'warning' },
  emitting: { label: 'Emitiendo', variant: 'info' },
  authorized: { label: 'Autorizada', variant: 'success' },
  rejected: { label: 'Rechazada', variant: 'error' },
  cancelled: { label: 'Anulada', variant: 'default' },
};

const DOC_TYPE_LABEL: Record<string, string> = {
  '01': 'Factura',
  '06': 'Nota Crédito',
  '07': 'Nota Débito',
};

interface Props {
  storeId?: string;
  startISO?: string;
  endISO?: string;
  formatCurrency: (n: number) => string;
}

export default function ElectronicInvoicesReport({ storeId, startISO, endISO, formatCurrency }: Props) {
  const { data: invoices = [], isLoading } = useStoreInvoices(storeId, startISO, endISO);
  const [busy, setBusy] = useState<string | null>(null);

  const authorized = invoices.filter((i) => i.status === 'authorized');
  const failed = invoices.filter((i) => i.status === 'rejected' || i.status === 'pending');
  const totalBilled = authorized.reduce((s, i) => s + (i.orders?.total || 0), 0);

  const fmtDate = (iso: string) =>
    new Date(iso).toLocaleString('es-PA', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });

  const exportCsv = () => {
    let csv = 'Fecha,Tipo,Orden,Cliente,Total,Estado,CUFE\n';
    for (const i of invoices) {
      const row = [
        fmtDate(i.created_at),
        DOC_TYPE_LABEL[i.doc_type] || i.doc_type,
        i.orders?.order_number ?? '',
        (i.orders?.customer_name || '').replace(/,/g, ' '),
        (i.orders?.total ?? 0).toFixed(2),
        STATUS_META[i.status].label,
        i.cufe || '',
      ];
      csv += row.join(',') + '\n';
    }
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = `facturas-electronicas-${(startISO || '').slice(0, 10)}.csv`;
    link.click();
  };

  const action = async (key: string, fn: () => Promise<void>) => {
    setBusy(key);
    try {
      await fn();
    } catch (e) {
      alert((e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  return (
    <div className="space-y-4">
      {/* Summary */}
      <div className="grid grid-cols-3 gap-4">
        <div className="bg-white rounded-xl border border-slate-200 p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Autorizadas</p>
          <p className="text-2xl font-bold text-emerald-600">{authorized.length}</p>
        </div>
        <div className="bg-white rounded-xl border border-slate-200 p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Pendientes / Rechazadas</p>
          <p className="text-2xl font-bold text-amber-600">{failed.length}</p>
        </div>
        <div className="bg-white rounded-xl border border-slate-200 p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Total Facturado</p>
          <p className="text-2xl font-bold text-slate-800">{formatCurrency(totalBilled)}</p>
        </div>
      </div>

      <div className="flex justify-end">
        <button onClick={exportCsv} disabled={!invoices.length} className="btn-secondary text-sm">
          <Download className="w-4 h-4" /> Exportar CSV
        </button>
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-slate-100">
            <tr>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Fecha</th>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Tipo</th>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Orden</th>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Cliente</th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">Total</th>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Estado</th>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">CUFE</th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">Acciones</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {isLoading && (
              <tr>
                <td colSpan={8} className="px-4 py-8 text-center text-slate-400">Cargando…</td>
              </tr>
            )}
            {!isLoading && invoices.length === 0 && (
              <tr>
                <td colSpan={8} className="px-4 py-8 text-center text-slate-400">
                  No hay facturas electrónicas en este período
                </td>
              </tr>
            )}
            {invoices.map((i: InvoiceWithOrder) => (
              <tr key={i.id} className="hover:bg-slate-50">
                <td className="px-4 py-3 text-slate-700 whitespace-nowrap">{fmtDate(i.created_at)}</td>
                <td className="px-4 py-3 text-slate-600">{DOC_TYPE_LABEL[i.doc_type] || i.doc_type}</td>
                <td className="px-4 py-3 text-slate-600">{i.orders?.order_number ?? '—'}</td>
                <td className="px-4 py-3 text-slate-600">{i.orders?.customer_name || '—'}</td>
                <td className="px-4 py-3 text-right text-slate-700">{formatCurrency(i.orders?.total || 0)}</td>
                <td className="px-4 py-3"><Badge variant={STATUS_META[i.status].variant}>{STATUS_META[i.status].label}</Badge></td>
                <td className="px-4 py-3 font-mono text-xs text-slate-400 max-w-[180px] truncate" title={i.cufe || ''}>
                  {i.cufe || '—'}
                </td>
                <td className="px-4 py-3">
                  {i.status === 'authorized' && (
                    <div className="flex items-center justify-end gap-1">
                      <button
                        title="Descargar PDF"
                        onClick={() => action(`d-${i.id}`, () => downloadCafe({ invoiceId: i.id }, `factura-${i.cufe}.pdf`))}
                        disabled={busy === `d-${i.id}`}
                        className="p-1.5 rounded hover:bg-slate-100 text-slate-500"
                      >
                        <Download className="w-4 h-4" />
                      </button>
                      <button
                        title="Imprimir"
                        onClick={() => action(`p-${i.id}`, () => printCafe({ invoiceId: i.id }))}
                        disabled={busy === `p-${i.id}`}
                        className="p-1.5 rounded hover:bg-slate-100 text-slate-500"
                      >
                        <Printer className="w-4 h-4" />
                      </button>
                      {i.qr_content && (
                        <a title="Ver en DGI" href={i.qr_content} target="_blank" rel="noreferrer" className="p-1.5 rounded hover:bg-slate-100 text-slate-500">
                          <ExternalLink className="w-4 h-4" />
                        </a>
                      )}
                    </div>
                  )}
                  {i.status === 'rejected' && (
                    <span className="flex items-center justify-end gap-1 text-xs text-red-500" title={i.error || ''}>
                      <FileText className="w-3 h-3" /> Ver orden
                    </span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
