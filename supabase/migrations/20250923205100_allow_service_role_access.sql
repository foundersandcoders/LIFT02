-- Migration: Allow service role access for development mode
-- This enables the app to work during development before magic link auth is implemented

-- ============================================================================
-- UPDATE PROFILES TABLE POLICIES TO ALLOW SERVICE ROLE ACCESS
-- ============================================================================

-- Drop existing policies to recreate them with service role access
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Users can insert own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
DROP POLICY IF EXISTS "Users can delete own profile" ON profiles;

-- Allow service role to access all profiles (for development)
-- Also allow authenticated users to access their own profiles (for production)
CREATE POLICY "Allow profile access" ON profiles
  FOR ALL USING (
    auth.role() = 'service_role' OR
    auth.uid() = user_id
  );

-- ============================================================================
-- UPDATE RESPONSES TABLE POLICIES TO ALLOW SERVICE ROLE ACCESS
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own responses" ON responses;
DROP POLICY IF EXISTS "Users can insert own responses" ON responses;
DROP POLICY IF EXISTS "Users can update own responses" ON responses;
DROP POLICY IF EXISTS "Users can delete own responses" ON responses;

CREATE POLICY "Allow responses access" ON responses
  FOR ALL USING (
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- ============================================================================
-- UPDATE ACTIONS TABLE POLICIES TO ALLOW SERVICE ROLE ACCESS
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own actions" ON actions;
DROP POLICY IF EXISTS "Users can insert own actions" ON actions;
DROP POLICY IF EXISTS "Users can update own actions" ON actions;
DROP POLICY IF EXISTS "Users can delete own actions" ON actions;

CREATE POLICY "Allow actions access" ON actions
  FOR ALL USING (
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- ============================================================================
-- UPDATE OTHER TABLE POLICIES FOR SERVICE ROLE ACCESS
-- ============================================================================

-- Sharing Events
DROP POLICY IF EXISTS "Users can view own sharing events" ON sharing_events;
DROP POLICY IF EXISTS "Users can insert own sharing events" ON sharing_events;
DROP POLICY IF EXISTS "Users can update own sharing events" ON sharing_events;
DROP POLICY IF EXISTS "Users can delete own sharing events" ON sharing_events;

CREATE POLICY "Allow sharing events access" ON sharing_events
  FOR ALL USING (
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Sharing Event Responses
DROP POLICY IF EXISTS "Users can view own sharing event responses" ON sharing_event_responses;
DROP POLICY IF EXISTS "Users can insert own sharing event responses" ON sharing_event_responses;
DROP POLICY IF EXISTS "Users can delete own sharing event responses" ON sharing_event_responses;

CREATE POLICY "Allow sharing event responses access" ON sharing_event_responses
  FOR ALL USING (
    auth.role() = 'service_role' OR
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Sharing Event Actions
DROP POLICY IF EXISTS "Users can view own sharing event actions" ON sharing_event_actions;
DROP POLICY IF EXISTS "Users can insert own sharing event actions" ON sharing_event_actions;
DROP POLICY IF EXISTS "Users can delete own sharing event actions" ON sharing_event_actions;

CREATE POLICY "Allow sharing event actions access" ON sharing_event_actions
  FOR ALL USING (
    auth.role() = 'service_role' OR
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Line Managers
DROP POLICY IF EXISTS "Users can view own line manager record" ON line_managers;
DROP POLICY IF EXISTS "Users can insert own line manager record" ON line_managers;
DROP POLICY IF EXISTS "Users can update own line manager record" ON line_managers;
DROP POLICY IF EXISTS "Users can delete own line manager record" ON line_managers;

CREATE POLICY "Allow line managers access" ON line_managers
  FOR ALL USING (
    auth.role() = 'service_role' OR
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- ============================================================================
-- COMMENT
-- ============================================================================

COMMENT ON TABLE profiles IS 'RLS enabled with service role bypass for development mode. Service role can access all data, authenticated users can only access their own data.';