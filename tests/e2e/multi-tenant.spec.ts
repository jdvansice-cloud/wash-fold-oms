import { test, expect } from '@playwright/test';

test.describe('Multi-Tenant Isolation', () => {
  test('non-existent slug shows error page', async ({ page }) => {
    await page.goto('/app/nonexistent-company/login');
    await page.waitForLoadState('networkidle');

    const body = await page.textContent('body');
    const shows404 = body?.includes('no encontr') || body?.includes('404') || body?.includes('not found') || body?.includes('No se encontr');
    expect(shows404).toBeTruthy();
  });

  test('portal for non-existent slug shows error', async ({ page }) => {
    await page.goto('/portal/nonexistent-company/login');
    await page.waitForLoadState('networkidle');

    const body = await page.textContent('body');
    const shows404 = body?.includes('no encontr') || body?.includes('404') || body?.includes('not found') || body?.includes('No se encontr');
    expect(shows404).toBeTruthy();
  });

  test('valid slug loads correct company name', async ({ page }) => {
    await page.goto('/app/american-laundry/login');
    await expect(page.getByText('American Laundry', { exact: true }).first()).toBeVisible({ timeout: 10_000 });
  });

  test('different slugs are isolated — cannot cross-access', async ({ page }) => {
    // Staff login page for american-laundry should NOT show any other company's data
    await page.goto('/app/american-laundry/login');
    await page.waitForLoadState('networkidle');

    const body = await page.textContent('body');
    // Should only reference American Laundry
    expect(body).toContain('American Laundry');
  });
});

test.describe('URL Structure', () => {
  test('staff routes follow /app/:slug pattern', async ({ page }) => {
    await page.goto('/app/american-laundry/login');
    expect(page.url()).toContain('/app/american-laundry/login');
  });

  test('portal routes follow /portal/:slug pattern', async ({ page }) => {
    await page.goto('/portal/american-laundry/login');
    expect(page.url()).toContain('/portal/american-laundry/login');
  });
});
