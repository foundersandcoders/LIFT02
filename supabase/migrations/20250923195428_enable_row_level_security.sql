-- Migration: Enable Row Level Security for all user-related tables
-- This addresses a critical security vulnerability where no RLS was implemented

-- Enable RLS on all user-related tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE actions ENABLE ROW LEVEL SECURITY;
ALTER TABLE sharing_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE sharing_event_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE sharing_event_actions ENABLE ROW LEVEL SECURITY;
ALTER TABLE line_managers ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- PROFILES TABLE POLICIES
-- ============================================================================

-- Users can view their own profile
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = user_id);

-- Users can insert their own profile (during registration)
CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = user_id);

-- Users can delete their own profile
CREATE POLICY "Users can delete own profile" ON profiles
  FOR DELETE USING (auth.uid() = user_id);

-- ============================================================================
-- RESPONSES TABLE POLICIES
-- ============================================================================

-- Users can view their own responses
CREATE POLICY "Users can view own responses" ON responses
  FOR SELECT USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can insert their own responses
CREATE POLICY "Users can insert own responses" ON responses
  FOR INSERT WITH CHECK (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can update their own responses
CREATE POLICY "Users can update own responses" ON responses
  FOR UPDATE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can delete their own responses
CREATE POLICY "Users can delete own responses" ON responses
  FOR DELETE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- ============================================================================
-- ACTIONS TABLE POLICIES
-- ============================================================================

-- Users can view their own actions
CREATE POLICY "Users can view own actions" ON actions
  FOR SELECT USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can insert their own actions
CREATE POLICY "Users can insert own actions" ON actions
  FOR INSERT WITH CHECK (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can update their own actions
CREATE POLICY "Users can update own actions" ON actions
  FOR UPDATE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can delete their own actions
CREATE POLICY "Users can delete own actions" ON actions
  FOR DELETE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- ============================================================================
-- SHARING_EVENTS TABLE POLICIES
-- ============================================================================

-- Users can view their own sharing events
CREATE POLICY "Users can view own sharing events" ON sharing_events
  FOR SELECT USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can insert their own sharing events
CREATE POLICY "Users can insert own sharing events" ON sharing_events
  FOR INSERT WITH CHECK (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can update their own sharing events
CREATE POLICY "Users can update own sharing events" ON sharing_events
  FOR UPDATE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Users can delete their own sharing events
CREATE POLICY "Users can delete own sharing events" ON sharing_events
  FOR DELETE USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- ============================================================================
-- SHARING_EVENT_RESPONSES TABLE POLICIES
-- ============================================================================

-- Users can view sharing event responses for their own sharing events
CREATE POLICY "Users can view own sharing event responses" ON sharing_event_responses
  FOR SELECT USING (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Users can insert sharing event responses for their own sharing events
CREATE POLICY "Users can insert own sharing event responses" ON sharing_event_responses
  FOR INSERT WITH CHECK (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Users can delete sharing event responses for their own sharing events
CREATE POLICY "Users can delete own sharing event responses" ON sharing_event_responses
  FOR DELETE USING (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- ============================================================================
-- SHARING_EVENT_ACTIONS TABLE POLICIES
-- ============================================================================

-- Users can view sharing event actions for their own sharing events
CREATE POLICY "Users can view own sharing event actions" ON sharing_event_actions
  FOR SELECT USING (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Users can insert sharing event actions for their own sharing events
CREATE POLICY "Users can insert own sharing event actions" ON sharing_event_actions
  FOR INSERT WITH CHECK (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- Users can delete sharing event actions for their own sharing events
CREATE POLICY "Users can delete own sharing event actions" ON sharing_event_actions
  FOR DELETE USING (
    sharing_event_id IN (
      SELECT id FROM sharing_events
      WHERE user_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
    )
  );

-- ============================================================================
-- LINE_MANAGERS TABLE POLICIES
-- ============================================================================

-- Users can view their own line manager record
CREATE POLICY "Users can view own line manager record" ON line_managers
  FOR SELECT USING (
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Users can insert their own line manager record
CREATE POLICY "Users can insert own line manager record" ON line_managers
  FOR INSERT WITH CHECK (
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Users can update their own line manager record
CREATE POLICY "Users can update own line manager record" ON line_managers
  FOR UPDATE USING (
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- Users can delete their own line manager record
CREATE POLICY "Users can delete own line manager record" ON line_managers
  FOR DELETE USING (
    line_manager_id = (SELECT id FROM profiles WHERE user_id = auth.uid())
  );

-- ============================================================================
-- NOTES
-- ============================================================================

-- Tables NOT included (public read access by design):
-- - questions: Public survey questions, no user-specific data
-- - organizations: Public organizational data
-- - resources: Public resource data

-- Important: This migration addresses a critical security vulnerability
-- where user data was accessible without proper access controls.