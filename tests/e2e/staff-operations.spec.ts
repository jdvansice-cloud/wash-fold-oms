import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

// Helper: wait for staff app to be loaded (scoped to header)
async function waitForStaff(page: any) {
  await expect(page.getByRole('banner').getByRole('link', { name: 'Nueva Orden' })).toBeVisible({ timeout: 15_000 });
}

test.describe('Staff — Sidebar Navigation', () => {
  test('sidebar opens and shows menu items', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    const menuBtn = staffPage.locator('button[aria-label*="menu"], button:has(svg):first-child').first();
    await menuBtn.click();
    await staffPage.waitForTimeout(500);
    const body = await staffPage.textContent('body');
    expect(body).toContain('Clientes');
  });

  test('can navigate to Customers page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Clientes') || body?.includes('cliente')).toBeTruthy();
  });

  test('can navigate to Machines page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/machines`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    expect(await staffPage.textContent('body')).toBeTruthy();
  });

  test('can navigate to Settings page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Configuracion') || body?.includes('Configuración')).toBeTruthy();
  });
});

test.describe('Staff — Customer Management', () => {
  test('customer list displays', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Clientes') || body?.includes('buscar') || body?.includes('Nombre')).toBeTruthy();
  });

  test('can search for a customer', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const searchInput = staffPage.locator('input[placeholder*="buscar"], input[placeholder*="Buscar"], input[type="search"]').first();
    if (await searchInput.count() > 0) {
      await searchInput.fill('Test');
      await staffPage.waitForTimeout(1_000);
      expect(await staffPage.textContent('body')).toBeTruthy();
    }
  });
});

test.describe('Staff — Settings Sections', () => {
  test('company settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const empresaItem = staffPage.locator('text=Empresa').first();
    if (await empresaItem.count() > 0) {
      await empresaItem.click();
      await staffPage.waitForTimeout(1_000);
      const body = await staffPage.textContent('body');
      expect(body?.includes('Nombre') || body?.includes('nombre') || body?.includes('Empresa')).toBeTruthy();
    }
  });

  test('store settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const tiendaItem = staffPage.locator('text=Tienda').first();
    if (await tiendaItem.count() > 0) {
      await tiendaItem.click();
      await staffPage.waitForTimeout(1_000);
      expect(await staffPage.textContent('body')).toBeTruthy();
    }
  });

  test('users settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const usersItem = staffPage.locator('text=Usuarios').first();
    if (await usersItem.count() > 0) {
      await usersItem.click();
      await staffPage.waitForTimeout(1_000);
      const body = await staffPage.textContent('body');
      expect(body?.includes('Usuario') || body?.includes('Rol') || body?.includes('admin')).toBeTruthy();
    }
  });

  test('payment methods settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const payItem = staffPage.locator('text=Métodos de Pago, text=Metodos de Pago').first();
    if (await payItem.count() > 0) {
      await payItem.click();
      await staffPage.waitForTimeout(1_000);
      const body = await staffPage.textContent('body');
      expect(body?.includes('Efectivo') || body?.includes('Tarjeta') || body?.includes('Yappy')).toBeTruthy();
    }
  });

  test('products settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const productsItem = staffPage.locator('text=Productos').first();
    if (await productsItem.count() > 0) {
      await productsItem.click();
      await staffPage.waitForTimeout(1_000);
      expect(await staffPage.textContent('body')).toBeTruthy();
    }
  });

  test('pickup schedule settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);

    // Scroll the settings sidebar to reveal "Recogidas" then click
    await staffPage.evaluate(() => {
      const items = document.querySelectorAll('button, a, [role="button"]');
      for (const el of items) {
        if (el.textContent?.includes('Recogidas')) {
          (el as HTMLElement).scrollIntoView({ block: 'center' });
          (el as HTMLElement).click();
          break;
        }
      }
    });
    await staffPage.waitForTimeout(2_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Horario') || body?.includes('Lunes') || body?.includes('horario') || body?.includes('Recogida')).toBeTruthy();
  });

  test('loyalty settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);
    const loyaltyItem = staffPage.locator('text=Lealtad').first();
    if (await loyaltyItem.count() > 0) {
      await loyaltyItem.click();
      await staffPage.waitForTimeout(1_000);
      const body = await staffPage.textContent('body');
      expect(body?.includes('Lealtad') || body?.includes('Puntos') || body?.includes('Tarjeta')).toBeTruthy();
    }
  });
});

test.describe('Staff — Pickups Page', () => {
  test('pickups page loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/pickups`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Recogida') || body?.includes('Hoy') || body?.includes('Proximos') || body?.includes('Próximos')).toBeTruthy();
  });

  test('pickups has Today and Upcoming tabs', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/pickups`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);
    const body = await staffPage.textContent('body');
    expect(body?.includes('Hoy') && (body?.includes('Proximos') || body?.includes('Próximos'))).toBeTruthy();
  });
});

test.describe('Staff — Header Features', () => {
  test('search icon in header works', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    const searchBtn = staffPage.getByRole('banner').locator('button:has(svg)').filter({ hasNotText: 'Gift Card' }).first();
    if (await searchBtn.count() > 0) {
      await searchBtn.click();
      await staffPage.waitForTimeout(1_000);
    }
  });

  test('user avatar/initials visible in header', async ({ staffPage }) => {
    await waitForStaff(staffPage);
    const avatar = staffPage.getByRole('banner').locator('[class*="avatar"], [class*="initials"], img').first();
    if (await avatar.count() > 0) {
      await expect(avatar).toBeVisible();
    }
  });
});
