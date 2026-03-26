import React, { useState } from 'react';
import { Calendar, Phone, MapPin, Clock } from 'lucide-react';
import { useStorePickupRequests } from '../../../hooks/queries/usePickupRequests';
import { format, addDays } from 'date-fns';
import type { PickupRequestStatus } from '../../../types';

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

export default function UpcomingTab({ storeId }: { storeId: string | undefined }) {
  const tomorrow = format(addDays(new Date(), 1), 'yyyy-MM-dd');
  const twoWeeks = format(addDays(new Date(), 14), 'yyyy-MM-dd');
  const [statusFilter, setStatusFilter] = useState<PickupRequestStatus | ''>('');

  const { data: pickups, isLoading } = useStorePickupRequests(storeId, {
    startDate: tomorrow,
    endDate: twoWeeks,
    status: statusFilter || undefined,
  });

  // Group by date
  const grouped = (pickups || []).reduce<Record<string, typeof pickups>>((acc, p) => {
    if (!acc[p.requested_date]) acc[p.requested_date] = [];
    acc[p.requested_date]!.push(p);
    return acc;
  }, {});

  const dates = Object.keys(grouped).sort();

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value as PickupRequestStatus | '')}
          className="px-3 py-2 rounded-lg border border-slate-300 text-sm"
        >
          <option value="">Todos los estados</option>
          <option value="pending">Pendientes</option>
          <option value="confirmed">Confirmadas</option>
          <option value="picked_up">Recogidas</option>
          <option value="cancelled">Canceladas</option>
        </select>
        <span className="text-sm text-slate-500">{pickups?.length || 0} recogida(s) proximas</span>
      </div>

      {isLoading ? (
        <div className="flex justify-center py-12">
          <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
        </div>
      ) : dates.length === 0 ? (
        <div className="text-center py-12">
          <Calendar size={40} className="mx-auto mb-3 text-slate-300" />
          <p className="text-slate-500">No hay recogidas proximas</p>
        </div>
      ) : (
        dates.map((date) => (
          <div key={date}>
            <h3 className="text-sm font-semibold text-slate-700 mb-2 flex items-center gap-2">
              <Calendar size={14} className="text-primary-500" />
              {format(new Date(date + 'T12:00:00'), 'EEEE dd MMM')}
              <span className="text-xs text-slate-400">({grouped[date]!.length})</span>
            </h3>
            <div className="space-y-2">
              {grouped[date]!.map((pickup) => {
                const st = STATUS_STYLES[pickup.status];
                const name = pickup.customer
                  ? `${pickup.customer.first_name} ${pickup.customer.last_name || ''}`.trim()
                  : 'Cliente';
                return (
                  <div key={pickup.id} className="bg-white rounded-lg border border-slate-200 p-3 flex items-center justify-between">
                    <div className="space-y-0.5">
                      <div className="flex items-center gap-2">
                        <span className="text-sm font-medium text-slate-900">{name}</span>
                        <span className={`px-1.5 py-0.5 rounded-full text-[10px] font-medium ${st.bg} ${st.text}`}>
                          {st.label}
                        </span>
                      </div>
                      <p className="text-xs text-slate-500 flex items-center gap-1">
                        <Clock size={11} /> {formatTime(pickup.requested_time_slot)}
                      </p>
                      <p className="text-xs text-slate-400 flex items-center gap-1">
                        <MapPin size={11} /> {pickup.address_line || pickup.customer_location?.address_line || 'Sin direccion'}
                      </p>
                    </div>
                    {pickup.customer?.phone && (
                      <a
                        href={`tel:${pickup.customer.phone}`}
                        className="p-2 rounded-lg bg-slate-50 hover:bg-slate-100 text-slate-500"
                      >
                        <Phone size={14} />
                      </a>
                    )}
                  </div>
                );
              })}
            </div>
          </div>
        ))
      )}
    </div>
  );
}
