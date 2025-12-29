import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.SUPABASE_URL
const supabaseKey = import.meta.env.SUPABASE_ANON_KEY

// Check if Supabase is configured
export const isSupabaseConfigured = !!(supabaseUrl && supabaseKey)

// Create client only if configured
export const supabase = isSupabaseConfigured 
  ? createClient(supabaseUrl, supabaseKey)
  : null

// Helper to check connection
export const checkConnection = async () => {
  if (!supabase) return { connected: false, error: 'Supabase not configured' }
  
  try {
    const { error } = await supabase.from('companies').select('id').limit(1)
    if (error) throw error
    return { connected: true, error: null }
  } catch (error) {
    return { connected: false, error: error.message }
  }
}
