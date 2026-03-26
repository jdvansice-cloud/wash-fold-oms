import React, { useState, useEffect } from 'react';
import { Save, Lock } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { useUpdateCustomer } from '../../hooks/queries/useCustomers';
import { supabasePortal as supabase } from '../../lib/supabase';

export default function MyProfile() {
  const { authUser, updatePassword } = useAuth();
  const customer = authUser?.customerProfile;
  const updateCustomer = useUpdateCustomer();

  const [profile, setProfile] = useState({
    first_name: '',
    last_name: '',
    phone: '',
    email: '',
    address_street: '',
    address_building: '',
    address_district: 'Panama',
    address_province: 'Panama',
  });
  const [profileSaved, setProfileSaved] = useState(false);

  const [passwords, setPasswords] = useState({ newPassword: '', confirmPassword: '' });
  const [passwordError, setPasswordError] = useState('');
  const [passwordSaved, setPasswordSaved] = useState(false);
  const [passwordLoading, setPasswordLoading] = useState(false);

  useEffect(() => {
    if (!customer) return;
    // Load full customer data
    const loadCustomer = async () => {
      const { data } = await supabase
        .from('customers')
        .select('*')
        .eq('id', customer.id)
        .single();
      if (data) {
        setProfile({
          first_name: data.first_name || '',
          last_name: data.last_name || '',
          phone: data.phone || '',
          email: data.email || '',
          address_street: data.address_street || '',
          address_building: data.address_building || '',
          address_district: data.address_district || 'Panama',
          address_province: data.address_province || 'Panama',
        });
      }
    };
    loadCustomer();
  }, [customer]);

  const handleSaveProfile = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!customer) return;

    try {
      await updateCustomer.mutateAsync({
        id: customer.id,
        ...profile,
      });
      setProfileSaved(true);
      setTimeout(() => setProfileSaved(false), 3000);
    } catch {
      // Error handled by mutation
    }
  };

  const handleChangePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setPasswordError('');

    if (passwords.newPassword.length < 8) {
      setPasswordError('Minimo 8 caracteres');
      return;
    }
    if (passwords.newPassword !== passwords.confirmPassword) {
      setPasswordError('Las contrasenas no coinciden');
      return;
    }

    setPasswordLoading(true);
    try {
      await updatePassword(passwords.newPassword);
      setPasswords({ newPassword: '', confirmPassword: '' });
      setPasswordSaved(true);
      setTimeout(() => setPasswordSaved(false), 3000);
    } catch (err: unknown) {
      setPasswordError(err instanceof Error ? err.message : 'Error al cambiar contrasena');
    } finally {
      setPasswordLoading(false);
    }
  };

  return (
    <div className="space-y-6">
      <h1 className="text-xl font-bold text-slate-900">Mi Perfil</h1>

      {/* Profile Form */}
      <form onSubmit={handleSaveProfile} className="bg-white rounded-xl border border-slate-200 p-4 space-y-4">
        <h2 className="text-sm font-semibold text-slate-900">Informacion Personal</h2>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <label className="block text-sm text-slate-600 mb-1">Nombre</label>
            <input
              type="text"
              value={profile.first_name}
              onChange={(e) => setProfile({ ...profile, first_name: e.target.value })}
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
              required
            />
          </div>
          <div>
            <label className="block text-sm text-slate-600 mb-1">Apellido</label>
            <input
              type="text"
              value={profile.last_name}
              onChange={(e) => setProfile({ ...profile, last_name: e.target.value })}
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            />
          </div>
        </div>

        <div>
          <label className="block text-sm text-slate-600 mb-1">Telefono</label>
          <div className="flex gap-2">
            <span className="flex items-center px-3 bg-slate-50 border border-slate-300 rounded-lg text-sm text-slate-600">
              +507
            </span>
            <input
              type="tel"
              value={profile.phone}
              onChange={(e) => setProfile({ ...profile, phone: e.target.value })}
              className="flex-1 px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            />
          </div>
        </div>

        <div>
          <label className="block text-sm text-slate-600 mb-1">Email</label>
          <input
            type="email"
            value={profile.email}
            onChange={(e) => setProfile({ ...profile, email: e.target.value })}
            className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
          />
        </div>

        <h3 className="text-sm font-semibold text-slate-900 pt-2">Direccion</h3>

        <div>
          <label className="block text-sm text-slate-600 mb-1">Calle / Edificio</label>
          <input
            type="text"
            value={profile.address_street}
            onChange={(e) => setProfile({ ...profile, address_street: e.target.value })}
            className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
          />
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <label className="block text-sm text-slate-600 mb-1">Distrito</label>
            <select
              value={profile.address_district}
              onChange={(e) => setProfile({ ...profile, address_district: e.target.value })}
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            >
              <option value="Panama">Panama</option>
              <option value="San Miguelito">San Miguelito</option>
              <option value="Arraijan">Arraijan</option>
              <option value="La Chorrera">La Chorrera</option>
            </select>
          </div>
          <div>
            <label className="block text-sm text-slate-600 mb-1">Provincia</label>
            <input
              type="text"
              value={profile.address_province}
              onChange={(e) => setProfile({ ...profile, address_province: e.target.value })}
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            />
          </div>
        </div>

        <button
          type="submit"
          disabled={updateCustomer.isPending}
          className="w-full py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center justify-center gap-2"
        >
          <Save size={16} />
          {updateCustomer.isPending ? 'Guardando...' : 'Guardar Cambios'}
        </button>

        {profileSaved && (
          <p className="text-sm text-emerald-600 text-center">Perfil actualizado</p>
        )}
        {updateCustomer.error && (
          <p className="text-sm text-red-600 text-center">Error al guardar</p>
        )}
      </form>

      {/* Password Change */}
      <form onSubmit={handleChangePassword} className="bg-white rounded-xl border border-slate-200 p-4 space-y-4">
        <h2 className="text-sm font-semibold text-slate-900 flex items-center gap-2">
          <Lock size={14} />
          Cambiar Contrasena
        </h2>

        <div>
          <label className="block text-sm text-slate-600 mb-1">Nueva contrasena</label>
          <input
            type="password"
            value={passwords.newPassword}
            onChange={(e) => setPasswords({ ...passwords, newPassword: e.target.value })}
            className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            minLength={8}
            required
          />
        </div>

        <div>
          <label className="block text-sm text-slate-600 mb-1">Confirmar contrasena</label>
          <input
            type="password"
            value={passwords.confirmPassword}
            onChange={(e) => setPasswords({ ...passwords, confirmPassword: e.target.value })}
            className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            required
          />
        </div>

        {passwordError && <p className="text-sm text-red-600">{passwordError}</p>}
        {passwordSaved && <p className="text-sm text-emerald-600">Contrasena actualizada</p>}

        <button
          type="submit"
          disabled={passwordLoading}
          className="w-full py-2.5 bg-slate-700 text-white rounded-lg text-sm font-medium hover:bg-slate-800 disabled:opacity-50"
        >
          {passwordLoading ? 'Cambiando...' : 'Cambiar Contrasena'}
        </button>
      </form>
    </div>
  );
}
