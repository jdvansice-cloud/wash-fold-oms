import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig(({ mode }) => {
  // Load env file based on mode
  const env = loadEnv(mode, process.cwd(), '')
  
  // Get Supabase vars - check both loadEnv result AND process.env (for Vercel)
  const supabaseUrl = env.SUPABASE_URL || process.env.SUPABASE_URL || ''
  // Prefer the new publishable key; fall back to the legacy anon key during migration.
  const supabasePublishableKey =
    env.SUPABASE_PUBLISHABLE_KEY || process.env.SUPABASE_PUBLISHABLE_KEY || ''
  const supabaseAnonKey = env.SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY || ''
  const supabaseClientKey = supabasePublishableKey || supabaseAnonKey

  console.log('Build environment:', {
    mode,
    hasSupabaseUrl: !!supabaseUrl,
    hasSupabaseKey: !!supabaseClientKey,
    usingPublishableKey: !!supabasePublishableKey,
  })
  
  return {
    plugins: [react()],
    server: {
      port: 3000,
      open: true
    },
    build: {
      rollupOptions: {
        output: {
          // Split rarely-changing vendor libs into cacheable chunks so the main
          // bundle is smaller and the browser can fetch them in parallel.
          manualChunks: {
            'vendor-react': ['react', 'react-dom', 'react-router-dom'],
            'vendor-supabase': ['@supabase/supabase-js'],
            'vendor-query': ['@tanstack/react-query'],
            'vendor-icons': ['lucide-react'],
            'vendor-utils': ['date-fns'],
          },
        },
      },
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
      },
    },
    define: {
      // Expose specific env vars to the client without VITE_ prefix
      'import.meta.env.SUPABASE_URL': JSON.stringify(supabaseUrl),
      // Resolved client key (publishable preferred, anon fallback).
      'import.meta.env.SUPABASE_PUBLISHABLE_KEY': JSON.stringify(supabaseClientKey),
      // Kept for backward compatibility with any remaining references.
      'import.meta.env.SUPABASE_ANON_KEY': JSON.stringify(supabaseAnonKey),
    }
  }
})
