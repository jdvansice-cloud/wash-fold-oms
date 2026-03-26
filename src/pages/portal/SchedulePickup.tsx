import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Check, MapPin, Plus } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { useTenant } from '../../hooks/useTenant';
import { useDayAvailability, useSlotAvailability } from '../../hooks/queries/usePickupSchedule';
import { useCreatePickupRequest } from '../../hooks/queries/usePickupRequests';
import { useMyLocations } from '../../hooks/queries/useCustomerLocations';
import { PickupCalendar } from '../../components/portal/PickupCalendar';
import { TimeSlotPicker } from '../../components/portal/TimeSlotPicker';
import { formatDate } from '../../utils/formatters';
import type { CustomerLocation } from '../../types';

const STEPS = ['Fecha', 'Horario', 'Direccion', 'Confirmar'];

export default function SchedulePickup() {
  const navigate = useNavigate();
  const { authUser } = useAuth();
  const customerId = authUser?.customerProfile?.id;
  const storeId = authUser?.customerProfile?.store_id;
  const { slug } = useTenant();
  const pp = (path: string) => `/portal/${slug}${path}`;

  const [step, setStep] = useState(0);
  const [selectedDate, setSelectedDate] = useState<string | null>(null);
  const [selectedSlot, setSelectedSlot] = useState<string | null>(null);
  const [selectedLocation, setSelectedLocation] = useState<CustomerLocation | null>(null);
  const [manualAddress, setManualAddress] = useState(false);
  const [address, setAddress] = useState({
    address_line: '',
    district: 'Panama',
    city: 'Panama',
  });
  const [notes, setNotes] = useState('');
  const [success, setSuccess] = useState(false);

  const { data: days, isLoading: daysLoading } = useDayAvailability(storeId);
  const { data: slots, isLoading: slotsLoading } = useSlotAvailability(storeId, selectedDate ?? undefined);
  const { data: savedLocations } = useMyLocations(customerId);
  const createPickup = useCreatePickupRequest();

  const handleSelectDate = (date: string) => {
    setSelectedDate(date);
    setSelectedSlot(null);
    setStep(1);
  };

  const handleSelectSlot = (time: string) => {
    setSelectedSlot(time);
    setStep(2);
  };

  const handleSelectLocation = (loc: CustomerLocation) => {
    setSelectedLocation(loc);
    setManualAddress(false);
    setAddress({ address_line: loc.address_line, district: loc.district || 'Panama', city: loc.city || 'Panama' });
  };

  const handleConfirm = async () => {
    if (!customerId || !storeId || !selectedDate || !selectedSlot) return;

    try {
      await createPickup.mutateAsync({
        store_id: storeId,
        customer_id: customerId,
        requested_date: selectedDate,
        requested_time_slot: selectedSlot,
        address_line: address.address_line || undefined,
        district: address.district || undefined,
        city: address.city || undefined,
        notes: notes || undefined,
        customer_location_id: selectedLocation?.id || undefined,
        latitude: selectedLocation?.latitude || undefined,
        longitude: selectedLocation?.longitude || undefined,
      });
      setSuccess(true);
    } catch {
      // Error handled by mutation state
    }
  };

  const activeAddress = selectedLocation
    ? `${selectedLocation.label}: ${selectedLocation.address_line}`
    : address.address_line
      ? `${address.address_line}, ${address.district}`
      : '';

  if (success) {
    return (
      <div className="text-center py-12">
        <div className="w-16 h-16 bg-emerald-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <Check size={32} className="text-emerald-600" />
        </div>
        <h2 className="text-xl font-bold text-slate-900 mb-2">Recogida Programada</h2>
        <p className="text-slate-500 mb-1">
          {selectedDate && formatDate(selectedDate)} a las {selectedSlot}
        </p>
        {activeAddress && <p className="text-sm text-slate-400">{activeAddress}</p>}
        <p className="text-sm text-slate-400 mt-4">
          Recibiras una confirmacion cuando el equipo acepte la recogida.
        </p>
        <button
          onClick={() => navigate(pp('/'))}
          className="mt-6 px-6 py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600"
        >
          Volver al inicio
        </button>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button
          onClick={() => (step > 0 ? setStep(step - 1) : navigate(pp('/')))}
          className="p-2 rounded-lg hover:bg-slate-100 text-slate-500"
        >
          <ArrowLeft size={20} />
        </button>
        <h1 className="text-xl font-bold text-slate-900">Programar Recogida</h1>
      </div>

      {/* Progress Steps */}
      <div className="flex items-center gap-2">
        {STEPS.map((label, i) => (
          <React.Fragment key={label}>
            {i > 0 && <div className={`flex-1 h-0.5 ${i <= step ? 'bg-primary-500' : 'bg-slate-200'}`} />}
            <div
              className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-medium ${
                i < step
                  ? 'bg-primary-500 text-white'
                  : i === step
                    ? 'bg-primary-100 text-primary-700 ring-2 ring-primary-500'
                    : 'bg-slate-100 text-slate-400'
              }`}
            >
              {i < step ? <Check size={12} /> : i + 1}
            </div>
          </React.Fragment>
        ))}
      </div>

      {/* Step Content */}
      <div className="bg-white rounded-xl border border-slate-200 p-4">
        {step === 0 && (
          daysLoading ? (
            <div className="flex justify-center py-8">
              <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
            </div>
          ) : (
            <PickupCalendar
              days={days || []}
              selectedDate={selectedDate}
              onSelectDate={handleSelectDate}
            />
          )
        )}

        {step === 1 && (
          <TimeSlotPicker
            slots={slots || []}
            selectedSlot={selectedSlot}
            onSelectSlot={handleSelectSlot}
            isLoading={slotsLoading}
          />
        )}

        {step === 2 && (
          <div className="space-y-4">
            <h3 className="text-sm font-medium text-slate-700 flex items-center gap-2">
              <MapPin size={16} />
              Direccion de recogida
            </h3>

            {/* Saved Locations */}
            {savedLocations && savedLocations.length > 0 && !manualAddress && (
              <div className="space-y-2">
                <p className="text-xs text-slate-500">Selecciona una direccion guardada:</p>
                {savedLocations.map((loc) => (
                  <button
                    key={loc.id}
                    onClick={() => handleSelectLocation(loc)}
                    className={`w-full text-left p-3 rounded-lg border transition-colors ${
                      selectedLocation?.id === loc.id
                        ? 'border-primary-500 bg-primary-50'
                        : 'border-slate-200 hover:border-slate-300 hover:bg-slate-50'
                    }`}
                  >
                    <div className="flex items-center gap-2">
                      <MapPin size={14} className={selectedLocation?.id === loc.id ? 'text-primary-500' : 'text-slate-400'} />
                      <span className="text-sm font-medium text-slate-900">{loc.label}</span>
                      {loc.is_default && (
                        <span className="px-1.5 py-0.5 bg-amber-100 text-amber-700 text-[10px] font-medium rounded">
                          Predeterminada
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-slate-500 mt-0.5 ml-[22px]">{loc.address_line}</p>
                    {loc.latitude && (
                      <p className="text-[10px] text-slate-400 mt-0.5 ml-[22px]">Con ubicacion en mapa</p>
                    )}
                  </button>
                ))}

                <button
                  onClick={() => { setManualAddress(true); setSelectedLocation(null); }}
                  className="w-full flex items-center gap-2 p-3 text-sm text-primary-600 hover:bg-primary-50 rounded-lg border border-dashed border-slate-300 transition-colors"
                >
                  <Plus size={14} />
                  Usar otra direccion
                </button>
              </div>
            )}

            {/* Manual Address Entry (shown if no saved locations or user chose "other") */}
            {(manualAddress || !savedLocations || savedLocations.length === 0) && (
              <div className="space-y-3">
                {manualAddress && savedLocations && savedLocations.length > 0 && (
                  <button
                    onClick={() => setManualAddress(false)}
                    className="text-xs text-primary-600 hover:underline"
                  >
                    Volver a direcciones guardadas
                  </button>
                )}
                <div>
                  <label className="block text-sm text-slate-600 mb-1">Direccion</label>
                  <input
                    type="text"
                    value={address.address_line}
                    onChange={(e) => setAddress({ ...address, address_line: e.target.value })}
                    className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    placeholder="Calle, edificio, apartamento..."
                  />
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="block text-sm text-slate-600 mb-1">Distrito</label>
                    <select
                      value={address.district}
                      onChange={(e) => setAddress({ ...address, district: e.target.value })}
                      className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    >
                      <option value="Panama">Panama</option>
                      <option value="San Miguelito">San Miguelito</option>
                      <option value="Arraijan">Arraijan</option>
                      <option value="La Chorrera">La Chorrera</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm text-slate-600 mb-1">Ciudad</label>
                    <input
                      type="text"
                      value={address.city}
                      onChange={(e) => setAddress({ ...address, city: e.target.value })}
                      className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                    />
                  </div>
                </div>
              </div>
            )}

            <div>
              <label className="block text-sm text-slate-600 mb-1">Notas (opcional)</label>
              <textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                className="w-full px-3 py-2.5 rounded-lg border border-slate-300 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 resize-none"
                rows={2}
                placeholder="Instrucciones especiales, timbre, etc."
              />
            </div>

            <button
              onClick={() => setStep(3)}
              disabled={!selectedLocation && !address.address_line.trim()}
              className="w-full py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50"
            >
              Continuar
            </button>
          </div>
        )}

        {step === 3 && (
          <div className="space-y-4">
            <h3 className="text-sm font-medium text-slate-700">Resumen de recogida</h3>
            <div className="bg-slate-50 rounded-lg p-4 space-y-2 text-sm">
              <div className="flex justify-between">
                <span className="text-slate-500">Fecha</span>
                <span className="font-medium text-slate-900">{selectedDate && formatDate(selectedDate)}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">Horario</span>
                <span className="font-medium text-slate-900">{selectedSlot}</span>
              </div>
              {activeAddress && (
                <div className="flex justify-between">
                  <span className="text-slate-500">Direccion</span>
                  <span className="font-medium text-slate-900 text-right max-w-[60%]">{activeAddress}</span>
                </div>
              )}
              {notes && (
                <div>
                  <span className="text-slate-500">Notas:</span>
                  <p className="text-slate-700 mt-1">{notes}</p>
                </div>
              )}
            </div>

            {createPickup.error && (
              <div className="p-3 rounded-lg bg-red-50 text-red-700 text-sm">
                Error al programar recogida. Intenta de nuevo.
              </div>
            )}

            <button
              onClick={handleConfirm}
              disabled={createPickup.isPending}
              className="w-full py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {createPickup.isPending ? (
                <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <Check size={16} />
              )}
              Confirmar Recogida
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
