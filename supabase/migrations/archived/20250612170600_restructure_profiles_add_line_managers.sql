-- Migration: Restructure profiles and add line managers system
-- 1. Create organizations table first (referenced by line_managers)
create table if not exists organizations (
	id uuid primary key default gen_random_uuid (),
	name text not null,
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now()
);

-- 2. Create line_managers table
create table if not exists line_managers (
	id uuid primary key default gen_random_uuid (),
	line_manager_id uuid not null references profiles (id) on delete cascade,
	organization_id uuid not null references organizations (id) on delete cascade,
	email text null unique,
	created_at timestamp with time zone default now(),
	updated_at timestamp with time zone default now(),
	constraint unique_line_manager_per_profile unique (line_manager_id)
);

-- 3. Modify profiles table
-- Add new columns
alter table profiles
add column if not exists is_line_manager boolean default false;

alter table profiles
add column if not exists line_manager uuid references line_managers (id) on delete set null;

-- Remove old columns (drop constraints first if they exist)
alter table profiles
drop column if exists employer_name;

alter table profiles
drop column if exists employer_id;

alter table profiles
drop column if exists line_manager_name;

alter table profiles
drop column if exists line_manager_email;

alter table profiles
drop column if exists line_manager_user_id;

-- 4. Create indexes for better performance
create index if not exists idx_profiles_is_line_manager on profiles (is_line_manager);

create index if not exists idx_profiles_line_manager on profiles (line_manager);

create index if not exists idx_line_managers_organization on line_managers (organization_id);
