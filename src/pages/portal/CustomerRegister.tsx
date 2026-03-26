import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { UserPlus, KeyRound, ArrowLeft } from 'lucide-react';
import { supabasePortal as supabase } from '../../lib/supabase';
import { useAuth } from '../../hooks/useAuth';
import { isValidEmail, isValidPanamaPhone } from '../../lib/validation';

export default function CustomerRegister() {
  const navigate = useNavigate();
  const { signInWithOtp, verifyOtp } = useAuth();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [step, setStep] = useState<'info' | 'otp'>('info');
  const [otpCode, setOtpCode] = useState('');
  const [cooldown, setCooldown] = useState(0);
  const [form, setForm] = useState({
    first_name: '',
    last_name: '',
    email: '',
    phone: '',
  });

  useEffect(() => {
    if (cooldown <= 0) return;
    const timer = setTimeout(() => setCooldown(cooldown - 1), 1000);
    return () => clearTimeout(timer);
  }, [cooldown]);

  const updateField = (field: string, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    setError('');
  };

  const validate = (): string | null => {
    if (!form.first_name.trim()) return 'Nombre es requerido';
    if (!form.last_name.trim()) return 'Apellido es requerido';
    if (!isValidEmail(form.email)) return 'Email invalido';
    if (!isValidPanamaPhone(form.phone)) return 'Telefono debe ser 8 digitos (Panama)';
    return null;
  };

  const handleSendOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    const validationError = validate();
    if (validationError) {
      setError(validationError);
      return;
    }

    setLoading(true);
    setError('');

    try {
      // Send OTP — Supabase auto-creates user if email doesn't exist
      await signInWithOtp(form.email);
      setStep('otp');
      setCooldown(60);
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al enviar codigo';
      setError(message);
    } finally {
      setLoading(false);
    }
  };

  const handleVerifyAndRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      // 1. Verify OTP (this also creates the Supabase auth session)
      const result = await verifyOtp(form.email, otpCode);
      const authUser = (result as { user?: { id: string } })?.user;
      if (!authUser?.id) throw new Error('No se pudo verificar la cuenta');

      // 2. Get the default store
      const { data: store } = await supabase
        .from('stores')
        .select('id')
        .eq('is_active', true)
        .limit(1)
        .single();

      if (!store) throw new Error('No se encontro la tienda');

      // 3. Check if customer already exists for this email
      const { data: existingCustomer } = await supabase
        .from('customers')
        .select('id')
        .eq('email', form.email.trim().toLowerCase())
        .eq('store_id', store.id)
        .limit(1)
        .single();

      let customerId: string;

      if (existingCustomer) {
        customerId = existingCustomer.id;
      } else {
        // 4. Create customer record
        const { data: customer, error: customerError } = await supabase
          .from('customers')
          .insert({
            store_id: store.id,
            first_name: form.first_name.trim(),
            last_name: form.last_name.trim(),
            email: form.email.trim().toLowerCase(),
            phone: form.phone.replace(/\D/g, ''),
            phone_country: '+507',
            address_district: 'Panama',
            address_province: 'Panama',
            is_active: true,
          })
          .select()
          .single();

        if (customerError) throw customerError;
        customerId = customer.id;
      }

      // 5. Check if customer_auth bridge already exists
      const { data: existingBridge } = await supabase
        .from('customer_auth')
        .select('id')
        .eq('auth_id', authUser.id)
        .limit(1)
        .single();

      if (!existingBridge) {
        // 6. Create customer_auth bridge
        const { error: bridgeError } = await supabase.from('customer_auth').insert({
          auth_id: authUser.id,
          customer_id: customerId,
          store_id: store.id,
        });

        if (bridgeError) throw bridgeError;
      }

      // Success — auth state change will redirect
      navigate('/portal');
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al registrarse';
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
      await signInWithOtp(form.email);
      setCooldown(60);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al reenviar');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-slate-100 flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-primary-600">American Laundry</h1>
          <p className="text-slate-500 text-sm mt-1">Crear cuenta de cliente</p>
        </div>

        <div className="bg-white rounded-2xl shadow-card p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-6">
            {step === 'info' ? 'Registro' : 'Verificar Email'}
          </h2>

          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm">{error}</div>
          )}

          {step === 'info' ? (
            <form onSubmit={handleSendOtp} className="space-y-4">
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Nombre</label>
                  <input
                    type="text"
                    value={form.first_name}
                    onChange={(e) => updateField('first_name', e.target.value)}
                    className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Apellido</label>
                  <input
                    type="text"
                    value={form.last_name}
                    onChange={(e) => updateField('last_name', e.target.value)}
                    className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    required
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
                <input
                  type="email"
                  value={form.email}
                  onChange={(e) => updateField('email', e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                  placeholder="tu@email.com"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Telefono</label>
                <div className="flex gap-2">
                  <span className="flex items-center px-3 bg-slate-50 border border-slate-300 rounded-lg text-sm text-slate-600">
                    +507
                  </span>
                  <input
                    type="tel"
                    value={form.phone}
                    onChange={(e) => updateField('phone', e.target.value)}
                    className="flex-1 px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    placeholder="6789-0000"
                    maxLength={9}
                    required
                  />
                </div>
              </div>

              <p className="text-xs text-slate-400">
                Te enviaremos un codigo de verificacion a tu email
              </p>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-2.5 bg-primary-500 hover:bg-primary-600 text-white rounded-lg font-medium text-sm transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? (
                  <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                ) : (
                  <UserPlus size={16} />
                )}
                Continuar
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerifyAndRegister} className="space-y-4">
              <div className="text-center mb-2">
                <div className="inline-flex items-center justify-center w-10 h-10 bg-primary-100 rounded-full mb-2">
                  <KeyRound size={20} className="text-primary-600" />
                </div>
                <p className="text-sm text-slate-600">
                  Codigo enviado a <strong>{form.email}</strong>
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
                Crear Cuenta
              </button>

              <div className="flex items-center justify-between text-xs">
                <button
                  type="button"
                  onClick={() => { setStep('info'); setOtpCode(''); setError(''); }}
                  className="text-slate-500 hover:text-slate-700 flex items-center gap-1"
                >
                  <ArrowLeft size={12} />
                  Volver
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
              Ya tienes cuenta?{' '}
              <Link to="/portal/login" className="text-primary-600 font-medium hover:underline">
                Iniciar sesion
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
