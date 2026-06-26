import React, { createContext, useContext, useReducer, useCallback } from 'react';
import { defaultServiceSettings, calculatePromisedDate, generateId } from '../data/helpers';

// Initial state - ALL DATA IS EMPTY, will be loaded from Supabase
const initialState = {
  // User & Store (loaded from Supabase auth, defaults for demo)
  user: {
    id: 'demo-user',
    full_name: 'Juan VanSice',
    initials: 'JV',
    email: 'juan@americanlaundry.com',
    role: 'admin',
  },
  store: null,
  company: null,
  
  // Data - ALL EMPTY, loaded from Supabase
  sections: [],
  products: [],
  customers: [],
  orders: [],
  paymentMethods: [],
  
  // Current ticket
  ticket: {
    customer: null,
    isWalkIn: false,
    customerConfirmed: false,
    isExpress: false,
    items: [],
    notes: '',
    deliveryProduct: null,
    manualDiscount: null,
    promotionCode: null,
    promotion: null,
    freeDelivery: false,
  },

  // Last customer served (for the quick re-select button). Not part of the
  // ticket, so it survives clearTicket.
  lastCustomer: null,

  // UI State
  activeSection: null,
  currentView: 'pos',
  sidebarOpen: false,
  
  // Settings (defaults, overridden by company settings from Supabase)
  settings: defaultServiceSettings,
  
  // Loading states
  loading: {
    initial: true,
    products: false,
    customers: false,
    orders: false,
    sections: false,
  },
  
  // Error state
  error: null,
};

// Action types
const actionTypes = {
  // Ticket actions
  SET_CUSTOMER: 'SET_CUSTOMER',
  SET_WALK_IN: 'SET_WALK_IN',
  CONFIRM_WALK_IN: 'CONFIRM_WALK_IN',
  SET_EXPRESS: 'SET_EXPRESS',
  ADD_ITEM: 'ADD_ITEM',
  UPDATE_ITEM: 'UPDATE_ITEM',
  REMOVE_ITEM: 'REMOVE_ITEM',
  CLEAR_TICKET: 'CLEAR_TICKET',
  RESTORE_TICKET: 'RESTORE_TICKET',
  SET_LAST_CUSTOMER: 'SET_LAST_CUSTOMER',
  SET_NOTES: 'SET_NOTES',
  SET_DELIVERY: 'SET_DELIVERY',
  SET_MANUAL_DISCOUNT: 'SET_MANUAL_DISCOUNT',
  SET_PROMOTION: 'SET_PROMOTION',
  SET_FREE_DELIVERY: 'SET_FREE_DELIVERY',
  
  // UI actions
  SET_ACTIVE_SECTION: 'SET_ACTIVE_SECTION',
  SET_CURRENT_VIEW: 'SET_CURRENT_VIEW',
  TOGGLE_SIDEBAR: 'TOGGLE_SIDEBAR',
  
  // Data loading actions (for Supabase)
  SET_LOADING: 'SET_LOADING',
  SET_ERROR: 'SET_ERROR',
  SET_USER: 'SET_USER',
  SET_STORE: 'SET_STORE',
  SET_COMPANY: 'SET_COMPANY',
  SET_SETTINGS: 'SET_SETTINGS',
  SET_SECTIONS: 'SET_SECTIONS',
  SET_PRODUCTS: 'SET_PRODUCTS',
  SET_CUSTOMERS: 'SET_CUSTOMERS',
  SET_ORDERS: 'SET_ORDERS',
  SET_PAYMENT_METHODS: 'SET_PAYMENT_METHODS',
  
  // CRUD actions
  ADD_CUSTOMER: 'ADD_CUSTOMER',
  UPDATE_CUSTOMER: 'UPDATE_CUSTOMER',
  DELETE_CUSTOMER: 'DELETE_CUSTOMER',
  ADD_ORDER: 'ADD_ORDER',
  UPDATE_ORDER: 'UPDATE_ORDER',
  UPDATE_ORDER_STATUS: 'UPDATE_ORDER_STATUS',
  ADD_PRODUCT: 'ADD_PRODUCT',
  UPDATE_PRODUCT: 'UPDATE_PRODUCT',
  UPDATE_PRODUCTS_ORDER: 'UPDATE_PRODUCTS_ORDER',
  DELETE_PRODUCT: 'DELETE_PRODUCT',
  ADD_SECTION: 'ADD_SECTION',
  UPDATE_SECTION: 'UPDATE_SECTION',
  DELETE_SECTION: 'DELETE_SECTION',
};

