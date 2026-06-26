import React, { useEffect, useState } from 'react';
import { Clock, Users } from 'lucide-react';
import { fetchStoreDayEntries, workedMinutes } from '../hooks/queries/useTimeClock';
import { dayScheduledHours } from '../utils/schedule';

const WEEKDAY_KEYS = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

const fmtTime = (iso) =>
  iso ? new Date(iso).toLocaleTimeString('es-PA', { hour: '2-digit', minute: '2-digit' }) : '—';

const fmtHM = (min) => {
  const h = Math.floor(min / 60);
  const m = min % 60;
  return h > 0 ? `${h}h ${m}m` : `${m}m`;
};

/**
 * EOD attendance: each staff member's clock in/out and worked-vs-scheduled
 * hours for the selected day. Scheduled hours come from users.weekly_hours.
 * Degrades to an empty state if the time_entries table isn't there yet.
 */
function AttendanceCard({ storeId, selectedDate }) {
  const [entries, setEntries] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let alive = true;
    (async () => {
      if (!storeId) return;
      setLoading(true);
      // Parse as LOCAL midnight (selectedDate is a YYYY-MM-DD wall-clock date);
      // `new Date('YYYY-MM-DD')` would parse as UTC and shift the day in -05:00.
      const start = new Date(`${selectedDate}T00:00:00`);
      const end = new Date(`${selectedDate}T23:59:59.999`);
      const data = await fetchStoreDayEntries(storeId, start.toISOString(), end.toISOString());
      if (alive) {
        setEntries(data);
        setLoading(false);
      }
    })();
    return () => {
      alive = false;
    };
  }, [storeId, selectedDate]);

  const weekdayKey = WEEKDAY_KEYS[new Date(`${selectedDate}T00:00:00`).getDay()];

  // Aggregate per staff member: first in, last out, total worked, scheduled.
  const byUser = new Map();
  for (const e of entries) {
    const k = e.user_id;
    const cur = byUser.get(k) || {
      name: e.users?.full_name || 'Empleado',
      scheduled: dayScheduledHours(e.users?.weekly_hours?.[weekdayKey]),
      firstIn: e.clock_in,
      lastOut: e.clock_out,
      worked: 0,
      open: false,
    };
    if (new Date(e.clock_in) < new Date(cur.firstIn)) cur.firstIn = e.clock_in;
    if (!e.clock_out) cur.open = true;
    else if (!cur.lastOut || new Date(e.clock_out) > new Date(cur.lastOut)) cur.lastOut = e.clock_out;
    cur.worked += workedMinutes(e);
    byUser.set(k, cur);
  }
  const rows = [...byUser.values()].sort((a, b) => a.name.localeCompare(b.name));
  const totalWorked = rows.reduce((s, r) => s + r.worked, 0);
  const totalScheduled = rows.reduce((s, r) => s + r.scheduled, 0);

  return (
    <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
      <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Clock className="w-5 h-5 text-primary-500" />
          <h2 className="font-semibold text-slate-800">Asistencia</h2>
        </div>
        {rows.length > 0 && (
          <span className="text-sm text-slate-500">
            {fmtHM(totalWorked)} trab. {totalScheduled > 0 && `/ ${totalScheduled}h prog.`}
          </span>
        )}
      </div>

      {loading ? (
        <div className="p-5 text-sm text-slate-400">Cargando…</div>
      ) : rows.length === 0 ? (
        <div className="p-8 text-center">
          <Users className="w-8 h-8 text-slate-300 mx-auto mb-2" />
          <p className="text-sm text-slate-400">Sin marcaciones registradas este día</p>
        </div>
      ) : (
        <div className="divide-y divide-slate-50">
          <div className="grid grid-cols-12 gap-2 px-5 py-2 text-[11px] font-medium uppercase tracking-wide text-slate-400">
            <div className="col-span-4">Empleado</div>
            <div className="col-span-2 text-center">Entrada</div>
            <div className="col-span-2 text-center">Salida</div>
            <div className="col-span-2 text-right">Trabajado</div>
            <div className="col-span-2 text-right">Programado</div>
          </div>
          {rows.map((r, i) => {
            const schedMin = r.scheduled * 60;
            const over = schedMin > 0 && r.worked > schedMin;
            const under = schedMin > 0 && r.worked < schedMin;
            return (
              <div key={i} className="grid grid-cols-12 gap-2 px-5 py-2.5 items-center text-sm">
                <div className="col-span-4 font-medium text-slate-700 truncate">{r.name}</div>
                <div className="col-span-2 text-center text-slate-600">{fmtTime(r.firstIn)}</div>
                <div className="col-span-2 text-center">
                  {r.open ? (
                    <span className="inline-flex items-center gap-1 text-emerald-600 text-xs font-medium">
                      <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                      Activo
                    </span>
                  ) : (
                    <span className="text-slate-600">{fmtTime(r.lastOut)}</span>
                  )}
                </div>
                <div
                  className={`col-span-2 text-right font-semibold ${
                    over ? 'text-amber-600' : under ? 'text-slate-500' : 'text-slate-700'
                  }`}
                >
                  {fmtHM(r.worked)}
                </div>
                <div className="col-span-2 text-right text-slate-500">
                  {r.scheduled > 0 ? `${r.scheduled}h` : '—'}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

export default AttendanceCard;
