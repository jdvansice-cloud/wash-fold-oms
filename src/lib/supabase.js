import { createClient } from '@supabase/supabase-js'

// Environment variables are exposed via vite.config.js
const supabaseUrl = import.meta.env.SUPABASE_URL
const supabaseKey = import.meta.env.SUPABASE_ANON_KEY

// Debug logging
console.log('=== SUPABASE CLIENT INIT ===')
console.log('URL configured:', !!supabaseUrl)
console.log('Key configured:', !!supabaseKey)
if (supabaseUrl) console.log('URL:', supabaseUrl.substring(0, 30) + '...')

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase environment variables!')
  console.error('SUPABASE_URL:', supabaseUrl ? 'SET' : 'MISSING')
  console.error('SUPABASE_ANON_KEY:', supabaseKey ? 'SET' : 'MISSING')
}

export const supabase = createClient(
  supabaseUrl || 'https://placeholder.supabase.co',
  supabaseKey || 'placeholder-key',
  {
    auth: {
      persistSession: true,
      autoRefreshToken: true,
    },
    global: {
      headers: {
        'x-client-info': 'wash-fold-oms'
      }
    }
  }
)

export const isConfigured = !!(supabaseUrl && supabaseKey)

// Test connectivity function
export const testConnection = async () => {
  console.log('Testing Supabase connection...')
  const startTime = Date.now()
  try {
    const { data, error } = await supabase
      .from('stores')
      .select('count')
      .limit(1)
    
    const elapsed = Date.now() - startTime
    console.log('Connection test completed in', elapsed, 'ms')
    
    if (error) {
      console.error('Connection test error:', error)
      return { success: false, error: error.message, elapsed }
    }
    
    return { success: true, elapsed }
  } catch (err) {
    const elapsed = Date.now() - startTime
    console.error('Connection test exception:', err)
    return { success: false, error: err.message, elapsed }
  }
}

// Get the default store ID (for single-store setup)
export const getDefaultStoreId = async () => {
  const { data, error } = await supabase
    .from('stores')
    .select('id')
    .eq('is_active', true)
    .limit(1)
    .single()
  
  if (error) {
    console.error('Error fetching store:', error)
    return null
  }
  return data?.id
}

// Get the default user (for demo without auth)
export const getDefaultUser = async () => {
  const { data, error } = await supabase
    .from('users')
    .select('*')
    .limit(1)
    .single()
  
  if (error) {
    console.error('Error fetching user:', error)
    return null
  }
  return data
}
