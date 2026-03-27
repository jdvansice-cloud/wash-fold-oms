import { test, expect } from '@playwright/test';
import { BASE_PORTAL } from '../fixtures/auth';

test.describe('Customer Portal Login Page', () => {
  test('renders login form with OTP', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/login`);
    await expect(page.locator('text=Iniciar Sesion')).toBeVisible();
    await expect(page.locator('input[type="email"]')).toBeVisible();
    await expect(page.locator('text=Enviar Codigo')).toBeVisible();
  });

  test('shows company name', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/login`);
    await expect(page.locator('text=American Laundry')).toBeVisible({ timeout: 10_000 });
  });

  test('has link to register page', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/login`);
    const registerLink = page.locator('text=Registrate');
    await expect(registerLink).toBeVisible();
  });

  test('has link to staff login', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/login`);
    const staffLink = page.locator('text=Acceso para empleados');
    await expect(staffLink).toBeVisible();
  });
});

test.describe('Customer Portal Register Page', () => {
  test('renders registration form', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/register`);
    await expect(page.locator('text=Crear Cuenta')).toBeVisible();
  });

  test('has required fields', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/register`);

    // Should have name, email, phone fields at minimum
    await expect(page.locator('input[type="email"]')).toBeVisible();

    // Find name-related inputs (label or placeholder)
    const nameInputs = page.locator('input').first();
    await expect(nameInputs).toBeVisible();
  });

  test('validates required fields on submit', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/register`);

    // Try to submit empty form
    const submitBtn = page.locator('button[type="submit"]');
    await submitBtn.click();

    // Should show validation errors or HTML5 validation prevents submission
    await page.waitForTimeout(1_000);
    const url = page.url();
    expect(url).toContain('/register'); // Should still be on register page
  });
});

test.describe('Customer Portal — Unauthenticated Access', () => {
  test('redirects to login when accessing dashboard without auth', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}`);
    await page.waitForURL(`**${BASE_PORTAL}/login**`, { timeout: 10_000 });
  });

  test('redirects to login when accessing orders without auth', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/orders`);
    await page.waitForURL(`**${BASE_PORTAL}/login**`, { timeout: 10_000 });
  });

  test('redirects to login when accessing schedule-pickup without auth', async ({ page }) => {
    await page.goto(`${BASE_PORTAL}/schedule-pickup`);
    await page.waitForURL(`**${BASE_PORTAL}/login**`, { timeout: 10_000 });
  });
});
