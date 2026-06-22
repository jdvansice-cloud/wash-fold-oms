import React, { useState, useMemo, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { 
  Calendar, DollarSign, CreditCard, Banknote, Calculator,
  CheckCircle, AlertTriangle, Clock, ChevronDown, ChevronUp,
  FileText, Save, History, Coins, Wallet, TrendingUp,
  Package, Scale, Users, XCircle, RotateCcw
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useAuth } from '../context/AuthContext';
import { useFeature } from '../hooks/useFeature';
import { supabase } from '../lib/supabase';
import EFacturaReconciliation from '../components/efactura/EFacturaReconciliation';
import AttendanceCard from '../components/AttendanceCard';

function EODPage() {
  const { state } = useApp();
  const { appUser } = useAuth();
  const hasInvoices = useFeature('invoices');
  const [searchParams] = useSearchParams();
  
  // Check if user is admin
  const isAdmin = appUser?.role === 'admin';
  
  // Selected date for closing
  const [selectedDate, setSelectedDate] = useState(() => {
    const today = new Date();
    return today.toISOString().split('T')[0];
  });
  
  // Cash counting state
  const [cashStart, setCashStart] = useState(100); // Default starting cash
  const [denominations, setDenominations] = useState({
    coins_005: 0,
    coins_010: 0,
    coins_025: 0,
    coins_050: 0,
    bills_1: 0,
    bills_5: 0,
    bills_10: 0,
    bills_20: 0,
    bills_50: 0,
    bills_100: 0,
  });
  
  // Notes
  const [notes, setNotes] = useState('');
  
  // UI State - check query param for auto-opening history
  const [showHistory, setShowHistory] = useState(() => searchParams.get('history') === '1');
  const [savingClosing, setSavingClosing] = useState(false);
  const [closingHistory, setClosingHistory] = useState([]);
  const [loadingHistory, setLoadingHistory] = useState(false);
  const [existingClosing, setExistingClosing] = useState(null);
  
  const formatCurrency = (amount) => `B/${(amount || 0).toFixed(2)}`;
  
  // Calculate counted cash from denominations
  const countedCash = useMemo(() => {
    return (
      denominations.coins_005 * 0.05 +
      denominations.coins_010 * 0.10 +
      denominations.coins_025 * 0.25 +
      denominations.coins_050 * 0.50 +
      denominations.bills_1 * 1 +
      denominations.bills_5 * 5 +
      denominations.bills_10 * 10 +
      denominations.bills_20 * 20 +
      denominations.bills_50 * 50 +
      denominations.bills_100 * 100
    );
  }, [denominations]);
  
  // Calculate daily stats from orders
  const dailyStats = useMemo(() => {
    // Local (wall-clock) day bounds. `new Date('YYYY-MM-DD')` parses as UTC and
    // shifts the day in -05:00, so build from the local-time string instead.
    const dateStart = new Date(`${selectedDate}T00:00:00`);
    const dateEnd = new Date(`${selectedDate}T23:59:59.999`);

    // Filter orders for selected date
    const dayOrders = state.orders.filter(order => {
      const orderDate = new Date(order.created_at);
      return orderDate >= dateStart && orderDate <= dateEnd;
    });
    
    // Separate regular orders from refunds
    const regularOrders = dayOrders.filter(o => o.status !== 'refund' && o.status !== 'cancelled');
    const refundOrders = dayOrders.filter(o => o.status === 'refund');
    
    // Calculate totals
    const totalSales = regularOrders.reduce((sum, o) => sum + Math.abs(o.total || 0), 0);
    const totalRefunds = refundOrders.reduce((sum, o) => sum + Math.abs(o.total || 0), 0);
    const netSales = totalSales - totalRefunds;
    const totalTransactions = regularOrders.length;
    const avgTicket = totalTransactions > 0 ? totalSales / totalTransactions : 0;
    const totalWeight = regularOrders.reduce((sum, o) => sum + (o.total_weight || 0), 0);
    const totalDiscounts = regularOrders.reduce((sum, o) => sum + (o.discount_amount || 0), 0);
    
    // Payment breakdown - we need to get payments for these orders
    // For now, estimate from orders (in real implementation, query payments table)
    const paymentBreakdown = {};
    
    // Get all payment methods
    state.paymentMethods.forEach(pm => {
      paymentBreakdown[pm.name] = 0;
    });
    
    // Add loyalty points as a payment type
    paymentBreakdown['Puntos de Lealtad'] = 0;
    
    return {
      date: selectedDate,
      totalSales,
      totalRefunds,
      netSales,
      totalTransactions,
      refundCount: refundOrders.length,
      avgTicket,
      totalWeight,
      totalDiscounts,
      paymentBreakdown,
      orders: regularOrders,
      refunds: refundOrders,
    };
  }, [state.orders, state.paymentMethods, selectedDate]);
  
  // Load payment breakdown from database
  const [paymentBreakdown, setPaymentBreakdown] = useState({});
  
  useEffect(() => {
    const loadPaymentBreakdown = async () => {
      if (!state.store?.id) return;
      
      const dateStart = new Date(`${selectedDate}T00:00:00`);
      const dateEnd = new Date(`${selectedDate}T23:59:59.999`);

      try {
        const breakdown = {};
        const add = (method, amount) => {
          const m = method || 'Otro';
          breakdown[m] = (breakdown[m] || 0) + Math.abs(amount || 0);
        };

        // Payments on orders created this day (immediate sales + pickup settles).
        const orderIds = dailyStats.orders.map((o) => o.id);
        if (orderIds.length) {
          const { data: payments, error } = await supabase
            .from('payments')
            .select('payment_method, amount')
            .in('order_id', orderIds);
          if (error) throw error;
          (payments || []).forEach((p) => add(p.payment_method, p.amount));
        }

        // B2B consolidated-invoice payments COLLECTED this day (attributed to the
        // collection date, not the orders' creation dates).
        const { data: b2bPayments, error: b2bErr } = await supabase
          .from('payments')
          .select('payment_method, amount, b2b_invoices!inner(store_id)')
          .not('b2b_invoice_id', 'is', null)
          .gte('created_at', dateStart.toISOString())
          .lte('created_at', dateEnd.toISOString())
          .eq('b2b_invoices.store_id', state.store.id);
        if (b2bErr) throw b2bErr;
        (b2bPayments || []).forEach((p) => add(p.payment_method, p.amount));

        setPaymentBreakdown(breakdown);
      } catch (err) {
        console.error('Error loading payment breakdown:', err);
      }
    };
    
    loadPaymentBreakdown();
  }, [dailyStats.orders, state.store?.id, selectedDate]);
  
  // Money actually collected = the recorded payments. Pay-on-pickup orders are
  // unpaid (no payment rows), so they never appear here; their total is shown
  // separately as pending and must NOT count toward the close.
  const collectedEntries = useMemo(
    () => Object.entries(paymentBreakdown),
    [paymentBreakdown],
  );
  const totalCollected = useMemo(
    () => collectedEntries.reduce((a, [, amount]) => a + amount, 0),
    [collectedEntries],
  );
  // Unpaid orders created this day, split by why they're deferred:
  //  - pickup:  collected at pickup
  //  - account: B2B credit, billed later as a consolidated invoice
  const { pickupPending, accountPending, pendingTotal } = useMemo(() => {
    let pickup = 0;
    let account = 0;
    dailyStats.orders.forEach((o) => {
      if (o.payment_status !== 'unpaid') return;
      const amt = Math.abs(o.total || 0);
      if (o.billing_type === 'account') account += amt;
      else pickup += amt;
    });
    return { pickupPending: pickup, accountPending: account, pendingTotal: pickup + account };
  }, [dailyStats.orders]);

  // Expected cash = starting cash + cash sales - cash refunds
  const expectedCash = useMemo(() => {
    const cashSales = paymentBreakdown['Efectivo'] || paymentBreakdown['Cash'] || 0;
    return cashStart + cashSales;
  }, [cashStart, paymentBreakdown]);
  
  // Cash difference
  const cashDifference = countedCash - expectedCash;
  
  // Load closing history
  useEffect(() => {
    const loadHistory = async () => {
      if (!state.store?.id) return;
      
      setLoadingHistory(true);
      try {
        const { data, error } = await supabase
          .from('eod_closings')
          .select('*, users:closed_by(full_name)')
          .eq('store_id', state.store.id)
          .order('closing_date', { ascending: false })
          .limit(30);
        
        if (error) throw error;
        setClosingHistory(data || []);
      } catch (err) {
        console.error('Error loading closing history:', err);
      } finally {
        setLoadingHistory(false);
      }
    };
    
    loadHistory();
  }, [state.store?.id]);
  
  // Check if closing exists for selected date
  useEffect(() => {
    const checkExisting = closingHistory.find(c => c.closing_date === selectedDate);
    setExistingClosing(checkExisting || null);
    
    // If existing, load its data
    if (checkExisting) {
      setCashStart(checkExisting.cash_start || 100);
      setNotes(checkExisting.notes || '');
      // Could also restore denominations if we store them
    }
  }, [selectedDate, closingHistory]);
  
  // Save EOD closing
  const handleSaveClosing = async () => {
    if (!state.store?.id) return;
    
    setSavingClosing(true);
    try {
      const closingData = {
        store_id: state.store.id,
        closing_date: selectedDate,
        total_sales: dailyStats.totalSales,
        total_transactions: dailyStats.totalTransactions,
        avg_ticket: dailyStats.avgTicket,
        total_weight: dailyStats.totalWeight,
        cash_start: cashStart,
        cash_counted: countedCash,
        cash_difference: cashDifference,
        payment_breakdown: paymentBreakdown,
        total_discounts: dailyStats.totalDiscounts,
        total_refunds: dailyStats.totalRefunds,
        notes: notes,
        closed_by: appUser?.id,
        closed_at: new Date().toISOString(),
      };
      
      if (existingClosing) {
        // Update existing
        const { error } = await supabase
          .from('eod_closings')
          .update(closingData)
          .eq('id', existingClosing.id);
        
        if (error) throw error;
      } else {
        // Insert new
        const { error } = await supabase
          .from('eod_closings')
          .insert(closingData);
        
        if (error) throw error;
      }
      
      // Reload history
      const { data } = await supabase
        .from('eod_closings')
        .select('*, users:closed_by(full_name)')
        .eq('store_id', state.store.id)
        .order('closing_date', { ascending: false })
        .limit(30);
      
      setClosingHistory(data || []);
      
      alert(existingClosing ? 'Cierre actualizado correctamente' : 'Cierre guardado correctamente');
    } catch (err) {
      console.error('Error saving closing:', err);
      alert('Error al guardar cierre: ' + err.message);
    } finally {
      setSavingClosing(false);
    }
  };
  
  // Reset cash counting
  const resetDenominations = () => {
    setDenominations({
      coins_005: 0,
      coins_010: 0,
      coins_025: 0,
      coins_050: 0,
      bills_1: 0,
      bills_5: 0,
      bills_10: 0,
      bills_20: 0,
      bills_50: 0,
      bills_100: 0,
    });
  };
  
  const isToday = selectedDate === new Date().toISOString().split('T')[0];
  
  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
        <div>
          <h1 className="text-2xl font-bold text-slate-800 flex items-center gap-2">
            <Clock className="w-7 h-7 text-primary-500" />
            Cierre del Día
          </h1>
          <p className="text-slate-500 mt-1">Resumen de ventas y cuadre de caja</p>
        </div>
        
        <div className="flex items-center gap-3">
          {/* Date Selector */}
          <div className="flex items-center gap-2 bg-white rounded-xl border border-slate-200 px-3 py-2">
            <Calendar className="w-5 h-5 text-slate-400" />
            <input
              type="date"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              max={new Date().toISOString().split('T')[0]}
              className="border-none focus:ring-0 text-slate-700 font-medium"
            />
          </div>
          
          {/* History Toggle */}
          <button
            onClick={() => setShowHistory(!showHistory)}
            className={`flex items-center gap-2 px-4 py-2 rounded-xl border transition-colors ${
              showHistory 
                ? 'bg-primary-50 border-primary-200 text-primary-700' 
                : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'
            }`}
          >
            <History className="w-5 h-5" />
            <span className="hidden md:inline">Historial</span>
          </button>
        </div>
      </div>
      
      {/* Existing Closing Warning */}
      {existingClosing && (
        <div className={`rounded-xl p-4 mb-6 flex items-start gap-3 ${
          isAdmin 
            ? 'bg-amber-50 border border-amber-200' 
            : 'bg-red-50 border border-red-200'
        }`}>
          <AlertTriangle className={`w-5 h-5 flex-shrink-0 mt-0.5 ${
            isAdmin ? 'text-amber-500' : 'text-red-500'
          }`} />
          <div>
            <p className={`font-medium ${isAdmin ? 'text-amber-800' : 'text-red-800'}`}>
              Ya existe un cierre para esta fecha
            </p>
            <p className={`text-sm mt-1 ${isAdmin ? 'text-amber-600' : 'text-red-600'}`}>
              Cerrado por {existingClosing.users?.full_name || 'Usuario'} el {new Date(existingClosing.closed_at).toLocaleString('es-PA')}
            </p>
            {!isAdmin && (
              <p className="text-sm text-red-700 font-medium mt-2">
                Solo los administradores pueden modificar cierres existentes.
              </p>
            )}
          </div>
        </div>
      )}
      
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column - Sales Summary */}
        <div className="lg:col-span-2 space-y-6">
          {/* KPI Cards */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <DollarSign className="w-4 h-4" />
                Ventas Brutas
              </div>
              <p className="text-2xl font-bold text-slate-800">{formatCurrency(dailyStats.totalSales)}</p>
            </div>
            
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <TrendingUp className="w-4 h-4" />
                Ventas Netas
              </div>
              <p className="text-2xl font-bold text-emerald-600">{formatCurrency(dailyStats.netSales)}</p>
            </div>
            
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <Package className="w-4 h-4" />
                Transacciones
              </div>
              <p className="text-2xl font-bold text-slate-800">{dailyStats.totalTransactions}</p>
            </div>
            
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <Scale className="w-4 h-4" />
                Peso Total
              </div>
              <p className="text-2xl font-bold text-slate-800">{dailyStats.totalWeight.toFixed(1)} kg</p>
            </div>
          </div>
          
          {/* Additional Stats */}
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <Calculator className="w-4 h-4" />
                Ticket Promedio
              </div>
              <p className="text-xl font-bold text-slate-800">{formatCurrency(dailyStats.avgTicket)}</p>
            </div>
            
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <XCircle className="w-4 h-4" />
                Descuentos
              </div>
              <p className="text-xl font-bold text-orange-600">{formatCurrency(dailyStats.totalDiscounts)}</p>
            </div>
            
            <div className="bg-white rounded-xl p-4 border border-slate-100 shadow-sm">
              <div className="flex items-center gap-2 text-slate-500 text-sm mb-2">
                <RotateCcw className="w-4 h-4" />
                Reembolsos ({dailyStats.refundCount})
              </div>
              <p className="text-xl font-bold text-red-600">{formatCurrency(dailyStats.totalRefunds)}</p>
            </div>
          </div>
          
          {/* Payment Breakdown */}
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
            <div className="px-5 py-4 border-b border-slate-100 flex items-center gap-2">
              <CreditCard className="w-5 h-5 text-primary-500" />
              <h2 className="font-semibold text-slate-800">Desglose de Pagos</h2>
            </div>
            <div className="p-5">
              {totalCollected === 0 && pendingTotal === 0 ? (
                <p className="text-slate-500 text-center py-4">No hay pagos registrados para esta fecha</p>
              ) : (
                <div className="space-y-3">
                  {collectedEntries
                    .filter(([_, amount]) => amount > 0)
                    .sort((a, b) => b[1] - a[1])
                    .map(([method, amount]) => (
                      <div key={method} className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                          <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                            method.toLowerCase().includes('efectivo') || method.toLowerCase().includes('cash')
                              ? 'bg-emerald-100 text-emerald-600'
                              : method.toLowerCase().includes('tarjeta') || method.toLowerCase().includes('card')
                              ? 'bg-blue-100 text-blue-600'
                              : method.toLowerCase().includes('yappy')
                              ? 'bg-purple-100 text-purple-600'
                              : method.toLowerCase().includes('lealtad') || method.toLowerCase().includes('loyalty')
                              ? 'bg-amber-100 text-amber-600'
                              : 'bg-slate-100 text-slate-600'
                          }`}>
                            {method.toLowerCase().includes('efectivo') || method.toLowerCase().includes('cash') ? (
                              <Banknote className="w-5 h-5" />
                            ) : method.toLowerCase().includes('lealtad') || method.toLowerCase().includes('loyalty') ? (
                              <Coins className="w-5 h-5" />
                            ) : (
                              <CreditCard className="w-5 h-5" />
                            )}
                          </div>
                          <span className="font-medium text-slate-700">{method}</span>
                        </div>
                        <span className="font-bold text-slate-800">{formatCurrency(amount)}</span>
                      </div>
                    ))}
                  
                  {/* Total */}
                  <div className="flex items-center justify-between pt-3 border-t border-slate-200">
                    <span className="font-semibold text-slate-700">Total Cobrado</span>
                    <span className="font-bold text-lg text-primary-600">
                      {formatCurrency(totalCollected)}
                    </span>
                  </div>

                  {/* Deferred amounts — not collected today */}
                  {pickupPending > 0 && (
                    <div className="flex items-center justify-between rounded-lg bg-amber-50 px-3 py-2 text-sm">
                      <span className="flex items-center gap-2 font-medium text-amber-700">
                        <Clock className="w-4 h-4" />
                        Pendiente (pagar al recoger)
                      </span>
                      <span className="font-semibold text-amber-700">{formatCurrency(pickupPending)}</span>
                    </div>
                  )}
                  {accountPending > 0 && (
                    <div className="flex items-center justify-between rounded-lg bg-indigo-50 px-3 py-2 text-sm">
                      <span className="flex items-center gap-2 font-medium text-indigo-700">
                        <FileText className="w-4 h-4" />
                        A crédito (B2B, factura posterior)
                      </span>
                      <span className="font-semibold text-indigo-700">{formatCurrency(accountPending)}</span>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Electronic Invoicing Reconciliation */}
          {hasInvoices && (
            <EFacturaReconciliation orders={dailyStats.orders} formatCurrency={formatCurrency} />
          )}

          {/* Staff attendance (worked vs scheduled hours) */}
          <AttendanceCard storeId={state.store?.id} selectedDate={selectedDate} />
        </div>

        {/* Right Column - Cash Reconciliation */}
        <div className="space-y-6">
          {/* Cash Counting */}
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
            <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Wallet className="w-5 h-5 text-emerald-500" />
                <h2 className="font-semibold text-slate-800">Cuadre de Caja</h2>
              </div>
              {!(existingClosing && !isAdmin) && (
                <button
                  onClick={resetDenominations}
                  className="text-xs text-slate-500 hover:text-slate-700"
                >
                  Limpiar
                </button>
              )}
            </div>
            
            <div className={`p-5 space-y-4 ${existingClosing && !isAdmin ? 'opacity-60' : ''}`}>
              {/* Starting Cash */}
              <div>
                <label className="block text-sm font-medium text-slate-600 mb-1">
                  Efectivo Inicial
                </label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                  <input
                    type="number"
                    value={cashStart}
                    onChange={(e) => setCashStart(parseFloat(e.target.value) || 0)}
                    disabled={existingClosing && !isAdmin}
                    className="w-full pl-9 pr-4 py-2 border border-slate-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 disabled:bg-slate-100 disabled:cursor-not-allowed"
                    step="0.01"
                  />
                </div>
              </div>
              
              {/* Denomination Counter */}
              <div>
                <label className="block text-sm font-medium text-slate-600 mb-2">
                  Conteo de Efectivo
                </label>
                
                {/* Coins */}
                <div className="grid grid-cols-4 gap-2 mb-3">
                  {[
                    { key: 'coins_005', label: '5¢', value: 0.05 },
                    { key: 'coins_010', label: '10¢', value: 0.10 },
                    { key: 'coins_025', label: '25¢', value: 0.25 },
                    { key: 'coins_050', label: '50¢', value: 0.50 },
                  ].map(coin => (
                    <div key={coin.key} className="bg-slate-50 rounded-lg p-2 text-center">
                      <div className="text-xs text-slate-500 mb-1">{coin.label}</div>
                      <input
                        type="number"
                        min="0"
                        value={denominations[coin.key]}
                        onChange={(e) => setDenominations(prev => ({
                          ...prev,
                          [coin.key]: parseInt(e.target.value) || 0
                        }))}
                        disabled={existingClosing && !isAdmin}
                        className="w-full text-center border border-slate-200 rounded px-1 py-1 text-sm disabled:bg-slate-100 disabled:cursor-not-allowed"
                      />
                    </div>
                  ))}
                </div>
                
                {/* Bills */}
                <div className="grid grid-cols-3 gap-2">
                  {[
                    { key: 'bills_1', label: 'B/1', value: 1 },
                    { key: 'bills_5', label: 'B/5', value: 5 },
                    { key: 'bills_10', label: 'B/10', value: 10 },
                    { key: 'bills_20', label: 'B/20', value: 20 },
                    { key: 'bills_50', label: 'B/50', value: 50 },
                    { key: 'bills_100', label: 'B/100', value: 100 },
                  ].map(bill => (
                    <div key={bill.key} className="bg-emerald-50 rounded-lg p-2 text-center">
                      <div className="text-xs text-emerald-600 font-medium mb-1">{bill.label}</div>
                      <input
                        type="number"
                        min="0"
                        value={denominations[bill.key]}
                        onChange={(e) => setDenominations(prev => ({
                          ...prev,
                          [bill.key]: parseInt(e.target.value) || 0
                        }))}
                        disabled={existingClosing && !isAdmin}
                        className="w-full text-center border border-emerald-200 rounded px-1 py-1 text-sm disabled:bg-emerald-100 disabled:cursor-not-allowed"
                      />
                    </div>
                  ))}
                </div>
              </div>
              
              {/* Cash Summary */}
              <div className="bg-slate-50 rounded-lg p-4 space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600">Efectivo Inicial</span>
                  <span className="font-medium">{formatCurrency(cashStart)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600">+ Ventas en Efectivo</span>
                  <span className="font-medium text-emerald-600">
                    {formatCurrency(paymentBreakdown['Efectivo'] || paymentBreakdown['Cash'] || 0)}
                  </span>
                </div>
                <div className="flex justify-between text-sm pt-2 border-t border-slate-200">
                  <span className="text-slate-700 font-medium">Efectivo Esperado</span>
                  <span className="font-bold">{formatCurrency(expectedCash)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-700 font-medium">Efectivo Contado</span>
                  <span className="font-bold">{formatCurrency(countedCash)}</span>
                </div>
                <div className={`flex justify-between text-sm pt-2 border-t border-slate-200 ${
                  cashDifference === 0 ? 'text-emerald-600' : 
                  cashDifference > 0 ? 'text-blue-600' : 'text-red-600'
                }`}>
                  <span className="font-medium">Diferencia</span>
                  <span className="font-bold flex items-center gap-1">
                    {cashDifference === 0 ? (
                      <CheckCircle className="w-4 h-4" />
                    ) : (
                      <AlertTriangle className="w-4 h-4" />
                    )}
                    {cashDifference >= 0 ? '+' : ''}{formatCurrency(cashDifference)}
                  </span>
                </div>
              </div>
            </div>
          </div>
          
          {/* Notes */}
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
            <div className="px-5 py-4 border-b border-slate-100 flex items-center gap-2">
              <FileText className="w-5 h-5 text-slate-400" />
              <h2 className="font-semibold text-slate-800">Notas</h2>
            </div>
            <div className={`p-5 ${existingClosing && !isAdmin ? 'opacity-60' : ''}`}>
              <textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                placeholder="Agregar notas del cierre..."
                rows={3}
                disabled={existingClosing && !isAdmin}
                className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 resize-none disabled:bg-slate-100 disabled:cursor-not-allowed"
              />
            </div>
          </div>
          
          {/* Save Button */}
          {/* Non-admins can only create new closings, not update existing ones */}
          {existingClosing && !isAdmin ? (
            <div className="w-full py-4 rounded-xl bg-slate-200 text-slate-500 text-center font-medium">
              <div className="flex items-center justify-center gap-2">
                <AlertTriangle className="w-5 h-5" />
                Cierre ya registrado
              </div>
              <p className="text-xs mt-1">Solo administradores pueden modificar</p>
            </div>
          ) : (
            <button
              onClick={handleSaveClosing}
              disabled={savingClosing}
              className={`w-full flex items-center justify-center gap-2 py-4 rounded-xl font-semibold text-white transition-all ${
                savingClosing 
                  ? 'bg-slate-400 cursor-wait' 
                  : 'bg-primary-500 hover:bg-primary-600 shadow-lg hover:shadow-xl'
              }`}
            >
              {savingClosing ? (
                <>
                  <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin" />
                  Guardando...
                </>
              ) : (
                <>
                  <Save className="w-5 h-5" />
                  {existingClosing ? 'Actualizar Cierre' : 'Guardar Cierre'}
                </>
              )}
            </button>
          )}
        </div>
      </div>
      
      {/* History Panel */}
      {showHistory && (
        <div className="mt-6 bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
          <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
            <div className="flex items-center gap-2">
              <History className="w-5 h-5 text-primary-500" />
              <h2 className="font-semibold text-slate-800">Historial de Cierres</h2>
            </div>
            <button
              onClick={() => setShowHistory(false)}
              className="text-slate-400 hover:text-slate-600"
            >
              <ChevronUp className="w-5 h-5" />
            </button>
          </div>
          
          <div className="overflow-x-auto">
            {loadingHistory ? (
              <div className="p-8 text-center text-slate-500">
                <div className="w-8 h-8 border-2 border-primary-500 border-t-transparent rounded-full animate-spin mx-auto mb-2" />
                Cargando historial...
              </div>
            ) : closingHistory.length === 0 ? (
              <div className="p-8 text-center text-slate-500">
                No hay cierres registrados
              </div>
            ) : (
              <table className="w-full text-sm">
                <thead className="bg-slate-50">
                  <tr>
                    <th className="px-4 py-3 text-left font-medium text-slate-600">Fecha</th>
                    <th className="px-4 py-3 text-right font-medium text-slate-600">Ventas</th>
                    <th className="px-4 py-3 text-right font-medium text-slate-600">Trans.</th>
                    <th className="px-4 py-3 text-right font-medium text-slate-600">Efectivo Esp.</th>
                    <th className="px-4 py-3 text-right font-medium text-slate-600">Efectivo Cont.</th>
                    <th className="px-4 py-3 text-right font-medium text-slate-600">Diferencia</th>
                    <th className="px-4 py-3 text-left font-medium text-slate-600">Cerrado Por</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {closingHistory.map(closing => {
                    const diff = (closing.cash_counted || 0) - ((closing.cash_start || 0) + (closing.payment_breakdown?.Efectivo || closing.payment_breakdown?.Cash || 0));
                    return (
                      <tr 
                        key={closing.id} 
                        className={`hover:bg-slate-50 cursor-pointer ${
                          closing.closing_date === selectedDate ? 'bg-primary-50' : ''
                        }`}
                        onClick={() => setSelectedDate(closing.closing_date)}
                      >
                        <td className="px-4 py-3 font-medium text-slate-800">
                          {new Date(closing.closing_date + 'T12:00:00').toLocaleDateString('es-PA', {
                            weekday: 'short',
                            month: 'short',
                            day: 'numeric'
                          })}
                        </td>
                        <td className="px-4 py-3 text-right font-medium text-slate-800">
                          {formatCurrency(closing.total_sales)}
                        </td>
                        <td className="px-4 py-3 text-right text-slate-600">
                          {closing.total_transactions}
                        </td>
                        <td className="px-4 py-3 text-right text-slate-600">
                          {formatCurrency((closing.cash_start || 0) + (closing.payment_breakdown?.Efectivo || closing.payment_breakdown?.Cash || 0))}
                        </td>
                        <td className="px-4 py-3 text-right text-slate-600">
                          {formatCurrency(closing.cash_counted)}
                        </td>
                        <td className={`px-4 py-3 text-right font-medium ${
                          closing.cash_difference === 0 ? 'text-emerald-600' :
                          closing.cash_difference > 0 ? 'text-blue-600' : 'text-red-600'
                        }`}>
                          {closing.cash_difference >= 0 ? '+' : ''}{formatCurrency(closing.cash_difference)}
                        </td>
                        <td className="px-4 py-3 text-slate-600">
                          {closing.users?.full_name || '-'}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export default EODPage;
