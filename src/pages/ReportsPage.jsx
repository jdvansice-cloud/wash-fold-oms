import React, { useState, useMemo } from 'react';
import { 
  Calendar, Download, FileText, ChevronDown, 
  ArrowLeftRight, DollarSign, Package, Truck,
  TrendingUp, TrendingDown, Percent
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useFeature } from '../hooks/useFeature';
import ElectronicInvoicesReport from '../components/efactura/ElectronicInvoicesReport';

function ReportsPage() {
  const { state } = useApp();
  const hasInvoices = useFeature('invoices');
  
  // Date Range State
  const [dateRange, setDateRange] = useState('month'); // today, week, month, custom
  const [customStartDate, setCustomStartDate] = useState('');
  const [customEndDate, setCustomEndDate] = useState('');
  const [showCustomDatePicker, setShowCustomDatePicker] = useState(false);
  
  // Comparison settings
  const [compareEnabled, setCompareEnabled] = useState(false);
  const [compareType, setCompareType] = useState('previous'); // previous, lastyear, custom
  const [compareCustomStart, setCompareCustomStart] = useState('');
  const [compareCustomEnd, setCompareCustomEnd] = useState('');
  const [showCompareOptions, setShowCompareOptions] = useState(false);
  
  // Report selection
  const [selectedReport, setSelectedReport] = useState('sales-by-day');
  
  const reportTypes = [
    { value: 'sales-by-day', label: 'Ventas por Día', icon: Calendar },
    ...(hasInvoices ? [{ value: 'efactura', label: 'Facturas Electrónicas', icon: FileText }] : []),
    // Future reports can be added here
    // { value: 'sales-by-product', label: 'Ventas por Producto', icon: Package },
    // { value: 'sales-by-customer', label: 'Ventas por Cliente', icon: Users },
    // { value: 'payment-methods', label: 'Métodos de Pago', icon: CreditCard },
  ];
  
  const formatCurrency = (amount) => `B/${(amount || 0).toFixed(2)}`;
  
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
        startDate.setDate(today.getDate() - 29);
        endDate = now;
    }
    
    // Calculate comparison dates
    let compareStartDate, compareEndDate;
    const daysDiff = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
    
    if (compareType === 'previous') {
      compareEndDate = new Date(startDate);
      compareEndDate.setDate(compareEndDate.getDate() - 1);
      compareStartDate = new Date(compareEndDate);
      compareStartDate.setDate(compareStartDate.getDate() - daysDiff + 1);
    } else if (compareType === 'lastyear') {
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
  
  // Generate Sales by Day report data
  const salesByDayData = useMemo(() => {
    const { startDate, endDate, compareStartDate, compareEndDate } = dateRanges;
    
    // Filter orders for current period (exclude cancelled and refund status from main calculations)
    const filteredOrders = state.orders.filter(order => {
      const orderDate = new Date(order.created_at);
      return orderDate >= startDate && orderDate <= endDate && 
             order.status !== 'cancelled' && order.status !== 'refund';
    });
    
    // Filter comparison orders
    const compareOrders = compareEnabled && compareStartDate && compareEndDate
      ? state.orders.filter(order => {
          const orderDate = new Date(order.created_at);
          return orderDate >= compareStartDate && orderDate <= compareEndDate &&
                 order.status !== 'cancelled' && order.status !== 'refund';
        })
      : [];
    
    // Group orders by date
    const groupByDate = (orders) => {
      const grouped = {};
      
      orders.forEach(order => {
        const dateKey = new Date(order.created_at).toISOString().split('T')[0];
        
        if (!grouped[dateKey]) {
          grouped[dateKey] = {
            date: dateKey,
            qty: 0,
            productsSubtotal: 0,
            deliverySubtotal: 0,
            totalItbms: 0,
            total: 0,
          };
        }
        
        grouped[dateKey].qty += 1;
        grouped[dateKey].productsSubtotal += (order.subtotal || 0);
        grouped[dateKey].deliverySubtotal += (order.delivery_charge || 0);
        grouped[dateKey].totalItbms += (order.tax_amount || 0);
        grouped[dateKey].total += (order.total || 0);
      });
      
      return grouped;
    };
    
    const currentGrouped = groupByDate(filteredOrders);
    const compareGrouped = groupByDate(compareOrders);
    
    // Create sorted array of dates
    const allDates = new Set([
      ...Object.keys(currentGrouped),
      ...(compareEnabled ? Object.keys(compareGrouped) : [])
    ]);
    
    // Create array sorted by date descending (most recent first)
    const sortedDates = Array.from(allDates).sort((a, b) => new Date(b) - new Date(a));
    
    // Calculate totals
    const currentTotals = {
      qty: 0,
      productsSubtotal: 0,
      deliverySubtotal: 0,
      totalItbms: 0,
      total: 0,
    };
    
    const compareTotals = {
      qty: 0,
      productsSubtotal: 0,
      deliverySubtotal: 0,
      totalItbms: 0,
      total: 0,
    };
    
    Object.values(currentGrouped).forEach(day => {
      currentTotals.qty += day.qty;
      currentTotals.productsSubtotal += day.productsSubtotal;
      currentTotals.deliverySubtotal += day.deliverySubtotal;
      currentTotals.totalItbms += day.totalItbms;
      currentTotals.total += day.total;
    });
    
    if (compareEnabled) {
      Object.values(compareGrouped).forEach(day => {
        compareTotals.qty += day.qty;
        compareTotals.productsSubtotal += day.productsSubtotal;
        compareTotals.deliverySubtotal += day.deliverySubtotal;
        compareTotals.totalItbms += day.totalItbms;
        compareTotals.total += day.total;
      });
    }
    
    return {
      currentGrouped,
      compareGrouped,
      sortedDates: sortedDates.filter(d => currentGrouped[d]), // Only show dates with current data
      currentTotals,
      compareTotals,
    };
  }, [state.orders, dateRanges, compareEnabled]);
  
  const formatDateShort = (date) => {
    if (!date) return '';
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
    }).format(date);
  };
  
  const formatDateFull = (dateStr) => {
    const date = new Date(dateStr + 'T12:00:00');
    return new Intl.DateTimeFormat('es-PA', {
      weekday: 'short',
      day: '2-digit',
      month: 'short',
      year: 'numeric',
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
  
  // Calculate growth percentage
  const calcGrowth = (current, previous) => {
    if (previous === 0) return current > 0 ? 100 : 0;
    return ((current - previous) / previous) * 100;
  };
  
  // Export to CSV
  const handleExportCSV = () => {
    const { currentGrouped, sortedDates, currentTotals } = salesByDayData;
    
    let csv = 'Fecha,Cantidad,Productos Subtotal,Delivery Subtotal,ITBMS,Total\n';
    
    sortedDates.forEach(dateKey => {
      const day = currentGrouped[dateKey];
      csv += `${formatDateFull(dateKey)},${day.qty},${day.productsSubtotal.toFixed(2)},${day.deliverySubtotal.toFixed(2)},${day.totalItbms.toFixed(2)},${day.total.toFixed(2)}\n`;
    });
    
    csv += `\nTOTAL,${currentTotals.qty},${currentTotals.productsSubtotal.toFixed(2)},${currentTotals.deliverySubtotal.toFixed(2)},${currentTotals.totalItbms.toFixed(2)},${currentTotals.total.toFixed(2)}\n`;
    
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = `ventas-por-dia-${dateRanges.startDate.toISOString().split('T')[0]}-${dateRanges.endDate.toISOString().split('T')[0]}.csv`;
    link.click();
  };

  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Reportes</h1>
          <p className="text-sm text-slate-500">Reportes detallados del negocio</p>
        </div>
        
        {/* Export Button */}
        <button onClick={handleExportCSV} className="btn-secondary">
          <Download className="w-4 h-4" />
          Exportar CSV
        </button>
      </div>
      
      {/* Filters Row */}
      <div className="card p-4 mb-6">
        <div className="flex flex-wrap items-center gap-4">
          {/* Report Type Selector */}
          <div className="flex items-center gap-2">
            <FileText className="w-4 h-4 text-slate-400" />
            <span className="text-sm font-medium text-slate-600">Reporte:</span>
            <select
              value={selectedReport}
              onChange={(e) => setSelectedReport(e.target.value)}
              className="input text-sm py-1.5 pr-8"
            >
              {reportTypes.map(report => (
                <option key={report.value} value={report.value}>
                  {report.label}
                </option>
              ))}
            </select>
          </div>
          
          {/* Divider */}
          <div className="h-8 w-px bg-slate-200" />
          
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
      
      {/* Report Content */}
      {selectedReport === 'sales-by-day' && (
        <SalesByDayReport
          data={salesByDayData}
          compareEnabled={compareEnabled}
          formatCurrency={formatCurrency}
          formatDateFull={formatDateFull}
          calcGrowth={calcGrowth}
        />
      )}

      {selectedReport === 'efactura' && (
        <ElectronicInvoicesReport
          storeId={state.store?.id}
          startISO={dateRanges.startDate?.toISOString()}
          endISO={dateRanges.endDate?.toISOString()}
          formatCurrency={formatCurrency}
        />
      )}
    </div>
  );
}

// Sales by Day Report Component
function SalesByDayReport({ data, compareEnabled, formatCurrency, formatDateFull, calcGrowth }) {
  const { currentGrouped, compareGrouped, sortedDates, currentTotals, compareTotals } = data;
  
  const GrowthIndicator = ({ current, previous }) => {
    if (!compareEnabled || previous === undefined) return null;
    
    const growth = calcGrowth(current, previous);
    const isPositive = growth >= 0;
    
    return (
      <span className={`inline-flex items-center gap-0.5 text-xs font-medium ${
        isPositive ? 'text-emerald-600' : 'text-red-600'
      }`}>
        {isPositive ? <TrendingUp className="w-3 h-3" /> : <TrendingDown className="w-3 h-3" />}
        {Math.abs(growth).toFixed(1)}%
      </span>
    );
  };
  
  if (sortedDates.length === 0) {
    return (
      <div className="card p-12 text-center">
        <Package className="w-12 h-12 text-slate-300 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-slate-600">No hay datos</h3>
        <p className="text-sm text-slate-400 mt-1">No se encontraron ventas en el período seleccionado</p>
      </div>
    );
  }
  
  return (
    <div className="card overflow-hidden">
      {/* Summary Cards */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-4 p-4 bg-slate-50 border-b border-slate-200">
        <div className="text-center">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Transacciones</p>
          <p className="text-xl font-bold text-slate-800">{currentTotals.qty}</p>
          {compareEnabled && (
            <p className="text-xs text-slate-400">
              vs {compareTotals.qty} <GrowthIndicator current={currentTotals.qty} previous={compareTotals.qty} />
            </p>
          )}
        </div>
        <div className="text-center">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Productos</p>
          <p className="text-xl font-bold text-slate-800">{formatCurrency(currentTotals.productsSubtotal)}</p>
          {compareEnabled && (
            <p className="text-xs text-slate-400">
              vs {formatCurrency(compareTotals.productsSubtotal)} <GrowthIndicator current={currentTotals.productsSubtotal} previous={compareTotals.productsSubtotal} />
            </p>
          )}
        </div>
        <div className="text-center">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">Delivery</p>
          <p className="text-xl font-bold text-slate-800">{formatCurrency(currentTotals.deliverySubtotal)}</p>
          {compareEnabled && (
            <p className="text-xs text-slate-400">
              vs {formatCurrency(compareTotals.deliverySubtotal)} <GrowthIndicator current={currentTotals.deliverySubtotal} previous={compareTotals.deliverySubtotal} />
            </p>
          )}
        </div>
        <div className="text-center">
          <p className="text-xs text-slate-500 uppercase tracking-wide mb-1">ITBMS</p>
          <p className="text-xl font-bold text-slate-800">{formatCurrency(currentTotals.totalItbms)}</p>
          {compareEnabled && (
            <p className="text-xs text-slate-400">
              vs {formatCurrency(compareTotals.totalItbms)} <GrowthIndicator current={currentTotals.totalItbms} previous={compareTotals.totalItbms} />
            </p>
          )}
        </div>
        <div className="text-center bg-primary-50 -m-4 p-4 rounded-lg md:rounded-none md:-m-0 md:p-0 md:bg-transparent">
          <p className="text-xs text-primary-600 uppercase tracking-wide mb-1 font-medium">Total</p>
          <p className="text-xl font-bold text-primary-600">{formatCurrency(currentTotals.total)}</p>
          {compareEnabled && (
            <p className="text-xs text-primary-400">
              vs {formatCurrency(compareTotals.total)} <GrowthIndicator current={currentTotals.total} previous={compareTotals.total} />
            </p>
          )}
        </div>
      </div>
      
      {/* Table */}
      <div className="overflow-x-auto">
        <table className="w-full text-sm">
          <thead className="bg-slate-100">
            <tr>
              <th className="px-4 py-3 text-left font-semibold text-slate-600">Fecha</th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">Cant.</th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">
                <div className="flex items-center justify-end gap-1">
                  <Package className="w-4 h-4" />
                  Productos
                </div>
              </th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">
                <div className="flex items-center justify-end gap-1">
                  <Truck className="w-4 h-4" />
                  Delivery
                </div>
              </th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">
                <div className="flex items-center justify-end gap-1">
                  <Percent className="w-4 h-4" />
                  ITBMS
                </div>
              </th>
              <th className="px-4 py-3 text-right font-semibold text-slate-600">
                <div className="flex items-center justify-end gap-1">
                  <DollarSign className="w-4 h-4" />
                  Total
                </div>
              </th>
              {compareEnabled && (
                <th className="px-4 py-3 text-right font-semibold text-slate-400">vs Anterior</th>
              )}
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {sortedDates.map((dateKey, index) => {
              const day = currentGrouped[dateKey];
              const compareDay = compareGrouped[dateKey];
              const isToday = dateKey === new Date().toISOString().split('T')[0];
              
              return (
                <tr 
                  key={dateKey} 
                  className={`hover:bg-slate-50 ${isToday ? 'bg-primary-50/50' : ''}`}
                >
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-2">
                      {isToday && (
                        <span className="px-1.5 py-0.5 bg-primary-100 text-primary-700 text-xs font-medium rounded">
                          HOY
                        </span>
                      )}
                      <span className="font-medium text-slate-700">{formatDateFull(dateKey)}</span>
                    </div>
                  </td>
                  <td className="px-4 py-3 text-right font-medium text-slate-800">
                    {day.qty}
                  </td>
                  <td className="px-4 py-3 text-right text-slate-600">
                    {formatCurrency(day.productsSubtotal)}
                  </td>
                  <td className="px-4 py-3 text-right text-slate-600">
                    {day.deliverySubtotal > 0 ? formatCurrency(day.deliverySubtotal) : '-'}
                  </td>
                  <td className="px-4 py-3 text-right text-slate-500">
                    {formatCurrency(day.totalItbms)}
                  </td>
                  <td className="px-4 py-3 text-right font-bold text-slate-800">
                    {formatCurrency(day.total)}
                  </td>
                  {compareEnabled && (
                    <td className="px-4 py-3 text-right">
                      {compareDay ? (
                        <div className="flex items-center justify-end gap-2">
                          <span className="text-slate-400">{formatCurrency(compareDay.total)}</span>
                          <GrowthIndicator current={day.total} previous={compareDay.total} />
                        </div>
                      ) : (
                        <span className="text-slate-300">-</span>
                      )}
                    </td>
                  )}
                </tr>
              );
            })}
          </tbody>
          
          {/* Totals Row */}
          <tfoot className="bg-slate-100 font-semibold">
            <tr>
              <td className="px-4 py-3 text-slate-700">TOTAL</td>
              <td className="px-4 py-3 text-right text-slate-800">{currentTotals.qty}</td>
              <td className="px-4 py-3 text-right text-slate-800">{formatCurrency(currentTotals.productsSubtotal)}</td>
              <td className="px-4 py-3 text-right text-slate-800">{formatCurrency(currentTotals.deliverySubtotal)}</td>
              <td className="px-4 py-3 text-right text-slate-600">{formatCurrency(currentTotals.totalItbms)}</td>
              <td className="px-4 py-3 text-right text-primary-600 text-lg">{formatCurrency(currentTotals.total)}</td>
              {compareEnabled && (
                <td className="px-4 py-3 text-right">
                  <div className="flex items-center justify-end gap-2">
                    <span className="text-slate-500">{formatCurrency(compareTotals.total)}</span>
                    <GrowthIndicator current={currentTotals.total} previous={compareTotals.total} />
                  </div>
                </td>
              )}
            </tr>
          </tfoot>
        </table>
      </div>
    </div>
  );
}

export default ReportsPage;
