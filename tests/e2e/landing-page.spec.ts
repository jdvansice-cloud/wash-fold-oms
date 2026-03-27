import { test, expect } from '@playwright/test';
import { SLUG, BASE_STAFF, BASE_PORTAL } from '../fixtures/auth';

test.describe('Landing Page', () => {
  test('loads the landing page', async ({ page }) => {
    await page.goto('/');
    // Check for the brand name in the header
    await expect(page.locator('header')).toBeVisible();
  });

  test('has staff login link in header', async ({ page }) => {
    await page.goto('/');
    const staffLink = page.locator('text=Iniciar Sesion').first();
    await expect(staffLink).toBeVisible();
  });

  test('has register button', async ({ page }) => {
    await page.goto('/');
    await expect(page.getByText('Registrarse').first()).toBeVisible({ timeout: 5_000 });
  });

  test('org search finds American Laundry by commercial name', async ({ page }) => {
    await page.goto('/');

    // Click the staff login button to open org search
    await page.locator('text=Iniciar Sesion').first().click();

    // Type in the search modal
    const searchInput = page.locator('input[placeholder*="Buscar"]').first();
    await searchInput.waitFor({ timeout: 5_000 });
    await searchInput.fill('American');

    // Should find the org
    await expect(page.getByText('American Laundry', { exact: true }).first()).toBeVisible({ timeout: 5_000 });
  });

  test('org search navigates to staff login', async ({ page, baseURL }) => {
    await page.goto('/');
    await page.locator('text=Iniciar Sesion').first().click();

    const searchInput = page.locator('input[placeholder*="Buscar"]').first();
    await searchInput.waitFor({ timeout: 5_000 });
    await searchInput.fill('American');

    // Each org result has Staff/Portal buttons — click the staff one
    // Look for buttons within the result that say "Ingresar" or "Staff" or contain a login icon
    const staffButton = page.locator('button:has-text("Ingresar"), button:has-text("Staff"), button:has-text("Acceder")').first();
    await staffButton.click({ timeout: 5_000 });

    // Should navigate to staff login
    await page.waitForURL(`**${BASE_STAFF}/login`, { timeout: 10_000 });
  });
});

test.describe('Backward Compatibility Redirects', () => {
  test('/login redirects to /app/american-laundry/login', async ({ page }) => {
    await page.goto('/login');
    await page.waitForURL(`**${BASE_STAFF}/login`, { timeout: 5_000 });
  });

  test('/portal redirects to /portal/american-laundry', async ({ page }) => {
    await page.goto('/portal');
    await page.waitForURL(`**${BASE_PORTAL}/**`, { timeout: 5_000 });
  });
});
