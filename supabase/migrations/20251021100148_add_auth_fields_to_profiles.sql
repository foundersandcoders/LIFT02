-- Add email and line manager fields to profiles
ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS email TEXT UNIQUE,
  ADD COLUMN IF NOT EXISTS line_manager_name TEXT,
  ADD COLUMN IF NOT EXISTS line_manager_email TEXT;

-- Add unique constraint on user_id (required for ON CONFLICT in trigger)
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_unique UNIQUE (user_id);

-- Create index for faster lookups (may already exist)
CREATE INDEX IF NOT EXISTS idx_profiles_user_id ON profiles(user_id);

-- Auto-create profile when user signs up
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (user_id, email, name, inserted_at, updated_at)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'name', ''),
    NOW(),
    NOW()
  )
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();

-- Sync email when auth.users email changes
CREATE OR REPLACE FUNCTION sync_profile_email()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE profiles
  SET email = NEW.email, updated_at = NOW()
  WHERE user_id = NEW.id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_email_updated ON auth.users;
CREATE TRIGGER on_auth_user_email_updated
  AFTER UPDATE OF email ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION sync_profile_email();

-- Enable RLS on all tables if not already enabled
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE actions ENABLE ROW LEVEL SECURITY;
ALTER TABLE sharing_events ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
DROP POLICY IF EXISTS "Users can insert own profile" ON profiles;
DROP POLICY IF EXISTS "Users can manage own responses" ON responses;
DROP POLICY IF EXISTS "Users can manage own actions" ON actions;
DROP POLICY IF EXISTS "Users can manage own sharing events" ON sharing_events;
DROP POLICY IF EXISTS "Service role full access profiles" ON profiles;
DROP POLICY IF EXISTS "Service role full access responses" ON responses;
DROP POLICY IF EXISTS "Service role full access actions" ON actions;
DROP POLICY IF EXISTS "Service role full access sharing_events" ON sharing_events;

-- Profiles: Users can read/update their own
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Responses: Users can CRUD their own
CREATE POLICY "Users can manage own responses"
  ON responses FOR ALL
  USING (auth.uid() = user_id);

-- Actions: Users can CRUD their own
CREATE POLICY "Users can manage own actions"
  ON actions FOR ALL
  USING (auth.uid() = user_id);

-- Sharing events: Users can manage their own
CREATE POLICY "Users can manage own sharing events"
  ON sharing_events FOR ALL
  USING (auth.uid() = user_id);

-- Service role has full access (for migrations/admin)
CREATE POLICY "Service role full access profiles"
  ON profiles FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

CREATE POLICY "Service role full access responses"
  ON responses FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

CREATE POLICY "Service role full access actions"
  ON actions FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

CREATE POLICY "Service role full access sharing_events"
  ON sharing_events FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');
