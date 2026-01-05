import { createClient } from '@supabase/supabase-js'

// Environment variables are exposed via vite.config.js
const supabaseUrl = import.meta.env.SUPABASE_URL
const supabaseKey = import.meta.env.SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase environment variables!')
  console.error('Please set SUPABASE_URL and SUPABASE_ANON_KEY in Vercel')
}

export const supabase = createClient(
  supabaseUrl || 'https://placeholder.supabase.co',
  supabaseKey || 'placeholder-key'
)

export const isConfigured = !!(supabaseUrl && supabaseKey)

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
