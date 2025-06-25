-- Comprehensive fake test data for development and testing
-- This file is auto-generated from data/test_data_source.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate
-- ===========================================
-- ORGANIZATIONS
-- ===========================================
INSERT INTO
	organizations (id, name)
VALUES
	(
		'990e8400-e29b-41d4-a716-446655440001'::uuid,
		'TechCorp Ltd'
	);

INSERT INTO
	organizations (id, name)
VALUES
	(
		'990e8400-e29b-41d4-a716-446655440002'::uuid,
		'Creative Agency'
	);

INSERT INTO
	organizations (id, name)
VALUES
	(
		'990e8400-e29b-41d4-a716-446655440003'::uuid,
		'DataFlow Inc'
	);

INSERT INTO
	organizations (id, name)
VALUES
	(
		'990e8400-e29b-41d4-a716-446655440004'::uuid,
		'InnovateCorp'
	);

INSERT INTO
	organizations (id, name)
VALUES
	(
		'990e8400-e29b-41d4-a716-446655440005'::uuid,
		'BrandWorks'
	);

-- ===========================================
-- AUTH USERS (for local testing only)
-- ===========================================
INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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

INSERT INTO
	auth.users (
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
	)
VALUES
	(
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
INSERT INTO
	profiles (
		id,
		user_id,
		name,
		pronouns,
		job_title,
		is_line_manager
	)
VALUES
	(
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'Alexander',
		ARRAY['they', 'them', 'theirs'],
		'Software Developer',
		false
	),
	(
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'Jordan Martinez',
		ARRAY['she', 'her', 'hers'],
		'UX Designer',
		false
	),
	(
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'Sam Chen',
		ARRAY['he', 'him', 'his'],
		'Data Analyst',
		false
	),
	(
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'Priya Patel',
		ARRAY['she', 'her', 'hers'],
		'Product Manager',
		false
	),
	(
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'Taylor Adams',
		ARRAY['he', 'him', 'his'],
		'Marketing Specialist',
		false
	),
	(
		'550e8400-e29b-41d4-a716-446655440010'::uuid,
		'550e8400-e29b-41d4-a716-446655440010'::uuid,
		'Sarah Wilson',
		ARRAY['she', 'her', 'hers'],
		'Engineering Manager',
		true
	),
	(
		'550e8400-e29b-41d4-a716-446655440011'::uuid,
		'550e8400-e29b-41d4-a716-446655440011'::uuid,
		'Mike Johnson',
		ARRAY['he', 'him', 'his'],
		'Design Director',
		true
	),
	(
		'550e8400-e29b-41d4-a716-446655440012'::uuid,
		'550e8400-e29b-41d4-a716-446655440012'::uuid,
		'Lisa Brown',
		ARRAY['she', 'her', 'hers'],
		'Analytics Lead',
		true
	),
	(
		'550e8400-e29b-41d4-a716-446655440013'::uuid,
		'550e8400-e29b-41d4-a716-446655440013'::uuid,
		'David Kim',
		ARRAY['he', 'him', 'his'],
		'Product Director',
		true
	),
	(
		'550e8400-e29b-41d4-a716-446655440014'::uuid,
		'550e8400-e29b-41d4-a716-446655440014'::uuid,
		'Emma Rodriguez',
		ARRAY['she', 'her', 'hers'],
		'Marketing Director',
		true
	);

-- ===========================================
-- LINE MANAGERS
-- ===========================================
INSERT INTO
	line_managers (id, line_manager_id, organization_id, email)
VALUES
	(
		'440e8400-e29b-41d4-a716-446655440001'::uuid,
		'550e8400-e29b-41d4-a716-446655440010'::uuid,
		'990e8400-e29b-41d4-a716-446655440001'::uuid,
		'sarah.wilson@techcorp.com'
	);

INSERT INTO
	line_managers (id, line_manager_id, organization_id, email)
VALUES
	(
		'440e8400-e29b-41d4-a716-446655440002'::uuid,
		'550e8400-e29b-41d4-a716-446655440011'::uuid,
		'990e8400-e29b-41d4-a716-446655440002'::uuid,
		'mike.johnson@creative.com'
	);

INSERT INTO
	line_managers (id, line_manager_id, organization_id, email)
VALUES
	(
		'440e8400-e29b-41d4-a716-446655440003'::uuid,
		'550e8400-e29b-41d4-a716-446655440012'::uuid,
		'990e8400-e29b-41d4-a716-446655440003'::uuid,
		'lisa.brown@dataflow.com'
	);

INSERT INTO
	line_managers (id, line_manager_id, organization_id, email)
VALUES
	(
		'440e8400-e29b-41d4-a716-446655440004'::uuid,
		'550e8400-e29b-41d4-a716-446655440013'::uuid,
		'990e8400-e29b-41d4-a716-446655440004'::uuid,
		'david.kim@innovatecorp.com'
	);

INSERT INTO
	line_managers (id, line_manager_id, organization_id, email)
VALUES
	(
		'440e8400-e29b-41d4-a716-446655440005'::uuid,
		'550e8400-e29b-41d4-a716-446655440014'::uuid,
		'990e8400-e29b-41d4-a716-446655440005'::uuid,
		'emma.rodriguez@brandworks.com'
	);

-- ===========================================
-- PROFILES (step 2: update line_manager FK)
-- ===========================================
UPDATE profiles
SET
	line_manager = '440e8400-e29b-41d4-a716-446655440001'::uuid
WHERE
	id = '550e8400-e29b-41d4-a716-446655440001'::uuid;

UPDATE profiles
SET
	line_manager = '440e8400-e29b-41d4-a716-446655440002'::uuid
WHERE
	id = '550e8400-e29b-41d4-a716-446655440002'::uuid;

UPDATE profiles
SET
	line_manager = '440e8400-e29b-41d4-a716-446655440003'::uuid
WHERE
	id = '550e8400-e29b-41d4-a716-446655440003'::uuid;

UPDATE profiles
SET
	line_manager = '440e8400-e29b-41d4-a716-446655440004'::uuid
WHERE
	id = '550e8400-e29b-41d4-a716-446655440004'::uuid;

UPDATE profiles
SET
	line_manager = '440e8400-e29b-41d4-a716-446655440005'::uuid
WHERE
	id = '550e8400-e29b-41d4-a716-446655440005'::uuid;

-- ===========================================
-- RESPONSES
-- ===========================================
INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440001'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'I have ADHD which significantly impacts my concentration and executive function. Open office environments are particularly challenging due to auditory processing sensitivity.',
	'answered',
	'public',
	3,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 1;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440002'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'On good days, I am energetic, creative, and able to hyperfocus on tasks. I communicate clearly and enjoy collaborating with the team.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 2;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440003'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'On difficult days, I may appear restless or fidgety, have difficulty sitting through long meetings, and need more time to process verbal instructions.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 3;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440004'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'Early warning signs include increased irritability, difficulty concentrating on routine tasks, and avoiding team communications. Please approach me privately and ask how I''m doing.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 4;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440005'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'ADHD affects my ability to filter distractions and organize tasks. I work best in quiet environments with clear, written instructions.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 10;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440006'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'I need noise-cancelling headphones, written meeting agendas in advance, and the ability to take short breaks during long meetings.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_support_needs'
	AND q."order" = 12;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440007'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'To thrive, I need a quiet workspace away from high-traffic areas, flexible working hours to accommodate my peak focus times, and regular check-ins with my manager.',
	'answered',
	'public',
	3,
	true
FROM
	questions q
WHERE
	q.category = 'my_support_needs'
	AND q."order" = 13;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440008'::uuid,
	'550e8400-e29b-41d4-a716-446655440001'::uuid,
	q.id,
	'I''m very direct in my communication style and appreciate the same in return. I prefer email over verbal instructions for important tasks.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'about_me'
	AND q."order" = 14;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440020'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'I have generalized anxiety disorder and chronic fatigue syndrome. Unexpected changes in deadlines or project scope can trigger anxiety episodes.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 1;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440021'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'On good days, I am creative, collaborative, and detail-oriented. I can engage fully in brainstorming sessions and provide thoughtful design feedback.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 2;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440022'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'On bad days, I may seem withdrawn and struggle with decision-making. I tend to overthink and need extra reassurance about my work quality.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 3;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440023'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'Warning signs include working late frequently, declining social interactions, and appearing more stressed. A gentle check-in asking about workload helps.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 4;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440024'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'Persistent insomnia, difficulty concentrating, and feeling overwhelmed by simple tasks indicate I need time off to recover.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 5;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440025'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'I care for my elderly parent who has dementia. This sometimes requires me to attend medical appointments or handle care-related emergencies.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_responsibilities'
	AND q."order" = 6;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440026'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'I need flexibility for occasional urgent appointments and understanding that my stress levels may fluctuate based on my parent''s condition.',
	'answered',
	'public',
	3,
	true
FROM
	questions q
WHERE
	q.category = 'my_responsibilities'
	AND q."order" = 7;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440027'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'Anxiety can make me overthink creative decisions and chronic fatigue affects my energy levels, especially in the afternoons.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 10;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440028'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'Long meetings in the afternoon drain my energy significantly. I work best with morning meetings and afternoon focus time.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 11;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440029'::uuid,
	'550e8400-e29b-41d4-a716-446655440002'::uuid,
	q.id,
	'I need clear deadlines with buffer time, regular feedback to reduce anxiety about work quality, and understanding about carer responsibilities.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_support_needs'
	AND q."order" = 12;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440030'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'I am autistic and have sensory processing sensitivities. Bright fluorescent lights and sudden loud noises can be overwhelming.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 1;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440031'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'On good days, I am highly analytical, detail-focused, and able to spot patterns others miss. I communicate best through written formats.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 2;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440032'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'On bad days, I may become overwhelmed by sensory input and need quiet space. I might appear blunt or withdrawn when overstimulated.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 3;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440033'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'Autism affects my social communication and sensory processing. I need predictable routines and advance notice of changes to perform well.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 10;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440034'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'Open office noise and fluorescent lighting make it difficult to concentrate. Last-minute meeting changes cause significant stress.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 11;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440035'::uuid,
	'550e8400-e29b-41d4-a716-446655440003'::uuid,
	q.id,
	'I need a quiet workspace with natural lighting, written communication for important information, and advance notice of schedule changes.',
	'answered',
	'public',
	3,
	true
FROM
	questions q
WHERE
	q.category = 'my_support_needs'
	AND q."order" = 12;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440040'::uuid,
	'550e8400-e29b-41d4-a716-446655440004'::uuid,
	q.id,
	'I have chronic pain from a back injury which affects my ability to sit for long periods. Pain levels vary day to day.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_wellbeing'
	AND q."order" = 1;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440041'::uuid,
	'550e8400-e29b-41d4-a716-446655440004'::uuid,
	q.id,
	'I have two young children and need to do school pickup on Tuesdays and Thursdays at 3:30pm.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_responsibilities'
	AND q."order" = 6;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440042'::uuid,
	'550e8400-e29b-41d4-a716-446655440004'::uuid,
	q.id,
	'I need to leave early twice a week for school pickup and occasionally work from home when children are unwell.',
	'answered',
	'public',
	2,
	true
FROM
	questions q
WHERE
	q.category = 'my_responsibilities'
	AND q."order" = 7;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440043'::uuid,
	'550e8400-e29b-41d4-a716-446655440004'::uuid,
	q.id,
	'Chronic back pain means I need to change positions frequently and sometimes use a standing desk to manage discomfort.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_conditions'
	AND q."order" = 10;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440050'::uuid,
	'550e8400-e29b-41d4-a716-446655440005'::uuid,
	q.id,
	'I observe Friday prayers and need 30 minutes on Fridays between 12-2pm. I also fast during Ramadan which may affect my energy levels.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_religion'
	AND q."order" = 8;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440051'::uuid,
	'550e8400-e29b-41d4-a716-446655440005'::uuid,
	q.id,
	'I don''t eat pork or drink alcohol. For team events, please ensure halal options are available or let me know in advance so I can arrange my own meal.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'my_religion'
	AND q."order" = 9;

INSERT INTO
	responses (
		id,
		user_id,
		question_id,
		response_text,
		status,
		visibility,
		version,
		is_latest
	)
SELECT
	'660e8400-e29b-41d4-a716-446655440052'::uuid,
	'550e8400-e29b-41d4-a716-446655440005'::uuid,
	q.id,
	'I''m very collaborative and enjoy mentoring junior team members. I prefer to discuss any concerns directly rather than through email.',
	'answered',
	'public',
	1,
	true
FROM
	questions q
WHERE
	q.category = 'about_me'
	AND q."order" = 14;

-- ===========================================
-- ACTIONS
-- ===========================================
INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440001'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440001'::uuid,
		'workplace_adjustment',
		'Provide noise-cancelling headphones and assign desk in quieter area of office',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440002'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440002'::uuid,
		'schedule_adjustment',
		'Allow 15-minute breaks every 90 minutes to help with focus',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440003'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440005'::uuid,
		'equipment',
		'Request ergonomic keyboard and mouse to reduce sensory input',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440004'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440006'::uuid,
		'communication',
		'Send written agendas 24 hours before meetings',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440005'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440007'::uuid,
		'workplace_adjustment',
		'Relocate to corner desk away from main walkway',
		'draft',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440006'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440007'::uuid,
		'schedule_adjustment',
		'Allow flexible start times between 8-10am based on focus patterns',
		'active',
		2,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440010'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440020'::uuid,
		'communication',
		'Provide 48-hour advance notice for project changes when possible',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440011'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440022'::uuid,
		'support',
		'Schedule weekly 1:1 check-ins for feedback and reassurance',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440012'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440025'::uuid,
		'schedule_adjustment',
		'Allow flexible hours for carer appointments with advance notice',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440013'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440026'::uuid,
		'workplace_adjustment',
		'Provide access to quiet room for stress management when needed',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440014'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440028'::uuid,
		'schedule_adjustment',
		'Schedule important meetings before 2pm when energy levels are higher',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440015'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440029'::uuid,
		'communication',
		'Provide clear deadlines with built-in buffer time for quality checks',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440020'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440030'::uuid,
		'workplace_adjustment',
		'Install desk lamp with adjustable lighting to replace fluorescent overhead',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440021'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440032'::uuid,
		'support',
		'Create signal system for when quiet time is needed (do not disturb sign)',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440022'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440033'::uuid,
		'communication',
		'Send all work instructions via email rather than verbal communication',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440023'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440034'::uuid,
		'schedule_adjustment',
		'Provide 48-hour notice for any schedule changes or meeting rearrangements',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440024'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440035'::uuid,
		'workplace_adjustment',
		'Relocate to quieter area near window for natural light',
		'draft',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440025'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440035'::uuid,
		'equipment',
		'Provide noise-cancelling headphones for focus periods',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440030'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440040'::uuid,
		'equipment',
		'Provide adjustable standing desk to manage back pain',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440031'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440040'::uuid,
		'workplace_adjustment',
		'Allow regular position changes and walking breaks throughout the day',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440032'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440041'::uuid,
		'schedule_adjustment',
		'Allow early finish on Tuesdays and Thursdays for school pickup (3:15pm)',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440033'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440042'::uuid,
		'remote_work',
		'Allow work from home when children are unwell (with advance notice)',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440034'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440043'::uuid,
		'equipment',
		'Provide ergonomic chair with proper lumbar support',
		'active',
		2,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440040'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440050'::uuid,
		'schedule_adjustment',
		'Allow 30-minute break on Fridays between 12-2pm for prayers',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440041'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440050'::uuid,
		'support',
		'Adjust workload expectations during Ramadan fasting period',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440042'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid,
		'event_planning',
		'Ensure halal food options at all team events and social gatherings',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440043'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid,
		'communication',
		'Provide advance notice of team events to arrange appropriate meals',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440044'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440052'::uuid,
		'communication',
		'Schedule direct face-to-face discussions for important concerns rather than email',
		'active',
		1,
		true
	);

