-- =============================================
-- Wash & Fold OMS - NUCLEAR Database Reset
-- Drops and recreates the ENTIRE public schema
-- Run this BEFORE running supabase-schema.sql
-- =============================================

-- Step 1: Drop the entire public schema (removes EVERYTHING)
DROP SCHEMA public CASCADE;

-- Step 2: Recreate the public schema
CREATE SCHEMA public;

-- Step 3: Restore default permissions
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

-- Step 4: Reset the schema comment (optional)
COMMENT ON SCHEMA public IS 'standard public schema';

-- Verify it's clean
SELECT 'Schema reset complete! Tables remaining: ' || COUNT(*)::text as status 
FROM information_schema.tables 
WHERE table_schema = 'public';
