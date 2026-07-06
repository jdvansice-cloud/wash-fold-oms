import React, { useState, useRef, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import {
  Menu, Search, Gift, User, Settings, LogOut,
  ClipboardList, BarChart3, FileText, Key, Clock, Loader2
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';
import { useTenant } from '../hooks/useTenant';
import { usePermission } from '../hooks/usePermission';
import { roleLabels } from '../utils/permissions';
import { restHeaders } from '../lib/restAuth';
import { useOpenTimeEntry, useClockToggle, workedMinutes } from '../hooks/queries/useTimeClock';
import StoreSwitcher from './StoreSwitcher';

function Header() {
  const { state, actions } = useApp();
  const { user, appUser, signOut } = useAuth();
  const { can } = usePermission();
  const location = useLocation();
  const navigate = useNavigate();
  const [userMenuOpen, setUserMenuOpen] = useState(false);
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [showGiftCardModal, setShowGiftCardModal] = useState(false);
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

  const { company, slug, activeStore } = useTenant();
  const p = (path) => `/app/${slug}${path}`;

  // Real-time attendance (clock in/out) for the signed-in staff member.
  const { data: openEntry } = useOpenTimeEntry(appUser?.id);
  const clockToggle = useClockToggle(appUser?.id, activeStore?.id || state.store?.id);
  const clockedIn = !!openEntry;

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

            {/* Store Switcher — shows whenever the company has >1 store
                (the component self-hides for a single store). */}
            <StoreSwitcher />
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
            <button
              onClick={() => setShowGiftCardModal(true)}
              className="flex items-center gap-2 px-3 py-2 bg-purple-50 hover:bg-purple-100 text-purple-700 rounded-xl text-sm font-medium transition-colors"
            >
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

                  {/* Clock in / out (real-time attendance) */}
                  <div className="px-4 py-3 border-b border-slate-100">
                    <button
                      onClick={() => clockToggle.mutate(openEntry || null)}
                      disabled={clockToggle.isPending}
                      className={`w-full flex items-center justify-center gap-2 py-2.5 rounded-xl text-sm font-medium transition-colors disabled:opacity-60 ${
                        clockedIn
                          ? 'bg-error-50 text-error-600 hover:bg-error-100'
                          : 'bg-emerald-50 text-emerald-700 hover:bg-emerald-100'
                      }`}
                    >
                      {clockToggle.isPending ? (
                        <Loader2 className="w-4 h-4 animate-spin" />
                      ) : (
                        <Clock className="w-4 h-4" />
                      )}
                      {clockedIn ? 'Marcar Salida' : 'Marcar Entrada'}
                    </button>
                    {clockedIn && (
                      <p className="text-xs text-slate-400 text-center mt-1.5">
                        Entrada{' '}
                        {new Date(openEntry.clock_in).toLocaleTimeString('es-PA', {
                          hour: '2-digit',
                          minute: '2-digit',
                        })}{' '}
                        · {Math.floor(workedMinutes(openEntry) / 60)}h {workedMinutes(openEntry) % 60}m
                      </p>
                    )}
                  </div>

                  {/* Menu Items — daily close is supervisor+ */}
                  {can('eod.close') && (
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
                  )}

                  <div className="border-t border-slate-100 py-1">
                    <button 
                      onClick={() => { setUserMenuOpen(false); setShowPasswordModal(true); }}
                      className="w-full px-4 py-2.5 text-left text-sm text-slate-700 hover:bg-slate-50 flex items-center gap-3"
                    >
                      <Key className="w-5 h-5 text-slate-400" />
                      <span>Cambiar Contraseña</span>
                    </button>

                    {can('settings.manage') && (
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

      {/* Gift Card Lookup Modal */}
      {showGiftCardModal && (
        <GiftCardLookupModal onClose={() => setShowGiftCardModal(false)} />
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

// Gift Card Lookup Modal
function GiftCardLookupModal({ onClose }) {
  const [code, setCode] = useState('');
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);
  const inputRef = useRef(null);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  const handleLookup = async (e) => {
    e.preventDefault();
    if (!code.trim()) return;
    setError(null);
    setResult(null);
    setLoading(true);

    try {
      const url = import.meta.env.SUPABASE_URL;
      const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
      const response = await fetch(
        `${url}/rest/v1/gift_cards?code=eq.${encodeURIComponent(code.trim().toUpperCase())}&select=id,code,initial_value,current_balance,is_active,expires_at,created_at`,
        { headers: await restHeaders() }
      );
      const data = await response.json();

      if (!data || data.length === 0) {
        setError('Tarjeta no encontrada. Verifica el codigo.');
      } else {
        setResult(data[0]);
      }
    } catch (err) {
      setError('Error al buscar la tarjeta');
    } finally {
      setLoading(false);
    }
  };

  const isExpired = result?.expires_at && new Date(result.expires_at) < new Date();

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4" onClick={onClose}>
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-sm" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <Gift className="w-5 h-5 text-purple-500" />
            <h2 className="text-lg font-semibold text-slate-800">Consultar Gift Card</h2>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg">
            <span className="text-slate-500 text-xl">&times;</span>
          </button>
        </div>

        <div className="p-5 space-y-4">
          <form onSubmit={handleLookup} className="flex gap-2">
            <input
              ref={inputRef}
              type="text"
              value={code}
              onChange={(e) => setCode(e.target.value.toUpperCase())}
              placeholder="Codigo de la tarjeta"
              className="flex-1 px-3 py-2.5 border border-slate-200 rounded-xl text-sm font-mono tracking-wider uppercase focus:outline-none focus:ring-2 focus:ring-purple-500/20 focus:border-purple-400"
              maxLength={20}
            />
            <button
              type="submit"
              disabled={loading || !code.trim()}
              className="px-4 py-2.5 bg-purple-600 text-white rounded-xl text-sm font-medium hover:bg-purple-700 disabled:opacity-50 transition-colors"
            >
              {loading ? '...' : 'Buscar'}
            </button>
          </form>

          {error && (
            <div className="p-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm text-center">
              {error}
            </div>
          )}

          {result && (
            <div className="bg-gradient-to-br from-purple-50 to-violet-50 rounded-xl border border-purple-200 p-5">
              {/* Balance */}
              <div className="text-center mb-4">
                <p className="text-xs text-purple-500 font-medium uppercase tracking-wide mb-1">Balance Disponible</p>
                <p className={`text-3xl font-bold ${result.current_balance > 0 ? 'text-purple-700' : 'text-slate-400'}`}>
                  B/{parseFloat(result.current_balance).toFixed(2)}
                </p>
              </div>

              {/* Details */}
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-slate-500">Codigo</span>
                  <span className="font-mono font-medium text-slate-700">{result.code}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-500">Valor Inicial</span>
                  <span className="text-slate-700">B/{parseFloat(result.initial_value).toFixed(2)}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-500">Estado</span>
                  <span className={`font-medium ${
                    !result.is_active ? 'text-red-600' :
                    isExpired ? 'text-amber-600' :
                    result.current_balance <= 0 ? 'text-slate-400' :
                    'text-emerald-600'
                  }`}>
                    {!result.is_active ? 'Inactiva' :
                     isExpired ? 'Expirada' :
                     result.current_balance <= 0 ? 'Agotada' :
                     'Activa'}
                  </span>
                </div>
                {result.expires_at && (
                  <div className="flex justify-between">
                    <span className="text-slate-500">Expira</span>
                    <span className={`${isExpired ? 'text-red-500' : 'text-slate-700'}`}>
                      {new Date(result.expires_at).toLocaleDateString('es-PA')}
                    </span>
                  </div>
                )}
                <div className="flex justify-between">
                  <span className="text-slate-500">Creada</span>
                  <span className="text-slate-700">{new Date(result.created_at).toLocaleDateString('es-PA')}</span>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default Header;
