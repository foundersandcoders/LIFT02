-- Comprehensive fake test data for development and testing
-- This file is auto-generated from data/test_data_source.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate

-- ===========================================
-- ORGANIZATIONS
-- ===========================================

INSERT INTO organizations (id, name) VALUES ('990e8400-e29b-41d4-a716-446655440001'::uuid, 'TechCorp Ltd');
INSERT INTO organizations (id, name) VALUES ('990e8400-e29b-41d4-a716-446655440002'::uuid, 'Creative Agency');
INSERT INTO organizations (id, name) VALUES ('990e8400-e29b-41d4-a716-446655440003'::uuid, 'DataFlow Inc');
INSERT INTO organizations (id, name) VALUES ('990e8400-e29b-41d4-a716-446655440004'::uuid, 'InnovateCorp');
INSERT INTO organizations (id, name) VALUES ('990e8400-e29b-41d4-a716-446655440005'::uuid, 'BrandWorks');

-- ===========================================
-- AUTH USERS (for local testing only)
-- ===========================================

INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440001'::uuid,
    'authenticated',
    'authenticated',
    'alex.thompson@example.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440002'::uuid,
    'authenticated',
    'authenticated',
    'jordan.martinez@example.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440003'::uuid,
    'authenticated',
    'authenticated',
    'sam.chen@example.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440004'::uuid,
    'authenticated',
    'authenticated',
    'priya.patel@example.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440005'::uuid,
    'authenticated',
    'authenticated',
    'taylor.adams@example.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440010'::uuid,
    'authenticated',
    'authenticated',
    'sarah.wilson@techcorp.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    'authenticated',
    'authenticated',
    'mike.johnson@creative.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    'authenticated',
    'authenticated',
    'lisa.brown@dataflow.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    'authenticated',
    'authenticated',
    'david.kim@innovatecorp.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '550e8400-e29b-41d4-a716-446655440014'::uuid,
    'authenticated',
    'authenticated',
    'emma.rodriguez@brandworks.com',
    '$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz',
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
);

-- ===========================================
-- PROFILES (step 1: without line_manager FK)
-- ===========================================

