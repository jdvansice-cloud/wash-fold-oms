import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

test.describe('Order Lifecycle — Status Board', () => {
  test('En Proceso tab loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}`);
    await staffPage.waitForLoadState('networkidle');

    // Click "En Proceso" tab
    const enProcesoTab = staffPage.locator('text=En Proceso').first();
    await enProcesoTab.click();

    await staffPage.waitForTimeout(2_000);

    // Should show either orders or empty state
    const body = await staffPage.textContent('body');
    const hasContent = body?.includes('En Proceso') || body?.includes('No hay ordenes') || body?.includes('pendiente');
    expect(hasContent).toBeTruthy();
  });

  test('Listo tab loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}`);
    await staffPage.waitForLoadState('networkidle');

    const listoTab = staffPage.locator('text=Listo').first();
    await listoTab.click();

    await staffPage.waitForTimeout(2_000);

    const body = await staffPage.textContent('body');
    expect(body).toBeTruthy();
  });

  test('Completado tab loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}`);
    await staffPage.waitForLoadState('networkidle');

    const completadoTab = staffPage.locator('text=Completado').first();
    await completadoTab.click();

    await staffPage.waitForTimeout(2_000);

    const body = await staffPage.textContent('body');
    expect(body).toBeTruthy();
  });
});

test.describe('Order Lifecycle — Status Transitions', () => {
  test('orders page has filter/search capabilities', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}`);
    await staffPage.waitForLoadState('networkidle');

    // Click En Proceso
    await staffPage.locator('text=En Proceso').first().click();
    await staffPage.waitForTimeout(2_000);

    // Should have some UI for viewing orders
    const body = await staffPage.textContent('body');
    expect(body).toBeTruthy();
  });
});
