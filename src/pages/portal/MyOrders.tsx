import React, { useState } from 'react';
import { useAuth } from '../../hooks/useAuth';
import { useMyOrders } from '../../hooks/queries/useMyOrders';
import { OrderCard } from '../../components/portal/OrderCard';
import { Spinner } from '../../components/ui/Spinner';
import { Package } from 'lucide-react';

export default function MyOrders() {
  const [tab, setTab] = useState<'active' | 'completed'>('active');
  const { authUser } = useAuth();
  const customerId = authUser?.customerProfile?.id;

  const { data: orders, isLoading } = useMyOrders(customerId, tab);

  return (
    <div className="space-y-4">
      <h1 className="text-xl font-bold text-slate-900">Mis Pedidos</h1>

      {/* Tabs */}
      <div className="flex bg-slate-100 rounded-lg p-1">
        <button
          onClick={() => setTab('active')}
          className={`flex-1 py-2 text-sm font-medium rounded-md transition-colors ${
            tab === 'active' ? 'bg-white text-slate-900 shadow-sm' : 'text-slate-500'
          }`}
        >
          Activas
        </button>
        <button
          onClick={() => setTab('completed')}
          className={`flex-1 py-2 text-sm font-medium rounded-md transition-colors ${
            tab === 'completed' ? 'bg-white text-slate-900 shadow-sm' : 'text-slate-500'
          }`}
        >
          Completadas
        </button>
      </div>

      {/* Orders List */}
      {isLoading ? (
        <div className="flex justify-center py-12">
          <Spinner />
        </div>
      ) : orders && orders.length > 0 ? (
        <div className="space-y-3">
          {orders.map((order) => (
            <OrderCard key={order.id} order={order} />
          ))}
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-slate-200 p-12 text-center">
          <Package size={40} className="mx-auto mb-3 text-slate-300" />
          <p className="text-slate-500">
            {tab === 'active' ? 'No tienes pedidos activos' : 'No tienes pedidos completados'}
          </p>
        </div>
      )}
    </div>
  );
}
