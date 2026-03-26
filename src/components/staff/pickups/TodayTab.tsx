import React from 'react';
import { Phone, MapPin, Clock, CheckCircle, XCircle, Truck } from 'lucide-react';
import { useStorePickupRequests, useUpdatePickupStatus } from '../../../hooks/queries/usePickupRequests';
import { format } from 'date-fns';
import type { PickupRequest, PickupRequestStatus } from '../../../types';

const STATUS_STYLES: Record<PickupRequestStatus, { bg: string; text: string; label: string }> = {
  pending: { bg: 'bg-amber-100', text: 'text-amber-700', label: 'Pendiente' },
  confirmed: { bg: 'bg-blue-100', text: 'text-blue-700', label: 'Confirmada' },
  picked_up: { bg: 'bg-emerald-100', text: 'text-emerald-700', label: 'Recogida' },
  cancelled: { bg: 'bg-red-100', text: 'text-red-700', label: 'Cancelada' },
};

function formatTime(t: string) {
  const [h, m] = t.split(':');
  const hour = parseInt(h);
  return `${hour > 12 ? hour - 12 : hour || 12}:${m} ${hour >= 12 ? 'PM' : 'AM'}`;
}

export default function TodayTab({ storeId }: { storeId: string | undefined }) {
  const today = format(new Date(), 'yyyy-MM-dd');
  const { data: pickups, isLoading } = useStorePickupRequests(storeId, {
    startDate: today,
    endDate: today,
  });
  const updateStatus = useUpdatePickupStatus();

  const handleAction = (id: string, status: PickupRequestStatus) => {
    updateStatus.mutate({ id, status });
  };

  if (isLoading) {
    return (
      <div className="flex justify-center py-12">
        <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  const active = pickups?.filter((p) => p.status !== 'cancelled') || [];
  const cancelled = pickups?.filter((p) => p.status === 'cancelled') || [];

  // Group by time slot
  const grouped = active.reduce<Record<string, PickupRequest[]>>((acc, p) => {
    const key = p.requested_time_slot;
    if (!acc[key]) acc[key] = [];
    acc[key].push(p);
    return acc;
  }, {});

  const timeSlots = Object.keys(grouped).sort();

  if (active.length === 0 && cancelled.length === 0) {
    return (
      <div className="text-center py-12">
        <Truck size={40} className="mx-auto mb-3 text-slate-300" />
        <p className="text-slate-500">No hay recogidas programadas para hoy</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-lg font-semibold text-slate-800">
          Hoy — {format(new Date(), 'dd MMM yyyy')}
        </h2>
        <span className="text-sm text-slate-500">{active.length} recogida(s)</span>
      </div>

      {timeSlots.map((slot) => (
        <div key={slot}>
          <div className="flex items-center gap-2 mb-2">
            <Clock size={14} className="text-primary-500" />
            <h3 className="text-sm font-medium text-slate-700">{formatTime(slot)}</h3>
            <span className="text-xs text-slate-400">({grouped[slot].length})</span>
          </div>

          <div className="space-y-2">
            {grouped[slot].map((pickup) => {
              const st = STATUS_STYLES[pickup.status];
              const name = pickup.customer
                ? `${pickup.customer.first_name} ${pickup.customer.last_name || ''}`.trim()
                : 'Cliente';

              return (
                <div key={pickup.id} className="bg-white rounded-xl border border-slate-200 p-4">
                  <div className="flex items-start justify-between">
                    <div className="space-y-1">
                      <div className="flex items-center gap-2">
                        <span className="font-medium text-slate-900">{name}</span>
                        <span className={`px-2 py-0.5 rounded-full text-[10px] font-medium ${st.bg} ${st.text}`}>
                          {st.label}
                        </span>
                      </div>
                      {pickup.customer?.phone && (
                        <p className="text-xs text-slate-500 flex items-center gap-1">
                          <Phone size={12} /> {pickup.customer.phone}
                        </p>
                      )}
                      <p className="text-xs text-slate-500 flex items-center gap-1">
                        <MapPin size={12} />
                        {pickup.address_line || pickup.customer_location?.address_line || 'Sin direccion'}
                        {pickup.latitude && ' (GPS)'}
                      </p>
                      {pickup.notes && (
                        <p className="text-xs text-slate-400 italic">Nota: {pickup.notes}</p>
                      )}
                    </div>

                    <div className="flex gap-1.5">
                      {pickup.status === 'pending' && (
                        <>
                          <button
                            onClick={() => handleAction(pickup.id, 'confirmed')}
                            className="px-3 py-1.5 bg-blue-500 text-white text-xs font-medium rounded-lg hover:bg-blue-600 flex items-center gap-1"
                          >
                            <CheckCircle size={12} /> Confirmar
                          </button>
                          <button
                            onClick={() => handleAction(pickup.id, 'cancelled')}
                            className="px-3 py-1.5 bg-slate-100 text-slate-600 text-xs font-medium rounded-lg hover:bg-slate-200 flex items-center gap-1"
                          >
                            <XCircle size={12} /> Cancelar
                          </button>
                        </>
                      )}
                      {pickup.status === 'confirmed' && (
                        <>
                          <button
                            onClick={() => handleAction(pickup.id, 'picked_up')}
                            className="px-3 py-1.5 bg-emerald-500 text-white text-xs font-medium rounded-lg hover:bg-emerald-600 flex items-center gap-1"
                          >
                            <Truck size={12} /> Recogida
                          </button>
                          <button
                            onClick={() => handleAction(pickup.id, 'cancelled')}
                            className="px-3 py-1.5 bg-slate-100 text-slate-600 text-xs font-medium rounded-lg hover:bg-slate-200 flex items-center gap-1"
                          >
                            <XCircle size={12} />
                          </button>
                        </>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      ))}

      {cancelled.length > 0 && (
        <details className="text-sm">
          <summary className="text-slate-400 cursor-pointer hover:text-slate-600">
            {cancelled.length} cancelada(s)
          </summary>
          <div className="mt-2 space-y-1">
            {cancelled.map((p) => (
              <div key={p.id} className="bg-slate-50 rounded-lg p-3 text-xs text-slate-500">
                {p.customer?.first_name} — {formatTime(p.requested_time_slot)}
                {p.cancelled_reason && ` — ${p.cancelled_reason}`}
              </div>
            ))}
          </div>
        </details>
      )}
    </div>
  );
}
