import React, { useState, useMemo, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { Search, Filter, Eye, ChevronRight, RotateCcw, Package, CreditCard, X, AlertTriangle, Banknote, Smartphone, Building2, FileText, Clock, Gift } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';
import { useDataLoader } from '../hooks/useDataLoader';
import { statusConfig } from '../data/helpers';

// Payment method icons map
const paymentIcons = {
  cash: Banknote,
  card: CreditCard,
  yappy: Smartphone,
  ach: Building2,
  check: FileText,
  invoice: FileText,
  pickup: Clock,
  gift_card: Gift,
};

const paymentMethodNames = {
  cash: 'Efectivo',
  card: 'Tarjeta',
  yappy: 'Yappy',
  ach: 'ACH / Bank',
  check: 'Cheque',
  invoice: 'Factura',
  pickup: 'Pagar en Recogida',
  gift_card: 'Tarjeta Regalo',
};

function OrdersPage() {
  const { state, actions } = useApp();
  const { isAdmin } = useAuth();
  const { updateOrderStatus: dbUpdateOrderStatus, getOrderDetails, createRefund, reload } = useDataLoader();
  const [searchParams, setSearchParams] = useSearchParams();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedOrder, setSelectedOrder] = useState(null);
  const [orderDetails, setOrderDetails] = useState(null);
  const [loadingDetails, setLoadingDetails] = useState(false);
  
  // Get status from URL or default to 'all'
  const statusFilter = searchParams.get('status') || 'all';
  
  // Update filter and URL
  const setStatusFilter = (newStatus) => {
    if (newStatus === 'all') {
      setSearchParams({});
    } else {
      setSearchParams({ status: newStatus });
    }
  };
  
  // Get page title based on filter
  const getPageTitle = () => {
    switch (statusFilter) {
      case 'ready':
        return 'Órdenes Listas';
      case 'completed':
        return 'Órdenes Completadas';
      case 'refunded':
        return 'Órdenes Reembolsadas';
      default:
        return 'Órdenes';
    }
  };
  
  const filteredOrders = useMemo(() => {
    return state.orders.filter(order => {
      // Status filter
      if (statusFilter !== 'all' && order.status !== statusFilter) return false;
      
      // Search filter
      if (searchQuery) {
        const query = searchQuery.toLowerCase();
        const matchesNumber = order.order_number.toString().includes(query);
        const matchesCustomer = order.customer_name?.toLowerCase().includes(query);
        return matchesNumber || matchesCustomer;
      }
      
      return true;
    });
  }, [state.orders, statusFilter, searchQuery]);
  
  const formatCurrency = (amount) => `B/${(amount || 0).toFixed(2)}`;
  
  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
      hour: '2-digit',
      minute: '2-digit',
    }).format(date);
  };
  
  const getStatusBadge = (status) => {
    const config = statusConfig[status] || statusConfig.pending;
    return (
      <span className={`badge ${config.bgClass} ${config.textClass}`}>
        {config.label}
      </span>
    );
  };
  
  // Load order details when selecting an order
  const handleSelectOrder = async (order) => {
    setSelectedOrder(order);
    setLoadingDetails(true);
    try {
      const details = await getOrderDetails(order.id);
      setOrderDetails(details);
    } catch (err) {
      console.error('Error loading order details:', err);
      setOrderDetails(null);
    }
    setLoadingDetails(false);
  };
  
  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">{getPageTitle()}</h1>
          <p className="text-sm text-slate-500">{filteredOrders.length} órdenes encontradas</p>
        </div>
      </div>
      
      {/* Filters */}
      <div className="flex flex-col sm:flex-row gap-4 mb-6">
        {/* Search */}
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Buscar por # orden o cliente..."
            className="input pl-10"
          />
        </div>
        
        {/* Status Filter */}
        <div className="flex items-center gap-2">
          <Filter className="w-5 h-5 text-slate-400" />
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="input w-auto"
          >
            <option value="all">Todos los estados</option>
            <option value="pending">Pendiente</option>
            <option value="washing">Lavando</option>
            <option value="drying">Secando</option>
            <option value="folding">Doblando</option>
            <option value="ready">Listo</option>
            <option value="completed">Completado</option>
            <option value="refunded">Reembolsado</option>
            <option value="refund">Reembolsos</option>
          </select>
        </div>
      </div>
      
      {/* Orders Table */}
      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="bg-slate-50 border-b border-slate-200">
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  # Orden
                </th>
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Cliente
                </th>
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Estado
                </th>
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Peso
                </th>
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Total
                </th>
                <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Fecha
                </th>
                <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wider">
                  Acciones
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {filteredOrders.map((order) => {
                // Find original order number if this is a refund
                const originalOrder = order.status === 'refund' && order.refund_for_order_id
                  ? state.orders.find(o => o.id === order.refund_for_order_id)
                  : null;
                
                return (
                <tr 
                  key={order.id}
                  className={`hover:bg-slate-50 transition-colors cursor-pointer ${
                    order.status === 'refund' ? 'bg-rose-50' : ''
                  }`}
                  onClick={() => handleSelectOrder(order)}
                >
                  <td className="px-4 py-4">
                    <div className="flex items-center gap-2">
                      <span className={`font-semibold ${order.total < 0 ? 'text-rose-600' : 'text-slate-800'}`}>
                        #{order.order_number}
                      </span>
                      {order.is_express && (
                        <span className="badge bg-warning-100 text-warning-700">Express</span>
                      )}
                      {order.status === 'refund' && (
                        <RotateCcw className="w-4 h-4 text-rose-500" />
                      )}
                    </div>
                    {originalOrder && (
                      <p className="text-xs text-rose-500 mt-0.5">
                        Ref. Orden #{originalOrder.order_number}
                      </p>
                    )}
                  </td>
                  <td className="px-4 py-4">
                    <p className="font-medium text-slate-700">{order.customer_name}</p>
                    {order.is_walk_in && (
                      <p className="text-xs text-slate-400">Walk-in</p>
                    )}
                  </td>
                  <td className="px-4 py-4">
                    {getStatusBadge(order.status)}
                  </td>
                  <td className="px-4 py-4 text-slate-600">
                    {order.total_weight?.toFixed(2) || '0.00'} kg
                  </td>
                  <td className={`px-4 py-4 font-semibold ${order.total < 0 ? 'text-rose-600' : 'text-slate-800'}`}>
                    {formatCurrency(order.total)}
                  </td>
                  <td className="px-4 py-4 text-sm text-slate-500">
                    {formatDate(order.created_at)}
                  </td>
                  <td className="px-4 py-4 text-right">
                    <button className="p-2 hover:bg-slate-100 rounded-lg transition-colors">
                      <Eye className="w-4 h-4 text-slate-400" />
                    </button>
                  </td>
                </tr>
              )})}
            </tbody>
          </table>
        </div>
        
        {/* Empty State */}
        {filteredOrders.length === 0 && (
          <div className="text-center py-12 text-slate-400">
            <Search className="w-12 h-12 mx-auto mb-3 opacity-50" />
            <p className="text-sm font-medium">No se encontraron órdenes</p>
            <p className="text-xs mt-1">Intenta con otros filtros</p>
          </div>
        )}
      </div>
      
      {/* Order Details Modal */}
      {selectedOrder && (
        <OrderDetailsModal 
          order={selectedOrder}
          orderDetails={orderDetails}
          loadingDetails={loadingDetails}
          isAdmin={isAdmin}
          allOrders={state.orders}
          onClose={() => {
            setSelectedOrder(null);
            setOrderDetails(null);
          }}
          onStatusChange={async (newStatus) => {
            try {
              await dbUpdateOrderStatus(selectedOrder.id, newStatus);
              setSelectedOrder({ ...selectedOrder, status: newStatus });
            } catch (err) {
              alert('Error al actualizar estado: ' + err.message);
            }
          }}
          onRefund={async (reason) => {
            try {
              const refundOrder = await createRefund(orderDetails, reason);
              setSelectedOrder(null);
              setOrderDetails(null);
              // Reload orders to show updated data
              await reload();
              alert(`Reembolso creado: Orden #${refundOrder.order_number}`);
            } catch (err) {
              alert('Error al crear reembolso: ' + err.message);
            }
          }}
        />
      )}
    </div>
  );
}

