// Typed re-export of useAuth from AuthContext
// This provides TypeScript consumers with proper types

import { useAuth as useAuthOriginal } from '../context/AuthContext';
import type { AuthUser } from '../lib/auth';

export interface AuthContextValue {
  session: unknown;
  user: unknown;
  appUser: Record<string, unknown> | null;
  authUser: AuthUser | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<unknown>;
  signOut: () => Promise<void>;
  updatePassword: (newPassword: string) => Promise<unknown>;
  inviteUser: (email: string, userData: Record<string, unknown>) => Promise<unknown>;
  isAdmin: boolean;
  isSupervisor: boolean;
  isStaff: boolean;
  isCustomer: boolean;
}

export function useAuth(): AuthContextValue {
  return useAuthOriginal() as AuthContextValue;
}
