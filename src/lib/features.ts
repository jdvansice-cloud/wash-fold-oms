const PLAN_FEATURES: Record<string, string[]> = {
  starter: [
    'pos', 'orders', 'customers', 'machines', 'analytics', 'reports', 'eod', 'settings',
  ],
  pro: [
    'pos', 'orders', 'customers', 'machines', 'analytics', 'reports', 'eod', 'settings',
    'portal', 'pickups', 'loyalty', 'gift_cards', 'promotions', 'invoices',
  ],
  enterprise: [
    'pos', 'orders', 'customers', 'machines', 'analytics', 'reports', 'eod', 'settings',
    'portal', 'pickups', 'loyalty', 'gift_cards', 'promotions', 'invoices',
    'custom_branding', 'api_access', 'multi_store',
  ],
};

export function hasFeature(plan: string, feature: string): boolean {
  return PLAN_FEATURES[plan]?.includes(feature) ?? false;
}
