import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../lib/supabase';
import { Loader2, Lock, Eye, EyeOff, Sparkles, CheckCircle, AlertCircle } from 'lucide-react';

function SetPasswordPage() {
  const navigate = useNavigate();
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [checking, setChecking] = useState(true);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);
  const [sessionValid, setSessionValid] = useState(false);

  useEffect(() => {
    // Check if we have a valid session from the email link
    checkSession();
  }, []);

  const checkSession = async () => {
    try {
      const { data: { session }, error } = await supabase.auth.getSession();
      
      if (error) {
        console.error('Session error:', error);
        setError('Enlace inválido o expirado. Contacta al administrador para un nuevo enlace.');
        setChecking(false);
        return;
      }

      if (session) {
        setSessionValid(true);
      } else {
        // Check URL for recovery token
        const hashParams = new URLSearchParams(window.location.hash.substring(1));
        const accessToken = hashParams.get('access_token');
        const type = hashParams.get('type');

        if (accessToken && (type === 'recovery' || type === 'invite' || type === 'signup')) {
          // Set session from URL token
          const { data, error: setError } = await supabase.auth.setSession({
            access_token: accessToken,
            refresh_token: hashParams.get('refresh_token') || ''
          });

          if (setError) {
            console.error('Set session error:', setError);
            setError('Enlace inválido o expirado. Contacta al administrador para un nuevo enlace.');
          } else {
            setSessionValid(true);
          }
        } else {
          setError('Enlace inválido o expirado. Contacta al administrador para un nuevo enlace.');
        }
      }
    } catch (err) {
      console.error('Check session error:', err);
      setError('Error al verificar la sesión.');
    } finally {
      setChecking(false);
    }
  };

  const validatePassword = (pwd) => {
    const checks = {
      length: pwd.length >= 8,
      uppercase: /[A-Z]/.test(pwd),
      lowercase: /[a-z]/.test(pwd),
      number: /[0-9]/.test(pwd),
    };
    return checks;
  };

  const passwordChecks = validatePassword(password);
  const isPasswordValid = Object.values(passwordChecks).every(Boolean);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);

    if (!isPasswordValid) {
      setError('La contraseña no cumple con los requisitos mínimos.');
      return;
    }

    if (password !== confirmPassword) {
      setError('Las contraseñas no coinciden.');
      return;
    }

    setLoading(true);

    try {
      const { data, error } = await supabase.auth.updateUser({
        password: password
      });

      if (error) throw error;

      // Link auth user to app user if not already linked
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        // Update the users table to link auth_id
        const { error: updateError } = await supabase
          .from('users')
          .update({ auth_id: user.id })
          .eq('email', user.email);

        if (updateError) {
          console.warn('Could not link auth to user:', updateError);
        }
      }

      setSuccess(true);
      
      // Sign out and redirect to login after 3 seconds
      setTimeout(async () => {
        await supabase.auth.signOut();
        navigate('/login');
      }, 3000);

    } catch (err) {
      console.error('Set password error:', err);
      setError(err.message || 'Error al establecer la contraseña');
    } finally {
      setLoading(false);
    }
  };

  if (checking) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-10 h-10 animate-spin text-primary-500 mx-auto mb-4" />
          <p className="text-slate-600">Verificando enlace...</p>
        </div>
      </div>
    );
  }

  if (success) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center p-4">
        <div className="w-full max-w-md">
          <div className="bg-white rounded-2xl shadow-elevated p-8 text-center">
            <div className="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <CheckCircle className="w-10 h-10 text-success-600" />
            </div>
            <h1 className="text-2xl font-semibold text-slate-800 mb-2">
              ¡Contraseña Establecida!
            </h1>
            <p className="text-slate-500 mb-4">
              Tu contraseña ha sido configurada correctamente.
            </p>
            <p className="text-sm text-slate-400">
              Redirigiendo al inicio de sesión...
            </p>
          </div>
        </div>
      </div>
    );
  }

  if (!sessionValid && error) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center p-4">
        <div className="w-full max-w-md">
          <div className="bg-white rounded-2xl shadow-elevated p-8 text-center">
            <div className="w-16 h-16 bg-error-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <AlertCircle className="w-10 h-10 text-error-600" />
            </div>
            <h1 className="text-2xl font-semibold text-slate-800 mb-2">
              Enlace Inválido
            </h1>
            <p className="text-slate-500 mb-6">
              {error}
            </p>
            <button
              onClick={() => navigate('/login')}
              className="btn-primary"
            >
              Ir al Inicio de Sesión
            </button>
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
          <p className="text-slate-500">Configura tu cuenta</p>
        </div>

        {/* Set Password Card */}
        <div className="bg-white rounded-2xl shadow-elevated p-8">
          <h1 className="text-2xl font-semibold text-slate-800 mb-2 text-center">
            Establecer Contraseña
          </h1>
          <p className="text-slate-500 text-center mb-6">
            Crea una contraseña segura para tu cuenta
          </p>

          {error && (
            <div className="mb-6 p-4 bg-error-50 border border-error-200 rounded-xl text-error-700 text-sm">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-5">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Nueva Contraseña
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="input pl-11 pr-11"
                  placeholder="••••••••"
                  required
                  autoComplete="new-password"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
                >
                  {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                </button>
              </div>

              {/* Password Requirements */}
              <div className="mt-3 space-y-1">
                <p className="text-xs font-medium text-slate-600 mb-1">Requisitos:</p>
                <div className={`text-xs flex items-center gap-2 ${passwordChecks.length ? 'text-success-600' : 'text-slate-400'}`}>
                  <CheckCircle className="w-3 h-3" />
                  Mínimo 8 caracteres
                </div>
                <div className={`text-xs flex items-center gap-2 ${passwordChecks.uppercase ? 'text-success-600' : 'text-slate-400'}`}>
                  <CheckCircle className="w-3 h-3" />
                  Al menos una mayúscula
                </div>
                <div className={`text-xs flex items-center gap-2 ${passwordChecks.lowercase ? 'text-success-600' : 'text-slate-400'}`}>
                  <CheckCircle className="w-3 h-3" />
                  Al menos una minúscula
                </div>
                <div className={`text-xs flex items-center gap-2 ${passwordChecks.number ? 'text-success-600' : 'text-slate-400'}`}>
                  <CheckCircle className="w-3 h-3" />
                  Al menos un número
                </div>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Confirmar Contraseña
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  className="input pl-11"
                  placeholder="••••••••"
                  required
                  autoComplete="new-password"
                />
              </div>
              {confirmPassword && password !== confirmPassword && (
                <p className="text-xs text-error-600 mt-1">Las contraseñas no coinciden</p>
              )}
            </div>

            <button
              type="submit"
              disabled={loading || !isPasswordValid || password !== confirmPassword}
              className="w-full btn-primary py-3 text-base justify-center disabled:opacity-50"
            >
              {loading ? (
                <>
                  <Loader2 className="w-5 h-5 animate-spin" />
                  Guardando...
                </>
              ) : (
                'Establecer Contraseña'
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

export default SetPasswordPage;
