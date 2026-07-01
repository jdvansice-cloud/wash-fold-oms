import React, { useState, useMemo, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { Search, Filter, Eye, ChevronRight, RotateCcw, Package, CreditCard, X, AlertTriangle, Banknote, Smartphone, Building2, FileText, Clock, Gift, Award, Coins, Stamp, Calendar, Tag } from 'lucide-react';
import OrderLabel from '../components/OrderLabel';
import { useApp } from '../context/AppContext';
import { usePermission } from '../hooks/usePermission';
import { useDataLoader } from '../hooks/useDataLoader';
import { statusConfig } from '../data/helpers';
import { InvoiceStatus } from '../components/efactura/InvoiceStatus';
import PaymentModal from '../components/modals/PaymentModal';
import { generateReceiptData, printCreditNote, isPrinterConnected } from '../utils/receiptPrinter';

// Polls for the refund order's nota de crédito (doc 06) until it reaches a
// terminal status or a 10s wall-clock cap, so we can print its CAFE.
const waitForCreditNote = async (orderId, { delayMs = 600, timeoutMs = 10000 } = {}) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key || !orderId) return null;
  const headers = { apikey: key, Authorization: `Bearer ${key}` };
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    try {
      const res = await fetch(
        `${url}/rest/v1/electronic_invoices?order_id=eq.${orderId}&doc_type=eq.06&order=created_at.desc&limit=1&select=*`,
        { headers },
      );
      if (res.ok) {
        const rows = await res.json();
        const inv = rows && rows[0];
        if (inv && ['authorized', 'rejected', 'cancelled'].includes(inv.status)) return inv;
      }
    } catch {
      /* transient — retry */
    }
    if (Date.now() + delayMs >= deadline) break;
    await new Promise((r) => setTimeout(r, delayMs));
  }
  return null;
};

// Helper to get date X days ago in YYYY-MM-DD format
const getDateDaysAgo = (days) => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date.toISOString().split('T')[0];
};

// Helper to get today's date in YYYY-MM-DD format
const getTodayDate = () => {
  return new Date().toISOString().split('T')[0];
};

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

// Payment state of an order — SEPARATE from its workflow "estado". A B2B credit
// order counts as paid once it's been placed on a consolidated invoice
// (b2b_invoice_id), even before that invoice is collected.
const paymentDisplay = (order) => {
  const paid =
    order.payment_status === 'paid' ||
    (order.billing_type === 'account' && !!order.b2b_invoice_id);
  if (paid) return { label: 'Pagado', cls: 'bg-emerald-100 text-emerald-700', paid: true };
  if (order.billing_type === 'account') return { label: 'A crédito', cls: 'bg-indigo-100 text-indigo-700', paid: false };
  if (order.billing_type === 'pickup') return { label: 'Por cobrar', cls: 'bg-amber-100 text-amber-700', paid: false };
  return { label: 'Pendiente', cls: 'bg-amber-100 text-amber-700', paid: false };
};

// Helper to display order number (legacy CC orders or new orders)
const getOrderDisplayNumber = (order) => {
  if (order.legacy_order_number) {
    return order.legacy_order_number; // e.g., "CC1234"
  }
  return `#${order.order_number}`;
};

