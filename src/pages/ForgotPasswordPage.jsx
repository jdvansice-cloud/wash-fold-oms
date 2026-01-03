import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { supabase } from '../lib/supabase';
import { Loader2, Mail, Sparkles, CheckCircle, ArrowLeft } from 'lucide-react';

function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/set-password`
      });

      if (error) throw error;
      setSuccess(true);
    } catch (err) {
      console.error('Reset password error:', err);
      setError(err.message || 'Error al enviar el correo');
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center p-4">
        <div className="w-full max-w-md">
          <div className="bg-white rounded-2xl shadow-elevated p-8 text-center">
            <div className="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <CheckCircle className="w-10 h-10 text-success-600" />
            </div>
            <h1 className="text-2xl font-semibold text-slate-800 mb-2">
              Correo Enviado
            </h1>
            <p className="text-slate-500 mb-6">
              Hemos enviado un enlace para restablecer tu contraseña a <strong>{email}</strong>
            </p>
            <p className="text-sm text-slate-400 mb-6">
              Revisa tu bandeja de entrada y sigue las instrucciones.
            </p>
            <Link to="/login" className="btn-primary">
              Volver al Inicio de Sesión
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        {/* Logo/Brand */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <Sparkles className="w-10 h-10 text-primary-500" />
            <span className="text-3xl font-bold text-slate-800">
              American<span className="text-primary-500">Laundry</span>
            </span>
          </div>
        </div>

        {/* Reset Card */}
        <div className="bg-white rounded-2xl shadow-elevated p-8">
          <Link to="/login" className="inline-flex items-center gap-2 text-sm text-slate-500 hover:text-primary-600 mb-6">
            <ArrowLeft className="w-4 h-4" />
            Volver al inicio de sesión
          </Link>

          <h1 className="text-2xl font-semibold text-slate-800 mb-2">
            Recuperar Contraseña
          </h1>
          <p className="text-slate-500 mb-6">
            Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.
          </p>

          {error && (
            <div className="mb-6 p-4 bg-error-50 border border-error-200 rounded-xl text-error-700 text-sm">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-5">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Correo Electrónico
              </label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="input pl-11"
                  placeholder="tu@email.com"
                  required
                  autoComplete="email"
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full btn-primary py-3 text-base justify-center"
            >
              {loading ? (
                <>
                  <Loader2 className="w-5 h-5 animate-spin" />
                  Enviando...
                </>
              ) : (
                'Enviar Enlace de Recuperación'
              )}
            </button>
          </form>
        </div>

        {/* Footer */}
        <p className="text-center text-sm text-slate-400 mt-8">
          © 2025 American Laundry. Todos los derechos reservados.
        </p>
      </div>
    </div>
  );
}

export default ForgotPasswordPage;
