import React, { useState } from 'react';
import { X, Scale, Plus, Trash2, Droplets, Package } from 'lucide-react';

function WeightEntryModal({ product, isExpress, onClose, onSubmit }) {
  const [entries, setEntries] = useState([]);
  const [currentEntry, setCurrentEntry] = useState({
    weight: '',
    pieces: '',
    notes: '',
    wetWeight: false,
  });
  
  const price = isExpress ? (product.express_price || product.price) : product.price;
  
  const totalWeight = entries.reduce((sum, e) => sum + e.weight, 0);
  const totalPrice = totalWeight * price;
  
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  const handleAddEntry = () => {
    const weight = parseFloat(currentEntry.weight);
    if (!weight || weight <= 0) return;
    
    const newEntry = {
      weight,
      pieces: parseInt(currentEntry.pieces) || 0,
      notes: currentEntry.notes,
      wetWeight: currentEntry.wetWeight,
    };
    
    setEntries([...entries, newEntry]);
    setCurrentEntry({ weight: '', pieces: '', notes: '', wetWeight: false });
  };
  
  const handleRemoveEntry = (index) => {
    setEntries(entries.filter((_, i) => i !== index));
  };
  
  const handleSubmit = () => {
    if (entries.length === 0) {
      // If no entries but valid current entry, add it first
      const weight = parseFloat(currentEntry.weight);
      if (weight && weight > 0) {
        onSubmit([{
          weight,
          pieces: parseInt(currentEntry.pieces) || 0,
          notes: currentEntry.notes,
          wetWeight: currentEntry.wetWeight,
        }]);
        return;
      }
      return;
    }
    onSubmit(entries);
  };
  
  const canSubmit = entries.length > 0 || (currentEntry.weight && parseFloat(currentEntry.weight) > 0);
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-lg animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <div>
            <h2 className="text-lg font-semibold text-slate-800">Ingresar Peso</h2>
            <p className="text-sm text-slate-500">{product.name}</p>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        <div className="p-4">
          {/* Weight Input */}
          <div className="flex gap-3 mb-4">
            <div className="flex-1">
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Peso (kg)
              </label>
              <div className="relative">
                <input
                  type="number"
                  step="0.01"
                  min="0"
                  value={currentEntry.weight}
                  onChange={(e) => setCurrentEntry({ ...currentEntry, weight: e.target.value })}
                  className="input pr-12"
                  placeholder="0.00"
                  autoFocus
                />
                <span className="absolute right-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">
                  kg
                </span>
              </div>
            </div>
            
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                &nbsp;
              </label>
              <button
                onClick={() => alert('Scale integration coming soon!')}
                className="btn-secondary h-[42px]"
              >
                <Scale className="w-4 h-4" />
                Leer Balanza
              </button>
            </div>
          </div>
          
          {/* Additional Fields */}
          <div className="grid grid-cols-2 gap-3 mb-4">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Notas
              </label>
              <input
                type="text"
                value={currentEntry.notes}
                onChange={(e) => setCurrentEntry({ ...currentEntry, notes: e.target.value })}
                className="input"
                placeholder="Opcional"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Piezas
              </label>
              <input
                type="number"
                min="0"
                value={currentEntry.pieces}
                onChange={(e) => setCurrentEntry({ ...currentEntry, pieces: e.target.value })}
                className="input"
                placeholder="0"
              />
            </div>
          </div>
          
          {/* Wet Weight Toggle */}
          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl cursor-pointer mb-4">
            <input
              type="checkbox"
              checked={currentEntry.wetWeight}
              onChange={(e) => setCurrentEntry({ ...currentEntry, wetWeight: e.target.checked })}
              className="sr-only"
            />
            <div className={`w-10 h-5 rounded-full transition-colors relative ${
              currentEntry.wetWeight ? 'bg-cyan-500' : 'bg-slate-300'
            }`}>
              <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                currentEntry.wetWeight ? 'translate-x-5' : ''
              }`} />
            </div>
            <div className="flex items-center gap-2">
              <Droplets className={`w-4 h-4 ${currentEntry.wetWeight ? 'text-cyan-500' : 'text-slate-400'}`} />
              <span className={`text-sm font-medium ${currentEntry.wetWeight ? 'text-cyan-600' : 'text-slate-600'}`}>
                Peso Mojado
              </span>
            </div>
          </label>
          
          {/* Entries List */}
          {entries.length > 0 && (
            <div className="mb-4 space-y-2">
              <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">
                Bolsas Registradas
              </p>
              {entries.map((entry, index) => (
                <div 
                  key={index}
                  className="flex items-center justify-between p-3 bg-slate-50 rounded-xl"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center font-semibold text-sm">
                      {index + 1}
                    </div>
                    <div>
                      <p className="font-medium text-slate-800">{entry.weight.toFixed(2)} kg</p>
                      <p className="text-xs text-slate-500">
                        {entry.pieces > 0 && `${entry.pieces} piezas`}
                        {entry.wetWeight && ' • Mojado'}
                        {entry.notes && ` • ${entry.notes}`}
                      </p>
                    </div>
                  </div>
                  <button
                    onClick={() => handleRemoveEntry(index)}
                    className="p-2 text-slate-400 hover:text-error-500 hover:bg-error-50 rounded-lg transition-colors"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              ))}
            </div>
          )}
          
          {/* Actions */}
          <div className="flex gap-3">
            <button
              onClick={() => {
                setCurrentEntry({ weight: '', pieces: '', notes: '', wetWeight: false });
                setEntries([]);
              }}
              className="btn-secondary"
            >
              Reiniciar
            </button>
            
            <button
              onClick={handleAddEntry}
              disabled={!currentEntry.weight || parseFloat(currentEntry.weight) <= 0}
              className="btn-secondary flex-1"
            >
              <Plus className="w-4 h-4" />
              Siguiente Bolsa
            </button>
            
            <button
              onClick={handleSubmit}
              disabled={!canSubmit}
              className={`btn-success flex-1 ${!canSubmit ? 'opacity-50 cursor-not-allowed' : ''}`}
            >
              <Package className="w-4 h-4" />
              Procesar
            </button>
          </div>
          
          {/* Running Total */}
          <div className="mt-4 pt-4 border-t border-slate-100 flex items-center justify-between">
            <div className="text-sm text-slate-600">
              <span className="font-medium">{(totalWeight + (parseFloat(currentEntry.weight) || 0)).toFixed(2)} kg</span>
              <span className="text-slate-400"> total × </span>
              <span>{formatCurrency(price)}/kg</span>
            </div>
            <div className="text-xl font-bold text-primary-600">
              {formatCurrency((totalWeight + (parseFloat(currentEntry.weight) || 0)) * price)}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default WeightEntryModal;
