-- Migration: Simplify actions table by removing versioning system
-- This removes the complex versioning mechanism and enables simple CRUD operations

-- Step 1: Remove the version column from actions table (this also removes dependency on sequence)
ALTER TABLE actions DROP COLUMN IF EXISTS version;

-- Step 2: Drop the version sequence (now safe to do after column removal)
DROP SEQUENCE IF EXISTS action_version_seq;

-- Step 3: Add a comment to document the simplified schema
COMMENT ON TABLE actions IS 'Actions table - simplified schema without versioning. Supports multiple actions per response with direct CRUD operations.';

-- Step 4: Update any existing indexes that might reference the version column
-- (none expected in current schema, but this ensures clean state)

-- Step 5: Verify the final schema
-- The actions table should now have: id, user_id, response_id, type, description, status, created_at, updated_at