-- Delete all fake test data from tables (keeping questions intact)
-- This file is auto-generated from data/test_data_source.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate

-- Delete in reverse dependency order to avoid foreign key constraint violations
-- Only deletes data related to specific test users to avoid affecting real data

-- 1. Delete sharing event links for test users
DELETE FROM sharing_event_actions 
WHERE action_id IN (
    SELECT a.id FROM actions a 
    WHERE a.user_id IN (
        '550e8400-e29b-41d4-a716-446655440001'::uuid,
        '550e8400-e29b-41d4-a716-446655440002'::uuid,
        '550e8400-e29b-41d4-a716-446655440003'::uuid,
        '550e8400-e29b-41d4-a716-446655440004'::uuid,
        '550e8400-e29b-41d4-a716-446655440005'::uuid,
        '550e8400-e29b-41d4-a716-446655440010'::uuid,
        '550e8400-e29b-41d4-a716-446655440011'::uuid,
        '550e8400-e29b-41d4-a716-446655440012'::uuid,
        '550e8400-e29b-41d4-a716-446655440013'::uuid,
        '550e8400-e29b-41d4-a716-446655440014'::uuid
    )
);

DELETE FROM sharing_event_responses 
WHERE response_id IN (
    SELECT r.id FROM responses r 
    WHERE r.user_id IN (
        '550e8400-e29b-41d4-a716-446655440001'::uuid,
        '550e8400-e29b-41d4-a716-446655440002'::uuid,
        '550e8400-e29b-41d4-a716-446655440003'::uuid,
        '550e8400-e29b-41d4-a716-446655440004'::uuid,
        '550e8400-e29b-41d4-a716-446655440005'::uuid,
        '550e8400-e29b-41d4-a716-446655440010'::uuid,
        '550e8400-e29b-41d4-a716-446655440011'::uuid,
        '550e8400-e29b-41d4-a716-446655440012'::uuid,
        '550e8400-e29b-41d4-a716-446655440013'::uuid,
        '550e8400-e29b-41d4-a716-446655440014'::uuid
    )
);

-- 2. Delete sharing events for test users
DELETE FROM sharing_events 
WHERE user_id IN (
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    '550e8400-e29b-41d4-a716-446655440014'::uuid
);

-- 3. Delete actions for test users
DELETE FROM actions 
WHERE user_id IN (
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    '550e8400-e29b-41d4-a716-446655440014'::uuid
);

-- 4. Delete responses for test users
DELETE FROM responses 
WHERE user_id IN (
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    '550e8400-e29b-41d4-a716-446655440014'::uuid
);

-- 5. Delete profiles for test users
DELETE FROM profiles 
WHERE user_id IN (
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    '550e8400-e29b-41d4-a716-446655440014'::uuid
);

-- 6. Delete specific test users
DELETE FROM auth.users 
WHERE id IN (
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    '550e8400-e29b-41d4-a716-446655440014'::uuid
);

-- 7. Delete test employers (only those used in test data)
DELETE FROM employers 
WHERE id IN (
    '990e8400-e29b-41d4-a716-446655440001'::uuid,
    '990e8400-e29b-41d4-a716-446655440002'::uuid,
    '990e8400-e29b-41d4-a716-446655440003'::uuid,
    '990e8400-e29b-41d4-a716-446655440004'::uuid,
    '990e8400-e29b-41d4-a716-446655440005'::uuid
);

-- Reset sequences to ensure clean state
SELECT setval('response_version_seq', 1, false);
SELECT setval('action_version_seq', 1, false);

-- Verification queries (uncomment to see results)
/*
SELECT 'auth.users' as table_name, COUNT(*) as remaining_rows FROM auth.users
UNION ALL
SELECT 'profiles', COUNT(*) FROM profiles  
UNION ALL
SELECT 'responses', COUNT(*) FROM responses
UNION ALL 
SELECT 'actions', COUNT(*) FROM actions
UNION ALL
SELECT 'sharing_events', COUNT(*) FROM sharing_events
UNION ALL
SELECT 'sharing_event_responses', COUNT(*) FROM sharing_event_responses
UNION ALL
SELECT 'sharing_event_actions', COUNT(*) FROM sharing_event_actions
UNION ALL
SELECT 'employers', COUNT(*) FROM employers
UNION ALL
SELECT 'questions', COUNT(*) FROM questions;
*/
