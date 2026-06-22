import React, { useState, useRef, useEffect } from 'react';
import { Gift, X, CreditCard, Check, AlertTriangle } from 'lucide-react';
import { supabaseStaff as supabase } from '../../lib/supabase';

export default function GiftCardActivationModal({ product, storeId, onConfirm, onClose }) {
  const [code, setCode] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [existingCard, setExistingCard] = useState(null);
  const inputRef = useRef(null);
  const amount = product?.price || 0;

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  // Look up card as user types (debounced on submit, not on every keystroke)
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!code.trim() || !storeId) return;

    setLoading(true);
    setError(null);

    try {
      const cardCode = code.trim().toUpperCase();

      // Check if card already exists
      const url = import.meta.env.SUPABASE_URL;
      const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
      const headers = { apikey: key, Authorization: `Bearer ${key}`, 'Content-Type': 'application/json', Prefer: 'return=representation' };

      const lookupRes = await fetch(
        `${url}/rest/v1/gift_cards?code=eq.${encodeURIComponent(cardCode)}&select=*`,
        { headers }
      );
      const existing = await lookupRes.json();

      if (existing && existing.length > 0) {
        // Card exists — top up
        const card = existing[0];
        if (!card.is_active) {
          setError('Esta tarjeta esta inactiva.');
          setLoading(false);
          return;
        }

        const newBalance = parseFloat(card.current_balance) + amount;

        // Update balance
        await fetch(`${url}/rest/v1/gift_cards?id=eq.${card.id}`, {
          method: 'PATCH',
          headers,
          body: JSON.stringify({
            current_balance: newBalance,
            updated_at: new Date().toISOString(),
          }),
        });

        // Record transaction
        await fetch(`${url}/rest/v1/gift_card_transactions`, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            gift_card_id: card.id,
            amount: amount,
            transaction_type: 'credit',
            balance_after: newBalance,
            notes: `Recarga desde POS - ${product.name}`,
          }),
        });

        setExistingCard({ ...card, current_balance: newBalance, wasTopUp: true });
      } else {
        // New card — create it
        const createRes = await fetch(`${url}/rest/v1/gift_cards`, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            store_id: storeId,
            code: cardCode,
            initial_value: amount,
            current_balance: amount,
            card_type: 'fixed',
            is_active: true,
          }),
        });

        if (!createRes.ok) {
          const err = await createRes.json();
          throw new Error(err.message || 'Error creating gift card');
        }

        const [newCard] = await createRes.json();

        // Record transaction
        await fetch(`${url}/rest/v1/gift_card_transactions`, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            gift_card_id: newCard.id,
            amount: amount,
            transaction_type: 'credit',
            balance_after: amount,
            notes: `Activacion nueva tarjeta - ${product.name}`,
          }),
        });

        setExistingCard({ ...newCard, wasTopUp: false });
      }

      // Add product to ticket
      onConfirm(cardCode);
    } catch (err) {
      console.error('Gift card activation error:', err);
      setError(err.message || 'Error al procesar la tarjeta');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4" onClick={onClose}>
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-sm" onClick={(e) => e.stopPropagation()}>
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <Gift className="w-5 h-5 text-purple-500" />
            <h2 className="text-lg font-semibold text-slate-800">Activar Gift Card</h2>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg">
            <X size={18} className="text-slate-400" />
          </button>
        </div>

        <div className="p-5 space-y-4">
          {/* Product Info */}
          <div className="bg-purple-50 rounded-xl p-4 text-center">
            <p className="text-sm text-purple-600 font-medium">{product?.name}</p>
            <p className="text-2xl font-bold text-purple-800 mt-1">B/{amount.toFixed(2)}</p>
          </div>

          {/* Success State */}
          {existingCard ? (
            <div className="space-y-3">
              <div className="flex items-center gap-2 p-3 bg-emerald-50 border border-emerald-200 rounded-xl">
                <Check size={18} className="text-emerald-600" />
                <div>
                  <p className="text-sm font-medium text-emerald-800">
                    {existingCard.wasTopUp ? 'Recarga exitosa' : 'Tarjeta activada'}
                  </p>
                  <p className="text-xs text-emerald-600">
                    Codigo: {existingCard.code} — Balance: B/{parseFloat(existingCard.current_balance).toFixed(2)}
                  </p>
                </div>
              </div>
              <p className="text-xs text-slate-400 text-center">
                El producto se agrego al ticket
              </p>
            </div>
          ) : (
            /* Code Entry Form */
            <form onSubmit={handleSubmit} className="space-y-3">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  Codigo de la tarjeta
                </label>
                <div className="relative">
                  <CreditCard size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
                  <input
                    ref={inputRef}
                    type="text"
                    value={code}
                    onChange={(e) => setCode(e.target.value.toUpperCase())}
                    placeholder="Escanear o escribir codigo"
                    className="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-xl text-sm font-mono tracking-wider uppercase focus:outline-none focus:ring-2 focus:ring-purple-500/20 focus:border-purple-400"
                    maxLength={30}
                    autoComplete="off"
                  />
                </div>
                <p className="text-xs text-slate-400 mt-1">
                  Si la tarjeta ya existe, se le agregara el monto como recarga
                </p>
              </div>

              {error && (
                <div className="flex items-center gap-2 p-3 bg-red-50 border border-red-200 rounded-xl">
                  <AlertTriangle size={14} className="text-red-500 shrink-0" />
                  <p className="text-sm text-red-700">{error}</p>
                </div>
              )}

              <button
                type="submit"
                disabled={loading || !code.trim()}
                className="w-full py-3 bg-purple-600 text-white rounded-xl text-sm font-medium hover:bg-purple-700 disabled:opacity-50 flex items-center justify-center gap-2 transition-colors"
              >
                {loading ? (
                  <span className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                ) : (
                  <Gift size={16} />
                )}
                {loading ? 'Procesando...' : 'Activar y Agregar al Ticket'}
              </button>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
