import React, { createContext, useContext, useState, useEffect, useRef } from 'react';
import { supabase } from '../lib/supabase';
import { resolveAuthUser } from '../lib/auth';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [session, setSession] = useState(null);
  const [user, setUser] = useState(null); // Raw Supabase auth user
  const [authUser, setAuthUser] = useState(null); // Resolved AuthUser (staff or customer)
  const [loading, setLoading] = useState(true);
  const initializedRef = useRef(false);

  useEffect(() => {
    let mounted = true;

    // Timeout to prevent infinite loading
    const timeout = setTimeout(() => {
      if (mounted && loading) {
        console.warn('Auth loading timeout - forcing completion');
        setLoading(false);
      }
    }, 2000);

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (!mounted) return;

      setSession(session);
      setUser(session?.user ?? null);

      if (session?.user) {
        const resolved = await resolveAuthUser(session.user.id, session.user.email);
        if (mounted) {
          setAuthUser(resolved);
        }
      } else {
        setAuthUser(null);
      }

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

  // Legacy password login (kept for backward compat, e.g. set-password flow)
  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) throw error;
    return data;
  };

  // OTP: send magic code to email
  const signInWithOtp = async (email) => {
    const { data, error } = await supabase.auth.signInWithOtp({ email });
    if (error) throw error;
    return data;
  };

  // OTP: verify the 6-digit code
  const verifyOtp = async (email, token) => {
    const { data, error } = await supabase.auth.verifyOtp({
      email,
      token,
      type: 'email',
    });
    if (error) throw error;
    return data;
  };

  const signOut = async () => {
    try {
      setSession(null);
      setUser(null);
      setAuthUser(null);
      const { error } = await supabase.auth.signOut();
      if (error) console.error('Supabase signOut error:', error);
    } catch (err) {
      console.error('SignOut exception:', err);
      setSession(null);
      setUser(null);
      setAuthUser(null);
    }
  };

  const updatePassword = async (newPassword) => {
    const { data, error } = await supabase.auth.updateUser({ password: newPassword });
    if (error) throw error;
    return data;
  };

  const inviteUser = async (email, userData) => {
    const { data, error } = await supabase.auth.admin.inviteUserByEmail(email, {
      data: { full_name: userData.full_name, role: userData.role },
      redirectTo: `${window.location.origin}/set-password`,
    });

    if (error) {
      // Fallback: sign up + password reset
      const tempPassword = crypto.randomUUID();
      const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
        email,
        password: tempPassword,
        options: {
          data: { full_name: userData.full_name, role: userData.role },
          emailRedirectTo: `${window.location.origin}/set-password`,
        },
      });
      if (signUpError) throw signUpError;

      const { error: resetError } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/set-password`,
      });
      if (resetError) console.warn('Reset email error:', resetError);

      return signUpData;
    }
    return data;
  };

  const value = {
    // Raw Supabase session (legacy compat)
    session,
    user,

    // Legacy compat: appUser = staff profile from users table
    appUser: authUser?.staffProfile ?? null,

    // New unified auth user
    authUser,

    loading,
    signIn,
    signInWithOtp,
    verifyOtp,
    signOut,
    updatePassword,
    inviteUser,

    // Role checks — legacy compat (staff roles)
    isAdmin: authUser?.role === 'admin',
    isSupervisor: authUser?.role === 'supervisor' || authUser?.role === 'admin',

    // New role checks
    isStaff: authUser ? authUser.role !== 'customer' : false,
    isCustomer: authUser?.role === 'customer',
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
