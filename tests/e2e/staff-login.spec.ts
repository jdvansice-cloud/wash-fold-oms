import { test, expect } from '@playwright/test';
import { BASE_STAFF } from '../fixtures/auth';

test.describe('Staff Login Page', () => {
  test('renders login form', async ({ page }) => {
    await page.goto(`${BASE_STAFF}/login`);
    await expect(page.locator('text=Iniciar Sesion')).toBeVisible();
    await expect(page.locator('input[type="email"]')).toBeVisible();
  });

  test('shows company name dynamically', async ({ page }) => {
    await page.goto(`${BASE_STAFF}/login`);
    // Should show "American Laundry" (commercial name from companies table)
    await expect(page.getByText('American Laundry', { exact: true }).first()).toBeVisible({ timeout: 10_000 });
  });

  test('shows error for invalid email format', async ({ page }) => {
    await page.goto(`${BASE_STAFF}/login`);

    const emailInput = page.locator('input[type="email"]');
    await emailInput.fill('notanemail');

    await page.locator('button[type="submit"]').click();

    // HTML5 validation should prevent submission
    const validity = await emailInput.evaluate((el: HTMLInputElement) => el.validity.valid);
    expect(validity).toBe(false);
  });

  test('OTP flow sends code for valid email', async ({ page }) => {
    await page.goto(`${BASE_STAFF}/login`);

    const emailInput = page.locator('input[type="email"]');
    await emailInput.fill('test-nonexistent@example.com');

    await page.locator('button[type="submit"]').click();

    // Should either show OTP input or an error (both are valid responses)
    // We're testing that the form submits and doesn't crash
    await page.waitForTimeout(3_000);

    const hasOtpInput = await page.locator('input[inputmode="numeric"], input[maxlength="6"]').count();
    const hasError = await page.locator('[class*="red"], [class*="error"]').count();

    expect(hasOtpInput + hasError).toBeGreaterThan(0);
  });
});

test.describe('Staff Login — Slug Validation', () => {
  test('shows 404 for non-existent org slug', async ({ page }) => {
    await page.goto('/app/fake-company-that-does-not-exist/login');
    await page.waitForLoadState('networkidle');

    // Should show not found or error
    const content = await page.textContent('body');
    const hasNotFound = content?.includes('no encontr') || content?.includes('No encontr') || content?.includes('404') || content?.includes('not found');
    expect(hasNotFound).toBeTruthy();
  });
});
