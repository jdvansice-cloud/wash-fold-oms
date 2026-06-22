import React, { useEffect, useState } from 'react';
import { Plus, Wrench, Loader2, X, Droplets, Wind, AlertTriangle, Check, Trash2, Edit2 } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { useAuth } from '../../context/AuthContext';
import {
  fetchMachines,
  createMachine,
  updateMachine,
  deleteMachine,
  logMaintenance,
  cyclesSinceService,
  maintenanceDue,
} from '../../hooks/queries/useMachines';

const typeLabel = { washer: 'Lavadora', dryer: 'Secadora' };

function MachinesSettings() {
  const { state } = useApp();
  const { appUser } = useAuth();
  const storeId = state.store?.id;
  const [machines, setMachines] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(null); // machine | {} (new) | null
  const [servicing, setServicing] = useState(null);

  const load = async () => {
    if (!storeId) return;
    setLoading(true);
    try {
      setMachines(await fetchMachines(storeId));
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => { load(); }, [storeId]);

  const grouped = {
    washer: machines.filter((m) => m.machine_type === 'washer' && m.is_active),
    dryer: machines.filter((m) => m.machine_type === 'dryer' && m.is_active),
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-xl font-bold text-slate-800">Máquinas</h2>
          <p className="text-sm text-slate-500">Inventario de lavadoras y secadoras, ciclos y mantenimiento.</p>
        </div>
        <button onClick={() => setEditing({})} className="btn-primary">
          <Plus className="w-4 h-4" /> Nueva máquina
        </button>
      </div>

      {loading ? (
        <div className="text-sm text-slate-400">Cargando…</div>
      ) : machines.filter((m) => m.is_active).length === 0 ? (
        <div className="bg-white rounded-xl border border-slate-100 p-10 text-center text-slate-400">
          Aún no hay máquinas. Crea una lavadora o secadora para empezar a registrar ciclos.
        </div>
      ) : (
        <div className="space-y-6">
          {['washer', 'dryer'].map((type) =>
            grouped[type].length === 0 ? null : (
              <div key={type}>
                <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center gap-2">
                  {type === 'washer' ? <Droplets className="w-4 h-4" /> : <Wind className="w-4 h-4" />}
                  {typeLabel[type]}s
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {grouped[type].map((m) => {
                    const since = cyclesSinceService(m);
                    const due = maintenanceDue(m);
                    return (
                      <div key={m.id} className={`bg-white rounded-xl border p-4 ${due ? 'border-amber-300' : 'border-slate-100'} shadow-sm`}>
                        <div className="flex items-start justify-between">
                          <div>
                            <p className="font-semibold text-slate-800">{m.name}</p>
                            <p className="text-xs text-slate-400">{typeLabel[m.machine_type]}</p>
                          </div>
                          <div className="flex items-center gap-1">
                            <button onClick={() => setEditing(m)} className="p-1.5 text-slate-400 hover:bg-slate-100 rounded-lg" title="Editar">
                              <Edit2 className="w-4 h-4" />
                            </button>
                            <button onClick={async () => { if (window.confirm(`¿Desactivar ${m.name}?`)) { await deleteMachine(m.id); load(); } }} className="p-1.5 text-slate-400 hover:bg-rose-50 hover:text-rose-500 rounded-lg" title="Desactivar">
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </div>
                        </div>

                        <div className="mt-3 grid grid-cols-3 gap-2 text-center">
                          <div className="bg-slate-50 rounded-lg py-2">
                            <p className="text-lg font-bold text-slate-800">{m.cycle_count}</p>
                            <p className="text-[11px] text-slate-400">ciclos total</p>
                          </div>
                          <div className="bg-slate-50 rounded-lg py-2">
                            <p className={`text-lg font-bold ${due ? 'text-amber-600' : 'text-slate-800'}`}>{since}</p>
                            <p className="text-[11px] text-slate-400">desde servicio</p>
                          </div>
                          <div className="bg-slate-50 rounded-lg py-2">
                            <p className="text-lg font-bold text-slate-800">{m.maintenance_interval || '—'}</p>
                            <p className="text-[11px] text-slate-400">cada (ciclos)</p>
                          </div>
                        </div>

                        {due && (
                          <div className="mt-2 flex items-center gap-1 text-xs text-amber-700">
                            <AlertTriangle className="w-3.5 h-3.5" /> Mantenimiento pendiente
                          </div>
                        )}

                        <button
                          onClick={() => setServicing(m)}
                          className="btn-secondary w-full mt-3 text-sm"
                        >
                          <Wrench className="w-4 h-4" /> Registrar mantenimiento
                        </button>
                      </div>
                    );
                  })}
                </div>
              </div>
            ),
          )}
        </div>
      )}

      {editing && (
        <MachineModal
          machine={editing.id ? editing : null}
          storeId={storeId}
          onClose={() => setEditing(null)}
          onSaved={() => { setEditing(null); load(); }}
        />
      )}
      {servicing && (
        <MaintenanceModal
          machine={servicing}
          userId={appUser?.id}
          onClose={() => setServicing(null)}
          onLogged={() => { setServicing(null); load(); }}
        />
      )}
    </div>
  );
}

function MachineModal({ machine, storeId, onClose, onSaved }) {
  const isEdit = !!machine;
  const [name, setName] = useState(machine?.name || '');
  const [type, setType] = useState(machine?.machine_type || 'washer');
  const [interval, setIntervalCycles] = useState(machine?.maintenance_interval ?? '');
  const [saving, setSaving] = useState(false);

  const save = async () => {
    if (!name.trim()) return;
    setSaving(true);
    try {
      const mi = interval === '' ? null : Math.max(1, parseInt(interval, 10));
      if (isEdit) {
        await updateMachine(machine.id, { name: name.trim(), machine_type: type, maintenance_interval: mi });
      } else {
        await createMachine({ store_id: storeId, name: name.trim(), machine_type: type, maintenance_interval: mi });
      }
      onSaved();
    } catch (e) {
      alert('Error al guardar: ' + e.message);
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between border-b border-slate-100 p-4">
          <h2 className="text-lg font-semibold text-slate-800">{isEdit ? 'Editar máquina' : 'Nueva máquina'}</h2>
          <button onClick={onClose} className="p-2 text-slate-400 hover:bg-slate-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>
        <div className="p-5 space-y-4">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Nombre</label>
            <input value={name} onChange={(e) => setName(e.target.value)} className="input" placeholder="Lavadora 1" />
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Tipo</label>
            <div className="grid grid-cols-2 gap-2">
              {['washer', 'dryer'].map((t) => (
                <button key={t} onClick={() => setType(t)} className={`rounded-lg border-2 py-2 text-sm font-medium ${type === t ? 'border-primary-500 bg-primary-50 text-primary-700' : 'border-slate-200 text-slate-600'}`}>
                  {typeLabel[t]}
                </button>
              ))}
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Mantenimiento cada (ciclos)</label>
            <input type="number" min="1" value={interval} onChange={(e) => setIntervalCycles(e.target.value)} className="input" placeholder="Ej. 500 (opcional)" />
          </div>
        </div>
        <div className="flex justify-end gap-3 border-t border-slate-100 p-4">
          <button onClick={onClose} className="btn-secondary">Cancelar</button>
          <button onClick={save} disabled={saving || !name.trim()} className="btn-primary disabled:opacity-50">
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Check className="w-4 h-4" />} Guardar
          </button>
        </div>
      </div>
    </div>
  );
}

function MaintenanceModal({ machine, userId, onClose, onLogged }) {
  const [notes, setNotes] = useState('');
  const [saving, setSaving] = useState(false);
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in" onClick={(e) => e.stopPropagation()}>
        <div className="border-b border-slate-100 p-4">
          <h2 className="text-lg font-semibold text-slate-800">Registrar mantenimiento</h2>
          <p className="text-sm text-slate-500">{machine.name} · {machine.cycle_count} ciclos</p>
        </div>
        <div className="p-5">
          <label className="block text-sm font-medium text-slate-700 mb-1">Notas (opcional)</label>
          <textarea value={notes} onChange={(e) => setNotes(e.target.value)} rows={3} className="input" placeholder="Ej. Cambio de filtro, limpieza…" />
          <p className="mt-2 text-xs text-slate-400">Esto reinicia el contador de ciclos desde el último servicio.</p>
        </div>
        <div className="flex justify-end gap-3 border-t border-slate-100 p-4">
          <button onClick={onClose} className="btn-secondary">Cancelar</button>
          <button
            onClick={async () => { setSaving(true); try { await logMaintenance(machine.id, notes, userId); onLogged(); } catch (e) { alert('Error: ' + e.message); } finally { setSaving(false); } }}
            disabled={saving}
            className="btn-primary disabled:opacity-50"
          >
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Wrench className="w-4 h-4" />} Registrar
          </button>
        </div>
      </div>
    </div>
  );
}

export default MachinesSettings;
