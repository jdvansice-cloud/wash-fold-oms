-- =============================================================
-- Customer Portal Migration
-- Creates tables for customer auth, pickup scheduling, and
-- RLS policies for customer self-service access
-- =============================================================

-- 1. CUSTOMER AUTH BRIDGE TABLE
-- Links Supabase Auth accounts to customer records
CREATE TABLE IF NOT EXISTS customer_auth (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  auth_id UUID NOT NULL UNIQUE,
  customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  store_id UUID NOT NULL REFERENCES stores(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_customer_auth_auth_id ON customer_auth(auth_id);
CREATE INDEX IF NOT EXISTS idx_customer_auth_customer_id ON customer_auth(customer_id);

-- 2. PICKUP SCHEDULES
-- Weekly store pickup availability (one row per day of week per store)
CREATE TABLE IF NOT EXISTS pickup_schedules (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 0 AND 6), -- 0=Sunday
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  slot_duration_minutes INT NOT NULL DEFAULT 30,
  max_pickups_per_slot INT NOT NULL DEFAULT 3,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(store_id, day_of_week)
);

CREATE INDEX IF NOT EXISTS idx_pickup_schedules_store ON pickup_schedules(store_id, day_of_week);

-- 3. PICKUP BLOCKED DATES
-- Holidays, closures, or dates when pickup is unavailable
CREATE TABLE IF NOT EXISTS pickup_blocked_dates (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  blocked_date DATE NOT NULL,
  reason VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(store_id, blocked_date)
);

CREATE INDEX IF NOT EXISTS idx_pickup_blocked_dates_store ON pickup_blocked_dates(store_id, blocked_date);

-- 4. PICKUP REQUESTS
-- Customer pickup bookings
CREATE TABLE IF NOT EXISTS pickup_requests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id),  -- linked after pickup is processed into an order
  requested_date DATE NOT NULL,
  requested_time_slot TIME NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'confirmed', 'picked_up', 'cancelled')),
  address_line TEXT,
  district VARCHAR(255),
  city VARCHAR(255),
  notes TEXT,
  cancelled_reason TEXT,
  confirmed_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_pickup_requests_store_date ON pickup_requests(store_id, requested_date, status);
CREATE INDEX IF NOT EXISTS idx_pickup_requests_customer ON pickup_requests(customer_id, status);

-- 5. ADDITIONAL INDEXES FOR EXISTING TABLES (performance)
CREATE INDEX IF NOT EXISTS idx_orders_store_created ON orders(store_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_customers_store ON customers(store_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);

-- =============================================================
-- ROW LEVEL SECURITY POLICIES
-- =============================================================

-- Enable RLS on new tables
ALTER TABLE customer_auth ENABLE ROW LEVEL SECURITY;
ALTER TABLE pickup_schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE pickup_blocked_dates ENABLE ROW LEVEL SECURITY;
ALTER TABLE pickup_requests ENABLE ROW LEVEL SECURITY;

-- Helper: check if current user is a staff member
-- (used in multiple policies)

-- CUSTOMER_AUTH policies
CREATE POLICY "Customers can read own auth" ON customer_auth
  FOR SELECT USING (auth.uid() = auth_id);

CREATE POLICY "Staff can manage customer_auth" ON customer_auth
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "Allow insert for new registrations" ON customer_auth
  FOR INSERT WITH CHECK (auth.uid() = auth_id);

-- PICKUP_SCHEDULES policies (public read, staff write)
CREATE POLICY "Anyone can read active schedules" ON pickup_schedules
  FOR SELECT USING (is_active = true);

CREATE POLICY "Staff can manage schedules" ON pickup_schedules
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid())
  );

-- PICKUP_BLOCKED_DATES policies (public read, staff write)
CREATE POLICY "Anyone can read blocked dates" ON pickup_blocked_dates
  FOR SELECT USING (true);

CREATE POLICY "Staff can manage blocked dates" ON pickup_blocked_dates
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid())
  );

-- PICKUP_REQUESTS policies
CREATE POLICY "Customers can read own pickup requests" ON pickup_requests
  FOR SELECT USING (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

CREATE POLICY "Customers can create pickup requests" ON pickup_requests
  FOR INSERT WITH CHECK (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

CREATE POLICY "Customers can update own pending requests" ON pickup_requests
  FOR UPDATE USING (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
    AND status IN ('pending', 'confirmed')
  );

CREATE POLICY "Staff can manage all pickup requests" ON pickup_requests
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE auth_id = auth.uid())
  );

-- ORDERS: customer can read their own orders
CREATE POLICY "Customers can read own orders" ON orders
  FOR SELECT USING (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

-- ORDER_ITEMS: customer can read items of their own orders
CREATE POLICY "Customers can read own order items" ON order_items
  FOR SELECT USING (
    order_id IN (
      SELECT id FROM orders WHERE customer_id IN (
        SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
      )
    )
  );

-- PAYMENTS: customer can read payments of their own orders
CREATE POLICY "Customers can read own payments" ON payments
  FOR SELECT USING (
    order_id IN (
      SELECT id FROM orders WHERE customer_id IN (
        SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid()
      )
    )
  );

-- CUSTOMER_LOYALTY: customer can read own loyalty
CREATE POLICY "Customers can read own loyalty" ON customer_loyalty
  FOR SELECT USING (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

-- LOYALTY_TRANSACTIONS: customer can read own transactions
CREATE POLICY "Customers can read own loyalty transactions" ON loyalty_transactions
  FOR SELECT USING (
    customer_id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

-- LOYALTY_SETTINGS: public read (needed to render loyalty page)
CREATE POLICY "Anyone can read loyalty settings" ON loyalty_settings
  FOR SELECT USING (true);

-- CUSTOMERS: customer can read and update their own record
CREATE POLICY "Customers can read own profile" ON customers
  FOR SELECT USING (
    id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

CREATE POLICY "Customers can update own profile" ON customers
  FOR UPDATE USING (
    id IN (SELECT customer_id FROM customer_auth WHERE auth_id = auth.uid())
  );

-- Allow new customer creation during registration
CREATE POLICY "Allow customer creation during registration" ON customers
  FOR INSERT WITH CHECK (true);
