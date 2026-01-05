-- Loyalty System Migration
-- Run this in Supabase SQL Editor

-- =====================================================
-- LOYALTY SETTINGS TABLE
-- Store program configurations per company/store
-- =====================================================
CREATE TABLE IF NOT EXISTS public.loyalty_settings (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  store_id uuid REFERENCES public.stores(id),
  
  -- Punch Card Settings (Lavamático)
  punch_card_enabled boolean DEFAULT false,
  wash_punches_required integer DEFAULT 9,        -- Punches needed for free wash
  dry_punches_required integer DEFAULT 9,         -- Punches needed for free dry
  punch_card_expiry_days integer DEFAULT 365,     -- Days until punches expire (0 = never)
  
  -- Points/Money Program Settings (Cashback)
  points_enabled boolean DEFAULT false,
  points_per_dollar numeric(10,4) DEFAULT 0.05,   -- Points earned per dollar spent (e.g., 0.05 = 5%)
  min_redemption_amount numeric(10,2) DEFAULT 5.00, -- Minimum balance to redeem
  points_expiry_days integer DEFAULT 365,         -- Days until points expire (0 = never)
  
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  
  CONSTRAINT loyalty_settings_pkey PRIMARY KEY (id)
);

-- =====================================================
-- CUSTOMER LOYALTY TABLE
-- Track individual customer loyalty status
-- =====================================================
CREATE TABLE IF NOT EXISTS public.customer_loyalty (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  customer_id uuid NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
  store_id uuid REFERENCES public.stores(id),
  
  -- Punch Card Tracking (Lavamático)
  wash_punches integer DEFAULT 0,                 -- Current wash punches
  dry_punches integer DEFAULT 0,                  -- Current dry punches
  total_free_washes_earned integer DEFAULT 0,     -- Lifetime free washes earned
  total_free_drys_earned integer DEFAULT 0,       -- Lifetime free drys earned
  pending_free_washes integer DEFAULT 0,          -- Available free washes to redeem
  pending_free_drys integer DEFAULT 0,            -- Available free drys to redeem
  last_punch_date timestamp with time zone,       -- For expiry calculation
  
  -- Points/Money Tracking (Cashback)
  points_balance numeric(10,2) DEFAULT 0,         -- Current points balance (in dollars)
  total_points_earned numeric(10,2) DEFAULT 0,    -- Lifetime points earned
  total_points_redeemed numeric(10,2) DEFAULT 0,  -- Lifetime points redeemed
  last_points_date timestamp with time zone,      -- For expiry calculation
  
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  
  CONSTRAINT customer_loyalty_pkey PRIMARY KEY (id),
  CONSTRAINT customer_loyalty_customer_unique UNIQUE (customer_id)
);

-- =====================================================
-- LOYALTY TRANSACTIONS TABLE
-- Log all loyalty activity for audit trail
-- =====================================================
CREATE TABLE IF NOT EXISTS public.loyalty_transactions (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  customer_id uuid NOT NULL REFERENCES public.customers(id),
  store_id uuid REFERENCES public.stores(id),
  order_id uuid REFERENCES public.orders(id),
  
  transaction_type varchar NOT NULL CHECK (transaction_type IN (
    'punch_wash',           -- Earned a wash punch
    'punch_dry',            -- Earned a dry punch
    'redeem_free_wash',     -- Redeemed free wash
    'redeem_free_dry',      -- Redeemed free dry
    'free_wash_earned',     -- Completed punch card for wash
    'free_dry_earned',      -- Completed punch card for dry
    'points_earned',        -- Earned points from purchase
    'points_redeemed',      -- Redeemed points for discount
    'points_expired',       -- Points expired
    'punches_expired',      -- Punches expired
    'manual_adjustment'     -- Manual adjustment by admin
  )),
  
  -- For punch transactions
  punch_count integer DEFAULT 0,                  -- Number of punches (positive or negative)
  punches_before integer DEFAULT 0,               -- Punch count before transaction
  punches_after integer DEFAULT 0,                -- Punch count after transaction
  
  -- For points transactions
  points_amount numeric(10,2) DEFAULT 0,          -- Points amount (positive or negative)
  balance_before numeric(10,2) DEFAULT 0,         -- Balance before transaction
  balance_after numeric(10,2) DEFAULT 0,          -- Balance after transaction
  order_subtotal numeric(10,2) DEFAULT 0,         -- Order subtotal that generated points
  
  notes text,
  created_by uuid REFERENCES public.users(id),
  created_at timestamp with time zone DEFAULT now(),
  
  CONSTRAINT loyalty_transactions_pkey PRIMARY KEY (id)
);

