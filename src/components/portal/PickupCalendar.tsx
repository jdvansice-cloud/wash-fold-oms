import React from 'react';
import type { DayAvailability } from '@/types';

const dayNames = ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'];

interface PickupCalendarProps {
  days: DayAvailability[];
  selectedDate: string | null;
  onSelectDate: (date: string) => void;
}

export function PickupCalendar({ days, selectedDate, onSelectDate }: PickupCalendarProps) {
  return (
    <div>
      <h3 className="text-sm font-medium text-slate-700 mb-3">Selecciona una fecha</h3>
      <div className="grid grid-cols-7 gap-2">
        {days.map((day) => {
          const dateObj = new Date(day.date + 'T12:00:00');
          const dayNum = dateObj.getDate();
          const dayName = dayNames[day.dayOfWeek];
          const isSelected = selectedDate === day.date;
          const isAvailable = day.isOpen && !day.isBlocked && day.hasAvailableSlots;

          return (
            <button
              key={day.date}
              onClick={() => isAvailable && onSelectDate(day.date)}
              disabled={!isAvailable}
              className={`flex flex-col items-center p-2 rounded-xl text-center transition-all ${
                isSelected
                  ? 'bg-primary-500 text-white shadow-sm ring-2 ring-primary-300'
                  : isAvailable
                    ? 'bg-white border border-slate-200 hover:border-primary-300 hover:bg-primary-50 cursor-pointer'
                    : 'bg-slate-50 text-slate-300 cursor-not-allowed'
              }`}
              title={day.isBlocked ? day.blockedReason || 'No disponible' : undefined}
            >
              <span className={`text-[10px] font-medium ${isSelected ? 'text-primary-100' : isAvailable ? 'text-slate-500' : ''}`}>
                {dayName}
              </span>
              <span className={`text-lg font-semibold ${isSelected ? '' : isAvailable ? 'text-slate-900' : ''}`}>
                {dayNum}
              </span>
              <span className={`text-[8px] ${isSelected ? 'text-primary-200' : isAvailable ? 'text-emerald-500' : 'text-slate-300'}`}>
                {isAvailable ? 'Disponible' : day.isBlocked ? 'Cerrado' : !day.isOpen ? 'Cerrado' : 'Lleno'}
              </span>
            </button>
          );
        })}
      </div>
    </div>
  );
}
