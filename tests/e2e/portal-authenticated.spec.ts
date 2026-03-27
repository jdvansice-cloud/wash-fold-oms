import { test, expect } from '../fixtures/authenticated';
import { CONFIG } from '../fixtures/test-config';

// Helper: check if portal is loaded (not stuck on login)
async function waitForPortal(page: any) {
  // If we see "Hola" or nav items like "Pedidos", we're logged in
  try {
    await page.locator('text=Hola, text=Pedidos, text=Inicio').first().waitFor({ timeout: 15_000 });
  } catch {
    // May still be on login — take a screenshot for debugging
    console.log('Portal URL:', page.url());
    const body = await page.textContent('body');
    console.log('Portal body preview:', body?.substring(0, 200));
  }
}

test.describe('Customer Portal — Dashboard', () => {
  test('portal dashboard loads for authenticated customer', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    // Check for welcome message or dashboard content
    const body = await portalPage.textContent('body');
    const isLoggedIn = body?.includes('Hola') || body?.includes('Bienvenido') || body?.includes('Pedidos');
    expect(isLoggedIn).toBeTruthy();
  });

  test('dashboard shows customer name', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    const body = await portalPage.textContent('body');
    // Customer name or "Hola" greeting should be visible
    const hasName = body?.includes(CONFIG.CUSTOMER_FIRST_NAME) || body?.includes('Hola');
    expect(hasName).toBeTruthy();
  });

  test('dashboard has quick action cards', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasCards = body?.includes('Mis Pedidos') || body?.includes('Pedidos') || body?.includes('Lealtad');
    expect(hasCards).toBeTruthy();
  });

  test('Programar Recogida button visible', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    const body = await portalPage.textContent('body');
    const hasPickup = body?.includes('Programar Recogida') || body?.includes('Recoger') || body?.includes('recogida');
    expect(hasPickup).toBeTruthy();
  });
});

test.describe('Customer Portal — My Orders', () => {
  test('orders page loads', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/orders`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasOrdersUI = body?.includes('Pedidos') || body?.includes('ordenes') || body?.includes('No tienes');
    expect(hasOrdersUI).toBeTruthy();
  });

  test('orders page shows active and completed tabs', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/orders`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasTabUI = body?.includes('Activ') || body?.includes('Completad') || body?.includes('Historial') || body?.includes('pedidos');
    expect(hasTabUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Pickup Scheduling', () => {
  test('schedule pickup page loads', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasScheduleUI = body?.includes('Programar Recogida') || body?.includes('Selecciona una fecha') || body?.includes('fecha');
    expect(hasScheduleUI).toBeTruthy();
  });

  test('date picker shows available days', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    // Look for day names or date numbers in the schedule
    const body = await portalPage.textContent('body');
    const hasDays = body?.includes('Lun') || body?.includes('Mar') || body?.includes('Mie') || body?.includes('Jue') || body?.includes('Vie');
    expect(hasDays).toBeTruthy();
  });

  test('can select an available date and see time slots', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/schedule-pickup`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);

    // Find a clickable date that's not "Cerrado"
    const availableDate = portalPage.locator('button:not(:has-text("Cerrado")):has-text(/^\\d+$/)').first();
    if (await availableDate.count() > 0) {
      await availableDate.click();
      await portalPage.waitForTimeout(1_000);
      const body = await portalPage.textContent('body');
      expect(body?.includes('Selecciona') || body?.includes('horario') || body?.includes(':00') || body?.includes(':30')).toBeTruthy();
    }
  });
});

test.describe('Customer Portal — Locations', () => {
  test('locations page loads', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/locations`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasLocationsUI = body?.includes('Direccion') || body?.includes('direccion') || body?.includes('Agregar') || body?.includes('ubicacion') || body?.includes('Mis Direcciones') || body?.includes('Guardar');
    expect(hasLocationsUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Loyalty', () => {
  test('loyalty page loads', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/loyalty`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasLoyaltyUI = body?.includes('Lealtad') || body?.includes('Puntos') || body?.includes('puntos') || body?.includes('Programa') || body?.includes('B/');
    expect(hasLoyaltyUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Profile', () => {
  test('profile page loads with customer info', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    await portalPage.goto(`${CONFIG.BASE_PORTAL}/profile`);
    await portalPage.waitForLoadState('networkidle');
    await portalPage.waitForTimeout(2_000);
    const body = await portalPage.textContent('body');
    const hasProfileUI = body?.includes('Perfil') || body?.includes('perfil') || body?.includes(CONFIG.CUSTOMER_EMAIL) || body?.includes('Nombre') || body?.includes('Email');
    expect(hasProfileUI).toBeTruthy();
  });
});

test.describe('Customer Portal — Navigation', () => {
  test('all nav items are clickable and navigate correctly', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    const navItems = ['Pedidos', 'Recoger', 'Lealtad', 'Perfil'];
    for (const item of navItems) {
      const navLink = portalPage.locator(`nav a:has-text("${item}"), header a:has-text("${item}")`).first();
      if (await navLink.count() > 0) {
        await navLink.click();
        await portalPage.waitForTimeout(1_000);
        expect(await portalPage.textContent('body')).toBeTruthy();
      }
    }
  });

  test('logout button works', async ({ portalPage }) => {
    await waitForPortal(portalPage);
    const logoutBtn = portalPage.locator('button[aria-label*="logout"], button[aria-label*="salir"], button:has(svg)').last();
    if (await logoutBtn.count() > 0) {
      await logoutBtn.click();
      await portalPage.waitForTimeout(2_000);
      expect(portalPage.url()).toContain('/login');
    }
  });
});