-- =====================================================
-- INDEXES
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_loyalty_settings_store ON public.loyalty_settings(store_id);
CREATE INDEX IF NOT EXISTS idx_customer_loyalty_customer ON public.customer_loyalty(customer_id);
CREATE INDEX IF NOT EXISTS idx_customer_loyalty_store ON public.customer_loyalty(store_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_transactions_customer ON public.loyalty_transactions(customer_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_transactions_order ON public.loyalty_transactions(order_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_transactions_type ON public.loyalty_transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_loyalty_transactions_date ON public.loyalty_transactions(created_at);

-- =====================================================
-- INSERT DEFAULT SETTINGS FOR EXISTING STORES
-- =====================================================
INSERT INTO public.loyalty_settings (store_id, punch_card_enabled, points_enabled)
SELECT id, false, false 
FROM public.stores 
WHERE is_active = true
  AND id NOT IN (SELECT store_id FROM public.loyalty_settings WHERE store_id IS NOT NULL)
ON CONFLICT DO NOTHING;

-- =====================================================
-- DISABLE RLS (for development)
-- =====================================================
ALTER TABLE public.loyalty_settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.customer_loyalty DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.loyalty_transactions DISABLE ROW LEVEL SECURITY;

-- =====================================================
-- HELPER FUNCTION: Get or Create Customer Loyalty Record
-- =====================================================
CREATE OR REPLACE FUNCTION get_or_create_customer_loyalty(
  p_customer_id uuid,
  p_store_id uuid
) RETURNS uuid AS $$
DECLARE
  v_loyalty_id uuid;
BEGIN
  -- Try to find existing record
  SELECT id INTO v_loyalty_id
  FROM public.customer_loyalty
  WHERE customer_id = p_customer_id;
  
  -- Create if not exists
  IF v_loyalty_id IS NULL THEN
    INSERT INTO public.customer_loyalty (customer_id, store_id)
    VALUES (p_customer_id, p_store_id)
    RETURNING id INTO v_loyalty_id;
  END IF;
  
  RETURN v_loyalty_id;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- FUNCTION: Add Punch to Customer Card
-- =====================================================
CREATE OR REPLACE FUNCTION add_loyalty_punch(
  p_customer_id uuid,
  p_store_id uuid,
  p_punch_type varchar, -- 'wash' or 'dry'
  p_punch_count integer DEFAULT 1,
  p_order_id uuid DEFAULT NULL,
  p_created_by uuid DEFAULT NULL
) RETURNS jsonb AS $$
DECLARE
  v_loyalty_id uuid;
  v_settings record;
  v_current_punches integer;
  v_new_punches integer;
  v_punches_required integer;
  v_free_earned boolean := false;
  v_result jsonb;
BEGIN
  -- Get loyalty settings
  SELECT * INTO v_settings
  FROM public.loyalty_settings
  WHERE store_id = p_store_id;
  
  IF NOT FOUND OR NOT v_settings.punch_card_enabled THEN
    RETURN jsonb_build_object('success', false, 'error', 'Punch card not enabled');
  END IF;
  
  -- Get or create customer loyalty record
  v_loyalty_id := get_or_create_customer_loyalty(p_customer_id, p_store_id);
  
  -- Get current punches and required punches
  IF p_punch_type = 'wash' THEN
    SELECT wash_punches INTO v_current_punches FROM customer_loyalty WHERE id = v_loyalty_id;
    v_punches_required := v_settings.wash_punches_required;
  ELSE
    SELECT dry_punches INTO v_current_punches FROM customer_loyalty WHERE id = v_loyalty_id;
    v_punches_required := v_settings.dry_punches_required;
  END IF;
  
  v_new_punches := v_current_punches + p_punch_count;
  
  -- Check if free service earned
  IF v_new_punches >= v_punches_required THEN
    v_free_earned := true;
    v_new_punches := v_new_punches - v_punches_required; -- Reset with remainder
  END IF;
  
  -- Update customer loyalty
  IF p_punch_type = 'wash' THEN
    UPDATE customer_loyalty
    SET wash_punches = v_new_punches,
        total_free_washes_earned = total_free_washes_earned + CASE WHEN v_free_earned THEN 1 ELSE 0 END,
        pending_free_washes = pending_free_washes + CASE WHEN v_free_earned THEN 1 ELSE 0 END,
        last_punch_date = now(),
        updated_at = now()
    WHERE id = v_loyalty_id;
  ELSE
    UPDATE customer_loyalty
    SET dry_punches = v_new_punches,
        total_free_drys_earned = total_free_drys_earned + CASE WHEN v_free_earned THEN 1 ELSE 0 END,
        pending_free_drys = pending_free_drys + CASE WHEN v_free_earned THEN 1 ELSE 0 END,
        last_punch_date = now(),
        updated_at = now()
    WHERE id = v_loyalty_id;
  END IF;
  
  -- Log transaction
  INSERT INTO loyalty_transactions (
    customer_id, store_id, order_id, transaction_type,
    punch_count, punches_before, punches_after, created_by
  ) VALUES (
    p_customer_id, p_store_id, p_order_id,
    'punch_' || p_punch_type,
    p_punch_count, v_current_punches, v_new_punches, p_created_by
  );
  
  -- Log free service earned if applicable
  IF v_free_earned THEN
    INSERT INTO loyalty_transactions (
      customer_id, store_id, order_id, transaction_type, notes, created_by
    ) VALUES (
      p_customer_id, p_store_id, p_order_id,
      'free_' || p_punch_type || '_earned',
      'Completó ' || v_punches_required || ' sellos',
      p_created_by
    );
  END IF;
  
  RETURN jsonb_build_object(
    'success', true,
    'punches_before', v_current_punches,
    'punches_after', v_new_punches,
    'free_earned', v_free_earned,
    'punches_to_next_free', v_punches_required - v_new_punches
  );
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- FUNCTION: Add Points to Customer Account
-- =====================================================
CREATE OR REPLACE FUNCTION add_loyalty_points(
  p_customer_id uuid,
  p_store_id uuid,
  p_order_subtotal numeric,
  p_order_id uuid DEFAULT NULL,
  p_created_by uuid DEFAULT NULL
) RETURNS jsonb AS $$
DECLARE
  v_loyalty_id uuid;
  v_settings record;
  v_points_earned numeric;
  v_balance_before numeric;
  v_balance_after numeric;
BEGIN
  -- Get loyalty settings
  SELECT * INTO v_settings
  FROM public.loyalty_settings
  WHERE store_id = p_store_id;
  
  IF NOT FOUND OR NOT v_settings.points_enabled THEN
    RETURN jsonb_build_object('success', false, 'error', 'Points program not enabled');
  END IF;
  
  -- Calculate points earned
  v_points_earned := ROUND(p_order_subtotal * v_settings.points_per_dollar, 2);
  
  IF v_points_earned <= 0 THEN
    RETURN jsonb_build_object('success', false, 'error', 'No points to earn');
  END IF;
  
  -- Get or create customer loyalty record
  v_loyalty_id := get_or_create_customer_loyalty(p_customer_id, p_store_id);
  
  -- Get current balance
  SELECT points_balance INTO v_balance_before FROM customer_loyalty WHERE id = v_loyalty_id;
  v_balance_after := v_balance_before + v_points_earned;
  
  -- Update customer loyalty
  UPDATE customer_loyalty
  SET points_balance = v_balance_after,
      total_points_earned = total_points_earned + v_points_earned,
      last_points_date = now(),
      updated_at = now()
  WHERE id = v_loyalty_id;
  
  -- Log transaction
  INSERT INTO loyalty_transactions (
    customer_id, store_id, order_id, transaction_type,
    points_amount, balance_before, balance_after, order_subtotal, created_by
  ) VALUES (
    p_customer_id, p_store_id, p_order_id,
    'points_earned',
    v_points_earned, v_balance_before, v_balance_after, p_order_subtotal, p_created_by
  );
  
  RETURN jsonb_build_object(
    'success', true,
    'points_earned', v_points_earned,
    'balance_before', v_balance_before,
    'balance_after', v_balance_after,
    'min_redemption', v_settings.min_redemption_amount,
    'can_redeem', v_balance_after >= v_settings.min_redemption_amount
  );
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- FUNCTION: Redeem Loyalty Points
-- =====================================================
CREATE OR REPLACE FUNCTION redeem_loyalty_points(
  p_customer_id uuid,
  p_store_id uuid,
  p_amount numeric,
  p_order_id uuid DEFAULT NULL,
  p_created_by uuid DEFAULT NULL
) RETURNS jsonb AS $$
DECLARE
  v_loyalty_id uuid;
  v_settings record;
  v_balance_before numeric;
  v_balance_after numeric;
BEGIN
  -- Get loyalty settings
  SELECT * INTO v_settings
  FROM public.loyalty_settings
  WHERE store_id = p_store_id;
  
  IF NOT FOUND OR NOT v_settings.points_enabled THEN
    RETURN jsonb_build_object('success', false, 'error', 'Points program not enabled');
  END IF;
  
  -- Get customer loyalty record
  SELECT id, points_balance INTO v_loyalty_id, v_balance_before
  FROM customer_loyalty
  WHERE customer_id = p_customer_id;
  
  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'No loyalty record found');
  END IF;
  
  -- Validate redemption
  IF v_balance_before < v_settings.min_redemption_amount THEN
    RETURN jsonb_build_object(
      'success', false, 
      'error', 'Balance below minimum redemption amount',
      'balance', v_balance_before,
      'min_required', v_settings.min_redemption_amount
    );
  END IF;
  
  IF p_amount > v_balance_before THEN
    RETURN jsonb_build_object('success', false, 'error', 'Insufficient balance');
  END IF;
  
  v_balance_after := v_balance_before - p_amount;
  
  -- Update customer loyalty
  UPDATE customer_loyalty
  SET points_balance = v_balance_after,
      total_points_redeemed = total_points_redeemed + p_amount,
      updated_at = now()
  WHERE id = v_loyalty_id;
  
  -- Log transaction
  INSERT INTO loyalty_transactions (
    customer_id, store_id, order_id, transaction_type,
    points_amount, balance_before, balance_after, created_by
  ) VALUES (
    p_customer_id, p_store_id, p_order_id,
    'points_redeemed',
    -p_amount, v_balance_before, v_balance_after, p_created_by
  );
  
  RETURN jsonb_build_object(
    'success', true,
    'amount_redeemed', p_amount,
    'balance_before', v_balance_before,
    'balance_after', v_balance_after
  );
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- VERIFICATION
-- =====================================================
SELECT 'loyalty_settings' as table_name, COUNT(*) as row_count FROM public.loyalty_settings
UNION ALL
SELECT 'customer_loyalty', COUNT(*) FROM public.customer_loyalty
UNION ALL
SELECT 'loyalty_transactions', COUNT(*) FROM public.loyalty_transactions;

