import React, { useState, useMemo } from 'react';
import { useApp } from '../context/AppContext';
import { getProductsBySection, getChildProducts } from '../data/sampleData';
import WeightEntryModal from '../components/modals/WeightEntryModal';
import ChildProductsModal from '../components/modals/ChildProductsModal';
import CustomerSearchModal from '../components/modals/CustomerSearchModal';

function POSScreen() {
  const { state, actions } = useApp();
  const [weightModalProduct, setWeightModalProduct] = useState(null);
  const [childModalProduct, setChildModalProduct] = useState(null);
  const [showCustomerModal, setShowCustomerModal] = useState(false);
  const [pendingProduct, setPendingProduct] = useState(null);
  
  // Check if customer is selected (either walk-in confirmed or actual customer)
  const hasCustomerSelected = state.ticket.customer !== null || state.ticket.customerConfirmed;
  
  // Get products for active section
  const sectionProducts = useMemo(() => {
    return getProductsBySection(state.activeSection).filter(p => !p.parent_id);
  }, [state.activeSection]);
  
  const handleProductClick = (product) => {
    // Check if customer is selected first
    if (!hasCustomerSelected) {
      setPendingProduct(product);
      setShowCustomerModal(true);
      return;
    }
    
    // If product has children, show child selection modal
    if (product.has_children) {
      setChildModalProduct(product);
      return;
    }
    
    // If product is weight-based, show weight entry modal
    if (product.pricing_type === 'weight') {
      setWeightModalProduct(product);
      return;
    }
    
    // For quantity-based products, add directly to ticket
    addProductToTicket(product);
  };
  
  const addProductToTicket = (product) => {
    const price = state.ticket.isExpress ? (product.express_price || product.price) : product.price;
    actions.addItem({
      product,
      quantity: 1,
      unitPrice: price,
      lineTotal: price,
      pieces: product.pieces_per_unit || 1,
    });
  };
  
  const handleCustomerSelect = (customer) => {
    actions.setCustomer(customer);
    setShowCustomerModal(false);
    
    // If there was a pending product, process it now
    if (pendingProduct) {
      setTimeout(() => {
        if (pendingProduct.has_children) {
          setChildModalProduct(pendingProduct);
        } else if (pendingProduct.pricing_type === 'weight') {
          setWeightModalProduct(pendingProduct);
        } else {
          addProductToTicket(pendingProduct);
        }
        setPendingProduct(null);
      }, 100);
    }
  };
  
  const handleWalkInSelect = () => {
    actions.confirmWalkIn();
    setShowCustomerModal(false);
    
    // If there was a pending product, process it now
    if (pendingProduct) {
      setTimeout(() => {
        if (pendingProduct.has_children) {
          setChildModalProduct(pendingProduct);
        } else if (pendingProduct.pricing_type === 'weight') {
          setWeightModalProduct(pendingProduct);
        } else {
          addProductToTicket(pendingProduct);
        }
        setPendingProduct(null);
      }, 100);
    }
  };
  
  const handleWeightEntry = (product, entries) => {
    const totalWeight = entries.reduce((sum, e) => sum + e.weight, 0);
    const totalBags = entries.length;
    const totalPieces = entries.reduce((sum, e) => sum + (e.pieces || 0), 0);
    const price = state.ticket.isExpress ? (product.express_price || product.price) : product.price;
    const lineTotal = totalWeight * price;
    
    actions.addItem({
      product,
      quantity: 1,
      totalWeight,
      weightEntries: entries,
      bags: totalBags,
      pieces: totalPieces,
      unitPrice: price,
      lineTotal,
    });
    
    setWeightModalProduct(null);
  };
  
  const handleChildProductSelect = (childProduct) => {
    // Check if customer is selected first
    if (!hasCustomerSelected) {
      setPendingProduct(childProduct);
      setShowCustomerModal(true);
      setChildModalProduct(null);
      return;
    }
    
    if (childProduct.pricing_type === 'weight') {
      setWeightModalProduct(childProduct);
    } else {
      addProductToTicket(childProduct);
    }
    setChildModalProduct(null);
  };
  
  return (
    <div className="p-6 animate-fade-in">
      {/* Category Tabs */}
      <div className="mb-6 flex items-center gap-2 overflow-x-auto pb-2 scrollbar-thin">
        {state.sections.filter(s => s.is_active).map((section) => (
          <button
            key={section.id}
            onClick={() => actions.setActiveSection(section.id)}
            className={`category-tab whitespace-nowrap ${
              state.activeSection === section.id ? 'active' : ''
            }`}
          >
            {section.name}
          </button>
        ))}
      </div>
      
      {/* Product Grid */}
      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-4">
        {sectionProducts.map((product, index) => (
          <ProductTile
            key={product.id}
            product={product}
            onClick={() => handleProductClick(product)}
            isExpress={state.ticket.isExpress}
            delay={index * 30}
            itbmsRate={state.settings?.itbms_rate || 7}
          />
        ))}
      </div>
      
      {/* Empty State */}
      {sectionProducts.length === 0 && (
        <div className="flex flex-col items-center justify-center py-20 text-slate-400">
          <div className="w-20 h-20 bg-slate-100 rounded-full flex items-center justify-center mb-4">
            <span className="text-4xl">📦</span>
          </div>
          <p className="text-lg font-medium">No hay productos en esta sección</p>
          <p className="text-sm mt-1">Agrega productos desde Configuración</p>
        </div>
      )}
      
      {/* Modals */}
      {weightModalProduct && (
        <WeightEntryModal
          product={weightModalProduct}
          isExpress={state.ticket.isExpress}
          onClose={() => setWeightModalProduct(null)}
          onSubmit={(entries) => handleWeightEntry(weightModalProduct, entries)}
          itbmsRate={state.settings?.itbms_rate || 7}
        />
      )}
      
      {childModalProduct && (
        <ChildProductsModal
          parentProduct={childModalProduct}
          childProducts={getChildProducts(childModalProduct.id)}
          onClose={() => setChildModalProduct(null)}
          onSelect={handleChildProductSelect}
          itbmsRate={state.settings?.itbms_rate || 7}
        />
      )}
      
      {showCustomerModal && (
        <CustomerSearchModal
          onClose={() => {
            setShowCustomerModal(false);
            setPendingProduct(null);
          }}
          onSelect={handleCustomerSelect}
          onWalkIn={handleWalkInSelect}
          showWalkInPrompt={true}
        />
      )}
    </div>
  );
}

