import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Sparkles, ArrowLeft, ArrowRight, Check, Loader2, Building, Mail, User, Globe } from 'lucide-react';
import { supabaseStaff } from '../lib/supabase';

const PLANS = [
  { id: 'starter', name: 'Starter', price: '$29/mes', desc: 'POS + ordenes + reportes' },
  { id: 'pro', name: 'Pro', price: '$59/mes', desc: 'Todo + portal + recogidas + lealtad', popular: true },
  { id: 'enterprise', name: 'Enterprise', price: '$99/mes', desc: 'Multi-tienda + branding + API' },
];

function slugify(text: string): string {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 60);
}

export default function SignupPage() {
  const navigate = useNavigate();
  const [step, setStep] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [slugAvailable, setSlugAvailable] = useState<boolean | null>(null);

  const [form, setForm] = useState({
    companyName: '',
    adminName: '',
    adminEmail: '',
    slug: '',
    plan: 'pro',
  });

  const updateField = (field: string, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    setError('');
    if (field === 'companyName' && !form.slug) {
      // Auto-suggest slug from company name
      setForm((prev) => ({ ...prev, [field]: value, slug: slugify(value) }));
    }
  };

  const checkSlug = async (slug: string) => {
    if (!slug || slug.length < 3) {
      setSlugAvailable(null);
      return;
    }
    const { data } = await supabaseStaff
      .from('companies')
      .select('id')
      .eq('slug', slug)
      .maybeSingle();
    setSlugAvailable(!data);
  };

  const handleSlugChange = (value: string) => {
    const cleaned = slugify(value);
    setForm((prev) => ({ ...prev, slug: cleaned }));
    setSlugAvailable(null);
    // Debounce check
    clearTimeout((window as any).__slugTimer);
    (window as any).__slugTimer = setTimeout(() => checkSlug(cleaned), 500);
  };

  const handleSubmit = async () => {
    if (!form.companyName.trim() || !form.adminName.trim() || !form.adminEmail.trim() || !form.slug) {
      setError('Todos los campos son requeridos');
      return;
    }
    if (slugAvailable === false) {
      setError('El URL ya esta en uso. Elige otro.');
      return;
    }

    setLoading(true);
    setError('');

    try {
      // 1. Create company
      const { data: company, error: companyError } = await supabaseStaff
        .from('companies')
        .insert({
          name: form.companyName.trim(),
          slug: form.slug,
          itbms_rate: 7.0,
        })
        .select()
        .single();

      if (companyError) throw companyError;

      // 2. Create default store
      const { data: store, error: storeError } = await supabaseStaff
        .from('stores')
        .insert({
          company_id: company.id,
          name: form.companyName.trim(),
          is_active: true,
        })
        .select()
        .single();

      if (storeError) throw storeError;

      // 3. Create subscription
      const { error: subError } = await supabaseStaff
        .from('subscriptions')
        .insert({
          company_id: company.id,
          plan: form.plan,
          status: 'trialing',
        });

      if (subError) throw subError;

      // 4. Send OTP to admin email (this creates the Supabase auth user)
      const { error: otpError } = await supabaseStaff.auth.signInWithOtp({
        email: form.adminEmail.trim(),
      });

      if (otpError) throw otpError;

      // 5. Store provisioning data for the OTP verification step
      sessionStorage.setItem('washpro_onboarding', JSON.stringify({
        companyId: company.id,
        storeId: store.id,
        adminName: form.adminName.trim(),
        adminEmail: form.adminEmail.trim(),
        slug: form.slug,
        plan: form.plan,
      }));

      setStep(3); // Show OTP verification step
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al crear la cuenta';
      if (message.includes('duplicate') || message.includes('unique')) {
        setError('Este URL o email ya esta registrado');
      } else {
        setError(message);
      }
    } finally {
      setLoading(false);
    }
  };

  const [otpCode, setOtpCode] = useState('');

  const handleVerifyOtp = async () => {
    setLoading(true);
    setError('');

    try {
      const onboarding = JSON.parse(sessionStorage.getItem('washpro_onboarding') || '{}');

      // Verify OTP
      const { data: authData, error: otpError } = await supabaseStaff.auth.verifyOtp({
        email: onboarding.adminEmail,
        token: otpCode,
        type: 'email',
      });

      if (otpError) throw otpError;
      const authUser = authData?.user;
      if (!authUser?.id) throw new Error('No se pudo verificar');

      // Create the admin user record
      const { error: userError } = await supabaseStaff
        .from('users')
        .insert({
          auth_id: authUser.id,
          store_id: onboarding.storeId,
          company_id: onboarding.companyId,
          email: onboarding.adminEmail,
          full_name: onboarding.adminName,
          initials: onboarding.adminName.split(' ').map((n: string) => n[0]).join('').slice(0, 2).toUpperCase(),
          role: 'admin',
          is_active: true,
        });

      if (userError) throw userError;

      // Sign out (the user will log in through the proper tenant route)
      await supabaseStaff.auth.signOut();

      sessionStorage.removeItem('washpro_onboarding');
      navigate(`/app/${onboarding.slug}/login`);
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al verificar';
      if (message.includes('expired')) {
        setError('El codigo ha expirado. Solicita uno nuevo.');
      } else if (message.toLowerCase().includes('invalid')) {
        setError('Codigo invalido. Intenta de nuevo.');
      } else {
        setError(message);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 via-white to-slate-50 flex items-center justify-center p-4">
      <div className="w-full max-w-lg">
        {/* Header */}
        <div className="text-center mb-8">
          <Link to="/" className="inline-flex items-center gap-2 mb-4">
            <Sparkles className="w-8 h-8 text-primary-500" />
            <span className="text-2xl font-bold text-slate-900">Wash<span className="text-primary-500">Pro</span></span>
          </Link>
          <p className="text-slate-500 text-sm">Crea tu cuenta en minutos</p>
        </div>

        <div className="bg-white rounded-2xl shadow-lg p-6 md:p-8">
          {/* Step indicators */}
          {step < 3 && (
            <div className="flex items-center gap-2 mb-6">
              {['Informacion', 'URL', 'Plan'].map((label, i) => (
                <React.Fragment key={label}>
                  {i > 0 && <div className={`flex-1 h-0.5 ${i <= step ? 'bg-primary-500' : 'bg-slate-200'}`} />}
                  <div className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-medium ${
                    i < step ? 'bg-primary-500 text-white' :
                    i === step ? 'bg-primary-100 text-primary-700 ring-2 ring-primary-500' :
                    'bg-slate-100 text-slate-400'
                  }`}>
                    {i < step ? <Check size={12} /> : i + 1}
                  </div>
                </React.Fragment>
              ))}
            </div>
          )}

          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm">{error}</div>
          )}

          {/* Step 0: Company + Admin info */}
          {step === 0 && (
            <div className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-900">Datos de tu negocio</h2>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  <Building size={14} className="inline mr-1" />
                  Nombre de la empresa
                </label>
                <input
                  type="text"
                  value={form.companyName}
                  onChange={(e) => updateField('companyName', e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  placeholder="Mi Lavanderia"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  <User size={14} className="inline mr-1" />
                  Tu nombre completo
                </label>
                <input
                  type="text"
                  value={form.adminName}
                  onChange={(e) => updateField('adminName', e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  placeholder="Juan Perez"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  <Mail size={14} className="inline mr-1" />
                  Email del administrador
                </label>
                <input
                  type="email"
                  value={form.adminEmail}
                  onChange={(e) => updateField('adminEmail', e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  placeholder="admin@milavanderia.com"
                />
              </div>
              <button
                onClick={() => {
                  if (!form.companyName.trim() || !form.adminName.trim() || !form.adminEmail.trim()) {
                    setError('Todos los campos son requeridos');
                    return;
                  }
                  checkSlug(form.slug);
                  setStep(1);
                }}
                className="w-full py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 flex items-center justify-center gap-2"
              >
                Continuar <ArrowRight size={16} />
              </button>
            </div>
          )}

          {/* Step 1: Slug */}
          {step === 1 && (
            <div className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-900">URL de tu negocio</h2>
              <p className="text-sm text-slate-500">
                Esta sera la direccion web para tu equipo y clientes.
              </p>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  <Globe size={14} className="inline mr-1" />
                  URL personalizada
                </label>
                <div className="flex items-center rounded-lg border border-slate-300 overflow-hidden focus-within:ring-2 focus-within:ring-primary-500">
                  <span className="px-3 py-2.5 bg-slate-50 text-slate-400 text-sm border-r border-slate-300 whitespace-nowrap">
                    washpro.app/app/
                  </span>
                  <input
                    type="text"
                    value={form.slug}
                    onChange={(e) => handleSlugChange(e.target.value)}
                    className="flex-1 px-3 py-2.5 text-sm focus:outline-none"
                    placeholder="mi-lavanderia"
                  />
                </div>
                {slugAvailable === true && form.slug.length >= 3 && (
                  <p className="text-xs text-emerald-600 mt-1 flex items-center gap-1">
                    <Check size={12} /> Disponible
                  </p>
                )}
                {slugAvailable === false && (
                  <p className="text-xs text-red-600 mt-1">Este URL ya esta en uso</p>
                )}
              </div>
              <div className="flex gap-2">
                <button
                  onClick={() => setStep(0)}
                  className="px-4 py-2.5 bg-slate-100 text-slate-600 rounded-lg text-sm font-medium hover:bg-slate-200 flex items-center gap-1"
                >
                  <ArrowLeft size={14} /> Atras
                </button>
                <button
                  onClick={() => {
                    if (!form.slug || form.slug.length < 3) {
                      setError('URL debe tener al menos 3 caracteres');
                      return;
                    }
                    if (slugAvailable === false) {
                      setError('Elige un URL disponible');
                      return;
                    }
                    setStep(2);
                  }}
                  className="flex-1 py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 flex items-center justify-center gap-2"
                >
                  Continuar <ArrowRight size={16} />
                </button>
              </div>
            </div>
          )}

          {/* Step 2: Plan selection */}
          {step === 2 && (
            <div className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-900">Elige tu plan</h2>
              <p className="text-sm text-slate-500">14 dias gratis. Cancela cuando quieras.</p>
              <div className="space-y-2">
                {PLANS.map((plan) => (
                  <button
                    key={plan.id}
                    onClick={() => setForm((prev) => ({ ...prev, plan: plan.id }))}
                    className={`w-full text-left p-4 rounded-xl border-2 transition-colors ${
                      form.plan === plan.id
                        ? 'border-primary-500 bg-primary-50'
                        : 'border-slate-200 hover:border-slate-300'
                    }`}
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <div className="flex items-center gap-2">
                          <span className="font-semibold text-slate-900">{plan.name}</span>
                          {plan.popular && (
                            <span className="px-1.5 py-0.5 bg-primary-500 text-white text-[10px] font-medium rounded">
                              Popular
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-slate-500 mt-0.5">{plan.desc}</p>
                      </div>
                      <span className="text-lg font-bold text-slate-900">{plan.price}</span>
                    </div>
                  </button>
                ))}
              </div>
              <div className="flex gap-2">
                <button
                  onClick={() => setStep(1)}
                  className="px-4 py-2.5 bg-slate-100 text-slate-600 rounded-lg text-sm font-medium hover:bg-slate-200 flex items-center gap-1"
                >
                  <ArrowLeft size={14} /> Atras
                </button>
                <button
                  onClick={handleSubmit}
                  disabled={loading}
                  className="flex-1 py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center justify-center gap-2"
                >
                  {loading ? (
                    <Loader2 size={16} className="animate-spin" />
                  ) : (
                    <>Crear cuenta <ArrowRight size={16} /></>
                  )}
                </button>
              </div>
            </div>
          )}

          {/* Step 3: OTP verification */}
          {step === 3 && (
            <div className="space-y-4">
              <div className="text-center mb-2">
                <div className="w-12 h-12 bg-primary-100 rounded-full flex items-center justify-center mx-auto mb-3">
                  <Mail size={24} className="text-primary-600" />
                </div>
                <h2 className="text-lg font-semibold text-slate-900">Verifica tu email</h2>
                <p className="text-sm text-slate-500 mt-1">
                  Enviamos un codigo a <strong>{form.adminEmail}</strong>
                </p>
              </div>
              <input
                type="text"
                value={otpCode}
                onChange={(e) => setOtpCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                className="w-full px-3 py-3 rounded-lg border border-slate-300 text-center text-2xl tracking-[0.5em] font-mono focus:ring-2 focus:ring-primary-500"
                placeholder="000000"
                maxLength={6}
                autoFocus
                autoComplete="one-time-code"
                inputMode="numeric"
              />
              <button
                onClick={handleVerifyOtp}
                disabled={loading || otpCode.length !== 6}
                className="w-full py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {loading ? (
                  <Loader2 size={16} className="animate-spin" />
                ) : (
                  <>Verificar y entrar <Check size={16} /></>
                )}
              </button>
            </div>
          )}
        </div>

        <p className="text-center text-xs text-slate-400 mt-6">
          Ya tienes cuenta? Ingresa desde la URL de tu negocio.
        </p>
      </div>
    </div>
  );
}
