-- Test data seed file
-- This file contains fake data for testing purposes
-- Run this after the main seed.sql to populate with test data

-- Create fake users in auth.users (for local testing only)
-- Note: These UUIDs should match what you'll use in profiles
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
), (
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
), (
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
), (
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
), (
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

-- Insert fake profiles
INSERT INTO profiles (id, user_id, name, pronouns, job_title, employer_name, line_manager_name, line_manager_email) VALUES
  ('550e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Alex Thompson', 'they/them', 'Software Developer', 'TechCorp Ltd', 'Sarah Wilson', 'sarah.wilson@techcorp.com'),
  ('550e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'Jordan Martinez', 'she/her', 'UX Designer', 'Creative Agency', 'Mike Johnson', 'mike.johnson@creative.com'),
  ('550e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'Sam Chen', 'he/him', 'Data Analyst', 'DataFlow Inc', 'Lisa Brown', 'lisa.brown@dataflow.com'),
  ('550e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, 'Priya Patel', 'she/her', 'Product Manager', 'InnovateCorp', 'David Kim', 'david.kim@innovatecorp.com'),
  ('550e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, 'Taylor Adams', 'he/him', 'Marketing Specialist', 'BrandWorks', 'Emma Rodriguez', 'emma.rodriguez@brandworks.com');

-- Insert comprehensive fake responses using actual question IDs from the questions table

-- ===========================================
-- ALEX THOMPSON - Software Developer (ADHD)
-- ===========================================

-- Wellbeing responses (has multiple versions for some questions)
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest, created_at) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440001'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I have ADHD which can affect my concentration, especially in open office environments. I work best with noise-cancelling headphones and scheduled breaks.',
  'answered',
  'public',
  1,
  false,
  NOW() - INTERVAL '2 months'
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

-- Updated version of the same question
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest, created_at) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440003'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I have ADHD which significantly impacts my concentration and executive function. Open office environments are particularly challenging due to auditory processing sensitivity. I work most effectively with noise-cancelling headphones, scheduled breaks every 90 minutes, and advance notice of any changes to my routine.',
  'answered',
  'public',
  2,
  true,
  NOW() - INTERVAL '2 weeks'
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440002'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'On good days, I''m energetic, creative, and able to hyperfocus on tasks. I communicate clearly and enjoy collaborating with the team. I''m most productive in the morning and can tackle complex problems efficiently.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440005'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'On difficult days, I struggle with focus and can become easily overwhelmed by interruptions or unexpected changes. I may appear restless or fidgety, have difficulty sitting through long meetings, and need more time to process verbal instructions.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 3;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440004'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'Early warning signs include increased fidgeting, difficulty completing tasks, procrastination on important work, and appearing scattered in conversations. When you notice these signs, please: give me written instructions rather than verbal ones, allow me to take short breaks, and avoid scheduling back-to-back meetings.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 4;

-- Parental responsibilities
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440010'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I care for my elderly parent who has mobility issues and dementia. Sometimes I need to leave early for medical appointments or handle urgent care situations.',
  'answered',
  'private',
  1,
  true
FROM questions q WHERE q.category = 'parental' AND q."order" = 6;

-- Support needs
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440012'::uuid,
  '550e8400-e29b-41d4-a716-446655440001'::uuid,
  q.id,
  'I need clear written instructions, regular check-ins to ensure I''m on track, and the flexibility to work in quieter spaces when needed. I also benefit from agenda items being shared in advance for meetings.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'employer_Support' AND q."order" = 13;

-- ===========================================
-- JORDAN MARTINEZ - UX Designer (Anxiety + Chronic Fatigue)
-- ===========================================

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440020'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I have generalized anxiety disorder and chronic fatigue syndrome. Unexpected changes in deadlines or project scope can trigger anxiety episodes, and my energy levels fluctuate significantly throughout the day.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440021'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'On good days, I''m creative, collaborative, and detail-oriented. I can engage fully in brainstorming sessions and provide thoughtful design feedback. I work well with structured timelines and clear expectations.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440022'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'On difficult days, I may appear withdrawn, have trouble making decisions, or seem overwhelmed by feedback. Fatigue can make it hard to concentrate during afternoon meetings.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 3;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440023'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'skipped',
  'skipped',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 4;

-- Disability details
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440024'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'Chronic fatigue syndrome means my energy levels can vary significantly day to day. Some days I can work full capacity, other days I need to pace myself and may be less productive in the afternoon.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'disability' AND q."order" = 10;

-- Religious needs
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440025'::uuid,
  '550e8400-e29b-41d4-a716-446655440002'::uuid,
  q.id,
  'I observe Ramadan and will need some flexibility during fasting hours. I may need to step away briefly for prayers during the day.',
  'answered',
  'private',
  1,
  true
FROM questions q WHERE q.category = 'religious' AND q."order" = 8;

-- ===========================================
-- SAM CHEN - Data Analyst (Autism)
-- ===========================================

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440030'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'I am autistic and have sensory processing sensitivities. Bright fluorescent lights and sudden loud noises can be overwhelming. I prefer structured environments and clear expectations.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440031'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'On good days, I''m detail-oriented and can work through complex datasets methodically. I enjoy problem-solving and finding patterns. I prefer working independently but am happy to collaborate when needed.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440032'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'skipped',
  'skipped',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 3;

-- Parental responsibilities  
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440033'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'I have two young children (ages 5 and 8) and occasionally need flexibility for school events, parent-teacher conferences, or when they''re sick.',
  'answered',
  'private',
  1,
  true
FROM questions q WHERE q.category = 'parental' AND q."order" = 6;

-- Personal introduction
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440034'::uuid,
  '550e8400-e29b-41d4-a716-446655440003'::uuid,
  q.id,
  'I communicate best through email or written messages rather than verbal instructions. I appreciate direct, honest feedback and prefer advance notice of changes to projects or meetings.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'personal_Introduction' AND q."order" = 14;

-- ===========================================
-- PRIYA PATEL - Product Manager (Depression + Diabetes)
-- ===========================================

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440040'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'I manage depression and Type 1 diabetes. Both conditions can affect my energy levels and require ongoing management throughout the day.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440043'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'On good days, I''m strategic, organized, and great at facilitating team discussions. I can balance multiple projects effectively and provide clear direction to development teams.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

-- Updated version of good days response
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest, created_at) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440041'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'On good days, I''m strategic, organized, and excellent at facilitating team discussions. I can balance multiple projects effectively, provide clear direction to development teams, and I''m particularly good at stakeholder management and roadmap planning.',
  'answered',
  'public',
  2,
  false,
  NOW() - INTERVAL '1 week'
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

-- Latest version
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440042'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'On good days, I''m strategic, organized, and excellent at facilitating team discussions and stakeholder meetings. I can balance multiple projects effectively, provide clear direction to development teams, and excel at roadmap planning. I''m energetic and collaborative, often helping to solve cross-team challenges.',
  'answered',
  'public',
  3,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440044'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'On difficult days, I may need to step away to manage my blood sugar levels or may have lower energy due to depression. I try not to let it show, but I might be less talkative or need more time to make decisions.',
  'answered',
  'private',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 3;

-- Disability barriers
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440045'::uuid,
  '550e8400-e29b-41d4-a716-446655440004'::uuid,
  q.id,
  'I need to monitor my blood sugar regularly and sometimes need to eat during meetings or step away briefly. Long meetings without breaks can be challenging.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'disability' AND q."order" = 11;

-- ===========================================
-- TAYLOR ADAMS - Marketing Specialist (Dyslexia)
-- ===========================================

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440050'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I have dyslexia which affects my reading speed and written communication. I''m more comfortable with verbal communication and visual presentations.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 1;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440051'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'On good days, I''m creative, enthusiastic, and great at brainstorming and presenting ideas. I excel at visual thinking and can come up with innovative marketing campaigns.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 2;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440052'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'skipped',
  'skipped',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 3;

INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440053'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'skipped',
  'skipped',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'wellbeing' AND q."order" = 4;

-- Support needs
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440054'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I work well when I can present ideas verbally rather than in lengthy written reports. I benefit from spell-check tools and prefer collaborative editing for important documents.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'employer_Support' AND q."order" = 13;

-- Colleague information
INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  '660e8400-e29b-41d4-a716-446655440055'::uuid,
  '550e8400-e29b-41d4-a716-446655440005'::uuid,
  q.id,
  'I''m a visual thinker and often prefer to explain ideas through sketches or diagrams rather than written documents. I''m always happy to discuss ideas verbally and brainstorm collaboratively.',
  'answered',
  'public',
  1,
  true
FROM questions q WHERE q.category = 'personal_Introduction' AND q."order" = 14;

-- Insert comprehensive fake actions linked to responses

-- Actions for Alex Thompson (ADHD accommodations)
INSERT INTO actions (id, user_id, response_id, type, description, version, is_latest) VALUES
  ('770e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 'workplace_adjustment', 'Provide noise-cancelling headphones and assign desk in quieter area of office', 1, true),
  ('770e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 'schedule_adjustment', 'Allow 15-minute breaks every 90 minutes to help with focus', 1, true),
  ('770e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 'communication', 'Provide written instructions and meeting agendas in advance', 1, true),
  ('770e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440010'::uuid, 'schedule_flexibility', 'Flexible hours for parent care responsibilities and medical appointments', 1, true);

-- Actions for Jordan Martinez (Anxiety + Chronic Fatigue)
INSERT INTO actions (id, user_id, response_id, type, description, version, is_latest, created_at) VALUES
  ('770e8400-e29b-41d4-a716-446655440010'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440020'::uuid, 'communication', 'Provide 48-hour advance notice for any project changes when possible', 1, false, NOW() - INTERVAL '3 weeks'),
  ('770e8400-e29b-41d4-a716-446655440013'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440020'::uuid, 'communication', 'Provide 48-hour advance notice for project changes and avoid scheduling back-to-back meetings', 2, true, NOW() - INTERVAL '1 week'),
  ('770e8400-e29b-41d4-a716-446655440011'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440024'::uuid, 'workload_management', 'Flexible working hours and option to work from home on low-energy days', 1, true, NOW()),
  ('770e8400-e29b-41d4-a716-446655440012'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440025'::uuid, 'religious_accommodation', 'Flexible prayer times during Ramadan and consideration for fasting schedules', 1, true, NOW());

-- Actions for Sam Chen (Autism accommodations)
INSERT INTO actions (id, user_id, response_id, type, description, version, is_latest, created_at) VALUES
  ('770e8400-e29b-41d4-a716-446655440020'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440030'::uuid, 'workplace_adjustment', 'Provide desk lamp to reduce fluorescent lighting and minimize sudden noise interruptions', 1, true, NOW()),
  ('770e8400-e29b-41d4-a716-446655440021'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440034'::uuid, 'communication', 'Prefer email communication over verbal instructions for important tasks', 1, true, NOW()),
  ('770e8400-e29b-41d4-a716-446655440022'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440033'::uuid, 'schedule_flexibility', 'Flexible hours for child-related responsibilities', 1, true, NOW());

-- Actions for Priya Patel (Diabetes + Depression accommodations)
INSERT INTO actions (id, user_id, response_id, type, description, version, is_latest, created_at) VALUES
  ('770e8400-e29b-41d4-a716-446655440030'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440043'::uuid, 'health_accommodation', 'Allow regular blood sugar monitoring breaks and eating during meetings when needed', 1, true, NOW()),
  ('770e8400-e29b-41d4-a716-446655440031'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440043'::uuid, 'schedule_adjustment', 'Ensure meeting breaks every 90 minutes for health management', 1, true, NOW());

-- Actions for Taylor Adams (Dyslexia accommodations)
INSERT INTO actions (id, user_id, response_id, type, description, version, is_latest, created_at) VALUES
  ('770e8400-e29b-41d4-a716-446655440040'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440054'::uuid, 'workplace_adjustment', 'Provide access to advanced spell-check tools and collaborative editing software', 1, true, NOW()),
  ('770e8400-e29b-41d4-a716-446655440041'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440055'::uuid, 'communication', 'Encourage verbal presentations and visual aids over lengthy written reports', 1, true, NOW());

-- Insert comprehensive fake sharing events
INSERT INTO sharing_events (id, user_id, recipient_email, message, shared_at) VALUES
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'sarah.wilson@techcorp.com', 'Hi Sarah, I wanted to share my workplace passport with you so you can better understand my needs and how to support me in my role. This includes my ADHD accommodations and care responsibilities.', NOW() - INTERVAL '2 weeks'),
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'mike.johnson@creative.com', 'Hi Mike, here is my workplace passport with information about my needs and how we can work together effectively. Please note my energy levels vary due to chronic fatigue.', NOW() - INTERVAL '1 month'),
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'lisa.brown@dataflow.com', 'Hi Lisa, I''m sharing my workplace passport to help you understand my communication preferences and work style as an autistic person.', NOW() - INTERVAL '3 weeks'),
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, 'david.kim@innovatecorp.com', 'Hi David, please find my workplace passport attached. It includes information about my diabetes management needs and some personal accommodation requests.', NOW() - INTERVAL '1 week'),
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, 'emma.rodriguez@brandworks.com', 'Hi Emma, I''m sharing my workplace passport to help you understand how my dyslexia affects my work and what support helps me be most effective.', NOW() - INTERVAL '5 days');

-- Link responses to sharing events (multiple responses per sharing event)

-- Alex Thompson sharing (ADHD + wellbeing + parental)
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid),  -- Latest wellbeing response
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid),   -- Good days
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid),   -- Bad days
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440012'::uuid);   -- Support needs

-- Jordan Martinez sharing (Anxiety + Chronic Fatigue + Religious)
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440020'::uuid),   -- Wellbeing
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440021'::uuid),   -- Good days
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440024'::uuid);   -- Disability

-- Sam Chen sharing (Autism + Communication)
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440030'::uuid),   -- Wellbeing
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440031'::uuid),   -- Good days
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440034'::uuid);   -- Personal intro

-- Priya Patel sharing (Depression + Diabetes)
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440040'::uuid),   -- Wellbeing
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440042'::uuid),  -- Latest good days
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440043'::uuid);   -- Disability barriers

-- Taylor Adams sharing (Dyslexia + Communication preferences)
INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440050'::uuid),   -- Wellbeing
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440051'::uuid),   -- Good days
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440054'::uuid),   -- Support needs
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440055'::uuid);   -- Personal intro

-- Link actions to sharing events

-- Alex Thompson actions shared
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '770e8400-e29b-41d4-a716-446655440001'::uuid),   -- Noise-cancelling headphones
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '770e8400-e29b-41d4-a716-446655440002'::uuid),   -- Break schedule
  ('880e8400-e29b-41d4-a716-446655440001'::uuid, '770e8400-e29b-41d4-a716-446655440003'::uuid);   -- Written instructions

-- Jordan Martinez actions shared
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '770e8400-e29b-41d4-a716-446655440013'::uuid),  -- Latest communication action
  ('880e8400-e29b-41d4-a716-446655440002'::uuid, '770e8400-e29b-41d4-a716-446655440011'::uuid);   -- Flexible hours

-- Sam Chen actions shared
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '770e8400-e29b-41d4-a716-446655440020'::uuid),   -- Lighting adjustment
  ('880e8400-e29b-41d4-a716-446655440003'::uuid, '770e8400-e29b-41d4-a716-446655440021'::uuid);   -- Email communication

-- Priya Patel actions shared
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '770e8400-e29b-41d4-a716-446655440030'::uuid),   -- Health breaks
  ('880e8400-e29b-41d4-a716-446655440004'::uuid, '770e8400-e29b-41d4-a716-446655440031'::uuid);   -- Meeting breaks

-- Taylor Adams actions shared
INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '770e8400-e29b-41d4-a716-446655440040'::uuid),   -- Spell-check tools
  ('880e8400-e29b-41d4-a716-446655440005'::uuid, '770e8400-e29b-41d4-a716-446655440041'::uuid);   -- Verbal presentations