function OrdersPage() {
  const { state, actions } = useApp();
  const { can } = usePermission();
  const { updateOrderStatus: dbUpdateOrderStatus, settleOrder, getOrderDetails, createRefund, reload, searchOrders, loadMoreOrders } = useDataLoader();
  const [settlingOrder, setSettlingOrder] = useState(null);
  const [searchParams, setSearchParams] = useSearchParams();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedOrder, setSelectedOrder] = useState(null);
  const [orderDetails, setOrderDetails] = useState(null);
  const [loadingDetails, setLoadingDetails] = useState(false);
  const [searchResults, setSearchResults] = useState(null);
  const [isSearching, setIsSearching] = useState(false);
  const [loadingMore, setLoadingMore] = useState(false);
  const [hasMoreOrders, setHasMoreOrders] = useState(true);
  
  // Date range filter - default to last 7 days
  const [startDate, setStartDate] = useState(getDateDaysAgo(7));
  const [endDate, setEndDate] = useState(getTodayDate());
  
  // Get status from URL or default to 'all'
  const statusFilter = searchParams.get('status') || 'all';
  
  // Update filter and URL
  const setStatusFilter = (newStatus) => {
    if (newStatus === 'all') {
      setSearchParams({});
    } else {
      setSearchParams({ status: newStatus });
    }
    setSearchResults(null); // Clear search when changing filter
  };
  
  // Database search with debounce
  useEffect(() => {
    if (!searchQuery || searchQuery.length < 2) {
      setSearchResults(null);
      return;
    }
    
    const timer = setTimeout(async () => {
      setIsSearching(true);
      const results = await searchOrders(searchQuery, 100);
      setSearchResults(results);
      setIsSearching(false);
    }, 300);
    
    return () => clearTimeout(timer);
  }, [searchQuery, searchOrders]);
  
  // Load more orders
  const handleLoadMore = async () => {
    setLoadingMore(true);
    try {
      const currentCount = state.orders.length;
      const newOrders = await loadMoreOrders(currentCount, 500);
      
      if (newOrders.length > 0) {
        // Merge new orders with existing, avoiding duplicates
        const existingIds = new Set(state.orders.map(o => o.id));
        const uniqueNewOrders = newOrders.filter(o => !existingIds.has(o.id));
        actions.setOrders([...state.orders, ...uniqueNewOrders]);
      }
      
      if (newOrders.length < 500) {
        setHasMoreOrders(false);
      }
    } catch (err) {
      console.error('Error loading more orders:', err);
    }
    setLoadingMore(false);
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
  
  // Use search results if searching, otherwise filter local state
  const ordersToDisplay = useMemo(() => {
    const sourceOrders = searchResults || state.orders;
    
    return sourceOrders.filter(order => {
      // Status filter
      if (statusFilter !== 'all' && order.status !== statusFilter) return false;
      
      // Date range filter (only when not searching)
      if (!searchResults && startDate && endDate) {
        const orderDate = new Date(order.created_at).toISOString().split('T')[0];
        if (orderDate < startDate || orderDate > endDate) return false;
      }
      
      // If using search results, don't filter again by query
      if (searchResults) return true;
      
      // Local search filter (for when not doing DB search)
      if (searchQuery && searchQuery.length >= 2) {
        const query = searchQuery.toLowerCase();
        const orderNum = order.legacy_order_number || order.order_number.toString();
        const matchesNumber = orderNum.toLowerCase().includes(query);
        const matchesCustomer = order.customer_name?.toLowerCase().includes(query);
        return matchesNumber || matchesCustomer;
      }
      
      return true;
    });
  }, [state.orders, searchResults, statusFilter, searchQuery, startDate, endDate]);
  
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
          <p className="text-sm text-slate-500">
            {isSearching ? (
              <span className="flex items-center gap-2">
                <span className="w-4 h-4 border-2 border-primary-500 border-t-transparent rounded-full animate-spin"></span>
                Buscando en base de datos...
              </span>
            ) : searchResults ? (
              `${ordersToDisplay.length} resultados encontrados`
            ) : (
              <>
                {ordersToDisplay.length} órdenes
                {startDate && endDate && ` • ${new Date(startDate + 'T12:00:00').toLocaleDateString('es-PA', { day: 'numeric', month: 'short' })} - ${new Date(endDate + 'T12:00:00').toLocaleDateString('es-PA', { day: 'numeric', month: 'short' })}`}
                {!startDate && !endDate && ` • Todas las fechas`}
              </>
            )}
          </p>
        </div>
      </div>
      
      {/* Filters */}
      <div className="flex flex-col lg:flex-row gap-4 mb-6">
        {/* Search */}
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Buscar por # orden, CC### o cliente..."
            className="input pl-10"
          />
          {searchQuery && (
            <button
              onClick={() => {
                setSearchQuery('');
                setSearchResults(null);
              }}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>
        
        {/* Date Range Filter */}
        <div className="flex items-center gap-2 flex-wrap sm:flex-nowrap">
          <Calendar className="w-5 h-5 text-slate-400 hidden sm:block" />
          <input
            type="date"
            value={startDate}
            onChange={(e) => setStartDate(e.target.value)}
            className="input w-auto text-sm"
          />
          <span className="text-slate-400">a</span>
          <input
            type="date"
            value={endDate}
            onChange={(e) => setEndDate(e.target.value)}
            className="input w-auto text-sm"
          />
          {/* Quick date presets */}
          <div className="flex gap-1">
            <button
              onClick={() => {
                setStartDate(getTodayDate());
                setEndDate(getTodayDate());
              }}
              className={`px-2 py-1 text-xs rounded-lg transition-colors ${
                startDate === getTodayDate() && endDate === getTodayDate()
                  ? 'bg-primary-100 text-primary-700'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              Hoy
            </button>
            <button
              onClick={() => {
                setStartDate(getDateDaysAgo(7));
                setEndDate(getTodayDate());
              }}
              className={`px-2 py-1 text-xs rounded-lg transition-colors ${
                startDate === getDateDaysAgo(7) && endDate === getTodayDate()
                  ? 'bg-primary-100 text-primary-700'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              7 días
            </button>
            <button
              onClick={() => {
                setStartDate(getDateDaysAgo(30));
                setEndDate(getTodayDate());
              }}
              className={`px-2 py-1 text-xs rounded-lg transition-colors ${
                startDate === getDateDaysAgo(30) && endDate === getTodayDate()
                  ? 'bg-primary-100 text-primary-700'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              30 días
            </button>
            <button
              onClick={() => {
                setStartDate('');
                setEndDate('');
              }}
              className={`px-2 py-1 text-xs rounded-lg transition-colors ${
                !startDate && !endDate
                  ? 'bg-primary-100 text-primary-700'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              Todo
            </button>
          </div>
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
                  Pago
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
              {ordersToDisplay.map((order) => {
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
                        {getOrderDisplayNumber(order)}
                      </span>
                      {order.legacy_order_number && (
                        <span className="badge bg-slate-100 text-slate-500 text-xs">Histórico</span>
                      )}
                      {order.is_express && (
                        <span className="badge bg-warning-100 text-warning-700">Express</span>
                      )}
                      {order.status === 'refund' && (
                        <RotateCcw className="w-4 h-4 text-rose-500" />
                      )}
                      {order.billing_type === 'account' && (
                        <span className="badge bg-indigo-100 text-indigo-700 text-xs inline-flex items-center gap-1">
                          <FileText className="w-3 h-3" /> B2B
                        </span>
                      )}
                    </div>
                    {originalOrder && (
                      <p className="text-xs text-rose-500 mt-0.5">
                        Ref. Orden {getOrderDisplayNumber(originalOrder)}
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
                  <td className="px-4 py-4">
                    {order.status === 'refund' ? (
                      <span className="text-slate-400">—</span>
                    ) : (
                      <span className={`badge ${paymentDisplay(order).cls}`}>{paymentDisplay(order).label}</span>
                    )}
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
        
        {/* Load More Button */}
        {!searchResults && hasMoreOrders && ordersToDisplay.length > 0 && (
          <div className="text-center py-4 border-t border-slate-100">
            <button
              onClick={handleLoadMore}
              disabled={loadingMore}
              className="btn-secondary inline-flex items-center gap-2"
            >
              {loadingMore ? (
                <>
                  <span className="w-4 h-4 border-2 border-primary-500 border-t-transparent rounded-full animate-spin"></span>
                  Cargando más órdenes...
                </>
              ) : (
                <>
                  Cargar más órdenes históricas
                </>
              )}
            </button>
            <p className="text-xs text-slate-400 mt-2">
              {state.orders.length} órdenes cargadas • Busca por "CC" + número para órdenes de CleanCloud
            </p>
          </div>
        )}
        
        {/* Empty State */}
        {ordersToDisplay.length === 0 && (
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
          canRefundRole={can('orders.refund')}
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
          onSettle={() => setSettlingOrder(selectedOrder)}
          onRefund={async (reason) => {
            try {
              const details = orderDetails;
              const refundOrder = await createRefund(details, reason);
              // Print the nota de crédito (CAFE) once it authorizes, mirroring the
              // sale receipt. Only when a NC was actually emitted (i.e. the
              // original order had an authorized factura) and the printer is set up.
              if (isPrinterConnected() && refundOrder?.id) {
                try {
                  const invoice = await waitForCreditNote(refundOrder.id);
                  if (invoice && invoice.status === 'authorized') {
                    const receiptData = generateReceiptData(
                      details,
                      state.company,
                      state.store,
                      details.items || [],
                      details.payments || [],
                    );
                    await printCreditNote(receiptData, invoice);
                  }
                } catch (printErr) {
                  console.error('Nota de crédito print failed (refund still created):', printErr);
                }
              }
              setSelectedOrder(null);
              setOrderDetails(null);
              // Reload orders to show updated data
              await reload();
              alert(`Reembolso creado: Orden ${getOrderDisplayNumber(refundOrder)}`);
            } catch (err) {
              alert('Error al crear reembolso: ' + err.message);
            }
          }}
        />
      )}

      {/* Settle an unpaid (pay-on-pickup) order: reuse the checkout payment
          screen bound to this order. On completion it's marked paid + invoiced. */}
      {settlingOrder && (
        <PaymentModal
          total={settlingOrder.total}
          subtotal={settlingOrder.subtotal}
          taxAmount={settlingOrder.tax_amount}
          paymentMethods={(state.paymentMethods || []).filter((m) => m.is_active)}
          storeId={state.store?.id}
          allowPickup={false}
          onClose={() => setSettlingOrder(null)}
          onComplete={async (paymentInfo) => {
            try {
              await settleOrder(settlingOrder.id, paymentInfo);
              setSelectedOrder((o) => (o ? { ...o, payment_status: 'paid' } : o));
              setSettlingOrder(null);
            } catch (err) {
              alert('Error al cobrar la orden: ' + err.message);
            }
          }}
        />
      )}
    </div>
  );
}

// Order Details Modal
function OrderDetailsModal({ order, orderDetails, loadingDetails, canRefundRole, allOrders, onClose, onStatusChange, onSettle, onRefund }) {
  const [showRefundModal, setShowRefundModal] = useState(false);
  const [refundReason, setRefundReason] = useState('');
  const [processingRefund, setProcessingRefund] = useState(false);
  const [showLabel, setShowLabel] = useState(false);

  const formatCurrency = (amount) => `B/${(amount || 0).toFixed(2)}`;
  const config = statusConfig[order.status] || statusConfig.pending;
  // Unpaid orders are either pay-on-pickup (settle before handover — gated) or
  // B2B credit/"account" (delivered on account, billed later — NOT gated).
  const isUnpaid = order.payment_status === 'unpaid';
  const isPickupUnpaid = isUnpaid && order.billing_type === 'pickup';

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
  const canRefund = canRefundRole &&
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
                Orden {getOrderDisplayNumber(order)}
              </h2>
              {order.legacy_order_number && (
                <span className="badge bg-slate-100 text-slate-500">Histórico</span>
              )}
              <span className={`badge ${config.bgClass} ${config.textClass}`}>
                {config.label}
              </span>
              {order.is_express && (
                <span className="badge bg-warning-100 text-warning-700">Express</span>
              )}
              {order.billing_type === 'account' && (
                <span className="badge bg-indigo-100 text-indigo-700 inline-flex items-center gap-1">
                  <FileText className="w-3 h-3" /> B2B
                </span>
              )}
              {/* Payment state — separate from the workflow estado above. */}
              {order.status !== 'refund' && (
                <span className={`badge ${paymentDisplay(order).cls}`}>{paymentDisplay(order).label}</span>
              )}
            </div>
            <p className="text-sm text-slate-500">{order.customer_name}</p>
            {originalOrder && (
              <p className="text-sm text-rose-500 font-medium">
                Reembolso de Orden {getOrderDisplayNumber(originalOrder)}
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

              {/* Electronic invoice — factura for sales, nota de crédito for
                  refunds. B2B credit orders are NOT invoiced individually; they
                  are billed on a consolidated B2B invoice, so no factura section. */}
              {order.billing_type === 'account' ? (
                <div className="bg-indigo-50 rounded-xl p-4 flex items-center gap-2 text-sm text-indigo-700">
                  <FileText className="w-4 h-4 flex-shrink-0" />
                  <span>Orden B2B a crédito — se factura en la factura consolidada del cliente, no individualmente.</span>
                </div>
              ) : order.total > 0 && order.status !== 'refund' ? (
                <div className="bg-slate-50 rounded-xl p-4">
                  <InvoiceStatus orderId={order.id} staff />
                </div>
              ) : order.status === 'refund' ? (
                <div className="bg-slate-50 rounded-xl p-4">
                  <InvoiceStatus orderId={order.id} staff canEmit={false} />
                </div>
              ) : null}

              {/* Notes */}
              {order.notes && (
                <div className="bg-amber-50 rounded-xl p-4">
                  <p className="text-xs font-semibold text-amber-600 uppercase tracking-wider mb-1">
                    Notas
                  </p>
                  <p className="text-sm text-amber-800 whitespace-pre-wrap">{order.notes}</p>
                </div>
              )}
              
              {/* Loyalty Rewards Earned - Single Line */}
              {orderDetails.loyaltyTransactions && orderDetails.loyaltyTransactions.length > 0 && (() => {
                const pointsEarned = orderDetails.loyaltyTransactions
                  .filter(t => t.transaction_type === 'points_earned')
                  .reduce((sum, t) => sum + (t.points_amount || 0), 0);
                const washPunches = orderDetails.loyaltyTransactions
                  .filter(t => t.transaction_type === 'punch_wash')
                  .reduce((sum, t) => sum + (t.punch_count || 0), 0);
                const dryPunches = orderDetails.loyaltyTransactions
                  .filter(t => t.transaction_type === 'punch_dry')
                  .reduce((sum, t) => sum + (t.punch_count || 0), 0);
                const freeWashes = orderDetails.loyaltyTransactions
                  .filter(t => t.transaction_type === 'free_wash_earned')
                  .reduce((sum, t) => sum + (t.punch_count || 1), 0);
                const freeDrys = orderDetails.loyaltyTransactions
                  .filter(t => t.transaction_type === 'free_dry_earned')
                  .reduce((sum, t) => sum + (t.punch_count || 1), 0);
                
                return (
                  <div className="flex items-center justify-between bg-gradient-to-r from-emerald-50 to-teal-50 rounded-xl px-4 py-3 border border-emerald-100">
                    <div className="flex items-center gap-2">
                      <Award className="w-4 h-4 text-emerald-600" />
                      <span className="text-sm font-medium text-emerald-700">Lealtad</span>
                    </div>
                    <div className="flex items-center gap-3">
                      {pointsEarned > 0 && (
                        <span className="flex items-center gap-1 text-sm font-semibold text-emerald-600">
                          <Coins className="w-4 h-4" />
                          +B/{pointsEarned.toFixed(2)}
                        </span>
                      )}
                      {washPunches > 0 && (
                        <span className="flex items-center gap-1 text-sm font-semibold text-blue-600">
                          +{washPunches} 🌀
                        </span>
                      )}
                      {dryPunches > 0 && (
                        <span className="flex items-center gap-1 text-sm font-semibold text-orange-600">
                          +{dryPunches} ☀️
                        </span>
                      )}
                      {freeWashes > 0 && (
                        <span className="flex items-center gap-1 text-sm font-semibold text-emerald-600 bg-emerald-100 px-2 py-0.5 rounded-full">
                          🎁 {freeWashes} lavado{freeWashes > 1 ? 's' : ''}
                        </span>
                      )}
                      {freeDrys > 0 && (
                        <span className="flex items-center gap-1 text-sm font-semibold text-emerald-600 bg-emerald-100 px-2 py-0.5 rounded-full">
                          🎁 {freeDrys} secado{freeDrys > 1 ? 's' : ''}
                        </span>
                      )}
                    </div>
                  </div>
                );
              })()}
            </>
          )}
          
          {/* Actions */}
          <div className="flex gap-3 pt-4 border-t border-slate-100">
            <button onClick={onClose} className="btn-secondary flex-1">
              Cerrar
            </button>

            {/* Print a scannable garment/order tag */}
            {order.status !== 'refund' && (
              <button onClick={() => setShowLabel(true)} className="btn-secondary flex-1">
                <Tag className="w-4 h-4" />
                Etiqueta
              </button>
            )}

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
            
            {/* Pay-on-pickup: must be cobrado before it can be handed to the
                customer. Offer "Cobrar" instead of advancing to entrega. */}
            {isPickupUnpaid && order.status !== 'refunded' && order.status !== 'refund' && (
              <button
                onClick={onSettle}
                className="btn-primary flex-1 bg-amber-500 hover:bg-amber-600"
              >
                <CreditCard className="w-4 h-4" />
                Cobrar {formatCurrency(order.total)}
              </button>
            )}

            {nextStatus && order.status !== 'refunded' && order.status !== 'refund'
              && !(nextStatus === 'completed' && isPickupUnpaid) && (
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
                  <p className="text-sm text-slate-500">Orden {getOrderDisplayNumber(order)}</p>
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

      {showLabel && <OrderLabel order={order} onClose={() => setShowLabel(false)} />}
    </div>
  );
}

export default OrdersPage;
