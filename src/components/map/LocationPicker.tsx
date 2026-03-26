import React, { useState, useCallback } from 'react';
import { MapContainer, TileLayer, Marker, useMapEvents } from 'react-leaflet';
import { Navigation } from 'lucide-react';
import { PANAMA_CENTER, DEFAULT_ZOOM } from './leafletSetup';
import './leafletSetup'; // ensure icons are configured

interface LocationPickerProps {
  latitude?: number;
  longitude?: number;
  onLocationChange: (lat: number, lng: number) => void;
  height?: string;
}

function DraggableMarker({
  position,
  onMove,
}: {
  position: [number, number];
  onMove: (lat: number, lng: number) => void;
}) {
  useMapEvents({
    click(e) {
      onMove(e.latlng.lat, e.latlng.lng);
    },
  });

  return (
    <Marker
      position={position}
      draggable
      eventHandlers={{
        dragend: (e) => {
          const marker = e.target;
          const pos = marker.getLatLng();
          onMove(pos.lat, pos.lng);
        },
      }}
    />
  );
}

export default function LocationPicker({
  latitude,
  longitude,
  onLocationChange,
  height = '280px',
}: LocationPickerProps) {
  const [position, setPosition] = useState<[number, number]>(
    latitude && longitude ? [latitude, longitude] : PANAMA_CENTER,
  );
  const [locating, setLocating] = useState(false);

  const handleMove = useCallback(
    (lat: number, lng: number) => {
      setPosition([lat, lng]);
      onLocationChange(lat, lng);
    },
    [onLocationChange],
  );

  const handleUseMyLocation = () => {
    if (!navigator.geolocation) return;
    setLocating(true);
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        handleMove(pos.coords.latitude, pos.coords.longitude);
        setLocating(false);
      },
      () => setLocating(false),
      { enableHighAccuracy: true, timeout: 10000 },
    );
  };

  return (
    <div className="space-y-2">
      <div className="relative rounded-xl overflow-hidden border border-slate-200" style={{ height }}>
        <MapContainer
          center={position}
          zoom={latitude && longitude ? 16 : DEFAULT_ZOOM}
          style={{ height: '100%', width: '100%' }}
          scrollWheelZoom={false}
          zoomControl={true}
        >
          <TileLayer
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          />
          <DraggableMarker position={position} onMove={handleMove} />
        </MapContainer>
      </div>

      <div className="flex items-center justify-between">
        <button
          type="button"
          onClick={handleUseMyLocation}
          disabled={locating}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-primary-600 bg-primary-50 rounded-lg hover:bg-primary-100 disabled:opacity-50 transition-colors"
        >
          <Navigation size={14} className={locating ? 'animate-pulse' : ''} />
          {locating ? 'Buscando...' : 'Usar mi ubicacion'}
        </button>
        <span className="text-[10px] text-slate-400">
          {position[0].toFixed(5)}, {position[1].toFixed(5)}
        </span>
      </div>
    </div>
  );
}
