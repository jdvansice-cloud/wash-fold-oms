import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { UserPlus, Eye, EyeOff } from 'lucide-react';
import { supabase } from '../../lib/supabase';
import { isValidEmail, isValidPanamaPhone } from '../../lib/validation';

export default function CustomerRegister() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [form, setForm] = useState({
    first_name: '',
    last_name: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
  });

  const updateField = (field: string, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    setError('');
  };

  const validate = (): string | null => {
    if (!form.first_name.trim()) return 'Nombre es requerido';
    if (!form.last_name.trim()) return 'Apellido es requerido';
    if (!isValidEmail(form.email)) return 'Email invalido';
    if (!isValidPanamaPhone(form.phone)) return 'Telefono debe ser 8 digitos (Panama)';
    if (form.password.length < 8) return 'Contrasena debe tener al menos 8 caracteres';
    if (!/[A-Z]/.test(form.password)) return 'Contrasena necesita al menos una mayuscula';
    if (!/[a-z]/.test(form.password)) return 'Contrasena necesita al menos una minuscula';
    if (!/[0-9]/.test(form.password)) return 'Contrasena necesita al menos un numero';
    if (form.password !== form.confirmPassword) return 'Las contrasenas no coinciden';
    return null;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const validationError = validate();
    if (validationError) {
      setError(validationError);
      return;
    }

    setLoading(true);
    setError('');

    try {
      // 1. Create Supabase Auth account
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: form.email,
        password: form.password,
        options: {
          data: { role: 'customer', first_name: form.first_name },
        },
      });

      if (authError) throw authError;
      if (!authData.user) throw new Error('No se pudo crear la cuenta');

      // 2. Get the default store
      const { data: store } = await supabase
        .from('stores')
        .select('id')
        .eq('is_active', true)
        .limit(1)
        .single();

      if (!store) throw new Error('No se encontro la tienda');

      // 3. Create customer record
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

      // 4. Create customer_auth bridge
      const { error: bridgeError } = await supabase.from('customer_auth').insert({
        auth_id: authData.user.id,
        customer_id: customer.id,
        store_id: store.id,
      });

      if (bridgeError) throw bridgeError;

      // Success — navigate to portal (auth state change will trigger)
      navigate('/portal');
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al registrarse';
      if (message.includes('already registered')) {
        setError('Este email ya esta registrado. Intenta iniciar sesion.');
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
          <p className="text-slate-500 text-sm mt-1">Crear cuenta de cliente</p>
        </div>

        <div className="bg-white rounded-2xl shadow-card p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-6">Registro</h2>

          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm">{error}</div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
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

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Contrasena</label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={form.password}
                  onChange={(e) => updateField('password', e.target.value)}
                  className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 pr-10"
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
              <p className="text-xs text-slate-400 mt-1">
                Minimo 8 caracteres, 1 mayuscula, 1 minuscula, 1 numero
              </p>
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Confirmar contrasena
              </label>
              <input
                type="password"
                value={form.confirmPassword}
                onChange={(e) => updateField('confirmPassword', e.target.value)}
                className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                required
              />
            </div>

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
              Crear Cuenta
            </button>
          </form>

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
