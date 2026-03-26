import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

// Fix Leaflet default marker icon paths broken by Vite bundler
const iconUrl = 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png';
const iconRetinaUrl = 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png';
const shadowUrl = 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png';

L.Icon.Default.mergeOptions({
  iconUrl,
  iconRetinaUrl,
  shadowUrl,
});

// Status-colored marker icons for pickup map
export function createStatusIcon(status: 'pending' | 'confirmed' | 'picked_up' | 'cancelled'): L.DivIcon {
  const colors: Record<string, string> = {
    pending: '#f59e0b',    // amber
    confirmed: '#3b82f6',  // blue
    picked_up: '#10b981',  // emerald
    cancelled: '#ef4444',  // red
  };
  const color = colors[status] || '#6b7280';

  return L.divIcon({
    className: '',
    html: `<div style="
      width: 28px; height: 28px;
      background: ${color};
      border: 3px solid white;
      border-radius: 50%;
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
    "></div>`,
    iconSize: [28, 28],
    iconAnchor: [14, 14],
    popupAnchor: [0, -16],
  });
}

// Numbered marker for route stops
export function createNumberedIcon(num: number): L.DivIcon {
  return L.divIcon({
    className: '',
    html: `<div style="
      width: 32px; height: 32px;
      background: #3b82f6;
      border: 3px solid white;
      border-radius: 50%;
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
      display: flex; align-items: center; justify-content: center;
      color: white; font-weight: 700; font-size: 14px;
    ">${num}</div>`,
    iconSize: [32, 32],
    iconAnchor: [16, 16],
    popupAnchor: [0, -18],
  });
}

// Panama City center coordinates
export const PANAMA_CENTER: [number, number] = [9.0, -79.5];
export const DEFAULT_ZOOM = 13;
