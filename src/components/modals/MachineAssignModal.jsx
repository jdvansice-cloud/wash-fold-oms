import React, { useEffect, useState } from 'react';
import { X, Wrench, Loader2, AlertTriangle } from 'lucide-react';
import { fetchActiveMachines } from '../../hooks/queries/useMachines';

const typeLabel = { washer: 'Lavadora', dryer: 'Secadora' };

/**
 * Asked before payment when the ticket has Lavamático (machine) lines: pick the
 * physical washer/dryer each line will use. The cycles are recorded against the
 * chosen machine once the order is created.
 */
function MachineAssignModal({ storeId, machineItems, onClose, onConfirm }) {
  const [machines, setMachines] = useState([]);
  const [loading, setLoading] = useState(true);
  const [assign, setAssign] = useState({}); // idx -> machineId

  useEffect(() => {
    let alive = true;
    (async () => {
      try {
        const ms = await fetchActiveMachines(storeId);
        if (alive) setMachines(ms);
      } catch (e) {
        console.error(e);
      } finally {
        if (alive) setLoading(false);
      }
    })();
    return () => { alive = false; };
  }, [storeId]);

  const machinesOfType = (t) => machines.filter((m) => m.machine_type === t);
  const allAssigned = machineItems.every((x) => assign[x.idx]);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between border-b border-slate-100 p-4">
          <h2 className="text-lg font-semibold text-slate-800 flex items-center gap-2">
            <Wrench className="w-5 h-5 text-primary-500" /> Asignar máquinas
          </h2>
          <button onClick={onClose} className="p-2 text-slate-400 hover:bg-slate-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>

        <div className="p-5 space-y-4 max-h-[60vh] overflow-y-auto">
          {loading ? (
            <p className="text-sm text-slate-400">Cargando máquinas…</p>
          ) : (
            machineItems.map(({ it, idx }) => {
              const type = it.product.machine_type;
              const options = machinesOfType(type);
              return (
                <div key={idx}>
                  <label className="block text-sm font-medium text-slate-700 mb-1">
                    {it.product.name}
                    {it.quantity > 1 ? <span className="text-slate-400"> × {it.quantity}</span> : null}
                    <span className="ml-2 text-xs text-slate-400">({typeLabel[type]})</span>
                  </label>
                  {options.length === 0 ? (
                    <div className="flex items-center gap-2 text-xs text-amber-600 bg-amber-50 rounded-lg px-3 py-2">
                      <AlertTriangle className="w-4 h-4" /> No hay {typeLabel[type].toLowerCase()}s activas. Créalas en Configuración → Máquinas.
                    </div>
                  ) : (
                    <select
                      value={assign[idx] || ''}
                      onChange={(e) => setAssign((a) => ({ ...a, [idx]: e.target.value }))}
                      className="input"
                    >
                      <option value="">Selecciona una máquina…</option>
                      {options.map((m) => (
                        <option key={m.id} value={m.id}>{m.name}</option>
                      ))}
                    </select>
                  )}
                </div>
              );
            })
          )}
        </div>

        <div className="flex justify-end gap-3 border-t border-slate-100 p-4">
          <button onClick={onClose} className="btn-secondary">Cancelar</button>
          <button
            onClick={() => onConfirm(assign)}
            disabled={!allAssigned}
            className="btn-primary disabled:opacity-50"
            title={!allAssigned ? 'Asigna una máquina a cada línea' : undefined}
          >
            Continuar al pago
          </button>
        </div>
      </div>
    </div>
  );
}

export default MachineAssignModal;
