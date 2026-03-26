import React, { createContext, useContext, useState, useEffect, useRef, useMemo } from 'react';
import { useLocation } from 'react-router-dom';
import { supabaseStaff, supabasePortal } from '../lib/supabase';
import { resolveAuthUser } from '../lib/auth';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const location = useLocation();
  const [session, setSession] = useState(null);
  const [user, setUser] = useState(null);
  const [authUser, setAuthUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const initializedRef = useRef(false);

  // Determine which client to use based on current route
  const isPortalRoute = location.pathname.startsWith('/portal');
  const activeClient = isPortalRoute ? supabasePortal : supabaseStaff;

  // Stable ref so the subscription callback always sees the current client
  const clientRef = useRef(activeClient);
  clientRef.current = activeClient;

  // Subscribe to BOTH clients to detect sessions on either side
  useEffect(() => {
    let mounted = true;

    const timeout = setTimeout(() => {
      if (mounted && loading) {
        setLoading(false);
      }
    }, 4000);

    const handleAuthChange = async (_event, session) => {
      if (!mounted) return;

      setSession(session);
      setUser(session?.user ?? null);

      if (session?.user) {
        const resolved = await resolveAuthUser(session.user.id, session.user.email);
        if (mounted) setAuthUser(resolved);
      } else {
        setAuthUser(null);
      }

      if (mounted) {
        setLoading(false);
        initializedRef.current = true;
      }
    };

    // Subscribe to staff auth changes
    const { data: { subscription: staffSub } } = supabaseStaff.auth.onAuthStateChange(
      (event, sess) => {
        // Only process if we're on a staff route
        if (!location.pathname.startsWith('/portal')) {
          handleAuthChange(event, sess);
        }
      }
    );

    // Subscribe to portal auth changes
    const { data: { subscription: portalSub } } = supabasePortal.auth.onAuthStateChange(
      (event, sess) => {
        // Only process if we're on a portal route
        if (location.pathname.startsWith('/portal')) {
          handleAuthChange(event, sess);
        }
      }
    );

    // Also check current session for the active client on mount
    activeClient.auth.getSession().then(({ data: { session } }) => {
      if (mounted) handleAuthChange('INITIAL_SESSION', session);
    });

    return () => {
      mounted = false;
      clearTimeout(timeout);
      staffSub.unsubscribe();
      portalSub.unsubscribe();
    };
  }, [isPortalRoute]);

  // Auth methods — use the correct client based on route
  const signIn = async (email, password) => {
    const { data, error } = await activeClient.auth.signInWithPassword({ email, password });
    if (error) throw error;
    return data;
  };

  const signInWithOtp = async (email) => {
    const { data, error } = await activeClient.auth.signInWithOtp({ email });
    if (error) throw error;
    return data;
  };

  const verifyOtp = async (email, token) => {
    const { data, error } = await activeClient.auth.verifyOtp({
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
      // Sign out from the active client only
      const { error } = await activeClient.auth.signOut();
      if (error) console.error('Supabase signOut error:', error);
    } catch (err) {
      console.error('SignOut exception:', err);
      setSession(null);
      setUser(null);
      setAuthUser(null);
    }
  };

  const updatePassword = async (newPassword) => {
    const { data, error } = await activeClient.auth.updateUser({ password: newPassword });
    if (error) throw error;
    return data;
  };

  const inviteUser = async (email, userData) => {
    const { data, error } = await supabaseStaff.auth.admin.inviteUserByEmail(email, {
      data: { full_name: userData.full_name, role: userData.role },
      redirectTo: `${window.location.origin}/set-password`,
    });

    if (error) {
      const tempPassword = crypto.randomUUID();
      const { data: signUpData, error: signUpError } = await supabaseStaff.auth.signUp({
        email,
        password: tempPassword,
        options: {
          data: { full_name: userData.full_name, role: userData.role },
          emailRedirectTo: `${window.location.origin}/set-password`,
        },
      });
      if (signUpError) throw signUpError;

      const { error: resetError } = await supabaseStaff.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/set-password`,
      });
      if (resetError) console.warn('Reset email error:', resetError);

      return signUpData;
    }
    return data;
  };

  const value = {
    session,
    user,
    appUser: authUser?.staffProfile ?? null,
    authUser,
    loading,
    signIn,
    signInWithOtp,
    verifyOtp,
    signOut,
    updatePassword,
    inviteUser,
    // Expose active client for components that need direct access
    supabase: activeClient,
    isAdmin: authUser?.role === 'admin',
    isSupervisor: authUser?.role === 'supervisor' || authUser?.role === 'admin',
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