INSERT INTO
	actions (
		id,
		user_id,
		response_id,
		type,
		description,
		status,
		version,
		is_latest
	)
VALUES
	(
		'770e8400-e29b-41d4-a716-446655440045'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440052'::uuid,
		'development',
		'Provide opportunities to mentor junior developers on projects',
		'draft',
		1,
		true
	);

-- ===========================================
-- SHARING EVENTS
-- ===========================================
INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440001'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'sarah.wilson@techcorp.com',
		'Hi Sarah, I wanted to share my workplace passport with you so you can better understand my needs and how to support me in my role.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440002'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'mike.johnson@creative.com',
		'Hi Mike, here is my workplace passport with information about my needs and how we can work together effectively.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'hr@techcorp.com',
		'Sharing my updated workplace passport with HR for accommodation planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440004'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'facilities@techcorp.com',
		'Hi Facilities team, these are my workspace requirements for optimal productivity.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440005'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'sarah.wilson@techcorp.com',
		'Hi Sarah, sharing my carer responsibilities information so you''re aware of my occasional need for flexibility.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440006'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'design-team@creative.com',
		'Team, sharing my workplace needs to help with project planning and meeting schedules.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440007'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'hr@creative.com',
		'Hi HR, sharing my anxiety and chronic fatigue information for accommodation planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440008'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'lisa.brown@dataflow.com',
		'Hi Lisa, sharing my autism-related workplace needs to ensure smooth collaboration.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'data-team@dataflow.com',
		'Team, here are my communication preferences and sensory needs for our work together.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440010'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'facilities@dataflow.com',
		'Hi Facilities, requesting workspace adjustments for sensory sensitivities.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440011'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'david.kim@innovatecorp.com',
		'Hi David, sharing my parental responsibilities and back pain accommodation needs.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440012'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'product-team@innovatecorp.com',
		'Team, here''s my availability info for project planning around school pickups.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'hr@innovatecorp.com',
		'Hi HR, sharing my chronic pain information for ergonomic equipment requests.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440014'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'emma.rodriguez@brandworks.com',
		'Hi Emma, sharing my religious observance requirements for team planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'marketing-team@brandworks.com',
		'Team, here are my dietary requirements and communication preferences for our projects.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440016'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'events@brandworks.com',
		'Hi Events team, sharing dietary requirements for all company events.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440017'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'project-leads@techcorp.com',
		'Hi Project Leads, sharing my ADHD accommodations for meeting planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440018'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'alex.mentor@techcorp.com',
		'Hi Alex, sharing my communication style preferences as we start our mentoring relationship.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440019'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'client-services@creative.com',
		'Hi Client Services, sharing my energy level patterns for client meeting scheduling.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440020'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'wellbeing@creative.com',
		'Hi Wellbeing team, sharing my stress indicators for early intervention support.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440021'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'accessibility@dataflow.com',
		'Hi Accessibility team, sharing my sensory needs for workspace design input.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440022'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'sam.colleague@dataflow.com',
		'Hi colleague, sharing my communication preferences for our upcoming project collaboration.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440023'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'childcare@innovatecorp.com',
		'Hi Childcare support, sharing my parental responsibilities for emergency planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440024'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'occupational-health@innovatecorp.com',
		'Hi Occupational Health, requesting assessment for back pain management equipment.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440025'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'imam.local@mosque.org',
		'Sharing my workplace accommodation needs with religious advisor for guidance.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440026'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'diversity@brandworks.com',
		'Hi Diversity team, sharing religious accommodation needs for inclusion planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440027'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'dev-team@techcorp.com',
		'Team, sharing my focus patterns and break needs for sprint planning.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440028'::uuid,
		'550e8400-e29b-41d4-a716-446655440002'::uuid,
		'support-group@creative.com',
		'Sharing with peer support group for carer resource sharing.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440029'::uuid,
		'550e8400-e29b-41d4-a716-446655440003'::uuid,
		'neurodiversity-network@dataflow.com',
		'Sharing with neurodiversity employee network for peer support.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440030'::uuid,
		'550e8400-e29b-41d4-a716-446655440004'::uuid,
		'working-parents@innovatecorp.com',
		'Sharing with working parents network for schedule coordination tips.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440031'::uuid,
		'550e8400-e29b-41d4-a716-446655440005'::uuid,
		'mentorship@brandworks.com',
		'Hi Mentorship team, sharing my communication style for mentor matching.',
		NOW()
	);