// Product Tile Component
function ProductTile({ product, onClick, isExpress, delay, itbmsRate = 7 }) {
  const basePrice = isExpress ? (product.express_price || product.price) : product.price;
  // Calculate price with ITBMS included for display
  const priceWithTax = basePrice * (1 + itbmsRate / 100);
  const isWeightBased = product.pricing_type === 'weight';
  const hasChildren = product.has_children;
  
  return (
    <button
      onClick={onClick}
      className="product-tile flex flex-col items-center text-center group"
      style={{ animationDelay: `${delay}ms` }}
    >
      {/* Icon */}
      <div className="w-16 h-16 flex items-center justify-center mb-3 bg-gradient-to-br from-slate-50 to-slate-100 rounded-2xl group-hover:from-primary-50 group-hover:to-primary-100 transition-colors">
        <span className="text-3xl">{product.icon || '📦'}</span>
      </div>
      
      {/* Name */}
      <p className="text-sm font-medium text-slate-700 leading-tight mb-2 line-clamp-2">
        {product.name}
      </p>
      
      {/* Price Badge - showing price WITH ITBMS */}
      {isWeightBased ? (
        <div className="flex flex-col items-center">
          <span className="text-xs text-slate-500">por kg</span>
          <span className="text-sm font-semibold text-primary-600">
            B/{priceWithTax.toFixed(2)}
          </span>
        </div>
      ) : (
        <span className="text-sm font-semibold text-primary-600">
          B/{priceWithTax.toFixed(2)}
        </span>
      )}
      
      {/* Indicators */}
      {hasChildren && (
        <span className="absolute top-2 right-2 w-5 h-5 bg-primary-100 text-primary-600 rounded-full text-xs flex items-center justify-center font-bold">
          +
        </span>
      )}
      
      {/* Weight indicator */}
      {isWeightBased && (
        <div className="absolute bottom-0 left-0 right-0 h-1 bg-primary-500 rounded-b-xl opacity-0 group-hover:opacity-100 transition-opacity" />
      )}
    </button>
  );
}

export default POSScreen;
