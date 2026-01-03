-- Migration: Add workflow settings columns to companies table
-- Run this in your Supabase SQL Editor

-- Add workflow settings columns to companies table
ALTER TABLE companies 
ADD COLUMN IF NOT EXISTS default_completion_days INTEGER DEFAULT 1,
ADD COLUMN IF NOT EXISTS express_completion_days INTEGER DEFAULT 0;

-- Update existing companies with default values
UPDATE companies 
SET default_completion_days = 1, 
    express_completion_days = 0 
WHERE default_completion_days IS NULL;
