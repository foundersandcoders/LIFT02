-- 1. Supabase-managed users table is implicit; you don't create it manually

-- 2. profiles table
create table profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  name text,
  pronouns text,
  job_title text,
  employer_name text,
  employer_id uuid, -- future use
  line_manager_name text,
  line_manager_email text,
  line_manager_user_id uuid, -- future use
  inserted_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 3. questions table
create table questions (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  question_text text not null,
  "order" integer not null
);

-- 4. responses table
create table responses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  question_id uuid references questions on delete cascade,
  response_text text,
  status text check (status in ('answered', 'skipped')),
  visibility text check (visibility in ('public', 'private')),
  version integer not null,
  is_latest boolean default true,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 5. actions table
create table actions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  response_id uuid references responses on delete set null,
  type text not null,
  description text,
  version integer not null,
  is_latest boolean default true,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 6. sharing_events
create table sharing_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  recipient_email text not null,
  message text,
  shared_at timestamp with time zone default now()
);

-- 7. sharing_event_responses
create table sharing_event_responses (
  id uuid primary key default gen_random_uuid(),
  sharing_event_id uuid references sharing_events on delete cascade,
  response_id uuid references responses on delete cascade
);

-- 8. sharing_event_actions
create table sharing_event_actions (
  id uuid primary key default gen_random_uuid(),
  sharing_event_id uuid references sharing_events on delete cascade,
  action_id uuid references actions on delete cascade
);
