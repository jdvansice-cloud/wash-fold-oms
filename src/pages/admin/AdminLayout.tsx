import React, { lazy, Suspense } from 'react';
import { Routes, Route, NavLink, useNavigate, Navigate } from 'react-router-dom';
import { LayoutDashboard, Building2, CreditCard, Users, Settings, LogOut, Shield } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { Spinner } from '../../components/ui/Spinner';

const AdminDashboard = lazy(() => import('./AdminDashboard'));
const AdminCompanies = lazy(() => import('./AdminCompanies'));
const AdminCompanyDetail = lazy(() => import('./AdminCompanyDetail'));

const navItems = [
  { to: '/admin', icon: LayoutDashboard, label: 'Dashboard', end: true },
  { to: '/admin/companies', icon: Building2, label: 'Empresas' },
];

export default function AdminLayout() {
  const { user, appUser, signOut } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await signOut();
    navigate('/admin/login', { replace: true });
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Top Header */}
      <header className="fixed top-0 left-0 right-0 h-14 bg-slate-900 text-white z-40 flex items-center justify-between px-6">
        <div className="flex items-center gap-3">
          <Shield size={20} className="text-amber-400" />
          <span className="font-bold text-lg tracking-tight">WashPro Admin</span>
        </div>
        <div className="flex items-center gap-4">
          <span className="text-sm text-slate-300">{appUser?.full_name || user?.email}</span>
          <button
            onClick={handleLogout}
            className="flex items-center gap-1.5 text-sm text-slate-400 hover:text-white transition-colors"
          >
            <LogOut size={16} />
            Salir
          </button>
        </div>
      </header>

      <div className="flex pt-14">
        {/* Sidebar */}
        <aside className="fixed left-0 top-14 bottom-0 w-56 bg-white border-r border-slate-200 py-4">
          <nav className="space-y-1 px-3">
            {navItems.map((item) => (
              <NavLink
                key={item.to}
                to={item.to}
                end={item.end}
                className={({ isActive }) =>
                  `flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${
                    isActive
                      ? 'bg-slate-900 text-white'
                      : 'text-slate-600 hover:bg-slate-100'
                  }`
                }
              >
                <item.icon size={18} />
                {item.label}
              </NavLink>
            ))}
          </nav>
        </aside>

        {/* Main Content */}
        <main className="ml-56 flex-1 p-6 min-h-[calc(100vh-3.5rem)]">
          <Suspense fallback={<div className="flex justify-center py-20"><Spinner /></div>}>
            <Routes>
              <Route index element={<AdminDashboard />} />
              <Route path="companies" element={<AdminCompanies />} />
              <Route path="companies/:companyId" element={<AdminCompanyDetail />} />
              <Route path="*" element={<Navigate to="/admin" replace />} />
            </Routes>
          </Suspense>
        </main>
      </div>
    </div>
  );
}
