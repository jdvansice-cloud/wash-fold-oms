// Auth user resolution — determines if an auth session belongs to staff or customer
import { supabaseStaff as supabase } from './supabase';

export type UserRole = 'admin' | 'supervisor' | 'operator' | 'customer';

export interface StaffProfile {
  id: string;
  full_name: string;
  initials?: string;
  email: string;
  role: 'admin' | 'supervisor' | 'operator';
  store_id: string;
  company_id?: string;
  is_active: boolean;
  is_platform_admin?: boolean;
  avatar_url?: string;
}

export interface CustomerProfile {
  id: string;
  customer_auth_id: string;
  first_name: string;
  last_name?: string;
  email?: string;
  phone?: string;
  store_id: string;
}

export interface AuthUser {
  id: string; // Supabase auth.uid()
  email: string;
  role: UserRole;
  isPlatformAdmin?: boolean;
  staffProfile?: StaffProfile;
  customerProfile?: CustomerProfile;
}

/**
 * Resolve which user (staff or customer) an auth session belongs to.
 * Checks `users` table first (staff), then `customer_auth` table (customer).
 */
export async function resolveAuthUser(
  authId: string,
  email: string,
): Promise<AuthUser | null> {
  // 1. Try staff lookup by auth_id
  const staffByAuthId = await lookupStaff(authId, email);
  if (staffByAuthId) {
    return {
      id: authId,
      email,
      role: staffByAuthId.role as UserRole,
      isPlatformAdmin: staffByAuthId.is_platform_admin === true,
      staffProfile: staffByAuthId,
    };
  }

  // 2. Try customer lookup by auth_id
  const customerByAuthId = await lookupCustomer(authId);
  if (customerByAuthId) {
    return {
      id: authId,
      email,
      role: 'customer',
      customerProfile: customerByAuthId,
    };
  }

  return null;
}

async function lookupStaff(authId: string, email: string): Promise<StaffProfile | null> {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  if (!url || !key) return null;

  const headers = {
    apikey: key,
    Authorization: `Bearer ${key}`,
  };

  try {
    // Try by auth_id first
    if (authId) {
      const response = await fetch(`${url}/rest/v1/users?auth_id=eq.${authId}&select=*`, {
        headers,
      });
      if (response.ok) {
        const data = await response.json();
        if (data?.length > 0) return data[0] as StaffProfile;
      }
    }

    // Fallback by email
    if (email) {
      const response = await fetch(
        `${url}/rest/v1/users?email=eq.${encodeURIComponent(email)}&select=*`,
        { headers },
      );
      if (response.ok) {
        const data = await response.json();
        if (data?.length > 0) {
          const user = data[0];
          // Link auth_id if missing
          if (!user.auth_id && authId) {
            await fetch(`${url}/rest/v1/users?id=eq.${user.id}`, {
              method: 'PATCH',
              headers: { ...headers, 'Content-Type': 'application/json', Prefer: 'return=representation' },
              body: JSON.stringify({ auth_id: authId }),
            });
            user.auth_id = authId;
          }
          return user as StaffProfile;
        }
      }
    }
  } catch {
    // Silently fail — will try customer lookup next
  }

  return null;
}

async function lookupCustomer(authId: string): Promise<CustomerProfile | null> {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  if (!url || !key) return null;

  const headers = {
    apikey: key,
    Authorization: `Bearer ${key}`,
  };

  try {
    // Fetch customer_auth with joined customer data
    const response = await fetch(
      `${url}/rest/v1/customer_auth?auth_id=eq.${authId}&select=id,auth_id,customer_id,store_id,customers(id,first_name,last_name,email,phone,store_id)`,
      { headers },
    );

    if (!response.ok) return null;
    const data = await response.json();
    if (!data?.length) return null;

    const row = data[0];
    const customer = row.customers;
    if (!customer) return null;

    return {
      id: customer.id,
      customer_auth_id: row.id,
      first_name: customer.first_name,
      last_name: customer.last_name,
      email: customer.email,
      phone: customer.phone,
      store_id: customer.store_id,
    };
  } catch {
    return null;
  }
}
