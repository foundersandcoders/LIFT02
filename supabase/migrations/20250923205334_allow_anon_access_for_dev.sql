-- Migration: Allow anon access for development mode
-- This enables the app to work with anon key during development

-- ============================================================================
-- UPDATE ALL TABLE POLICIES TO ALLOW ANON ACCESS FOR DEVELOPMENT
-- ============================================================================

-- Profiles
DROP POLICY IF EXISTS "Allow profile access" ON profiles;
CREATE POLICY "Allow profile access" ON profiles
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    auth.uid() = user_id
  );

-- Responses
DROP POLICY IF EXISTS "Allow responses access" ON responses;
CREATE POLICY "Allow responses access" ON responses
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Actions
DROP POLICY IF EXISTS "Allow actions access" ON actions;
CREATE POLICY "Allow actions access" ON actions
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Sharing Events
DROP POLICY IF EXISTS "Allow sharing events access" ON sharing_events;
CREATE POLICY "Allow sharing events access" ON sharing_events
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Sharing Event Responses
DROP POLICY IF EXISTS "Allow sharing event responses access" ON sharing_event_responses;
CREATE POLICY "Allow sharing event responses access" ON sharing_event_responses
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Sharing Event Actions
DROP POLICY IF EXISTS "Allow sharing event actions access" ON sharing_event_actions;
CREATE POLICY "Allow sharing event actions access" ON sharing_event_actions
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Line Managers
DROP POLICY IF EXISTS "Allow line managers access" ON line_managers;
CREATE POLICY "Allow line managers access" ON line_managers
  FOR ALL USING (
    auth.role() = 'anon' OR
    auth.role() = 'service_role' OR
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- ============================================================================
-- COMMENT
-- ============================================================================

COMMENT ON TABLE profiles IS 'RLS enabled with anon and service role bypass for development mode. In production, remove anon access and only allow authenticated users their own data.';