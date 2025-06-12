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
  3,
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
  2,
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
  '660e8400-e29b-41d4-a716-446655440004'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'Early warning signs include increased irritability, difficulty concentrating on routine tasks, and avoiding team communications. Please approach me privately and ask how I''m doing.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 4;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440005'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'ADHD affects my ability to filter distractions and organize tasks. I work best in quiet environments with clear, written instructions.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 10;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440006'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I need noise-cancelling headphones, written meeting agendas in advance, and the ability to take short breaks during long meetings.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_support_needs' AND q."order" = 12;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440007'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'To thrive, I need a quiet workspace away from high-traffic areas, flexible working hours to accommodate my peak focus times, and regular check-ins with my manager.',
  'answered',
  'public',
  3,
  true
FROM questions q WHERE q.category = 'my_support_needs' AND q."order" = 13;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440008'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I''m very direct in my communication style and appreciate the same in return. I prefer email over verbal instructions for important tasks.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'about_me' AND q."order" = 14;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440020'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I have generalized anxiety disorder and chronic fatigue syndrome. Unexpected changes in deadlines or project scope can trigger anxiety episodes.',
  'answered',
  'public',
  2,
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
  '660e8400-e29b-41d4-a716-446655440022'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'On bad days, I may seem withdrawn and struggle with decision-making. I tend to overthink and need extra reassurance about my work quality.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 3;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440023'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'Warning signs include working late frequently, declining social interactions, and appearing more stressed. A gentle check-in asking about workload helps.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 4;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440024'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'Persistent insomnia, difficulty concentrating, and feeling overwhelmed by simple tasks indicate I need time off to recover.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 5;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440025'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I care for my elderly parent who has dementia. This sometimes requires me to attend medical appointments or handle care-related emergencies.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_responsibilities' AND q."order" = 6;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440026'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I need flexibility for occasional urgent appointments and understanding that my stress levels may fluctuate based on my parent''s condition.',
  'answered',
  'public',
  3,
  true
FROM questions q WHERE q.category = 'my_responsibilities' AND q."order" = 7;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440027'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'Anxiety can make me overthink creative decisions and chronic fatigue affects my energy levels, especially in the afternoons.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 10;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440028'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'Long meetings in the afternoon drain my energy significantly. I work best with morning meetings and afternoon focus time.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 11;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440029'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I need clear deadlines with buffer time, regular feedback to reduce anxiety about work quality, and understanding about carer responsibilities.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_support_needs' AND q."order" = 12;
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
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440031'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'On good days, I am highly analytical, detail-focused, and able to spot patterns others miss. I communicate best through written formats.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 2;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440032'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'On bad days, I may become overwhelmed by sensory input and need quiet space. I might appear blunt or withdrawn when overstimulated.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 3;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440033'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'Autism affects my social communication and sensory processing. I need predictable routines and advance notice of changes to perform well.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 10;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440034'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'Open office noise and fluorescent lighting make it difficult to concentrate. Last-minute meeting changes cause significant stress.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 11;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440035'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'I need a quiet workspace with natural lighting, written communication for important information, and advance notice of schedule changes.',
  'answered',
  'public',
  3,
  true
FROM questions q WHERE q.category = 'my_support_needs' AND q."order" = 12;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440040'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'I have chronic pain from a back injury which affects my ability to sit for long periods. Pain levels vary day to day.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_wellbeing' AND q."order" = 1;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440041'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'I have two young children and need to do school pickup on Tuesdays and Thursdays at 3:30pm.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_responsibilities' AND q."order" = 6;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440042'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'I need to leave early twice a week for school pickup and occasionally work from home when children are unwell.',
  'answered',
  'public',
  2,
  true
FROM questions q WHERE q.category = 'my_responsibilities' AND q."order" = 7;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440043'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'Chronic back pain means I need to change positions frequently and sometimes use a standing desk to manage discomfort.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_conditions' AND q."order" = 10;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440050'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I observe Friday prayers and need 30 minutes on Fridays between 12-2pm. I also fast during Ramadan which may affect my energy levels.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_religion' AND q."order" = 8;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440051'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I don''t eat pork or drink alcohol. For team events, please ensure halal options are available or let me know in advance so I can arrange my own meal.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'my_religion' AND q."order" = 9;
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440052'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I''m very collaborative and enjoy mentoring junior team members. I prefer to discuss any concerns directly rather than through email.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'about_me' AND q."order" = 14;

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
