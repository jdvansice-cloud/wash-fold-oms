import React, { createContext, useContext, useReducer, useCallback } from 'react';
import {
  sampleUser,
  sampleStore,
  sampleCompany,
  sampleSections,
  sampleProducts,
  sampleCustomers,
  sampleOrders,
  samplePaymentMethods,
  serviceSettings,
  calculatePromisedDate,
} from '../data/sampleData';

// Initial state
const initialState = {
  // User & Store
  user: sampleUser,
  store: sampleStore,
  company: sampleCompany,
  
  // Data
  sections: sampleSections,
  products: sampleProducts,
  customers: sampleCustomers,
  orders: sampleOrders,
  paymentMethods: samplePaymentMethods,
  
  // Current ticket
  ticket: {
    customer: null,
    isWalkIn: true,
    isExpress: false,
    items: [],
    notes: '',
    deliveryProduct: null,
    manualDiscount: null,
    promotionCode: null,
  },
  
  // UI State
  activeSection: 'sec-001',
  currentView: 'pos', // pos, orders, analytics, en-proceso
  sidebarOpen: false,
  
  // Settings
  settings: serviceSettings,
};

// Action types
const actionTypes = {
  // Ticket actions
  SET_CUSTOMER: 'SET_CUSTOMER',
  SET_WALK_IN: 'SET_WALK_IN',
  SET_EXPRESS: 'SET_EXPRESS',
  ADD_ITEM: 'ADD_ITEM',
  UPDATE_ITEM: 'UPDATE_ITEM',
  REMOVE_ITEM: 'REMOVE_ITEM',
  CLEAR_TICKET: 'CLEAR_TICKET',
  SET_NOTES: 'SET_NOTES',
  SET_DELIVERY: 'SET_DELIVERY',
  SET_MANUAL_DISCOUNT: 'SET_MANUAL_DISCOUNT',
  SET_PROMOTION: 'SET_PROMOTION',
  
  // UI actions
  SET_ACTIVE_SECTION: 'SET_ACTIVE_SECTION',
  SET_CURRENT_VIEW: 'SET_CURRENT_VIEW',
  TOGGLE_SIDEBAR: 'TOGGLE_SIDEBAR',
  
  // Data actions
  ADD_CUSTOMER: 'ADD_CUSTOMER',
  UPDATE_CUSTOMER: 'UPDATE_CUSTOMER',
  ADD_ORDER: 'ADD_ORDER',
  UPDATE_ORDER: 'UPDATE_ORDER',
  UPDATE_ORDER_STATUS: 'UPDATE_ORDER_STATUS',
};

