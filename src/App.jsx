import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { useApp } from './context/AppContext';
import { useDataLoader } from './hooks/useDataLoader';
import Layout from './components/Layout';
import POSScreen from './pages/POSScreen';
import OrdersPage from './pages/OrdersPage';
import MachinesPage from './pages/MachinesPage';
import CustomersPage from './pages/CustomersPage';
import AnalyticsPage from './pages/AnalyticsPage';
import SettingsPage from './pages/SettingsPage';

function AppContent() {
  const { state } = useApp();
  const { isLoading, error, reload } = useDataLoader();
  
  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-primary-500 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Conectando con Supabase...</p>
        </div>
      </div>
    );
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
      <Routes>
        <Route path="/" element={<POSScreen />} />
        <Route path="/orders" element={<OrdersPage />} />
        <Route path="/machines" element={<MachinesPage />} />
        <Route path="/customers" element={<CustomersPage />} />
        <Route path="/analytics" element={<AnalyticsPage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  );
}

function App() {
  return <AppContent />;
}

export default App;
