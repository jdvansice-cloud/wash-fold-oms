import React, { useState, useMemo } from 'react';
import { Search, Filter, Eye, ChevronRight } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { statusConfig } from '../data/sampleData';

function OrdersPage() {
  const { state, actions } = useApp();
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [selectedOrder, setSelectedOrder] = useState(null);
  
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
  
  const formatCurrency = (amount) => `B/${amount?.toFixed(2) || '0.00'}`;
  
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
  
  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Órdenes</h1>
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
              {filteredOrders.map((order) => (
                <tr 
                  key={order.id}
                  className="hover:bg-slate-50 transition-colors cursor-pointer"
                  onClick={() => setSelectedOrder(order)}
                >
                  <td className="px-4 py-4">
                    <div className="flex items-center gap-2">
                      <span className="font-semibold text-slate-800">#{order.order_number}</span>
                      {order.is_express && (
                        <span className="badge bg-warning-100 text-warning-700">Express</span>
                      )}
                    </div>
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
                  <td className="px-4 py-4 font-semibold text-slate-800">
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
              ))}
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
          onClose={() => setSelectedOrder(null)}
          onStatusChange={(newStatus) => {
            actions.updateOrderStatus(selectedOrder.id, newStatus);
            setSelectedOrder({ ...selectedOrder, status: newStatus });
          }}
        />
      )}
    </div>
  );
}

// Order Details Modal
function OrderDetailsModal({ order, onClose, onStatusChange }) {
  const formatCurrency = (amount) => `B/${amount?.toFixed(2) || '0.00'}`;
  const config = statusConfig[order.status] || statusConfig.pending;
  
  const statusOrder = ['pending', 'washing', 'drying', 'folding', 'ready', 'completed'];
  const currentStatusIndex = statusOrder.indexOf(order.status);
  const nextStatus = currentStatusIndex < statusOrder.length - 1 ? statusOrder[currentStatusIndex + 1] : null;
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-2xl max-h-[90vh] overflow-y-auto animate-scale-in">
        {/* Header */}
        <div className="sticky top-0 bg-white flex items-center justify-between p-4 border-b border-slate-100 z-10">
          <div>
            <div className="flex items-center gap-3">
              <h2 className="text-xl font-bold text-slate-800">Orden #{order.order_number}</h2>
              <span className={`badge ${config.bgClass} ${config.textClass}`}>
                {config.label}
              </span>
              {order.is_express && (
                <span className="badge bg-warning-100 text-warning-700">Express</span>
              )}
            </div>
            <p className="text-sm text-slate-500">{order.customer_name}</p>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <span className="text-slate-500 text-xl">&times;</span>
          </button>
        </div>
        
        <div className="p-4 space-y-4">
          {/* Status Progress */}
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
          
          {/* Order Summary */}
          <div className="grid grid-cols-3 gap-4">
            <div className="bg-slate-50 rounded-xl p-3">
              <p className="text-xs text-slate-500">Peso Total</p>
              <p className="text-lg font-bold text-slate-800">{order.total_weight?.toFixed(2) || '0.00'} kg</p>
            </div>
            <div className="bg-slate-50 rounded-xl p-3">
              <p className="text-xs text-slate-500">Bolsas</p>
              <p className="text-lg font-bold text-slate-800">{order.total_bags || 0}</p>
            </div>
            <div className="bg-slate-50 rounded-xl p-3">
              <p className="text-xs text-slate-500">Total</p>
              <p className="text-lg font-bold text-primary-600">{formatCurrency(order.total)}</p>
            </div>
          </div>
          
          {/* Notes */}
          {order.notes && (
            <div className="bg-amber-50 rounded-xl p-4">
              <p className="text-xs font-semibold text-amber-600 uppercase tracking-wider mb-1">
                Notas
              </p>
              <p className="text-sm text-amber-800">{order.notes}</p>
            </div>
          )}
          
          {/* Actions */}
          <div className="flex gap-3 pt-4 border-t border-slate-100">
            <button onClick={onClose} className="btn-secondary flex-1">
              Cerrar
            </button>
            {nextStatus && (
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
    </div>
  );
}

export default OrdersPage;
