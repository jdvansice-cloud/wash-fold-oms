import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Shield, Mail, Lock, Loader2 } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';

export default function AdminLogin() {
  const { signInWithOtp, verifyOtp, isPlatformAdmin, user } = useAuth();
  const navigate = useNavigate();
  const [step, setStep] = useState<'email' | 'otp'>('email');
  const [email, setEmail] = useState('');
  const [otp, setOtp] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [cooldown, setCooldown] = useState(0);

  // Redirect if already logged in as platform admin
  useEffect(() => {
    if (user && isPlatformAdmin) {
      navigate('/admin', { replace: true });
    }
  }, [user, isPlatformAdmin]);

  useEffect(() => {
    if (cooldown <= 0) return;
    const t = setTimeout(() => setCooldown(cooldown - 1), 1000);
    return () => clearTimeout(t);
  }, [cooldown]);

  async function handleSendOtp(e: React.FormEvent) {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await signInWithOtp(email);
      setStep('otp');
      setCooldown(60);
    } catch (err: unknown) {
      setError((err as Error).message || 'Error enviando codigo');
    } finally {
      setLoading(false);
    }
  }

  async function handleVerifyOtp(e: React.FormEvent) {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await verifyOtp(email, otp);
      // After verify, auth context will resolve — check isPlatformAdmin
      // Give it a moment to resolve
      setTimeout(() => {
        navigate('/admin', { replace: true });
      }, 500);
    } catch (err: unknown) {
      setError((err as Error).message || 'Codigo invalido');
      setLoading(false);
    }
  }

  return (
    <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="text-center mb-8">
          <div className="w-14 h-14 bg-amber-500 rounded-2xl flex items-center justify-center mx-auto mb-4">
            <Shield size={28} className="text-white" />
          </div>
          <h1 className="text-2xl font-bold text-white">WashPro Admin</h1>
          <p className="text-sm text-slate-400 mt-1">Panel de administracion de plataforma</p>
        </div>

        <div className="bg-white rounded-2xl p-6 shadow-xl">
          {step === 'email' ? (
            <form onSubmit={handleSendOtp} className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-800">Iniciar Sesion</h2>

              {error && (
                <div className="p-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">
                  {error}
                </div>
              )}

              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
                <div className="relative">
                  <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="admin@washpro.app"
                    className="w-full pl-10 pr-4 py-2.5 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-slate-900/20"
                    required
                  />
                </div>
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-2.5 bg-slate-900 text-white rounded-lg text-sm font-medium hover:bg-slate-800 disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? <Loader2 size={16} className="animate-spin" /> : null}
                Enviar Codigo
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerifyOtp} className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-800">Verificar Codigo</h2>
              <p className="text-sm text-slate-500">Ingresa el codigo enviado a <strong>{email}</strong></p>

              {error && (
                <div className="p-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">
                  {error}
                </div>
              )}

              <div>
                <input
                  type="text"
                  value={otp}
                  onChange={(e) => setOtp(e.target.value.replace(/\D/g, '').slice(0, 6))}
                  placeholder="000000"
                  className="w-full text-center text-2xl font-mono tracking-[0.5em] py-3 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-slate-900/20"
                  maxLength={6}
                  required
                />
              </div>

              <button
                type="submit"
                disabled={loading || otp.length !== 6}
                className="w-full py-2.5 bg-slate-900 text-white rounded-lg text-sm font-medium hover:bg-slate-800 disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? <Loader2 size={16} className="animate-spin" /> : null}
                Verificar
              </button>

              <button
                type="button"
                onClick={() => { setStep('email'); setOtp(''); setError(''); }}
                className="w-full text-sm text-slate-500 hover:text-slate-700"
              >
                Cambiar email
              </button>

              {cooldown > 0 ? (
                <p className="text-xs text-slate-400 text-center">Reenviar en {cooldown}s</p>
              ) : (
                <button
                  type="button"
                  onClick={() => handleSendOtp({ preventDefault: () => {} } as React.FormEvent)}
                  className="w-full text-sm text-blue-600 hover:text-blue-800"
                >
                  Reenviar codigo
                </button>
              )}
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
