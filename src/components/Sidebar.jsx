import React from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { 
  X, Plus, ClipboardList, BarChart3, RefreshCw, 
  Users, FileText, Package, Settings, LogOut
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';

function Sidebar({ isOpen, onClose }) {
  const { state } = useApp();
  const { user, appUser, signOut } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  const handleLogout = async () => {
    onClose(); // Close sidebar immediately
    try {
      await signOut();
      navigate('/login', { replace: true });
    } catch (err) {
      console.error('Logout error:', err);
      // Force navigation even on error
      navigate('/login', { replace: true });
    }
  };

  // Get user display info
  const displayName = appUser?.full_name || user?.email?.split('@')[0] || 'Usuario';
  const displayRole = appUser?.role || 'usuario';
  const initials = appUser?.initials || displayName.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase();
  const isAdmin = appUser?.role === 'admin';

  const roleLabels = {
    admin: 'Administrador',
    supervisor: 'Supervisor',
    operator: 'Operador',
  };
  
  const menuSections = [
    {
      title: 'Operaciones',
      items: [
        { path: '/', label: 'Nueva Orden', icon: Plus },
        { path: '/orders', label: 'Órdenes', icon: ClipboardList },
        { path: '/analytics', label: 'Dashboard', icon: BarChart3, badge: '📊' },
        { path: '/reports', label: 'Reportes', icon: FileText },
        { path: '/machines', label: 'Máquinas / En Proceso', icon: RefreshCw },
        { path: '/customers', label: 'Clientes', icon: Users },
        { path: '/invoices', label: 'Facturas', icon: FileText },
      ],
    },
  ];

  // Only show settings section for admins
  if (isAdmin) {
    menuSections.push({
      title: 'Configuración',
      items: [
        { path: '/settings', label: 'Configuración', icon: Settings },
      ],
    });
  }
  
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
        <nav className="p-4 overflow-y-auto scrollbar-thin" style={{ maxHeight: 'calc(100vh - 180px)' }}>
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
          <div className="flex items-center gap-3 mb-3">
            <div className="w-10 h-10 bg-primary-500 text-white rounded-full flex items-center justify-center font-semibold">
              {initials}
            </div>
            <div className="flex-1 min-w-0">
              <p className="font-medium text-slate-800 text-sm truncate">
                {displayName}
              </p>
              <p className="text-xs text-slate-500">
                {roleLabels[displayRole] || displayRole}
              </p>
            </div>
          </div>
          <button 
            onClick={handleLogout}
            className="w-full flex items-center justify-center gap-2 px-4 py-2 text-sm text-error-600 hover:bg-error-50 rounded-lg transition-colors"
          >
            <LogOut className="w-4 h-4" />
            <span>Cerrar Sesión</span>
          </button>
        </div>
      </aside>
    </>
  );
}

export default Sidebar;
