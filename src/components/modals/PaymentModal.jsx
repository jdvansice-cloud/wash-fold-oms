import React, { useState } from 'react';
import { 
  X, Banknote, CreditCard, Smartphone, Building2, 
  FileText, Clock, Gift, Check 
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

function PaymentModal({ total, onClose, onComplete }) {
  const [selectedMethod, setSelectedMethod] = useState(null);
  const [cashAmount, setCashAmount] = useState('');
  const [processing, setProcessing] = useState(false);
  
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  const handleMethodSelect = (methodId) => {
    setSelectedMethod(methodId);
    if (methodId !== 'cash') {
      setCashAmount('');
    }
  };
  
  const handleCashDenomination = (amount) => {
    const currentAmount = parseFloat(cashAmount) || 0;
    setCashAmount((currentAmount + amount).toFixed(2));
  };
  
  const changeAmount = selectedMethod === 'cash' && cashAmount
    ? Math.max(0, parseFloat(cashAmount) - total)
    : 0;
  
  const canProcess = selectedMethod && (
    selectedMethod !== 'cash' || parseFloat(cashAmount) >= total
  );
  
  const handleProcess = () => {
    if (!canProcess) return;
    
    setProcessing(true);
    
    // Simulate processing delay
    setTimeout(() => {
      onComplete({
        method: selectedMethod,
        amount: total,
        cashTendered: selectedMethod === 'cash' ? parseFloat(cashAmount) : null,
        changeGiven: selectedMethod === 'cash' ? changeAmount : null,
        timestamp: new Date().toISOString(),
      });
    }, 500);
  };
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">Pago</h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        <div className="p-4">
          {/* Total Display */}
          <div className="text-center mb-6">
            <p className="text-sm text-slate-500 mb-1">Total a Pagar</p>
            <p className="text-4xl font-bold text-slate-800">{formatCurrency(total)}</p>
          </div>
          
          {/* Payment Methods */}
          <div className="grid grid-cols-2 gap-3 mb-6">
            {paymentMethods.filter(m => m.primary).map((method) => {
              const Icon = method.icon;
              const isSelected = selectedMethod === method.id;
              
              return (
                <button
                  key={method.id}
                  onClick={() => handleMethodSelect(method.id)}
                  className={`p-4 rounded-xl border-2 transition-all ${
                    isSelected
                      ? 'border-primary-500 bg-primary-50'
                      : 'border-slate-200 hover:border-slate-300'
                  }`}
                >
                  <Icon className={`w-8 h-8 mx-auto mb-2 ${
                    isSelected ? 'text-primary-500' : 'text-slate-400'
                  }`} />
                  <p className={`text-sm font-medium ${
                    isSelected ? 'text-primary-600' : 'text-slate-600'
                  }`}>
                    {method.name}
                  </p>
                </button>
              );
            })}
          </div>
          
          {/* Other Methods */}
          <div className="grid grid-cols-3 gap-2 mb-6">
            {paymentMethods.filter(m => !m.primary).map((method) => {
              const Icon = method.icon;
              const isSelected = selectedMethod === method.id;
              
              return (
                <button
                  key={method.id}
                  onClick={() => handleMethodSelect(method.id)}
                  className={`p-3 rounded-xl border text-center transition-all ${
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
          
          {/* Cash Change Calculator */}
          {selectedMethod === 'cash' && (
            <div className="bg-slate-50 rounded-xl p-4 mb-6 animate-slide-up">
              <p className="text-sm font-semibold text-slate-700 mb-3">
                Calculadora de Cambio
              </p>
              
              {/* Denomination Buttons */}
              <div className="grid grid-cols-3 gap-2 mb-4">
                {[1, 2, 5, 10, 20, 50].map((amount) => (
                  <button
                    key={amount}
                    onClick={() => handleCashDenomination(amount)}
                    className="py-3 px-4 bg-white border border-slate-200 rounded-xl hover:border-primary-500 hover:bg-primary-50 transition-colors font-medium text-slate-700"
                  >
                    B/{amount}
                  </button>
                ))}
              </div>
              
              {/* Amounts */}
              <div className="space-y-2">
                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-600">Monto a pagar</span>
                  <span className="font-medium text-slate-800">{formatCurrency(total)}</span>
                </div>
                
                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-600">Efectivo del cliente</span>
                  <input
                    type="number"
                    value={cashAmount}
                    onChange={(e) => setCashAmount(e.target.value)}
                    className="w-24 text-right px-3 py-1.5 border border-slate-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    placeholder="0.00"
                  />
                </div>
                
                <div className="flex justify-between items-center pt-2 border-t border-slate-200">
                  <span className="text-sm font-semibold text-slate-700">Cambio</span>
                  <span className={`text-2xl font-bold ${
                    changeAmount >= 0 ? 'text-success-600' : 'text-error-600'
                  }`}>
                    {formatCurrency(changeAmount)}
                  </span>
                </div>
              </div>
              
              {/* Clear Button */}
              {cashAmount && (
                <button
                  onClick={() => setCashAmount('')}
                  className="mt-3 text-xs text-slate-500 hover:text-slate-700"
                >
                  Limpiar
                </button>
              )}
            </div>
          )}
          
          {/* Process Button */}
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
                Procesar
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

export default PaymentModal;
