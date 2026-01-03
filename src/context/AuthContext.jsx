import React, { createContext, useContext, useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [session, setSession] = useState(null);
  const [user, setUser] = useState(null);
  const [appUser, setAppUser] = useState(null); // User from our users table
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      setUser(session?.user ?? null);
      if (session?.user) {
        loadAppUser(session.user.id);
      } else {
        setLoading(false);
      }
    });

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth event:', event);
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        await loadAppUser(session.user.id);
      } else {
        setAppUser(null);
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const loadAppUser = async (authId) => {
    try {
      const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('auth_id', authId)
        .single();

      if (error && error.code !== 'PGRST116') {
        console.error('Error loading app user:', error);
      }
      setAppUser(data || null);
    } catch (err) {
      console.error('Error loading app user:', err);
    } finally {
      setLoading(false);
    }
  };

  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (error) throw error;
    return data;
  };

  const signOut = async () => {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
    setAppUser(null);
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
      // For now, we'll use signUp with a random password and send reset email
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
