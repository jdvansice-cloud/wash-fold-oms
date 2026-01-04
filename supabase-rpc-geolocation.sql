-- =============================================
-- RPC Function to Update Store Geolocation
-- Run this in Supabase SQL Editor
-- =============================================

-- Drop if exists
DROP FUNCTION IF EXISTS update_store_geolocation(uuid, numeric, numeric);

-- Create the function
CREATE OR REPLACE FUNCTION update_store_geolocation(
  store_id uuid,
  lat numeric,
  lng numeric
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE stores 
  SET 
    geolocation = jsonb_build_object('lat', lat, 'lng', lng),
    updated_at = NOW()
  WHERE id = store_id;
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION update_store_geolocation(uuid, numeric, numeric) TO anon;
GRANT EXECUTE ON FUNCTION update_store_geolocation(uuid, numeric, numeric) TO authenticated;

-- Test it (replace with actual store ID)
-- SELECT update_store_geolocation('your-store-uuid-here', 9.06145, -79.42173);
