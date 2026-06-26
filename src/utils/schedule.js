// Weekly staff schedule helpers.
//
// A user's schedule lives in `users.weekly_hours` (JSONB). Each weekday key
// maps to a shift `{ start, end }` with "HH:MM" 24h strings, e.g.
//   { "mon": { "start": "08:00", "end": "17:00" }, "sat": { "start": "08:00", "end": "12:00" } }
// Days that are off are simply absent.
//
// Legacy data stored a bare number of hours per day (e.g. `{ "mon": 8 }`).
// The helpers below accept both shapes so older rows keep working.

export const WEEKDAYS = [
  { key: 'mon', label: 'Lunes', short: 'Lun' },
  { key: 'tue', label: 'Martes', short: 'Mar' },
  { key: 'wed', label: 'Miércoles', short: 'Mié' },
  { key: 'thu', label: 'Jueves', short: 'Jue' },
  { key: 'fri', label: 'Viernes', short: 'Vie' },
  { key: 'sat', label: 'Sábado', short: 'Sáb' },
  { key: 'sun', label: 'Domingo', short: 'Dom' },
];

export const DEFAULT_SHIFT = { start: '08:00', end: '17:00' };

const toMinutes = (hm) => {
  if (typeof hm !== 'string') return null;
  const [h, m] = hm.split(':').map(Number);
  if (Number.isNaN(h) || Number.isNaN(m)) return null;
  return h * 60 + m;
};

const fromMinutes = (min) => {
  const wrapped = ((min % 1440) + 1440) % 1440;
  const h = Math.floor(wrapped / 60);
  const m = wrapped % 60;
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
};

// Scheduled hours for one day. Accepts a `{ start, end }` shift or a legacy
// bare number. Overnight shifts (end before start) wrap to the next day.
export function dayScheduledHours(value) {
  if (value == null) return 0;
  if (typeof value === 'number') return value > 0 ? value : 0;
  const s = toMinutes(value.start);
  const e = toMinutes(value.end);
  if (s == null || e == null) return 0;
  let diff = e - s;
  if (diff < 0) diff += 1440;
  return Math.round((diff / 60) * 100) / 100;
}

// Total scheduled hours across a whole weekly_hours map.
export function weeklyScheduledHours(weekly = {}) {
  return WEEKDAYS.reduce((sum, d) => sum + dayScheduledHours(weekly?.[d.key]), 0);
}

// Normalize a stored weekly_hours map into the `{ start, end }` editing shape.
// Legacy numeric days become an 8:00-anchored shift of that many hours.
export function normalizeWeekly(weekly = {}) {
  const out = {};
  for (const d of WEEKDAYS) {
    const v = weekly?.[d.key];
    if (v == null) continue;
    if (typeof v === 'object' && v.start && v.end) {
      out[d.key] = { start: v.start, end: v.end };
    } else if (typeof v === 'number' && v > 0) {
      const startMin = toMinutes(DEFAULT_SHIFT.start);
      out[d.key] = { start: DEFAULT_SHIFT.start, end: fromMinutes(startMin + Math.round(v * 60)) };
    }
  }
  return out;
}
