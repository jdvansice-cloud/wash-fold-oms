import React, { useState } from 'react';
import { 
  Plus, X, User, Zap, ChevronDown, ChevronUp, 
  Trash2, Tag, Truck, MessageSquare, AlertCircle,
  CheckCircle, Printer, Share2
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import CustomerSearchModal from './modals/CustomerSearchModal';
import PaymentModal from './modals/PaymentModal';

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
    
    // Store confirmation data before clearing ticket
    const confirmationData = {
      orderNumber,
      customer: ticket.customer 
        ? `${ticket.customer.first_name} ${ticket.customer.last_name}`
        : 'Walk-in',
      total: calculations.total,
      paymentMethod: paymentInfo.method,
    };
    
    // Process the order
    actions.processOrder(paymentInfo);
    setPaymentModalOpen(false);
    
    // Show confirmation popup
    setOrderConfirmation(confirmationData);
  };
  
  const canProcess = ticket.items.length > 0;
  
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
              ticket.customerConfirmed 
                ? 'bg-slate-50 hover:bg-slate-100' 
                : 'bg-slate-50 hover:bg-slate-100'
            }`}
          >
            <User className={`w-5 h-5 ${ticket.customerConfirmed ? 'text-primary-500' : 'text-slate-400'}`} />
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
                  <p className="text-slate-600 font-medium">Cliente</p>
                  <p className="text-xs text-slate-400">Opcional - seleccionar al procesar</p>
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
            className="p-3 bg-primary-500 hover:bg-primary-600 text-white rounded-xl transition-colors"
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
          <div className="p-3 bg-slate-50 rounded-lg space-y-2">
            <div className="flex gap-2">
              <button
                onClick={() => actions.setManualDiscount({ type: 'percentage', value: 10 })}
                className="flex-1 px-3 py-2 text-sm bg-white border border-slate-200 rounded-lg hover:border-primary-500 hover:text-primary-600 transition-colors"
              >
                10%
              </button>
              <button
                onClick={() => actions.setManualDiscount({ type: 'percentage', value: 15 })}
                className="flex-1 px-3 py-2 text-sm bg-white border border-slate-200 rounded-lg hover:border-primary-500 hover:text-primary-600 transition-colors"
              >
                15%
              </button>
              <button
                onClick={() => actions.setManualDiscount({ type: 'amount', value: 5 })}
                className="flex-1 px-3 py-2 text-sm bg-white border border-slate-200 rounded-lg hover:border-primary-500 hover:text-primary-600 transition-colors"
              >
                B/5
              </button>
            </div>
            {ticket.manualDiscount && (
              <button
                onClick={() => actions.setManualDiscount(null)}
                className="w-full text-xs text-error-600 hover:underline"
              >
                Quitar descuento
              </button>
            )}
          </div>
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
          orderNumber={orderConfirmation.orderNumber}
          customer={orderConfirmation.customer}
          total={orderConfirmation.total}
          paymentMethod={orderConfirmation.paymentMethod}
          onClose={() => setOrderConfirmation(null)}
        />
      )}
    </div>
  );
}

// Order Confirmation Modal Component
function OrderConfirmationModal({ orderNumber, customer, total, paymentMethod, onClose }) {
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
            <p className="text-3xl font-bold text-slate-800">{orderNumber}</p>
          </div>
          
          {/* Customer */}
          <div className="flex items-center justify-between py-3 border-b border-slate-100">
            <span className="text-slate-500">Cliente</span>
            <span className="font-semibold text-slate-800">{customer}</span>
          </div>
          
          {/* Payment Method */}
          <div className="flex items-center justify-between py-3 border-b border-slate-100">
            <span className="text-slate-500">Método de Pago</span>
            <span className="font-medium text-slate-700">
              {paymentMethodNames[paymentMethod] || paymentMethod}
            </span>
          </div>
          
          {/* Total */}
          <div className="flex items-center justify-between py-3">
            <span className="text-slate-500">Total Pagado</span>
            <span className="text-2xl font-bold text-success-600">
              {formatCurrency(total)}
            </span>
          </div>
          
          {/* Actions */}
          <div className="flex gap-3 pt-4">
            <button
              onClick={onClose}
              className="flex-1 py-3 px-4 bg-slate-100 hover:bg-slate-200 text-slate-700 font-medium rounded-xl transition-colors"
            >
              Cerrar
            </button>
            <button
              onClick={() => {
                // TODO: Implement print functionality
                onClose();
              }}
              className="flex-1 py-3 px-4 bg-primary-500 hover:bg-primary-600 text-white font-medium rounded-xl transition-colors flex items-center justify-center gap-2"
            >
              <Printer className="w-4 h-4" />
              Imprimir
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default TicketPanel;