// Order Details Modal
function OrderDetailsModal({ order, orderDetails, loadingDetails, isAdmin, allOrders, onClose, onStatusChange, onRefund }) {
  const [showRefundModal, setShowRefundModal] = useState(false);
  const [refundReason, setRefundReason] = useState('');
  const [processingRefund, setProcessingRefund] = useState(false);
  
  const formatCurrency = (amount) => `B/${(amount || 0).toFixed(2)}`;
  const config = statusConfig[order.status] || statusConfig.pending;
  
  const statusOrder = ['pending', 'washing', 'drying', 'folding', 'ready', 'completed'];
  const currentStatusIndex = statusOrder.indexOf(order.status);
  const nextStatus = currentStatusIndex >= 0 && currentStatusIndex < statusOrder.length - 1 
    ? statusOrder[currentStatusIndex + 1] 
    : null;
  
  // Find original order if this is a refund
  const originalOrder = order.status === 'refund' && order.refund_for_order_id && allOrders
    ? allOrders.find(o => o.id === order.refund_for_order_id)
    : null;
  
  // Check if order can be refunded
  const canRefund = isAdmin && 
    !['refunded', 'refund', 'cancelled'].includes(order.status) &&
    order.total > 0;
  
  const handleRefund = async () => {
    setProcessingRefund(true);
    await onRefund(refundReason);
    setProcessingRefund(false);
    setShowRefundModal(false);
  };
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-3xl max-h-[90vh] overflow-y-auto animate-scale-in">
        {/* Header */}
        <div className="sticky top-0 bg-white flex items-center justify-between p-4 border-b border-slate-100 z-10">
          <div>
            <div className="flex items-center gap-3">
              <h2 className={`text-xl font-bold ${order.total < 0 ? 'text-rose-600' : 'text-slate-800'}`}>
                Orden #{order.order_number}
              </h2>
              <span className={`badge ${config.bgClass} ${config.textClass}`}>
                {config.label}
              </span>
              {order.is_express && (
                <span className="badge bg-warning-100 text-warning-700">Express</span>
              )}
            </div>
            <p className="text-sm text-slate-500">{order.customer_name}</p>
            {originalOrder && (
              <p className="text-sm text-rose-500 font-medium">
                Reembolso de Orden #{originalOrder.order_number}
              </p>
            )}
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        <div className="p-4 space-y-4">
          {/* Loading State */}
          {loadingDetails && (
            <div className="flex items-center justify-center py-8">
              <div className="w-8 h-8 border-4 border-primary-200 border-t-primary-500 rounded-full animate-spin"></div>
            </div>
          )}
          
          {!loadingDetails && orderDetails && (
            <>
              {/* Status Progress (hide for refund orders) */}
              {order.status !== 'refund' && order.status !== 'refunded' && (
                <div className="bg-slate-50 rounded-xl p-4">
                  <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-3">
                    Progreso
                  </p>
                  <div className="flex items-center justify-between">
                    {statusOrder.slice(0, -1).map((status, index) => {
                      const isActive = index <= currentStatusIndex;
                      const statusInfo = statusConfig[status];
                      return (
                        <React.Fragment key={status}>
                          <div className="flex flex-col items-center">
                            <div className={`w-8 h-8 rounded-full flex items-center justify-center text-xs font-semibold ${
                              isActive ? `${statusInfo.bgClass} ${statusInfo.textClass}` : 'bg-slate-200 text-slate-400'
                            }`}>
                              {index + 1}
                            </div>
                            <span className={`text-xs mt-1 ${isActive ? 'text-slate-700' : 'text-slate-400'}`}>
                              {statusInfo.label}
                            </span>
                          </div>
                          {index < statusOrder.length - 2 && (
                            <div className={`flex-1 h-0.5 mx-2 ${
                              index < currentStatusIndex ? 'bg-primary-500' : 'bg-slate-200'
                            }`} />
                          )}
                        </React.Fragment>
                      );
                    })}
                  </div>
                </div>
              )}
              
              {/* Order Summary */}
              <div className="grid grid-cols-4 gap-3">
                <div className="bg-slate-50 rounded-xl p-3">
                  <p className="text-xs text-slate-500">Peso Total</p>
                  <p className="text-lg font-bold text-slate-800">{order.total_weight?.toFixed(2) || '0.00'} kg</p>
                </div>
                <div className="bg-slate-50 rounded-xl p-3">
                  <p className="text-xs text-slate-500">Bolsas</p>
                  <p className="text-lg font-bold text-slate-800">{order.total_bags || 0}</p>
                </div>
                <div className="bg-slate-50 rounded-xl p-3">
                  <p className="text-xs text-slate-500">Piezas</p>
                  <p className="text-lg font-bold text-slate-800">{order.total_pieces || 0}</p>
                </div>
                <div className="bg-slate-50 rounded-xl p-3">
                  <p className="text-xs text-slate-500">Total</p>
                  <p className={`text-lg font-bold ${order.total < 0 ? 'text-rose-600' : 'text-primary-600'}`}>
                    {formatCurrency(order.total)}
                  </p>
                </div>
              </div>
              
              {/* Order Items */}
              <div className="bg-slate-50 rounded-xl p-4">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <Package className="w-4 h-4" />
                  Productos ({orderDetails.items?.length || 0})
                </p>
                <div className="space-y-2">
                  {orderDetails.items?.map((item, index) => (
                    <div key={index} className="flex justify-between items-center bg-white rounded-lg px-3 py-2">
                      <div>
                        <p className="font-medium text-slate-700">{item.product_name}</p>
                        <p className="text-xs text-slate-500">
                          {item.total_weight > 0 && `${item.total_weight.toFixed(2)} kg`}
                          {item.quantity > 0 && ` × ${item.quantity}`}
                          {item.bags > 0 && ` • ${item.bags} bolsas`}
                        </p>
                      </div>
                      <span className={`font-semibold ${item.line_total < 0 ? 'text-rose-600' : 'text-slate-800'}`}>
                        {formatCurrency(item.line_total)}
                      </span>
                    </div>
                  ))}
                  {(!orderDetails.items || orderDetails.items.length === 0) && (
                    <p className="text-sm text-slate-400 text-center py-2">Sin productos</p>
                  )}
                </div>
              </div>
              
              {/* Payments */}
              <div className="bg-slate-50 rounded-xl p-4">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <CreditCard className="w-4 h-4" />
                  Pagos ({orderDetails.payments?.length || 0})
                </p>
                <div className="space-y-2">
                  {orderDetails.payments?.map((payment, index) => {
                    const PaymentIcon = paymentIcons[payment.payment_method] || CreditCard;
                    return (
                      <div key={index} className="flex justify-between items-center bg-white rounded-lg px-3 py-2">
                        <div className="flex items-center gap-3">
                          <PaymentIcon className="w-5 h-5 text-slate-400" />
                          <div>
                            <p className="font-medium text-slate-700">
                              {paymentMethodNames[payment.payment_method] || payment.payment_method}
                            </p>
                            {payment.reference && (
                              <p className="text-xs text-slate-500">Ref: {payment.reference}</p>
                            )}
                            {payment.change_amount > 0 && (
                              <p className="text-xs text-slate-500">Cambio: {formatCurrency(payment.change_amount)}</p>
                            )}
                          </div>
                        </div>
                        <span className={`font-semibold ${payment.amount < 0 ? 'text-rose-600' : 'text-slate-800'}`}>
                          {formatCurrency(payment.amount)}
                        </span>
                      </div>
                    );
                  })}
                  {(!orderDetails.payments || orderDetails.payments.length === 0) && (
                    <p className="text-sm text-slate-400 text-center py-2">Sin pagos registrados</p>
                  )}
                </div>
              </div>
              
              {/* Totals Breakdown */}
              <div className="bg-slate-50 rounded-xl p-4">
                <div className="space-y-1">
                  <div className="flex justify-between text-sm">
                    <span className="text-slate-500">Subtotal</span>
                    <span className="text-slate-700">{formatCurrency(order.subtotal)}</span>
                  </div>
                  {order.discount_amount > 0 && (
                    <div className="flex justify-between text-sm">
                      <span className="text-warning-600">Descuento</span>
                      <span className="text-warning-600">-{formatCurrency(order.discount_amount)}</span>
                    </div>
                  )}
                  {order.delivery_charge > 0 && (
                    <div className="flex justify-between text-sm">
                      <span className="text-slate-500">Entrega</span>
                      <span className="text-slate-700">{formatCurrency(order.delivery_charge)}</span>
                    </div>
                  )}
                  <div className="flex justify-between text-sm">
                    <span className="text-slate-500">ITBMS</span>
                    <span className="text-slate-700">{formatCurrency(order.tax_amount)}</span>
                  </div>
                  <div className="flex justify-between text-base font-bold pt-2 border-t border-slate-200">
                    <span className="text-slate-800">Total</span>
                    <span className={order.total < 0 ? 'text-rose-600' : 'text-slate-800'}>
                      {formatCurrency(order.total)}
                    </span>
                  </div>
                </div>
              </div>
              
              {/* Notes */}
              {order.notes && (
                <div className="bg-amber-50 rounded-xl p-4">
                  <p className="text-xs font-semibold text-amber-600 uppercase tracking-wider mb-1">
                    Notas
                  </p>
                  <p className="text-sm text-amber-800 whitespace-pre-wrap">{order.notes}</p>
                </div>
              )}
            </>
          )}
          
          {/* Actions */}
          <div className="flex gap-3 pt-4 border-t border-slate-100">
            <button onClick={onClose} className="btn-secondary flex-1">
              Cerrar
            </button>
            
            {/* Refund Button (Admin Only) */}
            {canRefund && (
              <button 
                onClick={() => setShowRefundModal(true)}
                className="btn-secondary flex-1 text-rose-600 border-rose-200 hover:bg-rose-50"
              >
                <RotateCcw className="w-4 h-4" />
                Reembolsar
              </button>
            )}
            
            {nextStatus && order.status !== 'refunded' && order.status !== 'refund' && (
              <button 
                onClick={() => onStatusChange(nextStatus)}
                className="btn-primary flex-1"
              >
                Avanzar a {statusConfig[nextStatus].label}
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      </div>
      
      {/* Refund Confirmation Modal */}
      {showRefundModal && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 animate-fade-in">
          <div className="absolute inset-0 bg-black/50" onClick={() => setShowRefundModal(false)} />
          <div className="relative bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in">
            <div className="p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-full bg-rose-100 flex items-center justify-center">
                  <AlertTriangle className="w-6 h-6 text-rose-600" />
                </div>
                <div>
                  <h3 className="text-lg font-bold text-slate-800">Confirmar Reembolso</h3>
                  <p className="text-sm text-slate-500">Orden #{order.order_number}</p>
                </div>
              </div>
              
              <p className="text-sm text-slate-600 mb-4">
                Esta acción creará una orden de reembolso por <strong className="text-rose-600">{formatCurrency(order.total)}</strong> y 
                marcará la orden original como reembolsada.
              </p>
              
              <div className="mb-4">
                <label className="text-sm font-medium text-slate-700 mb-1 block">
                  Razón del reembolso (opcional)
                </label>
                <textarea
                  value={refundReason}
                  onChange={(e) => setRefundReason(e.target.value)}
                  placeholder="Ej: Cliente insatisfecho, Error en el pedido..."
                  className="input w-full"
                  rows={2}
                />
              </div>
              
              <div className="flex gap-3">
                <button 
                  onClick={() => setShowRefundModal(false)}
                  className="btn-secondary flex-1"
                  disabled={processingRefund}
                >
                  Cancelar
                </button>
                <button 
                  onClick={handleRefund}
                  disabled={processingRefund}
                  className="btn-primary flex-1 bg-rose-500 hover:bg-rose-600"
                >
                  {processingRefund ? (
                    <>
                      <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Procesando...
                    </>
                  ) : (
                    <>
                      <RotateCcw className="w-4 h-4" />
                      Confirmar Reembolso
                    </>
                  )}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default OrdersPage;
