import React, { useState, useEffect } from 'react';
import { 
  Plus, X, User, Zap, ChevronDown, ChevronUp, 
  Trash2, Tag, Truck, MessageSquare, AlertCircle,
  CheckCircle, Printer, Share2, Loader2, Check, AlertTriangle
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import CustomerSearchModal from './modals/CustomerSearchModal';
import PaymentModal from './modals/PaymentModal';
import { processOrderReceipts, browserPrintReceipt, generateReceiptContent } from '../services/receiptService';

function TicketPanel() {
  const { state, actions, ticketCalculations } = useApp();
  const [customerModalOpen, setCustomerModalOpen] = useState(false);
  const [customerModalMode, setCustomerModalMode] = useState('select'); // 'select' or 'required'
  const [paymentModalOpen, setPaymentModalOpen] = useState(false);
  const [discountExpanded, setDiscountExpanded] = useState(false);
  const [notesExpanded, setNotesExpanded] = useState(false);
  const [orderConfirmation, setOrderConfirmation] = useState(null); // {orderNumber, customer, total}
  
  const calculations = ticketCalculations();
  const { ticket } = state;
  
  const formatCurrency = (amount) => {
    return `B/${amount.toFixed(2)}`;
  };
  
  const formatDate = (date) => {
    return new Intl.DateTimeFormat('es-PA', {
      weekday: 'short',
      day: 'numeric',
      month: 'short',
    }).format(date);
  };
  
  const handleRemoveItem = (index) => {
    actions.removeItem(index);
  };
  
  const handleQuantityChange = (index, delta) => {
    const item = ticket.items[index];
    const newQuantity = Math.max(1, item.quantity + delta);
    actions.updateItem(index, {
      quantity: newQuantity,
      lineTotal: newQuantity * item.unitPrice,
    });
  };
  
  // Process button handler - check for customer first
  const handleProcessClick = () => {
    if (!ticket.customerConfirmed) {
      // No customer selected - open modal in required mode
      setCustomerModalMode('required');
      setCustomerModalOpen(true);
    } else {
      // Customer selected - proceed to payment
      setPaymentModalOpen(true);
    }
  };
  
  // Handle customer selection when in required mode
  const handleCustomerSelect = (customer) => {
    actions.setCustomer(customer);
    setCustomerModalOpen(false);
    if (customerModalMode === 'required') {
      // After selecting customer in required mode, open payment
      setTimeout(() => setPaymentModalOpen(true), 100);
    }
  };
  
  // Handle walk-in selection when in required mode
  const handleWalkIn = () => {
    actions.confirmWalkIn();
    setCustomerModalOpen(false);
    if (customerModalMode === 'required') {
      // After selecting walk-in in required mode, open payment
      setTimeout(() => setPaymentModalOpen(true), 100);
    }
  };
  
  // Handle payment completion
  const handlePaymentComplete = (paymentInfo) => {
    // Generate order number
    const orderNumber = `#${Math.floor(Math.random() * 9000) + 1000}`;
    const createdAt = new Date().toISOString();
    
    // Store full order data for receipt printing
    const orderData = {
      orderNumber,
      customer: ticket.customer,
      customerName: ticket.customer 
        ? `${ticket.customer.first_name} ${ticket.customer.last_name}`
        : 'Walk-in',
      items: ticket.items,
      subtotal: calculations.subtotal,
      taxAmount: calculations.taxAmount,
      discountAmount: calculations.discountAmount || 0,
      discountType: ticket.manualDiscount?.type || null,
      discountReason: ticket.manualDiscount?.reason || null,
      deliveryCharge: calculations.deliveryCharge || 0,
      total: calculations.total,
      paymentMethod: paymentInfo.method,
      cashTendered: paymentInfo.cashTendered,
      changeGiven: paymentInfo.changeGiven,
      isExpress: ticket.isExpress,
      promisedDate: calculations.promisedDate,
      notes: ticket.notes,
      createdAt,
      companyInfo: state.settings?.company || {
        name: 'AMERICAN LAUNDRY',
        address: 'Panamá, Panamá',
        phone: '',
        ruc: '',
        dv: ''
      }
    };
    
    // Process the order
    actions.processOrder(paymentInfo);
    setPaymentModalOpen(false);
    
    // Show confirmation popup with full order data
    setOrderConfirmation(orderData);
  };
  
  const canProcess = ticket.items.length > 0;
  const needsCustomer = ticket.items.length > 0 && !ticket.customerConfirmed;
  
  return (
    <div className="ticket-sidebar h-full flex flex-col bg-white">
      {/* Customer Selection */}
      <div className="p-4 border-b border-slate-100">
        <div className="flex items-center gap-2">
          <button
            onClick={() => {
              setCustomerModalMode('select');
              setCustomerModalOpen(true);
            }}
            className={`flex-1 flex items-center gap-3 px-4 py-3 rounded-xl transition-colors text-left ${
              needsCustomer
                ? 'bg-amber-50 border-2 border-amber-300 hover:bg-amber-100'
                : ticket.customerConfirmed 
                  ? 'bg-slate-50 hover:bg-slate-100' 
                  : 'bg-slate-50 hover:bg-slate-100'
            }`}
          >
            <User className={`w-5 h-5 ${needsCustomer ? 'text-amber-500' : ticket.customerConfirmed ? 'text-primary-500' : 'text-slate-400'}`} />
            <div className="flex-1 min-w-0">
              {ticket.customer ? (
                <>
                  <p className="font-medium text-slate-800 truncate">
                    {ticket.customer.first_name} {ticket.customer.last_name}
                  </p>
                  <p className="text-xs text-slate-500">
                    {ticket.customer.phone_country_code} {ticket.customer.phone}
                  </p>
                </>
              ) : ticket.customerConfirmed ? (
                <>
                  <p className="font-medium text-slate-700">Walk-in</p>
                  <p className="text-xs text-slate-500">Cliente sin registrar</p>
                </>
              ) : (
                <>
                  <p className={`font-medium ${needsCustomer ? 'text-amber-700' : 'text-slate-600'}`}>
                    {needsCustomer ? 'Seleccionar Cliente' : 'Cliente'}
                  </p>
                  <p className={`text-xs ${needsCustomer ? 'text-amber-600' : 'text-slate-400'}`}>
                    {needsCustomer ? 'Requerido para procesar' : 'Opcional - seleccionar al procesar'}
                  </p>
                </>
              )}
            </div>
            {ticket.customer && (
              <span className="text-xs text-slate-400">ID</span>
            )}
          </button>
          
          <button
            onClick={() => {
              setCustomerModalMode('select');
              setCustomerModalOpen(true);
            }}
            className={`p-3 rounded-xl transition-colors ${
              needsCustomer 
                ? 'bg-amber-500 hover:bg-amber-600 text-white'
                : 'bg-primary-500 hover:bg-primary-600 text-white'
            }`}
          >
            <Plus className="w-5 h-5" />
          </button>
        </div>
        
        {/* Price List & Express Toggle */}
        <div className="flex items-center gap-3 mt-3">
          <select className="flex-1 px-3 py-2 bg-slate-50 border-0 rounded-lg text-sm text-slate-600 focus:ring-2 focus:ring-primary-500">
            <option>Precios Por Defecto</option>
            <option>Corporativo</option>
          </select>
          
          <label className="flex items-center gap-2 px-3 py-2 bg-slate-50 rounded-lg cursor-pointer">
            <input
              type="checkbox"
              checked={ticket.isExpress}
              onChange={(e) => actions.setExpress(e.target.checked)}
              className="sr-only"
            />
            <div className={`relative w-10 h-5 rounded-full transition-colors ${
              ticket.isExpress ? 'bg-warning-500' : 'bg-slate-300'
            }`}>
              <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                ticket.isExpress ? 'translate-x-5' : ''
              }`} />
            </div>
            <Zap className={`w-4 h-4 ${ticket.isExpress ? 'text-warning-500' : 'text-slate-400'}`} />
            <span className={`text-sm font-medium ${ticket.isExpress ? 'text-warning-600' : 'text-slate-500'}`}>
              Express
            </span>
          </label>
        </div>
        
        {/* Pending Orders Alert */}
        {ticket.customer && ticket.customerConfirmed && (
          <div className="mt-3 flex items-center gap-2 px-3 py-2 bg-amber-50 text-amber-700 rounded-lg text-sm">
            <AlertCircle className="w-4 h-4 flex-shrink-0" />
            <span>2 órdenes pendientes</span>
          </div>
        )}
      </div>
      
      {/* Ticket Items */}
      <div className="flex-1 overflow-y-auto scrollbar-thin p-4">
        {ticket.items.length === 0 ? (
          <div className="h-full flex flex-col items-center justify-center text-slate-400">
            <div className="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center mb-4">
              <Tag className="w-8 h-8 text-slate-300" />
            </div>
            <p className="text-sm font-medium">Ticket vacío</p>
            <p className="text-xs mt-1">Selecciona productos para comenzar</p>
          </div>
        ) : (
          <div className="space-y-3">
            {ticket.items.map((item, index) => (
              <div key={index} className="bg-slate-50 rounded-xl p-3 animate-slide-up">
                <div className="flex items-start justify-between gap-2">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      {item.product.pricing_type === 'weight' && (
                        <span className="text-sm font-semibold text-primary-600">
                          {item.totalWeight?.toFixed(2)}kg
                        </span>
                      )}
                      <span className="font-medium text-slate-800 truncate">
                        {item.product.name}
                      </span>
                    </div>
                    
                    {/* Weight entries breakdown */}
                    {item.weightEntries && item.weightEntries.length > 0 && (
                      <div className="mt-1 space-y-0.5">
                        {item.weightEntries.map((entry, i) => (
                          <p key={i} className="text-xs text-slate-500 pl-2 border-l-2 border-slate-200">
                            {entry.weight}kg
                            {entry.pieces && ` • ${entry.pieces} piezas`}
                          </p>
                        ))}
                      </div>
                    )}
                    
                    {/* Quantity controls for quantity-based products */}
                    {item.product.pricing_type === 'quantity' && (
                      <div className="flex items-center gap-2 mt-2">
                        <button
                          onClick={() => handleQuantityChange(index, -1)}
                          className="w-7 h-7 flex items-center justify-center bg-white border border-slate-200 rounded-lg hover:bg-slate-100 transition-colors"
                        >
                          -
                        </button>
                        <span className="w-8 text-center font-medium text-slate-700">
                          {item.quantity}
                        </span>
                        <button
                          onClick={() => handleQuantityChange(index, 1)}
                          className="w-7 h-7 flex items-center justify-center bg-white border border-slate-200 rounded-lg hover:bg-slate-100 transition-colors"
                        >
                          +
                        </button>
                      </div>
                    )}
                  </div>
                  
                  <div className="flex items-center gap-2">
                    <span className="font-semibold text-slate-800">
                      {formatCurrency(item.lineTotal)}
                    </span>
                    <button
                      onClick={() => handleRemoveItem(index)}
                      className="p-1.5 text-slate-400 hover:text-error-500 hover:bg-error-50 rounded-lg transition-colors"
                    >
                      <X className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
      
      {/* Footer */}
      <div className="border-t border-slate-100 p-4 space-y-3">
        {/* Pieces & Bags Counter */}
        <div className="flex gap-3">
          <div className="flex-1 bg-slate-50 rounded-lg px-3 py-2">
            <span className="text-xs text-slate-500">Piezas</span>
            <p className="font-semibold text-slate-800">{calculations.totalPieces}</p>
          </div>
          <div className="flex-1 bg-slate-50 rounded-lg px-3 py-2">
            <span className="text-xs text-slate-500">Bolsas</span>
            <p className="font-semibold text-slate-800">{calculations.totalBags}</p>
          </div>
        </div>
        
        {/* Notes Section */}
        <button
          onClick={() => setNotesExpanded(!notesExpanded)}
          className="w-full flex items-center justify-between px-3 py-2 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors"
        >
          <div className="flex items-center gap-2">
            <MessageSquare className="w-4 h-4 text-slate-400" />
            <span className="text-sm text-slate-600">Notas</span>
          </div>
          {notesExpanded ? (
            <ChevronUp className="w-4 h-4 text-slate-400" />
          ) : (
            <ChevronDown className="w-4 h-4 text-slate-400" />
          )}
        </button>
        
        {notesExpanded && (
          <textarea
            value={ticket.notes}
            onChange={(e) => actions.setNotes(e.target.value)}
            placeholder="Agregar notas al pedido..."
            className="w-full px-3 py-2 bg-slate-50 border-0 rounded-lg text-sm resize-none focus:ring-2 focus:ring-primary-500"
            rows={2}
          />
        )}
        
        {/* Discount Section */}
        <button
          onClick={() => setDiscountExpanded(!discountExpanded)}
          className="w-full flex items-center justify-between px-3 py-2 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors"
        >
          <div className="flex items-center gap-2">
            <Tag className="w-4 h-4 text-slate-400" />
            <span className="text-sm text-slate-600">Descuento</span>
            {ticket.manualDiscount && (
              <span className="badge bg-warning-100 text-warning-700">
                -{ticket.manualDiscount.type === 'percentage' 
                  ? `${ticket.manualDiscount.value}%` 
                  : formatCurrency(ticket.manualDiscount.value)}
              </span>
            )}
          </div>
          {discountExpanded ? (
            <ChevronUp className="w-4 h-4 text-slate-400" />
          ) : (
            <ChevronDown className="w-4 h-4 text-slate-400" />
          )}
        </button>
        
        {discountExpanded && (
          <DiscountInput 
            currentDiscount={ticket.manualDiscount}
            onApply={(discount) => actions.setManualDiscount(discount)}
            onRemove={() => actions.setManualDiscount(null)}
            subtotal={calculations.subtotal}
          />
        )}
        
        {/* Totals */}
        <div className="space-y-1.5 py-2 border-t border-slate-100">
          <div className="flex justify-between text-sm">
            <span className="text-slate-500">Subtotal</span>
            <span className="text-slate-700">{formatCurrency(calculations.subtotal)}</span>
          </div>
          
          {calculations.discountAmount > 0 && (
            <div className="flex justify-between text-sm">
              <span className="text-warning-600">Descuento</span>
              <span className="text-warning-600">-{formatCurrency(calculations.discountAmount)}</span>
            </div>
          )}
          
          {calculations.deliveryCharge > 0 && (
            <div className="flex justify-between text-sm">
              <span className="text-slate-500">Delivery</span>
              <span className="text-slate-700">{formatCurrency(calculations.deliveryCharge)}</span>
            </div>
          )}
          
          <div className="flex justify-between text-sm">
            <span className="text-slate-500">ITBMS (7%)</span>
            <span className="text-slate-700">{formatCurrency(calculations.taxAmount)}</span>
          </div>
          
          <div className="flex justify-between text-lg font-bold pt-2 border-t border-slate-100">
            <span className="text-slate-800">Total</span>
            <span className="text-slate-800">{formatCurrency(calculations.total)}</span>
          </div>
        </div>
        
        {/* Process Button */}
        <button
          onClick={handleProcessClick}
          disabled={!canProcess}
          className={`w-full py-4 rounded-xl font-semibold text-white transition-all ${
            canProcess 
              ? 'bg-success-500 hover:bg-success-600 shadow-lg hover:shadow-xl active:scale-[0.98]' 
              : 'bg-slate-300 cursor-not-allowed'
          }`}
        >
          <div className="flex items-center justify-center gap-3">
            <span>Procesar</span>
            <span className="text-success-200">
              {formatDate(calculations.promisedDate)}
            </span>
            <span className="px-2 py-0.5 bg-white/20 rounded-md">
              {formatCurrency(calculations.total)}
            </span>
          </div>
        </button>
      </div>
      
      {/* Modals */}
      {customerModalOpen && (
        <CustomerSearchModal 
          onClose={() => setCustomerModalOpen(false)}
          onSelect={handleCustomerSelect}
          onWalkIn={handleWalkIn}
          showWalkInPrompt={customerModalMode === 'required'}
        />
      )}
      
      {paymentModalOpen && (
        <PaymentModal
          total={calculations.total}
          onClose={() => setPaymentModalOpen(false)}
          onComplete={handlePaymentComplete}
        />
      )}
      
      {/* Order Confirmation Modal */}
      {orderConfirmation && (
        <OrderConfirmationModal
          orderData={orderConfirmation}
          onClose={() => setOrderConfirmation(null)}
        />
      )}
    </div>
  );
}

// Discount Input Component - allows manual % or $ discount
function DiscountInput({ currentDiscount, onApply, onRemove, subtotal }) {
  const [discountType, setDiscountType] = useState(currentDiscount?.type || 'percentage');
  const [discountValue, setDiscountValue] = useState(currentDiscount?.value?.toString() || '');
  const [discountReason, setDiscountReason] = useState(currentDiscount?.reason || '');
  
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  // Calculate preview of discount
  const previewAmount = (() => {
    const value = parseFloat(discountValue) || 0;
    if (value <= 0) return 0;
    if (discountType === 'percentage') {
      return Math.min((subtotal * value) / 100, subtotal);
    }
    return Math.min(value, subtotal);
  })();
  
  const handleApply = () => {
    const value = parseFloat(discountValue) || 0;
    if (value <= 0) return;
    
    // Validate percentage doesn't exceed 100%
    if (discountType === 'percentage' && value > 100) {
      alert('El porcentaje no puede ser mayor a 100%');
      return;
    }
    
    // Validate amount doesn't exceed subtotal
    if (discountType === 'amount' && value > subtotal) {
      alert('El descuento no puede ser mayor al subtotal');
      return;
    }
    
    onApply({
      type: discountType,
      value: value,
      reason: discountReason || 'Descuento manual',
      amount: previewAmount, // Store calculated amount for reporting
    });
  };
  
  const handleClear = () => {
    setDiscountValue('');
    setDiscountReason('');
    onRemove();
  };
  
  return (
    <div className="p-3 bg-slate-50 rounded-lg space-y-3">
      {/* Type Toggle */}
      <div className="flex bg-white rounded-lg p-1 border border-slate-200">
        <button
          type="button"
          onClick={() => setDiscountType('percentage')}
          className={`flex-1 py-2 px-3 rounded-md text-sm font-medium transition-colors ${
            discountType === 'percentage'
              ? 'bg-primary-500 text-white'
              : 'text-slate-600 hover:bg-slate-50'
          }`}
        >
          Porcentaje (%)
        </button>
        <button
          type="button"
          onClick={() => setDiscountType('amount')}
          className={`flex-1 py-2 px-3 rounded-md text-sm font-medium transition-colors ${
            discountType === 'amount'
              ? 'bg-primary-500 text-white'
              : 'text-slate-600 hover:bg-slate-50'
          }`}
        >
          Monto (B/)
        </button>
      </div>
      
      {/* Value Input */}
      <div className="relative">
        <div className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 font-medium">
          {discountType === 'percentage' ? '%' : 'B/'}
        </div>
        <input
          type="number"
          value={discountValue}
          onChange={(e) => setDiscountValue(e.target.value)}
          placeholder={discountType === 'percentage' ? 'Ej: 10' : 'Ej: 5.00'}
          className="w-full pl-10 pr-4 py-2.5 bg-white border border-slate-200 rounded-lg text-right text-lg font-semibold focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          min="0"
          max={discountType === 'percentage' ? '100' : subtotal}
          step={discountType === 'percentage' ? '1' : '0.01'}
        />
      </div>
      
      {/* Reason Input */}
      <input
        type="text"
        value={discountReason}
        onChange={(e) => setDiscountReason(e.target.value)}
        placeholder="Razón del descuento (opcional)"
        className="w-full px-3 py-2 bg-white border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
      />
      
      {/* Preview */}
      {previewAmount > 0 && (
        <div className="flex items-center justify-between py-2 px-3 bg-warning-50 rounded-lg">
          <span className="text-sm text-warning-700">Descuento a aplicar:</span>
          <span className="font-bold text-warning-700">-{formatCurrency(previewAmount)}</span>
        </div>
      )}
      
      {/* Actions */}
      <div className="flex gap-2">
        {currentDiscount && (
          <button
            type="button"
            onClick={handleClear}
            className="flex-1 py-2 px-3 text-sm font-medium text-error-600 bg-error-50 hover:bg-error-100 rounded-lg transition-colors"
          >
            Quitar
          </button>
        )}
        <button
          type="button"
          onClick={handleApply}
          disabled={!discountValue || parseFloat(discountValue) <= 0}
          className={`flex-1 py-2 px-3 text-sm font-medium rounded-lg transition-colors ${
            discountValue && parseFloat(discountValue) > 0
              ? 'bg-primary-500 text-white hover:bg-primary-600'
              : 'bg-slate-200 text-slate-400 cursor-not-allowed'
          }`}
        >
          Aplicar Descuento
        </button>
      </div>
    </div>
  );
}

// Order Confirmation Modal Component
function OrderConfirmationModal({ orderData, onClose }) {
  const [printStatus, setPrintStatus] = useState('idle'); // idle, printing, success, error
  const [printMessage, setPrintMessage] = useState('');
  const [autoPrintAttempted, setAutoPrintAttempted] = useState(false);
  
  const formatCurrency = (amount) => `B/${amount.toFixed(2)}`;
  
  const paymentMethodNames = {
    cash: 'Efectivo',
    card: 'Tarjeta',
    yappy: 'Yappy',
    ach: 'ACH',
    check: 'Cheque',
    invoice: 'Factura',
    pickup: 'Pagar en Recogida',
    gift_card: 'Tarjeta Regalo',
  };
  
  // Auto-print on mount
  useEffect(() => {
    if (!autoPrintAttempted) {
      setAutoPrintAttempted(true);
      handlePrint();
    }
  }, []);
  
  const handlePrint = async () => {
    setPrintStatus('printing');
    setPrintMessage('Imprimiendo recibos...');
    
    try {
      const result = await processOrderReceipts(orderData);
      
      if (result.printed && result.saved) {
        setPrintStatus('success');
        setPrintMessage('Recibos impresos y guardados');
      } else if (result.printed) {
        setPrintStatus('success');
        setPrintMessage('Recibos impresos (no se pudo guardar en la nube)');
      } else if (result.saved) {
        setPrintStatus('error');
        setPrintMessage('No se pudo imprimir. Recibo guardado en la nube.');
      } else {
        throw new Error(result.error || 'Error desconocido');
      }
    } catch (error) {
      console.error('Print error:', error);
      setPrintStatus('error');
      setPrintMessage(error.message || 'Error al imprimir');
    }
  };
  
  const handleBrowserPrint = () => {
    const receipt = generateReceiptContent(orderData, 'customer');
    browserPrintReceipt(receipt);
  };
  
  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-sm animate-scale-in text-center overflow-hidden">
        {/* Success Header */}
        <div className="bg-gradient-to-br from-success-500 to-success-600 p-6">
          <div className="w-20 h-20 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
            <CheckCircle className="w-12 h-12 text-white" />
          </div>
          <h2 className="text-2xl font-bold text-white">¡Orden Creada!</h2>
        </div>
        
        {/* Order Details */}
        <div className="p-6 space-y-4">
          {/* Order Number */}
          <div className="bg-slate-50 rounded-xl p-4">
            <p className="text-sm text-slate-500 mb-1">Número de Orden</p>
            <p className="text-3xl font-bold text-slate-800">{orderData.orderNumber}</p>
          </div>
          
          {/* Customer */}
          <div className="flex items-center justify-between py-3 border-b border-slate-100">
            <span className="text-slate-500">Cliente</span>
            <span className="font-semibold text-slate-800">{orderData.customerName}</span>
          </div>
          
          {/* Payment Method */}
          <div className="flex items-center justify-between py-3 border-b border-slate-100">
            <span className="text-slate-500">Método de Pago</span>
            <span className="font-medium text-slate-700">
              {paymentMethodNames[orderData.paymentMethod] || orderData.paymentMethod}
            </span>
          </div>
          
          {/* Total */}
          <div className="flex items-center justify-between py-3">
            <span className="text-slate-500">Total Pagado</span>
            <span className="text-2xl font-bold text-success-600">
              {formatCurrency(orderData.total)}
            </span>
          </div>
          
          {/* Print Status */}
          <div className={`rounded-xl p-3 flex items-center gap-3 ${
            printStatus === 'printing' ? 'bg-blue-50 text-blue-700' :
            printStatus === 'success' ? 'bg-success-50 text-success-700' :
            printStatus === 'error' ? 'bg-amber-50 text-amber-700' :
            'bg-slate-50 text-slate-600'
          }`}>
            {printStatus === 'printing' && (
              <Loader2 className="w-5 h-5 animate-spin" />
            )}
            {printStatus === 'success' && (
              <Check className="w-5 h-5" />
            )}
            {printStatus === 'error' && (
              <AlertTriangle className="w-5 h-5" />
            )}
            <span className="text-sm">{printMessage || 'Listo para imprimir'}</span>
          </div>
          
          {/* Actions */}
          <div className="flex gap-3 pt-4">
            <button
              onClick={onClose}
              className="flex-1 py-3 px-4 bg-slate-100 hover:bg-slate-200 text-slate-700 font-medium rounded-xl transition-colors"
            >
              Cerrar
            </button>
            
            {printStatus === 'error' ? (
              <button
                onClick={handleBrowserPrint}
                className="flex-1 py-3 px-4 bg-amber-500 hover:bg-amber-600 text-white font-medium rounded-xl transition-colors flex items-center justify-center gap-2"
              >
                <Printer className="w-4 h-4" />
                Imprimir (Navegador)
              </button>
            ) : (
              <button
                onClick={handlePrint}
                disabled={printStatus === 'printing'}
                className="flex-1 py-3 px-4 bg-primary-500 hover:bg-primary-600 disabled:bg-primary-300 text-white font-medium rounded-xl transition-colors flex items-center justify-center gap-2"
              >
                {printStatus === 'printing' ? (
                  <Loader2 className="w-4 h-4 animate-spin" />
                ) : (
                  <Printer className="w-4 h-4" />
                )}
                {printStatus === 'success' ? 'Reimprimir' : 'Imprimir'}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default TicketPanel;
