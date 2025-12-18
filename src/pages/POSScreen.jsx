import React, { useState, useMemo, useEffect } from 'react';
import { useApp } from '../context/AppContext';
import WeightEntryModal from '../components/modals/WeightEntryModal';
import ChildProductsModal from '../components/modals/ChildProductsModal';

function POSScreen() {
  const { state, actions } = useApp();
  const [weightModalProduct, setWeightModalProduct] = useState(null);
  const [childModalProduct, setChildModalProduct] = useState(null);
  
  // Set default active section when sections load
  useEffect(() => {
    const activeSections = state.sections.filter(s => s.is_active);
    if (activeSections.length > 0 && !state.activeSection) {
      actions.setActiveSection(activeSections[0].id);
    }
  }, [state.sections, state.activeSection, actions]);
  
  // Get products for active section from state (sorted by display_order)
  const sectionProducts = useMemo(() => {
    return state.products
      .filter(p => p.section_id === state.activeSection && !p.parent_id && p.is_active !== false)
      .sort((a, b) => (a.display_order || 0) - (b.display_order || 0));
  }, [state.products, state.activeSection]);
  
  // Get child products for a parent (sorted by display_order)
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
    </div>
  );
}

// Product Tile Component
function ProductTile({ product, onClick, isExpress, delay, itbmsRate = 7 }) {
  const basePrice = isExpress ? (product.express_price || product.price) : product.price;
  // Only add ITBMS if product is taxable
  const displayPrice = product.is_taxable !== false 
    ? basePrice * (1 + itbmsRate / 100)  // With ITBMS
    : basePrice;  // Price as stored (no ITBMS)
  const isWeightBased = product.pricing_type === 'weight';
  const hasChildren = product.has_children;
  
  return (
    <button
      onClick={onClick}
      className={`product-tile flex flex-col items-center text-center group ${
        hasChildren ? 'ring-2 ring-primary-200 ring-offset-2' : ''
      }`}
      style={{ animationDelay: `${delay}ms` }}
    >
      {/* Icon - different style for parents */}
      <div className={`w-16 h-16 flex items-center justify-center mb-3 rounded-2xl transition-colors ${
        hasChildren 
          ? 'bg-gradient-to-br from-primary-50 to-primary-100 group-hover:from-primary-100 group-hover:to-primary-200' 
          : 'bg-gradient-to-br from-slate-50 to-slate-100 group-hover:from-primary-50 group-hover:to-primary-100'
      }`}>
        <span className="text-3xl">{product.icon || '📦'}</span>
      </div>
      
      {/* Name */}
      <p className="text-sm font-medium text-slate-700 leading-tight mb-2 line-clamp-2">
        {product.name}
      </p>
      
      {/* Price Badge - Only show for non-parent products */}
      {hasChildren ? (
        <div className="flex items-center gap-1 text-xs text-primary-600 font-medium">
          <span>Ver opciones</span>
          <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
          </svg>
        </div>
      ) : isWeightBased ? (
        <div className="flex flex-col items-center">
          <span className="text-xs text-slate-500">por kg</span>
          <span className="text-sm font-semibold text-primary-600">
            B/{displayPrice.toFixed(2)}
          </span>
        </div>
      ) : (
        <span className="text-sm font-semibold text-primary-600">
          B/{displayPrice.toFixed(2)}
        </span>
      )}
      
      {/* Parent indicator badge */}
      {hasChildren && (
        <span className="absolute top-2 right-2 px-2 py-0.5 bg-primary-500 text-white rounded-full text-[10px] font-semibold flex items-center gap-1">
          <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h7" />
          </svg>
        </span>
      )}
      
      {/* Weight indicator */}
      {isWeightBased && !hasChildren && (
        <div className="absolute bottom-0 left-0 right-0 h-1 bg-primary-500 rounded-b-xl opacity-0 group-hover:opacity-100 transition-opacity" />
      )}
    </button>
  );
}

export default POSScreen;
