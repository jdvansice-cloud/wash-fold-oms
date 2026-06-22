import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Banknote, CreditCard, Gift, Award, Wallet, X } from 'lucide-react';
import { supabase } from '../../lib/supabase';
import {
  sumApplied,
  remainingDue,
  totalChange,
  cashSplit,
  capAmount,
  buildCashTender,
} from '../../utils/payment';

// Quick-add cash denominations (Balboa / USD), largest first.
const DENOMS = [100, 50, 20, 10, 5, 1, 0.25, 0.1];

const DEFAULT_METHODS = [
  { id: 'default-cash', name: 'Efectivo', payment_type: 'cash' },
  { id: 'default-card', name: 'Tarjeta', payment_type: 'card' },
];

const fmt = (n) => `B/${(Number(n) || 0).toFixed(2)}`;

/**
 * Multi-tender POS payment flow (ported from the Mimosa platform).
 * Methods come from the store's configured payment methods; their payment_type
 * selects the screen (cash / card / other). Gift card and loyalty-points are
 * built-in tenders layered on top.
 */
function PaymentModal({
  total,
  subtotal,
  taxAmount,
  paymentMethods = [],
  storeId,
  customerLoyalty = null,
  loyaltySettings = null,
  freeServicesApplied = null,
  onClose,
  onComplete,
}) {
  const [tenders, setTenders] = useState([]);
  const [selected, setSelected] = useState(null); // { id?, name, payment_type } | { special: 'gift_card'|'loyalty' }
  const [processing, setProcessing] = useState(false);
  const cashInputRef = useRef(null);

  // Per-form inputs
  const [cashTendered, setCashTendered] = useState('');
  const [amount, setAmount] = useState('');
  const [reference, setReference] = useState('');
  const [note, setNote] = useState('');
  const [gcCode, setGcCode] = useState('');
  const [gc, setGc] = useState(null); // { id, code, balance }
  const [gcError, setGcError] = useState(null);
  const [gcLoading, setGcLoading] = useState(false);

  const paid = sumApplied(tenders);
  const remaining = remainingDue(total, tenders);
  const change = totalChange(tenders);

  // Available methods: configured (or a sane default), then built-ins.
  const methods = paymentMethods.length ? paymentMethods : DEFAULT_METHODS;

  const availablePoints = customerLoyalty?.points_balance || 0;
  const minRedemption = loyaltySettings?.min_redemption_amount || 5;
  const canUseLoyalty =
    !!loyaltySettings?.points_enabled &&
    availablePoints >= minRedemption &&
    !tenders.some((t) => t.type === 'loyalty_points');

  useEffect(() => {
    if (selected?.payment_type === 'cash') cashInputRef.current?.focus();
  }, [selected]);

  function resetForms() {
    setCashTendered('');
    setAmount('');
    setReference('');
    setNote('');
    setGcCode('');
    setGc(null);
    setGcError(null);
  }

  function selectMethod(m) {
    setSelected(m);
    resetForms();
    if (m.payment_type === 'card' || m.payment_type === 'other') {
      setAmount(remaining.toFixed(2));
    } else if (m.special === 'loyalty') {
      setAmount(Math.min(remaining, availablePoints).toFixed(2));
    }
  }

  function addTender(tender) {
    setTenders((t) => [...t, tender]);
    setSelected(null);
    resetForms();
  }

  const removeTender = (i) => setTenders((t) => t.filter((_, x) => x !== i));

  // --- Cash ---
  const cash = cashSplit(cashTendered, remaining);
  const isCash = selected?.payment_type === 'cash';
  const cashFull = isCash && remaining > 0 && (Number(cashTendered) || 0) >= remaining;
  const cashPartial = isCash && (Number(cashTendered) || 0) > 0 && (Number(cashTendered) || 0) < remaining;

  function addCashPartial() {
    const applied = capAmount(cashTendered, remaining);
    if (applied <= 0) return;
    addTender({ method: 'cash', methodName: selected.name, type: 'cash', amount: applied, changeGiven: 0 });
  }

  // --- Card / Other (generic amount) ---
  const isAmount = selected?.payment_type === 'card' || selected?.payment_type === 'other';
  const amtApplied = capAmount(amount, remaining);
  const amtFull = isAmount && remaining > 0 && amtApplied >= remaining;
  const amtPartial = isAmount && amtApplied > 0 && amtApplied < remaining;

  function addAmount() {
    if (amtApplied <= 0 || !selected) return;
    addTender({
      method: selected.payment_type === 'cash' ? 'cash' : selected.name,
      methodName: selected.name,
      type: selected.payment_type,
      amount: amtApplied,
      reference: reference.trim() || undefined,
    });
  }

  // --- Gift card ---
  const isGift = selected?.special === 'gift_card';
  const gcAppliedCap = gc ? capAmount(amount, remaining, gc.balance) : 0;
  const gcFull = isGift && !!gc && remaining > 0 && gcAppliedCap >= remaining;
  const gcPartial = isGift && !!gc && gcAppliedCap > 0 && gcAppliedCap < remaining;

  async function lookupGiftCard() {
    setGcError(null);
    setGcLoading(true);
    try {
      const { data, error } = await supabase
        .from('gift_cards')
        .select('id, code, current_balance, is_active, expires_at')
        .eq('code', gcCode.trim())
        .eq('store_id', storeId)
        .maybeSingle();
      if (error || !data) {
        setGcError('Tarjeta no encontrada');
        return;
      }
      if (!data.is_active) {
        setGcError('Tarjeta inactiva');
        return;
      }
      if (data.expires_at && new Date(data.expires_at) < new Date()) {
        setGcError('Tarjeta vencida');
        return;
      }
      if ((data.current_balance || 0) <= 0) {
        setGcError('Tarjeta sin saldo');
        return;
      }
      setGc({ id: data.id, code: data.code, balance: data.current_balance });
      setAmount(Math.min(data.current_balance, remaining).toFixed(2));
    } finally {
      setGcLoading(false);
    }
  }

  function addGift() {
    if (!gc) return;
    const applied = capAmount(amount, remaining, gc.balance);
    if (applied <= 0) return;
    addTender({
      method: 'gift_card',
      methodName: `Tarjeta Regalo ${gc.code}`,
      type: 'gift_card',
      amount: applied,
      reference: gc.code,
      giftCardId: gc.id,
      giftCardCode: gc.code,
    });
  }

  // --- Loyalty points ---
  const isLoyalty = selected?.special === 'loyalty';
  const loyaltyApplied = capAmount(amount, remaining, availablePoints);
  const loyaltyOk = loyaltyApplied >= minRedemption;
  const loyaltyFull = isLoyalty && remaining > 0 && loyaltyApplied >= remaining && loyaltyOk;
  const loyaltyPartial = isLoyalty && loyaltyOk && loyaltyApplied < remaining;

  function addLoyalty() {
    if (!loyaltyOk) return;
    addTender({
      method: 'loyalty_points',
      methodName: 'Puntos de Lealtad',
      type: 'loyalty_points',
      amount: loyaltyApplied,
      loyaltyPointsUsed: loyaltyApplied,
    });
  }

  // --- Completion ---
  const canComplete =
    (remaining === 0 && tenders.length > 0) || cashFull || amtFull || gcFull || loyaltyFull;

  function complete() {
    let finalTenders = [...tenders];
    if (cashFull) {
      finalTenders.push(buildCashTender(selected.name, remaining, Number(cashTendered) || 0));
    } else if (amtFull && selected) {
      finalTenders.push({
        method: selected.payment_type === 'cash' ? 'cash' : selected.name,
        methodName: selected.name,
        type: selected.payment_type,
        amount: remaining,
        reference: reference.trim() || undefined,
      });
    } else if (gcFull && gc) {
      finalTenders.push({
        method: 'gift_card',
        methodName: `Tarjeta Regalo ${gc.code}`,
        type: 'gift_card',
        amount: remaining,
        reference: gc.code,
        giftCardId: gc.id,
        giftCardCode: gc.code,
      });
    } else if (loyaltyFull) {
      finalTenders.push({
        method: 'loyalty_points',
        methodName: 'Puntos de Lealtad',
        type: 'loyalty_points',
        amount: remaining,
        loyaltyPointsUsed: remaining,
      });
    }

    setProcessing(true);
    onComplete({
      payments: finalTenders,
      totalPaid: sumApplied(finalTenders),
      change: totalChange(finalTenders),
      timestamp: new Date().toISOString(),
      freeServicesApplied,
    });
  }

  const iconFor = (m) =>
    m.special === 'gift_card' ? Gift
    : m.special === 'loyalty' ? Award
    : m.payment_type === 'cash' ? Banknote
    : m.payment_type === 'card' ? CreditCard
    : Wallet;

  const gridMethods = useMemo(() => {
    const list = methods.map((m) => ({
      ...m,
      payment_type: m.payment_type || 'other',
      key: m.id || m.name,
    }));
    list.push({ key: 'gift_card', name: 'Tarjeta Regalo', special: 'gift_card' });
    if (canUseLoyalty) list.push({ key: 'loyalty', name: 'Puntos de Lealtad', special: 'loyalty' });
    return list;
  }, [methods, canUseLoyalty]);

  const isSelected = (m) => selected && (selected.key === m.key);

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center pt-16 px-4 pb-4 animate-fade-in" onClick={onClose}>
      <div className="absolute inset-0 bg-black/50" />
      <div
        className="relative bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[calc(100vh-5rem)] flex flex-col animate-scale-in"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex flex-shrink-0 items-center justify-between border-b border-slate-100 p-4">
          <h2 className="text-lg font-semibold text-slate-800">Cobrar</h2>
          <button onClick={onClose} className="rounded-lg p-2 text-slate-400 hover:bg-slate-100">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Pinned summary */}
        <div className="flex-shrink-0 border-b border-slate-100 p-4">
          <div className="rounded-xl bg-slate-50 p-4">
            <div className="mb-1 flex items-center justify-between">
              <span className="text-sm text-slate-500">Total a pagar</span>
              <span className="text-2xl font-bold text-slate-800">{fmt(total)}</span>
            </div>
            {tenders.length > 0 && (
              <>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-slate-500">Pagado</span>
                  <span className="font-medium text-emerald-600">{fmt(paid)}</span>
                </div>
                <div className="mt-2 flex items-center justify-between border-t border-slate-200 pt-2 text-sm">
                  <span className="font-medium text-slate-600">{remaining > 0 ? 'Restante' : 'Cambio'}</span>
                  <span className={`text-lg font-bold ${remaining > 0 ? 'text-red-600' : 'text-emerald-600'}`}>
                    {fmt(remaining > 0 ? remaining : change)}
                  </span>
                </div>
              </>
            )}
          </div>

          {tenders.length > 0 && (
            <div className="mt-3 max-h-40 space-y-2 overflow-y-auto">
              {tenders.map((t, i) => (
                <div key={i} className="flex items-center justify-between rounded-lg border border-slate-200 bg-slate-50 px-3 py-2">
                  <span className="text-sm font-medium text-slate-700">
                    {t.methodName}
                    {t.reference ? <span className="ml-2 text-xs text-slate-400">#{t.reference}</span> : null}
                    {(t.changeGiven ?? 0) > 0 ? <span className="ml-2 text-xs text-slate-400">cambio {fmt(t.changeGiven)}</span> : null}
                  </span>
                  <span className="flex items-center gap-2">
                    <span className="font-semibold text-slate-700">{fmt(t.amount)}</span>
                    <button onClick={() => removeTender(i)} className="text-slate-400 hover:text-red-500">
                      <X className="w-4 h-4" />
                    </button>
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Body */}
        <div className="flex-1 overflow-y-auto p-4">
          {remaining > 0 && (
            <>
              <p className="mb-2 text-xs font-semibold uppercase tracking-wide text-slate-400">
                {tenders.length > 0 ? 'Agregar otro pago' : 'Método de pago'}
              </p>
              <div className="mb-4 grid grid-cols-3 gap-2">
                {gridMethods.map((m) => {
                  const Icon = iconFor(m);
                  return (
                    <button
                      key={m.key}
                      onClick={() => selectMethod(m)}
                      className={`flex flex-col items-center gap-1 rounded-xl border-2 px-3 py-3 text-sm font-medium transition ${
                        isSelected(m)
                          ? 'border-primary-500 bg-primary-50 text-primary-700'
                          : 'border-slate-200 text-slate-600 hover:border-primary-300'
                      }`}
                    >
                      <Icon className="w-5 h-5" />
                      <span className="text-xs text-center leading-tight">{m.name}</span>
                    </button>
                  );
                })}
              </div>

              {/* Cash */}
              {isCash && (
                <div className="rounded-xl bg-slate-50 p-4">
                  <div className="mb-3 flex items-center justify-between">
                    <span className="text-sm text-slate-500">Total a cobrar</span>
                    <span className="text-lg font-semibold text-slate-800">{fmt(remaining)}</span>
                  </div>
                  <p className="mb-2 text-xs font-medium text-slate-500">Efectivo recibido</p>
                  <div className="mb-3 grid grid-cols-4 gap-1">
                    {DENOMS.map((d) => (
                      <button
                        key={d}
                        onClick={() => setCashTendered((((Number(cashTendered) || 0) + d)).toFixed(2))}
                        className="rounded border border-slate-200 bg-white py-2 text-xs font-medium text-slate-600 hover:border-primary-300 hover:bg-primary-50"
                      >
                        +{d}
                      </button>
                    ))}
                  </div>
                  <div className="flex items-center justify-between rounded-lg border border-slate-200 bg-white px-3 py-2">
                    <span className="text-sm text-slate-500">Recibido</span>
                    <span className="flex items-center gap-2">
                      <span className="text-sm text-slate-400">B/.</span>
                      <input
                        ref={cashInputRef}
                        type="number"
                        step="0.01"
                        value={cashTendered}
                        onChange={(e) => setCashTendered(e.target.value)}
                        placeholder="0.00"
                        className="w-28 rounded border border-slate-200 px-2 py-1 text-right outline-none focus:border-primary-500"
                      />
                      {cashTendered && (
                        <button onClick={() => setCashTendered('')} className="text-xs text-slate-400 hover:text-slate-600">✕</button>
                      )}
                    </span>
                  </div>
                  <div className="mt-3 text-center">
                    <p className="text-xs uppercase tracking-wide text-slate-400">Cambio</p>
                    <p className="text-3xl font-bold text-emerald-600">{fmt(cash.change)}</p>
                  </div>
                  {cashPartial && (
                    <button onClick={addCashPartial} className="btn-primary w-full mt-3">
                      Agregar {fmt(cash.applied)} al ticket
                    </button>
                  )}
                  {cashFull && (
                    <p className="mt-3 text-center text-xs text-slate-400">Presiona “Cobrar” abajo para completar.</p>
                  )}
                </div>
              )}

              {/* Card / Other */}
              {isAmount && (
                <div className="rounded-xl bg-slate-50 p-4">
                  <div className="mb-3 flex items-center justify-between">
                    <span className="text-sm text-slate-500">Total a cobrar</span>
                    <span className="text-lg font-semibold text-slate-800">{fmt(remaining)}</span>
                  </div>
                  <label className="mb-1 block text-xs text-slate-500">Monto ({selected.name})</label>
                  <div className="relative mb-3">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">B/.</span>
                    <input
                      type="number"
                      step="0.01"
                      value={amount}
                      onChange={(e) => setAmount(e.target.value)}
                      placeholder={remaining.toFixed(2)}
                      className="input pl-10"
                    />
                  </div>
                  <label className="mb-1 block text-xs text-slate-500">Referencia / confirmación (opcional)</label>
                  <input
                    value={reference}
                    onChange={(e) => setReference(e.target.value)}
                    placeholder="Ej. 123456"
                    className="input"
                  />
                  {amtPartial && (
                    <button onClick={addAmount} className="btn-primary w-full mt-3">
                      Agregar {fmt(amtApplied)} al ticket
                    </button>
                  )}
                  {amtFull && (
                    <p className="mt-3 text-center text-xs text-slate-400">Presiona “Cobrar” abajo para completar.</p>
                  )}
                </div>
              )}

              {/* Gift card */}
              {isGift && (
                <div className="rounded-xl bg-slate-50 p-4">
                  {!gc ? (
                    <>
                      <label className="mb-1 block text-xs text-slate-500">Código de la tarjeta</label>
                      <div className="flex gap-2">
                        <input
                          value={gcCode}
                          onChange={(e) => setGcCode(e.target.value)}
                          placeholder="Código…"
                          className="input"
                        />
                        <button onClick={lookupGiftCard} disabled={!gcCode.trim() || gcLoading} className="btn-secondary whitespace-nowrap">
                          {gcLoading ? '…' : 'Buscar'}
                        </button>
                      </div>
                      {gcError && <p className="mt-1 text-xs text-red-600">{gcError}</p>}
                    </>
                  ) : (
                    <>
                      <div className="mb-2 flex items-center justify-between text-sm">
                        <span className="text-slate-500">Total a cobrar</span>
                        <span className="text-lg font-semibold text-slate-800">{fmt(remaining)}</span>
                      </div>
                      <p className="mb-2 text-sm text-slate-600">
                        Tarjeta {gc.code} · saldo <span className="font-semibold">{fmt(gc.balance)}</span>
                      </p>
                      <label className="mb-1 block text-xs text-slate-500">Monto a aplicar</label>
                      <div className="relative">
                        <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">B/.</span>
                        <input
                          type="number"
                          step="0.01"
                          value={amount}
                          onChange={(e) => setAmount(e.target.value)}
                          className="input pl-10"
                        />
                      </div>
                      {gcPartial && (
                        <button onClick={addGift} className="btn-primary w-full mt-3">
                          Agregar {fmt(gcAppliedCap)} al ticket
                        </button>
                      )}
                      {gcFull && (
                        <p className="mt-3 text-center text-xs text-slate-400">Presiona “Cobrar” abajo para completar.</p>
                      )}
                    </>
                  )}
                </div>
              )}

              {/* Loyalty */}
              {isLoyalty && (
                <div className="rounded-xl bg-slate-50 p-4">
                  <p className="mb-2 text-sm text-slate-600">
                    Puntos disponibles: <span className="font-semibold">{fmt(availablePoints)}</span>
                    <span className="text-xs text-slate-400"> · mínimo {fmt(minRedemption)}</span>
                  </p>
                  <label className="mb-1 block text-xs text-slate-500">Monto a usar</label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">B/.</span>
                    <input
                      type="number"
                      step="0.01"
                      value={amount}
                      onChange={(e) => setAmount(e.target.value)}
                      className="input pl-10"
                    />
                  </div>
                  {!loyaltyOk && (Number(amount) || 0) > 0 && (
                    <p className="mt-1 text-xs text-amber-600">El mínimo es {fmt(minRedemption)}</p>
                  )}
                  {loyaltyPartial && (
                    <button onClick={addLoyalty} className="btn-primary w-full mt-3">
                      Agregar {fmt(loyaltyApplied)} al ticket
                    </button>
                  )}
                  {loyaltyFull && (
                    <p className="mt-3 text-center text-xs text-slate-400">Presiona “Cobrar” abajo para completar.</p>
                  )}
                </div>
              )}
            </>
          )}

          {remaining === 0 && tenders.length > 0 && (
            <div className="rounded-xl bg-emerald-50 p-4 text-center">
              <p className="text-sm text-emerald-700">Pago completo.</p>
              {change > 0 && <p className="mt-1 text-2xl font-bold text-emerald-600">Cambio {fmt(change)}</p>}
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex-shrink-0 border-t border-slate-100 p-4">
          <button onClick={complete} disabled={!canComplete || processing} className="btn-primary w-full py-4 text-base disabled:opacity-50 disabled:cursor-not-allowed">
            {processing ? 'Procesando…' : canComplete ? `Cobrar ${fmt(total)}` : `Faltan ${fmt(remaining)}`}
          </button>
        </div>
      </div>
    </div>
  );
}

export default PaymentModal;
