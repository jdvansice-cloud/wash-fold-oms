import React, { useState, useMemo } from 'react';
import { 
  TrendingUp, TrendingDown, DollarSign, Package, 
  Users, Scale, Calendar, Filter, Download,
  ShoppingCart, Clock, Percent, CreditCard,
  ChevronDown, X, ArrowLeftRight
} from 'lucide-react';
import { useApp } from '../context/AppContext';

function AnalyticsPage() {
  const { state } = useApp();
  const [dateRange, setDateRange] = useState('week'); // today, week, month, custom
  const [customStartDate, setCustomStartDate] = useState('');
  const [customEndDate, setCustomEndDate] = useState('');
  const [showCustomDatePicker, setShowCustomDatePicker] = useState(false);
  
  // Comparison settings
  const [compareEnabled, setCompareEnabled] = useState(false);
  const [compareType, setCompareType] = useState('previous'); // previous, lastyear, custom
  const [compareCustomStart, setCompareCustomStart] = useState('');
  const [compareCustomEnd, setCompareCustomEnd] = useState('');
  const [showCompareOptions, setShowCompareOptions] = useState(false);
  
  const [viewMode, setViewMode] = useState('summary'); // summary, detail
  
  // Calculate date ranges
  const dateRanges = useMemo(() => {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    let startDate, endDate;
    
    switch (dateRange) {
      case 'today':
        startDate = today;
        endDate = now;
        break;
      case 'week':
        startDate = new Date(today);
        startDate.setDate(today.getDate() - 6);
        endDate = now;
        break;
      case 'month':
        startDate = new Date(today);
        startDate.setDate(today.getDate() - 29);
        endDate = now;
        break;
      case 'custom':
        startDate = customStartDate ? new Date(customStartDate) : new Date(today.setDate(today.getDate() - 7));
        endDate = customEndDate ? new Date(customEndDate + 'T23:59:59') : now;
        break;
      default:
        startDate = new Date(today);
        startDate.setDate(today.getDate() - 6);
        endDate = now;
    }
    
    // Calculate comparison dates
    let compareStartDate, compareEndDate;
    const daysDiff = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
    
    if (compareType === 'previous') {
      // Previous period: same number of days, immediately before
      compareEndDate = new Date(startDate);
      compareEndDate.setDate(compareEndDate.getDate() - 1);
      compareStartDate = new Date(compareEndDate);
      compareStartDate.setDate(compareStartDate.getDate() - daysDiff + 1);
    } else if (compareType === 'lastyear') {
      // Last year: same dates, 1 year ago
      compareStartDate = new Date(startDate);
      compareStartDate.setFullYear(compareStartDate.getFullYear() - 1);
      compareEndDate = new Date(endDate);
      compareEndDate.setFullYear(compareEndDate.getFullYear() - 1);
    } else if (compareType === 'custom') {
      compareStartDate = compareCustomStart ? new Date(compareCustomStart) : null;
      compareEndDate = compareCustomEnd ? new Date(compareCustomEnd + 'T23:59:59') : null;
    }
    
    return {
      startDate,
      endDate,
      compareStartDate,
      compareEndDate,
      daysDiff,
    };
  }, [dateRange, customStartDate, customEndDate, compareType, compareCustomStart, compareCustomEnd]);
  
  // Calculate KPIs from orders
  const kpis = useMemo(() => {
    const { startDate, endDate, compareStartDate, compareEndDate } = dateRanges;
    
    // Filter orders for current period
    const filteredOrders = state.orders.filter(order => {
      const orderDate = new Date(order.created_at);
      return orderDate >= startDate && orderDate <= endDate;
    });
    
    // Filter orders for comparison period
    const compareOrders = compareEnabled && compareStartDate && compareEndDate
      ? state.orders.filter(order => {
          const orderDate = new Date(order.created_at);
          return orderDate >= compareStartDate && orderDate <= compareEndDate;
        })
      : [];
    
    // Current period stats
    const totalSales = filteredOrders.reduce((sum, o) => sum + (o.total || 0), 0);
    const totalWeight = filteredOrders.reduce((sum, o) => sum + (o.total_weight || 0), 0);
    const totalOrders = filteredOrders.length;
    const avgTicket = totalOrders > 0 ? totalSales / totalOrders : 0;
    const expressOrders = filteredOrders.filter(o => o.is_express).length;
    const expressRate = totalOrders > 0 ? (expressOrders / totalOrders) * 100 : 0;
    const uniqueCustomers = new Set(filteredOrders.map(o => o.customer_id).filter(Boolean)).size;
    const avgWeightPerOrder = totalOrders > 0 ? totalWeight / totalOrders : 0;
    
    // Comparison period stats
    const compareTotalSales = compareOrders.reduce((sum, o) => sum + (o.total || 0), 0);
    const compareTotalWeight = compareOrders.reduce((sum, o) => sum + (o.total_weight || 0), 0);
    const compareTotalOrders = compareOrders.length;
    const compareAvgTicket = compareTotalOrders > 0 ? compareTotalSales / compareTotalOrders : 0;
    
    // Calculate growth percentages
    const calcGrowth = (current, previous) => {
      if (previous === 0) return current > 0 ? 100 : 0;
      return ((current - previous) / previous) * 100;
    };
    
    const salesGrowth = compareEnabled ? calcGrowth(totalSales, compareTotalSales) : null;
    const ordersGrowth = compareEnabled ? calcGrowth(totalOrders, compareTotalOrders) : null;
    const weightGrowth = compareEnabled ? calcGrowth(totalWeight, compareTotalWeight) : null;
    const avgTicketGrowth = compareEnabled ? calcGrowth(avgTicket, compareAvgTicket) : null;
    
    return {
      totalSales,
      totalWeight,
      totalOrders,
      avgTicket,
      expressOrders,
      expressRate,
      uniqueCustomers,
      avgWeightPerOrder,
      salesGrowth,
      ordersGrowth,
      weightGrowth,
      avgTicketGrowth,
      filteredOrders,
      // Comparison data
      compareTotalSales,
      compareTotalOrders,
      compareTotalWeight,
      compareAvgTicket,
    };
  }, [state.orders, dateRanges, compareEnabled]);
  
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
  
  const formatDateShort = (date) => {
    if (!date) return '';
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
    }).format(date);
  };
  
  const handleDateRangeChange = (range) => {
    setDateRange(range);
    if (range !== 'custom') {
      setShowCustomDatePicker(false);
    } else {
      setShowCustomDatePicker(true);
    }
  };
  
  const getDateRangeLabel = () => {
    const { startDate, endDate } = dateRanges;
    return `${formatDateShort(startDate)} - ${formatDateShort(endDate)}`;
  };
  
  const getCompareRangeLabel = () => {
    const { compareStartDate, compareEndDate } = dateRanges;
    if (!compareStartDate || !compareEndDate) return '';
    return `${formatDateShort(compareStartDate)} - ${formatDateShort(compareEndDate)}`;
  };

  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Analíticas</h1>
          <p className="text-sm text-slate-500">Dashboard de rendimiento del negocio</p>
        </div>
        
        {/* Export Button */}
        <button className="btn-secondary">
          <Download className="w-4 h-4" />
          Exportar
        </button>
      </div>
      
      {/* Filters Row */}
      <div className="card p-4 mb-6">
        <div className="flex flex-wrap items-center gap-4">
          {/* Date Range Filter */}
          <div className="flex items-center gap-2">
            <Calendar className="w-4 h-4 text-slate-400" />
            <span className="text-sm font-medium text-slate-600">Período:</span>
            <div className="flex items-center gap-1 bg-slate-100 rounded-xl p-1">
              {[
                { value: 'today', label: 'Hoy' },
                { value: 'week', label: '7 días' },
                { value: 'month', label: '30 días' },
                { value: 'custom', label: 'Personalizado' },
              ].map((option) => (
                <button
                  key={option.value}
                  onClick={() => handleDateRangeChange(option.value)}
                  className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                    dateRange === option.value
                      ? 'bg-white text-primary-600 shadow-sm'
                      : 'text-slate-600 hover:text-slate-800'
                  }`}
                >
                  {option.label}
                </button>
              ))}
            </div>
          </div>
          
          {/* Custom Date Picker */}
          {showCustomDatePicker && (
            <div className="flex items-center gap-2">
              <input
                type="date"
                value={customStartDate}
                onChange={(e) => setCustomStartDate(e.target.value)}
                className="input w-36 text-sm"
              />
              <span className="text-slate-400">a</span>
              <input
                type="date"
                value={customEndDate}
                onChange={(e) => setCustomEndDate(e.target.value)}
                className="input w-36 text-sm"
              />
            </div>
          )}
          
          {/* Divider */}
          <div className="h-8 w-px bg-slate-200" />
          
          {/* Compare Toggle */}
          <div className="flex items-center gap-2">
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={compareEnabled}
                onChange={(e) => setCompareEnabled(e.target.checked)}
                className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
              />
              <ArrowLeftRight className="w-4 h-4 text-slate-400" />
              <span className="text-sm font-medium text-slate-600">Comparar</span>
            </label>
            
            {compareEnabled && (
              <div className="relative">
                <button
                  onClick={() => setShowCompareOptions(!showCompareOptions)}
                  className="flex items-center gap-2 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 rounded-lg text-sm font-medium text-slate-700 transition-colors"
                >
                  {compareType === 'previous' && 'Período anterior'}
                  {compareType === 'lastyear' && 'Año anterior'}
                  {compareType === 'custom' && 'Personalizado'}
                  <ChevronDown className="w-4 h-4" />
                </button>
                
                {showCompareOptions && (
                  <div className="absolute top-full left-0 mt-1 bg-white rounded-xl shadow-elevated border border-slate-200 py-1 z-10 min-w-[180px]">
                    <button
                      onClick={() => { setCompareType('previous'); setShowCompareOptions(false); }}
                      className={`w-full px-4 py-2 text-left text-sm hover:bg-slate-50 ${compareType === 'previous' ? 'text-primary-600 font-medium' : 'text-slate-700'}`}
                    >
                      Período anterior
                      <p className="text-xs text-slate-400">Misma cantidad de días</p>
                    </button>
                    <button
                      onClick={() => { setCompareType('lastyear'); setShowCompareOptions(false); }}
                      className={`w-full px-4 py-2 text-left text-sm hover:bg-slate-50 ${compareType === 'lastyear' ? 'text-primary-600 font-medium' : 'text-slate-700'}`}
                    >
                      Año anterior
                      <p className="text-xs text-slate-400">Mismas fechas, hace 1 año</p>
                    </button>
                    <button
                      onClick={() => { setCompareType('custom'); setShowCompareOptions(false); }}
                      className={`w-full px-4 py-2 text-left text-sm hover:bg-slate-50 ${compareType === 'custom' ? 'text-primary-600 font-medium' : 'text-slate-700'}`}
                    >
                      Personalizado
                      <p className="text-xs text-slate-400">Elegir rango manualmente</p>
                    </button>
                  </div>
                )}
              </div>
            )}
            
            {/* Custom Compare Date Picker */}
            {compareEnabled && compareType === 'custom' && (
              <div className="flex items-center gap-2">
                <input
                  type="date"
                  value={compareCustomStart}
                  onChange={(e) => setCompareCustomStart(e.target.value)}
                  className="input w-36 text-sm"
                />
                <span className="text-slate-400">a</span>
                <input
                  type="date"
                  value={compareCustomEnd}
                  onChange={(e) => setCompareCustomEnd(e.target.value)}
                  className="input w-36 text-sm"
                />
              </div>
            )}
          </div>
        </div>
        
        {/* Date Range Labels */}
        <div className="flex items-center gap-4 mt-3 pt-3 border-t border-slate-100">
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-primary-500" />
            <span className="text-sm text-slate-600">
              <span className="font-medium">Período actual:</span> {getDateRangeLabel()}
            </span>
          </div>
          
          {compareEnabled && (
            <div className="flex items-center gap-2">
              <div className="w-3 h-3 rounded-full bg-slate-400" />
              <span className="text-sm text-slate-600">
                <span className="font-medium">Comparación:</span> {getCompareRangeLabel()}
              </span>
            </div>
          )}
        </div>
      </div>
      
      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <KPICard
          title="Ventas Totales"
          value={formatCurrency(kpis.totalSales)}
          compareValue={compareEnabled ? formatCurrency(kpis.compareTotalSales) : null}
          change={kpis.salesGrowth}
          icon={DollarSign}
          color="primary"
        />
        <KPICard
          title="Total Órdenes"
          value={kpis.totalOrders}
          compareValue={compareEnabled ? kpis.compareTotalOrders : null}
          change={kpis.ordersGrowth}
          icon={ShoppingCart}
          color="success"
        />
        <KPICard
          title="Peso Total"
          value={`${kpis.totalWeight.toFixed(2)} kg`}
          compareValue={compareEnabled ? `${kpis.compareTotalWeight.toFixed(2)} kg` : null}
          change={kpis.weightGrowth}
          icon={Scale}
          color="warning"
        />
        <KPICard
          title="Ticket Promedio"
          value={formatCurrency(kpis.avgTicket)}
          compareValue={compareEnabled ? formatCurrency(kpis.compareAvgTicket) : null}
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
            <span className="text-2xl font-bold text-slate-800">{kpis.uniqueCustomers}</span>
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
              {kpis.avgWeightPerOrder.toFixed(2)}
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
        
        {kpis.filteredOrders.length > 10 && (
          <div className="p-4 bg-slate-50 border-t border-slate-100 text-center">
            <span className="text-sm text-slate-500">
              Mostrando 10 de {kpis.filteredOrders.length} órdenes
            </span>
          </div>
        )}
      </div>
    </div>
  );
}

// KPI Card Component
function KPICard({ title, value, compareValue, change, icon: Icon, color }) {
  const hasChange = change !== null && change !== undefined;
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
          {compareValue && (
            <p className="text-sm text-slate-400 mt-1">
              vs {compareValue}
            </p>
          )}
        </div>
        <div className={`p-2.5 rounded-xl ${colorClasses[color]}`}>
          <Icon className="w-5 h-5" />
        </div>
      </div>
      
      {hasChange && (
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
      )}
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
