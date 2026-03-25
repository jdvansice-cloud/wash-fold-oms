import React from 'react';
import { useAuth } from '../../hooks/useAuth';
import { useCustomerLoyalty, useLoyaltySettings, useLoyaltyTransactions } from '../../hooks/queries/useLoyalty';
import { LoyaltyCard } from '../../components/portal/LoyaltyCard';
import { Spinner } from '../../components/ui/Spinner';
import { formatCurrency, formatDate } from '../../utils/formatters';

const transactionLabels: Record<string, string> = {
  punch_wash: 'Sello lavado',
  punch_dry: 'Sello secado',
  free_wash_earned: 'Lavado gratis ganado',
  free_dry_earned: 'Secado gratis ganado',
  redeem_free_wash: 'Lavado gratis usado',
  redeem_free_dry: 'Secado gratis usado',
  points_earned: 'Puntos ganados',
  points_redeemed: 'Puntos canjeados',
  points_expired: 'Puntos expirados',
  punches_expired: 'Sellos expirados',
  manual_adjustment: 'Ajuste manual',
};

export default function MyLoyalty() {
  const { authUser } = useAuth();
  const customerId = authUser?.customerProfile?.id;
  const storeId = authUser?.customerProfile?.store_id;

  const { data: loyalty, isLoading: loyaltyLoading } = useCustomerLoyalty(customerId);
  const { data: settings, isLoading: settingsLoading } = useLoyaltySettings(storeId);
  const { data: transactions, isLoading: txLoading } = useLoyaltyTransactions(customerId);

  const isLoading = loyaltyLoading || settingsLoading;

  if (isLoading) {
    return (
      <div className="flex justify-center py-12">
        <Spinner />
      </div>
    );
  }

  if (!settings || (!settings.points_enabled && !settings.punch_card_enabled)) {
    return (
      <div className="text-center py-12">
        <p className="text-slate-500">El programa de lealtad no esta disponible en este momento.</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h1 className="text-xl font-bold text-slate-900">Mi Lealtad</h1>

      <LoyaltyCard loyalty={loyalty ?? null} settings={settings} />

      {/* Transaction History */}
      {settings.points_enabled && (
        <div className="bg-white rounded-xl border border-slate-200">
          <div className="px-4 py-3 border-b border-slate-100">
            <h2 className="text-sm font-semibold text-slate-900">Historial de Transacciones</h2>
          </div>

          {txLoading ? (
            <div className="flex justify-center py-8">
              <Spinner size="sm" />
            </div>
          ) : transactions && transactions.length > 0 ? (
            <div className="divide-y divide-slate-100">
              {transactions.map((tx) => (
                <div key={tx.id} className="px-4 py-3 flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-slate-900">
                      {transactionLabels[tx.transaction_type] || tx.transaction_type}
                    </p>
                    <p className="text-xs text-slate-400">{formatDate(tx.created_at)}</p>
                  </div>
                  <div className="text-right">
                    {tx.points_amount !== 0 && (
                      <p
                        className={`text-sm font-medium ${
                          tx.points_amount > 0 ? 'text-emerald-600' : 'text-red-600'
                        }`}
                      >
                        {tx.points_amount > 0 ? '+' : ''}
                        {formatCurrency(tx.points_amount)}
                      </p>
                    )}
                    {tx.punch_count !== 0 && (
                      <p className="text-xs text-slate-500">
                        {tx.punch_count > 0 ? '+' : ''}
                        {tx.punch_count} sello(s)
                      </p>
                    )}
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="p-8 text-center text-sm text-slate-400">
              No hay transacciones todavia
            </div>
          )}
        </div>
      )}
    </div>
  );
}
