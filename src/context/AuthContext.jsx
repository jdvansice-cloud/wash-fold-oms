import React, { createContext, useContext, useState, useEffect, useRef } from 'react';
import { supabase } from '../lib/supabase';

const AuthContext = createContext(null);

// Raw fetch helper for user lookup
const fetchAppUser = async (authId, email) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
  if (!url || !key) return null;
  
  try {
    // First try by auth_id
    if (authId) {
      console.log('Fetching app user for auth_id:', authId);
      const response = await fetch(`${url}/rest/v1/users?auth_id=eq.${authId}&select=*`, {
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        console.log('App user lookup by auth_id result:', data);
        
        if (data && data.length > 0) {
          return data[0];
        }
      }
    }
    
    // Fallback: try by email
    if (email) {
      console.log('Fallback: Fetching app user for email:', email);
      const response = await fetch(`${url}/rest/v1/users?email=eq.${encodeURIComponent(email)}&select=*`, {
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        console.log('App user lookup by email result:', data);
        
        if (data && data.length > 0) {
          // Update the user's auth_id if it's missing
          const foundUser = data[0];
          if (!foundUser.auth_id && authId) {
            console.log('Updating user auth_id...');
            await fetch(`${url}/rest/v1/users?id=eq.${foundUser.id}`, {
              method: 'PATCH',
              headers: {
                'apikey': key,
                'Authorization': `Bearer ${key}`,
                'Content-Type': 'application/json',
                'Prefer': 'return=representation'
              },
              body: JSON.stringify({ auth_id: authId })
            });
            foundUser.auth_id = authId;
          }
          return foundUser;
        }
      }
    }
    
    console.log('No app user found for auth_id:', authId, 'or email:', email);
    return null;
  } catch (err) {
    console.error('Error fetching app user:', err);
    return null;
  }
};

export function AuthProvider({ children }) {
  const [session, setSession] = useState(null);
  const [user, setUser] = useState(null);
  const [appUser, setAppUser] = useState(null); // User from our users table
  const [loading, setLoading] = useState(true);
  const initializedRef = useRef(false);

  useEffect(() => {
    let mounted = true;
    
    // Timeout to prevent infinite loading (2 seconds)
    const timeout = setTimeout(() => {
      if (mounted && loading) {
        console.warn('Auth loading timeout - forcing completion');
        setLoading(false);
      }
    }, 2000);

    // Listen for auth changes - this fires immediately with current session
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (!mounted) return;
      
      console.log('Auth event:', event, session?.user?.email);
      
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        // Use raw fetch to get app user (try auth_id first, then email)
        const userData = await fetchAppUser(session.user.id, session.user.email);
        if (mounted) {
          console.log('Setting appUser:', userData);
          setAppUser(userData);
        }
      } else {
        setAppUser(null);
      }
      
      // Only set loading false after we've processed the session
      if (mounted) {
        setLoading(false);
        initializedRef.current = true;
      }
    });

    return () => {
      mounted = false;
      clearTimeout(timeout);
      subscription.unsubscribe();
    };
  }, []);

  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (error) throw error;
    return data;
  };

  const signOut = async () => {
    try {
      // Clear local state first
      setSession(null);
      setUser(null);
      setAppUser(null);
      
      // Then sign out from Supabase
      const { error } = await supabase.auth.signOut();
      if (error) {
        console.error('Supabase signOut error:', error);
      }
    } catch (err) {
      console.error('SignOut exception:', err);
      setSession(null);
      setUser(null);
      setAppUser(null);
    }
  };

  const updatePassword = async (newPassword) => {
    const { data, error } = await supabase.auth.updateUser({
      password: newPassword
    });
    if (error) throw error;
    return data;
  };

  // Invite a new user (admin only)
  const inviteUser = async (email, userData) => {
    // First, create the invite via Supabase Auth
    const { data, error } = await supabase.auth.admin.inviteUserByEmail(email, {
      data: {
        full_name: userData.full_name,
        role: userData.role,
      },
      redirectTo: `${window.location.origin}/set-password`
    });

    if (error) {
      // If admin API fails, try using the edge function approach or manual invite
      const tempPassword = crypto.randomUUID();
      const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
        email,
        password: tempPassword,
        options: {
          data: {
            full_name: userData.full_name,
            role: userData.role,
          },
          emailRedirectTo: `${window.location.origin}/set-password`
        }
      });

      if (signUpError) throw signUpError;

      // Send password reset email so user can set their password
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/set-password`
      });

      if (resetError) console.warn('Reset email error:', resetError);

      return signUpData;
    }

    return data;
  };

  const value = {
    session,
    user,
    appUser,
    loading,
    signIn,
    signOut,
    updatePassword,
    inviteUser,
    isAdmin: appUser?.role === 'admin',
    isSupervisor: appUser?.role === 'supervisor' || appUser?.role === 'admin',
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
