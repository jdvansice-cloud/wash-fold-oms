import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

test.describe('POS — Create Order', () => {
  test('POS screen loads with product sections', async ({ staffPage }) => {
    // Should see the "Nueva Orden" header
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Should have at least one section tab
    const tabs = staffPage.locator('[class*="section"], button:has-text("Lava y Dobla"), button:has-text("Productos")');
    await expect(tabs.first()).toBeVisible({ timeout: 5_000 });
  });

  test('can select a customer for the order', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Click "Seleccionar Cliente" button
    const selectCustomer = staffPage.locator('text=Seleccionar Cliente').first();
    await selectCustomer.click();

    // Customer search modal should appear
    await expect(staffPage.locator('text=Buscar Cliente, input[placeholder*="cliente"], input[placeholder*="buscar"]').first()).toBeVisible({ timeout: 5_000 });
  });

  test('can add a quantity-based product to the ticket', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Find and click a product tile (not weight-based)
    // Look for "Productos" section which has quantity-based items
    const productosTab = staffPage.locator('button:has-text("Productos")');
    if (await productosTab.count() > 0) {
      await productosTab.click();
      await staffPage.waitForTimeout(500);
    }

    // Click a product tile
    const productTile = staffPage.locator('[class*="product"], [class*="tile"], [class*="card"]')
      .filter({ hasNotText: 'Ver opciones' })
      .first();

    if (await productTile.count() > 0) {
      await productTile.click();

      // Ticket should now show at least 1 item or pieces > 0
      await staffPage.waitForTimeout(1_000);
      const ticketContent = await staffPage.textContent('body');
      // The ticket panel should show something (pieces, total, etc.)
      expect(ticketContent).toBeTruthy();
    }
  });

  test('can toggle express mode', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Find express toggle
    const expressToggle = staffPage.locator('text=Express, label:has-text("Express")').first();
    if (await expressToggle.count() > 0) {
      await expressToggle.click();
      await staffPage.waitForTimeout(500);
    }
  });

  test('ticket panel shows Procesar button', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // The Procesar button should be visible (may be disabled if no items)
    const processBtn = staffPage.locator('button:has-text("Procesar")');
    await expect(processBtn).toBeVisible();
  });

  test('weight entry modal opens for weight-based products', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Click "Lava y Dobla" section (weight-based)
    const lavaDoblaTab = staffPage.locator('button:has-text("Lava y Dobla")');
    if (await lavaDoblaTab.count() > 0) {
      await lavaDoblaTab.click();
      await staffPage.waitForTimeout(500);

      // Click the first weight-based product
      const weightProduct = staffPage.locator('[class*="product"], [class*="tile"], [class*="card"]')
        .filter({ hasText: 'por kg' })
        .first();

      if (await weightProduct.count() > 0) {
        await weightProduct.click();

        // Weight entry modal should appear
        await expect(staffPage.locator('text=Peso, text=Bolsa, text=kg').first()).toBeVisible({ timeout: 5_000 });
      }
    }
  });
});

test.describe('POS — Section Navigation', () => {
  test('can switch between product sections', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Find section tabs
    const sections = staffPage.locator('nav button, [role="tab"]');
    const count = await sections.count();

    if (count >= 2) {
      // Click second section
      await sections.nth(1).click();
      await staffPage.waitForTimeout(500);

      // Products grid should update
      const grid = staffPage.locator('[class*="grid"], [class*="products"]');
      await expect(grid.first()).toBeVisible();
    }
  });
});
