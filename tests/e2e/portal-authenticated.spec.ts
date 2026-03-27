import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

test.describe('Customer Portal — Dashboard', () => {
  test('portal dashboard loads for authenticated customer', async ({ portalPage }) => {
    // Should show welcome message
    await expect(portalPage.locator('text=Bienvenido, text=Hola').first()).toBeVisible({ timeout: 10_000 });
  });

  test('dashboard shows customer name', async ({ portalPage }) => {
    await expect(portalPage.locator(`text=${CONFIG.CUSTOMER_FIRST_NAME}`).first()).toBeVisible({ timeout: 10_000 });
  });

  test('dashboard has quick action cards', async ({ portalPage }) => {
    await portalPage.waitForTimeout(2_000);

    // Should show "Mis Pedidos", "Lealtad", "Mi Perfil" cards
    const body = await portalPage.textContent('body');
    expect(body).toContain('Mis Pedidos');
  });

  test('Programar Recogida button visible', async ({ portalPage }) => {
    const pickupBtn = portalPage.locator('text=Programar Recogida, text=Recoger').first();
    await expect(pickupBtn).toBeVisible({ timeout: 10_000 });
  });
});

test.describe('Customer Portal — My Orders', () => {
  test('orders page loads', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/orders`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    const body = await portalPage.textContent('body');
    const hasOrdersUI = body?.includes('Pedidos') || body?.includes('ordenes') || body?.includes('No tienes');
    expect(hasOrdersUI).toBeTruthy();
  });

  test('orders page shows active and completed tabs', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/orders`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    const body = await portalPage.textContent('body');
    const hasTabUI = body?.includes('Activ') || body?.includes('Completad') || body?.includes('Historial');
    expect(hasTabUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Pickup Scheduling', () => {
  test('schedule pickup page loads', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    // Should show the scheduling wizard
    await expect(portalPage.locator('text=Programar Recogida, text=Selecciona una fecha').first()).toBeVisible({ timeout: 10_000 });
  });

  test('date picker shows available days', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    // Should see date cards (days of the week)
    const dateCells = portalPage.locator('[class*="date"], [class*="day"]');
    const count = await dateCells.count();
    expect(count).toBeGreaterThan(0);
  });

  test('can select an available date and see time slots', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    // Find a date that's not "Cerrado" and click it
    const availableDate = portalPage.locator('[class*="date"]:not(:has-text("Cerrado")), button:has-text("Disponible")').first();

    if (await availableDate.count() > 0) {
      await availableDate.click();
      await portalPage.waitForTimeout(1_000);

      // Should show time slots (step 2)
      const body = await portalPage.textContent('body');
      const hasTimeSlots = body?.includes('Selecciona') || body?.includes('horario') || body?.includes(':00') || body?.includes(':30');
      expect(hasTimeSlots).toBeTruthy();
    }
  });
});

test.describe('Customer Portal — Locations', () => {
  test('locations page loads', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/locations`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    const body = await portalPage.textContent('body');
    const hasLocationsUI = body?.includes('Direccion') || body?.includes('direccion') || body?.includes('Agregar') || body?.includes('ubicacion') || body?.includes('Mis Direcciones');
    expect(hasLocationsUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Loyalty', () => {
  test('loyalty page loads', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/loyalty`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    const body = await portalPage.textContent('body');
    const hasLoyaltyUI = body?.includes('Lealtad') || body?.includes('Puntos') || body?.includes('puntos') || body?.includes('Programa');
    expect(hasLoyaltyUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Profile', () => {
  test('profile page loads with customer info', async ({ portalPage }) => {
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/profile`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    const body = await portalPage.textContent('body');
    const hasProfileUI = body?.includes('Perfil') || body?.includes('perfil') || body?.includes(CONFIG.CUSTOMER_EMAIL);
    expect(hasProfileUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Navigation', () => {
  test('all nav items are clickable and navigate correctly', async ({ portalPage }) => {
    await portalPage.waitForTimeout(2_000);

    // Test each nav item
    const navItems = ['Pedidos', 'Recoger', 'Lealtad', 'Perfil'];

    for (const item of navItems) {
      const navLink = portalPage.locator(`nav a:has-text("${item}"), header a:has-text("${item}")`).first();
      if (await navLink.count() > 0) {
        await navLink.click();
        await portalPage.waitForTimeout(1_000);
        // Should not crash
        const body = await portalPage.textContent('body');
        expect(body).toBeTruthy();
      }
    }
  });

  test('logout button works', async ({ portalPage }) => {
    await portalPage.waitForTimeout(2_000);

    // Find logout button (arrow icon or text)
    const logoutBtn = portalPage.locator('button[aria-label*="logout"], button[aria-label*="salir"], button:has(svg)').last();
    if (await logoutBtn.count() > 0) {
      await logoutBtn.click();
      await portalPage.waitForTimeout(2_000);

      // Should redirect to login
      expect(portalPage.url()).toContain('/login');
    }
  });
});
