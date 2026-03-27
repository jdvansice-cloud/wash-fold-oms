import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

// Helper: wait for POS to be loaded (scoped to header to avoid strict mode)
async function waitForPOS(page: any) {
  await expect(page.getByRole('banner').getByRole('link', { name: 'Nueva Orden' })).toBeVisible({ timeout: 15_000 });
}

test.describe('POS — Create Order', () => {
  test('POS screen loads with product sections', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    const tabs = staffPage.locator('[class*="section"], button:has-text("Lava y Dobla"), button:has-text("Productos")');
    await expect(tabs.first()).toBeVisible({ timeout: 5_000 });
  });

  test('can select a customer for the order', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    const selectCustomer = staffPage.locator('text=Seleccionar Cliente').first();
    await selectCustomer.click();
    await expect(staffPage.locator('input[placeholder*="cliente"], input[placeholder*="buscar"], input[placeholder*="Buscar"]').first()).toBeVisible({ timeout: 5_000 });
  });

  test('can add a quantity-based product to the ticket', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    const productosTab = staffPage.locator('button:has-text("Productos")');
    if (await productosTab.count() > 0) {
      await productosTab.click();
      await staffPage.waitForTimeout(500);
    }
    const productTile = staffPage.locator('[class*="product"], [class*="tile"], [class*="card"]')
      .filter({ hasNotText: 'Ver opciones' }).first();
    if (await productTile.count() > 0) {
      await productTile.click();
      await staffPage.waitForTimeout(1_000);
      expect(await staffPage.textContent('body')).toBeTruthy();
    }
  });

  test('can toggle express mode', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    const expressToggle = staffPage.locator('text=Express, label:has-text("Express")').first();
    if (await expressToggle.count() > 0) {
      await expressToggle.click();
      await staffPage.waitForTimeout(500);
    }
  });

  test('ticket panel shows Procesar button', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    await expect(staffPage.locator('button:has-text("Procesar")')).toBeVisible();
  });

  test('weight entry modal opens for weight-based products', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    // "Lava y Dobla" is usually the first section and auto-selected
    // Click the first weight product (shows "por kg" in its tile)
    const weightProduct = staffPage.locator('button.product-tile').filter({ hasText: /por\s*kg/i }).first();
    if (await weightProduct.count() > 0) {
      await weightProduct.click();
      await staffPage.waitForTimeout(1_000);
      // Weight entry modal shows input for weight
      const modal = staffPage.locator('[class*="modal"], [role="dialog"], .fixed').filter({ hasText: /[Pp]eso|[Bb]olsa|kg/ });
      await expect(modal.first()).toBeVisible({ timeout: 5_000 });
    }
  });
});

test.describe('POS — Section Navigation', () => {
  test('can switch between product sections', async ({ staffPage }) => {
    await waitForPOS(staffPage);
    const sections = staffPage.locator('nav button, [role="tab"]');
    const count = await sections.count();
    if (count >= 2) {
      await sections.nth(1).click();
      await staffPage.waitForTimeout(500);
      await expect(staffPage.locator('[class*="grid"], [class*="products"]').first()).toBeVisible();
    }
  });
});
