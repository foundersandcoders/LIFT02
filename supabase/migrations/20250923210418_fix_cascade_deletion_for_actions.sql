-- Migration: Fix cascade deletion for actions when responses are deleted
-- This ensures that deleting a response automatically deletes all associated actions
-- instead of setting their response_id to NULL and creating orphaned records

-- ============================================================================
-- FIX ACTIONS FOREIGN KEY CONSTRAINT
-- ============================================================================

-- Drop the existing constraint that uses ON DELETE SET NULL
ALTER TABLE actions DROP CONSTRAINT IF EXISTS actions_response_id_fkey;

-- Add the corrected constraint with ON DELETE CASCADE
ALTER TABLE actions ADD CONSTRAINT actions_response_id_fkey
    FOREIGN KEY (response_id)
    REFERENCES responses(id)
    ON DELETE CASCADE;

-- ============================================================================
-- VERIFY OTHER CASCADE RELATIONSHIPS
-- ============================================================================

-- Ensure sharing_event_actions also cascade properly when actions are deleted
-- First check if this constraint exists and is correct
DO $$
BEGIN
    -- Check if the constraint exists with SET NULL
    IF EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'sharing_event_actions_action_id_fkey'
        AND pg_get_constraintdef(oid) LIKE '%ON DELETE SET NULL%'
    ) THEN
        -- Drop and recreate with CASCADE
        ALTER TABLE sharing_event_actions DROP CONSTRAINT sharing_event_actions_action_id_fkey;
        ALTER TABLE sharing_event_actions ADD CONSTRAINT sharing_event_actions_action_id_fkey
            FOREIGN KEY (action_id)
            REFERENCES actions(id)
            ON DELETE CASCADE;
    END IF;
END $$;

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON CONSTRAINT actions_response_id_fkey ON actions IS
'Actions are automatically deleted when their parent response is deleted (CASCADE)';

-- ============================================================================
-- VERIFICATION QUERY (for manual testing)
-- ============================================================================

-- To test this migration:
-- 1. Create a response with actions
-- 2. Delete the response
-- 3. Verify actions are automatically deleted

/*
Test case after applying migration:

-- Create test data
INSERT INTO responses (id, user_id, question_id, response_text)
VALUES ('test-response-id', 'test-user-id', 'test-question-id', 'Test response');

INSERT INTO actions (id, user_id, response_id, type, description, status)
VALUES ('test-action-id', 'test-user-id', 'test-response-id', 'test', 'Test action', 'active');

-- Verify action exists
SELECT COUNT(*) FROM actions WHERE response_id = 'test-response-id'; -- Should be 1

-- Delete response
DELETE FROM responses WHERE id = 'test-response-id';

-- Verify action was automatically deleted
SELECT COUNT(*) FROM actions WHERE id = 'test-action-id'; -- Should be 0
*/