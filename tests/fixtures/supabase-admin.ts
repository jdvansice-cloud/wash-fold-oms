import { CONFIG } from './test-config';

const { SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY } = CONFIG;

/**
 * Admin API helper — uses service_role key to bypass RLS and manage auth.
 */
async function adminFetch(path: string, options: RequestInit = {}) {
  const res = await fetch(`${SUPABASE_URL}${path}`, {
    ...options,
    headers: {
      apikey: SUPABASE_SERVICE_ROLE_KEY,
      Authorization: `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
      'Content-Type': 'application/json',
      ...(options.headers || {}),
    },
  });
  return res;
}

/**
 * Create a Supabase Auth user (or return existing) and get an access token.
 */
export async function createAuthUser(email: string, password: string = 'TestPassword123!') {
  // Try to create user via admin API
  const createRes = await adminFetch('/auth/v1/admin/users', {
    method: 'POST',
    body: JSON.stringify({
      email,
      password,
      email_confirm: true,
    }),
  });

  let userId: string;

  if (createRes.ok) {
    const user = await createRes.json();
    userId = user.id;
  } else {
    // User might already exist — find them
    const listRes = await adminFetch(`/auth/v1/admin/users?page=1&per_page=50`);
    const { users } = await listRes.json();
    const existing = users?.find((u: any) => u.email === email);
    if (existing) {
      userId = existing.id;
      // Update password to ensure we can log in
      await adminFetch(`/auth/v1/admin/users/${existing.id}`, {
        method: 'PUT',
        body: JSON.stringify({ password, email_confirm: true }),
      });
    } else {
      throw new Error(`Failed to create or find auth user: ${email}`);
    }
  }

  return userId;
}

/**
 * Generate a valid session (access_token + refresh_token) for a user via password login.
 */
export async function getSession(email: string, password: string = 'TestPassword123!') {
  const res = await fetch(`${SUPABASE_URL}/auth/v1/token?grant_type=password`, {
    method: 'POST',
    headers: {
      apikey: CONFIG.SUPABASE_ANON_KEY || SUPABASE_SERVICE_ROLE_KEY,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ email, password }),
  });

  if (!res.ok) {
    const err = await res.text();
    throw new Error(`Failed to get session for ${email}: ${err}`);
  }

  return res.json();
}

/**
 * Ensure a staff user exists in both auth and users table.
 */
export async function ensureStaffUser(storeId?: string) {
  const { STAFF_EMAIL, STAFF_NAME } = CONFIG;
  const password = 'TestPassword123!';

  const authId = await createAuthUser(STAFF_EMAIL, password);

  // Get company_id and store_id
  const companyRes = await adminFetch(`/rest/v1/companies?slug=eq.${CONFIG.SLUG}&select=id`, {
    headers: { Prefer: 'return=representation' } as any,
  });
  const [company] = await companyRes.json();
  const companyId = company?.id;

  let finalStoreId = storeId;
  if (!finalStoreId) {
    const storeRes = await adminFetch(`/rest/v1/stores?company_id=eq.${companyId}&select=id&limit=1`);
    const [store] = await storeRes.json();
    finalStoreId = store?.id;
  }

  // Upsert users row
  await adminFetch('/rest/v1/users', {
    method: 'POST',
    headers: { Prefer: 'resolution=merge-duplicates,return=representation' } as any,
    body: JSON.stringify({
      auth_id: authId,
      store_id: finalStoreId,
      company_id: companyId,
      email: STAFF_EMAIL,
      full_name: STAFF_NAME,
      initials: 'TS',
      role: 'admin',
      is_active: true,
    }),
  });

  const session = await getSession(STAFF_EMAIL, password);
  return { authId, session, storeId: finalStoreId, companyId };
}

/**
 * Ensure a customer user exists in both auth, customers, and customer_auth tables.
 */
export async function ensureCustomerUser(storeId?: string) {
  const { CUSTOMER_EMAIL, CUSTOMER_FIRST_NAME, CUSTOMER_LAST_NAME, CUSTOMER_PHONE } = CONFIG;
  const password = 'TestPassword123!';

  const authId = await createAuthUser(CUSTOMER_EMAIL, password);

  const companyRes = await adminFetch(`/rest/v1/companies?slug=eq.${CONFIG.SLUG}&select=id`);
  const [company] = await companyRes.json();
  const companyId = company?.id;

  let finalStoreId = storeId;
  if (!finalStoreId) {
    const storeRes = await adminFetch(`/rest/v1/stores?company_id=eq.${companyId}&select=id&limit=1`);
    const [store] = await storeRes.json();
    finalStoreId = store?.id;
  }

  // Check if customer already exists by email
  let customerId: string;
  const existingCustRes = await adminFetch(
    `/rest/v1/customers?email=eq.${encodeURIComponent(CUSTOMER_EMAIL)}&store_id=eq.${finalStoreId}&select=id&limit=1`
  );
  const existingCusts = await existingCustRes.json();

  if (existingCusts?.length > 0) {
    customerId = existingCusts[0].id;
  } else {
    const custRes = await adminFetch('/rest/v1/customers?select=id', {
      method: 'POST',
      headers: { Prefer: 'return=representation' } as any,
      body: JSON.stringify({
        store_id: finalStoreId,
        first_name: CUSTOMER_FIRST_NAME,
        last_name: CUSTOMER_LAST_NAME,
        email: CUSTOMER_EMAIL,
        phone: CUSTOMER_PHONE,
        is_active: true,
      }),
    });
    const customers = await custRes.json();
    customerId = Array.isArray(customers) ? customers[0]?.id : customers?.id;
  }

  // Create customer_auth link (upsert on auth_id unique constraint)
  const existingAuthRes = await adminFetch(
    `/rest/v1/customer_auth?auth_id=eq.${authId}&select=id&limit=1`
  );
  const existingAuth = await existingAuthRes.json();

  if (!existingAuth?.length) {
    await adminFetch('/rest/v1/customer_auth', {
      method: 'POST',
      headers: { Prefer: 'return=representation' } as any,
      body: JSON.stringify({
        auth_id: authId,
        customer_id: customerId,
        store_id: finalStoreId,
        company_id: companyId,
      }),
    });
  } else {
    // Update existing to ensure correct customer_id
    await adminFetch(`/rest/v1/customer_auth?auth_id=eq.${authId}`, {
      method: 'PATCH',
      headers: { Prefer: 'return=representation' } as any,
      body: JSON.stringify({
        customer_id: customerId,
        store_id: finalStoreId,
        company_id: companyId,
      }),
    });
  }

  const session = await getSession(CUSTOMER_EMAIL, password);
  return { authId, session, customerId, storeId: finalStoreId, companyId };
}

/**
 * Query the database with service role (bypasses RLS).
 */
export async function adminQuery(table: string, query: string = '') {
  const res = await adminFetch(`/rest/v1/${table}?${query}`);
  return res.json();
}

/**
 * Insert data with service role.
 */
export async function adminInsert(table: string, data: any) {
  const res = await adminFetch(`/rest/v1/${table}`, {
    method: 'POST',
    headers: { Prefer: 'return=representation' } as any,
    body: JSON.stringify(data),
  });
  return res.json();
}

/**
 * Delete test data (cleanup).
 */
export async function cleanupTestData() {
  // Delete in order of dependencies
  const { STAFF_EMAIL, CUSTOMER_EMAIL } = CONFIG;

  await adminFetch(`/rest/v1/customer_auth?auth_id=in.(select id from auth.users where email='${CUSTOMER_EMAIL}')`, { method: 'DELETE' });
  await adminFetch(`/rest/v1/customers?email=eq.${CUSTOMER_EMAIL}`, { method: 'DELETE' });
  await adminFetch(`/rest/v1/users?email=eq.${STAFF_EMAIL}`, { method: 'DELETE' });
}
