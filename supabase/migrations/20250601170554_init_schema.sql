-- Combined migration: Complete schema with line managers system
-- This combines the initial schema with the profiles restructure
-- 1. Create sequences for version management
create sequence if not exists response_version_seq;

create sequence if not exists action_version_seq;

-- 2. Create organizations table
create table if not exists organizations (
	id uuid primary key default gen_random_uuid (),
	name text not null,
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now()
);

-- 3. Create profiles table (without line_manager FK initially)
create table if not exists profiles (
	id uuid primary key default gen_random_uuid (),
	user_id uuid references auth.users on delete cascade,
	name text,
	pronouns text[] constraint pronouns_length_check check (array_length(pronouns, 1) = 3),
	job_title text,
	is_line_manager boolean default false,
	inserted_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now()
);

-- 4. Create line_managers table
create table if not exists line_managers (
	id uuid primary key default gen_random_uuid (),
	line_manager_id uuid not null references profiles (id) on delete cascade,
	organization_id uuid not null references organizations (id) on delete cascade,
	email text null unique,
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now(),
	constraint unique_line_manager_per_profile unique (line_manager_id)
);

-- 5. Add line_manager foreign key to profiles after line_managers table exists
alter table profiles
add column if not exists line_manager uuid references line_managers (id) on delete set null;

-- 6. Create questions table
create table if not exists questions (
	id uuid primary key default gen_random_uuid (),
	category text not null,
	question_text text not null,
	"order" integer not null constraint questions_order_unique unique,
	preview text
);

-- 7. Create responses table
create table if not exists responses (
	id uuid primary key default gen_random_uuid (),
	user_id uuid references auth.users on delete cascade,
	question_id uuid references questions on delete cascade,
	response_text text,
	status text check (status in ('answered', 'skipped')),
	visibility text not null default 'private' check (visibility in ('public', 'private')),
	version integer default nextval('response_version_seq'),
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now(),
	constraint version_status_check check (
		(
			status = 'skipped'
			and version is null
		)
		or (
			status = 'skipped'
			and version is not null
		)
		or (
			status = 'answered'
			and version is not null
		)
	)
);

-- 8. Create actions table
create table if not exists actions (
	id uuid primary key default gen_random_uuid (),
	user_id uuid references auth.users on delete cascade,
	response_id uuid references responses on delete set null,
	type text not null,
	description text,
	status text not null default 'active' check (status in ('active', 'archived')),
	version integer default nextval('action_version_seq'),
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now()
);

-- 9. Create sharing_events table
create table if not exists sharing_events (
	id uuid primary key default gen_random_uuid (),
	user_id uuid references auth.users on delete cascade,
	recipient_email text not null,
	message text,
	shared_at timestamp with time zone default now()
);

-- 10. Create sharing_event_responses table
create table if not exists sharing_event_responses (
	id uuid primary key default gen_random_uuid (),
	sharing_event_id uuid references sharing_events on delete cascade,
	response_id uuid references responses on delete cascade
);

-- 11. Create sharing_event_actions table
create table if not exists sharing_event_actions (
	id uuid primary key default gen_random_uuid (),
	sharing_event_id uuid references sharing_events on delete cascade,
	action_id uuid references actions on delete cascade
);

-- 12. Create resources table
create table if not exists resources (
	id uuid primary key default gen_random_uuid (),
	title text not null,
	description text,
	url text,
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now()
);

-- 13. Create indexes for better performance
create index if not exists idx_profiles_is_line_manager on profiles (is_line_manager);

create index if not exists idx_profiles_line_manager on profiles (line_manager);

create index if not exists idx_line_managers_organization on line_managers (organization_id);
