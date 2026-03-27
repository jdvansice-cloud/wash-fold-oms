import { test as base, Page, expect } from '@playwright/test';
import { ensureStaffUser, ensureCustomerUser } from './supabase-admin';
import { CONFIG } from './test-config';

type AuthFixtures = {
  staffPage: Page;
  portalPage: Page;
  staffSession: Awaited<ReturnType<typeof ensureStaffUser>>;
  customerSession: Awaited<ReturnType<typeof ensureCustomerUser>>;
};

/**
 * Extended Playwright test with authenticated fixtures.
 *
 * Usage:
 *   import { test, expect } from '../fixtures/authenticated';
 *   test('my test', async ({ staffPage }) => { ... });
 */
export const test = base.extend<AuthFixtures>({
  staffSession: async ({}, use) => {
    const session = await ensureStaffUser();
    await use(session);
  },

  customerSession: async ({}, use) => {
    const session = await ensureCustomerUser();
    await use(session);
  },

  staffPage: async ({ page, staffSession }, use) => {
    // Navigate to staff login page first (sets up domain cookies)
    await page.goto(`${CONFIG.BASE_STAFF}/login`);
    await page.waitForLoadState('networkidle');

    // Inject session into localStorage
    const { session } = staffSession;
    await page.evaluate(({ session, storageKey }) => {
      const data = {
        access_token: session.access_token,
        refresh_token: session.refresh_token,
        token_type: 'bearer',
        expires_in: session.expires_in,
        expires_at: session.expires_at,
        user: session.user,
      };
      localStorage.setItem(storageKey, JSON.stringify(data));
    }, { session: session, storageKey: 'sb-staff-auth-token' });

    // Reload to pick up the session
    await page.goto(`${CONFIG.BASE_STAFF}`);
    await page.waitForLoadState('networkidle');

    // Wait for the app to load (POS screen or loading spinner to complete)
    await page.waitForTimeout(3_000);

    await use(page);
  },

  portalPage: async ({ page, customerSession }, use) => {
    await page.goto(`${CONFIG.BASE_PORTAL}/login`);
    await page.waitForLoadState('networkidle');

    const { session } = customerSession;
    await page.evaluate(({ session, storageKey }) => {
      const data = {
        access_token: session.access_token,
        refresh_token: session.refresh_token,
        token_type: 'bearer',
        expires_in: session.expires_in,
        expires_at: session.expires_at,
        user: session.user,
      };
      localStorage.setItem(storageKey, JSON.stringify(data));
    }, { session: session, storageKey: 'sb-portal-auth-token' });

    await page.goto(`${CONFIG.BASE_PORTAL}`);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(3_000);

    await use(page);
  },
});

export { expect };
