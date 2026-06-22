import React, { useMemo, useState } from 'react';
import { FileText, CheckCircle, AlertTriangle, Clock, Loader2, RefreshCw, Printer } from 'lucide-react';
import { useQueryClient } from '@tanstack/react-query';
import { useInvoicesForOrders, printCafe } from '../../hooks/queries/useElectronicInvoice';
import { emitInvoice } from '../../lib/efactura/client';
import type { ElectronicInvoice } from '../../types';

interface EodOrder {
  id: string;
  order_number?: number;
  customer_name?: string | null;
  total: number;
}

interface Props {
  orders: EodOrder[];
  formatCurrency: (n: number) => string;
}

/**
 * EOD electronic-invoicing reconciliation: confirms every sale of the day was
 * billed to the DGI, and surfaces the gaps (missing / rejected / in-flight) with
 * one-click emit/retry so the day can be closed clean.
 */
export default function EFacturaReconciliation({ orders, formatCurrency }: Props) {
  const qc = useQueryClient();
  const orderIds = useMemo(() => orders.map((o) => o.id), [orders]);
  const { data: invoiceMap = {}, isLoading } = useInvoicesForOrders(orderIds);
  const [busy, setBusy] = useState<string | null>(null);

  const groups = useMemo(() => {
    const authorized: EodOrder[] = [];
    const pending: EodOrder[] = [];
    const rejected: EodOrder[] = [];
    const missing: EodOrder[] = [];
    for (const o of orders) {
      const inv: ElectronicInvoice | undefined = invoiceMap[o.id];
      if (!inv) missing.push(o);
      else if (inv.status === 'authorized') authorized.push(o);
      else if (inv.status === 'rejected' || inv.status === 'cancelled') rejected.push(o);
      else pending.push(o); // pending / emitting
    }
    return { authorized, pending, rejected, missing };
  }, [orders, invoiceMap]);

  const sum = (list: EodOrder[]) => list.reduce((s, o) => s + Math.abs(o.total || 0), 0);
  const totalSales = sum(orders);
  const authorizedAmount = sum(groups.authorized);
  const difference = totalSales - authorizedAmount;
  const problems = [...groups.missing, ...groups.rejected];

  const refresh = () => qc.invalidateQueries({ queryKey: ['invoices-for-orders'] });

  const handleEmit = async (orderId: string) => {
    setBusy(orderId);
    try {
      await emitInvoice(orderId);
      refresh();
    } catch (e) {
      alert('No se pudo emitir: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  const handleEmitAll = async () => {
    setBusy('all');
    try {
      for (const o of problems) {
        try {
          await emitInvoice(o.id);
        } catch {
          /* keep going; per-row state will reflect failures after refresh */
        }
      }
      refresh();
    } finally {
      setBusy(null);
    }
  };

  const handlePrint = async (orderId: string) => {
    const inv = invoiceMap[orderId];
    if (!inv) return;
    setBusy('print-' + orderId);
    try {
      await printCafe({ invoiceId: inv.id });
    } catch (e) {
      alert('No se pudo imprimir: ' + (e as Error).message);
    } finally {
      setBusy(null);
    }
  };

  const allClear = problems.length === 0 && groups.pending.length === 0;

  return (
    <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
      <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <FileText className="w-5 h-5 text-primary-500" />
          <h2 className="font-semibold text-slate-800">Conciliación de Facturación Electrónica</h2>
        </div>
        <button onClick={refresh} className="p-1.5 rounded hover:bg-slate-100 text-slate-400" title="Actualizar">
          <RefreshCw className="w-4 h-4" />
        </button>
      </div>

      <div className="p-5 space-y-4">
        {isLoading ? (
          <div className="py-6 text-center text-slate-400 flex items-center justify-center gap-2">
            <Loader2 className="w-4 h-4 animate-spin" /> Cargando…
          </div>
        ) : orders.length === 0 ? (
          <p className="text-slate-500 text-center py-4">No hay ventas para esta fecha</p>
        ) : (
          <>
            {/* Counters */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              <Stat icon={<CheckCircle className="w-4 h-4" />} tone="emerald" label="Autorizadas" value={groups.authorized.length} />
              <Stat icon={<Clock className="w-4 h-4" />} tone="blue" label="En proceso" value={groups.pending.length} />
              <Stat icon={<AlertTriangle className="w-4 h-4" />} tone="red" label="Rechazadas" value={groups.rejected.length} />
              <Stat icon={<FileText className="w-4 h-4" />} tone="amber" label="Sin factura" value={groups.missing.length} />
            </div>

            {/* Reconciliation line */}
            <div className="rounded-lg bg-slate-50 p-4 space-y-1.5 text-sm">
              <Row label="Ventas del día" value={formatCurrency(totalSales)} />
              <Row label="Facturado (autorizadas)" value={formatCurrency(authorizedAmount)} />
              <div className="flex justify-between pt-1.5 border-t border-slate-200 font-semibold">
                <span className={difference > 0.005 ? 'text-red-600' : 'text-emerald-600'}>
                  {difference > 0.005 ? 'Pendiente de facturar' : 'Diferencia'}
                </span>
                <span className={difference > 0.005 ? 'text-red-600' : 'text-emerald-600'}>
                  {formatCurrency(difference)}
                </span>
              </div>
            </div>

            {allClear ? (
              <div className="flex items-center gap-2 text-sm text-emerald-700 bg-emerald-50 rounded-lg px-3 py-2">
                <CheckCircle className="w-4 h-4" /> Todas las ventas del día están facturadas a la DGI.
              </div>
            ) : (
              <>
                {groups.pending.length > 0 && problems.length === 0 && (
                  <div className="flex items-center gap-2 text-sm text-blue-700 bg-blue-50 rounded-lg px-3 py-2">
                    <Clock className="w-4 h-4" /> {groups.pending.length} factura(s) en proceso — el sistema
                    reintenta automáticamente.
                  </div>
                )}

                {problems.length > 0 && (
                  <div>
                    <div className="flex items-center justify-between mb-2">
                      <p className="text-sm font-medium text-slate-700">
                        Requieren atención ({problems.length})
                      </p>
                      <button onClick={handleEmitAll} disabled={busy === 'all'} className="btn-secondary text-xs">
                        {busy === 'all' ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <RefreshCw className="w-3.5 h-3.5" />}
                        Emitir todas
                      </button>
                    </div>
                    <div className="border border-slate-200 rounded-lg divide-y divide-slate-100 max-h-64 overflow-auto">
                      {problems.map((o) => {
                        const inv = invoiceMap[o.id];
                        const isRejected = inv?.status === 'rejected';
                        return (
                          <div key={o.id} className="flex items-center justify-between px-3 py-2 text-sm">
                            <div className="min-w-0">
                              <p className="font-medium text-slate-700">
                                #{o.order_number ?? '—'} · {formatCurrency(Math.abs(o.total || 0))}
                              </p>
                              <p className="text-xs truncate text-slate-400">
                                {o.customer_name || 'Consumidor final'}
                                {isRejected && inv?.error ? ` · ${inv.error}` : ''}
                              </p>
                            </div>
                            <button
                              onClick={() => handleEmit(o.id)}
                              disabled={busy === o.id}
                              className="btn-secondary text-xs flex-shrink-0"
                            >
                              {busy === o.id ? (
                                <Loader2 className="w-3.5 h-3.5 animate-spin" />
                              ) : (
                                <FileText className="w-3.5 h-3.5" />
                              )}
                              {isRejected ? 'Reintentar' : 'Emitir'}
                            </button>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                )}
              </>
            )}

            {/* Reprint authorized */}
            {groups.authorized.length > 0 && (
              <details className="text-sm">
                <summary className="cursor-pointer text-slate-500 hover:text-slate-700">
                  Reimprimir facturas autorizadas ({groups.authorized.length})
                </summary>
                <div className="mt-2 border border-slate-200 rounded-lg divide-y divide-slate-100 max-h-64 overflow-auto">
                  {groups.authorized.map((o) => (
                    <div key={o.id} className="flex items-center justify-between px-3 py-2">
                      <span className="text-slate-600">
                        #{o.order_number ?? '—'} · {formatCurrency(Math.abs(o.total || 0))}
                      </span>
                      <button
                        onClick={() => handlePrint(o.id)}
                        disabled={busy === 'print-' + o.id}
                        className="p-1.5 rounded hover:bg-slate-100 text-slate-500"
                        title="Imprimir CAFE"
                      >
                        {busy === 'print-' + o.id ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                      </button>
                    </div>
                  ))}
                </div>
              </details>
            )}
          </>
        )}
      </div>
    </div>
  );
}

function Stat({ icon, tone, label, value }: { icon: React.ReactNode; tone: string; label: string; value: number }) {
  const tones: Record<string, string> = {
    emerald: 'bg-emerald-50 text-emerald-600',
    blue: 'bg-blue-50 text-blue-600',
    red: 'bg-red-50 text-red-600',
    amber: 'bg-amber-50 text-amber-600',
  };
  return (
    <div className="rounded-lg border border-slate-100 p-3">
      <div className={`inline-flex items-center gap-1 px-1.5 py-0.5 rounded ${tones[tone]} text-xs font-medium mb-1`}>
        {icon} {label}
      </div>
      <p className="text-xl font-bold text-slate-800">{value}</p>
    </div>
  );
}

function Row({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between">
      <span className="text-slate-500">{label}</span>
      <span className="text-slate-700">{value}</span>
    </div>
  );
}
