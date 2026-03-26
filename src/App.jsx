import React, { lazy, Suspense } from 'react';
import { Routes, Route, Navigate, useParams } from 'react-router-dom';
import { useApp } from './context/AppContext';
import { AuthProvider, useAuth } from './context/AuthContext';
import { TenantProvider } from './context/TenantContext';
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
const LandingPage = lazy(() => import('./pages/LandingPage'));
const SignupPage = lazy(() => import('./pages/SignupPage'));

// Portal pages
const CustomerLogin = lazy(() => import('./pages/portal/CustomerLogin'));
const CustomerRegister = lazy(() => import('./pages/portal/CustomerRegister'));
const PortalLayout = lazy(() => import('./components/portal/PortalLayout'));

// Protected Route wrapper (staff)
function ProtectedRoute({ children }) {
  const { slug } = useParams();
  const { user, loading, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Verificando sesion..." />;
  }

  if (!user) {
    return <Navigate to={`/app/${slug}/login`} replace />;
  }

  if (isCustomer) {
    return <Navigate to={`/portal/${slug}`} replace />;
  }

  return children;
}

// Public Route wrapper (redirect if logged in)
function PublicRoute({ children }) {
  const { slug } = useParams();
  const { user, loading, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Cargando..." />;
  }

  if (user) {
    return <Navigate to={isCustomer ? `/portal/${slug}` : `/app/${slug}`} replace />;
  }

  return children;
}

// Portal Protected Route (customer)
function PortalProtectedRoute({ children }) {
  const { slug } = useParams();
  const { user, loading, isCustomer } = useAuth();

  if (loading) {
    return <FullPageSpinner text="Cargando..." />;
  }

  if (!user || !isCustomer) {
    return <Navigate to={`/portal/${slug}/login`} replace />;
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
          <Route path="*" element={<Navigate to="." replace />} />
        </Routes>
      </Suspense>
    </Layout>
  );
}

// Wrapper that provides Tenant + Auth context for slug-based routes
function TenantApp({ children }) {
  return (
    <TenantProvider>
      <AuthProvider>
        {children}
      </AuthProvider>
    </TenantProvider>
  );
}

function App() {
  return (
    <Suspense fallback={<FullPageSpinner />}>
      <Routes>
        {/* Backward-compat redirects for existing users */}
        <Route path="/login" element={<Navigate to="/app/american-laundry/login" replace />} />
        <Route path="/set-password" element={<SetPasswordPage />} />
        <Route path="/forgot-password" element={<ForgotPasswordPage />} />
        <Route path="/portal/login" element={<Navigate to="/portal/american-laundry/login" replace />} />
        <Route path="/portal/register" element={<Navigate to="/portal/american-laundry/register" replace />} />
        <Route path="/portal" element={<Navigate to="/portal/american-laundry" replace />} />

        {/* Staff routes — /app/:slug/* */}
        <Route path="/app/:slug/login" element={
          <TenantApp>
            <PublicRoute>
              <LoginPage />
            </PublicRoute>
          </TenantApp>
        } />
        <Route path="/app/:slug/*" element={
          <TenantApp>
            <ProtectedRoute>
              <AppContent />
            </ProtectedRoute>
          </TenantApp>
        } />

        {/* Portal routes — /portal/:slug/* */}
        <Route path="/portal/:slug/login" element={
          <TenantApp>
            <CustomerLogin />
          </TenantApp>
        } />
        <Route path="/portal/:slug/register" element={
          <TenantApp>
            <CustomerRegister />
          </TenantApp>
        } />
        <Route path="/portal/:slug/*" element={
          <TenantApp>
            <PortalProtectedRoute>
              <PortalLayout />
            </PortalProtectedRoute>
          </TenantApp>
        } />

        {/* Landing page + Signup */}
        <Route path="/" element={<LandingPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Suspense>
  );
}

export default App;
