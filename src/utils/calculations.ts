// Pure ticket calculation logic extracted from AppContext.jsx
// This is the pricing engine for the POS system

import type { ServiceSettings } from '@/data/constants';
import { defaultServiceSettings } from '@/data/constants';

// --- Types ---

export interface TicketProduct {
  id: string;
  product_type: string;
  is_taxable?: boolean;
  price: number;
  express_price?: number;
  pricing_type: string;
}

export interface TicketItem {
  product: TicketProduct;
  quantity: number;
  totalWeight?: number;
  bags?: number;
  pieces?: number;
  unitPrice: number;
  lineTotal: number;
}

export interface ManualDiscount {
  type: 'percentage' | 'fixed';
  value: number;
}

export interface Promotion {
  code?: string;
  discount_type: 'percentage' | 'fixed';
  discount_value: number;
}

export interface DeliveryProduct {
  id: string;
  price: number;
}

export interface TicketCalculationInput {
  items: TicketItem[];
  isExpress: boolean;
  manualDiscount: ManualDiscount | null;
  promotion: Promotion | null;
  deliveryProduct: DeliveryProduct | null;
  freeDelivery: boolean;
  itbmsRate: number;
}

export interface TicketCalculationResult {
  productsTotal: number;
  deliveryTotal: number;
  productDiscountAmount: number;
  promotionDiscountAmount: number;
  manualDiscountAmount: number;
  deliveryDiscountAmount: number;
  subtotal: number;
  taxAmount: number;
  total: number;
  totalWeight: number;
  totalBags: number;
  totalPieces: number;
  promisedDate: Date;
  productItems: TicketItem[];
  deliveryItems: TicketItem[];
  // Legacy compatibility fields
  discountAmount: number;
  deliveryCharge: number;
}

// --- Core calculation ---

export function calculateTicket(input: TicketCalculationInput): TicketCalculationResult {
  const { items, isExpress, manualDiscount, promotion, deliveryProduct, freeDelivery, itbmsRate } =
    input;

  // Step 1: Separate product items from delivery items
  const productItems = items.filter((item) => item.product.product_type !== 'delivery');
  const deliveryItems = items.filter((item) => item.product.product_type === 'delivery');

  // Step 2: Products subtotal
  const productsTotal = productItems.reduce((sum, item) => sum + item.lineTotal, 0);

  // Step 3: Delivery total (from items or standalone delivery product)
  let deliveryTotal = deliveryItems.reduce((sum, item) => sum + item.lineTotal, 0);
  if (deliveryProduct && deliveryItems.length === 0) {
    deliveryTotal = deliveryProduct.price;
  }

  // Step 4: Manual discount (applies to products only)
  let manualDiscountAmount = 0;
  if (manualDiscount) {
    if (manualDiscount.type === 'percentage') {
      manualDiscountAmount = productsTotal * (manualDiscount.value / 100);
    } else {
      manualDiscountAmount = Math.min(manualDiscount.value, productsTotal);
    }
  }

  // Step 5: Promotion discount (applies to products only)
  let promotionDiscountAmount = 0;
  if (promotion) {
    if (promotion.discount_type === 'percentage') {
      promotionDiscountAmount = productsTotal * (promotion.discount_value / 100);
    } else {
      promotionDiscountAmount = Math.min(promotion.discount_value, productsTotal);
    }
  }

  // Step 6: Aggregate discounts
  const totalProductDiscount = manualDiscountAmount + promotionDiscountAmount;
  const deliveryDiscountAmount = freeDelivery ? deliveryTotal : 0;

  // Step 7: Subtotals after discounts
  const productsAfterDiscount = productsTotal - totalProductDiscount;
  const deliveryAfterDiscount = deliveryTotal - deliveryDiscountAmount;
  const subtotal = productsAfterDiscount + deliveryAfterDiscount;

  // Step 8: ITBMS tax (proportionally on taxable items only)
  const taxableProductsAmount = productItems
    .filter((item) => item.product.is_taxable !== false)
    .reduce((sum, item) => sum + item.lineTotal, 0);

  const taxableDiscountRatio = productsTotal > 0 ? totalProductDiscount / productsTotal : 0;
  const taxableProductsAfterDiscount = taxableProductsAmount * (1 - taxableDiscountRatio);
  const taxableDelivery = deliveryAfterDiscount;
  const taxableAmount = taxableProductsAfterDiscount + taxableDelivery;
  const taxAmount = taxableAmount * (itbmsRate / 100);

  // Step 9: Grand total
  const total = subtotal + taxAmount;

  // Step 10: Aggregates (product items only)
  const totalWeight = productItems.reduce((sum, item) => sum + (item.totalWeight || 0), 0);
  const totalBags = productItems.reduce((sum, item) => sum + (item.bags || 0), 0);
  const totalPieces = productItems.reduce(
    (sum, item) => sum + (item.pieces || item.quantity || 0),
    0,
  );

  // Promised date
  const promisedDate = calculatePromisedDate(isExpress);

  return {
    productsTotal,
    deliveryTotal,
    productDiscountAmount: totalProductDiscount,
    promotionDiscountAmount,
    manualDiscountAmount,
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
}

// --- Helper functions ---

/**
 * Calculate the promised completion date based on express flag and settings
 */
export function calculatePromisedDate(
  isExpress = false,
  settings: ServiceSettings = defaultServiceSettings,
): Date {
  const date = new Date();
  const daysToAdd = isExpress ? settings.express_completion_days : settings.default_completion_days;
  date.setDate(date.getDate() + daysToAdd);
  date.setHours(12, 0, 0, 0); // Always noon
  return date;
}