INSERT INTO
	sharing_events (id, user_id, recipient_email, message, shared_at)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440032'::uuid,
		'550e8400-e29b-41d4-a716-446655440001'::uuid,
		'buddy@techcorp.com',
		'Hi work buddy, sharing my ADHD info so you can support me during busy periods.',
		NOW()
	);

-- Link responses to sharing events
INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440001'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440001'::uuid,
		'660e8400-e29b-41d4-a716-446655440002'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440020'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440002'::uuid,
		'660e8400-e29b-41d4-a716-446655440021'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440005'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440006'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'660e8400-e29b-41d4-a716-446655440007'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440004'::uuid,
		'660e8400-e29b-41d4-a716-446655440007'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440025'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440005'::uuid,
		'660e8400-e29b-41d4-a716-446655440026'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440006'::uuid,
		'660e8400-e29b-41d4-a716-446655440022'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440006'::uuid,
		'660e8400-e29b-41d4-a716-446655440028'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440007'::uuid,
		'660e8400-e29b-41d4-a716-446655440027'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440007'::uuid,
		'660e8400-e29b-41d4-a716-446655440029'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440008'::uuid,
		'660e8400-e29b-41d4-a716-446655440030'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440008'::uuid,
		'660e8400-e29b-41d4-a716-446655440032'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'660e8400-e29b-41d4-a716-446655440033'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'660e8400-e29b-41d4-a716-446655440034'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'660e8400-e29b-41d4-a716-446655440035'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440010'::uuid,
		'660e8400-e29b-41d4-a716-446655440035'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440011'::uuid,
		'660e8400-e29b-41d4-a716-446655440041'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440011'::uuid,
		'660e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440012'::uuid,
		'660e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'660e8400-e29b-41d4-a716-446655440040'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'660e8400-e29b-41d4-a716-446655440043'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440014'::uuid,
		'660e8400-e29b-41d4-a716-446655440050'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440014'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'660e8400-e29b-41d4-a716-446655440052'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440016'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440017'::uuid,
		'660e8400-e29b-41d4-a716-446655440003'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440017'::uuid,
		'660e8400-e29b-41d4-a716-446655440004'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440018'::uuid,
		'660e8400-e29b-41d4-a716-446655440008'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440019'::uuid,
		'660e8400-e29b-41d4-a716-446655440028'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440020'::uuid,
		'660e8400-e29b-41d4-a716-446655440023'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440020'::uuid,
		'660e8400-e29b-41d4-a716-446655440024'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440021'::uuid,
		'660e8400-e29b-41d4-a716-446655440034'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440022'::uuid,
		'660e8400-e29b-41d4-a716-446655440033'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440023'::uuid,
		'660e8400-e29b-41d4-a716-446655440041'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440024'::uuid,
		'660e8400-e29b-41d4-a716-446655440043'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440025'::uuid,
		'660e8400-e29b-41d4-a716-446655440050'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440026'::uuid,
		'660e8400-e29b-41d4-a716-446655440050'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440026'::uuid,
		'660e8400-e29b-41d4-a716-446655440051'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440027'::uuid,
		'660e8400-e29b-41d4-a716-446655440002'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440028'::uuid,
		'660e8400-e29b-41d4-a716-446655440025'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440029'::uuid,
		'660e8400-e29b-41d4-a716-446655440031'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440030'::uuid,
		'660e8400-e29b-41d4-a716-446655440041'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440030'::uuid,
		'660e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440031'::uuid,
		'660e8400-e29b-41d4-a716-446655440052'::uuid
	);

