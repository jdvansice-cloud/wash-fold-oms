import React, { useEffect, useState } from 'react';
import { TrendingUp, Package, CreditCard, Building2 } from 'lucide-react';
import { supabase } from '../../lib/supabase';

const fmt = (n) => `B/${(Number(n) || 0).toFixed(2)}`;
const dayLabel = (d) =>
  new Date(`${d}T00:00:00`).toLocaleDateString('es-PA', { day: '2-digit', month: 'short' });

const methodColor = (m) => {
  const s = (m || '').toLowerCase();
  if (s.includes('efectivo') || s.includes('cash')) return 'bg-emerald-500';
  if (s.includes('tarjeta') || s.includes('card')) return 'bg-blue-500';
  if (s.includes('yappy')) return 'bg-purple-500';
  if (s.includes('ach')) return 'bg-slate-500';
  return 'bg-indigo-400';
};

/**
 * Owner cockpit: DB-aggregated revenue trend, top services, payment mix and B2B
 * receivables for the selected range — accurate over full history (the client
 * only holds recent orders in memory).
 */
function AnalyticsCockpit({ storeId, startDate, endDate }) {
  const [daily, setDaily] = useState([]);
  const [services, setServices] = useState([]);
  const [mix, setMix] = useState([]);
  const [receivables, setReceivables] = useState({ total: 0, count: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!storeId || !startDate || !endDate) return;
    let alive = true;
    setLoading(true);
    const p_start = startDate.toISOString();
    const p_end = endDate.toISOString();
    (async () => {
      try {
        const [rev, top, pay, ar] = await Promise.all([
          supabase.rpc('analytics_daily_revenue', { p_store: storeId, p_start, p_end }),
          supabase.rpc('analytics_top_services', { p_store: storeId, p_start, p_end, p_limit: 5 }),
          supabase.rpc('analytics_payment_mix', { p_store: storeId, p_start, p_end }),
          supabase
            .from('orders')
            .select('total')
            .eq('store_id', storeId)
            .eq('billing_type', 'account')
            .eq('payment_status', 'unpaid'),
        ]);
        if (!alive) return;
        setDaily(rev.data || []);
        setServices(top.data || []);
        setMix((pay.data || []).filter((m) => Math.abs(Number(m.amount)) > 0));
        const arRows = ar.data || [];
        setReceivables({
          total: arRows.reduce((s, o) => s + Math.abs(Number(o.total) || 0), 0),
          count: arRows.length,
        });
      } catch (e) {
        console.error('Analytics cockpit error:', e);
      } finally {
        if (alive) setLoading(false);
      }
    })();
    return () => { alive = false; };
  }, [storeId, startDate, endDate]);

  const maxRev = Math.max(1, ...daily.map((d) => Number(d.revenue) || 0));
  const maxSvc = Math.max(1, ...services.map((s) => Number(s.revenue) || 0));
  const mixTotal = mix.reduce((s, m) => s + Math.abs(Number(m.amount) || 0), 0);

  const Card = ({ icon: Icon, title, children, accent = 'text-primary-500' }) => (
    <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
      <div className="px-5 py-4 border-b border-slate-100 flex items-center gap-2">
        <Icon className={`w-5 h-5 ${accent}`} />
        <h3 className="font-semibold text-slate-800">{title}</h3>
      </div>
      <div className="p-5">{children}</div>
    </div>
  );

  if (loading) {
    return <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-6 text-sm text-slate-400">Cargando panel…</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      {/* Revenue trend */}
      <Card icon={TrendingUp} title="Tendencia de ventas" accent="text-emerald-500">
        {daily.length === 0 ? (
          <p className="text-sm text-slate-400 text-center py-6">Sin ventas en el período.</p>
        ) : (
          <div className="flex items-end gap-1 h-40">
            {daily.map((d) => (
              <div key={d.day} className="flex-1 flex flex-col items-center justify-end group" title={`${dayLabel(d.day)}: ${fmt(d.revenue)} · ${d.orders} órdenes`}>
                <span className="text-[10px] text-slate-500 mb-1 opacity-0 group-hover:opacity-100 whitespace-nowrap">{fmt(d.revenue)}</span>
                <div
                  className="w-full rounded-t bg-emerald-400 hover:bg-emerald-500 transition-colors"
                  style={{ height: `${Math.max(2, (Number(d.revenue) / maxRev) * 100)}%` }}
                />
                <span className="text-[10px] text-slate-400 mt-1 truncate w-full text-center">{dayLabel(d.day).split(' ')[0]}</span>
              </div>
            ))}
          </div>
        )}
      </Card>

      {/* B2B receivables + top services side */}
      <Card icon={Building2} title="Cuentas por cobrar B2B" accent="text-indigo-500">
        <div className="flex items-baseline gap-2">
          <span className="text-3xl font-bold text-indigo-600">{fmt(receivables.total)}</span>
          <span className="text-sm text-slate-500">en {receivables.count} orden(es) a crédito</span>
        </div>
        <p className="mt-2 text-xs text-slate-400">Órdenes B2B entregadas a crédito, aún sin facturar/cobrar.</p>
      </Card>

      {/* Top services */}
      <Card icon={Package} title="Servicios más vendidos" accent="text-primary-500">
        {services.length === 0 ? (
          <p className="text-sm text-slate-400 text-center py-4">Sin datos.</p>
        ) : (
          <div className="space-y-3">
            {services.map((s) => (
              <div key={s.product_name}>
                <div className="flex items-center justify-between text-sm mb-1">
                  <span className="font-medium text-slate-700 truncate">{s.product_name}</span>
                  <span className="text-slate-500 whitespace-nowrap">{fmt(s.revenue)}</span>
                </div>
                <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                  <div className="h-full bg-primary-400" style={{ width: `${(Number(s.revenue) / maxSvc) * 100}%` }} />
                </div>
              </div>
            ))}
          </div>
        )}
      </Card>

      {/* Payment mix */}
      <Card icon={CreditCard} title="Mezcla de pagos" accent="text-blue-500">
        {mix.length === 0 ? (
          <p className="text-sm text-slate-400 text-center py-4">Sin cobros en el período.</p>
        ) : (
          <div className="space-y-3">
            {mix.map((m) => {
              const pct = mixTotal > 0 ? (Math.abs(Number(m.amount)) / mixTotal) * 100 : 0;
              return (
                <div key={m.method}>
                  <div className="flex items-center justify-between text-sm mb-1">
                    <span className="font-medium text-slate-700">{m.method}</span>
                    <span className="text-slate-500">{fmt(m.amount)} · {pct.toFixed(0)}%</span>
                  </div>
                  <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div className={`h-full ${methodColor(m.method)}`} style={{ width: `${pct}%` }} />
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </Card>
    </div>
  );
}

export default AnalyticsCockpit;
