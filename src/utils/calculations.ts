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

export interface LineDiscount {
  mode: 'amount' | 'pct';
  value: number;
}

export interface TicketItem {
  product: TicketProduct;
  quantity: number;
  totalWeight?: number;
  bags?: number;
  pieces?: number;
  unitPrice: number;
  lineTotal: number;
  /** Per-line manual discount, as a B/. amount or a % of the line gross. */
  discount?: LineDiscount | null;
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
  /** When the selected customer is ITBMS-exempt (exonerado), tax is zeroed. */
  customerTaxExempt?: boolean;
}

export interface TicketCalculationResult {
  productsTotal: number;
  deliveryTotal: number;
  productDiscountAmount: number;
  promotionDiscountAmount: number;
  manualDiscountAmount: number;
  lineDiscountTotal: number;
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
  const {
    items,
    isExpress,
    manualDiscount,
    promotion,
    deliveryProduct,
    freeDelivery,
    itbmsRate,
    customerTaxExempt = false,
  } = input;

  // Step 1: Separate product items from delivery items
  const productItems = items.filter((item) => item.product.product_type !== 'delivery');
  const deliveryItems = items.filter((item) => item.product.product_type === 'delivery');

  // Step 2: Products subtotal (gross) + per-line discounts
  const productsTotal = productItems.reduce((sum, item) => sum + item.lineTotal, 0);
  const lineDiscountFor = (item: TicketItem): number => {
    const d = item.discount;
    if (!d || !d.value) return 0;
    const gross = item.lineTotal || 0;
    const amt = d.mode === 'pct' ? gross * (d.value / 100) : d.value;
    return Math.min(Math.max(0, amt), gross);
  };
  const lineDiscounts = productItems.map(lineDiscountFor);
  const lineDiscountTotal = lineDiscounts.reduce((s, d) => s + d, 0);
  const netAfterLineTotal = Math.max(0, productsTotal - lineDiscountTotal);

  // Step 3: Delivery total (from items or standalone delivery product)
  let deliveryTotal = deliveryItems.reduce((sum, item) => sum + item.lineTotal, 0);
  if (deliveryProduct && deliveryItems.length === 0) {
    deliveryTotal = deliveryProduct.price;
  }

  // Step 4: Order-level manual discount (products only)
  let manualDiscountAmount = 0;
  if (manualDiscount) {
    manualDiscountAmount =
      manualDiscount.type === 'percentage'
        ? productsTotal * (manualDiscount.value / 100)
        : manualDiscount.value;
  }

  // Step 5: Promotion discount (products only)
  let promotionDiscountAmount = 0;
  if (promotion) {
    promotionDiscountAmount =
      promotion.discount_type === 'percentage'
        ? productsTotal * (promotion.discount_value / 100)
        : promotion.discount_value;
  }

  // Step 6: Aggregate discounts (order-level capped at the post-line net).
  // Reported manual/promo amounts are scaled to the applied (capped) total.
  const combinedOrder = manualDiscountAmount + promotionDiscountAmount;
  const orderDiscount = Math.min(combinedOrder, netAfterLineTotal);
  const manualReported = combinedOrder > 0 ? orderDiscount * (manualDiscountAmount / combinedOrder) : 0;
  const promoReported = combinedOrder > 0 ? orderDiscount * (promotionDiscountAmount / combinedOrder) : 0;
  const totalProductDiscount = lineDiscountTotal + orderDiscount;
  const deliveryDiscountAmount = freeDelivery ? deliveryTotal : 0;

  // Step 7: Subtotals after discounts
  const productsAfterDiscount = productsTotal - totalProductDiscount;
  const deliveryAfterDiscount = deliveryTotal - deliveryDiscountAmount;
  const subtotal = productsAfterDiscount + deliveryAfterDiscount;

  // Step 8: ITBMS on taxable lines, after line discount + a proportional share
  // of the order-level discount.
  const orderRatio = netAfterLineTotal > 0 ? orderDiscount / netAfterLineTotal : 0;
  let taxableProductsAfterDiscount = 0;
  productItems.forEach((item, i) => {
    if (item.product.is_taxable !== false) {
      taxableProductsAfterDiscount += (item.lineTotal - lineDiscounts[i]) * (1 - orderRatio);
    }
  });
  const taxableDelivery = deliveryAfterDiscount;
  const taxableAmount = taxableProductsAfterDiscount + taxableDelivery;
  // An ITBMS-exempt (exonerado) customer zeroes the whole ticket's tax.
  const taxAmount = customerTaxExempt ? 0 : taxableAmount * (itbmsRate / 100);

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
