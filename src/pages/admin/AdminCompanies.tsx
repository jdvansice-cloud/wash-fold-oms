import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Search, Building2, ExternalLink, ChevronRight } from 'lucide-react';
import { supabaseStaff as supabase } from '../../lib/supabase';

interface CompanyRow {
  id: string;
  name: string;
  legal_name: string | null;
  slug: string;
  phone: string | null;
  created_at: string;
  stores: { id: string }[];
  subscriptions: { plan: string; status: string }[];
}

export default function AdminCompanies() {
  const [companies, setCompanies] = useState<CompanyRow[]>([]);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadCompanies();
  }, []);

  async function loadCompanies() {
    try {
      const { data, error } = await supabase
        .from('companies')
        .select('id, name, legal_name, slug, phone, created_at, stores(id), subscriptions(plan, status)')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setCompanies(data || []);
    } catch (err) {
      console.error('Error loading companies:', err);
    } finally {
      setLoading(false);
    }
  }

  const filtered = companies.filter((c) => {
    const q = search.toLowerCase();
    return (
      c.name.toLowerCase().includes(q) ||
      (c.legal_name || '').toLowerCase().includes(q) ||
      c.slug.toLowerCase().includes(q)
    );
  });

  const statusColors: Record<string, string> = {
    active: 'bg-emerald-100 text-emerald-700',
    trialing: 'bg-blue-100 text-blue-700',
    past_due: 'bg-amber-100 text-amber-700',
    canceled: 'bg-red-100 text-red-700',
    incomplete: 'bg-slate-100 text-slate-600',
  };

  const planColors: Record<string, string> = {
    starter: 'bg-slate-100 text-slate-700',
    pro: 'bg-blue-100 text-blue-700',
    enterprise: 'bg-violet-100 text-violet-700',
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Empresas</h1>
          <p className="text-sm text-slate-500 mt-1">{companies.length} organizaciones registradas</p>
        </div>
      </div>

      {/* Search */}
      <div className="relative max-w-md">
        <Search size={18} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
        <input
          type="text"
          placeholder="Buscar por nombre, razon social o slug..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-full pl-10 pr-4 py-2.5 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-slate-900/10"
        />
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
        {loading ? (
          <div className="flex justify-center py-16">
            <div className="w-8 h-8 border-4 border-slate-200 border-t-slate-800 rounded-full animate-spin" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-16 text-slate-400">
            <Building2 size={40} className="mx-auto mb-3 opacity-50" />
            <p className="font-medium">No se encontraron empresas</p>
          </div>
        ) : (
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-slate-100 bg-slate-50">
                <th className="text-left px-5 py-3 font-medium text-slate-500">Empresa</th>
                <th className="text-left px-5 py-3 font-medium text-slate-500">Slug</th>
                <th className="text-center px-5 py-3 font-medium text-slate-500">Tiendas</th>
                <th className="text-center px-5 py-3 font-medium text-slate-500">Plan</th>
                <th className="text-center px-5 py-3 font-medium text-slate-500">Estado</th>
                <th className="text-left px-5 py-3 font-medium text-slate-500">Registro</th>
                <th className="w-10"></th>
              </tr>
            </thead>
            <tbody>
              {filtered.map((c) => {
                const sub = c.subscriptions?.[0];
                return (
                  <tr key={c.id} className="border-b border-slate-50 hover:bg-slate-50 transition-colors">
                    <td className="px-5 py-3">
                      <div>
                        <p className="font-medium text-slate-800">{c.name}</p>
                        {c.legal_name && (
                          <p className="text-xs text-slate-400">{c.legal_name}</p>
                        )}
                      </div>
                    </td>
                    <td className="px-5 py-3">
                      <code className="text-xs bg-slate-100 px-2 py-1 rounded">{c.slug}</code>
                    </td>
                    <td className="px-5 py-3 text-center">{c.stores?.length || 0}</td>
                    <td className="px-5 py-3 text-center">
                      {sub ? (
                        <span className={`inline-block px-2 py-0.5 rounded-full text-xs font-medium capitalize ${planColors[sub.plan] || 'bg-slate-100'}`}>
                          {sub.plan}
                        </span>
                      ) : (
                        <span className="text-xs text-slate-400">—</span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-center">
                      {sub ? (
                        <span className={`inline-block px-2 py-0.5 rounded-full text-xs font-medium ${statusColors[sub.status] || 'bg-slate-100'}`}>
                          {sub.status}
                        </span>
                      ) : (
                        <span className="text-xs text-slate-400">—</span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-slate-500 text-xs">
                      {new Date(c.created_at).toLocaleDateString('es-PA')}
                    </td>
                    <td className="px-3 py-3">
                      <Link
                        to={`/admin/companies/${c.id}`}
                        className="p-1.5 hover:bg-slate-200 rounded-lg transition-colors inline-flex"
                      >
                        <ChevronRight size={16} className="text-slate-400" />
                      </Link>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}
