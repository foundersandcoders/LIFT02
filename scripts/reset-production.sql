-- Reset production database completely
-- WARNING: This will delete ALL data and recreate schema from scratch

-- Drop all tables (in reverse dependency order)
DROP TABLE IF EXISTS sharing_event_actions CASCADE;
DROP TABLE IF EXISTS sharing_event_responses CASCADE;
DROP TABLE IF EXISTS sharing_events CASCADE;
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS responses CASCADE;
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;

-- Drop sequences
DROP SEQUENCE IF EXISTS response_version_seq CASCADE;
DROP SEQUENCE IF EXISTS action_version_seq CASCADE;

-- Clear migration history
DELETE FROM supabase_migrations.schema_migrations;