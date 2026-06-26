// Centralized role-based permissions. Roles are hierarchical:
//   operator < supervisor < admin
// Each permission declares the MINIMUM role that holds it; a higher role
// inherits everything below it. This mirrors the server-side helpers
// (auth_is_staff / auth_is_supervisor / auth_is_admin) in supabase-rbac-*.sql —
// the DB is the real enforcement; these gates keep the UI honest.

export type Role = 'admin' | 'supervisor' | 'operator';

export const roleLabels: Record<Role, string> = {
  admin: 'Administrador',
  supervisor: 'Supervisor',
  operator: 'Operador',
};

const RANK: Record<Role, number> = { operator: 1, supervisor: 2, admin: 3 };

export type Permission =
  | 'orders.process' // create / advance / deliver orders
  | 'orders.refund' // reembolsar
  | 'reports.view' // analytics + reports
  | 'eod.close' // run the daily close (cierre)
  | 'eod.editClosed' // edit an already-closed day
  | 'b2b.manage' // B2B billing: generate / collect consolidated invoices
  | 'efactura.void' // anular (void) an authorized electronic invoice
  | 'users.manage' // invite / edit / deactivate staff
  | 'settings.manage'; // company config, payment methods, products, stores…

// Minimum role for each permission.
const MIN_ROLE: Record<Permission, Role> = {
  'orders.process': 'operator',
  'reports.view': 'supervisor',
  'eod.close': 'supervisor',
  'b2b.manage': 'supervisor',
  'orders.refund': 'admin',
  'eod.editClosed': 'admin',
  'efactura.void': 'admin',
  'users.manage': 'admin',
  'settings.manage': 'admin',
};

export function roleCan(role: Role | null | undefined, perm: Permission): boolean {
  if (!role) return false;
  const r = RANK[role];
  return !!r && r >= RANK[MIN_ROLE[perm]];
}
