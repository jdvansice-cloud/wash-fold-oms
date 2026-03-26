import React from 'react';
import { useParams, Link } from 'react-router-dom';
import { ArrowLeft, Zap } from 'lucide-react';
import { useMyOrderDetails } from '../../hooks/queries/useMyOrders';
import { useTenant } from '../../hooks/useTenant';
import { OrderTimeline } from '../../components/portal/OrderTimeline';
import { Spinner } from '../../components/ui/Spinner';
import { formatCurrency, formatDate, formatWeight, formatOrderNumber } from '../../utils/formatters';

export default function OrderDetail() {
  const { id } = useParams<{ id: string }>();
  const { slug } = useTenant();
  const pp = (path: string) => `/portal/${slug}${path}`;
  const { data: order, isLoading, error } = useMyOrderDetails(id);

  if (isLoading) {
    return (
      <div className="flex justify-center py-12">
        <Spinner />
      </div>
    );
  }

  if (error || !order) {
    return (
      <div className="text-center py-12">
        <p className="text-slate-500">No se encontro el pedido</p>
        <Link to={pp('/orders')} className="text-primary-600 text-sm mt-2 inline-block">
          Volver a pedidos
        </Link>
      </div>
    );
  }

  const displayNumber = order.legacy_order_number || formatOrderNumber(order.order_number);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <Link to={pp('/orders')} className="p-2 rounded-lg hover:bg-slate-100 text-slate-500">
          <ArrowLeft size={20} />
        </Link>
        <div>
          <div className="flex items-center gap-2">
            <h1 className="text-xl font-bold text-slate-900">Orden {displayNumber}</h1>
            {order.is_express && (
              <span className="inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded-full bg-accent-100 text-accent-700 text-xs font-medium">
                <Zap size={10} />
                Express
              </span>
            )}
          </div>
          <p className="text-sm text-slate-500">{formatDate(order.created_at)}</p>
        </div>
      </div>

      {/* Status Timeline */}
      <div className="bg-white rounded-xl border border-slate-200 p-4">
        <OrderTimeline currentStatus={order.status} />
      </div>

      {/* Order Items */}
      <div className="bg-white rounded-xl border border-slate-200">
        <div className="px-4 py-3 border-b border-slate-100">
          <h2 className="text-sm font-semibold text-slate-900">Articulos</h2>
        </div>
        <div className="divide-y divide-slate-100">
          {order.order_items?.map((item) => (
            <div key={item.id} className="px-4 py-3 flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-slate-900">{item.product_name}</p>
                <p className="text-xs text-slate-500">
                  {item.total_weight > 0
                    ? `${formatWeight(item.total_weight)} x ${formatCurrency(item.unit_price)}/kg`
                    : `${item.quantity} x ${formatCurrency(item.unit_price)}`}
                </p>
              </div>
              <span className="text-sm font-medium text-slate-900">
                {formatCurrency(item.line_total)}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Totals */}
      <div className="bg-white rounded-xl border border-slate-200 p-4 space-y-2">
        <div className="flex justify-between text-sm">
          <span className="text-slate-500">Subtotal</span>
          <span className="text-slate-700">{formatCurrency(order.subtotal)}</span>
        </div>
        {order.discount_amount > 0 && (
          <div className="flex justify-between text-sm">
            <span className="text-slate-500">Descuento</span>
            <span className="text-emerald-600">-{formatCurrency(order.discount_amount)}</span>
          </div>
        )}
        {order.delivery_charge > 0 && (
          <div className="flex justify-between text-sm">
            <span className="text-slate-500">Delivery</span>
            <span className="text-slate-700">{formatCurrency(order.delivery_charge)}</span>
          </div>
        )}
        <div className="flex justify-between text-sm">
          <span className="text-slate-500">ITBMS</span>
          <span className="text-slate-700">{formatCurrency(order.tax_amount)}</span>
        </div>
        <div className="flex justify-between text-base font-semibold pt-2 border-t border-slate-200">
          <span className="text-slate-900">Total</span>
          <span className="text-slate-900">{formatCurrency(order.total)}</span>
        </div>
      </div>

      {/* Payments */}
      {order.payments && order.payments.length > 0 && (
        <div className="bg-white rounded-xl border border-slate-200 p-4">
          <h3 className="text-sm font-semibold text-slate-900 mb-2">Pagos</h3>
          {order.payments.map((payment) => (
            <div key={payment.id} className="flex justify-between text-sm py-1">
              <span className="text-slate-500">{payment.payment_method}</span>
              <span className="text-slate-700">{formatCurrency(payment.amount)}</span>
            </div>
          ))}
        </div>
      )}

      {/* Info */}
      <div className="bg-white rounded-xl border border-slate-200 p-4 space-y-2 text-sm">
        {order.promised_date && (
          <div className="flex justify-between">
            <span className="text-slate-500">Fecha estimada</span>
            <span className="text-slate-700">{formatDate(order.promised_date)}</span>
          </div>
        )}
        {order.total_weight > 0 && (
          <div className="flex justify-between">
            <span className="text-slate-500">Peso total</span>
            <span className="text-slate-700">{formatWeight(order.total_weight)}</span>
          </div>
        )}
        {order.notes && (
          <div>
            <span className="text-slate-500">Notas:</span>
            <p className="text-slate-700 mt-1">{order.notes}</p>
          </div>
        )}
      </div>
    </div>
  );
}
