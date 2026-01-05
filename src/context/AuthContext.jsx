import React, { createContext, useContext, useState, useEffect, useRef } from 'react';
import { supabase } from '../lib/supabase';

const AuthContext = createContext(null);

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
        try {
          const { data, error } = await supabase
            .from('users')
            .select('*')
            .eq('auth_id', session.user.id)
            .maybeSingle();

          if (!error && mounted) {
            setAppUser(data || null);
          }
        } catch (err) {
          console.error('Error loading app user:', err);
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
