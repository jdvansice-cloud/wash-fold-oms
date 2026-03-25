import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig(({ mode }) => {
  // Load env file based on mode
  const env = loadEnv(mode, process.cwd(), '')
  
  // Get Supabase vars - check both loadEnv result AND process.env (for Vercel)
  const supabaseUrl = env.SUPABASE_URL || process.env.SUPABASE_URL || ''
  const supabaseAnonKey = env.SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY || ''
  
  console.log('Build environment:', {
    mode,
    hasSupabaseUrl: !!supabaseUrl,
    hasSupabaseKey: !!supabaseAnonKey,
  })
  
  return {
    plugins: [react()],
    server: {
      port: 3000,
      open: true
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
      },
    },
    define: {
      // Expose specific env vars to the client without VITE_ prefix
      'import.meta.env.SUPABASE_URL': JSON.stringify(supabaseUrl),
      'import.meta.env.SUPABASE_ANON_KEY': JSON.stringify(supabaseAnonKey),
    }
  }
})
