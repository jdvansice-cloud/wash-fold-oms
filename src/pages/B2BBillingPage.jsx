import React, { useEffect, useMemo, useState } from 'react';
import { Building2, FileText, Check, Loader2, Printer, X, ChevronRight, CreditCard } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';
import PaymentModal from '../components/modals/PaymentModal';
import {
  fetchB2BCustomersWithOutstanding,
  fetchOutstandingOrders,
  fetchB2BInvoices,
  fetchInvoiceOrders,
  generateB2BInvoice,
  settleB2BInvoice,
  orderDisplayNumber,
} from '../hooks/queries/useB2BBilling';

const fmt = (n) => `B/${(Number(n) || 0).toFixed(2)}`;
const fmtDate = (iso) => (iso ? new Date(iso).toLocaleDateString('es-PA', { day: '2-digit', month: 'short', year: 'numeric' }) : '');

function B2BBillingPage() {
  const { state } = useApp();
  const { appUser } = useAuth();
  const storeId = state.store?.id;

  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState(null); // customer summary
  const [orders, setOrders] = useState([]);
  const [checked, setChecked] = useState(() => new Set());
  const [invoices, setInvoices] = useState([]);
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [generating, setGenerating] = useState(false);
  const [viewInvoice, setViewInvoice] = useState(null);
  const [payingInvoice, setPayingInvoice] = useState(null);

  const loadCustomers = async () => {
    if (!storeId) return;
    setLoading(true);
    try {
      setCustomers(await fetchB2BCustomersWithOutstanding(storeId));
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadCustomers();
  }, [storeId]);

  const selectCustomer = async (c) => {
    setSelected(c);
    setLoadingDetail(true);
    try {
      const [outstanding, invs] = await Promise.all([
        fetchOutstandingOrders(c.customer_id),
        fetchB2BInvoices(c.customer_id),
      ]);
      setOrders(outstanding);
      setChecked(new Set(outstanding.map((o) => o.id))); // default: all selected
      setInvoices(invs);
    } catch (e) {
      console.error(e);
    } finally {
      setLoadingDetail(false);
    }
  };

  const toggle = (id) =>
    setChecked((prev) => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });

  const selectedOrders = orders.filter((o) => checked.has(o.id));
  const selectedTotal = useMemo(
    () => selectedOrders.reduce((s, o) => s + Math.abs(o.total || 0), 0),
    [selectedOrders],
  );

  const handleGenerate = async () => {
    if (!selectedOrders.length) return;
    setGenerating(true);
    try {
      await generateB2BInvoice({
        storeId,
        customerId: selected.customer_id,
        orderIds: selectedOrders.map((o) => o.id),
        createdBy: appUser?.id || null,
      });
      await selectCustomer(selected); // refresh outstanding + invoices
      await loadCustomers(); // refresh left list (balance changed)
    } catch (e) {
      alert('Error al generar la factura: ' + e.message);
    } finally {
      setGenerating(false);
    }
  };

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      <div className="flex items-center gap-2 mb-6">
        <Building2 className="w-6 h-6 text-indigo-500" />
        <div>
          <h1 className="text-2xl font-bold text-slate-800">Facturación B2B</h1>
          <p className="text-sm text-slate-500">Consolida las órdenes a crédito de cada cliente en una factura.</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Customers with outstanding credit orders */}
        <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
          <div className="px-5 py-4 border-b border-slate-100">
            <h2 className="font-semibold text-slate-800">Clientes con saldo</h2>
          </div>
          {loading ? (
            <div className="p-5 text-sm text-slate-400">Cargando…</div>
          ) : customers.length === 0 ? (
            <div className="p-8 text-center text-sm text-slate-400">
              No hay órdenes a crédito pendientes de facturar.
            </div>
          ) : (
            <div className="divide-y divide-slate-50">
              {customers.map((c) => (
                <button
                  key={c.customer_id}
                  onClick={() => selectCustomer(c)}
                  className={`w-full flex items-center justify-between px-5 py-3 text-left hover:bg-slate-50 ${
                    selected?.customer_id === c.customer_id ? 'bg-indigo-50' : ''
                  }`}
                >
                  <div className="min-w-0">
                    <p className="font-medium text-slate-700 truncate">{c.name}</p>
                    <p className="text-xs text-slate-400">
                      {c.order_count > 0 && `${c.order_count} sin facturar`}
                      {c.order_count > 0 && c.open_invoice_count > 0 && ' · '}
                      {c.open_invoice_count > 0 && `${c.open_invoice_count} factura(s) por cobrar`}
                    </p>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="font-semibold text-indigo-600">{fmt(c.balance)}</span>
                    <ChevronRight className="w-4 h-4 text-slate-300" />
                  </div>
                </button>
              ))}
            </div>
          )}
        </div>

        {/* Detail: outstanding orders + invoices */}
        <div className="lg:col-span-2 space-y-6">
          {!selected ? (
            <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-10 text-center text-slate-400">
              Selecciona un cliente para ver sus órdenes a crédito.
            </div>
          ) : (
            <>
              {/* Generate invoice from outstanding orders */}
              <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
                <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
                  <h2 className="font-semibold text-slate-800">{selected.name} — órdenes a crédito</h2>
                  <span className="text-sm text-slate-500">{orders.length} pendiente(s)</span>
                </div>
                {loadingDetail ? (
                  <div className="p-5 text-sm text-slate-400">Cargando…</div>
                ) : orders.length === 0 ? (
                  <div className="p-6 text-center text-sm text-slate-400">Sin órdenes pendientes de facturar.</div>
                ) : (
                  <>
                    <div className="divide-y divide-slate-50 max-h-80 overflow-y-auto">
                      {orders.map((o) => (
                        <label key={o.id} className="flex items-center gap-3 px-5 py-2.5 cursor-pointer hover:bg-slate-50">
                          <input
                            type="checkbox"
                            checked={checked.has(o.id)}
                            onChange={() => toggle(o.id)}
                            className="w-4 h-4 rounded border-slate-300 text-indigo-600 focus:ring-indigo-500"
                          />
                          <span className="flex-1 font-medium text-slate-700">{orderDisplayNumber(o)}</span>
                          <span className="text-xs text-slate-400">{fmtDate(o.created_at)}</span>
                          <span className="w-20 text-right font-semibold text-slate-700">{fmt(o.total)}</span>
                        </label>
                      ))}
                    </div>
                    <div className="flex items-center justify-between px-5 py-4 border-t border-slate-100 bg-slate-50">
                      <span className="text-sm text-slate-600">
                        {selectedOrders.length} seleccionada(s) · <span className="font-semibold text-slate-800">{fmt(selectedTotal)}</span>
                      </span>
                      <button
                        onClick={handleGenerate}
                        disabled={!selectedOrders.length || generating}
                        className="btn-primary disabled:opacity-50"
                      >
                        {generating ? <Loader2 className="w-4 h-4 animate-spin" /> : <FileText className="w-4 h-4" />}
                        Generar factura
                      </button>
                    </div>
                  </>
                )}
              </div>

              {/* Existing invoices */}
              <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
                <div className="px-5 py-4 border-b border-slate-100">
                  <h2 className="font-semibold text-slate-800">Facturas</h2>
                </div>
                {invoices.length === 0 ? (
                  <div className="p-6 text-center text-sm text-slate-400">Aún no hay facturas para este cliente.</div>
                ) : (
                  <div className="divide-y divide-slate-50">
                    {invoices.map((inv) => (
                      <button
                        key={inv.id}
                        onClick={() => setViewInvoice(inv)}
                        className="w-full flex items-center justify-between px-5 py-3 text-left hover:bg-slate-50"
                      >
                        <div>
                          <p className="font-medium text-slate-700">Factura #{inv.invoice_number}</p>
                          <p className="text-xs text-slate-400">{fmtDate(inv.created_at)}</p>
                        </div>
                        <div className="flex items-center gap-3">
                          <span className={`badge ${inv.status === 'paid' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700'}`}>
                            {inv.status === 'paid' ? 'Pagada' : 'Pendiente'}
                          </span>
                          <span className="font-semibold text-slate-700">{fmt(inv.total)}</span>
                        </div>
                      </button>
                    ))}
                  </div>
                )}
              </div>
            </>
          )}
        </div>
      </div>

      {viewInvoice && (
        <InvoiceModal
          invoice={viewInvoice}
          customer={selected}
          onClose={() => setViewInvoice(null)}
          onPay={() => setPayingInvoice(viewInvoice)}
        />
      )}

      {/* Pay the invoice through the regular payment screen, restricted to
          cash/card/ACH/Yappy (no pickup, credit, gift card or loyalty). */}
      {payingInvoice && (
        <PaymentModal
          total={payingInvoice.total}
          subtotal={payingInvoice.subtotal}
          taxAmount={payingInvoice.tax_amount}
          paymentMethods={(state.paymentMethods || []).filter((m) => m.is_active)}
          storeId={storeId}
          allowPickup={false}
          allowGiftCard={false}
          onClose={() => setPayingInvoice(null)}
          onComplete={async (paymentInfo) => {
            try {
              await settleB2BInvoice(payingInvoice.id, paymentInfo.payments);
              setPayingInvoice(null);
              setViewInvoice((v) => (v ? { ...v, status: 'paid', paid_at: new Date().toISOString() } : v));
              await selectCustomer(selected);
              await loadCustomers();
            } catch (e) {
              alert('Error al cobrar la factura: ' + e.message);
            }
          }}
        />
      )}
    </div>
  );
}

