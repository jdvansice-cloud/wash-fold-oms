-- ============================================
-- Pickup Locations & Routing Migration
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Customer Saved Locations
CREATE TABLE IF NOT EXISTS customer_locations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  label VARCHAR(100) NOT NULL DEFAULT 'Casa',
  address_line TEXT NOT NULL,
  district VARCHAR(255),
  city VARCHAR(255) DEFAULT 'Panama',
  latitude NUMERIC(10, 7),
  longitude NUMERIC(10, 7),
  is_default BOOLEAN DEFAULT false,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_customer_locations_customer ON customer_locations(customer_id);

-- 2. Add location fields to pickup_requests
ALTER TABLE pickup_requests
  ADD COLUMN IF NOT EXISTS customer_location_id UUID REFERENCES customer_locations(id),
  ADD COLUMN IF NOT EXISTS latitude NUMERIC(10, 7),
  ADD COLUMN IF NOT EXISTS longitude NUMERIC(10, 7);

-- 3. Pickup Routes (driver routing)
CREATE TABLE IF NOT EXISTS pickup_routes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id UUID NOT NULL REFERENCES stores(id),
  route_date DATE NOT NULL,
  driver_name VARCHAR(255),
  status VARCHAR(20) DEFAULT 'planned' CHECK (status IN ('planned', 'in_progress', 'completed')),
  route_order JSONB DEFAULT '[]'::jsonb,
  notes TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_pickup_routes_store_date ON pickup_routes(store_id, route_date);

-- 4. Add route_id to pickup_requests
ALTER TABLE pickup_requests
  ADD COLUMN IF NOT EXISTS route_id UUID REFERENCES pickup_routes(id);

-- ============================================
-- Row Level Security
-- ============================================

ALTER TABLE customer_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE pickup_routes ENABLE ROW LEVEL SECURITY;

-- Customer locations: customers manage their own
CREATE POLICY "Customers can view own locations"
  ON customer_locations FOR SELECT
  USING (
    customer_id IN (
      SELECT ca.customer_id FROM customer_auth ca WHERE ca.auth_id = auth.uid()
    )
  );

CREATE POLICY "Customers can insert own locations"
  ON customer_locations FOR INSERT
  WITH CHECK (
    customer_id IN (
      SELECT ca.customer_id FROM customer_auth ca WHERE ca.auth_id = auth.uid()
    )
  );

CREATE POLICY "Customers can update own locations"
  ON customer_locations FOR UPDATE
  USING (
    customer_id IN (
      SELECT ca.customer_id FROM customer_auth ca WHERE ca.auth_id = auth.uid()
    )
  );

CREATE POLICY "Customers can delete own locations"
  ON customer_locations FOR DELETE
  USING (
    customer_id IN (
      SELECT ca.customer_id FROM customer_auth ca WHERE ca.auth_id = auth.uid()
    )
  );

-- Staff can read all customer locations
CREATE POLICY "Staff can view all locations"
  ON customer_locations FOR SELECT
  USING (
    auth.uid() IN (SELECT u.auth_id FROM users u WHERE u.is_active = true)
  );

-- Pickup routes: staff only
CREATE POLICY "Staff can manage routes"
  ON pickup_routes FOR ALL
  USING (
    auth.uid() IN (SELECT u.auth_id FROM users u WHERE u.is_active = true)
  );

-- Allow anon access for customer_locations (needed for portal queries with anon key)
CREATE POLICY "Anon can access customer_locations"
  ON customer_locations FOR ALL
  USING (true)
  WITH CHECK (true);

-- Allow anon access for pickup_routes
CREATE POLICY "Anon can access pickup_routes"
  ON pickup_routes FOR ALL
  USING (true)
  WITH CHECK (true);