// Reducer
function appReducer(state, action) {
  switch (action.type) {
    // Ticket actions
    case actionTypes.SET_CUSTOMER:
      return {
        ...state,
        ticket: {
          ...state.ticket,
          customer: action.payload,
          isWalkIn: action.payload === null,
        },
      };
      
    case actionTypes.SET_WALK_IN:
      return {
        ...state,
        ticket: {
          ...state.ticket,
          isWalkIn: action.payload,
          customer: action.payload ? null : state.ticket.customer,
        },
      };
      
    case actionTypes.SET_EXPRESS:
      return {
        ...state,
        ticket: {
          ...state.ticket,
          isExpress: action.payload,
        },
      };
      
    case actionTypes.ADD_ITEM: {
      const existingIndex = state.ticket.items.findIndex(
        item => item.product.id === action.payload.product.id && 
                item.product.pricing_type === 'quantity'
      );
      
      if (existingIndex >= 0 && action.payload.product.pricing_type === 'quantity') {
        // Increment quantity for quantity-based products
        const newItems = [...state.ticket.items];
        newItems[existingIndex] = {
          ...newItems[existingIndex],
          quantity: newItems[existingIndex].quantity + 1,
          lineTotal: (newItems[existingIndex].quantity + 1) * newItems[existingIndex].unitPrice,
        };
        return {
          ...state,
          ticket: { ...state.ticket, items: newItems },
        };
      }
      
      // Add new item
      return {
        ...state,
        ticket: {
          ...state.ticket,
          items: [...state.ticket.items, action.payload],
        },
      };
    }
      
    case actionTypes.UPDATE_ITEM: {
      const newItems = state.ticket.items.map((item, index) =>
        index === action.payload.index ? { ...item, ...action.payload.updates } : item
      );
      return {
        ...state,
        ticket: { ...state.ticket, items: newItems },
      };
    }
      
    case actionTypes.REMOVE_ITEM:
      return {
        ...state,
        ticket: {
          ...state.ticket,
          items: state.ticket.items.filter((_, index) => index !== action.payload),
        },
      };
      
    case actionTypes.CLEAR_TICKET:
      return {
        ...state,
        ticket: {
          customer: null,
          isWalkIn: true,
          isExpress: false,
          items: [],
          notes: '',
          deliveryProduct: null,
          manualDiscount: null,
          promotionCode: null,
        },
      };
      
    case actionTypes.SET_NOTES:
      return {
        ...state,
        ticket: { ...state.ticket, notes: action.payload },
      };
      
    case actionTypes.SET_DELIVERY:
      return {
        ...state,
        ticket: { ...state.ticket, deliveryProduct: action.payload },
      };
      
    case actionTypes.SET_MANUAL_DISCOUNT:
      return {
        ...state,
        ticket: { ...state.ticket, manualDiscount: action.payload },
      };
      
    case actionTypes.SET_PROMOTION:
      return {
        ...state,
        ticket: { ...state.ticket, promotionCode: action.payload },
      };
      
    // UI actions
    case actionTypes.SET_ACTIVE_SECTION:
      return { ...state, activeSection: action.payload };
      
    case actionTypes.SET_CURRENT_VIEW:
      return { ...state, currentView: action.payload };
      
    case actionTypes.TOGGLE_SIDEBAR:
      return { ...state, sidebarOpen: action.payload ?? !state.sidebarOpen };
      
    // Data actions
    case actionTypes.ADD_CUSTOMER:
      return {
        ...state,
        customers: [...state.customers, action.payload],
      };
      
    case actionTypes.UPDATE_CUSTOMER: {
      const newCustomers = state.customers.map(c =>
        c.id === action.payload.id ? { ...c, ...action.payload } : c
      );
      return { ...state, customers: newCustomers };
    }
      
    case actionTypes.ADD_ORDER:
      return {
        ...state,
        orders: [action.payload, ...state.orders],
      };
      
    case actionTypes.UPDATE_ORDER: {
      const newOrders = state.orders.map(o =>
        o.id === action.payload.id ? { ...o, ...action.payload } : o
      );
      return { ...state, orders: newOrders };
    }
      
    case actionTypes.UPDATE_ORDER_STATUS: {
      const newOrders = state.orders.map(o =>
        o.id === action.payload.orderId
          ? { ...o, status: action.payload.status }
          : o
      );
      return { ...state, orders: newOrders };
    }
      
    default:
      return state;
  }
}

// Create context
const AppContext = createContext(null);

