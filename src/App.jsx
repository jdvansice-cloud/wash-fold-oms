import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { useApp } from './context/AppContext';
import Layout from './components/Layout';
import POSScreen from './pages/POSScreen';
import OrdersPage from './pages/OrdersPage';
import MachinesPage from './pages/MachinesPage';
import CustomersPage from './pages/CustomersPage';

function App() {
  const { state } = useApp();
  
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<POSScreen />} />
        <Route path="/orders" element={<OrdersPage />} />
        <Route path="/machines" element={<MachinesPage />} />
        <Route path="/customers" element={<CustomersPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  );
}

export default App;
