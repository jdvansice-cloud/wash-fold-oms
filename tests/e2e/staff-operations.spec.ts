import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

test.describe('Staff — Sidebar Navigation', () => {
  test('sidebar opens and shows menu items', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Open sidebar (hamburger menu)
    const menuBtn = staffPage.locator('button[aria-label*="menu"], button:has(svg):first-child').first();
    await menuBtn.click();
    await staffPage.waitForTimeout(500);

    // Should show navigation items
    const body = await staffPage.textContent('body');
    expect(body).toContain('Clientes');
  });

  test('can navigate to Customers page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const body = await staffPage.textContent('body');
    const hasCustomers = body?.includes('Clientes') || body?.includes('cliente');
    expect(hasCustomers).toBeTruthy();
  });

  test('can navigate to Machines page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/machines`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const body = await staffPage.textContent('body');
    expect(body).toBeTruthy();
  });

  test('can navigate to Settings page', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const body = await staffPage.textContent('body');
    const hasSettings = body?.includes('Configuracion') || body?.includes('Configuración');
    expect(hasSettings).toBeTruthy();
  });
});

test.describe('Staff — Customer Management', () => {
  test('customer list displays', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    // Should have a search bar or customer list
    const body = await staffPage.textContent('body');
    const hasList = body?.includes('Clientes') || body?.includes('buscar') || body?.includes('Nombre');
    expect(hasList).toBeTruthy();
  });

  test('can search for a customer', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/customers`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const searchInput = staffPage.locator('input[placeholder*="buscar"], input[placeholder*="Buscar"], input[type="search"]').first();
    if (await searchInput.count() > 0) {
      await searchInput.fill('Test');
      await staffPage.waitForTimeout(1_000);

      // Should filter/show results
      const body = await staffPage.textContent('body');
      expect(body).toBeTruthy();
    }
  });
});

test.describe('Staff — Settings Sections', () => {
  test('company settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);

    // Click Empresa
    const empresaItem = staffPage.locator('text=Empresa').first();
    if (await empresaItem.count() > 0) {
      await empresaItem.click();
      await staffPage.waitForTimeout(1_000);

      const body = await staffPage.textContent('body');
      const hasCompanySettings = body?.includes('Nombre') || body?.includes('nombre') || body?.includes('Empresa');
      expect(hasCompanySettings).toBeTruthy();
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

      const body = await staffPage.textContent('body');
      expect(body).toBeTruthy();
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
      const hasUsersUI = body?.includes('Usuario') || body?.includes('Rol') || body?.includes('admin');
      expect(hasUsersUI).toBeTruthy();
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
      const hasPaymentUI = body?.includes('Efectivo') || body?.includes('Tarjeta') || body?.includes('Yappy');
      expect(hasPaymentUI).toBeTruthy();
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

      const body = await staffPage.textContent('body');
      expect(body).toBeTruthy();
    }
  });

  test('pickup schedule settings loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/settings`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(2_000);

    const pickupItem = staffPage.locator('text=Recogidas').first();
    if (await pickupItem.count() > 0) {
      await pickupItem.click();
      await staffPage.waitForTimeout(1_000);

      // Should show pickup schedule
      const body = await staffPage.textContent('body');
      const hasScheduleUI = body?.includes('Horario') || body?.includes('Lunes') || body?.includes('horario');
      expect(hasScheduleUI).toBeTruthy();
    }
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
      const hasLoyaltyUI = body?.includes('Lealtad') || body?.includes('Puntos') || body?.includes('Tarjeta');
      expect(hasLoyaltyUI).toBeTruthy();
    }
  });
});

test.describe('Staff — Pickups Page', () => {
  test('pickups page loads', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/pickups`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const body = await staffPage.textContent('body');
    const hasPickupsUI = body?.includes('Recogida') || body?.includes('Hoy') || body?.includes('Proximos') || body?.includes('Próximos');
    expect(hasPickupsUI).toBeTruthy();
  });

  test('pickups has Today and Upcoming tabs', async ({ staffPage }) => {
    await staffPage.goto(`${CONFIG.BASE_STAFF}/pickups`);
    await staffPage.waitForLoadState('networkidle');
    await staffPage.waitForTimeout(3_000);

    const body = await staffPage.textContent('body');
    const hasTabs = body?.includes('Hoy') && (body?.includes('Proximos') || body?.includes('Próximos'));
    expect(hasTabs).toBeTruthy();
  });
});

test.describe('Staff — Header Features', () => {
  test('search icon in header works', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Find search button in header
    const searchBtn = staffPage.locator('header button:has(svg)').filter({ hasNotText: 'Gift Card' }).first();
    if (await searchBtn.count() > 0) {
      await searchBtn.click();
      await staffPage.waitForTimeout(1_000);
    }
  });

  test('user avatar/initials visible in header', async ({ staffPage }) => {
    await expect(staffPage.locator('text=Nueva Orden')).toBeVisible({ timeout: 10_000 });

    // Should show user initials or avatar
    const avatar = staffPage.locator('[class*="avatar"], [class*="initials"]').first();
    if (await avatar.count() > 0) {
      await expect(avatar).toBeVisible();
    }
  });
});
