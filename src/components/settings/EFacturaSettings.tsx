import React, { useEffect, useState } from 'react';
import { Loader2, Save, FileText, ShieldCheck } from 'lucide-react';
import { supabase } from '../../lib/supabase';
import { useTenant } from '../../hooks/useTenant';

// Settings panel for the Panama E-Factura (DGI / efacturapty) integration.
// The API key is write-only from the UI: we never render the stored value,
// only whether one is configured, and we only send a new key when the user
// types one.

interface ConfigForm {
  environment: 'test' | 'prod';
  punto_facturacion: string;
  default_cpbs_code: string;
  default_cpbs_code_short: string;
  enabled: boolean;
}

export default function EFacturaSettings() {
  const { company, stores, activeStore } = useTenant();
  const companyId = company?.id;
  const [storeId, setStoreId] = useState<string | undefined>(activeStore?.id || stores[0]?.id);

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [hasKey, setHasKey] = useState(false);
  const [apiKey, setApiKey] = useState('');
  const [form, setForm] = useState<ConfigForm>({
    environment: 'test',
    punto_facturacion: '001',
    default_cpbs_code: '',
    default_cpbs_code_short: '',
    enabled: false,
  });

  const blankForm: ConfigForm = {
    environment: 'test',
    punto_facturacion: '001',
    default_cpbs_code: '',
    default_cpbs_code_short: '',
    enabled: false,
  };

  useEffect(() => {
    if (!storeId || !companyId) return;
    let active = true;
    (async () => {
      setLoading(true);
      setHasKey(false);
      // Per-store config; fall back to the company-level row if the store_id
      // column doesn't exist yet (pre per-store migration).
      let { data, error } = await supabase
        .from('company_efactura_config')
        .select('*')
        .eq('store_id', storeId)
        .maybeSingle();
      if (error) {
        ({ data } = await supabase
          .from('company_efactura_config')
          .select('*')
          .eq('company_id', companyId)
          .maybeSingle());
      }
      if (!active) return;
      if (data) {
        setHasKey(!!data.api_key);
        setForm({
          environment: data.environment || 'test',
          punto_facturacion: data.punto_facturacion || '001',
          default_cpbs_code: data.default_cpbs_code?.toString() || '',
          default_cpbs_code_short: data.default_cpbs_code_short?.toString() || '',
          enabled: !!data.enabled,
        });
      } else {
        setForm(blankForm);
      }
      setLoading(false);
    })();
    return () => {
      active = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [storeId, companyId]);

  const handleSave = async () => {
    if (!storeId || !companyId) return;
    if (form.enabled && !hasKey && !apiKey.trim()) {
      alert('Ingresa la API key de efacturapty antes de activar la facturación.');
      return;
    }
    setSaving(true);
    try {
      const payload: Record<string, unknown> = {
        store_id: storeId,
        company_id: companyId,
        environment: form.environment,
        punto_facturacion: form.punto_facturacion.trim() || '001',
        default_cpbs_code: form.default_cpbs_code ? Number(form.default_cpbs_code) : null,
        default_cpbs_code_short: form.default_cpbs_code_short
          ? Number(form.default_cpbs_code_short)
          : null,
        enabled: form.enabled,
        updated_at: new Date().toISOString(),
      };
      if (apiKey.trim()) payload.api_key = apiKey.trim();

      const { error } = await supabase
        .from('company_efactura_config')
        .upsert(payload, { onConflict: 'store_id' });
      if (error) throw error;

      if (apiKey.trim()) {
        setHasKey(true);
        setApiKey('');
      }
      alert('Configuración de facturación electrónica guardada.');
    } catch (err) {
      alert('Error al guardar: ' + (err as Error).message);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center min-h-[300px]">
        <Loader2 className="w-8 h-8 animate-spin text-primary-500" />
      </div>
    );
  }

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800 flex items-center gap-2">
            <FileText className="w-5 h-5 text-primary-500" />
            Facturación Electrónica
          </h2>
          <p className="text-sm text-slate-500">
            Emite facturas electrónicas autorizadas por la DGI a través de efacturapty.
          </p>
        </div>
        <button onClick={handleSave} disabled={saving} className="btn-primary">
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          {saving ? 'Guardando...' : 'Guardar'}
        </button>
      </div>

      <div className="space-y-5 max-w-xl">
        {/* Store selector — each store is its own DGI punto de facturación */}
        {stores.length > 1 && (
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Tienda / Sucursal</label>
            <select
              value={storeId || ''}
              onChange={(e) => setStoreId(e.target.value)}
              className="input w-full"
            >
              {stores.map((s) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>
            <p className="text-xs text-slate-400 mt-1">
              Cada sucursal es su propio punto de facturación ante la DGI. Configúralo por tienda.
            </p>
          </div>
        )}

        {/* Enable */}
        <label className="flex items-start gap-3 cursor-pointer">
          <input
            type="checkbox"
            checked={form.enabled}
            onChange={(e) => setForm({ ...form, enabled: e.target.checked })}
            className="mt-1 w-4 h-4 rounded border-slate-300 text-primary-600"
          />
          <div>
            <p className="text-sm font-medium text-slate-700">Activar emisión automática</p>
            <p className="text-xs text-slate-400">
              Cada orden pagada se emite automáticamente como factura electrónica.
            </p>
          </div>
        </label>

        {/* API key */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">API Key (efacturapty)</label>
          <input
            type="password"
            value={apiKey}
            onChange={(e) => setApiKey(e.target.value)}
            placeholder={hasKey ? '•••••••••• (configurada)' : 'Pega tu API key'}
            className="input w-full font-mono text-sm"
            autoComplete="off"
          />
          {hasKey && (
            <p className="text-xs text-emerald-600 mt-1 flex items-center gap-1">
              <ShieldCheck className="w-3 h-3" /> API key configurada. Déjalo en blanco para
              mantener la actual.
            </p>
          )}
        </div>

        {/* Environment */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">Ambiente</label>
          <select
            value={form.environment}
            onChange={(e) => setForm({ ...form, environment: e.target.value as 'test' | 'prod' })}
            className="input w-full"
          >
            <option value="test">Pruebas (sin valor fiscal)</option>
            <option value="prod">Producción (fiscal)</option>
          </select>
        </div>

        {/* Punto de facturación */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">Punto de Facturación</label>
          <input
            type="text"
            value={form.punto_facturacion}
            onChange={(e) => setForm({ ...form, punto_facturacion: e.target.value })}
            maxLength={3}
            className="input w-32"
          />
        </div>

        {/* CPBS codes */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Código CPBS (servicio)
            </label>
            <input
              type="number"
              value={form.default_cpbs_code}
              onChange={(e) => setForm({ ...form, default_cpbs_code: e.target.value })}
              placeholder="Ej. 8111"
              className="input w-full"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Código CPBS abreviado
            </label>
            <input
              type="number"
              value={form.default_cpbs_code_short}
              onChange={(e) => setForm({ ...form, default_cpbs_code_short: e.target.value })}
              placeholder="Ej. 81"
              className="input w-full"
            />
          </div>
        </div>

        <p className="text-xs text-slate-400">
          El RUC, DV y los datos del emisor se toman automáticamente de tu cuenta en el PAC. La
          numeración de documentos la asigna el PAC.
        </p>
      </div>
    </div>
  );
}
