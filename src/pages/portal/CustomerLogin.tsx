import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { LogIn, Eye, EyeOff } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';

export default function CustomerLogin() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const { signIn } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      await signIn(email, password);
      navigate('/portal');
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al iniciar sesion';
      if (message.includes('Invalid login credentials')) {
        setError('Credenciales invalidas. Verifica tu email y contrasena.');
      } else if (message.includes('Email not confirmed')) {
        setError('Email no confirmado. Revisa tu bandeja de entrada.');
      } else {
        setError(message);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-slate-100 flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-primary-600">American Laundry</h1>
          <p className="text-slate-500 text-sm mt-1">Portal del Cliente</p>
        </div>

        <div className="bg-white rounded-2xl shadow-card p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-6">Iniciar Sesion</h2>

          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm">{error}</div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                placeholder="tu@email.com"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Contrasena</label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 pr-10"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400"
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full py-2.5 bg-primary-500 hover:bg-primary-600 text-white rounded-lg font-medium text-sm transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {loading ? (
                <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <LogIn size={16} />
              )}
              Iniciar Sesion
            </button>
          </form>

          <div className="mt-6 text-center">
            <p className="text-sm text-slate-500">
              No tienes cuenta?{' '}
              <Link to="/portal/register" className="text-primary-600 font-medium hover:underline">
                Registrate
              </Link>
            </p>
          </div>
        </div>

        <div className="text-center mt-4">
          <Link to="/login" className="text-xs text-slate-400 hover:text-slate-600">
            Acceso para empleados
          </Link>
        </div>
      </div>
    </div>
  );
}
