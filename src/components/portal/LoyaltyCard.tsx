import React from 'react';
import { Star, Gift } from 'lucide-react';
import { formatCurrency } from '@/utils/formatters';
import type { CustomerLoyalty, LoyaltySettings } from '@/types';

interface LoyaltyCardProps {
  loyalty: CustomerLoyalty | null;
  settings: LoyaltySettings | null;
  compact?: boolean;
}

export function LoyaltyCard({ loyalty, settings, compact = false }: LoyaltyCardProps) {
  if (!settings || (!settings.points_enabled && !settings.punch_card_enabled)) {
    return null;
  }

  if (compact) {
    return (
      <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 flex items-center gap-4">
        <div className="bg-amber-400 rounded-xl p-3 text-white flex-shrink-0">
          <Star size={22} />
        </div>
        <div className="flex-1 min-w-0">
          <span className="text-xs font-medium text-amber-700 uppercase tracking-wide">Lealtad</span>
          {settings.points_enabled && (
            <div className="text-xl font-bold text-slate-900">{formatCurrency(loyalty?.points_balance || 0)}</div>
          )}
          {settings.punch_card_enabled && loyalty && (
            <div className="flex items-center gap-3 text-xs text-amber-700">
              {loyalty.pending_free_washes > 0 && (
                <span className="flex items-center gap-1">
                  <Gift size={12} /> {loyalty.pending_free_washes} lavado gratis
                </span>
              )}
              {loyalty.pending_free_drys > 0 && (
                <span className="flex items-center gap-1">
                  <Gift size={12} /> {loyalty.pending_free_drys} secado gratis
                </span>
              )}
            </div>
          )}
        </div>
        <div className="text-amber-400">
          <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M7.5 5l5 5-5 5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/></svg>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {/* Points Section */}
      {settings.points_enabled && (
        <div className="bg-gradient-to-br from-primary-500 to-primary-700 rounded-xl p-6 text-white">
          <div className="flex items-center gap-2 mb-1">
            <Star size={18} className="text-accent-300" />
            <span className="text-sm font-medium opacity-90">Puntos de Lealtad</span>
          </div>
          <div className="text-3xl font-bold mt-2">{formatCurrency(loyalty?.points_balance || 0)}</div>
          <p className="text-xs opacity-75 mt-1">
            Ganas {formatCurrency(settings.points_per_dollar)} por cada B/1.00
          </p>
          {settings.min_redemption_amount > 0 && (
            <p className="text-xs opacity-75">
              Minimo para canjear: {formatCurrency(settings.min_redemption_amount)}
            </p>
          )}
        </div>
      )}

      {/* Punch Card Section */}
      {settings.punch_card_enabled && loyalty && (
        <div className="bg-white rounded-xl border border-slate-200 p-4 space-y-4">
          <h4 className="text-sm font-medium text-slate-700">Tarjeta de Sellos</h4>

          {/* Wash punches */}
          <div>
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs text-slate-500">Lavado</span>
              <span className="text-xs text-slate-500">
                {loyalty.wash_punches}/{settings.wash_punches_required}
              </span>
            </div>
            <PunchRow
              current={loyalty.wash_punches}
              required={settings.wash_punches_required}
            />
            {loyalty.pending_free_washes > 0 && (
              <p className="text-xs text-emerald-600 font-medium mt-1">
                {loyalty.pending_free_washes} lavado(s) gratis disponible(s)
              </p>
            )}
          </div>

          {/* Dry punches */}
          <div>
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs text-slate-500">Secado</span>
              <span className="text-xs text-slate-500">
                {loyalty.dry_punches}/{settings.dry_punches_required}
              </span>
            </div>
            <PunchRow
              current={loyalty.dry_punches}
              required={settings.dry_punches_required}
            />
            {loyalty.pending_free_drys > 0 && (
              <p className="text-xs text-emerald-600 font-medium mt-1">
                {loyalty.pending_free_drys} secado(s) gratis disponible(s)
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

function PunchRow({ current, required }: { current: number; required: number }) {
  return (
    <div className="flex items-center gap-1.5">
      {Array.from({ length: required }, (_, i) => (
        <div
          key={i}
          className={`w-6 h-6 rounded-full border-2 flex items-center justify-center text-xs ${
            i < current
              ? 'bg-primary-500 border-primary-500 text-white'
              : 'border-slate-200 text-slate-300'
          }`}
        >
          {i < current ? '✓' : i + 1}
        </div>
      ))}
    </div>
  );
}
