-- =============================================
-- Wash & Fold OMS - Supabase Database Schema
-- American Laundry Panama
-- =============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- COMPANIES & STORES
-- =============================================

CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  ruc VARCHAR(50),
  dv VARCHAR(5),
  address TEXT,
  phone VARCHAR(50),
  logo_url TEXT,
  itbms_rate DECIMAL(5,2) DEFAULT 7.00,
  smtp_host VARCHAR(255),
  smtp_port INTEGER,
  smtp_user VARCHAR(255),
  smtp_pass VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE stores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  address TEXT,
  phone VARCHAR(50),
  geolocation JSONB,
  opening_hours JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- USERS
-- =============================================

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  auth_id UUID UNIQUE, -- Links to Supabase Auth
  store_id UUID REFERENCES stores(id),
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  initials VARCHAR(5),
  role VARCHAR(50) DEFAULT 'operator' CHECK (role IN ('admin', 'supervisor', 'operator')),
  avatar_url TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- SECTIONS & PRODUCTS
-- =============================================

CREATE TABLE sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(20) DEFAULT '#0077B6',
  display_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  is_online BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  section_id UUID REFERENCES sections(id) ON DELETE SET NULL,
  parent_id UUID REFERENCES products(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  icon VARCHAR(50),
  product_type VARCHAR(50) DEFAULT 'service' CHECK (product_type IN ('service', 'retail', 'delivery')),
  pricing_type VARCHAR(50) DEFAULT 'quantity' CHECK (pricing_type IN ('weight', 'quantity')),
  price DECIMAL(10,2) DEFAULT 0,
  express_price DECIMAL(10,2) DEFAULT 0,
  cost DECIMAL(10,2) DEFAULT 0,
  sku VARCHAR(100),
  stock INTEGER DEFAULT 0,
  min_stock INTEGER DEFAULT 0,
  pieces INTEGER DEFAULT 1,
  min_quantity DECIMAL(10,2) DEFAULT 0,
  extra_days INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  is_online BOOLEAN DEFAULT true,
  is_taxable BOOLEAN DEFAULT true,
  has_children BOOLEAN DEFAULT false,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- CUSTOMERS
-- =============================================

CREATE TABLE customers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(50),
  phone_country VARCHAR(10) DEFAULT '+507',
  address_street TEXT,
  address_building VARCHAR(255),
  address_corregimiento VARCHAR(255),
  address_district VARCHAR(255),
  address_province VARCHAR(255),
  id_type VARCHAR(50) CHECK (id_type IN ('cedula', 'passport', 'ruc')),
  id_number VARCHAR(100),
  company_name VARCHAR(255),
  ruc VARCHAR(50),
  dv VARCHAR(5),
  can_be_invoiced BOOLEAN DEFAULT false,
  account_balance DECIMAL(10,2) DEFAULT 0,
  preferences JSONB DEFAULT '{}',
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- ORDERS
-- =============================================

CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  order_number SERIAL,
  customer_name VARCHAR(255),
  is_walk_in BOOLEAN DEFAULT false,
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'washing', 'drying', 'folding', 'ready', 'completed', 'cancelled')),
  is_express BOOLEAN DEFAULT false,
  subtotal DECIMAL(10,2) DEFAULT 0,
  discount_amount DECIMAL(10,2) DEFAULT 0,
  delivery_charge DECIMAL(10,2) DEFAULT 0,
  tax_amount DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) DEFAULT 0,
  total_weight DECIMAL(10,2) DEFAULT 0,
  total_bags INTEGER DEFAULT 0,
  total_pieces INTEGER DEFAULT 0,
  notes TEXT,
  promised_date TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE order_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE SET NULL,
  product_name VARCHAR(255),
  quantity INTEGER DEFAULT 1,
  total_weight DECIMAL(10,2) DEFAULT 0,
  bags INTEGER DEFAULT 0,
  pieces INTEGER DEFAULT 0,
  unit_price DECIMAL(10,2) DEFAULT 0,
  line_total DECIMAL(10,2) DEFAULT 0,
  weight_entries JSONB DEFAULT '[]',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- PAYMENTS
-- =============================================

