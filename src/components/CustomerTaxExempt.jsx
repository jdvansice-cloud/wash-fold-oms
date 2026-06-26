import React, { useEffect, useRef, useState } from 'react';
import { ShieldCheck, Upload, FileText, AlertTriangle, Trash2, Loader2 } from 'lucide-react';
import { supabase } from '../lib/supabase';

const REASONS = [
  { value: 'diplomatic', label: 'Diplomático (MIRE)' },
  { value: 'public_entity', label: 'Entidad pública / gobierno' },
  { value: 'ngo', label: 'ONG / sin fines de lucro' },
  { value: 'other', label: 'Otro' },
];

/**
 * ITBMS exemption (exoneración) editor for a customer: the manual exempt flag,
 * the proof metadata the DGI requires, and uploads of the supporting credential
 * images. Document upload is only available once the customer exists (edit).
 *
 * Props:
 *  - formData: the parent modal's form state (reads tax_exempt* fields)
 *  - onChange(field, value): parent setter
 *  - customerId?: enables document upload/list when present
 *  - storeId?: stored on uploaded document rows
 */
export default function CustomerTaxExempt({ formData, onChange, customerId, storeId }) {
  const [docs, setDocs] = useState([]);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const fileRef = useRef(null);

  const exempt = !!formData.tax_exempt;

  useEffect(() => {
    if (customerId) loadDocs();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [customerId]);

  const loadDocs = async () => {
    const { data, error: err } = await supabase
      .from('customer_documents')
      .select('*')
      .eq('customer_id', customerId)
      .order('created_at', { ascending: false });
    if (!err) setDocs(data || []);
  };

  const handleUpload = async (e) => {
    const file = e.target.files?.[0];
    if (!file || !customerId) return;
    setUploading(true);
    setError(null);
    try {
      const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, '_');
      const path = `${customerId}/${Date.now()}-${safeName}`;
      const { error: upErr } = await supabase.storage
        .from('customer-documents')
        .upload(path, file, { contentType: file.type, upsert: false });
      if (upErr) throw upErr;
      const { error: insErr } = await supabase.from('customer_documents').insert({
        customer_id: customerId,
        store_id: storeId || null,
        path,
        label: file.name,
        doc_type: 'exemption_proof',
      });
      if (insErr) throw insErr;
      await loadDocs();
    } catch (err) {
      setError(err.message || 'Error al subir el documento');
    } finally {
      setUploading(false);
      if (fileRef.current) fileRef.current.value = '';
    }
  };

  const handleView = async (doc) => {
    const { data } = await supabase.storage
      .from('customer-documents')
      .createSignedUrl(doc.path, 300);
    if (data?.signedUrl) window.open(data.signedUrl, '_blank', 'noopener');
  };

  const handleDelete = async (doc) => {
    await supabase.storage.from('customer-documents').remove([doc.path]);
    await supabase.from('customer_documents').delete().eq('id', doc.id);
    await loadDocs();
  };

  const missingProof = exempt && !formData.tax_exempt_doc_number && docs.length === 0;

  return (
    <div className="border border-slate-200 rounded-xl p-3 space-y-3">
      <label className="flex items-center gap-2 cursor-pointer">
        <input
          type="checkbox"
          checked={exempt}
          onChange={(e) => onChange('tax_exempt', e.target.checked)}
          className="w-4 h-4"
        />
        <ShieldCheck className="w-4 h-4 text-emerald-600" />
        <span className="text-sm font-medium text-slate-700">Exonerado de ITBMS</span>
      </label>

      {exempt && (
        <div className="space-y-3 pt-1">
          {missingProof && (
            <div className="flex items-center gap-2 p-2 bg-amber-50 border border-amber-200 rounded-lg">
              <AlertTriangle className="w-4 h-4 text-amber-500 shrink-0" />
              <p className="text-xs text-amber-700">
                Registra el número de oficio o sube el documento de exoneración como respaldo.
              </p>
            </div>
          )}

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Tipo</label>
              <select
                value={formData.tax_exempt_reason || ''}
                onChange={(e) => onChange('tax_exempt_reason', e.target.value)}
                className="input"
              >
                <option value="">—</option>
                {REASONS.map((r) => (
                  <option key={r.value} value={r.value}>{r.label}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Autoridad emisora</label>
              <input
                type="text"
                value={formData.tax_exempt_authority || ''}
                onChange={(e) => onChange('tax_exempt_authority', e.target.value)}
                className="input"
                placeholder="MIRE / MEF / DGI"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-600 mb-1">
              Nº de oficio / resolución / nota de exoneración
            </label>
            <input
              type="text"
              value={formData.tax_exempt_doc_number || ''}
              onChange={(e) => onChange('tax_exempt_doc_number', e.target.value)}
              className="input"
              placeholder="Ej. Oficio Nº 1234-2026"
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Emitido</label>
              <input
                type="date"
                value={formData.tax_exempt_issued_at || ''}
                onChange={(e) => onChange('tax_exempt_issued_at', e.target.value)}
                className="input"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Vence</label>
              <input
                type="date"
                value={formData.tax_exempt_expires_at || ''}
                onChange={(e) => onChange('tax_exempt_expires_at', e.target.value)}
                className="input"
              />
            </div>
          </div>

          {/* Document uploads */}
          <div>
            <label className="block text-xs font-medium text-slate-600 mb-1">
              Documentos de respaldo
            </label>
            {customerId ? (
              <>
                <div className="flex items-center gap-2">
                  <input
                    ref={fileRef}
                    type="file"
                    accept="image/*,application/pdf"
                    onChange={handleUpload}
                    className="hidden"
                    id="customer-doc-upload"
                  />
                  <label
                    htmlFor="customer-doc-upload"
                    className="inline-flex items-center gap-2 px-3 py-2 bg-slate-100 hover:bg-slate-200 rounded-lg text-sm cursor-pointer"
                  >
                    {uploading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Upload className="w-4 h-4" />}
                    Subir documento
                  </label>
                </div>
                {error && <p className="text-xs text-red-600 mt-1">{error}</p>}
                <ul className="mt-2 space-y-1">
                  {docs.map((doc) => (
                    <li key={doc.id} className="flex items-center justify-between text-sm bg-slate-50 rounded-lg px-2 py-1">
                      <button onClick={() => handleView(doc)} className="flex items-center gap-2 text-slate-700 hover:text-primary-600 truncate">
                        <FileText className="w-4 h-4 shrink-0" />
                        <span className="truncate">{doc.label || doc.path}</span>
                      </button>
                      <button onClick={() => handleDelete(doc)} className="p-1 text-slate-400 hover:text-red-500">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </li>
                  ))}
                </ul>
              </>
            ) : (
              <p className="text-xs text-slate-400">
                Guarda el cliente primero para adjuntar documentos.
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
