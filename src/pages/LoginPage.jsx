import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useTenant } from '../hooks/useTenant';
import { Loader2, Mail, Sparkles, ArrowLeft, KeyRound } from 'lucide-react';

function LoginPage() {
  const navigate = useNavigate();
  const { signInWithOtp, verifyOtp } = useAuth();
  const { company, slug } = useTenant();
  const companyName = company?.name || 'Lavanderia';
  const [email, setEmail] = useState('');
  const [otpCode, setOtpCode] = useState('');
  const [step, setStep] = useState('email'); // 'email' or 'otp'
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [cooldown, setCooldown] = useState(0);

  // Cooldown timer for resend
  useEffect(() => {
    if (cooldown <= 0) return;
    const timer = setTimeout(() => setCooldown(cooldown - 1), 1000);
    return () => clearTimeout(timer);
  }, [cooldown]);

  const handleSendOtp = async (e) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      await signInWithOtp(email);
      setStep('otp');
      setCooldown(60);
    } catch (err) {
      console.error('OTP send error:', err);
      setError(err.message || 'Error al enviar el codigo');
    } finally {
      setLoading(false);
    }
  };

  const handleVerifyOtp = async (e) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      await verifyOtp(email, otpCode);
      navigate(`/app/${slug}`);
    } catch (err) {
      console.error('OTP verify error:', err);
      if (err.message.includes('Token has expired') || err.message.includes('expired')) {
        setError('El codigo ha expirado. Solicita uno nuevo.');
      } else if (err.message.includes('Invalid') || err.message.includes('invalid')) {
        setError('Codigo invalido. Verifica e intenta de nuevo.');
      } else {
        setError(err.message || 'Error al verificar el codigo');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleResend = async () => {
    if (cooldown > 0) return;
    setError(null);
    try {
      await signInWithOtp(email);
      setCooldown(60);
    } catch (err) {
      setError(err.message || 'Error al reenviar el codigo');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-secondary-50 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        {/* Logo/Brand */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <Sparkles className="w-10 h-10 text-primary-500" />
            <span className="text-3xl font-bold text-slate-800">
              {companyName}
            </span>
          </div>
          <p className="text-slate-500">Sistema de Gestion de Ordenes</p>
        </div>

        {/* Login Card */}
        <div className="bg-white rounded-2xl shadow-elevated p-8">
          <h1 className="text-2xl font-semibold text-slate-800 mb-6 text-center">
            Iniciar Sesion
          </h1>

          {error && (
            <div className="mb-6 p-4 bg-error-50 border border-error-200 rounded-xl text-error-700 text-sm">
              {error}
            </div>
          )}

          {step === 'email' ? (
            <form onSubmit={handleSendOtp} className="space-y-5">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Correo Electronico
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
                <p className="text-xs text-slate-400 mt-2">
                  Te enviaremos un codigo de acceso a tu email
                </p>
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full btn-primary py-3 text-base justify-center"
              >
                {loading ? (
                  <>
                    <Loader2 className="w-5 h-5 animate-spin" />
                    Enviando codigo...
                  </>
                ) : (
                  'Enviar Codigo'
                )}
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerifyOtp} className="space-y-5">
              <div className="text-center mb-4">
                <div className="inline-flex items-center justify-center w-12 h-12 bg-primary-100 rounded-full mb-3">
                  <KeyRound className="w-6 h-6 text-primary-600" />
                </div>
                <p className="text-sm text-slate-600">
                  Enviamos un codigo a <strong>{email}</strong>
                </p>
              </div>

              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Codigo de Verificacion
                </label>
                <input
                  type="text"
                  value={otpCode}
                  onChange={(e) => setOtpCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                  className="input text-center text-2xl tracking-[0.5em] font-mono"
                  placeholder="000000"
                  maxLength={6}
                  required
                  autoFocus
                  autoComplete="one-time-code"
                  inputMode="numeric"
                />
              </div>

              <button
                type="submit"
                disabled={loading || otpCode.length !== 6}
                className="w-full btn-primary py-3 text-base justify-center"
              >
                {loading ? (
                  <>
                    <Loader2 className="w-5 h-5 animate-spin" />
                    Verificando...
                  </>
                ) : (
                  'Verificar Codigo'
                )}
              </button>

              <div className="flex items-center justify-between text-sm">
                <button
                  type="button"
                  onClick={() => { setStep('email'); setOtpCode(''); setError(null); }}
                  className="text-slate-500 hover:text-slate-700 flex items-center gap-1"
                >
                  <ArrowLeft className="w-4 h-4" />
                  Cambiar email
                </button>
                <button
                  type="button"
                  onClick={handleResend}
                  disabled={cooldown > 0}
                  className="text-primary-600 hover:text-primary-700 disabled:text-slate-300"
                >
                  {cooldown > 0 ? `Reenviar (${cooldown}s)` : 'Reenviar codigo'}
                </button>
              </div>
            </form>
          )}
        </div>

        {/* Footer */}
        <p className="text-center text-sm text-slate-400 mt-8">
          &copy; 2025 American Laundry. Todos los derechos reservados.
        </p>
      </div>
    </div>
  );
}

export default LoginPage;
