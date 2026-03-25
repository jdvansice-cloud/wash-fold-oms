import React, { useState, useEffect } from 'react';
import { Save, Plus, Trash2, Calendar } from 'lucide-react';
import { supabase } from '../../lib/supabase';
import type { PickupSchedule, PickupBlockedDate } from '../../types';

const DAY_NAMES = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'];

interface PickupScheduleSettingsProps {
  storeId: string;
}

interface ScheduleRow {
  day_of_week: number;
  is_active: boolean;
  start_time: string;
  end_time: string;
  slot_duration_minutes: number;
  max_pickups_per_slot: number;
}

const DEFAULT_SCHEDULE: ScheduleRow[] = Array.from({ length: 7 }, (_, i) => ({
  day_of_week: i,
  is_active: i >= 1 && i <= 5, // Mon-Fri active by default
  start_time: '08:00',
  end_time: i === 6 ? '14:00' : '17:00',
  slot_duration_minutes: 30,
  max_pickups_per_slot: 3,
}));

export default function PickupScheduleSettings({ storeId }: PickupScheduleSettingsProps) {
  const [schedule, setSchedule] = useState<ScheduleRow[]>(DEFAULT_SCHEDULE);
  const [blockedDates, setBlockedDates] = useState<PickupBlockedDate[]>([]);
  const [newBlockedDate, setNewBlockedDate] = useState('');
  const [newBlockedReason, setNewBlockedReason] = useState('');
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  // Load existing schedule
  useEffect(() => {
    if (!storeId) return;
    const load = async () => {
      const { data: scheduleData } = await supabase
        .from('pickup_schedules')
        .select('*')
        .eq('store_id', storeId)
        .order('day_of_week');

      if (scheduleData && scheduleData.length > 0) {
        const merged = DEFAULT_SCHEDULE.map((def) => {
          const existing = scheduleData.find((s: PickupSchedule) => s.day_of_week === def.day_of_week);
          return existing ? { ...def, ...existing } : def;
        });
        setSchedule(merged);
      }

      const { data: blockedData } = await supabase
        .from('pickup_blocked_dates')
        .select('*')
        .eq('store_id', storeId)
        .order('blocked_date');

      if (blockedData) setBlockedDates(blockedData as PickupBlockedDate[]);
    };
    load();
  }, [storeId]);

  const updateDay = (dayIndex: number, field: string, value: unknown) => {
    setSchedule((prev) =>
      prev.map((row) => (row.day_of_week === dayIndex ? { ...row, [field]: value } : row)),
    );
  };

  const handleSaveSchedule = async () => {
    setSaving(true);
    try {
      for (const row of schedule) {
        await supabase.from('pickup_schedules').upsert(
          {
            store_id: storeId,
            day_of_week: row.day_of_week,
            is_active: row.is_active,
            start_time: row.start_time,
            end_time: row.end_time,
            slot_duration_minutes: row.slot_duration_minutes,
            max_pickups_per_slot: row.max_pickups_per_slot,
            updated_at: new Date().toISOString(),
          },
          { onConflict: 'store_id,day_of_week' },
        );
      }
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch (err) {
      console.error('Error saving schedule:', err);
    } finally {
      setSaving(false);
    }
  };

  const handleAddBlockedDate = async () => {
    if (!newBlockedDate) return;
    const { data, error } = await supabase
      .from('pickup_blocked_dates')
      .insert({
        store_id: storeId,
        blocked_date: newBlockedDate,
        reason: newBlockedReason || null,
      })
      .select()
      .single();

    if (!error && data) {
      setBlockedDates((prev) => [...prev, data as PickupBlockedDate]);
      setNewBlockedDate('');
      setNewBlockedReason('');
    }
  };

  const handleRemoveBlockedDate = async (id: string) => {
    const { error } = await supabase.from('pickup_blocked_dates').delete().eq('id', id);
    if (!error) {
      setBlockedDates((prev) => prev.filter((d) => d.id !== id));
    }
  };

  return (
    <div className="space-y-8">
      {/* Weekly Schedule */}
      <div>
        <h3 className="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
          <Calendar size={20} className="text-primary-500" />
          Horario Semanal de Recogida
        </h3>

        <div className="space-y-3">
          {schedule.map((row) => (
            <div
              key={row.day_of_week}
              className={`flex items-center gap-4 p-3 rounded-xl border ${
                row.is_active ? 'bg-white border-gray-200' : 'bg-gray-50 border-gray-100'
              }`}
            >
              <label className="flex items-center gap-2 w-28 shrink-0">
                <input
                  type="checkbox"
                  checked={row.is_active}
                  onChange={(e) => updateDay(row.day_of_week, 'is_active', e.target.checked)}
                  className="rounded border-gray-300 text-primary-600 focus:ring-primary-500"
                />
                <span className={`text-sm font-medium ${row.is_active ? 'text-gray-700' : 'text-gray-400'}`}>
                  {DAY_NAMES[row.day_of_week]}
                </span>
              </label>

              {row.is_active && (
                <>
                  <input
                    type="time"
                    value={row.start_time}
                    onChange={(e) => updateDay(row.day_of_week, 'start_time', e.target.value)}
                    className="px-2 py-1.5 rounded-lg border border-gray-300 text-sm"
                  />
                  <span className="text-gray-400">a</span>
                  <input
                    type="time"
                    value={row.end_time}
                    onChange={(e) => updateDay(row.day_of_week, 'end_time', e.target.value)}
                    className="px-2 py-1.5 rounded-lg border border-gray-300 text-sm"
                  />
                  <div className="flex items-center gap-1">
                    <input
                      type="number"
                      value={row.slot_duration_minutes}
                      onChange={(e) =>
                        updateDay(row.day_of_week, 'slot_duration_minutes', parseInt(e.target.value) || 30)
                      }
                      className="w-16 px-2 py-1.5 rounded-lg border border-gray-300 text-sm"
                      min={15}
                      max={120}
                    />
                    <span className="text-xs text-gray-400">min</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <span className="text-xs text-gray-400">Max</span>
                    <input
                      type="number"
                      value={row.max_pickups_per_slot}
                      onChange={(e) =>
                        updateDay(row.day_of_week, 'max_pickups_per_slot', parseInt(e.target.value) || 1)
                      }
                      className="w-14 px-2 py-1.5 rounded-lg border border-gray-300 text-sm"
                      min={1}
                      max={20}
                    />
                  </div>
                </>
              )}
            </div>
          ))}
        </div>

        <button
          onClick={handleSaveSchedule}
          disabled={saving}
          className="mt-4 px-4 py-2 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 disabled:opacity-50 flex items-center gap-2"
        >
          <Save size={16} />
          {saving ? 'Guardando...' : 'Guardar Horario'}
        </button>
        {saved && <p className="text-sm text-emerald-600 mt-2">Horario guardado</p>}
      </div>

      {/* Blocked Dates */}
      <div>
        <h3 className="text-lg font-semibold text-gray-800 mb-4">Fechas Bloqueadas</h3>
        <p className="text-sm text-gray-500 mb-3">
          Agrega fechas en las que no se realizaran recogidas (feriados, cierres, etc.)
        </p>

        <div className="flex items-end gap-3 mb-4">
          <div>
            <label className="block text-xs text-gray-500 mb-1">Fecha</label>
            <input
              type="date"
              value={newBlockedDate}
              onChange={(e) => setNewBlockedDate(e.target.value)}
              className="px-3 py-2 rounded-lg border border-gray-300 text-sm"
            />
          </div>
          <div className="flex-1">
            <label className="block text-xs text-gray-500 mb-1">Razon (opcional)</label>
            <input
              type="text"
              value={newBlockedReason}
              onChange={(e) => setNewBlockedReason(e.target.value)}
              placeholder="Ej: Feriado nacional"
              className="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm"
            />
          </div>
          <button
            onClick={handleAddBlockedDate}
            disabled={!newBlockedDate}
            className="px-3 py-2 bg-slate-700 text-white rounded-lg text-sm hover:bg-slate-800 disabled:opacity-50 flex items-center gap-1"
          >
            <Plus size={14} />
            Agregar
          </button>
        </div>

        {blockedDates.length > 0 ? (
          <div className="space-y-2">
            {blockedDates.map((bd) => (
              <div key={bd.id} className="flex items-center justify-between p-3 bg-white rounded-lg border border-gray-200">
                <div>
                  <span className="text-sm font-medium text-gray-700">{bd.blocked_date}</span>
                  {bd.reason && <span className="text-sm text-gray-400 ml-2">- {bd.reason}</span>}
                </div>
                <button
                  onClick={() => handleRemoveBlockedDate(bd.id)}
                  className="p-1 text-red-400 hover:text-red-600 hover:bg-red-50 rounded"
                >
                  <Trash2 size={14} />
                </button>
              </div>
            ))}
          </div>
        ) : (
          <p className="text-sm text-gray-400 italic">No hay fechas bloqueadas</p>
        )}
      </div>
    </div>
  );
}
