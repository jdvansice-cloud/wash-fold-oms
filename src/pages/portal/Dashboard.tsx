import React from 'react';
import { Link } from 'react-router-dom';
import { Truck, Package, Star, User } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { useMyOrders } from '../../hooks/queries/useMyOrders';
import { useCustomerLoyalty, useLoyaltySettings } from '../../hooks/queries/useLoyalty';
import { OrderCard } from '../../components/portal/OrderCard';
import { LoyaltyCard } from '../../components/portal/LoyaltyCard';
import { Spinner } from '../../components/ui/Spinner';

export default function PortalDashboard() {
  const { authUser } = useAuth();
  const customerId = authUser?.customerProfile?.id;
  const storeId = authUser?.customerProfile?.store_id;
  const firstName = authUser?.customerProfile?.first_name || 'Cliente';

  const { data: activeOrders, isLoading: ordersLoading } = useMyOrders(customerId, 'active');
  const { data: loyalty } = useCustomerLoyalty(customerId);
  const { data: loyaltySettings } = useLoyaltySettings(storeId);

  return (
    <div className="space-y-6">
      {/* Greeting */}
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Hola, {firstName}</h1>
        <p className="text-slate-500 text-sm mt-1">Bienvenido a tu portal de lavanderia</p>
      </div>

      {/* Schedule Pickup CTA */}
      <Link
        to="/portal/schedule-pickup"
        className="block bg-gradient-to-r from-primary-500 to-primary-600 rounded-xl p-5 text-white hover:from-primary-600 hover:to-primary-700 transition-all shadow-sm"
      >
        <div className="flex items-center gap-3">
          <div className="bg-white/20 rounded-lg p-2">
            <Truck size={24} />
          </div>
          <div>
            <h3 className="font-semibold text-lg">Programar Recogida</h3>
            <p className="text-primary-100 text-sm">Agenda una recogida a domicilio</p>
          </div>
        </div>
      </Link>

      {/* Loyalty Card */}
      {loyaltySettings && (loyaltySettings.points_enabled || loyaltySettings.punch_card_enabled) && (
        <Link to="/portal/loyalty">
          <LoyaltyCard loyalty={loyalty ?? null} settings={loyaltySettings} compact />
        </Link>
      )}

      {/* Active Orders */}
      <div>
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-lg font-semibold text-slate-900">Pedidos Activos</h2>
          <Link to="/portal/orders" className="text-sm text-primary-600 font-medium hover:underline">
            Ver todos
          </Link>
        </div>

        {ordersLoading ? (
          <div className="flex justify-center py-8">
            <Spinner />
          </div>
        ) : activeOrders && activeOrders.length > 0 ? (
          <div className="space-y-3">
            {activeOrders.slice(0, 3).map((order) => (
              <OrderCard key={order.id} order={order} />
            ))}
            {activeOrders.length > 3 && (
              <Link
                to="/portal/orders"
                className="block text-center text-sm text-primary-600 font-medium py-2 hover:underline"
              >
                Ver {activeOrders.length - 3} mas
              </Link>
            )}
          </div>
        ) : (
          <div className="bg-white rounded-xl border border-slate-200 p-8 text-center">
            <Package size={32} className="mx-auto mb-2 text-slate-300" />
            <p className="text-sm text-slate-500">No tienes pedidos activos</p>
          </div>
        )}
      </div>

      {/* Quick Links */}
      <div className="grid grid-cols-3 gap-3">
        <Link
          to="/portal/orders"
          className="bg-white rounded-xl border border-slate-200 p-4 text-center hover:shadow-card transition-shadow"
        >
          <Package size={20} className="mx-auto mb-1 text-primary-500" />
          <span className="text-xs font-medium text-slate-700">Mis Pedidos</span>
        </Link>
        <Link
          to="/portal/loyalty"
          className="bg-white rounded-xl border border-slate-200 p-4 text-center hover:shadow-card transition-shadow"
        >
          <Star size={20} className="mx-auto mb-1 text-accent-500" />
          <span className="text-xs font-medium text-slate-700">Lealtad</span>
        </Link>
        <Link
          to="/portal/profile"
          className="bg-white rounded-xl border border-slate-200 p-4 text-center hover:shadow-card transition-shadow"
        >
          <User size={20} className="mx-auto mb-1 text-slate-500" />
          <span className="text-xs font-medium text-slate-700">Mi Perfil</span>
        </Link>
      </div>
    </div>
  );
}
