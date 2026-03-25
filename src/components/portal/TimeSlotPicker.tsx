import React from 'react';
import { Clock } from 'lucide-react';
import type { TimeSlot } from '@/types';

interface TimeSlotPickerProps {
  slots: TimeSlot[];
  selectedSlot: string | null;
  onSelectSlot: (time: string) => void;
  isLoading?: boolean;
}

export function TimeSlotPicker({ slots, selectedSlot, onSelectSlot, isLoading }: TimeSlotPickerProps) {
  if (isLoading) {
    return (
      <div className="flex items-center justify-center py-8">
        <div className="h-6 w-6 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (slots.length === 0) {
    return (
      <div className="text-center py-8 text-slate-500">
        <Clock size={32} className="mx-auto mb-2 text-slate-300" />
        <p className="text-sm">No hay horarios disponibles para esta fecha</p>
      </div>
    );
  }

  return (
    <div>
      <h3 className="text-sm font-medium text-slate-700 mb-3">Selecciona un horario</h3>
      <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
        {slots.map((slot) => {
          const isSelected = selectedSlot === slot.time;
          return (
            <button
              key={slot.time}
              onClick={() => slot.available && onSelectSlot(slot.time)}
              disabled={!slot.available}
              className={`px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
                isSelected
                  ? 'bg-primary-500 text-white shadow-sm'
                  : slot.available
                    ? 'bg-white border border-slate-200 hover:border-primary-300 hover:bg-primary-50 text-slate-700'
                    : 'bg-slate-50 text-slate-300 cursor-not-allowed'
              }`}
            >
              <span>{slot.time} - {slot.endTime}</span>
              {!slot.available && (
                <span className="block text-[10px] mt-0.5">Lleno</span>
              )}
            </button>
          );
        })}
      </div>
    </div>
  );
}
