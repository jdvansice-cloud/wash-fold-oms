import React from 'react';
import { useStorePickupRequests } from '../../../hooks/queries/usePickupRequests';
import { format } from 'date-fns';
import PickupMapView from '../../map/PickupMapView';

export default function MapTab({ storeId }: { storeId: string | undefined }) {
  const today = format(new Date(), 'yyyy-MM-dd');
  const { data: pickups, isLoading } = useStorePickupRequests(storeId, {
    startDate: today,
    endDate: today,
  });

  const active = pickups?.filter((p) => p.status === 'pending' || p.status === 'confirmed') || [];

  if (isLoading) {
    return (
      <div className="flex justify-center py-12">
        <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-sm font-medium text-slate-700">
          Recogidas de hoy en el mapa
        </h2>
        <span className="text-xs text-slate-500">
          {active.filter((p) => p.latitude).length} con ubicacion / {active.length} total
        </span>
      </div>

      <PickupMapView pickups={active} height="500px" />

      <div className="flex items-center gap-4 text-xs text-slate-500">
        <span className="flex items-center gap-1.5">
          <span className="w-3 h-3 rounded-full bg-amber-400" /> Pendiente
        </span>
        <span className="flex items-center gap-1.5">
          <span className="w-3 h-3 rounded-full bg-blue-500" /> Confirmada
        </span>
        <span className="flex items-center gap-1.5">
          <span className="w-3 h-3 rounded-full bg-emerald-500" /> Recogida
        </span>
      </div>
    </div>
  );
}
