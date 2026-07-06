import React, { useState, useRef, useEffect } from 'react';
import { X, PackagePlus, AlertTriangle } from 'lucide-react';

/**
 * Ad-hoc "generic sale" for a product that isn't in the catalog: the cashier
 * enters a description, the FINAL sale price, and whether it carries ITBMS.
 * The line is stored with product_id = NULL, which is what the EOD's
 * "Ventas genéricas (supervisión)" section reports on — usage is visible to
 * the admin by design.
 */
export default function GenericItemModal({ itbmsRate = 7, onConfirm, onClose }) {
  const [description, setDescription] = useState('');
  const [price, setPrice] = useState('');
  const [isTaxable, setIsTaxable] = useState(true);
  const [error, setError] = useState(null);
  const inputRef = useRef(null);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  const parsedPrice = parseFloat(price);
  const canSubmit = description.trim().length >= 3 && parsedPrice > 0;

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!canSubmit) {
      setError(
        description.trim().length < 3
          ? 'Escriba una descripción (mínimo 3 letras).'
          : 'Ingrese un precio de venta válido.'
      );
      return;
    }
    onConfirm({
      description: description.trim(),
      salePrice: Math.round(parsedPrice * 100) / 100,
      isTaxable,
    });
  };

  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in" onClick={onClose}>
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <PackagePlus className="w-5 h-5 text-primary-500" />
            <h2 className="text-lg font-semibold text-slate-800">Venta genérica</h2>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg">
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-4 space-y-4">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Descripción <span className="text-error-500">*</span>
            </label>
            <input
              ref={inputRef}
              type="text"
              value={description}
              onChange={(e) => { setDescription(e.target.value); setError(null); }}
              className="input"
              placeholder="¿Qué se está vendiendo?"
              maxLength={80}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Precio de venta <span className="text-error-500">*</span>
            </label>
            <div className="relative">
              <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">B/</span>
              <input
                type="number"
                step="0.01"
                min="0"
                value={price}
                onChange={(e) => { setPrice(e.target.value); setError(null); }}
                className="input pl-9"
                placeholder="0.00"
              />
            </div>
            <p className="text-xs text-slate-400 mt-1">
              Precio final que paga el cliente{isTaxable ? ` (incluye ITBMS ${itbmsRate}%)` : ''}.
            </p>
          </div>

          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl cursor-pointer">
            <input
              type="checkbox"
              checked={isTaxable}
              onChange={(e) => setIsTaxable(e.target.checked)}
              className="w-4 h-4 text-primary-600 rounded focus:ring-primary-500"
            />
            <span className="text-sm text-slate-700">
              Cobra ITBMS ({itbmsRate}%)
              <span className="block text-xs text-slate-400">Desmarque solo para productos exentos.</span>
            </span>
          </label>

          {error && (
            <div className="flex items-center gap-2 p-3 bg-red-50 border border-red-200 rounded-xl">
              <AlertTriangle size={14} className="text-red-500 shrink-0" />
              <p className="text-sm text-red-700">{error}</p>
            </div>
          )}

          <p className="text-[11px] text-slate-400">
            Las ventas genéricas se listan en el Cierre del Día para revisión del administrador.
          </p>

          <div className="flex gap-3">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">Cancelar</button>
            <button
              type="submit"
              disabled={!canSubmit}
              className={`btn-primary flex-1 ${!canSubmit ? 'opacity-50 cursor-not-allowed' : ''}`}
            >
              Agregar al ticket
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
