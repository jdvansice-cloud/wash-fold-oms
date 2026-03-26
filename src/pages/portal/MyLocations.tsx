import React, { useState } from 'react';
import { MapPin, Plus, Trash2, Star, X, Check } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { useMyLocations, useCreateLocation, useDeleteLocation, useUpdateLocation } from '../../hooks/queries/useCustomerLocations';
import LocationPicker from '../../components/map/LocationPicker';
import type { CustomerLocation } from '../../types';

export default function MyLocations() {
  const { authUser } = useAuth();
  const customerId = authUser?.customerProfile?.id;
  const { data: locations, isLoading } = useMyLocations(customerId);
  const createLocation = useCreateLocation();
  const deleteLocation = useDeleteLocation();
  const updateLocation = useUpdateLocation();
  const [showForm, setShowForm] = useState(false);
  const [deleteConfirm, setDeleteConfirm] = useState<string | null>(null);

  const [form, setForm] = useState({
    label: '',
    address_line: '',
    district: 'Panama',
    city: 'Panama',
    latitude: undefined as number | undefined,
    longitude: undefined as number | undefined,
    is_default: false,
    notes: '',
  });

  const resetForm = () => {
    setForm({ label: '', address_line: '', district: 'Panama', city: 'Panama', latitude: undefined, longitude: undefined, is_default: false, notes: '' });
    setShowForm(false);
  };

  const handleSave = async () => {
    if (!customerId || !form.label.trim() || !form.address_line.trim()) return;
    await createLocation.mutateAsync({
      customer_id: customerId,
      label: form.label.trim(),
      address_line: form.address_line.trim(),
      district: form.district,
      city: form.city,
      latitude: form.latitude,
      longitude: form.longitude,
      is_default: form.is_default,
      notes: form.notes || undefined,
    });
    resetForm();
  };

  const handleDelete = async (id: string) => {
    if (!customerId) return;
    await deleteLocation.mutateAsync({ id, customerId });
    setDeleteConfirm(null);
  };

  const handleSetDefault = async (loc: CustomerLocation) => {
    if (!customerId) return;
    await updateLocation.mutateAsync({ id: loc.id, customerId, is_default: true });
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-slate-900">Mis Direcciones</h1>
          <p className="text-sm text-slate-500 mt-1">Guarda tus ubicaciones para agendar recogidas mas rapido</p>
        </div>
        {!showForm && (
          <button
            onClick={() => setShowForm(true)}
            className="flex items-center gap-1.5 px-3 py-2 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 transition-colors"
          >
            <Plus size={16} />
            Agregar
          </button>
        )}
      </div>

      {/* Add Location Form */}
      {showForm && (
        <div className="bg-white rounded-xl border border-slate-200 p-5 space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="font-semibold text-slate-900">Nueva Direccion</h3>
            <button onClick={resetForm} className="p-1 text-slate-400 hover:text-slate-600">
              <X size={18} />
            </button>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Etiqueta</label>
              <input
                type="text"
                value={form.label}
                onChange={(e) => setForm({ ...form, label: e.target.value })}
                placeholder="Ej: Casa, Oficina"
                className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-slate-600 mb-1">Distrito</label>
              <select
                value={form.district}
                onChange={(e) => setForm({ ...form, district: e.target.value })}
                className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500"
              >
                <option value="Panama">Panama</option>
                <option value="San Miguelito">San Miguelito</option>
                <option value="Arraijan">Arraijan</option>
                <option value="La Chorrera">La Chorrera</option>
                <option value="Colon">Colon</option>
              </select>
            </div>
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-600 mb-1">Direccion</label>
            <input
              type="text"
              value={form.address_line}
              onChange={(e) => setForm({ ...form, address_line: e.target.value })}
              placeholder="Calle, edificio, apartamento..."
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500"
            />
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-600 mb-1">Ubicacion en el mapa</label>
            <p className="text-[11px] text-slate-400 mb-2">Toca el mapa o arrastra el marcador a tu ubicacion</p>
            <LocationPicker
              latitude={form.latitude}
              longitude={form.longitude}
              onLocationChange={(lat, lng) => setForm({ ...form, latitude: lat, longitude: lng })}
            />
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-600 mb-1">Notas (opcional)</label>
            <input
              type="text"
              value={form.notes}
              onChange={(e) => setForm({ ...form, notes: e.target.value })}
              placeholder="Ej: Porteria principal, piso 3"
              className="w-full px-3 py-2 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-primary-500"
            />
          </div>

          <label className="flex items-center gap-2 text-sm text-slate-700">
            <input
              type="checkbox"
              checked={form.is_default}
              onChange={(e) => setForm({ ...form, is_default: e.target.checked })}
              className="rounded border-slate-300 text-primary-600"
            />
            Usar como direccion predeterminada
          </label>

          <div className="flex gap-2">
            <button
              onClick={handleSave}
              disabled={!form.label.trim() || !form.address_line.trim() || createLocation.isPending}
              className="flex-1 py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center justify-center gap-2 transition-colors"
            >
              {createLocation.isPending ? (
                <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <Check size={16} />
              )}
              Guardar Direccion
            </button>
            <button
              onClick={resetForm}
              className="px-4 py-2.5 bg-slate-100 text-slate-600 rounded-lg text-sm font-medium hover:bg-slate-200 transition-colors"
            >
              Cancelar
            </button>
          </div>
        </div>
      )}

      {/* Locations List */}
      {isLoading ? (
        <div className="flex justify-center py-8">
          <span className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
        </div>
      ) : locations && locations.length > 0 ? (
        <div className="space-y-3">
          {locations.map((loc) => (
            <div key={loc.id} className="bg-white rounded-xl border border-slate-200 p-4">
              <div className="flex items-start justify-between">
                <div className="flex items-start gap-3">
                  <div className="bg-primary-50 rounded-lg p-2 mt-0.5">
                    <MapPin size={18} className="text-primary-500" />
                  </div>
                  <div>
                    <div className="flex items-center gap-2">
                      <h3 className="font-medium text-slate-900">{loc.label}</h3>
                      {loc.is_default && (
                        <span className="px-1.5 py-0.5 bg-amber-100 text-amber-700 text-[10px] font-medium rounded">
                          Predeterminada
                        </span>
                      )}
                    </div>
                    <p className="text-sm text-slate-500 mt-0.5">{loc.address_line}</p>
                    {loc.district && <p className="text-xs text-slate-400">{loc.district}, {loc.city || 'Panama'}</p>}
                    {loc.notes && <p className="text-xs text-slate-400 mt-1">{loc.notes}</p>}
                  </div>
                </div>

                <div className="flex items-center gap-1">
                  {!loc.is_default && (
                    <button
                      onClick={() => handleSetDefault(loc)}
                      className="p-1.5 text-slate-400 hover:text-amber-500 rounded-lg hover:bg-amber-50 transition-colors"
                      title="Establecer como predeterminada"
                    >
                      <Star size={14} />
                    </button>
                  )}
                  {deleteConfirm === loc.id ? (
                    <div className="flex items-center gap-1">
                      <button
                        onClick={() => handleDelete(loc.id)}
                        className="px-2 py-1 text-xs bg-red-500 text-white rounded hover:bg-red-600"
                      >
                        Si
                      </button>
                      <button
                        onClick={() => setDeleteConfirm(null)}
                        className="px-2 py-1 text-xs bg-slate-200 text-slate-600 rounded hover:bg-slate-300"
                      >
                        No
                      </button>
                    </div>
                  ) : (
                    <button
                      onClick={() => setDeleteConfirm(loc.id)}
                      className="p-1.5 text-slate-400 hover:text-red-500 rounded-lg hover:bg-red-50 transition-colors"
                    >
                      <Trash2 size={14} />
                    </button>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-slate-200 p-8 text-center">
          <MapPin size={32} className="mx-auto mb-2 text-slate-300" />
          <p className="text-sm text-slate-500">No tienes direcciones guardadas</p>
          <p className="text-xs text-slate-400 mt-1">Agrega una para agendar recogidas mas rapido</p>
        </div>
      )}
    </div>
  );
}