INSERT INTO
	sharing_event_responses (sharing_event_id, response_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440032'::uuid,
		'660e8400-e29b-41d4-a716-446655440004'::uuid
	);

-- Link actions to sharing events
INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440001'::uuid,
		'770e8400-e29b-41d4-a716-446655440001'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440001'::uuid,
		'770e8400-e29b-41d4-a716-446655440002'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440002'::uuid,
		'770e8400-e29b-41d4-a716-446655440010'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'770e8400-e29b-41d4-a716-446655440003'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'770e8400-e29b-41d4-a716-446655440004'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440003'::uuid,
		'770e8400-e29b-41d4-a716-446655440005'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440004'::uuid,
		'770e8400-e29b-41d4-a716-446655440005'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440004'::uuid,
		'770e8400-e29b-41d4-a716-446655440006'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440005'::uuid,
		'770e8400-e29b-41d4-a716-446655440012'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440005'::uuid,
		'770e8400-e29b-41d4-a716-446655440013'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440006'::uuid,
		'770e8400-e29b-41d4-a716-446655440011'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440006'::uuid,
		'770e8400-e29b-41d4-a716-446655440014'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440007'::uuid,
		'770e8400-e29b-41d4-a716-446655440015'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440008'::uuid,
		'770e8400-e29b-41d4-a716-446655440020'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440008'::uuid,
		'770e8400-e29b-41d4-a716-446655440021'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'770e8400-e29b-41d4-a716-446655440022'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440009'::uuid,
		'770e8400-e29b-41d4-a716-446655440023'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440010'::uuid,
		'770e8400-e29b-41d4-a716-446655440024'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440010'::uuid,
		'770e8400-e29b-41d4-a716-446655440025'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440011'::uuid,
		'770e8400-e29b-41d4-a716-446655440032'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440011'::uuid,
		'770e8400-e29b-41d4-a716-446655440033'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440012'::uuid,
		'770e8400-e29b-41d4-a716-446655440033'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'770e8400-e29b-41d4-a716-446655440030'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'770e8400-e29b-41d4-a716-446655440031'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440013'::uuid,
		'770e8400-e29b-41d4-a716-446655440034'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440014'::uuid,
		'770e8400-e29b-41d4-a716-446655440040'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440014'::uuid,
		'770e8400-e29b-41d4-a716-446655440041'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'770e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'770e8400-e29b-41d4-a716-446655440043'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440015'::uuid,
		'770e8400-e29b-41d4-a716-446655440044'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440016'::uuid,
		'770e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440016'::uuid,
		'770e8400-e29b-41d4-a716-446655440043'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440017'::uuid,
		'770e8400-e29b-41d4-a716-446655440002'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440018'::uuid,
		'770e8400-e29b-41d4-a716-446655440004'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440019'::uuid,
		'770e8400-e29b-41d4-a716-446655440014'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440020'::uuid,
		'770e8400-e29b-41d4-a716-446655440013'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440021'::uuid,
		'770e8400-e29b-41d4-a716-446655440023'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440022'::uuid,
		'770e8400-e29b-41d4-a716-446655440022'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440023'::uuid,
		'770e8400-e29b-41d4-a716-446655440032'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440024'::uuid,
		'770e8400-e29b-41d4-a716-446655440034'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440025'::uuid,
		'770e8400-e29b-41d4-a716-446655440040'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440026'::uuid,
		'770e8400-e29b-41d4-a716-446655440041'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440026'::uuid,
		'770e8400-e29b-41d4-a716-446655440042'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440027'::uuid,
		'770e8400-e29b-41d4-a716-446655440002'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440028'::uuid,
		'770e8400-e29b-41d4-a716-446655440012'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440029'::uuid,
		'770e8400-e29b-41d4-a716-446655440021'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440030'::uuid,
		'770e8400-e29b-41d4-a716-446655440032'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440030'::uuid,
		'770e8400-e29b-41d4-a716-446655440033'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440031'::uuid,
		'770e8400-e29b-41d4-a716-446655440044'::uuid
	);

INSERT INTO
	sharing_event_actions (sharing_event_id, action_id)
VALUES
	(
		'880e8400-e29b-41d4-a716-446655440031'::uuid,
		'770e8400-e29b-41d4-a716-446655440045'::uuid
	);
