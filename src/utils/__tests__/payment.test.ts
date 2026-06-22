import { describe, it, expect } from 'vitest';
import {
  sumApplied,
  remainingDue,
  totalChange,
  cashSplit,
  capAmount,
  buildCashTender,
  type Tender,
} from '../payment';

const t = (over: Partial<Tender>): Tender => ({
  method: 'cash',
  methodName: 'Efectivo',
  type: 'cash',
  amount: 0,
  ...over,
});

describe('payment math', () => {
  it('sums applied amounts without float drift', () => {
    expect(sumApplied([t({ amount: 0.1 }), t({ amount: 0.2 })])).toBe(0.3);
  });

  it('computes remaining due, clamped at zero', () => {
    expect(remainingDue(10.7, [t({ amount: 4 })])).toBe(6.7);
    expect(remainingDue(10.7, [t({ amount: 10.7 })])).toBe(0);
    expect(remainingDue(10.7, [t({ amount: 20 })])).toBe(0);
  });

  it('sums change handed back', () => {
    expect(totalChange([t({ changeGiven: 5.59 }), t({ changeGiven: 0 })])).toBe(5.59);
  });

  it('splits cash into applied + change', () => {
    expect(cashSplit(20, 14.41)).toEqual({ applied: 14.41, change: 5.59 });
    expect(cashSplit(10, 14.41)).toEqual({ applied: 10, change: 0 });
    expect(cashSplit(14.41, 14.41)).toEqual({ applied: 14.41, change: 0 });
  });

  it('caps an amount at the due and an optional ceiling', () => {
    expect(capAmount(100, 14.41)).toBe(14.41);
    expect(capAmount(5, 14.41)).toBe(5);
    expect(capAmount(100, 14.41, 8)).toBe(8); // gift-card balance ceiling
    expect(capAmount(-5, 14.41)).toBe(0);
  });

  it('builds a fully-covering cash tender with change', () => {
    const tender = buildCashTender('Efectivo', 14.41, 20);
    expect(tender).toMatchObject({
      method: 'cash',
      type: 'cash',
      amount: 14.41,
      changeGiven: 5.59,
      cashTendered: 20,
    });
  });

  it('treats exact cash as no change', () => {
    expect(buildCashTender('Efectivo', 14.41, 14.41).changeGiven).toBe(0);
  });
});
