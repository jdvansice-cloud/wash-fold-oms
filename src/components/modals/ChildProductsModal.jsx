import React from 'react';
import { X } from 'lucide-react';

function ChildProductsModal({ parentProduct, childProducts, onClose, onSelect }) {
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <div className="flex items-center gap-3">
            <span className="text-2xl">{parentProduct.icon}</span>
            <h2 className="text-lg font-semibold text-slate-800">{parentProduct.name}</h2>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Child Options */}
        <div className="p-4 space-y-2">
          <p className="text-sm text-slate-500 mb-3">Selecciona una opción:</p>
          
          {childProducts.map((child, index) => (
            <button
              key={child.id}
              onClick={() => onSelect(child)}
              className="w-full flex items-center justify-between p-4 bg-slate-50 hover:bg-slate-100 rounded-xl transition-colors group"
              style={{ animationDelay: `${index * 50}ms` }}
            >
              <span className="font-medium text-slate-700 group-hover:text-primary-600 transition-colors">
                {child.name}
              </span>
              <span className="font-semibold text-primary-600">
                {formatCurrency(child.price)}
              </span>
            </button>
          ))}
        </div>
        
        {/* Cancel */}
        <div className="p-4 border-t border-slate-100">
          <button
            onClick={onClose}
            className="w-full btn-secondary"
          >
            Cancelar
          </button>
        </div>
      </div>
    </div>
  );
}

export default ChildProductsModal;
