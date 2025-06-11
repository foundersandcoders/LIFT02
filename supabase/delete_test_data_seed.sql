-- Delete test data from all tables (keeping questions intact)
-- This file removes all user-generated data while preserving the questions

-- Delete in reverse dependency order to avoid foreign key constraint violations

-- 1. Delete sharing event links (no foreign key dependencies)
DELETE FROM sharing_event_actions;
DELETE FROM sharing_event_responses;

-- 2. Delete sharing events (referenced by sharing_event_actions and sharing_event_responses)
DELETE FROM sharing_events;

-- 3. Delete actions (referenced by sharing_event_actions)
DELETE FROM actions;

-- 4. Delete responses (referenced by sharing_event_responses and actions)
DELETE FROM responses;

-- 5. Delete profiles (no other tables reference this)
DELETE FROM profiles;

-- 6. Delete users from auth.users (referenced by profiles, responses, actions, sharing_events)
-- Note: This targets the fake test users by their specific UUIDs
DELETE FROM auth.users WHERE id IN (
    '550e8400-e29b-41d4-a716-446655440001',
    '550e8400-e29b-41d4-a716-446655440002', 
    '550e8400-e29b-41d4-a716-446655440003',
    '550e8400-e29b-41d4-a716-446655440004',
    '550e8400-e29b-41d4-a716-446655440005'
);

-- Reset sequences to ensure clean state
SELECT setval('response_version_seq', 1, false);
SELECT setval('action_version_seq', 1, false);

-- Verification queries (these will show row counts after deletion)
-- Uncomment to see results:
-- SELECT 'auth.users' as table_name, COUNT(*) as remaining_rows FROM auth.users
-- UNION ALL
-- SELECT 'profiles', COUNT(*) FROM profiles  
-- UNION ALL
-- SELECT 'responses', COUNT(*) FROM responses
-- UNION ALL 
-- SELECT 'actions', COUNT(*) FROM actions
-- UNION ALL
-- SELECT 'sharing_events', COUNT(*) FROM sharing_events
-- UNION ALL
-- SELECT 'sharing_event_responses', COUNT(*) FROM sharing_event_responses
-- UNION ALL
-- SELECT 'sharing_event_actions', COUNT(*) FROM sharing_event_actions
-- UNION ALL
-- SELECT 'questions', COUNT(*) FROM questions;