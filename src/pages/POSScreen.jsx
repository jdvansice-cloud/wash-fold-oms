import React, { useState, useMemo, useEffect } from 'react';
import { useApp } from '../context/AppContext';
import WeightEntryModal from '../components/modals/WeightEntryModal';
import ChildProductsModal from '../components/modals/ChildProductsModal';
import CustomerSearchModal from '../components/modals/CustomerSearchModal';

function POSScreen() {
  const { state, actions } = useApp();
  const [weightModalProduct, setWeightModalProduct] = useState(null);
  const [childModalProduct, setChildModalProduct] = useState(null);
  const [showCustomerModal, setShowCustomerModal] = useState(false);
  
  // Set default active section when sections load
  useEffect(() => {
    const activeSections = state.sections.filter(s => s.is_active);
    if (activeSections.length > 0 && !state.activeSection) {
      actions.setActiveSection(activeSections[0].id);
    }
  }, [state.sections, state.activeSection, actions]);
  
  // Get products for active section from state (not sampleData)
  const sectionProducts = useMemo(() => {
    return state.products
      .filter(p => p.section_id === state.activeSection && !p.parent_id && p.is_active !== false)
      .sort((a, b) => (a.display_order || 0) - (b.display_order || 0));
  }, [state.products, state.activeSection]);
  
  // Get child products for a parent
  const getChildProducts = (parentId) => {
    return state.products
      .filter(p => p.parent_id === parentId && p.is_active !== false)
      .sort((a, b) => (a.display_order || 0) - (b.display_order || 0));
  };
  
  const handleProductClick = (product) => {
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
  };
  
  const handleWalkInSelect = () => {
    actions.confirmWalkIn();
    setShowCustomerModal(false);
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
      {state.sections.filter(s => s.is_active).length > 0 ? (
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
      ) : (
        <div className="mb-6 p-4 bg-amber-50 border border-amber-200 rounded-xl text-amber-700 text-sm">
          No hay secciones configuradas. Ve a Configuración → Productos → Secciones para crear secciones.
        </div>
      )}
      
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
      
      {/* Empty State - No products in section */}
      {state.activeSection && sectionProducts.length === 0 && (
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
          onClose={() => setShowCustomerModal(false)}
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
  
  // Check if product has different express price
  const hasExpressPrice = product.express_price && product.express_price !== product.price;
  
  // Parent product tile - different styling
  if (hasChildren) {
    return (
      <button
        onClick={onClick}
        className="product-tile flex flex-col items-center text-center group relative overflow-hidden bg-gradient-to-br from-purple-50 to-indigo-50 border-2 border-purple-200 hover:border-purple-400 hover:shadow-lg"
        style={{ animationDelay: `${delay}ms` }}
      >
        {/* Category indicator */}
        <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-purple-400 to-indigo-400" />
        
        {/* Icon */}
        <div className="w-16 h-16 flex items-center justify-center mb-3 mt-2 bg-white/60 rounded-2xl group-hover:bg-white transition-colors shadow-sm">
          <span className="text-3xl">{product.icon || '📦'}</span>
        </div>
        
        {/* Name */}
        <p className="text-sm font-semibold text-purple-800 leading-tight mb-2 line-clamp-2">
          {product.name}
        </p>
        
        {/* "Ver opciones" label instead of price */}
        <span className="text-xs font-medium text-purple-600 bg-purple-100 px-2 py-1 rounded-full">
          Ver opciones →
        </span>
        
        {/* Corner badge */}
        <span className="absolute top-2 right-2 w-6 h-6 bg-purple-500 text-white rounded-full text-xs flex items-center justify-center font-bold shadow-sm">
          +
        </span>
      </button>
    );
  }
  
  // Regular product tile
  return (
    <button
      onClick={onClick}
      className={`product-tile flex flex-col items-center text-center group relative ${
        isExpress ? 'ring-2 ring-warning-400 ring-offset-1' : ''
      }`}
      style={{ animationDelay: `${delay}ms` }}
    >
      {/* Express badge */}
      {isExpress && hasExpressPrice && (
        <div className="absolute -top-1 -right-1 bg-warning-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full flex items-center gap-0.5 shadow-sm z-10">
          <span>⚡</span>
        </div>
      )}
      
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
          <span className={`text-sm font-semibold ${isExpress && hasExpressPrice ? 'text-warning-600' : 'text-primary-600'}`}>
            B/{priceWithTax.toFixed(2)}
          </span>
        </div>
      ) : (
        <span className={`text-sm font-semibold ${isExpress && hasExpressPrice ? 'text-warning-600' : 'text-primary-600'}`}>
          B/{priceWithTax.toFixed(2)}
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
