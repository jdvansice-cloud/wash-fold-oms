import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import App from './App'
import { AppProvider } from './context/AppContext'
import { ToastProvider } from './components/Toast'
import { queryClient } from './lib/queryClient'
import './index.css'

// One-time cleanup: remove old shared Supabase auth key that caused session conflicts
// between staff and customer portals. Each now uses its own storage key.
const OLD_KEY_PREFIX = 'sb-';
const OLD_KEY_SUFFIX = '-auth-token';
for (let i = localStorage.length - 1; i >= 0; i--) {
  const key = localStorage.key(i);
  if (
    key &&
    key.startsWith(OLD_KEY_PREFIX) &&
    key.endsWith(OLD_KEY_SUFFIX) &&
    key !== 'sb-staff-auth-token' &&
    key !== 'sb-portal-auth-token'
  ) {
    localStorage.removeItem(key);
  }
}

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        <AppProvider>
          <ToastProvider>
            <App />
          </ToastProvider>
        </AppProvider>
      </BrowserRouter>
      <ReactQueryDevtools initialIsOpen={false} />
    </QueryClientProvider>
  </React.StrictMode>,
)
