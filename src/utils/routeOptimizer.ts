// Haversine distance in km between two lat/lng points
function haversine(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) * Math.cos((lat2 * Math.PI) / 180) * Math.sin(dLon / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

interface PickupPoint {
  id: string;
  latitude: number;
  longitude: number;
}

/**
 * Greedy nearest-neighbor route optimization.
 * Starts from the store location, always visits the closest unvisited pickup.
 * Returns pickup IDs in optimized order.
 */
export function optimizeRoute(
  storeLocation: { lat: number; lng: number },
  pickups: PickupPoint[],
): string[] {
  if (pickups.length <= 1) return pickups.map((p) => p.id);

  const remaining = [...pickups];
  const ordered: string[] = [];
  let currentLat = storeLocation.lat;
  let currentLng = storeLocation.lng;

  while (remaining.length > 0) {
    let nearestIdx = 0;
    let nearestDist = Infinity;

    for (let i = 0; i < remaining.length; i++) {
      const dist = haversine(currentLat, currentLng, remaining[i].latitude, remaining[i].longitude);
      if (dist < nearestDist) {
        nearestDist = dist;
        nearestIdx = i;
      }
    }

    const next = remaining.splice(nearestIdx, 1)[0];
    ordered.push(next.id);
    currentLat = next.latitude;
    currentLng = next.longitude;
  }

  return ordered;
}