// Provider component
export function AppProvider({ children }) {
  const [state, dispatch] = useReducer(appReducer, initialState);
  
  // Ticket calculations
  const ticketCalculations = useCallback(() => {
    const { items, isExpress, manualDiscount, deliveryProduct } = state.ticket;
    const { itbms_rate } = state.settings;
    
    let subtotal = items.reduce((sum, item) => sum + item.lineTotal, 0);
    
    // Apply manual discount
    let discountAmount = 0;
    if (manualDiscount) {
      if (manualDiscount.type === 'percentage') {
        discountAmount = subtotal * (manualDiscount.value / 100);
      } else {
        discountAmount = manualDiscount.value;
      }
    }
    
    const afterDiscount = subtotal - discountAmount;
    
    // Delivery charge
    const deliveryCharge = deliveryProduct ? deliveryProduct.price : 0;
    
    // Tax calculation (on subtotal after discount + delivery)
    const taxableAmount = afterDiscount + deliveryCharge;
    const taxAmount = taxableAmount * (itbms_rate / 100);
    
    // Total
    const total = afterDiscount + deliveryCharge + taxAmount;
    
    // Weight and bags
    const totalWeight = items.reduce((sum, item) => sum + (item.totalWeight || 0), 0);
    const totalBags = items.reduce((sum, item) => sum + (item.bags || 0), 0);
    const totalPieces = items.reduce((sum, item) => sum + (item.pieces || item.quantity || 0), 0);
    
    // Promised date
    const promisedDate = calculatePromisedDate(isExpress);
    
    return {
      subtotal,
      discountAmount,
      deliveryCharge,
      taxAmount,
      total,
      totalWeight,
      totalBags,
      totalPieces,
      promisedDate,
    };
  }, [state.ticket, state.settings]);
  
  // Actions
  const actions = {
    // Ticket
    setCustomer: (customer) => dispatch({ type: actionTypes.SET_CUSTOMER, payload: customer }),
    setWalkIn: (isWalkIn) => dispatch({ type: actionTypes.SET_WALK_IN, payload: isWalkIn }),
    setExpress: (isExpress) => dispatch({ type: actionTypes.SET_EXPRESS, payload: isExpress }),
    addItem: (item) => dispatch({ type: actionTypes.ADD_ITEM, payload: item }),
    updateItem: (index, updates) => dispatch({ type: actionTypes.UPDATE_ITEM, payload: { index, updates } }),
    removeItem: (index) => dispatch({ type: actionTypes.REMOVE_ITEM, payload: index }),
    clearTicket: () => dispatch({ type: actionTypes.CLEAR_TICKET }),
    setNotes: (notes) => dispatch({ type: actionTypes.SET_NOTES, payload: notes }),
    setDelivery: (product) => dispatch({ type: actionTypes.SET_DELIVERY, payload: product }),
    setManualDiscount: (discount) => dispatch({ type: actionTypes.SET_MANUAL_DISCOUNT, payload: discount }),
    setPromotion: (code) => dispatch({ type: actionTypes.SET_PROMOTION, payload: code }),
    
    // UI
    setActiveSection: (sectionId) => dispatch({ type: actionTypes.SET_ACTIVE_SECTION, payload: sectionId }),
    setCurrentView: (view) => dispatch({ type: actionTypes.SET_CURRENT_VIEW, payload: view }),
    toggleSidebar: (open) => dispatch({ type: actionTypes.TOGGLE_SIDEBAR, payload: open }),
    
    // Data
    addCustomer: (customer) => dispatch({ type: actionTypes.ADD_CUSTOMER, payload: customer }),
    updateCustomer: (customer) => dispatch({ type: actionTypes.UPDATE_CUSTOMER, payload: customer }),
    addOrder: (order) => dispatch({ type: actionTypes.ADD_ORDER, payload: order }),
    updateOrder: (order) => dispatch({ type: actionTypes.UPDATE_ORDER, payload: order }),
    updateOrderStatus: (orderId, status) => dispatch({ type: actionTypes.UPDATE_ORDER_STATUS, payload: { orderId, status } }),
    
    // Process order
    processOrder: (paymentInfo) => {
      const calculations = ticketCalculations();
      const orderNumber = Math.max(...state.orders.map(o => o.order_number), 3480) + 1;
      
      const newOrder = {
        id: `ord-${Date.now()}`,
        store_id: state.store.id,
        customer_id: state.ticket.customer?.id || null,
        order_number: orderNumber,
        customer_name: state.ticket.customer
          ? `${state.ticket.customer.first_name} ${state.ticket.customer.last_name}`
          : 'Walk-in',
        is_walk_in: state.ticket.isWalkIn,
        status: 'pending',
        is_express: state.ticket.isExpress,
        subtotal: calculations.subtotal,
        discount_amount: calculations.discountAmount,
        delivery_charge: calculations.deliveryCharge,
        tax_amount: calculations.taxAmount,
        total: calculations.total,
        total_weight: calculations.totalWeight,
        total_bags: calculations.totalBags,
        notes: state.ticket.notes,
        promised_date: calculations.promisedDate.toISOString(),
        created_at: new Date().toISOString(),
        items: state.ticket.items,
        payments: [paymentInfo],
      };
      
      dispatch({ type: actionTypes.ADD_ORDER, payload: newOrder });
      dispatch({ type: actionTypes.CLEAR_TICKET });
      
      return newOrder;
    },
  };
  
  return (
    <AppContext.Provider value={{ state, actions, ticketCalculations }}>
      {children}
    </AppContext.Provider>
  );
}

// Hook for using context
export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
}
