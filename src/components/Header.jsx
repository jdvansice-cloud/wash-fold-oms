import React, { useState, useRef, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { 
  Menu, Search, Gift, User, Settings, LogOut, 
  ClipboardList, BarChart3, FileText, Key
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';
import { useTenant } from '../hooks/useTenant';
import { useFeature } from '../hooks/useFeature';
import StoreSwitcher from './StoreSwitcher';

function Header() {
  const { state, actions } = useApp();
  const { user, appUser, signOut } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [userMenuOpen, setUserMenuOpen] = useState(false);
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const userMenuRef = useRef(null);
  
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

  const { company, slug } = useTenant();
  const isMultiStore = useFeature('multi_store');
  const p = (path) => `/app/${slug}${path}`;

  const handleLogout = async () => {
    setUserMenuOpen(false);
    try {
      await signOut();
      navigate(p('/login'), { replace: true });
    } catch (err) {
      console.error('Logout error:', err);
      navigate(p('/login'), { replace: true });
    }
  };

  const navLinks = [
    { path: p('/'), label: 'Nueva Orden', icon: null },
    { path: p('/machines'), label: 'En Proceso', icon: null },
    { path: p('/orders'), label: 'Listo', query: '?status=ready', icon: null },
    { path: p('/orders'), label: 'Completado', query: '?status=completed', icon: null },
  ];

  // Get user display info
  const displayName = appUser?.full_name || user?.email?.split('@')[0] || 'Usuario';
  const displayRole = appUser?.role || 'usuario';
  const initials = appUser?.initials || displayName.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase();

  const roleLabels = {
    admin: 'Administrador',
    supervisor: 'Supervisor',
    operator: 'Operador',
  };
  
  return (
    <>
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
            
            <Link to={p('/')} className="flex items-center gap-2">
              <span className="text-2xl">✨</span>
              <span className="font-display font-bold text-slate-800 text-lg tracking-tight truncate max-w-[200px]">
                {company?.name || 'Wash & Fold'}
              </span>
            </Link>

            {/* Store Switcher — Enterprise only, multi-store */}
            {isMultiStore && <StoreSwitcher />}
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
                {initials}
              </button>
              
              {/* Dropdown */}
              {userMenuOpen && (
                <div className="absolute right-0 top-12 w-72 bg-white rounded-2xl shadow-elevated border border-slate-200 py-2 animate-scale-in">
                  {/* User Info */}
                  <div className="px-4 py-3 border-b border-slate-100">
                    <p className="font-semibold text-slate-800">{displayName}</p>
                    <p className="text-xs text-slate-500">{roleLabels[displayRole] || displayRole}</p>
                    <p className="text-xs text-slate-400 mt-1">{user?.email}</p>
                  </div>
                  
                  {/* Menu Items */}
                  <div className="py-1">
                    <Link 
                      to={p('/eod')}
                      onClick={() => setUserMenuOpen(false)}
                      className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    >
                      <span className="text-lg">📊</span>
                      <div>
                        <p className="font-medium">Cierre del Día</p>
                        <p className="text-xs text-slate-500">Reconciliación y reporte</p>
                      </div>
                    </Link>
                    
                    <Link 
                      to="/eod?history=1"
                      onClick={() => setUserMenuOpen(false)}
                      className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    >
                      <span className="text-lg">📋</span>
                      <div>
                        <p className="font-medium">Historial de Cierres</p>
                        <p className="text-xs text-slate-500">Ver reportes anteriores</p>
                      </div>
                    </Link>
                  </div>
                  
                  <div className="border-t border-slate-100 py-1">
                    <button 
                      onClick={() => { setUserMenuOpen(false); setShowPasswordModal(true); }}
                      className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    >
                      <Key className="w-5 h-5 text-slate-400" />
                      <span>Cambiar Contraseña</span>
                    </button>

                    {appUser?.role === 'admin' && (
                      <Link 
                        to={p('/settings')}
                        className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                        onClick={() => setUserMenuOpen(false)}
                      >
                        <Settings className="w-5 h-5 text-slate-400" />
                        <span>Configuración</span>
                      </Link>
                    )}
                    
                    <button 
                      onClick={handleLogout}
                      className="w-full px-4 py-2.5 text-left text-sm text-error-600 hover:bg-error-50 flex items-center gap-3"
                    >
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

      {/* Change Password Modal */}
      {showPasswordModal && (
        <ChangePasswordModal onClose={() => setShowPasswordModal(false)} />
      )}
    </>
  );
}

// Change Password Modal
function ChangePasswordModal({ onClose }) {
  const { updatePassword } = useAuth();
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const validatePassword = (pwd) => {
    return pwd.length >= 8 && /[A-Z]/.test(pwd) && /[a-z]/.test(pwd) && /[0-9]/.test(pwd);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);

    if (!validatePassword(newPassword)) {
      setError('La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Las contraseñas no coinciden');
      return;
    }

    setLoading(true);
    try {
      await updatePassword(newPassword);
      alert('Contraseña actualizada correctamente');
      onClose();
    } catch (err) {
      console.error('Password update error:', err);
      setError(err.message || 'Error al actualizar la contraseña');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-md">
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">Cambiar Contraseña</h2>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg">
            <span className="text-slate-500 text-xl">&times;</span>
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          {error && (
            <div className="p-3 bg-error-50 border border-error-200 rounded-xl text-error-700 text-sm">
              {error}
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Nueva Contraseña
            </label>
            <input
              type="password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="input"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Confirmar Nueva Contraseña
            </label>
            <input
              type="password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="input"
              required
            />
          </div>

          <div className="text-xs text-slate-500 space-y-1">
            <p>La contraseña debe tener:</p>
            <ul className="list-disc list-inside">
              <li>Mínimo 8 caracteres</li>
              <li>Al menos una mayúscula</li>
              <li>Al menos una minúscula</li>
              <li>Al menos un número</li>
            </ul>
          </div>

          <div className="flex justify-end gap-3 pt-4">
            <button type="button" onClick={onClose} className="btn-secondary">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="btn-primary">
              {loading ? 'Guardando...' : 'Guardar'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default Header;
