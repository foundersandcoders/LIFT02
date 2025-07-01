-- 1. Supabase-managed users table is implicit; you don't create it manually

-- 2. Create sequences for version management
create sequence if not exists response_version_seq;
create sequence if not exists action_version_seq;

-- 3. profiles table
create table if not exists profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  name text,
  pronouns text[] constraint pronouns_length_check check (array_length(pronouns, 1) = 3),
  job_title text,
  employer_name text,
  employer_id uuid, -- future use
  line_manager_name text,
  line_manager_email text,
  line_manager_user_id uuid, -- future use
  inserted_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 4. questions table
create table if not exists questions (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  question_text text not null,
  "order" integer not null constraint questions_order_unique unique,
  preview text
);

-- 5. responses table
create table if not exists responses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  question_id uuid references questions on delete cascade,
  response_text text,
  status text check (status in ('answered', 'skipped')),
  visibility text not null default 'private' check (visibility in ('public', 'private')),
  version integer default nextval('response_version_seq'),
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  constraint version_status_check check (
    (status = 'skipped' and version is null) or
    (status = 'skipped' and version is not null) or
    (status = 'answered' and version is not null)
  )
);

-- 6. actions table
create table if not exists actions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  response_id uuid references responses on delete set null,
  type text not null,
  description text,
  status text not null default 'active' check (status in ( 'active', 'archived')),
  version integer default nextval('action_version_seq'),
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 6. sharing_events
create table if not exists sharing_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  recipient_email text not null,
  message text,
  shared_at timestamp with time zone default now()
);

-- 7. sharing_event_responses
create table if not exists sharing_event_responses (
  id uuid primary key default gen_random_uuid(),
  sharing_event_id uuid references sharing_events on delete cascade,
  response_id uuid references responses on delete cascade
);

-- 8. sharing_event_actions
create table if not exists sharing_event_actions (
  id uuid primary key default gen_random_uuid(),
  sharing_event_id uuid references sharing_events on delete cascade,
  action_id uuid references actions on delete cascade
);
