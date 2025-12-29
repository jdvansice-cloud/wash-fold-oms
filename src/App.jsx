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
  const { isLoading, dataSource, error } = useDataLoader();
  
  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-primary-500 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Cargando datos...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center bg-white p-8 rounded-xl shadow-lg">
          <div className="text-red-500 text-5xl mb-4">⚠️</div>
          <h2 className="text-xl font-semibold text-gray-800 mb-2">Error al cargar</h2>
          <p className="text-gray-600 mb-4">{error}</p>
          <button 
            onClick={() => window.location.reload()} 
            className="px-4 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600"
          >
            Reintentar
          </button>
        </div>
      </div>
    );
  }
  
  return (
    <Layout dataSource={dataSource}>
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
