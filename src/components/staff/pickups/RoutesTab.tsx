import React, { useState } from 'react';
import { Route as RouteIcon, Plus, Play, CheckCircle, Navigation } from 'lucide-react';
import { useStorePickupRequests } from '../../../hooks/queries/usePickupRequests';
import { useStorePickupRoutes, useCreateRoute, useUpdateRoute } from '../../../hooks/queries/usePickupRoutes';
import { useAuth } from '../../../context/AuthContext';
import { optimizeRoute } from '../../../utils/routeOptimizer';
import { format } from 'date-fns';
import PickupMapView from '../../map/PickupMapView';
import type { PickupRoute } from '../../../types';

const PANAMA_STORE = { lat: 9.0, lng: -79.5 }; // default store location

export default function RoutesTab({ storeId }: { storeId: string | undefined }) {
  const { appUser } = useAuth();
  const today = format(new Date(), 'yyyy-MM-dd');
  const [routeDate, setRouteDate] = useState(today);
  const [selectedPickups, setSelectedPickups] = useState<string[]>([]);
  const [driverName, setDriverName] = useState('');
  const [viewingRoute, setViewingRoute] = useState<PickupRoute | null>(null);

  const { data: pickups } = useStorePickupRequests(storeId, {
    startDate: routeDate,
    endDate: routeDate,
  });
  const { data: routes } = useStorePickupRoutes(storeId, routeDate);
  const createRoute = useCreateRoute();
  const updateRoute = useUpdateRoute();

  // Confirmed pickups without a route assigned
  const unassigned = pickups?.filter(
    (p) => p.status === 'confirmed' && !p.route_id && p.latitude && p.longitude,
  ) || [];

  const togglePickup = (id: string) => {
    setSelectedPickups((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id],
    );
  };

  const handleOptimize = () => {
    const points = selectedPickups
      .map((id) => unassigned.find((p) => p.id === id))
      .filter((p) => p?.latitude && p?.longitude)
      .map((p) => ({ id: p!.id, latitude: p!.latitude!, longitude: p!.longitude! }));

    const optimized = optimizeRoute(PANAMA_STORE, points);
    setSelectedPickups(optimized);
  };

  const handleCreateRoute = async () => {
    if (!storeId || selectedPickups.length === 0) return;
    await createRoute.mutateAsync({
      store_id: storeId,
      route_date: routeDate,
      driver_name: driverName || undefined,
      route_order: selectedPickups,
      created_by: appUser?.id,
    });
    setSelectedPickups([]);
    setDriverName('');
  };

  const handleStartRoute = (route: PickupRoute) => {
    updateRoute.mutate({ id: route.id, status: 'in_progress' });
  };

  const handleCompleteRoute = (route: PickupRoute) => {
    updateRoute.mutate({ id: route.id, status: 'completed' });
  };

  const routeStatusStyles: Record<string, { bg: string; text: string; label: string }> = {
    planned: { bg: 'bg-blue-100', text: 'text-blue-700', label: 'Planificada' },
    in_progress: { bg: 'bg-amber-100', text: 'text-amber-700', label: 'En Progreso' },
    completed: { bg: 'bg-emerald-100', text: 'text-emerald-700', label: 'Completada' },
  };

  return (
    <div className="space-y-6">
      {/* Date Selector */}
      <div className="flex items-center gap-3">
        <input
          type="date"
          value={routeDate}
          onChange={(e) => { setRouteDate(e.target.value); setViewingRoute(null); }}
          className="px-3 py-2 rounded-lg border border-slate-300 text-sm"
        />
      </div>

      {/* Existing Routes */}
      {routes && routes.length > 0 && (
        <div>
          <h3 className="text-sm font-medium text-slate-700 mb-2">Rutas del dia</h3>
          <div className="space-y-2">
            {routes.map((route) => {
              const st = routeStatusStyles[route.status] || routeStatusStyles.planned;
              return (
                <div key={route.id} className="bg-white rounded-xl border border-slate-200 p-4">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <RouteIcon size={16} className="text-primary-500" />
                      <span className="text-sm font-medium text-slate-900">
                        {route.driver_name || 'Sin conductor'}
                      </span>
                      <span className={`px-2 py-0.5 rounded-full text-[10px] font-medium ${st.bg} ${st.text}`}>
                        {st.label}
                      </span>
                      <span className="text-xs text-slate-400">
                        {route.route_order.length} paradas
                      </span>
                    </div>
                    <div className="flex gap-1.5">
                      <button
                        onClick={() => setViewingRoute(viewingRoute?.id === route.id ? null : route)}
                        className="px-2.5 py-1.5 text-xs bg-slate-100 text-slate-600 rounded-lg hover:bg-slate-200"
                      >
                        {viewingRoute?.id === route.id ? 'Ocultar' : 'Ver mapa'}
                      </button>
                      {route.status === 'planned' && (
                        <button
                          onClick={() => handleStartRoute(route)}
                          className="px-2.5 py-1.5 text-xs bg-amber-500 text-white rounded-lg hover:bg-amber-600 flex items-center gap-1"
                        >
                          <Play size={10} /> Iniciar
                        </button>
                      )}
                      {route.status === 'in_progress' && (
                        <button
                          onClick={() => handleCompleteRoute(route)}
                          className="px-2.5 py-1.5 text-xs bg-emerald-500 text-white rounded-lg hover:bg-emerald-600 flex items-center gap-1"
                        >
                          <CheckCircle size={10} /> Completar
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>

          {/* Route Map View */}
          {viewingRoute && pickups && (
            <div className="mt-4">
              <PickupMapView
                pickups={pickups.filter((p) => viewingRoute.route_order.includes(p.id))}
                routeOrder={viewingRoute.route_order}
                height="400px"
              />
            </div>
          )}
        </div>
      )}

      {/* Create New Route */}
      <div>
        <h3 className="text-sm font-medium text-slate-700 mb-2 flex items-center gap-2">
          <Plus size={14} />
          Crear nueva ruta
        </h3>

        {unassigned.length === 0 ? (
          <div className="bg-slate-50 rounded-xl p-6 text-center">
            <Navigation size={28} className="mx-auto mb-2 text-slate-300" />
            <p className="text-sm text-slate-500">
              No hay recogidas confirmadas con ubicacion GPS sin asignar para este dia
            </p>
            <p className="text-xs text-slate-400 mt-1">
              Las recogidas deben estar confirmadas y tener coordenadas de mapa
            </p>
          </div>
        ) : (
          <div className="space-y-3">
            <div className="flex items-center gap-3">
              <input
                type="text"
                value={driverName}
                onChange={(e) => setDriverName(e.target.value)}
                placeholder="Nombre del conductor"
                className="flex-1 px-3 py-2 rounded-lg border border-slate-300 text-sm"
              />
              <button
                onClick={handleOptimize}
                disabled={selectedPickups.length < 2}
                className="px-3 py-2 bg-slate-700 text-white text-xs font-medium rounded-lg hover:bg-slate-800 disabled:opacity-50 flex items-center gap-1"
              >
                <Navigation size={12} /> Optimizar
              </button>
              <button
                onClick={handleCreateRoute}
                disabled={selectedPickups.length === 0 || createRoute.isPending}
                className="px-3 py-2 bg-primary-500 text-white text-xs font-medium rounded-lg hover:bg-primary-600 disabled:opacity-50 flex items-center gap-1"
              >
                <RouteIcon size={12} /> Crear Ruta
              </button>
            </div>

            <div className="space-y-1.5">
              {unassigned.map((pickup, idx) => {
                const isSelected = selectedPickups.includes(pickup.id);
                const orderNum = isSelected ? selectedPickups.indexOf(pickup.id) + 1 : null;
                const name = pickup.customer
                  ? `${pickup.customer.first_name} ${pickup.customer.last_name || ''}`.trim()
                  : 'Cliente';

                return (
                  <button
                    key={pickup.id}
                    onClick={() => togglePickup(pickup.id)}
                    className={`w-full text-left p-3 rounded-lg border transition-colors flex items-center gap-3 ${
                      isSelected
                        ? 'border-primary-500 bg-primary-50'
                        : 'border-slate-200 bg-white hover:bg-slate-50'
                    }`}
                  >
                    <div
                      className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold ${
                        isSelected
                          ? 'bg-primary-500 text-white'
                          : 'bg-slate-100 text-slate-400'
                      }`}
                    >
                      {orderNum || idx + 1}
                    </div>
                    <div className="flex-1">
                      <span className="text-sm font-medium text-slate-900">{name}</span>
                      <p className="text-xs text-slate-500">
                        {pickup.address_line || pickup.customer_location?.address_line} — {pickup.requested_time_slot}
                      </p>
                    </div>
                  </button>
                );
              })}
            </div>

            {selectedPickups.length > 0 && (
              <PickupMapView
                pickups={unassigned.filter((p) => selectedPickups.includes(p.id))}
                routeOrder={selectedPickups}
                height="350px"
              />
            )}
          </div>
        )}
      </div>
    </div>
  );
}
