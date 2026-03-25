import React, { lazy, Suspense } from 'react';
import { Routes, Route, NavLink, useNavigate, Navigate } from 'react-router-dom';
import { Package, Truck, Star, User, LogOut } from 'lucide-react';
import { useAuth } from '../../hooks/useAuth';
import { Spinner } from '../ui/Spinner';

const Dashboard = lazy(() => import('../../pages/portal/Dashboard'));
const MyOrders = lazy(() => import('../../pages/portal/MyOrders'));
const OrderDetail = lazy(() => import('../../pages/portal/OrderDetail'));
const SchedulePickup = lazy(() => import('../../pages/portal/SchedulePickup'));
const MyLoyalty = lazy(() => import('../../pages/portal/MyLoyalty'));
const MyProfile = lazy(() => import('../../pages/portal/MyProfile'));

const navItems = [
  { to: '/portal', icon: Package, label: 'Inicio', end: true },
  { to: '/portal/orders', icon: Package, label: 'Pedidos' },
  { to: '/portal/schedule-pickup', icon: Truck, label: 'Recoger' },
  { to: '/portal/loyalty', icon: Star, label: 'Lealtad' },
  { to: '/portal/profile', icon: User, label: 'Perfil' },
];

export default function PortalLayout() {
  const { authUser, signOut } = useAuth();
  const navigate = useNavigate();
  const customerName = authUser?.customerProfile
    ? `${authUser.customerProfile.first_name} ${authUser.customerProfile.last_name || ''}`.trim()
    : 'Cliente';

  const handleSignOut = async () => {
    await signOut();
    navigate('/portal/login');
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col">
      {/* Desktop Header */}
      <header className="bg-white border-b border-slate-200 hidden md:block">
        <div className="max-w-5xl mx-auto px-4 h-16 flex items-center justify-between">
          <div className="flex items-center gap-8">
            <h1 className="text-lg font-bold text-primary-600">American Laundry</h1>
            <nav className="flex items-center gap-1">
              {navItems.map(({ to, label, end }) => (
                <NavLink
                  key={to}
                  to={to}
                  end={end}
                  className={({ isActive }) =>
                    `px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                      isActive
                        ? 'bg-primary-50 text-primary-700'
                        : 'text-slate-600 hover:bg-slate-100'
                    }`
                  }
                >
                  {label}
                </NavLink>
              ))}
            </nav>
          </div>
          <div className="flex items-center gap-3">
            <span className="text-sm text-slate-600">{customerName}</span>
            <button
              onClick={handleSignOut}
              className="p-2 rounded-lg hover:bg-slate-100 text-slate-500 transition-colors"
              title="Cerrar sesion"
            >
              <LogOut size={18} />
            </button>
          </div>
        </div>
      </header>

      {/* Mobile Header */}
      <header className="bg-white border-b border-slate-200 md:hidden">
        <div className="px-4 h-14 flex items-center justify-between">
          <h1 className="text-base font-bold text-primary-600">American Laundry</h1>
          <div className="flex items-center gap-2">
            <span className="text-sm text-slate-600">{authUser?.customerProfile?.first_name}</span>
            <button
              onClick={handleSignOut}
              className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-500"
            >
              <LogOut size={16} />
            </button>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="flex-1 pb-20 md:pb-8">
        <div className="max-w-5xl mx-auto px-4 py-6">
          <Suspense fallback={<div className="flex justify-center py-12"><Spinner /></div>}>
            <Routes>
              <Route index element={<Dashboard />} />
              <Route path="orders" element={<MyOrders />} />
              <Route path="orders/:id" element={<OrderDetail />} />
              <Route path="schedule-pickup" element={<SchedulePickup />} />
              <Route path="loyalty" element={<MyLoyalty />} />
              <Route path="profile" element={<MyProfile />} />
              <Route path="*" element={<Navigate to="/portal" replace />} />
            </Routes>
          </Suspense>
        </div>
      </main>

      {/* Mobile Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-200 md:hidden z-40">
        <div className="flex items-center justify-around h-16">
          {navItems.map(({ to, icon: Icon, label, end }) => (
            <NavLink
              key={to}
              to={to}
              end={end}
              className={({ isActive }) =>
                `flex flex-col items-center gap-0.5 px-3 py-1 rounded-lg transition-colors ${
                  isActive ? 'text-primary-600' : 'text-slate-400'
                }`
              }
            >
              <Icon size={20} />
              <span className="text-[10px] font-medium">{label}</span>
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  );
}
