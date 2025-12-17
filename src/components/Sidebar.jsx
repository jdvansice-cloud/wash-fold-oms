import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  X, Plus, ClipboardList, BarChart3, RefreshCw, 
  Users, FileText, Package, Settings 
} from 'lucide-react';
import { useApp } from '../context/AppContext';

function Sidebar({ isOpen, onClose }) {
  const { state } = useApp();
  const location = useLocation();
  
  const menuSections = [
    {
      title: 'Operaciones',
      items: [
        { path: '/', label: 'Nueva Orden', icon: Plus },
        { path: '/orders', label: 'Órdenes', icon: ClipboardList },
        { path: '/analytics', label: 'Analíticas', icon: BarChart3, badge: '📊' },
        { path: '/machines', label: 'Máquinas / En Proceso', icon: RefreshCw },
        { path: '/customers', label: 'Clientes', icon: Users },
        { path: '/invoices', label: 'Facturas', icon: FileText },
      ],
    },
    {
      title: 'Configuración',
      items: [
        { path: '/products', label: 'Productos', icon: Package },
        { path: '/settings', label: 'Configuración', icon: Settings },
      ],
    },
  ];
  
  return (
    <>
      {/* Overlay */}
      {isOpen && (
        <div 
          className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 animate-fade-in"
          onClick={onClose}
        />
      )}
      
      {/* Sidebar */}
      <aside 
        className={`fixed top-0 left-0 h-full w-72 bg-white z-50 shadow-elevated transform transition-transform duration-300 ease-out ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* Header */}
        <div className="p-4 border-b border-slate-100 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="text-xl">✨</span>
            <span className="font-display font-bold text-slate-800">AMERICAN</span>
            <span className="font-display font-light text-slate-500">LAUNDRY</span>
          </div>
          <button 
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Navigation */}
        <nav className="p-4 overflow-y-auto scrollbar-thin" style={{ maxHeight: 'calc(100vh - 140px)' }}>
          {menuSections.map((section, sectionIndex) => (
            <div key={sectionIndex} className={sectionIndex > 0 ? 'mt-6' : ''}>
              <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 px-4">
                {section.title}
              </p>
              
              {section.items.map((item) => {
                const isActive = location.pathname === item.path;
                const Icon = item.icon;
                
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    onClick={onClose}
                    className={`sidebar-link ${isActive ? 'active' : ''}`}
                  >
                    <Icon className="w-5 h-5" />
                    <span className="flex-1">{item.label}</span>
                    {item.badge && <span>{item.badge}</span>}
                  </Link>
                );
              })}
            </div>
          ))}
        </nav>
        
        {/* User Info */}
        <div className="absolute bottom-0 left-0 right-0 p-4 border-t border-slate-100 bg-white">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-primary-500 text-white rounded-full flex items-center justify-center font-semibold">
              {state.user.initials}
            </div>
            <div className="flex-1 min-w-0">
              <p className="font-medium text-slate-800 text-sm truncate">
                {state.user.full_name}
              </p>
              <p className="text-xs text-slate-500 capitalize">
                {state.user.role}
              </p>
            </div>
          </div>
        </div>
      </aside>
    </>
  );
}

export default Sidebar;
