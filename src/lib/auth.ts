// Auth user resolution — determines if an auth session belongs to staff or customer

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

function restHeaders(accessToken: string, key: string) {
  return {
    apikey: key,
    Authorization: `Bearer ${accessToken}`,
  };
}

/**
 * Resolve which user (staff or customer) an auth session belongs to.
 * `accessToken` is the session's access token — it MUST be used (not the
 * anon key) so RLS lets the user read their own `users` / `customer_auth`
 * row. Checks staff first, then customer.
 */
export async function resolveAuthUser(
  authId: string,
  email: string,
  accessToken: string,
): Promise<AuthUser | null> {
  if (!accessToken) return null;

  const staff = await lookupStaff(authId, accessToken);
  if (staff) {
    return {
      id: authId,
      email,
      role: staff.role as UserRole,
      isPlatformAdmin: staff.is_platform_admin === true,
      staffProfile: staff,
    };
  }

  const customer = await lookupCustomer(authId, accessToken);
  if (customer) {
    return {
      id: authId,
      email,
      role: 'customer',
      customerProfile: customer,
    };
  }

  return null;
}

async function lookupStaff(
  authId: string,
  accessToken: string,
): Promise<StaffProfile | null> {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key) return null;

  const headers = restHeaders(accessToken, key);

  try {
    // Normal path: the user row is already linked to this auth session.
    if (authId) {
      const response = await fetch(
        `${url}/rest/v1/users?auth_id=eq.${encodeURIComponent(authId)}&select=*`,
        { headers },
      );
      if (response.ok) {
        const data = await response.json();
        if (data?.length > 0) return data[0] as StaffProfile;
      }
    }

    // Legacy staff whose `auth_id` was never set: claim the row by the
    // verified email on the JWT via a SECURITY DEFINER RPC.
    const linkResponse = await fetch(`${url}/rest/v1/rpc/link_staff_account`, {
      method: 'POST',
      headers: { ...headers, 'Content-Type': 'application/json' },
      body: '{}',
    });
    if (linkResponse.ok) {
      const linked = await linkResponse.json();
      if (linked?.length > 0) return linked[0] as StaffProfile;
    }
  } catch {
    // Silently fail — will try customer lookup next
  }

  return null;
}

async function lookupCustomer(
  authId: string,
  accessToken: string,
): Promise<CustomerProfile | null> {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key || !authId) return null;

  const headers = restHeaders(accessToken, key);

  try {
    const response = await fetch(
      `${url}/rest/v1/customer_auth?auth_id=eq.${encodeURIComponent(authId)}&select=id,auth_id,customer_id,store_id,customers(id,first_name,last_name,email,phone,store_id)`,
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
