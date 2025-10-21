-- Migration: Remove response versioning system
-- This simplifies responses to one record per user+question (like actions)
-- WARNING: This will delete old response versions, keeping only the latest

-- ============================================================================
-- STEP 1: BACKUP CURRENT STATE
-- ============================================================================

-- Create temporary backup table for safety
CREATE TABLE responses_backup AS
SELECT * FROM responses;

COMMENT ON TABLE responses_backup IS 'Backup of responses before removing versioning - can be dropped after verification';

-- ============================================================================
-- STEP 2: IDENTIFY AND PRESERVE LATEST VERSIONS ONLY
-- ============================================================================

-- First, identify the latest version for each user+question combination
CREATE TEMP TABLE latest_response_versions AS
SELECT user_id, question_id, MAX(version) as max_version
FROM responses
GROUP BY user_id, question_id;

-- Create temp table with only the responses we want to keep
CREATE TEMP TABLE responses_to_keep AS
SELECT r.*
FROM responses r
INNER JOIN latest_response_versions lrv ON
    r.user_id = lrv.user_id
    AND r.question_id = lrv.question_id
    AND r.version = lrv.max_version;

-- ============================================================================
-- STEP 3: UPDATE SHARING EVENT REFERENCES
-- ============================================================================

-- Update sharing_event_responses to point to the latest versions we're keeping
UPDATE sharing_event_responses
SET response_id = rtk.id
FROM responses_to_keep rtk, responses old_r
WHERE sharing_event_responses.response_id = old_r.id
  AND rtk.user_id = old_r.user_id
  AND rtk.question_id = old_r.question_id;

-- ============================================================================
-- STEP 4: DELETE OLD VERSIONS
-- ============================================================================

-- Delete all responses that are NOT in our "keep" list
DELETE FROM responses
WHERE id NOT IN (SELECT id FROM responses_to_keep);

-- ============================================================================
-- STEP 5: REMOVE VERSION COLUMN AND ADD CONSTRAINTS
-- ============================================================================

-- Drop the version column (no longer needed)
ALTER TABLE responses DROP COLUMN IF EXISTS version;

-- Drop the version sequence
DROP SEQUENCE IF EXISTS response_version_seq;

-- Add unique constraint to prevent future duplicates
ALTER TABLE responses ADD CONSTRAINT responses_user_question_unique
  UNIQUE (user_id, question_id);

-- ============================================================================
-- STEP 6: VERIFICATION QUERIES
-- ============================================================================

-- Verify no duplicate user+question combinations remain
-- (This should return 0 rows after migration)
/*
SELECT user_id, question_id, COUNT(*)
FROM responses
GROUP BY user_id, question_id
HAVING COUNT(*) > 1;
*/

-- ============================================================================
-- STEP 7: DOCUMENTATION
-- ============================================================================

COMMENT ON TABLE responses IS 'Responses table - simplified without versioning. One response per user+question combination.';
COMMENT ON CONSTRAINT responses_user_question_unique ON responses IS 'Ensures one response per user+question combination';

-- ============================================================================
-- CLEANUP INSTRUCTIONS (run manually after verification)
-- ============================================================================

/*
-- After verifying the migration worked correctly, you can drop the backup:
-- DROP TABLE responses_backup;
*/