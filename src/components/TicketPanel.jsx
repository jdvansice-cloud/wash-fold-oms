import React, { useState } from 'react';
import { 
  Plus, X, User, Zap, ChevronDown, ChevronUp, 
  Trash2, Tag, Truck, MessageSquare, AlertCircle 
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useDataLoader } from '../hooks/useDataLoader';
import CustomerSearchModal from './modals/CustomerSearchModal';
import PaymentModal from './modals/PaymentModal';

function TicketPanel() {
  const { state, actions, ticketCalculations } = useApp();
  const { addOrder: dbAddOrder } = useDataLoader();
  const [customerModalOpen, setCustomerModalOpen] = useState(false);
  const [paymentModalOpen, setPaymentModalOpen] = useState(false);
  const [discountExpanded, setDiscountExpanded] = useState(false);
  const [notesExpanded, setNotesExpanded] = useState(false);
  const [processing, setProcessing] = useState(false);
  
  const calculations = ticketCalculations();
  const { ticket } = state;
  
  // Count pending orders for the selected customer
  const pendingOrdersCount = ticket.customer 
    ? state.orders.filter(o => 
        o.customer_id === ticket.customer.id && 
        !['completed', 'cancelled'].includes(o.status)
      ).length 
    : 0;
  
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
  
  const canProcess = ticket.items.length > 0;
  
  return (
    <div className="ticket-sidebar h-full flex flex-col bg-white">
      {/* Customer Selection */}
      <div className="p-4 border-b border-slate-100">
        <div className="flex items-center gap-2">
          <button
            onClick={() => setCustomerModalOpen(true)}
            className={`flex-1 flex items-center gap-3 px-4 py-3 rounded-xl transition-colors text-left ${
              ticket.customerConfirmed 
                ? 'bg-slate-50 hover:bg-slate-100' 
                : 'bg-amber-50 border-2 border-amber-200 hover:bg-amber-100'
            }`}
          >
            <User className={`w-5 h-5 ${ticket.customerConfirmed ? 'text-slate-400' : 'text-amber-500'}`} />
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
                  <p className="text-amber-700 font-medium">Seleccionar Cliente</p>
                  <p className="text-xs text-amber-600">Haz clic para elegir</p>
                </>
              )}
            </div>
            {ticket.customer && (
              <span className="text-xs text-slate-400">ID</span>
            )}
          </button>
          
          <button
            onClick={() => setCustomerModalOpen(true)}
            className="p-3 bg-primary-500 hover:bg-primary-600 text-white rounded-xl transition-colors"
          >
            <Plus className="w-5 h-5" />
          </button>
        </div>
        
        {/* Express Toggle */}
        <div className="flex items-center mt-3">
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
        
        {/* Pending Orders Alert - Only show if customer has pending orders */}
        {ticket.customer && ticket.customerConfirmed && pendingOrdersCount > 0 && (
          <div className="mt-3 flex items-center gap-2 px-3 py-2 bg-amber-50 text-amber-700 rounded-lg text-sm">
            <AlertCircle className="w-4 h-4 flex-shrink-0" />
            <span>{pendingOrdersCount} {pendingOrdersCount === 1 ? 'orden pendiente' : 'órdenes pendientes'}</span>
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
          <div className="p-3 bg-slate-50 rounded-lg space-y-3">
            <div className="flex gap-3">
              {/* Percentage Input */}
              <div className="flex-1">
                <label className="text-xs text-slate-500 mb-1 block">Porcentaje</label>
                <div className="relative">
                  <input
                    type="number"
                    min="0"
                    max="100"
                    step="1"
                    placeholder="0"
                    value={ticket.manualDiscount?.type === 'percentage' ? ticket.manualDiscount.value : ''}
                    onChange={(e) => {
                      const value = parseFloat(e.target.value);
                      if (value > 0 && value <= 100) {
                        actions.setManualDiscount({ type: 'percentage', value });
                      } else if (!e.target.value) {
                        actions.setManualDiscount(null);
                      }
                    }}
                    className={`w-full px-3 py-2 pr-8 bg-white border rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 ${
                      ticket.manualDiscount?.type === 'percentage' 
                        ? 'border-warning-400 bg-warning-50' 
                        : 'border-slate-200'
                    }`}
                  />
                  <span className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">%</span>
                </div>
              </div>
              
              {/* Amount Input */}
              <div className="flex-1">
                <label className="text-xs text-slate-500 mb-1 block">Monto Fijo</label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">B/</span>
                  <input
                    type="number"
                    min="0"
                    step="0.01"
                    placeholder="0.00"
                    value={ticket.manualDiscount?.type === 'amount' ? ticket.manualDiscount.value : ''}
                    onChange={(e) => {
                      const value = parseFloat(e.target.value);
                      if (value > 0) {
                        actions.setManualDiscount({ type: 'amount', value });
                      } else if (!e.target.value) {
                        actions.setManualDiscount(null);
                      }
                    }}
                    className={`w-full px-3 py-2 pl-9 bg-white border rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 ${
                      ticket.manualDiscount?.type === 'amount' 
                        ? 'border-warning-400 bg-warning-50' 
                        : 'border-slate-200'
                    }`}
                  />
                </div>
              </div>
            </div>
            
            {ticket.manualDiscount && (
              <button
                onClick={() => actions.setManualDiscount(null)}
                className="w-full text-xs text-error-600 hover:text-error-700 hover:underline py-1"
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
          onClick={() => setPaymentModalOpen(true)}
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
          onSelect={(customer) => {
            actions.setCustomer(customer);
            setCustomerModalOpen(false);
          }}
          onWalkIn={() => {
            actions.confirmWalkIn();
            setCustomerModalOpen(false);
          }}
        />
      )}
      
      {paymentModalOpen && (
        <PaymentModal
          total={calculations.total}
          onClose={() => setPaymentModalOpen(false)}
          onComplete={async (paymentInfo) => {
            setProcessing(true);
            try {
              // Build order data for database
              const orderData = {
                customer_id: state.ticket.customer?.id || null,
                customer_name: state.ticket.customer
                  ? `${state.ticket.customer.first_name} ${state.ticket.customer.last_name}`
                  : 'Walk-in',
                is_walk_in: !state.ticket.customer,
                is_express: state.ticket.isExpress,
                subtotal: calculations.subtotal,
                discount_amount: calculations.discountAmount,
                delivery_charge: calculations.deliveryCharge,
                tax_amount: calculations.taxAmount,
                total: calculations.total,
                total_weight: calculations.totalWeight,
                total_bags: calculations.totalBags,
                total_pieces: calculations.totalPieces,
                notes: state.ticket.notes,
                promised_date: calculations.promisedDate.toISOString(),
                items: state.ticket.items,
                payment: paymentInfo,
              };
              
              await dbAddOrder(orderData);
              actions.clearTicket();
              setPaymentModalOpen(false);
            } catch (err) {
              console.error('Error processing order:', err);
              alert('Error al procesar la orden: ' + err.message);
            } finally {
              setProcessing(false);
            }
          }}
        />
      )}
    </div>
  );
}

export default TicketPanel;
