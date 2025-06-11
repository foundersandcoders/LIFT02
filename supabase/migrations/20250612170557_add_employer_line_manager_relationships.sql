-- Add employers table and establish proper foreign key relationships
-- This migration creates the employers table and updates profiles to use proper FKs

-- 1. Create employers table
CREATE TABLE IF NOT EXISTS employers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

-- 2. Populate employers table from existing profile data
-- Extract unique employer names and create employer records
INSERT INTO employers (name)
SELECT DISTINCT employer_name
FROM profiles 
WHERE employer_name IS NOT NULL AND employer_name != ''
ON CONFLICT (name) DO NOTHING;

-- 3. Update profiles table to reference employers
-- Set employer_id based on employer_name
UPDATE profiles 
SET employer_id = (
  SELECT e.id 
  FROM employers e 
  WHERE e.name = profiles.employer_name
)
WHERE employer_name IS NOT NULL AND employer_name != '';

-- 4. Add foreign key constraint for employer_id
ALTER TABLE profiles 
ADD CONSTRAINT profiles_employer_id_fkey 
FOREIGN KEY (employer_id) REFERENCES employers(id) ON DELETE SET NULL;

-- 5. Add foreign key constraint for line_manager_user_id (hierarchical relationship)
-- This allows profiles to reference other users as their line managers
ALTER TABLE profiles 
ADD CONSTRAINT profiles_line_manager_fkey 
FOREIGN KEY (line_manager_user_id) REFERENCES auth.users(id) ON DELETE SET NULL;

-- 6. Rename line_manager_user_id to line_manager_id for clarity
ALTER TABLE profiles 
RENAME COLUMN line_manager_user_id TO line_manager_id;

-- 7. Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_profiles_employer_id ON profiles(employer_id);
CREATE INDEX IF NOT EXISTS idx_profiles_line_manager_id ON profiles(line_manager_id);
CREATE INDEX IF NOT EXISTS idx_employers_name ON employers(name);

-- 8. Add helpful comments
COMMENT ON TABLE employers IS 'Companies/organizations that employ users';
COMMENT ON COLUMN profiles.employer_id IS 'Foreign key to employers table - every profile has a direct employer relationship';
COMMENT ON COLUMN profiles.line_manager_id IS 'Foreign key to auth.users - points to another user who is this person''s line manager';