// Invoice / estado de cuenta — line items are the orders.
function InvoiceModal({ invoice, customer, onClose, onPay }) {
  const [lines, setLines] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    (async () => {
      setLoading(true);
      try {
        setLines(await fetchInvoiceOrders(invoice.id));
      } finally {
        setLoading(false);
      }
    })();
  }, [invoice.id]);

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center pt-12 px-4 pb-4 print:p-0" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50 print:hidden" />
      <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[calc(100vh-4rem)] flex flex-col print:max-w-none print:shadow-none" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between border-b border-slate-100 p-4 print:hidden">
          <h2 className="text-lg font-semibold text-slate-800">Factura #{invoice.invoice_number}</h2>
          <button onClick={onClose} className="rounded-lg p-2 text-slate-400 hover:bg-slate-100">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="flex-1 overflow-y-auto p-5" id="b2b-statement">
          <div className="mb-4">
            <p className="text-sm text-slate-500">Estado de cuenta</p>
            <p className="text-lg font-bold text-slate-800">{customer?.name}</p>
            <p className="text-xs text-slate-400">Factura #{invoice.invoice_number} · {fmtDate(invoice.created_at)}</p>
          </div>

          {loading ? (
            <p className="text-sm text-slate-400">Cargando…</p>
          ) : (
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-[11px] uppercase tracking-wide text-slate-400 border-b border-slate-100">
                  <th className="py-2">Orden</th>
                  <th className="py-2">Fecha</th>
                  <th className="py-2 text-right">Monto</th>
                </tr>
              </thead>
              <tbody>
                {lines.map((o) => (
                  <tr key={o.id} className="border-b border-slate-50">
                    <td className="py-2 font-medium text-slate-700">{orderDisplayNumber(o)}</td>
                    <td className="py-2 text-slate-500">{fmtDate(o.created_at)}</td>
                    <td className="py-2 text-right text-slate-700">{fmt(o.total)}</td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr>
                  <td colSpan={2} className="pt-3 text-right text-slate-500">Subtotal</td>
                  <td className="pt-3 text-right text-slate-700">{fmt(invoice.subtotal)}</td>
                </tr>
                <tr>
                  <td colSpan={2} className="text-right text-slate-500">ITBMS</td>
                  <td className="text-right text-slate-700">{fmt(invoice.tax_amount)}</td>
                </tr>
                <tr>
                  <td colSpan={2} className="pt-1 text-right font-bold text-slate-800">Total</td>
                  <td className="pt-1 text-right font-bold text-indigo-600">{fmt(invoice.total)}</td>
                </tr>
              </tfoot>
            </table>
          )}
        </div>

        <div className="flex items-center justify-between gap-3 border-t border-slate-100 p-4 print:hidden">
          <button onClick={() => window.print()} className="btn-secondary">
            <Printer className="w-4 h-4" /> Imprimir
          </button>
          {invoice.status === 'paid' ? (
            <span className="inline-flex items-center gap-1 text-sm font-medium text-emerald-600">
              <Check className="w-4 h-4" /> Pagada {invoice.paid_at ? `· ${fmtDate(invoice.paid_at)}` : ''}
            </span>
          ) : (
            <button onClick={onPay} className="btn-primary">
              <CreditCard className="w-4 h-4" /> Cobrar {fmt(invoice.total)}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

export default B2BBillingPage;
