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
    await page.goto(`${CONFIG.BASE_STAFF}/login`);
    await page.waitForLoadState('networkidle');

    // Inject session — Supabase gotrue-js stores it directly (not nested)
    const { session } = staffSession;
    await page.evaluate(({ session, storageKey }) => {
      localStorage.setItem(storageKey, JSON.stringify(session));
    }, { session, storageKey: 'sb-staff-auth-token' });

    await page.goto(`${CONFIG.BASE_STAFF}`);
    await page.waitForLoadState('networkidle');

    // Wait for POS to load — check header has the app loaded
    try {
      await page.locator('header').first().waitFor({ timeout: 15_000 });
      await page.waitForTimeout(2_000);
    } catch {
      // If header doesn't appear, we might still be on login — wait longer
      await page.waitForTimeout(5_000);
    }

    await use(page);
  },

  portalPage: async ({ page, customerSession }, use) => {
    await page.goto(`${CONFIG.BASE_PORTAL}/login`);
    await page.waitForLoadState('networkidle');

    const { session } = customerSession;
    await page.evaluate(({ session, storageKey }) => {
      localStorage.setItem(storageKey, JSON.stringify(session));
    }, { session, storageKey: 'sb-portal-auth-token' });

    await page.goto(`${CONFIG.BASE_PORTAL}`);
    await page.waitForLoadState('networkidle');

    // Wait for portal dashboard to load
    try {
      await page.locator('header, nav').first().waitFor({ timeout: 15_000 });
      await page.waitForTimeout(2_000);
    } catch {
      await page.waitForTimeout(5_000);
    }

    await use(page);
  },
});

export { expect };
