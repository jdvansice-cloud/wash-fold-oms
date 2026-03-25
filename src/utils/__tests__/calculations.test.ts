import { describe, it, expect } from 'vitest';
import { calculateTicket, calculatePromisedDate } from '../calculations';
import type { TicketItem, TicketCalculationInput } from '../calculations';

function makeItem(overrides: Partial<TicketItem> = {}): TicketItem {
  return {
    product: {
      id: 'prod-1',
      product_type: 'service',
      is_taxable: true,
      price: 2.5,
      express_price: 3.5,
      pricing_type: 'weight',
    },
    quantity: 1,
    totalWeight: 2,
    bags: 1,
    pieces: 0,
    unitPrice: 2.5,
    lineTotal: 5.0,
    ...overrides,
  };
}

function makeInput(overrides: Partial<TicketCalculationInput> = {}): TicketCalculationInput {
  return {
    items: [],
    isExpress: false,
    manualDiscount: null,
    promotion: null,
    deliveryProduct: null,
    freeDelivery: false,
    itbmsRate: 7.0,
    ...overrides,
  };
}

describe('calculateTicket', () => {
  it('returns zeros for empty items', () => {
    const result = calculateTicket(makeInput());
    expect(result.productsTotal).toBe(0);
    expect(result.deliveryTotal).toBe(0);
    expect(result.subtotal).toBe(0);
    expect(result.taxAmount).toBe(0);
    expect(result.total).toBe(0);
    expect(result.totalWeight).toBe(0);
    expect(result.totalBags).toBe(0);
  });

  it('calculates single weight-based product', () => {
    const item = makeItem({ lineTotal: 5.0, totalWeight: 2, bags: 1 });
    const result = calculateTicket(makeInput({ items: [item] }));

    expect(result.productsTotal).toBe(5.0);
    expect(result.subtotal).toBe(5.0);
    expect(result.taxAmount).toBeCloseTo(0.35, 2); // 5 * 0.07
    expect(result.total).toBeCloseTo(5.35, 2);
    expect(result.totalWeight).toBe(2);
    expect(result.totalBags).toBe(1);
  });

  it('calculates quantity-based product', () => {
    const item = makeItem({
      product: { id: 'p2', product_type: 'service', is_taxable: true, price: 10, pricing_type: 'quantity' },
      quantity: 3,
      totalWeight: 0,
      unitPrice: 10,
      lineTotal: 30,
    });
    const result = calculateTicket(makeInput({ items: [item] }));

    expect(result.productsTotal).toBe(30);
    expect(result.total).toBeCloseTo(32.1, 2); // 30 + 30*0.07
  });

  it('applies percentage manual discount', () => {
    const item = makeItem({ lineTotal: 100 });
    const result = calculateTicket(
      makeInput({ items: [item], manualDiscount: { type: 'percentage', value: 20 } }),
    );

    expect(result.manualDiscountAmount).toBe(20);
    expect(result.subtotal).toBe(80);
  });

  it('applies fixed manual discount capped at products total', () => {
    const item = makeItem({ lineTotal: 10 });
    const result = calculateTicket(
      makeInput({ items: [item], manualDiscount: { type: 'fixed', value: 50 } }),
    );

    expect(result.manualDiscountAmount).toBe(10); // Capped at productsTotal
    expect(result.subtotal).toBe(0);
  });

  it('stacks manual and promotion discounts', () => {
    const item = makeItem({ lineTotal: 100 });
    const result = calculateTicket(
      makeInput({
        items: [item],
        manualDiscount: { type: 'fixed', value: 10 },
        promotion: { discount_type: 'percentage', discount_value: 10 },
      }),
    );

    expect(result.manualDiscountAmount).toBe(10);
    expect(result.promotionDiscountAmount).toBe(10);
    expect(result.productDiscountAmount).toBe(20);
    expect(result.subtotal).toBe(80);
  });

  it('calculates ITBMS only on taxable items', () => {
    const taxable = makeItem({ lineTotal: 100, product: { id: 'p1', product_type: 'service', is_taxable: true, price: 100, pricing_type: 'quantity' } });
    const nonTaxable = makeItem({ lineTotal: 50, product: { id: 'p2', product_type: 'service', is_taxable: false, price: 50, pricing_type: 'quantity' } });

    const result = calculateTicket(makeInput({ items: [taxable, nonTaxable] }));

    // Only B/100 is taxable, not the B/50
    expect(result.productsTotal).toBe(150);
    expect(result.taxAmount).toBeCloseTo(7.0, 2); // 100 * 0.07
    expect(result.total).toBeCloseTo(157.0, 2);
  });

  it('separates delivery items from product items', () => {
    const product = makeItem({ lineTotal: 20 });
    const delivery = makeItem({
      lineTotal: 5,
      product: { id: 'del', product_type: 'delivery', is_taxable: true, price: 5, pricing_type: 'quantity' },
      totalWeight: 0,
      bags: 0,
    });

    const result = calculateTicket(makeInput({ items: [product, delivery] }));

    expect(result.productsTotal).toBe(20);
    expect(result.deliveryTotal).toBe(5);
    expect(result.productItems).toHaveLength(1);
    expect(result.deliveryItems).toHaveLength(1);
    expect(result.totalWeight).toBe(2); // Only from product item
  });

  it('uses standalone delivery product when no delivery items', () => {
    const product = makeItem({ lineTotal: 20 });
    const result = calculateTicket(
      makeInput({ items: [product], deliveryProduct: { id: 'del', price: 3 } }),
    );

    expect(result.deliveryTotal).toBe(3);
    expect(result.subtotal).toBe(23);
  });

  it('applies free delivery discount', () => {
    const product = makeItem({ lineTotal: 20 });
    const result = calculateTicket(
      makeInput({
        items: [product],
        deliveryProduct: { id: 'del', price: 5 },
        freeDelivery: true,
      }),
    );

    expect(result.deliveryTotal).toBe(5);
    expect(result.deliveryDiscountAmount).toBe(5);
    expect(result.subtotal).toBe(20); // No delivery charge
  });

  it('populates legacy compatibility fields', () => {
    const item = makeItem({ lineTotal: 50 });
    const result = calculateTicket(
      makeInput({
        items: [item],
        manualDiscount: { type: 'fixed', value: 5 },
        deliveryProduct: { id: 'del', price: 3 },
      }),
    );

    expect(result.discountAmount).toBe(5); // legacy alias
    expect(result.deliveryCharge).toBe(3); // legacy alias
  });

  it('distributes discount proportionally for tax', () => {
    // 60 taxable + 40 non-taxable = 100 total, 10 discount
    const taxable = makeItem({ lineTotal: 60, product: { id: 't', product_type: 'service', is_taxable: true, price: 60, pricing_type: 'quantity' } });
    const nonTaxable = makeItem({ lineTotal: 40, product: { id: 'nt', product_type: 'service', is_taxable: false, price: 40, pricing_type: 'quantity' } });

    const result = calculateTicket(
      makeInput({
        items: [taxable, nonTaxable],
        manualDiscount: { type: 'fixed', value: 10 },
      }),
    );

    // Discount ratio = 10/100 = 0.1
    // Taxable after proportional discount = 60 * (1 - 0.1) = 54
    // Tax = 54 * 0.07 = 3.78
    expect(result.taxAmount).toBeCloseTo(3.78, 2);
  });
});

describe('calculatePromisedDate', () => {
  it('returns tomorrow noon for standard', () => {
    const date = calculatePromisedDate(false);
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    expect(date.getDate()).toBe(tomorrow.getDate());
    expect(date.getHours()).toBe(12);
    expect(date.getMinutes()).toBe(0);
  });

  it('returns today noon for express', () => {
    const date = calculatePromisedDate(true);
    const today = new Date();

    expect(date.getDate()).toBe(today.getDate());
    expect(date.getHours()).toBe(12);
  });

  it('respects custom settings', () => {
    const date = calculatePromisedDate(false, {
      default_completion_days: 3,
      express_completion_days: 1,
      itbms_rate: 7,
    });
    const expected = new Date();
    expected.setDate(expected.getDate() + 3);

    expect(date.getDate()).toBe(expected.getDate());
  });
});
