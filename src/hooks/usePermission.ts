import { useAuth } from '../context/AuthContext';
import { roleCan, type Permission, type Role } from '../utils/permissions';

/**
 * Role-based UI gating. `can(permission)` is the single source of truth for
 * showing/hiding actions; prefer it over ad-hoc `role === 'admin'` checks.
 *
 *   const { can, isAdmin } = usePermission();
 *   if (can('orders.refund')) { … }
 */
export function usePermission() {
  // AuthContext is untyped JS; appUser carries the staff profile with `role`.
  const auth = useAuth() as { appUser?: { role?: string } | null };
  const role = ((auth?.appUser?.role as Role) || null);
  return {
    role,
    can: (perm: Permission) => roleCan(role, perm),
    isAdmin: role === 'admin',
    isSupervisor: role === 'admin' || role === 'supervisor',
  };
}
