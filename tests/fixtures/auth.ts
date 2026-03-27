import { Page, expect } from '@playwright/test';

const SLUG = 'american-laundry';
const BASE_STAFF = `/app/${SLUG}`;
const BASE_PORTAL = `/portal/${SLUG}`;

export { SLUG, BASE_STAFF, BASE_PORTAL };

/**
 * Login to staff app using email/password.
 * Assumes the staff user has password-based auth (not OTP).
 */
export async function staffLogin(page: Page, email: string, password: string) {
  await page.goto(`${BASE_STAFF}/login`);
  await page.waitForLoadState('networkidle');

  // Fill email
  const emailInput = page.locator('input[type="email"]');
  await emailInput.fill(email);

  // Fill password
  const passwordInput = page.locator('input[type="password"]');
  await passwordInput.fill(password);

  // Click login button
  await page.locator('button[type="submit"]').click();

  // Wait for navigation to POS or dashboard
  await page.waitForURL(`**${BASE_STAFF}/**`, { timeout: 15_000 });
}

/**
 * Set auth session directly via localStorage to bypass OTP.
 * Use this when you have a valid Supabase session token.
 */
export async function setStaffSession(page: Page, accessToken: string, refreshToken: string) {
  await page.goto(`${BASE_STAFF}/login`);

  await page.evaluate(({ access, refresh }) => {
    const session = {
      access_token: access,
      refresh_token: refresh,
      token_type: 'bearer',
      expires_in: 3600,
      expires_at: Math.floor(Date.now() / 1000) + 3600,
    };
    localStorage.setItem('sb-staff-auth-token', JSON.stringify({
      currentSession: session,
      expiresAt: session.expires_at,
    }));
  }, { access: accessToken, refresh: refreshToken });

  await page.reload();
}

/**
 * Check that we're on the POS screen (staff landing page)
 */
export async function expectPOSScreen(page: Page) {
  await expect(page.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });
}

/**
 * Check that we're on the portal dashboard
 */
export async function expectPortalDashboard(page: Page) {
  await expect(page.locator('text=Bienvenido')).toBeVisible({ timeout: 10_000 });
}
