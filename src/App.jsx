import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { useApp } from './context/AppContext';
import { useSupabaseData } from './hooks/useSupabaseData';
import Layout from './components/Layout';
import POSScreen from './pages/POSScreen';
import OrdersPage from './pages/OrdersPage';
import MachinesPage from './pages/MachinesPage';
import CustomersPage from './pages/CustomersPage';
import AnalyticsPage from './pages/AnalyticsPage';
import SettingsPage from './pages/SettingsPage';
import DailyClosingPage from './pages/DailyClosingPage';

function App() {
  const { state } = useApp();
  const { isLoading, error } = useSupabaseData();
  
  // Show loading screen while fetching initial data
  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-primary-200 border-t-primary-500 rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-slate-600 font-medium">Cargando datos...</p>
          <p className="text-slate-400 text-sm mt-1">Conectando con Supabase</p>
        </div>
      </div>
    );
  }
  
  // Show error screen if data loading failed
  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50 p-4">
        <div className="bg-white rounded-2xl shadow-lg p-8 max-w-md w-full text-center">
          <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <span className="text-3xl">⚠️</span>
          </div>
          <h1 className="text-xl font-bold text-slate-800 mb-2">Error de Conexión</h1>
          <p className="text-slate-600 mb-4">{error}</p>
          <div className="text-left bg-slate-50 rounded-lg p-4 text-sm text-slate-600">
            <p className="font-medium mb-2">Verifica que:</p>
            <ul className="list-disc list-inside space-y-1">
              <li>Las variables de entorno estén configuradas</li>
              <li>VITE_SUPABASE_URL</li>
              <li>VITE_SUPABASE_ANON_KEY</li>
              <li>Exista una tienda activa en Supabase</li>
            </ul>
          </div>
          <button 
            onClick={() => window.location.reload()}
            className="mt-6 px-6 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 transition-colors"
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
        <Route path="/closing" element={<DailyClosingPage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  );
}

export default App;