CREATE TABLE payment_methods (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(50),
  is_active BOOLEAN DEFAULT true,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  payment_method_id UUID REFERENCES payment_methods(id),
  payment_method VARCHAR(100),
  amount DECIMAL(10,2) NOT NULL,
  reference VARCHAR(255),
  change_amount DECIMAL(10,2) DEFAULT 0,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- INVOICES
-- =============================================

CREATE TABLE invoices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  invoice_number SERIAL,
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue', 'cancelled')),
  amount_due DECIMAL(10,2) NOT NULL,
  amount_paid DECIMAL(10,2) DEFAULT 0,
  due_date DATE,
  paid_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- REFUNDS
-- =============================================

CREATE TABLE refunds (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
  order_number INTEGER,
  customer_name VARCHAR(255),
  amount DECIMAL(10,2) NOT NULL,
  refund_type VARCHAR(50) DEFAULT 'full' CHECK (refund_type IN ('full', 'partial')),
  reason VARCHAR(255),
  notes TEXT,
  processed_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- GIFT CARDS
-- =============================================

CREATE TABLE gift_cards (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  code VARCHAR(50) UNIQUE NOT NULL,
  initial_value DECIMAL(10,2) NOT NULL,
  current_balance DECIMAL(10,2) NOT NULL,
  card_type VARCHAR(50) DEFAULT 'fixed' CHECK (card_type IN ('fixed', 'variable')),
  is_active BOOLEAN DEFAULT true,
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE gift_card_transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  gift_card_id UUID REFERENCES gift_cards(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
  amount DECIMAL(10,2) NOT NULL,
  transaction_type VARCHAR(50) CHECK (transaction_type IN ('credit', 'debit')),
  balance_after DECIMAL(10,2) NOT NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- PROMOTIONS
-- =============================================

CREATE TABLE promotions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  code VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  discount_type VARCHAR(50) DEFAULT 'percentage' CHECK (discount_type IN ('percentage', 'amount')),
  discount_value DECIMAL(10,2) NOT NULL,
  applies_to VARCHAR(50) DEFAULT 'ticket' CHECK (applies_to IN ('product', 'ticket')),
  min_purchase DECIMAL(10,2) DEFAULT 0,
  max_uses INTEGER,
  uses_count INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  valid_from TIMESTAMPTZ,
  valid_until TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- END OF DAY CLOSINGS
-- =============================================

CREATE TABLE eod_closings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  closing_date DATE NOT NULL,
  total_sales DECIMAL(10,2) DEFAULT 0,
  total_transactions INTEGER DEFAULT 0,
  avg_ticket DECIMAL(10,2) DEFAULT 0,
  total_weight DECIMAL(10,2) DEFAULT 0,
  cash_start DECIMAL(10,2) DEFAULT 0,
  cash_counted DECIMAL(10,2) DEFAULT 0,
  cash_difference DECIMAL(10,2) DEFAULT 0,
  payment_breakdown JSONB DEFAULT '{}',
  total_discounts DECIMAL(10,2) DEFAULT 0,
  total_refunds DECIMAL(10,2) DEFAULT 0,
  notes TEXT,
  closed_by UUID REFERENCES users(id),
  closed_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- STOCK MOVEMENTS
-- =============================================

CREATE TABLE stock_movements (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  movement_type VARCHAR(50) CHECK (movement_type IN ('purchase', 'sale', 'adjustment', 'return')),
  quantity INTEGER NOT NULL,
  unit_cost DECIMAL(10,2),
  reason VARCHAR(255),
  reference VARCHAR(255),
  notes TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- MACHINES (Washers/Dryers)
-- =============================================

CREATE TABLE machines (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  machine_type VARCHAR(50) CHECK (machine_type IN ('washer', 'dryer')),
  cycle_time INTEGER DEFAULT 30, -- minutes
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- INDEXES
-- =============================================

CREATE INDEX idx_products_store ON products(store_id);
CREATE INDEX idx_products_section ON products(section_id);
CREATE INDEX idx_customers_store ON customers(store_id);
CREATE INDEX idx_orders_store ON orders(store_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created ON orders(created_at DESC);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_payments_order ON payments(order_id);
CREATE INDEX idx_invoices_customer ON invoices(customer_id);

-- =============================================
-- ROW LEVEL SECURITY (RLS)
-- =============================================

ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- For now, allow all operations (you can tighten this later with proper auth)
CREATE POLICY "Allow all" ON companies FOR ALL USING (true);
CREATE POLICY "Allow all" ON stores FOR ALL USING (true);
CREATE POLICY "Allow all" ON users FOR ALL USING (true);
CREATE POLICY "Allow all" ON sections FOR ALL USING (true);
CREATE POLICY "Allow all" ON products FOR ALL USING (true);
CREATE POLICY "Allow all" ON customers FOR ALL USING (true);
CREATE POLICY "Allow all" ON orders FOR ALL USING (true);
CREATE POLICY "Allow all" ON order_items FOR ALL USING (true);
CREATE POLICY "Allow all" ON payment_methods FOR ALL USING (true);
CREATE POLICY "Allow all" ON payments FOR ALL USING (true);

-- =============================================
-- SEED DATA - American Laundry Panama
-- =============================================

-- Insert Company
INSERT INTO companies (id, name, ruc, dv, address, phone, itbms_rate) VALUES 
('00000000-0000-0000-0000-000000000001', 'American Laundry', '155737034', '2', 'Panamá, Panamá', '+507 6789-0000', 7.00);

-- Insert Store
INSERT INTO stores (id, company_id, name, address, is_active) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'American Laundry - Principal', 'Ciudad de Panamá', true);

-- Insert Default User
INSERT INTO users (id, store_id, email, full_name, initials, role) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'admin@americanlaundry.com', 'Juan VanSice', 'JV', 'admin');

-- Insert Sections
INSERT INTO sections (id, store_id, name, color, display_order, is_active, is_online) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Lava y Dobla', '#0077B6', 1, true, true),
('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Lavamático', '#38B000', 2, true, true),
('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'Productos', '#F48C06', 3, true, true),
('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 'Entregas', '#9333EA', 4, true, false);

-- Insert Products - Lava y Dobla
INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, express_price, is_taxable) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Lava y Dobla (por kg)', '👕', 'service', 'weight', 2.50, 3.50, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Seca y Dobla (por kg)', '🌀', 'service', 'weight', 1.75, 2.50, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Cortinas', '🪟', 'service', 'quantity', 10.00, 15.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Almohadas', '🛏️', 'service', 'quantity', 6.00, 8.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Sábanas', '🛏️', 'service', 'quantity', 8.00, 12.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Toallas', '🧴', 'service', 'quantity', 2.00, 3.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Sobrecamas', '🛋️', 'service', 'quantity', 15.00, 20.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Mantel', '🍽️', 'service', 'quantity', 5.00, 7.00, true);

-- Insert Products - Lavamático
INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, is_taxable) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Lavadora Pequeña', '🧺', 'service', 'quantity', 3.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Lavadora Grande', '🧺', 'service', 'quantity', 5.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Secadora 30 min', '🌀', 'service', 'quantity', 2.00, true);

-- Insert Products - Retail
INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, cost, sku, stock, min_stock, is_taxable) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'Detergente (1L)', '🧴', 'retail', 'quantity', 5.50, 3.00, 'DET-001', 25, 5, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'Suavizante (1L)', '🌸', 'retail', 'quantity', 4.50, 2.50, 'SUV-001', 20, 5, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'Bolsa de Lavandería', '👜', 'retail', 'quantity', 8.00, 4.00, 'BOL-001', 15, 3, true);

-- Insert Products - Delivery
INSERT INTO products (store_id, section_id, name, icon, product_type, pricing_type, price, is_taxable) VALUES 
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004', 'Recogida Local', '🚗', 'delivery', 'quantity', 3.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004', 'Entrega Local', '🚚', 'delivery', 'quantity', 3.00, true),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004', 'Recogida + Entrega', '📦', 'delivery', 'quantity', 5.00, true);

-- Insert Payment Methods
INSERT INTO payment_methods (store_id, name, icon, is_active, display_order) VALUES 
('00000000-0000-0000-0000-000000000001', 'Efectivo', '💵', true, 1),
('00000000-0000-0000-0000-000000000001', 'Tarjeta', '💳', true, 2),
('00000000-0000-0000-0000-000000000001', 'Yappy', '📱', true, 3),
('00000000-0000-0000-0000-000000000001', 'ACH', '🏦', true, 4),
('00000000-0000-0000-0000-000000000001', 'Pagar en Recogida', '🧾', true, 5),
('00000000-0000-0000-0000-000000000001', 'Factura', '📄', true, 6);

-- Insert Sample Customers
INSERT INTO customers (store_id, first_name, last_name, email, phone, phone_country, address_street, address_corregimiento, address_district, address_province, id_type, id_number) VALUES 
('00000000-0000-0000-0000-000000000001', 'María', 'González', 'maria@email.com', '6789-1234', '+507', 'Calle 50, Torre Global', 'Bella Vista', 'Panamá', 'Panamá', 'cedula', '8-123-4567'),
('00000000-0000-0000-0000-000000000001', 'Carlos', 'Rodríguez', 'carlos@empresa.com', '6555-9876', '+507', 'Ave. Balboa, PH Oceanía', 'San Francisco', 'Panamá', 'Panamá', 'ruc', '155737034-2-2023'),
('00000000-0000-0000-0000-000000000001', 'Ana', 'Martínez', 'ana.m@gmail.com', '6234-5678', '+507', 'Costa del Este', 'Parque Lefevre', 'Panamá', 'Panamá', 'cedula', '8-987-6543');

-- Success message
SELECT 'Database schema created and seeded successfully!' as message;
