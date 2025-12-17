import React, { useState, useMemo } from 'react';
import { 
  TrendingUp, TrendingDown, DollarSign, Package, 
  Users, Scale, Calendar, Filter, Download,
  ShoppingCart, Clock, Percent, CreditCard
} from 'lucide-react';
import { useApp } from '../context/AppContext';

function AnalyticsPage() {
  const { state } = useApp();
  const [dateRange, setDateRange] = useState('week'); // today, week, month, custom
  const [viewMode, setViewMode] = useState('summary'); // summary, detail
  
  // Calculate KPIs from orders
  const kpis = useMemo(() => {
    const now = new Date();
    const filterDate = new Date();
    
    switch (dateRange) {
      case 'today':
        filterDate.setHours(0, 0, 0, 0);
        break;
      case 'week':
        filterDate.setDate(now.getDate() - 7);
        break;
      case 'month':
        filterDate.setMonth(now.getMonth() - 1);
        break;
      default:
        filterDate.setDate(now.getDate() - 7);
    }
    
    const filteredOrders = state.orders.filter(order => 
      new Date(order.created_at) >= filterDate
    );
    
    const completedOrders = filteredOrders.filter(o => 
      o.status === 'completed' || o.status === 'ready'
    );
    
    const totalSales = filteredOrders.reduce((sum, o) => sum + (o.total || 0), 0);
    const totalWeight = filteredOrders.reduce((sum, o) => sum + (o.total_weight || 0), 0);
    const totalOrders = filteredOrders.length;
    const avgTicket = totalOrders > 0 ? totalSales / totalOrders : 0;
    const expressOrders = filteredOrders.filter(o => o.is_express).length;
    const expressRate = totalOrders > 0 ? (expressOrders / totalOrders) * 100 : 0;
    
    // Simulated comparison with previous period
    const salesGrowth = 12.5;
    const ordersGrowth = 8.3;
    const weightGrowth = 15.2;
    const avgTicketGrowth = -2.1;
    
    return {
      totalSales,
      totalWeight,
      totalOrders,
      avgTicket,
      expressOrders,
      expressRate,
      salesGrowth,
      ordersGrowth,
      weightGrowth,
      avgTicketGrowth,
      filteredOrders,
    };
  }, [state.orders, dateRange]);
  
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
      hour: '2-digit',
      minute: '2-digit',
    }).format(date);
  };

  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Analíticas</h1>
          <p className="text-sm text-slate-500">Dashboard de rendimiento del negocio</p>
        </div>
        
        <div className="flex items-center gap-3">
          {/* Date Range Filter */}
          <div className="flex items-center gap-2 bg-slate-100 rounded-xl p-1">
            {[
              { value: 'today', label: 'Hoy' },
              { value: 'week', label: '7 días' },
              { value: 'month', label: '30 días' },
            ].map((option) => (
              <button
                key={option.value}
                onClick={() => setDateRange(option.value)}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                  dateRange === option.value
                    ? 'bg-white text-primary-600 shadow-sm'
                    : 'text-slate-600 hover:text-slate-800'
                }`}
              >
                {option.label}
              </button>
            ))}
          </div>
          
          {/* Export Button */}
          <button className="btn-secondary">
            <Download className="w-4 h-4" />
            Exportar
          </button>
        </div>
      </div>
      
      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <KPICard
          title="Ventas Totales"
          value={formatCurrency(kpis.totalSales)}
          change={kpis.salesGrowth}
          icon={DollarSign}
          color="primary"
        />
        <KPICard
          title="Total Órdenes"
          value={kpis.totalOrders}
          change={kpis.ordersGrowth}
          icon={ShoppingCart}
          color="success"
        />
        <KPICard
          title="Peso Total"
          value={`${kpis.totalWeight.toFixed(2)} kg`}
          change={kpis.weightGrowth}
          icon={Scale}
          color="warning"
        />
        <KPICard
          title="Ticket Promedio"
          value={formatCurrency(kpis.avgTicket)}
          change={kpis.avgTicketGrowth}
          icon={CreditCard}
          color="purple"
        />
      </div>
      
      {/* Secondary Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div className="card p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-slate-500">Órdenes Express</span>
            <Clock className="w-4 h-4 text-warning-500" />
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-2xl font-bold text-slate-800">{kpis.expressOrders}</span>
            <span className="text-sm text-slate-500">({kpis.expressRate.toFixed(1)}%)</span>
          </div>
        </div>
        
        <div className="card p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-slate-500">Clientes Atendidos</span>
            <Users className="w-4 h-4 text-primary-500" />
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-2xl font-bold text-slate-800">
              {new Set(kpis.filteredOrders.map(o => o.customer_id).filter(Boolean)).size}
            </span>
            <span className="text-sm text-slate-500">únicos</span>
          </div>
        </div>
        
        <div className="card p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-slate-500">Peso Promedio/Orden</span>
            <Scale className="w-4 h-4 text-success-500" />
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-2xl font-bold text-slate-800">
              {kpis.totalOrders > 0 ? (kpis.totalWeight / kpis.totalOrders).toFixed(2) : '0.00'}
            </span>
            <span className="text-sm text-slate-500">kg</span>
          </div>
        </div>
      </div>
      
      {/* View Toggle */}
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-lg font-semibold text-slate-800">Detalle de Ventas</h2>
        <div className="flex items-center gap-2 bg-slate-100 rounded-lg p-1">
          <button
            onClick={() => setViewMode('summary')}
            className={`px-3 py-1.5 rounded-md text-sm font-medium transition-colors ${
              viewMode === 'summary'
                ? 'bg-white text-slate-800 shadow-sm'
                : 'text-slate-600'
            }`}
          >
            Resumen
          </button>
          <button
            onClick={() => setViewMode('detail')}
            className={`px-3 py-1.5 rounded-md text-sm font-medium transition-colors ${
              viewMode === 'detail'
                ? 'bg-white text-slate-800 shadow-sm'
                : 'text-slate-600'
            }`}
          >
            Detalle
          </button>
        </div>
      </div>
      
      {/* Sales Table */}
      <div className="card overflow-hidden">
        <table className="w-full">
          <thead className="bg-slate-50 border-b border-slate-200">
            <tr>
              <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">
                # Orden
              </th>
              <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">
                Cliente
              </th>
              <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">
                Fecha
              </th>
              <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">
                Peso
              </th>
              <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">
                Total
              </th>
              <th className="px-4 py-3 text-center text-xs font-semibold text-slate-500 uppercase">
                Estado
              </th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {kpis.filteredOrders.slice(0, 10).map((order) => (
              <tr key={order.id} className="hover:bg-slate-50">
                <td className="px-4 py-3">
                  <div className="flex items-center gap-2">
                    <span className="font-medium text-slate-800">#{order.order_number}</span>
                    {order.is_express && (
                      <span className="badge bg-warning-100 text-warning-700 text-xs">Express</span>
                    )}
                  </div>
                </td>
                <td className="px-4 py-3 text-slate-600">{order.customer_name}</td>
                <td className="px-4 py-3 text-sm text-slate-500">{formatDate(order.created_at)}</td>
                <td className="px-4 py-3 text-right text-slate-600">
                  {order.total_weight?.toFixed(2) || '0.00'} kg
                </td>
                <td className="px-4 py-3 text-right font-semibold text-slate-800">
                  {formatCurrency(order.total || 0)}
                </td>
                <td className="px-4 py-3 text-center">
                  <StatusBadge status={order.status} />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        
        {kpis.filteredOrders.length === 0 && (
          <div className="text-center py-12 text-slate-400">
            <Package className="w-12 h-12 mx-auto mb-3 opacity-50" />
            <p className="text-sm">No hay órdenes en este período</p>
          </div>
        )}
      </div>
    </div>
  );
}

// KPI Card Component
function KPICard({ title, value, change, icon: Icon, color }) {
  const isPositive = change >= 0;
  
  const colorClasses = {
    primary: 'bg-primary-50 text-primary-600',
    success: 'bg-success-50 text-success-600',
    warning: 'bg-warning-50 text-warning-600',
    purple: 'bg-purple-50 text-purple-600',
  };
  
  return (
    <div className="card p-4">
      <div className="flex items-start justify-between">
        <div>
          <p className="text-sm text-slate-500 mb-1">{title}</p>
          <p className="text-2xl font-bold text-slate-800">{value}</p>
        </div>
        <div className={`p-2.5 rounded-xl ${colorClasses[color]}`}>
          <Icon className="w-5 h-5" />
        </div>
      </div>
      
      <div className="flex items-center gap-1 mt-3">
        {isPositive ? (
          <TrendingUp className="w-4 h-4 text-success-500" />
        ) : (
          <TrendingDown className="w-4 h-4 text-error-500" />
        )}
        <span className={`text-sm font-medium ${isPositive ? 'text-success-600' : 'text-error-600'}`}>
          {isPositive ? '+' : ''}{change.toFixed(1)}%
        </span>
        <span className="text-xs text-slate-400 ml-1">vs período anterior</span>
      </div>
    </div>
  );
}

// Status Badge Component
function StatusBadge({ status }) {
  const statusConfig = {
    pending: { label: 'Pendiente', bg: 'bg-amber-100', text: 'text-amber-700' },
    washing: { label: 'Lavando', bg: 'bg-blue-100', text: 'text-blue-700' },
    drying: { label: 'Secando', bg: 'bg-cyan-100', text: 'text-cyan-700' },
    folding: { label: 'Doblando', bg: 'bg-purple-100', text: 'text-purple-700' },
    ready: { label: 'Listo', bg: 'bg-green-100', text: 'text-green-700' },
    completed: { label: 'Completado', bg: 'bg-slate-100', text: 'text-slate-700' },
  };
  
  const config = statusConfig[status] || statusConfig.pending;
  
  return (
    <span className={`badge ${config.bg} ${config.text}`}>
      {config.label}
    </span>
  );
}

export default AnalyticsPage;
