// Pure money math for the POS payment flow. Everything is computed in integer
// cents so split tenders and change never drift on floating point.

export type TenderType = 'cash' | 'card' | 'other' | 'gift_card' | 'loyalty_points';

export interface Tender {
  /** Stored as payments.payment_method. Special keys: 'cash', 'loyalty_points',
   * 'gift_card'; otherwise the configured method name. */
  method: string;
  methodName: string;
  type: TenderType;
  /** Amount applied to the sale (never exceeds the remaining due). */
  amount: number;
  reference?: string;
  cashTendered?: number;
  changeGiven?: number;
  loyaltyPointsUsed?: number;
  giftCardId?: string;
  giftCardCode?: string;
}

const c = (n: number): number => Math.round((Number(n) || 0) * 100);
const m = (cents: number): number => Math.round(cents) / 100;

/** Sum of amounts applied to the sale. */
export function sumApplied(tenders: Tender[]): number {
  return m(tenders.reduce((s, t) => s + c(t.amount), 0));
}

/** Amount still owed after the accumulated tenders. */
export function remainingDue(total: number, tenders: Tender[]): number {
  return m(Math.max(0, c(total) - tenders.reduce((s, t) => s + c(t.amount), 0)));
}

/** Total cash change handed back across all tenders. */
export function totalChange(tenders: Tender[]): number {
  return m(tenders.reduce((s, t) => s + c(t.changeGiven ?? 0), 0));
}

/** Cash applied toward the due (capped at the due) and the change handed back. */
export function cashSplit(tendered: number, due: number): { applied: number; change: number } {
  const t = c(tendered);
  const d = c(due);
  return { applied: m(Math.min(t, d)), change: m(Math.max(0, t - d)) };
}

/** Caps an entered amount at the remaining due (and an optional ceiling, e.g. a
 * gift-card balance or loyalty balance). */
export function capAmount(amount: number, due: number, ceiling?: number): number {
  let v = Math.min(c(amount), c(due));
  if (ceiling != null) v = Math.min(v, c(ceiling));
  return m(Math.max(0, v));
}

/** The change-given to record for a final, fully-covering cash tender. */
export function buildCashTender(
  methodName: string,
  due: number,
  tendered: number,
): Tender {
  const { change } = cashSplit(tendered, due);
  return {
    method: 'cash',
    methodName,
    type: 'cash',
    amount: due,
    cashTendered: m(Math.max(c(tendered), c(due))),
    changeGiven: change,
  };
}
