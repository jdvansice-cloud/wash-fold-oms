import React from 'react';
import { MapContainer, TileLayer, Marker, Popup, Polyline } from 'react-leaflet';
import { PANAMA_CENTER, DEFAULT_ZOOM, createStatusIcon, createNumberedIcon, createStoreIcon } from './leafletSetup';
import './leafletSetup';
import type { PickupRequest } from '@/types';

interface PickupMapViewProps {
  pickups: PickupRequest[];
  routeOrder?: string[]; // ordered IDs for route polyline
  storeLocation?: { lat: number; lng: number }; // starting point for routes
  height?: string;
}

export default function PickupMapView({ pickups, routeOrder, storeLocation, height = '400px' }: PickupMapViewProps) {
  // Only show pickups that have coordinates
  const mappable = pickups.filter((p) => p.latitude && p.longitude);

  // Compute center from pickups or default to Panama
  const center: [number, number] =
    mappable.length > 0
      ? [
          mappable.reduce((sum, p) => sum + (p.latitude || 0), 0) / mappable.length,
          mappable.reduce((sum, p) => sum + (p.longitude || 0), 0) / mappable.length,
        ]
      : PANAMA_CENTER;

  // Build route polyline if routeOrder is provided (starting from store)
  const routePositions: [number, number][] = [];
  if (routeOrder) {
    // Start from store location
    if (storeLocation) {
      routePositions.push([storeLocation.lat, storeLocation.lng]);
    }
    for (const id of routeOrder) {
      const p = mappable.find((m) => m.id === id);
      if (p?.latitude && p?.longitude) {
        routePositions.push([p.latitude, p.longitude]);
      }
    }
  }

  const formatTime = (t: string) => {
    const [h, m] = t.split(':');
    const hour = parseInt(h);
    const ampm = hour >= 12 ? 'PM' : 'AM';
    return `${hour > 12 ? hour - 12 : hour || 12}:${m} ${ampm}`;
  };

  if (mappable.length === 0) {
    return (
      <div
        className="flex items-center justify-center bg-slate-50 rounded-xl border border-slate-200 text-slate-400 text-sm"
        style={{ height }}
      >
        No hay recogidas con ubicacion en el mapa
      </div>
    );
  }

  return (
    <div className="rounded-xl overflow-hidden border border-slate-200" style={{ height }}>
      <MapContainer
        center={center}
        zoom={mappable.length === 1 ? 15 : DEFAULT_ZOOM}
        style={{ height: '100%', width: '100%' }}
        scrollWheelZoom={true}
      >
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        {/* Store starting point marker */}
        {storeLocation && (
          <Marker
            position={[storeLocation.lat, storeLocation.lng]}
            icon={createStoreIcon()}
          >
            <Popup>
              <p className="text-xs font-semibold">Tienda (Punto de inicio)</p>
            </Popup>
          </Marker>
        )}

        {mappable.map((pickup, idx) => {
          const routeIdx = routeOrder?.indexOf(pickup.id);
          const icon =
            routeOrder && routeIdx !== undefined && routeIdx >= 0
              ? createNumberedIcon(routeIdx + 1)
              : createStatusIcon(pickup.status);

          const customerName = pickup.customer
            ? `${pickup.customer.first_name} ${pickup.customer.last_name || ''}`.trim()
            : 'Cliente';

          return (
            <Marker
              key={pickup.id}
              position={[pickup.latitude!, pickup.longitude!]}
              icon={icon}
            >
              <Popup>
                <div className="text-xs space-y-1 min-w-[150px]">
                  <p className="font-semibold text-sm">{customerName}</p>
                  <p className="text-slate-500">
                    {pickup.requested_date} — {formatTime(pickup.requested_time_slot)}
                  </p>
                  <p className="text-slate-600">
                    {pickup.address_line || pickup.customer_location?.address_line || 'Sin direccion'}
                  </p>
                  {pickup.customer?.phone && (
                    <p className="text-slate-500">Tel: {pickup.customer.phone}</p>
                  )}
                </div>
              </Popup>
            </Marker>
          );
        })}

        {routePositions.length > 1 && (
          <Polyline positions={routePositions} color="#3b82f6" weight={3} opacity={0.7} dashArray="8 4" />
        )}
      </MapContainer>
    </div>
  );
}
