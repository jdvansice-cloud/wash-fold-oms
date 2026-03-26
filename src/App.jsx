import React, { lazy, Suspense } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { useApp } from './context/AppContext';
import { AuthProvider, useAuth } from './context/AuthContext';
import { useDataLoader } from './hooks/useDataLoader';
import Layout from './components/Layout';
import { FullPageSpinner } from './components/ui/Spinner';

// Lazy-loaded pages (code splitting)
const POSScreen = lazy(() => import('./pages/POSScreen'));
const OrdersPage = lazy(() => import('./pages/OrdersPage'));
const MachinesPage = lazy(() => import('./pages/MachinesPage'));
const CustomersPage = lazy(() => import('./pages/CustomersPage'));
const AnalyticsPage = lazy(() => import('./pages/AnalyticsPage'));
const ReportsPage = lazy(() => import('./pages/ReportsPage'));
const SettingsPage = lazy(() => import('./pages/SettingsPage'));
const EODPage = lazy(() => import('./pages/EODPage'));
const PickupsPage = lazy(() => import('./pages/PickupsPage'));
const LoginPage = lazy(() => import('./pages/LoginPage'));
const SetPasswordPage = lazy(() => import('./pages/SetPasswordPage'));
const ForgotPasswordPage = lazy(() => import('./pages/ForgotPasswordPage'));

// Portal pages
const PortalDashboard = lazy(() => import('./pages/portal/Dashboard'));
const CustomerLogin = lazy(() => import('./pages/portal/CustomerLogin'));
const CustomerRegister = lazy(() => import('./pages/portal/CustomerRegister'));
const MyOrders = lazy(() => import('./pages/portal/MyOrders'));
const OrderDetail = lazy(() => import('./pages/portal/OrderDetail'));
const SchedulePickup = lazy(() => import('./pages/portal/SchedulePickup'));
const MyLoyalty = lazy(() => import('./pages/portal/MyLoyalty'));
const MyProfile = lazy(() => import('./pages/portal/MyProfile'));
const PortalLayout = lazy(() => import('./components/portal/PortalLayout'));

// Protected Route wrapper (staff)
function ProtectedRoute({ children }) {
  const { user, loading, isStaff, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Verificando sesion..." />;
  }

  if (!user) {
    return <Navigate to="/login" replace />;
  }

  // Redirect customers away from staff routes
  if (isCustomer) {
    return <Navigate to="/portal" replace />;
  }

  return children;
}

// Public Route wrapper (redirect if logged in)
function PublicRoute({ children }) {
  const { user, loading, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Cargando..." />;
  }

  if (user) {
    // Route customers to portal, staff to POS
    return <Navigate to={isCustomer ? '/portal' : '/'} replace />;
  }

  return children;
}

// Portal Protected Route (customer)
function PortalProtectedRoute({ children }) {
  const { user, loading, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Cargando..." />;
  }

  if (!user || !isCustomer) {
    return <Navigate to="/portal/login" replace />;
  }

  return children;
}

function AppContent() {
  const { state } = useApp();
  const { isLoading, error, reload } = useDataLoader();

  if (isLoading) {
    return <FullPageSpinner text="Conectando con Supabase..." />;
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <div className="bg-white p-8 rounded-2xl shadow-lg max-w-md w-full text-center">
          <div className="text-red-500 text-6xl mb-4">
            {error.type === 'config' ? '⚙️' : error.type === 'data' ? '📭' : '🔌'}
          </div>
          <h2 className="text-xl font-semibold text-gray-800 mb-2">{error.message}</h2>
          <p className="text-gray-600 mb-6">{error.details}</p>

          {error.type === 'config' && (
            <div className="bg-gray-50 rounded-xl p-4 mb-6 text-left">
              <p className="text-sm font-medium text-gray-700 mb-2">Variables requeridas en Vercel:</p>
              <code className="block text-xs bg-gray-100 p-2 rounded mb-1">SUPABASE_URL</code>
              <code className="block text-xs bg-gray-100 p-2 rounded">SUPABASE_ANON_KEY</code>
            </div>
          )}

          {error.type === 'data' && (
            <div className="bg-amber-50 rounded-xl p-4 mb-6 text-left">
              <p className="text-sm text-amber-800">
                Ejecuta el archivo <code className="bg-amber-100 px-1 rounded">supabase-schema.sql</code> en el SQL Editor de Supabase para crear las tablas y datos iniciales.
              </p>
            </div>
          )}

          <button
            onClick={reload}
            className="px-6 py-3 bg-primary-500 text-white rounded-xl hover:bg-primary-600 transition-colors font-medium"
          >
            Reintentar
          </button>
        </div>
      </div>
    );
  }

  return (
    <Layout>
      <Suspense fallback={<FullPageSpinner />}>
        <Routes>
          <Route path="/" element={<POSScreen />} />
          <Route path="/orders" element={<OrdersPage />} />
          <Route path="/machines" element={<MachinesPage />} />
          <Route path="/pickups" element={<PickupsPage />} />
          <Route path="/customers" element={<CustomersPage />} />
          <Route path="/analytics" element={<AnalyticsPage />} />
          <Route path="/reports" element={<ReportsPage />} />
          <Route path="/eod" element={<EODPage />} />
          <Route path="/settings" element={<SettingsPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Suspense>
    </Layout>
  );
}

function App() {
  return (
    <AuthProvider>
      <Suspense fallback={<FullPageSpinner />}>
        <Routes>
          {/* Public routes */}
          <Route path="/login" element={
            <PublicRoute>
              <LoginPage />
            </PublicRoute>
          } />
          <Route path="/set-password" element={<SetPasswordPage />} />
          <Route path="/forgot-password" element={<ForgotPasswordPage />} />

          {/* Portal public routes (MUST be before /portal/* wildcard) */}
          <Route path="/portal/login" element={<CustomerLogin />} />
          <Route path="/portal/register" element={<CustomerRegister />} />

          {/* Portal protected routes (customer-facing) */}
          <Route path="/portal/*" element={
            <PortalProtectedRoute>
              <PortalLayout />
            </PortalProtectedRoute>
          } />

          {/* Staff routes */}
          <Route path="/*" element={
            <ProtectedRoute>
              <AppContent />
            </ProtectedRoute>
          } />
        </Routes>
      </Suspense>
    </AuthProvider>
  );
}

export default App;
