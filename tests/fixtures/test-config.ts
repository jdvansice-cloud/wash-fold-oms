/**
 * Test configuration — loaded from environment variables.
 *
 * Set these before running tests:
 *   SUPABASE_URL=https://your-project.supabase.co
 *   SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
 *   TEST_STORE_ID=your-store-uuid
 *
 * The service role key is needed to create auth sessions programmatically.
 * NEVER commit actual keys — use .env.test or export them in your shell.
 */

export const CONFIG = {
  SUPABASE_URL: process.env.SUPABASE_URL || '',
  SUPABASE_ANON_KEY: process.env.SUPABASE_ANON_KEY || '',
  SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY || '',

  SLUG: 'american-laundry',
  BASE_STAFF: '/app/american-laundry',
  BASE_PORTAL: '/portal/american-laundry',

  // Test users — created programmatically
  STAFF_EMAIL: 'test-staff@washpro.test',
  STAFF_NAME: 'Test Staff',
  CUSTOMER_EMAIL: 'test-customer@washpro.test',
  CUSTOMER_FIRST_NAME: 'Test',
  CUSTOMER_LAST_NAME: 'Customer',
  CUSTOMER_PHONE: '+5076000000',
};
