import React, { useState, lazy, Suspense } from 'react';
import { Truck, Calendar, Map, Route } from 'lucide-react';
import { useTenant } from '../hooks/useTenant';

const TodayTab = lazy(() => import('../components/staff/pickups/TodayTab'));
const UpcomingTab = lazy(() => import('../components/staff/pickups/UpcomingTab'));
const MapTab = lazy(() => import('../components/staff/pickups/MapTab'));
const RoutesTab = lazy(() => import('../components/staff/pickups/RoutesTab'));

const TABS = [
  { id: 'today', label: 'Hoy', icon: Truck },
  { id: 'upcoming', label: 'Proximos', icon: Calendar },
  { id: 'map', label: 'Mapa', icon: Map },
  { id: 'routes', label: 'Rutas', icon: Route },
] as const;

type TabId = (typeof TABS)[number]['id'];

export default function PickupsPage() {
  const { activeStore } = useTenant();
  const storeId = activeStore?.id;
  const [activeTab, setActiveTab] = useState<TabId>('today');

  return (
    <div className="p-6 animate-fade-in">
      <div className="mb-6">
        <h1 className="text-2xl font-display font-bold text-slate-800 flex items-center gap-2">
          <Truck className="w-6 h-6 text-primary-500" />
          Recogidas
        </h1>
        <p className="text-sm text-slate-500">Gestiona las recogidas programadas</p>
      </div>

      {/* Tab Bar */}
      <div className="flex gap-1 bg-slate-100 rounded-xl p-1 mb-6">
        {TABS.map(({ id, label, icon: Icon }) => (
          <button
            key={id}
            onClick={() => setActiveTab(id)}
            className={`flex-1 flex items-center justify-center gap-2 px-4 py-2.5 rounded-lg text-sm font-medium transition-colors ${
              activeTab === id
                ? 'bg-white text-primary-700 shadow-sm'
                : 'text-slate-500 hover:text-slate-700'
            }`}
          >
            <Icon size={16} />
            {label}
          </button>
        ))}
      </div>

      {/* Tab Content */}
      <Suspense
        fallback={
          <div className="flex justify-center py-12">
            <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
          </div>
        }
      >
        {activeTab === 'today' && <TodayTab storeId={storeId} />}
        {activeTab === 'upcoming' && <UpcomingTab storeId={storeId} />}
        {activeTab === 'map' && <MapTab storeId={storeId} />}
        {activeTab === 'routes' && <RoutesTab storeId={storeId} />}
      </Suspense>
    </div>
  );
}
