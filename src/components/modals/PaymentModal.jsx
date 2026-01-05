import React, { useState } from 'react';
import { 
  X, Banknote, CreditCard, Smartphone, Building2, 
  FileText, Clock, Gift, Check, ChevronDown, ChevronUp, Hash, Plus, Trash2 
} from 'lucide-react';

const paymentMethods = [
  { id: 'cash', name: 'Efectivo', icon: Banknote, primary: true },
  { id: 'card', name: 'Tarjeta', icon: CreditCard, primary: true },
  { id: 'yappy', name: 'Yappy', icon: Smartphone },
  { id: 'ach', name: 'ACH / Bank', icon: Building2 },
  { id: 'check', name: 'Cheque', icon: FileText },
  { id: 'invoice', name: 'Factura', icon: FileText },
  { id: 'pickup', name: 'Pagar en Recogida', icon: Clock },
  { id: 'gift_card', name: 'Tarjeta Regalo', icon: Gift },
];

function PaymentModal({ total, subtotal, taxAmount, onClose, onComplete }) {
  // Track multiple payments
  const [payments, setPayments] = useState([]);
  const [activeMethod, setActiveMethod] = useState(null);
  const [showAllMethods, setShowAllMethods] = useState(true);
  
  // For cash payment
  const [cashAmount, setCashAmount] = useState('');
  const [cashTendered, setCashTendered] = useState('');
  
  // For card payment
  const [cardAmount, setCardAmount] = useState('');
  const [cardReference, setCardReference] = useState('');
  
  // For other payments
  const [otherAmount, setOtherAmount] = useState('');
  
  const [processing, setProcessing] = useState(false);
  
  const formatCurrency = (amount) => `B/${Number(amount).toFixed(2)}`;
  
  // Calculate totals (round to 2 decimals to avoid floating point issues)
  const totalPaid = Math.round(payments.reduce((sum, p) => sum + p.amount, 0) * 100) / 100;
  const remaining = Math.round(Math.max(0, total - totalPaid) * 100) / 100;
  const overpaid = Math.round(Math.max(0, totalPaid - total) * 100) / 100;
  
  const handleMethodSelect = (methodId) => {
    setActiveMethod(methodId);
    // Pre-fill with remaining amount
    const remainingStr = remaining.toFixed(2);
    if (methodId === 'cash') {
      setCashAmount(remainingStr);
      setCashTendered('');
    } else if (methodId === 'card') {
      setCardAmount(remainingStr);
      setCardReference('');
    } else {
      setOtherAmount(remainingStr);
    }
  };
  
  const handleCashDenomination = (amount) => {
    const currentAmount = parseFloat(cashTendered) || 0;
    setCashTendered((currentAmount + amount).toFixed(2));
  };
  
  const cashChange = cashTendered && cashAmount
    ? Math.max(0, parseFloat(cashTendered) - parseFloat(cashAmount))
    : 0;
  
  // Add a payment to the list
  const addPayment = () => {
    if (!activeMethod) return;
    
    let paymentData = null;
    
    if (activeMethod === 'cash') {
      const amount = Math.min(parseFloat(cashAmount) || 0, remaining);
      if (amount <= 0) return;
      paymentData = {
        method: 'cash',
        methodName: 'Efectivo',
        amount,
        cashTendered: parseFloat(cashTendered) || amount,
        changeGiven: Math.max(0, (parseFloat(cashTendered) || amount) - amount),
      };
      setCashAmount('');
      setCashTendered('');
    } else if (activeMethod === 'card') {
      const amount = Math.min(parseFloat(cardAmount) || 0, remaining);
      if (amount <= 0 || !cardReference.trim()) return;
      paymentData = {
        method: 'card',
        methodName: 'Tarjeta',
        amount,
        reference: cardReference.trim(),
      };
      setCardAmount('');
      setCardReference('');
    } else {
      const amount = Math.min(parseFloat(otherAmount) || 0, remaining);
      if (amount <= 0) return;
      const methodInfo = paymentMethods.find(m => m.id === activeMethod);
      paymentData = {
        method: activeMethod,
        methodName: methodInfo?.name || activeMethod,
        amount,
      };
      setOtherAmount('');
    }
    
    if (paymentData) {
      setPayments([...payments, paymentData]);
      setActiveMethod(null);
      setShowAllMethods(true);
    }
  };
  
  const removePayment = (index) => {
    setPayments(payments.filter((_, i) => i !== index));
  };
  
  // Can process when total is covered (remaining is 0)
  const canProcess = remaining === 0;
  
  const handleProcess = () => {
    if (!canProcess) return;
    
    setProcessing(true);
    
    setTimeout(() => {
      onComplete({
        payments,
        totalPaid,
        change: overpaid,
        timestamp: new Date().toISOString(),
      });
    }, 500);
  };
  
  // Check if active payment can be added
  const canAddPayment = () => {
    if (!activeMethod) return false;
    if (activeMethod === 'cash') {
      return parseFloat(cashAmount) > 0;
    } else if (activeMethod === 'card') {
      return parseFloat(cardAmount) > 0 && cardReference.trim().length > 0;
    } else {
      return parseFloat(otherAmount) > 0;
    }
  };
  
  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center pt-16 px-4 pb-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div 
        className="relative bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[calc(100vh-5rem)] flex flex-col animate-scale-in"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100 flex-shrink-0">
          <h2 className="text-lg font-semibold text-slate-800">Pago</h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Scrollable Content */}
        <div className="p-4 overflow-y-auto flex-1">
          {/* Amount Summary */}
          <div className="bg-slate-50 rounded-xl p-4 mb-4">
            <div className="flex justify-between items-center mb-2">
              <span className="text-sm text-slate-600">Total a Pagar</span>
              <span className="text-2xl font-bold text-slate-800">{formatCurrency(total)}</span>
            </div>
            {payments.length > 0 && (
              <>
                <div className="flex justify-between items-center text-sm">
                  <span className="text-slate-500">Pagado</span>
                  <span className="text-success-600 font-medium">{formatCurrency(totalPaid)}</span>
                </div>
                <div className="flex justify-between items-center text-sm pt-2 border-t border-slate-200 mt-2">
                  <span className="font-medium text-slate-700">
                    {remaining > 0 ? 'Restante' : 'Cambio'}
                  </span>
                  <span className={`font-bold ${remaining > 0 ? 'text-warning-600' : 'text-success-600'}`}>
                    {formatCurrency(remaining > 0 ? remaining : overpaid)}
                  </span>
                </div>
              </>
            )}
          </div>
          
          {/* Added Payments List */}
          {payments.length > 0 && (
            <div className="mb-4">
              <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">
                Pagos Agregados
              </p>
              <div className="space-y-2">
                {payments.map((payment, index) => (
                  <div key={index} className="flex items-center justify-between bg-success-50 border border-success-200 rounded-lg px-3 py-2">
                    <div className="flex items-center gap-2">
                      <Check className="w-4 h-4 text-success-600" />
                      <span className="text-sm font-medium text-slate-700">{payment.methodName}</span>
                      {payment.reference && (
                        <span className="text-xs text-slate-500">#{payment.reference}</span>
                      )}
                    </div>
                    <div className="flex items-center gap-2">
                      <span className="font-semibold text-slate-800">{formatCurrency(payment.amount)}</span>
                      <button
                        onClick={() => removePayment(index)}
                        className="p-1 text-slate-400 hover:text-error-500 hover:bg-error-50 rounded transition-colors"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
          
          {/* Payment Methods Selection */}
          {remaining > 0 && (
            <>
              {/* Toggle to show/hide methods */}
              {activeMethod && (
                <button
                  onClick={() => setShowAllMethods(!showAllMethods)}
                  className="w-full flex items-center justify-center gap-2 text-sm text-primary-600 mb-3 hover:text-primary-700"
                >
                  {showAllMethods ? (
                    <>
                      <ChevronUp className="w-4 h-4" />
                      Ocultar métodos de pago
                    </>
                  ) : (
                    <>
                      <ChevronDown className="w-4 h-4" />
                      Ver otros métodos de pago
                    </>
                  )}
                </button>
              )}
              
              {/* Payment Methods Grid */}
              {(showAllMethods || !activeMethod) && (
                <div className="mb-4">
                  <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">
                    {payments.length > 0 ? 'Agregar Otro Pago' : 'Seleccionar Método de Pago'}
                  </p>
                  
                  {/* Primary Methods */}
                  <div className="grid grid-cols-2 gap-2 mb-2">
                    {paymentMethods.filter(m => m.primary).map((method) => {
                      const Icon = method.icon;
                      const isSelected = activeMethod === method.id;
                      
                      return (
                        <button
                          key={method.id}
                          onClick={() => handleMethodSelect(method.id)}
                          className={`p-3 rounded-xl border-2 transition-all flex items-center gap-3 ${
                            isSelected
                              ? 'border-primary-500 bg-primary-50'
                              : 'border-slate-200 hover:border-slate-300'
                          }`}
                        >
                          <Icon className={`w-6 h-6 ${
                            isSelected ? 'text-primary-500' : 'text-slate-400'
                          }`} />
                          <span className={`text-sm font-medium ${
                            isSelected ? 'text-primary-600' : 'text-slate-600'
                          }`}>
                            {method.name}
                          </span>
                        </button>
                      );
                    })}
                  </div>
                  
                  {/* Other Methods */}
                  <div className="grid grid-cols-3 gap-2">
                    {paymentMethods.filter(m => !m.primary).map((method) => {
                      const isSelected = activeMethod === method.id;
                      
                      return (
                        <button
                          key={method.id}
                          onClick={() => handleMethodSelect(method.id)}
                          className={`p-2 rounded-lg border text-center transition-all ${
                            isSelected
                              ? 'border-primary-500 bg-primary-50'
                              : 'border-slate-200 hover:border-slate-300'
                          }`}
                        >
                          <p className={`text-xs font-medium ${
                            isSelected ? 'text-primary-600' : 'text-slate-600'
                          }`}>
                            {method.name}
                          </p>
                        </button>
                      );
                    })}
                  </div>
                </div>
              )}
              
              {/* Cash Payment Form */}
              {activeMethod === 'cash' && (
                <div className="bg-slate-50 rounded-xl p-4 animate-slide-up">
                  <p className="text-sm font-semibold text-slate-700 mb-3">
                    Pago en Efectivo
                  </p>
                  
                  {/* Quick Amount Buttons */}
                  <div className="mb-3">
                    <label className="text-xs text-slate-500 mb-2 block">Monto a pagar con efectivo</label>
                    <div className="grid grid-cols-4 gap-2 mb-2">
                      <button
                        onClick={() => setCashAmount(remaining.toFixed(2))}
                        className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                          parseFloat(cashAmount) === remaining
                            ? 'bg-primary-500 text-white border-primary-500'
                            : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                        }`}
                      >
                        Todo ({formatCurrency(remaining)})
                      </button>
                      {[5, 10, 20].map((amount) => (
                        <button
                          key={amount}
                          onClick={() => setCashAmount(Math.min(amount, remaining).toFixed(2))}
                          disabled={amount > remaining}
                          className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                            parseFloat(cashAmount) === amount
                              ? 'bg-primary-500 text-white border-primary-500'
                              : amount > remaining
                                ? 'bg-slate-100 text-slate-300 border-slate-200 cursor-not-allowed'
                                : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                          }`}
                        >
                          B/{amount}
                        </button>
                      ))}
                    </div>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">B/</span>
                      <input
                        type="number"
                        value={cashAmount}
                        onChange={(e) => setCashAmount(e.target.value)}
                        className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                        placeholder={remaining.toFixed(2)}
                        max={remaining}
                      />
                    </div>
                  </div>
                  
                  {/* Change Calculator */}
                  {parseFloat(cashAmount) > 0 && (
                    <div className="bg-white rounded-lg p-3 border border-slate-200">
                      <p className="text-xs text-slate-500 mb-2 font-medium">Calculadora de Cambio</p>
                      
                      {/* Denomination Buttons for tendered */}
                      <div className="grid grid-cols-6 gap-1 mb-3">
                        {[1, 2, 5, 10, 20, 50].map((amount) => (
                          <button
                            key={amount}
                            onClick={() => handleCashDenomination(amount)}
                            className="py-2 bg-slate-50 border border-slate-200 rounded text-xs font-medium text-slate-700 hover:border-primary-500 hover:bg-primary-50 transition-colors"
                          >
                            +{amount}
                          </button>
                        ))}
                      </div>
                      
                      <div className="space-y-2">
                        <div className="flex justify-between items-center text-sm">
                          <span className="text-slate-600">Monto a cobrar</span>
                          <span className="font-medium text-slate-800">{formatCurrency(parseFloat(cashAmount) || 0)}</span>
                        </div>
                        <div className="flex justify-between items-center">
                          <span className="text-sm text-slate-600">Efectivo recibido</span>
                          <div className="flex items-center gap-2">
                            <input
                              type="number"
                              value={cashTendered}
                              onChange={(e) => setCashTendered(e.target.value)}
                              className="w-20 text-right px-2 py-1 border border-slate-200 rounded text-sm focus:ring-2 focus:ring-primary-500"
                              placeholder="0.00"
                            />
                            {cashTendered && (
                              <button
                                onClick={() => setCashTendered('')}
                                className="text-xs text-slate-400 hover:text-slate-600"
                              >
                                ✕
                              </button>
                            )}
                          </div>
                        </div>
                        {parseFloat(cashTendered) >= parseFloat(cashAmount) && (
                          <div className="flex justify-between items-center pt-2 border-t border-slate-200">
                            <span className="text-sm font-semibold text-slate-700">Cambio</span>
                            <span className="text-lg font-bold text-success-600">
                              {formatCurrency(cashChange)}
                            </span>
                          </div>
                        )}
                      </div>
                    </div>
                  )}
                  
                  {/* Add Payment Button */}
                  <button
                    onClick={addPayment}
                    disabled={!parseFloat(cashAmount) || parseFloat(cashAmount) > remaining}
                    className={`w-full mt-3 py-2 rounded-lg font-medium flex items-center justify-center gap-2 transition-all ${
                      parseFloat(cashAmount) > 0 && parseFloat(cashAmount) <= remaining
                        ? 'bg-primary-500 text-white hover:bg-primary-600'
                        : 'bg-slate-200 text-slate-400 cursor-not-allowed'
                    }`}
                  >
                    <Plus className="w-4 h-4" />
                    Agregar Pago de {formatCurrency(parseFloat(cashAmount) || 0)}
                  </button>
                </div>
              )}
              
              {/* Card Payment Form */}
              {activeMethod === 'card' && (
                <div className="bg-blue-50 rounded-xl p-4 animate-slide-up border border-blue-200">
                  <p className="text-sm font-semibold text-blue-800 mb-3 flex items-center gap-2">
                    <CreditCard className="w-4 h-4" />
                    Pago con Tarjeta (POS Bancario)
                  </p>
                  
                  {/* Quick Amount Buttons */}
                  <div className="mb-3">
                    <label className="text-xs text-slate-600 mb-2 block">Monto a pagar con tarjeta</label>
                    <div className="grid grid-cols-4 gap-2 mb-2">
                      <button
                        onClick={() => setCardAmount(remaining.toFixed(2))}
                        className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                          parseFloat(cardAmount) === remaining
                            ? 'bg-primary-500 text-white border-primary-500'
                            : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                        }`}
                      >
                        Todo ({formatCurrency(remaining)})
                      </button>
                      {[10, 20, 50].map((amount) => (
                        <button
                          key={amount}
                          onClick={() => setCardAmount(Math.min(amount, remaining).toFixed(2))}
                          disabled={amount > remaining}
                          className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                            parseFloat(cardAmount) === amount
                              ? 'bg-primary-500 text-white border-primary-500'
                              : amount > remaining
                                ? 'bg-slate-100 text-slate-300 border-slate-200 cursor-not-allowed'
                                : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                          }`}
                        >
                          B/{amount}
                        </button>
                      ))}
                    </div>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">B/</span>
                      <input
                        type="number"
                        value={cardAmount}
                        onChange={(e) => setCardAmount(e.target.value)}
                        className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 bg-white"
                        placeholder={remaining.toFixed(2)}
                        max={remaining}
                      />
                    </div>
                  </div>
                  
                  {/* POS Info */}
                  {cardAmount && parseFloat(cardAmount) > 0 && (
                    <div className="space-y-2 mb-3 bg-white rounded-lg p-3">
                      <p className="text-xs text-slate-500 font-medium">Ingresar en POS:</p>
                      <div className="flex justify-between items-center text-sm">
                        <span className="text-slate-600">Subtotal</span>
                        <span className="font-mono font-semibold text-slate-800">
                          {formatCurrency(parseFloat(cardAmount) / 1.07)}
                        </span>
                      </div>
                      <div className="flex justify-between items-center text-sm">
                        <span className="text-slate-600">ITBMS (7%)</span>
                        <span className="font-mono font-semibold text-slate-800">
                          {formatCurrency(parseFloat(cardAmount) - (parseFloat(cardAmount) / 1.07))}
                        </span>
                      </div>
                      <div className="flex justify-between items-center text-sm pt-2 border-t border-slate-200">
                        <span className="font-semibold text-slate-700">Total</span>
                        <span className="font-mono font-bold text-lg text-primary-600">
                          {formatCurrency(parseFloat(cardAmount))}
                        </span>
                      </div>
                    </div>
                  )}
                  
                  {/* Reference Number */}
                  <div className="mb-3">
                    <label className="text-xs text-slate-600 mb-1 block">
                      Número de Confirmación *
                    </label>
                    <div className="relative">
                      <Hash className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                      <input
                        type="text"
                        value={cardReference}
                        onChange={(e) => setCardReference(e.target.value)}
                        className={`w-full pl-10 pr-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 bg-white ${
                          cardReference ? 'border-success-400' : 'border-slate-200'
                        }`}
                        placeholder="Ej: 123456"
                      />
                    </div>
                  </div>
                  
                  {/* Add Payment Button */}
                  <button
                    onClick={addPayment}
                    disabled={!parseFloat(cardAmount) || !cardReference.trim() || parseFloat(cardAmount) > remaining}
                    className={`w-full py-2 rounded-lg font-medium flex items-center justify-center gap-2 transition-all ${
                      parseFloat(cardAmount) > 0 && cardReference.trim() && parseFloat(cardAmount) <= remaining
                        ? 'bg-primary-500 text-white hover:bg-primary-600'
                        : 'bg-slate-200 text-slate-400 cursor-not-allowed'
                    }`}
                  >
                    <Plus className="w-4 h-4" />
                    Agregar Pago de {formatCurrency(parseFloat(cardAmount) || 0)}
                  </button>
                </div>
              )}
              
              {/* Other Payment Methods Form */}
              {activeMethod && !['cash', 'card'].includes(activeMethod) && (
                <div className="bg-slate-50 rounded-xl p-4 animate-slide-up">
                  <p className="text-sm font-semibold text-slate-700 mb-3">
                    Pago con {paymentMethods.find(m => m.id === activeMethod)?.name}
                  </p>
                  
                  {/* Quick Amount Buttons */}
                  <div className="mb-3">
                    <label className="text-xs text-slate-500 mb-2 block">Monto</label>
                    <div className="grid grid-cols-4 gap-2 mb-2">
                      <button
                        onClick={() => setOtherAmount(remaining.toFixed(2))}
                        className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                          parseFloat(otherAmount) === remaining
                            ? 'bg-primary-500 text-white border-primary-500'
                            : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                        }`}
                      >
                        Todo ({formatCurrency(remaining)})
                      </button>
                      {[10, 20, 50].map((amount) => (
                        <button
                          key={amount}
                          onClick={() => setOtherAmount(Math.min(amount, remaining).toFixed(2))}
                          disabled={amount > remaining}
                          className={`py-2 px-2 border rounded-lg text-xs font-medium transition-colors ${
                            parseFloat(otherAmount) === amount
                              ? 'bg-primary-500 text-white border-primary-500'
                              : amount > remaining
                                ? 'bg-slate-100 text-slate-300 border-slate-200 cursor-not-allowed'
                                : 'bg-white border-slate-200 text-slate-700 hover:border-primary-500'
                          }`}
                        >
                          B/{amount}
                        </button>
                      ))}
                    </div>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">B/</span>
                      <input
                        type="number"
                        value={otherAmount}
                        onChange={(e) => setOtherAmount(e.target.value)}
                        className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                        placeholder={remaining.toFixed(2)}
                        max={remaining}
                      />
                    </div>
                  </div>
                  
                  {/* Add Payment Button */}
                  <button
                    onClick={addPayment}
                    disabled={!parseFloat(otherAmount) || parseFloat(otherAmount) > remaining}
                    className={`w-full py-2 rounded-lg font-medium flex items-center justify-center gap-2 transition-all ${
                      parseFloat(otherAmount) > 0 && parseFloat(otherAmount) <= remaining
                        ? 'bg-primary-500 text-white hover:bg-primary-600'
                        : 'bg-slate-200 text-slate-400 cursor-not-allowed'
                    }`}
                  >
                    <Plus className="w-4 h-4" />
                    Agregar Pago de {formatCurrency(parseFloat(otherAmount) || 0)}
                  </button>
                </div>
              )}
            </>
          )}
        </div>
        
        {/* Process Button - Fixed at bottom */}
        <div className="p-4 border-t border-slate-100 flex-shrink-0">
          <button
            onClick={handleProcess}
            disabled={!canProcess || processing}
            className={`w-full py-4 rounded-xl font-semibold text-white transition-all flex items-center justify-center gap-2 ${
              canProcess && !processing
                ? 'bg-success-500 hover:bg-success-600 shadow-lg hover:shadow-xl'
                : 'bg-slate-300 cursor-not-allowed'
            }`}
          >
            {processing ? (
              <>
                <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                Procesando...
              </>
            ) : (
              <>
                <Check className="w-5 h-5" />
                {canProcess ? 'Completar Venta' : `Faltan ${formatCurrency(remaining)}`}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

export default PaymentModal;
