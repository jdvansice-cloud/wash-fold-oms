import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import {
  ArrowLeft, Building2, Store, Users, CreditCard, ExternalLink,
  Save, Loader2, MapPin, Mail, Phone, Calendar
} from 'lucide-react';
import { supabaseStaff as supabase } from '../../lib/supabase';

interface Company {
  id: string;
  name: string;
  legal_name: string | null;
  slug: string;
  ruc: string | null;
  dv: string | null;
  address: string | null;
  phone: string | null;
  created_at: string;
}

interface StoreSummary {
  id: string;
  name: string;
  address: string | null;
  is_active: boolean;
}

interface UserSummary {
  id: string;
  full_name: string;
  email: string;
  role: string;
  is_active: boolean;
}

interface Subscription {
  id: string;
  plan: string;
  status: string;
  current_period_start: string | null;
  current_period_end: string | null;
}

export default function AdminCompanyDetail() {
  const { companyId } = useParams<{ companyId: string }>();
  const navigate = useNavigate();
  const [company, setCompany] = useState<Company | null>(null);
  const [stores, setStores] = useState<StoreSummary[]>([]);
  const [users, setUsers] = useState<UserSummary[]>([]);
  const [subscription, setSubscription] = useState<Subscription | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [editPlan, setEditPlan] = useState('');

  useEffect(() => {
    if (companyId) loadCompany();
  }, [companyId]);

  async function loadCompany() {
    try {
      const [compRes, storesRes, usersRes, subRes] = await Promise.all([
        supabase.from('companies').select('*').eq('id', companyId).single(),
        supabase.from('stores').select('id, name, address, is_active').eq('company_id', companyId),
        supabase.from('users').select('id, full_name, email, role, is_active').eq('company_id', companyId),
        supabase.from('subscriptions').select('*').eq('company_id', companyId).order('created_at', { ascending: false }).limit(1),
      ]);

      if (compRes.error) throw compRes.error;
      setCompany(compRes.data);
      setStores(storesRes.data || []);
      setUsers(usersRes.data || []);
      const sub = subRes.data?.[0] || null;
      setSubscription(sub);
      setEditPlan(sub?.plan || 'starter');
    } catch (err) {
      console.error('Error loading company:', err);
    } finally {
      setLoading(false);
    }
  }

  async function handlePlanChange() {
    if (!subscription || editPlan === subscription.plan) return;
    setSaving(true);
    try {
      const { error } = await supabase
        .from('subscriptions')
        .update({ plan: editPlan, updated_at: new Date().toISOString() })
        .eq('id', subscription.id);
      if (error) throw error;
      setSubscription({ ...subscription, plan: editPlan });
      alert('Plan actualizado');
    } catch (err) {
      console.error('Error updating plan:', err);
      alert('Error al actualizar plan');
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="w-8 h-8 border-4 border-slate-200 border-t-slate-800 rounded-full animate-spin" />
      </div>
    );
  }

  if (!company) {
    return (
      <div className="text-center py-20">
        <p className="text-slate-500">Empresa no encontrada</p>
        <Link to="/admin/companies" className="text-blue-600 text-sm mt-2 inline-block">Volver</Link>
      </div>
    );
  }

  const roleLabels: Record<string, string> = { admin: 'Admin', supervisor: 'Supervisor', operator: 'Operador' };
  const statusColors: Record<string, string> = {
    active: 'bg-emerald-100 text-emerald-700',
    trialing: 'bg-blue-100 text-blue-700',
    past_due: 'bg-amber-100 text-amber-700',
    canceled: 'bg-red-100 text-red-700',
  };

  return (
    <div className="space-y-6 max-w-4xl">
      {/* Back + Title */}
      <div className="flex items-center gap-3">
        <button onClick={() => navigate('/admin/companies')} className="p-2 hover:bg-slate-200 rounded-lg">
          <ArrowLeft size={18} className="text-slate-600" />
        </button>
        <div>
          <h1 className="text-xl font-bold text-slate-900">{company.name}</h1>
          {company.legal_name && (
            <p className="text-sm text-slate-500">{company.legal_name}</p>
          )}
        </div>
        <a
          href={`/app/${company.slug}/login`}
          target="_blank"
          rel="noreferrer"
          className="ml-auto flex items-center gap-1.5 text-sm text-blue-600 hover:text-blue-800"
        >
          <ExternalLink size={14} />
          Ir al sitio
        </a>
      </div>

      {/* Company Info */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <Building2 size={18} />
          Informacion General
        </h2>
        <div className="grid sm:grid-cols-2 gap-4 text-sm">
          <div>
            <p className="text-slate-400 text-xs mb-1">Nombre Comercial</p>
            <p className="text-slate-700 font-medium">{company.name}</p>
          </div>
          <div>
            <p className="text-slate-400 text-xs mb-1">Razon Social</p>
            <p className="text-slate-700">{company.legal_name || '—'}</p>
          </div>
          <div>
            <p className="text-slate-400 text-xs mb-1">RUC / DV</p>
            <p className="text-slate-700">{company.ruc ? `${company.ruc}-${company.dv || ''}` : '—'}</p>
          </div>
          <div>
            <p className="text-slate-400 text-xs mb-1">Slug</p>
            <code className="text-xs bg-slate-100 px-2 py-1 rounded">{company.slug}</code>
          </div>
          <div>
            <p className="text-slate-400 text-xs mb-1">Telefono</p>
            <p className="text-slate-700">{company.phone || '—'}</p>
          </div>
          <div>
            <p className="text-slate-400 text-xs mb-1">Registro</p>
            <p className="text-slate-700">{new Date(company.created_at).toLocaleDateString('es-PA')}</p>
          </div>
        </div>
      </div>

      {/* Subscription */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <CreditCard size={18} />
          Suscripcion
        </h2>
        {subscription ? (
          <div className="space-y-4">
            <div className="flex items-center gap-3">
              <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${statusColors[subscription.status] || 'bg-slate-100'}`}>
                {subscription.status}
              </span>
              {subscription.current_period_end && (
                <span className="text-xs text-slate-400">
                  Vence: {new Date(subscription.current_period_end).toLocaleDateString('es-PA')}
                </span>
              )}
            </div>
            <div className="flex items-end gap-3">
              <div>
                <label className="text-xs text-slate-500 mb-1 block">Plan</label>
                <select
                  value={editPlan}
                  onChange={(e) => setEditPlan(e.target.value)}
                  className="border border-slate-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-slate-900/10"
                >
                  <option value="starter">Starter</option>
                  <option value="pro">Pro</option>
                  <option value="enterprise">Enterprise</option>
                </select>
              </div>
              {editPlan !== subscription.plan && (
                <button
                  onClick={handlePlanChange}
                  disabled={saving}
                  className="flex items-center gap-2 px-4 py-2 bg-slate-900 text-white rounded-lg text-sm font-medium hover:bg-slate-800 disabled:opacity-50"
                >
                  {saving ? <Loader2 size={14} className="animate-spin" /> : <Save size={14} />}
                  Guardar
                </button>
              )}
            </div>
          </div>
        ) : (
          <p className="text-sm text-slate-400">Sin suscripcion activa</p>
        )}
      </div>

      {/* Stores */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <Store size={18} />
          Tiendas ({stores.length})
        </h2>
        {stores.length === 0 ? (
          <p className="text-sm text-slate-400">Sin tiendas configuradas</p>
        ) : (
          <div className="space-y-2">
            {stores.map((s) => (
              <div key={s.id} className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                <MapPin size={16} className="text-slate-400" />
                <div className="flex-1">
                  <p className="text-sm font-medium text-slate-700">{s.name}</p>
                  {s.address && <p className="text-xs text-slate-400">{s.address}</p>}
                </div>
                <span className={`text-xs px-2 py-0.5 rounded-full ${s.is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-200 text-slate-500'}`}>
                  {s.is_active ? 'Activa' : 'Inactiva'}
                </span>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Users */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <h2 className="text-base font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <Users size={18} />
          Usuarios Staff ({users.length})
        </h2>
        {users.length === 0 ? (
          <p className="text-sm text-slate-400">Sin usuarios</p>
        ) : (
          <div className="space-y-2">
            {users.map((u) => (
              <div key={u.id} className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                <div className="w-8 h-8 bg-slate-300 rounded-full flex items-center justify-center text-xs font-bold text-white">
                  {u.full_name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()}
                </div>
                <div className="flex-1">
                  <p className="text-sm font-medium text-slate-700">{u.full_name}</p>
                  <p className="text-xs text-slate-400">{u.email}</p>
                </div>
                <span className="text-xs bg-slate-200 text-slate-600 px-2 py-0.5 rounded-full">
                  {roleLabels[u.role] || u.role}
                </span>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
