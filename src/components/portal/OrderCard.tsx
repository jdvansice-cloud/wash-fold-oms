import React from 'react';
import { Link } from 'react-router-dom';
import { ChevronRight, Zap } from 'lucide-react';
import { formatCurrency, formatDate, formatWeight, formatOrderNumber } from '@/utils/formatters';
import { statusConfig } from '@/data/constants';
import type { Order } from '@/types';

interface OrderCardProps {
  order: Order;
}

export function OrderCard({ order }: OrderCardProps) {
  const status = statusConfig[order.status];
  const displayNumber = order.legacy_order_number || formatOrderNumber(order.order_number);

  return (
    <Link
      to={`/portal/orders/${order.id}`}
      className="block bg-white rounded-xl border border-slate-200 p-4 hover:shadow-card transition-shadow"
    >
      <div className="flex items-start justify-between">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <span className="font-semibold text-slate-900">{displayNumber}</span>
            {order.is_express && (
              <span className="inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded-full bg-accent-100 text-accent-700 text-xs font-medium">
                <Zap size={10} />
                Express
              </span>
            )}
          </div>
          <p className="text-sm text-slate-500">{formatDate(order.created_at)}</p>
          <div className="flex items-center gap-3 mt-2 text-xs text-slate-500">
            {order.total_weight > 0 && <span>{formatWeight(order.total_weight)}</span>}
            {order.total_pieces > 0 && (
              <span>
                {order.total_pieces} {order.total_pieces === 1 ? 'pieza' : 'piezas'}
              </span>
            )}
          </div>
        </div>
        <div className="flex flex-col items-end gap-2">
          {status && (
            <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${status.bgClass} ${status.textClass}`}>
              {status.label}
            </span>
          )}
          <span className="font-semibold text-slate-900">{formatCurrency(order.total)}</span>
          <ChevronRight size={16} className="text-slate-400" />
        </div>
      </div>
    </Link>
  );
}
