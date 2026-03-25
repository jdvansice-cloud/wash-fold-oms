import React from 'react';
import { Check } from 'lucide-react';
import type { OrderStatus } from '@/types';

const steps: { status: OrderStatus; label: string }[] = [
  { status: 'pending', label: 'Recibido' },
  { status: 'washing', label: 'Lavando' },
  { status: 'drying', label: 'Secando' },
  { status: 'folding', label: 'Doblando' },
  { status: 'ready', label: 'Listo' },
  { status: 'completed', label: 'Entregado' },
];

const statusOrder: OrderStatus[] = ['pending', 'washing', 'drying', 'folding', 'ready', 'completed'];

interface OrderTimelineProps {
  currentStatus: OrderStatus;
}

export function OrderTimeline({ currentStatus }: OrderTimelineProps) {
  const currentIndex = statusOrder.indexOf(currentStatus);
  const isCancelled = currentStatus === 'cancelled' || currentStatus === 'refunded' || currentStatus === 'refund';

  if (isCancelled) {
    return (
      <div className="flex items-center justify-center py-4">
        <span className="px-3 py-1.5 rounded-full bg-red-100 text-red-700 text-sm font-medium">
          {currentStatus === 'cancelled' ? 'Cancelado' : 'Reembolsado'}
        </span>
      </div>
    );
  }

  return (
    <div className="py-4">
      {/* Desktop: horizontal */}
      <div className="hidden sm:flex items-center justify-between">
        {steps.map((step, i) => {
          const isCompleted = i < currentIndex;
          const isCurrent = i === currentIndex;
          return (
            <React.Fragment key={step.status}>
              {i > 0 && (
                <div
                  className={`flex-1 h-0.5 ${isCompleted ? 'bg-primary-500' : 'bg-slate-200'}`}
                />
              )}
              <div className="flex flex-col items-center gap-1">
                <div
                  className={`w-8 h-8 rounded-full flex items-center justify-center text-xs font-medium ${
                    isCompleted
                      ? 'bg-primary-500 text-white'
                      : isCurrent
                        ? 'bg-primary-100 text-primary-700 ring-2 ring-primary-500'
                        : 'bg-slate-100 text-slate-400'
                  }`}
                >
                  {isCompleted ? <Check size={14} /> : i + 1}
                </div>
                <span
                  className={`text-[10px] font-medium ${
                    isCurrent ? 'text-primary-700' : isCompleted ? 'text-slate-700' : 'text-slate-400'
                  }`}
                >
                  {step.label}
                </span>
              </div>
            </React.Fragment>
          );
        })}
      </div>

      {/* Mobile: vertical */}
      <div className="sm:hidden space-y-3">
        {steps.map((step, i) => {
          const isCompleted = i < currentIndex;
          const isCurrent = i === currentIndex;
          return (
            <div key={step.status} className="flex items-center gap-3">
              <div
                className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-medium shrink-0 ${
                  isCompleted
                    ? 'bg-primary-500 text-white'
                    : isCurrent
                      ? 'bg-primary-100 text-primary-700 ring-2 ring-primary-500'
                      : 'bg-slate-100 text-slate-400'
                }`}
              >
                {isCompleted ? <Check size={12} /> : i + 1}
              </div>
              <span
                className={`text-sm ${
                  isCurrent ? 'font-medium text-primary-700' : isCompleted ? 'text-slate-700' : 'text-slate-400'
                }`}
              >
                {step.label}
              </span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
