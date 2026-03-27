import { defineConfig } from '@playwright/test';
import dotenv from 'dotenv';

// Load .env.test for Supabase credentials
dotenv.config({ path: '.env.test' });

export default defineConfig({
  testDir: './tests/e2e',
  timeout: 60_000,
  retries: 0,
  workers: 2,
  use: {
    baseURL: 'https://wash-fold-oms.vercel.app',
    headless: true,
    screenshot: 'only-on-failure',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'public',
      testMatch: [
        'landing-page.spec.ts',
        'staff-login.spec.ts',
        'customer-portal.spec.ts',
        'multi-tenant.spec.ts',
      ],
    },
    {
      name: 'authenticated',
      testMatch: [
        'pos-order.spec.ts',
        'order-lifecycle.spec.ts',
        'gift-cards.spec.ts',
        'portal-authenticated.spec.ts',
        'staff-operations.spec.ts',
      ],
    },
  ],
});
