import React, { useState, useEffect } from 'react';
import { Building2, Users, Store, CreditCard, TrendingUp, AlertTriangle } from 'lucide-react';
import { supabaseStaff as supabase } from '../../lib/supabase';

interface PlatformMetrics {
  totalCompanies: number;
  activeCompanies: number;
  totalStores: number;
  totalStaffUsers: number;
  totalCustomers: number;
  planBreakdown: Record<string, number>;
  recentCompanies: Array<{ id: string; name: string; slug: string; created_at: string }>;
  pastDueSubscriptions: number;
}

export default function AdminDashboard() {
  const [metrics, setMetrics] = useState<PlatformMetrics | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadMetrics();
  }, []);

  async function loadMetrics() {
    try {
      const [companiesRes, storesRes, usersRes, customersRes, subsRes] = await Promise.all([
        supabase.from('companies').select('id, name, slug, created_at'),
        supabase.from('stores').select('id', { count: 'exact', head: true }),
        supabase.from('users').select('id', { count: 'exact', head: true }),
        supabase.from('customers').select('id', { count: 'exact', head: true }),
        supabase.from('subscriptions').select('plan, status'),
      ]);

      const companies = companiesRes.data || [];
      const subs = subsRes.data || [];

      const planBreakdown: Record<string, number> = {};
      let pastDue = 0;
      subs.forEach((s: { plan: string; status: string }) => {
        planBreakdown[s.plan] = (planBreakdown[s.plan] || 0) + 1;
        if (s.status === 'past_due') pastDue++;
      });

      setMetrics({
        totalCompanies: companies.length,
        activeCompanies: subs.filter((s: { status: string }) => s.status === 'active' || s.status === 'trialing').length,
        totalStores: storesRes.count || 0,
        totalStaffUsers: usersRes.count || 0,
        totalCustomers: customersRes.count || 0,
        planBreakdown,
        recentCompanies: companies
          .sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
          .slice(0, 5),
        pastDueSubscriptions: pastDue,
      });
    } catch (err) {
      console.error('Error loading platform metrics:', err);
    } finally {
      setLoading(false);
    }
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="w-8 h-8 border-4 border-slate-200 border-t-slate-800 rounded-full animate-spin" />
      </div>
    );
  }

  if (!metrics) return <p className="text-slate-500">Error cargando metricas</p>;

  const statCards = [
    { label: 'Empresas', value: metrics.totalCompanies, icon: Building2, color: 'bg-blue-500' },
    { label: 'Tiendas', value: metrics.totalStores, icon: Store, color: 'bg-emerald-500' },
    { label: 'Usuarios Staff', value: metrics.totalStaffUsers, icon: Users, color: 'bg-violet-500' },
    { label: 'Clientes', value: metrics.totalCustomers, icon: Users, color: 'bg-amber-500' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Dashboard de Plataforma</h1>
        <p className="text-sm text-slate-500 mt-1">Metricas generales de WashPro</p>
      </div>

      {/* Alert: Past due */}
      {metrics.pastDueSubscriptions > 0 && (
        <div className="flex items-center gap-3 p-4 bg-amber-50 border border-amber-200 rounded-xl">
          <AlertTriangle size={20} className="text-amber-600" />
          <p className="text-sm text-amber-800">
            <strong>{metrics.pastDueSubscriptions}</strong> suscripcion(es) con pago pendiente
          </p>
        </div>
      )}

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {statCards.map((card) => (
          <div key={card.label} className="bg-white rounded-xl border border-slate-200 p-5">
            <div className="flex items-center justify-between mb-3">
              <div className={`w-10 h-10 ${card.color} rounded-lg flex items-center justify-center`}>
                <card.icon size={20} className="text-white" />
              </div>
            </div>
            <p className="text-2xl font-bold text-slate-900">{card.value}</p>
            <p className="text-sm text-slate-500">{card.label}</p>
          </div>
        ))}
      </div>

      {/* Plans + Recent */}
      <div className="grid lg:grid-cols-2 gap-6">
        {/* Plan Breakdown */}
        <div className="bg-white rounded-xl border border-slate-200 p-6">
          <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
            <CreditCard size={18} />
            Distribucion por Plan
          </h2>
          <div className="space-y-3">
            {['starter', 'pro', 'enterprise'].map((plan) => {
              const count = metrics.planBreakdown[plan] || 0;
              const total = metrics.totalCompanies || 1;
              const pct = Math.round((count / total) * 100);
              const colors: Record<string, string> = {
                starter: 'bg-slate-400',
                pro: 'bg-blue-500',
                enterprise: 'bg-violet-600',
              };
              return (
                <div key={plan}>
                  <div className="flex items-center justify-between text-sm mb-1">
                    <span className="font-medium text-slate-700 capitalize">{plan}</span>
                    <span className="text-slate-500">{count} ({pct}%)</span>
                  </div>
                  <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div className={`h-full ${colors[plan]} rounded-full transition-all`} style={{ width: `${pct}%` }} />
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Recent Companies */}
        <div className="bg-white rounded-xl border border-slate-200 p-6">
          <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
            <TrendingUp size={18} />
            Empresas Recientes
          </h2>
          {metrics.recentCompanies.length === 0 ? (
            <p className="text-sm text-slate-400 text-center py-6">No hay empresas registradas</p>
          ) : (
            <div className="space-y-3">
              {metrics.recentCompanies.map((c) => (
                <div key={c.id} className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-slate-700">{c.name}</p>
                    <p className="text-xs text-slate-400">{c.slug}</p>
                  </div>
                  <p className="text-xs text-slate-400">
                    {new Date(c.created_at).toLocaleDateString('es-PA')}
                  </p>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
