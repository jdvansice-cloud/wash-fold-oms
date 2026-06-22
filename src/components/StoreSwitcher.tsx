import React, { useState, useRef, useEffect } from 'react';
import { Store, ChevronDown, Check, MapPin } from 'lucide-react';
import { useTenant } from '../hooks/useTenant';

export default function StoreSwitcher() {
  const { stores, activeStore, setActiveStore } = useTenant();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Don't render if single store (hooks above must run unconditionally).
  if (!stores || stores.length <= 1) return null;

  const handleSelect = (storeId: string) => {
    setActiveStore(storeId);
    setOpen(false);
    // Reload data for new store — page will re-render via context
    window.location.reload();
  };

  return (
    <div className="relative" ref={ref}>
      <button
        onClick={() => setOpen(!open)}
        className="flex items-center gap-2 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 rounded-lg text-sm font-medium text-slate-700 transition-colors max-w-[180px]"
      >
        <Store size={14} className="text-slate-500 shrink-0" />
        <span className="truncate">{activeStore?.name || 'Tienda'}</span>
        <ChevronDown size={14} className={`text-slate-400 shrink-0 transition-transform ${open ? 'rotate-180' : ''}`} />
      </button>

      {open && (
        <div className="absolute left-0 top-full mt-1 w-64 bg-white rounded-xl shadow-elevated border border-slate-200 py-1 z-50 animate-scale-in">
          <div className="px-3 py-2 border-b border-slate-100">
            <p className="text-xs font-medium text-slate-400 uppercase tracking-wide">Cambiar tienda</p>
          </div>
          {stores.map((store) => (
            <button
              key={store.id}
              onClick={() => handleSelect(store.id)}
              className={`w-full px-3 py-2.5 text-left flex items-center gap-3 hover:bg-slate-50 transition-colors ${
                store.id === activeStore?.id ? 'bg-primary-50' : ''
              }`}
            >
              <div className={`w-8 h-8 rounded-lg flex items-center justify-center shrink-0 ${
                store.id === activeStore?.id ? 'bg-primary-500 text-white' : 'bg-slate-100 text-slate-500'
              }`}>
                <MapPin size={16} />
              </div>
              <div className="flex-1 min-w-0">
                <p className={`text-sm font-medium truncate ${
                  store.id === activeStore?.id ? 'text-primary-700' : 'text-slate-700'
                }`}>
                  {store.name}
                </p>
                {store.address && (
                  <p className="text-xs text-slate-400 truncate">{store.address}</p>
                )}
              </div>
              {store.id === activeStore?.id && (
                <Check size={16} className="text-primary-500 shrink-0" />
              )}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
