import React, { useEffect, useState } from 'react';
import { MessageCircle, Loader2, Check, Send, Info } from 'lucide-react';
import { useTenant } from '../../hooks/useTenant';
import { supabase } from '../../lib/supabase';
import { sendWhatsApp } from '../../lib/whatsapp/client';

/**
 * WhatsApp (Meta Cloud API) settings. Cheapest path: connect a Meta app's phone
 * number id + access token directly (no BSP). The token is a secret — saved to
 * company_whatsapp (admin RLS) and only read server-side when sending.
 */
function WhatsAppSettings() {
  const { company } = useTenant();
  const companyId = company?.id;

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [hasToken, setHasToken] = useState(false);
  const [form, setForm] = useState({
    enabled: false,
    phone_number_id: '',
    access_token: '',
    waba_id: '',
    default_country_code: '507',
  });
  const [testTo, setTestTo] = useState('');
  const [testing, setTesting] = useState(false);
  const [testMsg, setTestMsg] = useState(null);

  useEffect(() => {
    if (!companyId) return;
    let alive = true;
    (async () => {
      const { data } = await supabase.from('company_whatsapp').select('*').eq('company_id', companyId).maybeSingle();
      if (!alive) return;
      if (data) {
        setForm({
          enabled: data.enabled,
          phone_number_id: data.phone_number_id || '',
          access_token: '', // never prefill the secret
          waba_id: data.waba_id || '',
          default_country_code: data.default_country_code || '507',
        });
        setHasToken(!!data.access_token);
      }
      setLoading(false);
    })();
    return () => { alive = false; };
  }, [companyId]);

  const set = (k, v) => setForm((f) => ({ ...f, [k]: v }));

  const save = async () => {
    if (!companyId) return;
    setSaving(true);
    try {
      const row = {
        company_id: companyId,
        enabled: form.enabled,
        phone_number_id: form.phone_number_id.trim() || null,
        waba_id: form.waba_id.trim() || null,
        default_country_code: form.default_country_code.trim() || '507',
        updated_at: new Date().toISOString(),
      };
      // Only overwrite the token when a new one is entered.
      if (form.access_token.trim()) row.access_token = form.access_token.trim();
      const { error } = await supabase.from('company_whatsapp').upsert(row, { onConflict: 'company_id' });
      if (error) throw error;
      if (form.access_token.trim()) setHasToken(true);
      setForm((f) => ({ ...f, access_token: '' }));
    } catch (e) {
      alert('Error al guardar: ' + e.message);
    } finally {
      setSaving(false);
    }
  };

  const sendTest = async () => {
    if (!testTo.trim()) return;
    setTesting(true);
    setTestMsg(null);
    try {
      // hello_world is Meta's default-approved template — works to any recipient.
      await sendWhatsApp({ to: testTo.trim(), template: 'hello_world', language_code: 'en_US' });
      setTestMsg({ ok: true, text: 'Mensaje de prueba enviado (plantilla hello_world).' });
    } catch (e) {
      setTestMsg({ ok: false, text: e.message });
    } finally {
      setTesting(false);
    }
  };

  if (loading) return <div className="text-sm text-slate-400">Cargando…</div>;

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h2 className="text-xl font-bold text-slate-800 flex items-center gap-2">
          <MessageCircle className="w-5 h-5 text-emerald-500" /> WhatsApp
        </h2>
        <p className="text-sm text-slate-500">Notificaciones por WhatsApp vía Meta Cloud API (sin intermediarios).</p>
      </div>

      <div className="bg-blue-50 border border-blue-200 rounded-xl p-3 mb-5 flex gap-2 text-sm text-blue-800">
        <Info className="w-4 h-4 flex-shrink-0 mt-0.5" />
        <div>
          En Meta for Developers crea una app con el producto <b>WhatsApp</b>. Copia el <b>Identificador del número de teléfono</b> (phone number id) y un <b>token de acceso</b>. Para pruebas, usa el número de prueba de Meta y agrega tu celular como destinatario de prueba.
        </div>
      </div>

      <div className="space-y-4 bg-white rounded-xl border border-slate-100 p-5">
        <label className="flex items-center gap-3 cursor-pointer">
          <input type="checkbox" checked={form.enabled} onChange={(e) => set('enabled', e.target.checked)} className="sr-only peer" />
          <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-emerald-300 rounded-full peer peer-checked:after:translate-x-full after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-emerald-500 relative"></div>
          <span className="text-sm font-medium text-slate-700">Activar notificaciones por WhatsApp</span>
        </label>

        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">Phone Number ID</label>
          <input value={form.phone_number_id} onChange={(e) => set('phone_number_id', e.target.value)} className="input" placeholder="Ej. 123456789012345" />
        </div>

        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Access Token {hasToken && <span className="text-xs text-emerald-600">(guardado)</span>}
          </label>
          <input type="password" value={form.access_token} onChange={(e) => set('access_token', e.target.value)} className="input" placeholder={hasToken ? '•••••••• (deja en blanco para conservar)' : 'Token de acceso de Meta'} />
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Código de país por defecto</label>
            <input value={form.default_country_code} onChange={(e) => set('default_country_code', e.target.value)} className="input" placeholder="507" />
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">WABA ID <span className="text-xs text-slate-400">(opcional)</span></label>
            <input value={form.waba_id} onChange={(e) => set('waba_id', e.target.value)} className="input" placeholder="—" />
          </div>
        </div>

        <div className="flex justify-end">
          <button onClick={save} disabled={saving} className="btn-primary disabled:opacity-50">
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Check className="w-4 h-4" />} Guardar
          </button>
        </div>
      </div>

      <div className="mt-5 bg-white rounded-xl border border-slate-100 p-5">
        <h3 className="font-semibold text-slate-800 mb-1">Enviar prueba</h3>
        <p className="text-sm text-slate-500 mb-3">Envía la plantilla <code>hello_world</code> a un número (debe ser un destinatario de prueba si usas el número de prueba de Meta).</p>
        <div className="flex gap-2">
          <input value={testTo} onChange={(e) => setTestTo(e.target.value)} className="input" placeholder="Ej. 50761234567" />
          <button onClick={sendTest} disabled={testing || !testTo.trim()} className="btn-secondary whitespace-nowrap disabled:opacity-50">
            {testing ? <Loader2 className="w-4 h-4 animate-spin" /> : <Send className="w-4 h-4" />} Enviar
          </button>
        </div>
        {testMsg && (
          <p className={`mt-2 text-sm ${testMsg.ok ? 'text-emerald-600' : 'text-rose-600'}`}>{testMsg.text}</p>
        )}
      </div>
    </div>
  );
}

export default WhatsAppSettings;
