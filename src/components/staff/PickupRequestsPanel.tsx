import React, { useState } from 'react';
import { Check, X, Truck, Phone, MapPin, Clock } from 'lucide-react';
import { useStorePickupRequests, useUpdatePickupStatus } from '../../hooks/queries/usePickupRequests';
import { formatDate } from '../../utils/formatters';
import { Spinner } from '../ui/Spinner';
import type { PickupRequestStatus } from '../../types';

interface PickupRequestsPanelProps {
  storeId: string;
  userId?: string;
}

const statusLabels: Record<PickupRequestStatus, { label: string; bg: string; text: string }> = {
  pending: { label: 'Pendiente', bg: 'bg-amber-100', text: 'text-amber-700' },
  confirmed: { label: 'Confirmado', bg: 'bg-blue-100', text: 'text-blue-700' },
  picked_up: { label: 'Recogido', bg: 'bg-emerald-100', text: 'text-emerald-700' },
  cancelled: { label: 'Cancelado', bg: 'bg-red-100', text: 'text-red-700' },
};

export default function PickupRequestsPanel({ storeId, userId }: PickupRequestsPanelProps) {
  const [statusFilter, setStatusFilter] = useState<PickupRequestStatus | ''>('');
  const { data: requests, isLoading } = useStorePickupRequests(storeId, {
    status: statusFilter || undefined,
  });
  const updateStatus = useUpdatePickupStatus();

  const handleConfirm = (id: string) => {
    updateStatus.mutate({ id, status: 'confirmed', confirmedBy: userId });
  };

  const handlePickedUp = (id: string) => {
    updateStatus.mutate({ id, status: 'picked_up' });
  };

  const handleCancel = (id: string) => {
    const reason = prompt('Razon de cancelacion:');
    if (reason !== null) {
      updateStatus.mutate({ id, status: 'cancelled', cancelledReason: reason });
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="text-lg font-semibold text-gray-800 flex items-center gap-2">
          <Truck size={20} className="text-primary-500" />
          Solicitudes de Recogida
        </h3>
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value as PickupRequestStatus | '')}
          className="px-3 py-1.5 rounded-lg border border-gray-300 text-sm"
        >
          <option value="">Todos</option>
          <option value="pending">Pendiente</option>
          <option value="confirmed">Confirmado</option>
          <option value="picked_up">Recogido</option>
          <option value="cancelled">Cancelado</option>
        </select>
      </div>

      {isLoading ? (
        <div className="flex justify-center py-8">
          <Spinner />
        </div>
      ) : requests && requests.length > 0 ? (
        <div className="space-y-3">
          {requests.map((req) => {
            const status = statusLabels[req.status as PickupRequestStatus];
            const customer = (req as unknown as Record<string, unknown>).customer as Record<string, string> | undefined;
            const customerName = customer
              ? `${customer.first_name} ${customer.last_name || ''}`.trim()
              : 'Cliente';

            return (
              <div key={req.id} className="bg-white rounded-xl border border-gray-200 p-4">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <p className="font-medium text-gray-900">{customerName}</p>
                    {customer?.phone && (
                      <p className="text-xs text-gray-500 flex items-center gap-1 mt-0.5">
                        <Phone size={10} /> +507 {customer.phone}
                      </p>
                    )}
                  </div>
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${status.bg} ${status.text}`}>
                    {status.label}
                  </span>
                </div>

                <div className="grid grid-cols-2 gap-2 text-sm mb-3">
                  <div className="flex items-center gap-1 text-gray-600">
                    <Clock size={14} />
                    <span>{formatDate(req.requested_date)} - {req.requested_time_slot}</span>
                  </div>
                  {req.address_line && (
                    <div className="flex items-center gap-1 text-gray-600">
                      <MapPin size={14} />
                      <span className="truncate">{req.address_line}</span>
                    </div>
                  )}
                </div>

                {req.notes && (
                  <p className="text-xs text-gray-400 mb-3">Nota: {req.notes}</p>
                )}

                {/* Actions */}
                <div className="flex items-center gap-2">
                  {req.status === 'pending' && (
                    <>
                      <button
                        onClick={() => handleConfirm(req.id)}
                        disabled={updateStatus.isPending}
                        className="px-3 py-1.5 bg-primary-500 text-white rounded-lg text-xs font-medium hover:bg-primary-600 flex items-center gap-1"
                      >
                        <Check size={12} /> Confirmar
                      </button>
                      <button
                        onClick={() => handleCancel(req.id)}
                        disabled={updateStatus.isPending}
                        className="px-3 py-1.5 bg-red-50 text-red-600 rounded-lg text-xs font-medium hover:bg-red-100 flex items-center gap-1"
                      >
                        <X size={12} /> Cancelar
                      </button>
                    </>
                  )}
                  {req.status === 'confirmed' && (
                    <>
                      <button
                        onClick={() => handlePickedUp(req.id)}
                        disabled={updateStatus.isPending}
                        className="px-3 py-1.5 bg-emerald-500 text-white rounded-lg text-xs font-medium hover:bg-emerald-600 flex items-center gap-1"
                      >
                        <Truck size={12} /> Marcar Recogido
                      </button>
                      <button
                        onClick={() => handleCancel(req.id)}
                        disabled={updateStatus.isPending}
                        className="px-3 py-1.5 bg-red-50 text-red-600 rounded-lg text-xs font-medium hover:bg-red-100 flex items-center gap-1"
                      >
                        <X size={12} /> Cancelar
                      </button>
                    </>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-gray-200 p-8 text-center">
          <Truck size={32} className="mx-auto mb-2 text-gray-300" />
          <p className="text-sm text-gray-500">
            {statusFilter ? 'No hay solicitudes con este estado' : 'No hay solicitudes de recogida'}
          </p>
        </div>
      )}
    </div>
  );
}
