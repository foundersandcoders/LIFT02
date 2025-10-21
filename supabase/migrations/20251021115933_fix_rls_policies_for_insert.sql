-- Fix RLS policies to support INSERT operations
-- The previous policies used USING clause for ALL operations,
-- but INSERT requires WITH CHECK clause instead

-- Drop old policies
DROP POLICY IF EXISTS "Users can manage own responses" ON responses;
DROP POLICY IF EXISTS "Users can manage own actions" ON actions;
DROP POLICY IF EXISTS "Users can manage own sharing events" ON sharing_events;

-- Recreate policies with proper INSERT support
-- Responses: Users can read/update/delete their own, and insert with their user_id
CREATE POLICY "Users can select own responses"
  ON responses FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own responses"
  ON responses FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own responses"
  ON responses FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own responses"
  ON responses FOR DELETE
  USING (auth.uid() = user_id);

-- Actions: Users can read/update/delete their own, and insert with their user_id
CREATE POLICY "Users can select own actions"
  ON actions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own actions"
  ON actions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own actions"
  ON actions FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own actions"
  ON actions FOR DELETE
  USING (auth.uid() = user_id);

-- Sharing events: Users can read/update/delete their own, and insert with their user_id
CREATE POLICY "Users can select own sharing events"
  ON sharing_events FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own sharing events"
  ON sharing_events FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own sharing events"
  ON sharing_events FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own sharing events"
  ON sharing_events FOR DELETE
  USING (auth.uid() = user_id);
