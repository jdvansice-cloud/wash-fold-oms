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

    // Sign in directly via Supabase auth API from the browser context
    // This ensures the Supabase client properly picks up the session
    const password = 'TestPassword123!';
    await page.evaluate(async ({ supabaseUrl, anonKey, email, password, storageKey }) => {
      // Sign in via REST API from the browser origin
      const res = await fetch(`${supabaseUrl}/auth/v1/token?grant_type=password`, {
        method: 'POST',
        headers: { apikey: anonKey, 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      });
      const session = await res.json();
      if (session.access_token) {
        localStorage.setItem(storageKey, JSON.stringify(session));
      }
    }, {
      supabaseUrl: CONFIG.SUPABASE_URL,
      anonKey: CONFIG.SUPABASE_ANON_KEY,
      email: CONFIG.CUSTOMER_EMAIL,
      password,
      storageKey: 'sb-portal-auth-token',
    });

    await page.goto(`${CONFIG.BASE_PORTAL}`);
    await page.waitForLoadState('networkidle');

    // Wait for portal dashboard to load
    try {
      await page.locator('text=Hola, text=Pedidos, text=Inicio').first().waitFor({ timeout: 15_000 });
    } catch {
      await page.waitForTimeout(3_000);
    }

    await use(page);
  },
});

export { expect };
