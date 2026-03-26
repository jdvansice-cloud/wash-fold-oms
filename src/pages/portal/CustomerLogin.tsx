import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Mail, KeyRound, ArrowLeft } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { useTenant } from '../../hooks/useTenant';

export default function CustomerLogin() {
  const [email, setEmail] = useState('');
  const [otpCode, setOtpCode] = useState('');
  const [step, setStep] = useState<'email' | 'otp'>('email');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [cooldown, setCooldown] = useState(0);
  const { signInWithOtp, verifyOtp } = useAuth();
  const { company, slug } = useTenant();
  const navigate = useNavigate();
  const companyName = company?.name || 'Lavanderia';

  useEffect(() => {
    if (cooldown <= 0) return;
    const timer = setTimeout(() => setCooldown(cooldown - 1), 1000);
    return () => clearTimeout(timer);
  }, [cooldown]);

  const handleSendOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      await signInWithOtp(email);
      setStep('otp');
      setCooldown(60);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al enviar el codigo');
    } finally {
      setLoading(false);
    }
  };

  const handleVerifyOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      await verifyOtp(email, otpCode);
      navigate(`/portal/${slug}`);
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al verificar';
      if (message.includes('expired')) {
        setError('El codigo ha expirado. Solicita uno nuevo.');
      } else if (message.toLowerCase().includes('invalid')) {
        setError('Codigo invalido. Verifica e intenta de nuevo.');
      } else {
        setError(message);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleResend = async () => {
    if (cooldown > 0) return;
    setError('');
    try {
      await signInWithOtp(email);
      setCooldown(60);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al reenviar');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-slate-100 flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-primary-600">{companyName}</h1>
          <p className="text-slate-500 text-sm mt-1">Portal del Cliente</p>
        </div>

        <div className="bg-white rounded-2xl shadow-card p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-6">Iniciar Sesion</h2>

          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm">{error}</div>
          )}

          {step === 'email' ? (
            <form onSubmit={handleSendOtp} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
                <div className="relative">
                  <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="w-full pl-10 pr-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    placeholder="tu@email.com"
                    required
                  />
                </div>
                <p className="text-xs text-slate-400 mt-2">
                  Te enviaremos un codigo de acceso a tu email
                </p>
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-2.5 bg-primary-500 hover:bg-primary-600 text-white rounded-lg font-medium text-sm transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? (
                  <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                ) : (
                  <Mail size={16} />
                )}
                Enviar Codigo
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerifyOtp} className="space-y-4">
              <div className="text-center mb-2">
                <div className="inline-flex items-center justify-center w-10 h-10 bg-primary-100 rounded-full mb-2">
                  <KeyRound size={20} className="text-primary-600" />
                </div>
                <p className="text-sm text-slate-600">
                  Codigo enviado a <strong className="text-slate-800">{email}</strong>
                </p>
              </div>

              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  Codigo de Verificacion
                </label>
                <input
                  type="text"
                  value={otpCode}
                  onChange={(e) => setOtpCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm text-center text-2xl tracking-[0.5em] font-mono focus:outline-none focus:ring-2 focus:ring-primary-500"
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
                className="w-full py-2.5 bg-primary-500 hover:bg-primary-600 text-white rounded-lg font-medium text-sm transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? (
                  <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                ) : (
                  <KeyRound size={16} />
                )}
                Verificar Codigo
              </button>

              <div className="flex items-center justify-between text-xs">
                <button
                  type="button"
                  onClick={() => { setStep('email'); setOtpCode(''); setError(''); }}
                  className="text-slate-500 hover:text-slate-700 flex items-center gap-1"
                >
                  <ArrowLeft size={12} />
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

          <div className="mt-6 text-center">
            <p className="text-sm text-slate-500">
              No tienes cuenta?{' '}
              <Link to={`/portal/${slug}/register`} className="text-primary-600 font-medium hover:underline">
                Registrate
              </Link>
            </p>
          </div>
        </div>

        <div className="text-center mt-4">
          <Link to={`/app/${slug}/login`} className="text-xs text-slate-400 hover:text-slate-600">
            Acceso para empleados
          </Link>
        </div>
      </div>
    </div>
  );
}
