import React, { useState, useMemo } from 'react';
import { 
  Calendar, Clock, DollarSign, CreditCard, Smartphone, Building2,
  FileText, Gift, Percent, Users, Tag, TrendingDown, TrendingUp,
  Printer, Download, Check, X, AlertTriangle, RefreshCw, Banknote,
  ChevronDown, ChevronUp, Lock, Calculator, ClipboardCheck
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { generateClosingReport, printClosingReport, saveClosingReport } from '../services/closingService';

function DailyClosingPage() {
  const { state } = useApp();
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split('T')[0]);
  const [showCashCount, setShowCashCount] = useState(false);
  const [cashCount, setCashCount] = useState({
    coins: { '0.01': 0, '0.05': 0, '0.10': 0, '0.25': 0, '0.50': 0, '1.00': 0 },
    bills: { '1': 0, '5': 0, '10': 0, '20': 0, '50': 0, '100': 0 },
  });
  const [openingBalance, setOpeningBalance] = useState(100); // Default opening balance
  const [closingNotes, setClosingNotes] = useState('');
  const [isClosing, setIsClosing] = useState(false);
  const [showClosingConfirm, setShowClosingConfirm] = useState(false);
  const [expandedSections, setExpandedSections] = useState({
    payments: true,
    discounts: true,
    refunds: true,
    users: true,
  });

  // Sample users for demo
  const users = state.users || [
    { id: 'user-1', name: 'María García', role: 'operator' },
    { id: 'user-2', name: 'Juan Pérez', role: 'operator' },
    { id: 'user-3', name: 'Admin', role: 'admin' },
  ];

  // Get transactions for selected date
  const dailyData = useMemo(() => {
    const startOfDay = new Date(selectedDate);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(selectedDate);
    endOfDay.setHours(23, 59, 59, 999);

    // Filter orders for the selected date
    const dayOrders = state.orders.filter(order => {
      const orderDate = new Date(order.created_at);
      return orderDate >= startOfDay && orderDate <= endOfDay;
    });

    // Calculate sales by payment method
    const salesByPayment = {
      cash: 0,
      card: 0,
      yappy: 0,
      ach: 0,
      check: 0,
      invoice: 0,
      pickup: 0,
      gift_card: 0,
    };

    // Calculate discounts by user
    const discountsByUser = {};
    
    // Calculate refunds by user
    const refundsByUser = {};
    
    // Track transactions per user
    const transactionsByUser = {};

    dayOrders.forEach(order => {
      // Sales by payment method
      const method = order.payment_method || 'cash';
      salesByPayment[method] = (salesByPayment[method] || 0) + (order.total || 0);

      // Track by user
      const userId = order.user_id || 'user-1';
      const userName = order.user_name || users.find(u => u.id === userId)?.name || 'Usuario';
      
      if (!transactionsByUser[userId]) {
        transactionsByUser[userId] = {
          name: userName,
          orders: 0,
          sales: 0,
          discounts: 0,
          refunds: 0,
        };
      }
      
      transactionsByUser[userId].orders += 1;
      transactionsByUser[userId].sales += order.total || 0;

      // Track discounts
      if (order.discount_amount > 0) {
        transactionsByUser[userId].discounts += order.discount_amount;
        
        if (!discountsByUser[userId]) {
          discountsByUser[userId] = {
            name: userName,
            total: 0,
            count: 0,
            details: [],
          };
        }
        discountsByUser[userId].total += order.discount_amount;
        discountsByUser[userId].count += 1;
        discountsByUser[userId].details.push({
          orderNumber: order.order_number,
          amount: order.discount_amount,
          type: order.discount_type || 'manual',
          reason: order.discount_reason || 'Descuento manual',
        });
      }

      // Track refunds
      if (order.refund_amount > 0 || order.status === 'refunded') {
        const refundAmount = order.refund_amount || order.total || 0;
        transactionsByUser[userId].refunds += refundAmount;
        
        if (!refundsByUser[userId]) {
          refundsByUser[userId] = {
            name: userName,
            total: 0,
            count: 0,
            details: [],
          };
        }
        refundsByUser[userId].total += refundAmount;
        refundsByUser[userId].count += 1;
        refundsByUser[userId].details.push({
          orderNumber: order.order_number,
          amount: refundAmount,
          reason: order.refund_reason || 'Sin especificar',
        });
      }
    });

    // Calculate totals
    const totalSales = Object.values(salesByPayment).reduce((sum, val) => sum + val, 0);
    const totalDiscounts = Object.values(discountsByUser).reduce((sum, user) => sum + user.total, 0);
    const totalRefunds = Object.values(refundsByUser).reduce((sum, user) => sum + user.total, 0);
    const netSales = totalSales - totalRefunds;
    
    // Expected cash = opening + cash sales - cash refunds
    const cashRefunds = dayOrders
      .filter(o => o.payment_method === 'cash' && (o.refund_amount > 0 || o.status === 'refunded'))
      .reduce((sum, o) => sum + (o.refund_amount || o.total || 0), 0);
    const expectedCash = openingBalance + salesByPayment.cash - cashRefunds;

    return {
      orders: dayOrders,
      totalOrders: dayOrders.length,
      salesByPayment,
      totalSales,
      totalDiscounts,
      totalRefunds,
      netSales,
      expectedCash,
      discountsByUser,
      refundsByUser,
      transactionsByUser,
    };
  }, [state.orders, selectedDate, openingBalance, users]);

  // Calculate counted cash total
  const countedCashTotal = useMemo(() => {
    const coinsTotal = Object.entries(cashCount.coins).reduce((sum, [denom, count]) => {
      return sum + (parseFloat(denom) * count);
    }, 0);
    const billsTotal = Object.entries(cashCount.bills).reduce((sum, [denom, count]) => {
      return sum + (parseInt(denom) * count);
    }, 0);
    return coinsTotal + billsTotal;
  }, [cashCount]);

  const cashVariance = countedCashTotal - dailyData.expectedCash;

  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;

  const paymentMethodLabels = {
    cash: { label: 'Efectivo', icon: Banknote, color: 'bg-green-100 text-green-700' },
    card: { label: 'Tarjeta', icon: CreditCard, color: 'bg-blue-100 text-blue-700' },
    yappy: { label: 'Yappy', icon: Smartphone, color: 'bg-pink-100 text-pink-700' },
    ach: { label: 'ACH / Banco', icon: Building2, color: 'bg-purple-100 text-purple-700' },
    check: { label: 'Cheque', icon: FileText, color: 'bg-amber-100 text-amber-700' },
    invoice: { label: 'Factura a Crédito', icon: FileText, color: 'bg-orange-100 text-orange-700' },
    pickup: { label: 'Pago en Recogida', icon: Clock, color: 'bg-cyan-100 text-cyan-700' },
    gift_card: { label: 'Tarjeta Regalo', icon: Gift, color: 'bg-rose-100 text-rose-700' },
  };

  const toggleSection = (section) => {
    setExpandedSections(prev => ({ ...prev, [section]: !prev[section] }));
  };

  const handleCashCountChange = (type, denom, value) => {
    setCashCount(prev => ({
      ...prev,
      [type]: {
        ...prev[type],
        [denom]: parseInt(value) || 0,
      },
    }));
  };

  const handleCloseDay = async () => {
    setIsClosing(true);
    try {
      const closingData = {
        date: selectedDate,
        openingBalance,
        closingBalance: countedCashTotal,
        expectedCash: dailyData.expectedCash,
        variance: cashVariance,
        ...dailyData,
        cashCount,
        notes: closingNotes,
        closedAt: new Date().toISOString(),
        closedBy: state.currentUser?.name || 'Admin',
      };

      // Save closing report
      await saveClosingReport(closingData);
      
      // Print closing report
      await printClosingReport(closingData);

      setShowClosingConfirm(false);
      alert('Día cerrado exitosamente. Reporte impreso.');
    } catch (error) {
      console.error('Error closing day:', error);
      alert('Error al cerrar el día: ' + error.message);
    } finally {
      setIsClosing(false);
    }
  };

  const handlePrintReport = async () => {
    const reportData = {
      date: selectedDate,
      openingBalance,
      closingBalance: countedCashTotal,
      expectedCash: dailyData.expectedCash,
      variance: cashVariance,
      ...dailyData,
      cashCount,
      notes: closingNotes,
    };
    
    try {
      await printClosingReport(reportData);
    } catch (error) {
      console.error('Print error:', error);
      // Fallback to browser print
      generateClosingReport(reportData);
    }
  };

  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Cierre del Día</h1>
          <p className="text-sm text-slate-500">Reconciliación y reportes de cierre</p>
        </div>
        
        <div className="flex items-center gap-3">
          {/* Date Selector */}
          <div className="flex items-center gap-2 bg-white border border-slate-200 rounded-xl px-4 py-2">
            <Calendar className="w-4 h-4 text-slate-400" />
            <input
              type="date"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              className="border-0 bg-transparent text-slate-700 font-medium focus:outline-none"
            />
          </div>
          
          <button 
            onClick={handlePrintReport}
            className="btn-secondary"
          >
            <Printer className="w-4 h-4" />
            Imprimir Reporte
          </button>
          
          <button 
            onClick={() => setShowClosingConfirm(true)}
            className="btn-primary"
          >
            <Lock className="w-4 h-4" />
            Cerrar Día
          </button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <SummaryCard
          title="Ventas Totales"
          value={formatCurrency(dailyData.totalSales)}
          subtitle={`${dailyData.totalOrders} órdenes`}
          icon={DollarSign}
          color="success"
        />
        <SummaryCard
          title="Descuentos"
          value={formatCurrency(dailyData.totalDiscounts)}
          subtitle={`${Object.values(dailyData.discountsByUser).reduce((sum, u) => sum + u.count, 0)} aplicados`}
          icon={Tag}
          color="warning"
        />
        <SummaryCard
          title="Reembolsos"
          value={formatCurrency(dailyData.totalRefunds)}
          subtitle={`${Object.values(dailyData.refundsByUser).reduce((sum, u) => sum + u.count, 0)} procesados`}
          icon={RefreshCw}
          color="error"
        />
        <SummaryCard
          title="Ventas Netas"
          value={formatCurrency(dailyData.netSales)}
          subtitle="Total - Reembolsos"
          icon={TrendingUp}
          color="primary"
        />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column - Payment Methods & Details */}
        <div className="lg:col-span-2 space-y-6">
          {/* Sales by Payment Method */}
          <div className="card">
            <button
              onClick={() => toggleSection('payments')}
              className="w-full p-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-primary-100 text-primary-600 rounded-lg">
                  <CreditCard className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <h2 className="font-semibold text-slate-800">Ventas por Método de Pago</h2>
                  <p className="text-sm text-slate-500">Desglose de ingresos</p>
                </div>
              </div>
              {expandedSections.payments ? (
                <ChevronUp className="w-5 h-5 text-slate-400" />
              ) : (
                <ChevronDown className="w-5 h-5 text-slate-400" />
              )}
            </button>
            
            {expandedSections.payments && (
              <div className="p-4 pt-0 space-y-2">
                {Object.entries(dailyData.salesByPayment).map(([method, amount]) => {
                  const config = paymentMethodLabels[method];
                  if (!config || amount === 0) return null;
                  const Icon = config.icon;
                  const percentage = dailyData.totalSales > 0 
                    ? ((amount / dailyData.totalSales) * 100).toFixed(1)
                    : 0;
                  
                  return (
                    <div key={method} className="flex items-center justify-between p-3 bg-slate-50 rounded-xl">
                      <div className="flex items-center gap-3">
                        <span className={`p-2 rounded-lg ${config.color}`}>
                          <Icon className="w-4 h-4" />
                        </span>
                        <span className="font-medium text-slate-700">{config.label}</span>
                      </div>
                      <div className="text-right">
                        <p className="font-semibold text-slate-800">{formatCurrency(amount)}</p>
                        <p className="text-xs text-slate-500">{percentage}%</p>
                      </div>
                    </div>
                  );
                })}
                
                {dailyData.totalSales === 0 && (
                  <div className="text-center py-8 text-slate-400">
                    <DollarSign className="w-10 h-10 mx-auto mb-2 opacity-50" />
                    <p className="text-sm">No hay ventas registradas</p>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Discounts by User */}
          <div className="card">
            <button
              onClick={() => toggleSection('discounts')}
              className="w-full p-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-warning-100 text-warning-600 rounded-lg">
                  <Tag className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <h2 className="font-semibold text-slate-800">Descuentos Manuales por Usuario</h2>
                  <p className="text-sm text-slate-500">Total: {formatCurrency(dailyData.totalDiscounts)}</p>
                </div>
              </div>
              {expandedSections.discounts ? (
                <ChevronUp className="w-5 h-5 text-slate-400" />
              ) : (
                <ChevronDown className="w-5 h-5 text-slate-400" />
              )}
            </button>
            
            {expandedSections.discounts && (
              <div className="p-4 pt-0">
                {Object.entries(dailyData.discountsByUser).length > 0 ? (
                  <div className="space-y-4">
                    {Object.entries(dailyData.discountsByUser).map(([userId, userData]) => (
                      <div key={userId} className="border border-slate-200 rounded-xl overflow-hidden">
                        <div className="flex items-center justify-between p-3 bg-slate-50">
                          <div className="flex items-center gap-2">
                            <div className="w-8 h-8 bg-warning-100 text-warning-600 rounded-full flex items-center justify-center font-semibold text-sm">
                              {userData.name.charAt(0)}
                            </div>
                            <span className="font-medium text-slate-700">{userData.name}</span>
                          </div>
                          <div className="text-right">
                            <p className="font-semibold text-warning-600">{formatCurrency(userData.total)}</p>
                            <p className="text-xs text-slate-500">{userData.count} descuento(s)</p>
                          </div>
                        </div>
                        <div className="divide-y divide-slate-100">
                          {userData.details.map((detail, i) => (
                            <div key={i} className="flex items-center justify-between px-3 py-2 text-sm">
                              <div>
                                <span className="text-slate-600">Orden #{detail.orderNumber}</span>
                                <span className="text-slate-400 ml-2">• {detail.reason}</span>
                              </div>
                              <span className="font-medium text-warning-600">-{formatCurrency(detail.amount)}</span>
                            </div>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-8 text-slate-400">
                    <Tag className="w-10 h-10 mx-auto mb-2 opacity-50" />
                    <p className="text-sm">No hay descuentos registrados</p>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Refunds by User */}
          <div className="card">
            <button
              onClick={() => toggleSection('refunds')}
              className="w-full p-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-error-100 text-error-600 rounded-lg">
                  <RefreshCw className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <h2 className="font-semibold text-slate-800">Reembolsos por Usuario</h2>
                  <p className="text-sm text-slate-500">Total: {formatCurrency(dailyData.totalRefunds)}</p>
                </div>
              </div>
              {expandedSections.refunds ? (
                <ChevronUp className="w-5 h-5 text-slate-400" />
              ) : (
                <ChevronDown className="w-5 h-5 text-slate-400" />
              )}
            </button>
            
            {expandedSections.refunds && (
              <div className="p-4 pt-0">
                {Object.entries(dailyData.refundsByUser).length > 0 ? (
                  <div className="space-y-4">
                    {Object.entries(dailyData.refundsByUser).map(([userId, userData]) => (
                      <div key={userId} className="border border-slate-200 rounded-xl overflow-hidden">
                        <div className="flex items-center justify-between p-3 bg-slate-50">
                          <div className="flex items-center gap-2">
                            <div className="w-8 h-8 bg-error-100 text-error-600 rounded-full flex items-center justify-center font-semibold text-sm">
                              {userData.name.charAt(0)}
                            </div>
                            <span className="font-medium text-slate-700">{userData.name}</span>
                          </div>
                          <div className="text-right">
                            <p className="font-semibold text-error-600">{formatCurrency(userData.total)}</p>
                            <p className="text-xs text-slate-500">{userData.count} reembolso(s)</p>
                          </div>
                        </div>
                        <div className="divide-y divide-slate-100">
                          {userData.details.map((detail, i) => (
                            <div key={i} className="flex items-center justify-between px-3 py-2 text-sm">
                              <div>
                                <span className="text-slate-600">Orden #{detail.orderNumber}</span>
                                <span className="text-slate-400 ml-2">• {detail.reason}</span>
                              </div>
                              <span className="font-medium text-error-600">-{formatCurrency(detail.amount)}</span>
                            </div>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-8 text-slate-400">
                    <RefreshCw className="w-10 h-10 mx-auto mb-2 opacity-50" />
                    <p className="text-sm">No hay reembolsos registrados</p>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Sales by User */}
          <div className="card">
            <button
              onClick={() => toggleSection('users')}
              className="w-full p-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-purple-100 text-purple-600 rounded-lg">
                  <Users className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <h2 className="font-semibold text-slate-800">Resumen por Usuario</h2>
                  <p className="text-sm text-slate-500">Rendimiento del equipo</p>
                </div>
              </div>
              {expandedSections.users ? (
                <ChevronUp className="w-5 h-5 text-slate-400" />
              ) : (
                <ChevronDown className="w-5 h-5 text-slate-400" />
              )}
            </button>
            
            {expandedSections.users && (
              <div className="p-4 pt-0">
                {Object.entries(dailyData.transactionsByUser).length > 0 ? (
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead className="bg-slate-50">
                        <tr>
                          <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">Usuario</th>
                          <th className="px-4 py-3 text-center text-xs font-semibold text-slate-500 uppercase">Órdenes</th>
                          <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Ventas</th>
                          <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Descuentos</th>
                          <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Reembolsos</th>
                          <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Neto</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {Object.entries(dailyData.transactionsByUser).map(([userId, data]) => (
                          <tr key={userId} className="hover:bg-slate-50">
                            <td className="px-4 py-3">
                              <div className="flex items-center gap-2">
                                <div className="w-8 h-8 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center font-semibold text-sm">
                                  {data.name.charAt(0)}
                                </div>
                                <span className="font-medium text-slate-700">{data.name}</span>
                              </div>
                            </td>
                            <td className="px-4 py-3 text-center text-slate-600">{data.orders}</td>
                            <td className="px-4 py-3 text-right font-medium text-slate-800">{formatCurrency(data.sales)}</td>
                            <td className="px-4 py-3 text-right text-warning-600">
                              {data.discounts > 0 ? `-${formatCurrency(data.discounts)}` : '-'}
                            </td>
                            <td className="px-4 py-3 text-right text-error-600">
                              {data.refunds > 0 ? `-${formatCurrency(data.refunds)}` : '-'}
                            </td>
                            <td className="px-4 py-3 text-right font-semibold text-slate-800">
                              {formatCurrency(data.sales - data.refunds)}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                ) : (
                  <div className="text-center py-8 text-slate-400">
                    <Users className="w-10 h-10 mx-auto mb-2 opacity-50" />
                    <p className="text-sm">No hay transacciones registradas</p>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>

        {/* Right Column - Cash Reconciliation */}
        <div className="space-y-6">
          {/* Opening Balance */}
          <div className="card p-4">
            <h3 className="font-semibold text-slate-800 mb-3 flex items-center gap-2">
              <Banknote className="w-5 h-5 text-green-600" />
              Balance de Apertura
            </h3>
            <div className="flex items-center gap-2">
              <span className="text-slate-500">B/</span>
              <input
                type="number"
                value={openingBalance}
                onChange={(e) => setOpeningBalance(parseFloat(e.target.value) || 0)}
                className="input text-right text-lg font-semibold"
                step="0.01"
              />
            </div>
          </div>

          {/* Cash Count */}
          <div className="card">
            <button
              onClick={() => setShowCashCount(!showCashCount)}
              className="w-full p-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-green-100 text-green-600 rounded-lg">
                  <Calculator className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <h3 className="font-semibold text-slate-800">Conteo de Caja</h3>
                  <p className="text-sm text-slate-500">Arqueo físico</p>
                </div>
              </div>
              {showCashCount ? (
                <ChevronUp className="w-5 h-5 text-slate-400" />
              ) : (
                <ChevronDown className="w-5 h-5 text-slate-400" />
              )}
            </button>

            {showCashCount && (
              <div className="p-4 pt-0 space-y-4">
                {/* Bills */}
                <div>
                  <p className="text-xs font-semibold text-slate-500 uppercase mb-2">Billetes</p>
                  <div className="grid grid-cols-3 gap-2">
                    {Object.entries(cashCount.bills).map(([denom, count]) => (
                      <div key={denom} className="text-center">
                        <label className="text-xs text-slate-500 block mb-1">B/{denom}</label>
                        <input
                          type="number"
                          value={count}
                          onChange={(e) => handleCashCountChange('bills', denom, e.target.value)}
                          className="input text-center text-sm py-2"
                          min="0"
                        />
                      </div>
                    ))}
                  </div>
                </div>

                {/* Coins */}
                <div>
                  <p className="text-xs font-semibold text-slate-500 uppercase mb-2">Monedas</p>
                  <div className="grid grid-cols-3 gap-2">
                    {Object.entries(cashCount.coins).map(([denom, count]) => (
                      <div key={denom} className="text-center">
                        <label className="text-xs text-slate-500 block mb-1">B/{denom}</label>
                        <input
                          type="number"
                          value={count}
                          onChange={(e) => handleCashCountChange('coins', denom, e.target.value)}
                          className="input text-center text-sm py-2"
                          min="0"
                        />
                      </div>
                    ))}
                  </div>
                </div>

                {/* Counted Total */}
                <div className="pt-3 border-t border-slate-200">
                  <div className="flex justify-between items-center">
                    <span className="text-slate-600">Total Contado</span>
                    <span className="text-xl font-bold text-slate-800">{formatCurrency(countedCashTotal)}</span>
                  </div>
                </div>
              </div>
            )}
          </div>

          {/* Cash Summary */}
          <div className="card p-4 space-y-4">
            <h3 className="font-semibold text-slate-800 flex items-center gap-2">
              <ClipboardCheck className="w-5 h-5 text-primary-600" />
              Resumen de Caja
            </h3>
            
            <div className="space-y-3">
              <div className="flex justify-between items-center text-sm">
                <span className="text-slate-500">Balance de Apertura</span>
                <span className="font-medium text-slate-700">{formatCurrency(openingBalance)}</span>
              </div>
              <div className="flex justify-between items-center text-sm">
                <span className="text-slate-500">+ Ventas en Efectivo</span>
                <span className="font-medium text-green-600">+{formatCurrency(dailyData.salesByPayment.cash)}</span>
              </div>
              <div className="flex justify-between items-center text-sm border-t border-slate-200 pt-3">
                <span className="text-slate-600 font-medium">Efectivo Esperado</span>
                <span className="font-semibold text-slate-800">{formatCurrency(dailyData.expectedCash)}</span>
              </div>
              <div className="flex justify-between items-center text-sm">
                <span className="text-slate-500">Efectivo Contado</span>
                <span className="font-medium text-slate-700">{formatCurrency(countedCashTotal)}</span>
              </div>
              <div className={`flex justify-between items-center text-sm pt-3 border-t border-slate-200 ${
                Math.abs(cashVariance) < 0.01 ? 'text-success-600' : 
                Math.abs(cashVariance) <= 5 ? 'text-warning-600' : 'text-error-600'
              }`}>
                <span className="font-medium flex items-center gap-2">
                  {Math.abs(cashVariance) < 0.01 ? (
                    <Check className="w-4 h-4" />
                  ) : (
                    <AlertTriangle className="w-4 h-4" />
                  )}
                  Diferencia
                </span>
                <span className="font-bold text-lg">
                  {cashVariance >= 0 ? '+' : ''}{formatCurrency(cashVariance)}
                </span>
              </div>
            </div>
          </div>

          {/* Closing Notes */}
          <div className="card p-4">
            <h3 className="font-semibold text-slate-800 mb-3">Notas de Cierre</h3>
            <textarea
              value={closingNotes}
              onChange={(e) => setClosingNotes(e.target.value)}
              placeholder="Observaciones del día, incidentes, etc..."
              className="input resize-none"
              rows={3}
            />
          </div>
        </div>
      </div>

      {/* Closing Confirmation Modal */}
      {showClosingConfirm && (
        <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
          <div className="bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in">
            <div className="p-6 text-center">
              <div className={`w-16 h-16 mx-auto mb-4 rounded-full flex items-center justify-center ${
                Math.abs(cashVariance) < 0.01 ? 'bg-success-100' : 
                Math.abs(cashVariance) <= 5 ? 'bg-warning-100' : 'bg-error-100'
              }`}>
                {Math.abs(cashVariance) < 0.01 ? (
                  <Check className="w-8 h-8 text-success-600" />
                ) : (
                  <AlertTriangle className={`w-8 h-8 ${
                    Math.abs(cashVariance) <= 5 ? 'text-warning-600' : 'text-error-600'
                  }`} />
                )}
              </div>
              
              <h2 className="text-xl font-bold text-slate-800 mb-2">Confirmar Cierre del Día</h2>
              
              <p className="text-slate-600 mb-4">
                {Math.abs(cashVariance) < 0.01 
                  ? 'La caja cuadra perfectamente.'
                  : `Hay una diferencia de ${formatCurrency(Math.abs(cashVariance))} en caja.`
                }
              </p>
              
              <div className="bg-slate-50 rounded-xl p-4 mb-6 text-left space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-500">Fecha</span>
                  <span className="font-medium">{new Date(selectedDate).toLocaleDateString('es-PA')}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-500">Ventas Totales</span>
                  <span className="font-medium">{formatCurrency(dailyData.totalSales)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-500">Efectivo Esperado</span>
                  <span className="font-medium">{formatCurrency(dailyData.expectedCash)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-500">Efectivo Contado</span>
                  <span className="font-medium">{formatCurrency(countedCashTotal)}</span>
                </div>
              </div>

              <div className="flex gap-3">
                <button
                  onClick={() => setShowClosingConfirm(false)}
                  className="flex-1 py-3 px-4 bg-slate-100 hover:bg-slate-200 text-slate-700 font-medium rounded-xl transition-colors"
                  disabled={isClosing}
                >
                  Cancelar
                </button>
                <button
                  onClick={handleCloseDay}
                  disabled={isClosing}
                  className="flex-1 py-3 px-4 bg-primary-500 hover:bg-primary-600 text-white font-medium rounded-xl transition-colors flex items-center justify-center gap-2"
                >
                  {isClosing ? (
                    <>
                      <RefreshCw className="w-4 h-4 animate-spin" />
                      Cerrando...
                    </>
                  ) : (
                    <>
                      <Lock className="w-4 h-4" />
                      Cerrar Día
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

// Summary Card Component
function SummaryCard({ title, value, subtitle, icon: Icon, color }) {
  const colorClasses = {
    primary: 'bg-primary-100 text-primary-600',
    success: 'bg-success-100 text-success-600',
    warning: 'bg-warning-100 text-warning-600',
    error: 'bg-error-100 text-error-600',
  };

  return (
    <div className="card p-4">
      <div className="flex items-start justify-between">
        <div>
          <p className="text-sm text-slate-500 mb-1">{title}</p>
          <p className="text-2xl font-bold text-slate-800">{value}</p>
          <p className="text-xs text-slate-400 mt-1">{subtitle}</p>
        </div>
        <div className={`p-2.5 rounded-xl ${colorClasses[color]}`}>
          <Icon className="w-5 h-5" />
        </div>
      </div>
    </div>
  );
}

export default DailyClosingPage;
