import { supabase } from './supabase';

/**
 * PostgREST headers whose Authorization bearer is the logged-in STAFF session
 * token — not the anon publishable key. RLS scopes every tenant row by the
 * user's company/store via auth_* helpers, so any RLS-protected read or write
 * MUST use this: with the bare anon key PostgREST runs as `anon` and the query
 * returns/writes nothing (silently). Falls back to the anon key only pre-login.
 */
export async function restHeaders(extra = {}) {
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  let token = key;
  try {
    const { data: { session } } = await supabase.auth.getSession();
    if (session?.access_token) token = session.access_token;
  } catch {
    /* pre-login: fall back to the anon key */
  }
  return { apikey: key, Authorization: `Bearer ${token}`, ...extra };
}
