import React from 'react';
import { useLocation } from 'react-router-dom';
import Header from './Header';
import Sidebar from './Sidebar';
import TicketPanel from './TicketPanel';
import { useApp } from '../context/AppContext';

function Layout({ children, dataSource }) {
  const { state, actions } = useApp();
  const location = useLocation();
  
  const isPOSPage = location.pathname === '/';
  
  return (
    <div className="min-h-screen flex flex-col">
      {/* Header */}
      <Header />
      
      {/* Sidebar */}
      <Sidebar 
        isOpen={state.sidebarOpen} 
        onClose={() => actions.toggleSidebar(false)} 
      />
      
      {/* Main Content */}
      <div className="flex flex-1 pt-16">
        {/* Main Area */}
        <main className={`flex-1 ${isPOSPage ? 'mr-96' : ''}`}>
          {children}
        </main>
        
        {/* Ticket Panel - Only visible on POS page */}
        {isPOSPage && (
          <div className="fixed right-0 top-16 bottom-0 w-96">
            <TicketPanel />
          </div>
        )}
      </div>
      
      {/* Data Source Indicator (dev mode) */}
      {dataSource && (
        <div className="fixed bottom-4 left-4 z-50">
          <div className={`px-3 py-1.5 rounded-full text-xs font-medium shadow-lg ${
            dataSource === 'supabase' 
              ? 'bg-emerald-100 text-emerald-700 border border-emerald-200' 
              : 'bg-amber-100 text-amber-700 border border-amber-200'
          }`}>
            {dataSource === 'supabase' ? '🔗 Supabase' : '💾 LocalStorage'}
          </div>
        </div>
      )}
    </div>
  );
}

export default Layout;