INSERT INTO profiles (id, user_id, name, pronouns, job_title, is_line_manager) VALUES
  ('550e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Alexander', ARRAY['they', 'them', 'theirs'], 'Software Developer', false),
  ('550e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'Jordan Martinez', ARRAY['she', 'her', 'hers'], 'UX Designer', false),
  ('550e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'Sam Chen', ARRAY['he', 'him', 'his'], 'Data Analyst', false),
  ('550e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, 'Priya Patel', ARRAY['she', 'her', 'hers'], 'Product Manager', false),
  ('550e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, 'Taylor Adams', ARRAY['he', 'him', 'his'], 'Marketing Specialist', false),
  ('550e8400-e29b-41d4-a716-446655440010'::uuid, '550e8400-e29b-41d4-a716-446655440010'::uuid, 'Sarah Wilson', ARRAY['she', 'her', 'hers'], 'Engineering Manager', true),
  ('550e8400-e29b-41d4-a716-446655440011'::uuid, '550e8400-e29b-41d4-a716-446655440011'::uuid, 'Mike Johnson', ARRAY['he', 'him', 'his'], 'Design Director', true),
  ('550e8400-e29b-41d4-a716-446655440012'::uuid, '550e8400-e29b-41d4-a716-446655440012'::uuid, 'Lisa Brown', ARRAY['she', 'her', 'hers'], 'Analytics Lead', true),
  ('550e8400-e29b-41d4-a716-446655440013'::uuid, '550e8400-e29b-41d4-a716-446655440013'::uuid, 'David Kim', ARRAY['he', 'him', 'his'], 'Product Director', true),
  ('550e8400-e29b-41d4-a716-446655440014'::uuid, '550e8400-e29b-41d4-a716-446655440014'::uuid, 'Emma Rodriguez', ARRAY['she', 'her', 'hers'], 'Marketing Director', true);

-- ===========================================
-- LINE MANAGERS
-- ===========================================

INSERT INTO line_managers (id, line_manager_id, organization_id, email) VALUES ('440e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440010'::uuid, '990e8400-e29b-41d4-a716-446655440001'::uuid, 'sarah.wilson@techcorp.com');
INSERT INTO line_managers (id, line_manager_id, organization_id, email) VALUES ('440e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440011'::uuid, '990e8400-e29b-41d4-a716-446655440002'::uuid, 'mike.johnson@creative.com');
INSERT INTO line_managers (id, line_manager_id, organization_id, email) VALUES ('440e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440012'::uuid, '990e8400-e29b-41d4-a716-446655440003'::uuid, 'lisa.brown@dataflow.com');
INSERT INTO line_managers (id, line_manager_id, organization_id, email) VALUES ('440e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440013'::uuid, '990e8400-e29b-41d4-a716-446655440004'::uuid, 'david.kim@innovatecorp.com');
INSERT INTO line_managers (id, line_manager_id, organization_id, email) VALUES ('440e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440014'::uuid, '990e8400-e29b-41d4-a716-446655440005'::uuid, 'emma.rodriguez@brandworks.com');

-- ===========================================
-- PROFILES (step 2: update line_manager FK)
-- ===========================================

UPDATE profiles SET line_manager = '440e8400-e29b-41d4-a716-446655440001'::uuid WHERE id = '550e8400-e29b-41d4-a716-446655440001'::uuid;
UPDATE profiles SET line_manager = '440e8400-e29b-41d4-a716-446655440002'::uuid WHERE id = '550e8400-e29b-41d4-a716-446655440002'::uuid;
UPDATE profiles SET line_manager = '440e8400-e29b-41d4-a716-446655440003'::uuid WHERE id = '550e8400-e29b-41d4-a716-446655440003'::uuid;
UPDATE profiles SET line_manager = '440e8400-e29b-41d4-a716-446655440004'::uuid WHERE id = '550e8400-e29b-41d4-a716-446655440004'::uuid;
UPDATE profiles SET line_manager = '440e8400-e29b-41d4-a716-446655440005'::uuid WHERE id = '550e8400-e29b-41d4-a716-446655440005'::uuid;

-- ===========================================
-- RESPONSES
-- ===========================================

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440001'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I have ADHD which significantly impacts my concentration and executive function. Open office environments are particularly challenging due to auditory processing sensitivity.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 1;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440002'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'On good days, I am energetic, creative, and able to hyperfocus on tasks. I communicate clearly and enjoy collaborating with the team.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 2;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440003'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'On difficult days, I may appear restless or fidgety, have difficulty sitting through long meetings, and need more time to process verbal instructions.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 3;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440020'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I have generalized anxiety disorder and chronic fatigue syndrome. Unexpected changes in deadlines or project scope can trigger anxiety episodes.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 1;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440021'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'On good days, I am creative, collaborative, and detail-oriented. I can engage fully in brainstorming sessions and provide thoughtful design feedback.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 2;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440030'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'I am autistic and have sensory processing sensitivities. Bright fluorescent lights and sudden loud noises can be overwhelming.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 1;

-- ===========================================
-- ACTIONS
-- ===========================================

INSERT INTO actions (id, user_id, response_id, type, description, status, version, is_latest) VALUES
  ('770e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 'workplace_adjustment', 'Provide noise-cancelling headphones and assign desk in quieter area of office', 'active', 1, true);
INSERT INTO actions (id, user_id, response_id, type, description, status, version, is_latest) VALUES
  ('770e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 'schedule_adjustment', 'Allow 15-minute breaks every 90 minutes to help with focus', 'active', 1, true);
INSERT INTO actions (id, user_id, response_id, type, description, status, version, is_latest) VALUES
  ('770e8400-e29b-41d4-a716-446655440010'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440020'::uuid, 'communication', 'Provide 48-hour advance notice for project changes when possible', 'active', 1, true);

-- ===========================================
-- SHARING EVENTS
-- ===========================================

INSERT INTO sharing_events (id, user_id, recipient_email, message, shared_at) VALUES
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'sarah.wilson@techcorp.com', 'Hi Sarah, I wanted to share my workplace passport with you so you can better understand my needs and how to support me in my role.', NOW());
INSERT INTO sharing_events (id, user_id, recipient_email, message, shared_at) VALUES
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'mike.johnson@creative.com', 'Hi Mike, here is my workplace passport with information about my needs and how we can work together effectively.', NOW());

-- Link responses to sharing events
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid);
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid);
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES ('880e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440020'::uuid);
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES ('880e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440021'::uuid);

-- Link actions to sharing events
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES ('880e8400-e29b-41d4-a716-446655440001'::uuid, '770e8400-e29b-41d4-a716-446655440001'::uuid);
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES ('880e8400-e29b-41d4-a716-446655440001'::uuid, '770e8400-e29b-41d4-a716-446655440002'::uuid);
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES ('880e8400-e29b-41d4-a716-446655440002'::uuid, '770e8400-e29b-41d4-a716-446655440010'::uuid);
