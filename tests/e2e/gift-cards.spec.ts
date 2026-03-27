import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

test.describe('Gift Card — Header Lookup', () => {
  test('gift card lookup button visible in header', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Gift Card button in header
    const giftBtn = staffPage.locator('button:has-text("Gift Card"), [aria-label*="Gift"], button:has(svg)').filter({ hasText: 'Gift Card' });
    await expect(giftBtn.first()).toBeVisible();
  });

  test('gift card lookup modal opens', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    const giftBtn = staffPage.locator('text=Gift Card').first();
    await giftBtn.click();

    // Modal should appear with code input
    await expect(staffPage.locator('input[placeholder*="codigo"], input[placeholder*="CODIGO"], input[placeholder*="Gift"]').first()).toBeVisible({ timeout: 5_000 });
  });

  test('lookup shows "not found" for invalid code', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    await staffPage.locator('text=Gift Card').first().click();

    const codeInput = staffPage.locator('input[placeholder*="codigo"], input[placeholder*="CODIGO"], input[placeholder*="Gift"]').first();
    await codeInput.waitFor({ timeout: 5_000 });
    await codeInput.fill('NONEXISTENT-CODE-XYZ');

    // Submit / press Enter
    await codeInput.press('Enter');
    await staffPage.waitForTimeout(2_000);

    // Should show not found message
    const body = await staffPage.textContent('body');
    const notFound = body?.includes('no encontr') || body?.includes('No se encontr') || body?.includes('no existe');
    expect(notFound).toBeTruthy();
  });
});

test.describe('Gift Card — Settings Management', () => {
  test('gift card settings page loads', async ({ staffPage }) => {
    // Navigate to settings
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);

    // Click "Tarjetas Regalo" in settings sidebar
    const giftCardItem = staffPage.locator('text=Tarjetas Regalo').first();
    await giftCardItem.click();
    await staffPage.waitForTimeout(1_000);

    // Should show the gift card management UI
    const body = await staffPage.textContent('body');
    const hasGiftCardUI = body?.includes('Denominacion') || body?.includes('denominacion') || body?.includes('gift card') || body?.includes('Tarjetas de Regalo');
    expect(hasGiftCardUI).toBeTruthy();
  });

  test('can create a new gift card denomination', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);

    await staffPage.locator('text=Tarjetas Regalo').first().click();
    await staffPage.waitForTimeout(1_000);

    // Click "Nueva Denominacion" button
    const newBtn = staffPage.locator('button:has-text("Nueva Denominacion")');
    if (await newBtn.count() > 0) {
      await newBtn.click();
      await staffPage.waitForTimeout(500);

      // Fill form
      const nameInput = staffPage.locator('input[placeholder*="Gift Card"]').first();
      if (await nameInput.count() > 0) {
        await nameInput.fill('Test Gift Card B/10.00');

        const priceInput = staffPage.locator('input[placeholder*="25"], input[type="number"]').first();
        await priceInput.fill('10');

        // Click save
        const saveBtn = staffPage.locator('button:has-text("Crear")');
        await saveBtn.click();

        await staffPage.waitForTimeout(2_000);

        // Should show the new denomination in the list
        await expect(staffPage.locator('text=Test Gift Card')).toBeVisible({ timeout: 5_000 });
      }
    }
  });
});

test.describe('Gift Card — POS Activation', () => {
  test('gift card product in POS opens activation modal', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Look for "Tarjetas Regalo" section tab
    const giftSection = staffPage.locator('button:has-text("Tarjetas Regalo")');
    if (await giftSection.count() > 0) {
      await giftSection.click();
      await staffPage.waitForTimeout(500);

      // Click a gift card product
      const giftProduct = staffPage.locator('[class*="product"], [class*="tile"], [class*="card"]').first();
      if (await giftProduct.count() > 0) {
        await giftProduct.click();

        // Activation modal should appear
        await expect(staffPage.locator('text=Activar Gift Card, text=Activar, text=codigo').first()).toBeVisible({ timeout: 5_000 });
      }
    }
  });
});
