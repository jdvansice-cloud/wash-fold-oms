import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

// Helper: wait for staff app to be loaded (scoped to header)
async function waitForStaff(page: any) {
  await expect(page.getByRole('banner').getByRole('link', { name: 'Nueva Orden' })).toBeVisible({ timeout: 15_000 });
}

test.describe('Gift Card — Header Lookup', () => {
  test('gift card lookup button visible in header', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    const giftBtn = staffPage.getByRole('banner').locator('text=Gift Card').first();
    await expect(giftBtn).toBeVisible();
  });

  test('gift card lookup modal opens', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    await staffPage.getByRole('banner').locator('text=Gift Card').first().click();
    await expect(staffPage.locator('input[placeholder*="odigo"], input[placeholder*="Codigo"], input[placeholder*="tarjeta"]').first()).toBeVisible({ timeout: 5_000 });
  });

  test('lookup shows "not found" for invalid code', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    await staffPage.getByRole('banner').locator('text=Gift Card').first().click();
    const codeInput = staffPage.locator('input[placeholder*="odigo"], input[placeholder*="Codigo"], input[placeholder*="tarjeta"]').first();
    await codeInput.waitFor({ timeout: 5_000 });
    await codeInput.fill('NONEXISTENT-CODE-XYZ');
    await codeInput.press('Enter');
    await staffPage.waitForTimeout(2_000);
    const body = await staffPage.textContent('body');
    const notFound = body?.includes('no encontr') || body?.includes('No se encontr') || body?.includes('no existe') || body?.includes('No encontrada');
    expect(notFound).toBeTruthy();
  });
});

test.describe('Gift Card — Settings Management', () => {
  test('gift card settings page loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const giftCardItem = staffPage.locator('text=Tarjetas Regalo').first();
    await giftCardItem.click();
    await staffPage.waitForTimeout(1_000);
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

    const newBtn = staffPage.locator('button:has-text("Nueva Denominacion")');
    if (await newBtn.count() > 0) {
      await newBtn.click();
      await staffPage.waitForTimeout(500);

      // Use .fill() with dispatch to trigger React state
      const nameInput = staffPage.locator('input[placeholder*="Gift Card"]').first();
      if (await nameInput.count() > 0) {
        await nameInput.click();
        await nameInput.fill('Test Gift Card B/10.00');

        const priceInput = staffPage.locator('input[type="number"]').first();
        await priceInput.click();
        await priceInput.fill('10');

        // Dispatch input event to trigger React onChange
        await priceInput.dispatchEvent('input');
        await staffPage.waitForTimeout(500);

        const saveBtn = staffPage.locator('button:has-text("Crear")');
        await expect(saveBtn).toBeEnabled({ timeout: 5_000 });
        await saveBtn.click();
        await staffPage.waitForTimeout(2_000);

        await expect(staffPage.locator('text=Test Gift Card').first()).toBeVisible({ timeout: 5_000 });
      }
    }
  });
});

test.describe('Gift Card — POS Activation', () => {
  test('gift card product in POS opens activation modal', async ({ staffPage }) => {
    await waitForStaff(staffPage);

    const giftSection = staffPage.locator('button:has-text("Tarjetas Regalo")');
    if (await giftSection.count() > 0) {
      await giftSection.click();
      await staffPage.waitForTimeout(500);

      const giftProduct = staffPage.locator('[class*="product"], [class*="tile"], [class*="card"]').first();
      if (await giftProduct.count() > 0) {
        await giftProduct.click();
        await expect(staffPage.locator('text=Activar Gift Card').first()).toBeVisible({ timeout: 5_000 });
      }
    }
  });
});
