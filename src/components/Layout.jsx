import React from 'react';
import { useLocation } from 'react-router-dom';
import Header from './Header';
import Sidebar from './Sidebar';
import TicketPanel from './TicketPanel';
import { useApp } from '../context/AppContext';

function Layout({ children }) {
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
    </div>
  );
}

export default Layout;