// Reducer
function appReducer(state, action) {
  switch (action.type) {
    // Ticket actions
    case actionTypes.SET_CUSTOMER:
      return {
        ...state,
        // Remember the last real (non-walk-in) customer for quick re-select.
        lastCustomer: action.payload?.id ? action.payload : state.lastCustomer,
        ticket: {
          ...state.ticket,
          customer: action.payload,
          isWalkIn: action.payload === null,
          customerConfirmed: true, // Customer is now confirmed
        },
      };
      
    case actionTypes.CONFIRM_WALK_IN:
      return {
        ...state,
        ticket: {
          ...state.ticket,
          customer: null,
          isWalkIn: true,
          customerConfirmed: true, // Walk-in is now confirmed
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
      
    case actionTypes.SET_EXPRESS: {
      const isExpress = action.payload;
      // Recalculate all item prices based on express status
      const updatedItems = state.ticket.items.map(item => {
        const newUnitPrice = isExpress 
          ? (item.product.express_price || item.product.price) 
          : item.product.price;
        
        // For weight-based products
        if (item.product.pricing_type === 'weight') {
          return {
            ...item,
            unitPrice: newUnitPrice,
            lineTotal: (item.totalWeight || 0) * newUnitPrice,
          };
        }
        
        // For quantity-based products
        return {
          ...item,
          unitPrice: newUnitPrice,
          lineTotal: item.quantity * newUnitPrice,
        };
      });

      return {
        ...state,
        ticket: {
          ...state.ticket,
          isExpress: isExpress,
          items: updatedItems,
        },
      };
    }
      
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
          isWalkIn: false,
          customerConfirmed: false,
          isExpress: false,
          items: [],
          notes: '',
          deliveryProduct: null,
          manualDiscount: null,
          promotionCode: null,
        },
      };

    case actionTypes.RESTORE_TICKET:
      return { ...state, ticket: { ...action.payload } };

    case actionTypes.SET_LAST_CUSTOMER:
      return { ...state, lastCustomer: action.payload };

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
        ticket: { 
          ...state.ticket, 
          promotionCode: action.payload?.code || action.payload,
          promotion: action.payload,
        },
      };

    case actionTypes.SET_FREE_DELIVERY:
      return {
        ...state,
        ticket: { ...state.ticket, freeDelivery: action.payload },
      };
      
    // UI actions
    case actionTypes.SET_ACTIVE_SECTION:
      return { ...state, activeSection: action.payload };
      
    case actionTypes.SET_CURRENT_VIEW:
      return { ...state, currentView: action.payload };
      
    case actionTypes.TOGGLE_SIDEBAR:
      return { ...state, sidebarOpen: action.payload ?? !state.sidebarOpen };
    
    // Data loading actions (from Supabase)
    case actionTypes.SET_LOADING:
      return { 
        ...state, 
        loading: { ...state.loading, ...action.payload } 
      };
      
    case actionTypes.SET_ERROR:
      return { ...state, error: action.payload };
      
    case actionTypes.SET_USER:
      return { ...state, user: action.payload };
      
    case actionTypes.SET_STORE:
      return { ...state, store: action.payload };
      
    case actionTypes.SET_COMPANY:
      return { ...state, company: action.payload };
      
    case actionTypes.SET_SETTINGS:
      return { ...state, settings: { ...state.settings, ...action.payload } };
      
    case actionTypes.SET_SECTIONS: {
      const sections = action.payload;
      return { 
        ...state, 
        sections,
        // Set active section to first one if not already set
        activeSection: state.activeSection || (sections[0]?.id || null),
      };
    }
      
    case actionTypes.SET_PRODUCTS:
      return { ...state, products: action.payload };
      
    case actionTypes.SET_CUSTOMERS:
      return { ...state, customers: action.payload };
      
    case actionTypes.SET_ORDERS:
      return { ...state, orders: action.payload };
      
    case actionTypes.SET_PAYMENT_METHODS:
      return { ...state, paymentMethods: action.payload };
      
    // CRUD actions - Customers
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
    
    case actionTypes.DELETE_CUSTOMER:
      return {
        ...state,
        customers: state.customers.filter(c => c.id !== action.payload),
      };
      
    // Order actions
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
    
    // Product actions
    case actionTypes.ADD_PRODUCT:
      return {
        ...state,
        products: [...state.products, action.payload],
      };
      
    case actionTypes.UPDATE_PRODUCT: {
      const newProducts = state.products.map(p =>
        p.id === action.payload.id ? { ...p, ...action.payload } : p
      );
      return { ...state, products: newProducts };
    }
    
    case actionTypes.UPDATE_PRODUCTS_ORDER: {
      // action.payload is an array of { id, display_order }
      const updates = action.payload;
      const newProducts = state.products.map(p => {
        const update = updates.find(u => u.id === p.id);
        return update ? { ...p, display_order: update.display_order } : p;
      });
      return { ...state, products: newProducts };
    }
    
    case actionTypes.DELETE_PRODUCT:
      return {
        ...state,
        products: state.products.filter(p => p.id !== action.payload),
      };
      
    // Section actions
    case actionTypes.ADD_SECTION:
      return {
        ...state,
        sections: [...state.sections, action.payload],
      };
      
    case actionTypes.UPDATE_SECTION: {
      const newSections = state.sections.map(s =>
        s.id === action.payload.id ? { ...s, ...action.payload } : s
      );
      return { ...state, sections: newSections };
    }
    
    case actionTypes.DELETE_SECTION:
      return {
        ...state,
        sections: state.sections.filter(s => s.id !== action.payload),
      };
      
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
    const { items, isExpress, manualDiscount, deliveryProduct, promotion, freeDelivery, customer } = state.ticket;
    const { itbms_rate } = state.settings;
    // An ITBMS-exempt (exonerado) customer zeroes the whole ticket's tax.
    const customerTaxExempt = customer?.tax_exempt === true;
    
    // Separate regular items from delivery items (in case delivery is in items)
    const productItems = items.filter(item => item.product.product_type !== 'delivery');
    const deliveryItems = items.filter(item => item.product.product_type === 'delivery');
    
    // Products subtotal (gross, without ITBMS)
    const productsTotal = productItems.reduce((sum, item) => sum + item.lineTotal, 0);

    // Per-line manual discount (each item may carry { mode: 'amount'|'pct', value }).
    const lineDiscountFor = (item) => {
      const d = item.discount;
      if (!d || !d.value) return 0;
      const gross = item.lineTotal || 0;
      const amt = d.mode === 'pct' ? gross * (d.value / 100) : d.value;
      return Math.min(Math.max(0, amt), gross);
    };
    const lineDiscounts = productItems.map(lineDiscountFor);
    const lineDiscountTotal = lineDiscounts.reduce((s, d) => s + d, 0);
    const netAfterLineTotal = Math.max(0, productsTotal - lineDiscountTotal);

    // Delivery from items or deliveryProduct
    let deliveryTotal = deliveryItems.reduce((sum, item) => sum + item.lineTotal, 0);
    if (deliveryProduct && deliveryItems.length === 0) {
      deliveryTotal = deliveryProduct.price;
    }

    // Order-level discount (manual + promotion), applied on top of line discounts.
    let manualDiscountAmount = 0;
    let productDiscountLabel = '';
    if (manualDiscount) {
      if (manualDiscount.type === 'percentage') {
        manualDiscountAmount = productsTotal * (manualDiscount.value / 100);
        productDiscountLabel = `Descuento ${manualDiscount.value}%`;
      } else {
        manualDiscountAmount = manualDiscount.value;
        productDiscountLabel = 'Descuento';
      }
    }
    let promotionDiscountAmount = 0;
    if (promotion) {
      promotionDiscountAmount = promotion.discount_type === 'percentage'
        ? productsTotal * (promotion.discount_value / 100)
        : promotion.discount_value;
    }
    const combinedOrder = manualDiscountAmount + promotionDiscountAmount;
    const orderDiscount = Math.min(combinedOrder, netAfterLineTotal);
    const manualReported = combinedOrder > 0 ? orderDiscount * (manualDiscountAmount / combinedOrder) : 0;
    const promoReported = combinedOrder > 0 ? orderDiscount * (promotionDiscountAmount / combinedOrder) : 0;

    // Total product discount (per-line + order-level)
    const totalProductDiscount = lineDiscountTotal + orderDiscount;

    // Free delivery discount (only affects delivery)
    const deliveryDiscountAmount = freeDelivery ? deliveryTotal : 0;

    // Subtotals after discounts
    const productsAfterDiscount = productsTotal - totalProductDiscount;
    const deliveryAfterDiscount = deliveryTotal - deliveryDiscountAmount;

    // Subtotal (products + delivery after discounts, before tax)
    const subtotal = productsAfterDiscount + deliveryAfterDiscount;

    // Tax only on taxable items, after their line discount + a proportional
    // share of the order-level discount.
    const orderRatio = netAfterLineTotal > 0 ? orderDiscount / netAfterLineTotal : 0;
    let taxableProductsAfterDiscount = 0;
    productItems.forEach((item, i) => {
      if (item.product.is_taxable !== false) {
        const netLine = item.lineTotal - lineDiscounts[i];
        taxableProductsAfterDiscount += netLine * (1 - orderRatio);
      }
    });

    // Delivery is typically taxable
    const taxableDelivery = deliveryAfterDiscount;

    // Total taxable amount
    const taxableAmount = taxableProductsAfterDiscount + taxableDelivery;
    const taxAmount = customerTaxExempt ? 0 : taxableAmount * (itbms_rate / 100);

    // Total
    const total = subtotal + taxAmount;
    
    // Weight and bags (only from product items)
    const totalWeight = productItems.reduce((sum, item) => sum + (item.totalWeight || 0), 0);
    const totalBags = productItems.reduce((sum, item) => sum + (item.bags || 0), 0);
    const totalPieces = productItems.reduce((sum, item) => sum + (item.pieces || item.quantity || 0), 0);
    
    // Promised date
    const promisedDate = calculatePromisedDate(isExpress);
    
    return {
      productsTotal,
      deliveryTotal,
      productDiscountAmount: totalProductDiscount,
      promotionDiscountAmount: promoReported,
      manualDiscountAmount: manualReported,
      lineDiscountTotal,
      deliveryDiscountAmount,
      subtotal,
      taxAmount,
      total,
      totalWeight,
      totalBags,
      totalPieces,
      promisedDate,
      productItems,
      deliveryItems,
      // Legacy compatibility
      discountAmount: totalProductDiscount,
      deliveryCharge: deliveryTotal,
    };
  }, [state.ticket, state.settings]);
  
  // Actions
  const actions = {
    // Ticket
    setCustomer: (customer) => dispatch({ type: actionTypes.SET_CUSTOMER, payload: customer }),
    setWalkIn: (isWalkIn) => dispatch({ type: actionTypes.SET_WALK_IN, payload: isWalkIn }),
    confirmWalkIn: () => dispatch({ type: actionTypes.CONFIRM_WALK_IN }),
    setExpress: (isExpress) => dispatch({ type: actionTypes.SET_EXPRESS, payload: isExpress }),
    addItem: (item) => dispatch({ type: actionTypes.ADD_ITEM, payload: item }),
    updateItem: (index, updates) => dispatch({ type: actionTypes.UPDATE_ITEM, payload: { index, updates } }),
    removeItem: (index) => dispatch({ type: actionTypes.REMOVE_ITEM, payload: index }),
    clearTicket: () => dispatch({ type: actionTypes.CLEAR_TICKET }),
    restoreTicket: (ticket) => dispatch({ type: actionTypes.RESTORE_TICKET, payload: ticket }),
    setLastCustomer: (customer) => dispatch({ type: actionTypes.SET_LAST_CUSTOMER, payload: customer }),
    setNotes: (notes) => dispatch({ type: actionTypes.SET_NOTES, payload: notes }),
    setDelivery: (product) => dispatch({ type: actionTypes.SET_DELIVERY, payload: product }),
    setManualDiscount: (discount) => dispatch({ type: actionTypes.SET_MANUAL_DISCOUNT, payload: discount }),
    setPromotion: (promotion) => dispatch({ type: actionTypes.SET_PROMOTION, payload: promotion }),
    setFreeDelivery: (isFree) => dispatch({ type: actionTypes.SET_FREE_DELIVERY, payload: isFree }),
    
    // UI
    setActiveSection: (sectionId) => dispatch({ type: actionTypes.SET_ACTIVE_SECTION, payload: sectionId }),
    setCurrentView: (view) => dispatch({ type: actionTypes.SET_CURRENT_VIEW, payload: view }),
    toggleSidebar: (open) => dispatch({ type: actionTypes.TOGGLE_SIDEBAR, payload: open }),
    
    // Data loading (for Supabase integration)
    setLoading: (loadingState) => dispatch({ type: actionTypes.SET_LOADING, payload: loadingState }),
    setError: (error) => dispatch({ type: actionTypes.SET_ERROR, payload: error }),
    setUser: (user) => dispatch({ type: actionTypes.SET_USER, payload: user }),
    setStore: (store) => dispatch({ type: actionTypes.SET_STORE, payload: store }),
    setCompany: (company) => dispatch({ type: actionTypes.SET_COMPANY, payload: company }),
    setSettings: (settings) => dispatch({ type: actionTypes.SET_SETTINGS, payload: settings }),
    setSections: (sections) => dispatch({ type: actionTypes.SET_SECTIONS, payload: sections }),
    setProducts: (products) => dispatch({ type: actionTypes.SET_PRODUCTS, payload: products }),
    setCustomers: (customers) => dispatch({ type: actionTypes.SET_CUSTOMERS, payload: customers }),
    setOrders: (orders) => dispatch({ type: actionTypes.SET_ORDERS, payload: orders }),
    setPaymentMethods: (methods) => dispatch({ type: actionTypes.SET_PAYMENT_METHODS, payload: methods }),
    
    // Customers CRUD
    addCustomer: (customer) => dispatch({ type: actionTypes.ADD_CUSTOMER, payload: customer }),
    updateCustomer: (customer) => dispatch({ type: actionTypes.UPDATE_CUSTOMER, payload: customer }),
    deleteCustomer: (customerId) => dispatch({ type: actionTypes.DELETE_CUSTOMER, payload: customerId }),
    
    // Orders CRUD
    addOrder: (order) => dispatch({ type: actionTypes.ADD_ORDER, payload: order }),
    updateOrder: (order) => dispatch({ type: actionTypes.UPDATE_ORDER, payload: order }),
    updateOrderStatus: (orderId, status) => dispatch({ type: actionTypes.UPDATE_ORDER_STATUS, payload: { orderId, status } }),
    
    // Products CRUD
    addProduct: (product) => dispatch({ type: actionTypes.ADD_PRODUCT, payload: product }),
    updateProduct: (product) => dispatch({ type: actionTypes.UPDATE_PRODUCT, payload: product }),
    updateProductsOrder: (updates) => dispatch({ type: actionTypes.UPDATE_PRODUCTS_ORDER, payload: updates }),
    deleteProduct: (productId) => dispatch({ type: actionTypes.DELETE_PRODUCT, payload: productId }),
    
    // Sections CRUD
    addSection: (section) => dispatch({ type: actionTypes.ADD_SECTION, payload: section }),
    updateSection: (section) => dispatch({ type: actionTypes.UPDATE_SECTION, payload: section }),
    deleteSection: (sectionId) => dispatch({ type: actionTypes.DELETE_SECTION, payload: sectionId }),
    
    // Process order
    processOrder: (paymentInfo) => {
      const calculations = ticketCalculations();
      // Generate order number - handle empty orders array
      const existingNumbers = state.orders.map(o => o.order_number).filter(n => n);
      const orderNumber = existingNumbers.length > 0 
        ? Math.max(...existingNumbers) + 1 
        : 1;
      
      const newOrder = {
        id: generateId('ord'),
        store_id: state.store?.id || null,
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
