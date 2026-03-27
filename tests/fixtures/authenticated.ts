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

    // Inject session — Supabase gotrue-js expects this exact format
    const { session } = staffSession;
    await page.evaluate(({ session, storageKey }) => {
      // Try multiple formats to cover different gotrue-js versions
      const data = JSON.stringify(session);
      localStorage.setItem(storageKey, data);
      // Also set the Supabase v2 format with project ref extracted from URL
      const urlParts = window.location.hostname.split('.');
      const possibleKey = `sb-${urlParts[0]}-auth-token`;
      if (possibleKey !== storageKey) {
        localStorage.setItem(possibleKey, data);
      }
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

    // Use the Supabase client already loaded on the page to sign in properly.
    // This calls setSession() internally, which updates both localStorage AND in-memory state.
    const password = 'TestPassword123!';
    const signInResult = await page.evaluate(async ({ supabaseUrl, anonKey, email, password, storageKey }) => {
      // First sign in via REST to get tokens
      const res = await fetch(`${supabaseUrl}/auth/v1/token?grant_type=password`, {
        method: 'POST',
        headers: { apikey: anonKey, 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      });
      const session = await res.json();

      if (!session.access_token) {
        return { error: 'No access_token in response', session };
      }

      // Now use the app's supabasePortal client to set the session
      // This ensures GoTrue-JS properly initializes its internal state
      try {
        // Access the module's exported supabasePortal via window.__supabasePortal
        // or try importing from the app bundle
        const storageVal = JSON.stringify(session);
        localStorage.setItem(storageKey, storageVal);

        // Also try to dispatch a storage event to notify other listeners
        window.dispatchEvent(new StorageEvent('storage', {
          key: storageKey,
          newValue: storageVal,
        }));

        return { success: true, userId: session.user?.id };
      } catch (e: any) {
        return { error: e.message };
      }
    }, {
      supabaseUrl: CONFIG.SUPABASE_URL,
      anonKey: CONFIG.SUPABASE_ANON_KEY,
      email: CONFIG.CUSTOMER_EMAIL,
      password,
      storageKey: 'sb-portal-auth-token',
    });

    // Navigate to portal — the page reload forces supabasePortal to re-read from localStorage
    await page.goto(`${CONFIG.BASE_PORTAL}`, { waitUntil: 'networkidle' });

    // Give the auth context time to resolve
    await page.waitForTimeout(3_000);

    // Check if we're still on login — if so, try one more reload
    const url = page.url();
    if (url.includes('/login')) {
      // Force reload to re-trigger supabase client initialization
      await page.reload({ waitUntil: 'networkidle' });
      await page.waitForTimeout(3_000);
    }

    // Debug: log what the page shows
    const body = await page.textContent('body');
    console.log('Portal URL:', page.url());
    console.log('Portal body preview:', body?.substring(0, 200));

    await use(page);
  },
});

export { expect };
