-- Add legal_name to companies and fix American Laundry data
ALTER TABLE companies ADD COLUMN IF NOT EXISTS legal_name VARCHAR(500);

-- Update American Laundry: name = commercial name, legal_name = legal entity
UPDATE companies
SET legal_name = 'Avalco Enterprises Inc, S.A.',
    name = 'American Laundry'
WHERE slug = 'american-laundry';
