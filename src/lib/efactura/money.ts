// Integer-cents money helpers. Electronic invoices must reconcile to the cent,
// so all distribution happens in integer cents and rounding remainders are
// allocated deterministically (largest-remainder method).

export function toCents(amount: number): number {
  return Math.round(amount * 100);
}

export function fromCents(cents: number): number {
  // Avoid binary-float artifacts like 53.50000000000001.
  return Math.round(cents) / 100;
}

export function round2(amount: number): number {
  return Math.round(amount * 100) / 100;
}

/** Rounds to 6 dp — used for unit prices / per-unit discounts so that
 * (precioUnitario − descuento) × cantidad reconstitutes the 2-dp line total. */
export function round6(amount: number): number {
  return Math.round(amount * 1e6) / 1e6;
}

/**
 * Splits `totalCents` across buckets in proportion to `weights`, returning
 * integer cents that sum exactly to `totalCents`. Leftover cents from flooring
 * go to the buckets with the largest fractional remainder.
 *
 * If every weight is zero, the total is placed on the last bucket (so a total
 * with no taxable base still reconciles rather than being silently dropped).
 */
export function distributeCents(totalCents: number, weights: number[]): number[] {
  const n = weights.length;
  if (n === 0) return [];

  const totalWeight = weights.reduce((sum, w) => sum + w, 0);
  if (totalWeight <= 0) {
    const out = new Array<number>(n).fill(0);
    out[n - 1] = totalCents;
    return out;
  }

  const exact = weights.map((w) => (totalCents * w) / totalWeight);
  const floored = exact.map((x) => Math.floor(x));
  let remainder = totalCents - floored.reduce((sum, x) => sum + x, 0);

  const byFraction = exact
    .map((x, i) => ({ i, frac: x - Math.floor(x) }))
    .sort((a, b) => b.frac - a.frac);

  const out = floored.slice();
  for (let k = 0; remainder > 0 && k < byFraction.length; k++, remainder--) {
    out[byFraction[k].i] += 1;
  }
  return out;
}
