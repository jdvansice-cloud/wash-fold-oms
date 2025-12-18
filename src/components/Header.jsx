import React, { useState, useRef, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  Menu, Search, Gift, User, Settings, LogOut, 
  ClipboardList, BarChart3, FileText 
} from 'lucide-react';
import { useApp } from '../context/AppContext';

function Header() {
  const { state, actions } = useApp();
  const location = useLocation();
  const [userMenuOpen, setUserMenuOpen] = useState(false);
  const userMenuRef = useRef(null);
  
  // Default user info when not logged in
  const user = state.user || {
    initials: 'U',
    full_name: 'Usuario',
    role: 'operator'
  };
  
  // Close user menu when clicking outside
  useEffect(() => {
    function handleClickOutside(event) {
      if (userMenuRef.current && !userMenuRef.current.contains(event.target)) {
        setUserMenuOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);
  
  const navLinks = [
    { path: '/', label: 'Nueva Orden', icon: null },
    { path: '/machines', label: 'En Proceso', icon: null },
    { path: '/orders', label: 'Listo', query: '?status=ready', icon: null },
    { path: '/orders', label: 'Completado', query: '?status=completed', icon: null },
  ];
  
  return (
    <header className="fixed top-0 left-0 right-0 h-16 bg-white border-b border-slate-200 z-40 shadow-sm">
      <div className="h-full flex items-center justify-between px-4">
        {/* Left: Menu + Logo */}
        <div className="flex items-center gap-4">
          <button 
            onClick={() => actions.toggleSidebar(true)}
            className="p-2 hover:bg-slate-100 rounded-xl transition-colors"
          >
            <Menu className="w-5 h-5 text-slate-600" />
          </button>
          
          <Link to="/" className="flex items-center gap-2">
            <span className="text-2xl">✨</span>
            <div className="flex items-baseline gap-1">
              <span className="font-display font-bold text-slate-800 text-lg tracking-tight">AMERICAN</span>
              <span className="font-display font-light text-slate-500 text-lg">LAUNDRY</span>
            </div>
          </Link>
        </div>
        
        {/* Center: Navigation */}
        <nav className="hidden md:flex items-center gap-1">
          {navLinks.map((link, index) => {
            const isActive = location.pathname === link.path && 
              (!link.query || location.search === link.query);
            
            return (
              <Link
                key={index}
                to={link.path + (link.query || '')}
                className={`nav-link ${isActive ? 'active' : ''}`}
              >
                {link.label}
              </Link>
            );
          })}
        </nav>
        
        {/* Right: Actions */}
        <div className="flex items-center gap-2">
          {/* Gift Card Button */}
          <button className="flex items-center gap-2 px-3 py-2 bg-purple-50 hover:bg-purple-100 text-purple-700 rounded-xl text-sm font-medium transition-colors">
            <Gift className="w-4 h-4" />
            <span className="hidden lg:inline">Gift Card</span>
          </button>
          
          {/* Search Button */}
          <button className="p-2 hover:bg-slate-100 rounded-xl transition-colors hidden md:flex">
            <Search className="w-5 h-5 text-slate-600" />
          </button>
          
          {/* User Menu */}
          <div className="relative" ref={userMenuRef}>
            <button
              onClick={() => setUserMenuOpen(!userMenuOpen)}
              className="w-9 h-9 bg-primary-500 text-white rounded-full flex items-center justify-center font-semibold text-sm hover:bg-primary-600 transition-colors"
            >
              {user.initials}
            </button>
            
            {/* Dropdown */}
            {userMenuOpen && (
              <div className="absolute right-0 top-12 w-72 bg-white rounded-2xl shadow-elevated border border-slate-200 py-2 animate-scale-in">
                {/* User Info */}
                <div className="px-4 py-3 border-b border-slate-100">
                  <p className="font-semibold text-slate-800">{user.full_name}</p>
                  <p className="text-xs text-slate-500 capitalize">{user.role}</p>
                </div>
                
                {/* Menu Items */}
                <div className="py-1">
                  <Link 
                    to="/closing"
                    className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    onClick={() => setUserMenuOpen(false)}
                  >
                    <span className="text-lg">📊</span>
                    <div>
                      <p className="font-medium">Cierre del Día</p>
                      <p className="text-xs text-slate-500">Reconciliación y reporte</p>
                    </div>
                  </Link>
                  
                  <Link 
                    to="/analytics"
                    className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    onClick={() => setUserMenuOpen(false)}
                  >
                    <span className="text-lg">📋</span>
                    <div>
                      <p className="font-medium">Analíticas</p>
                      <p className="text-xs text-slate-500">Reportes y estadísticas</p>
                    </div>
                  </Link>
                </div>
                
                <div className="border-t border-slate-100 py-1">
                  <Link 
                    to="/settings"
                    className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    onClick={() => setUserMenuOpen(false)}
                  >
                    <Settings className="w-5 h-5 text-slate-400" />
                    <span>Configuración</span>
                  </Link>
                  
                  <button className="w-full px-4 py-2.5 text-left text-sm text-error-600 hover:bg-error-50 flex items-center gap-3">
                    <LogOut className="w-5 h-5" />
                    <span>Cerrar Sesión</span>
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </header>
  );
}

export default Header;
