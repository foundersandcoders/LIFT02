-- 1. Auth: No Changes

-- 2. Profiles
  -- Pronouns
    -- Change pronouns to text array with exactly 3 elements
      -- This means we can assign pronouns intelligently
      -- ["he", "him", "his"]
      -- ["they", "them", "theirs"]
    alter table profiles
      alter column pronouns type text[] using array[pronouns, "", ""],
      add constraint pronouns_length_check check (array_length(pronouns, 1) = 3);

-- 3. Questions
  -- Order
    -- Make order column unique
    alter table questions
      add constraint questions_order_unique unique ("order");

-- 4. Responses
  -- Visibility
    -- Make visibility not null with default 'private'
    alter table responses
      alter column visibility set not null,
      alter column visibility set default 'private';

  -- Version
    -- Create a sequence that increments by 1 when edited
    create sequence response_version_seq;

    -- Modify the version column to use the sequence
    alter table responses 
      alter column version set default nextval('response_version_seq');

    -- Set the current version values to start from the sequence
    update responses 
      set version = nextval('response_version_seq')
      where version is not null;
    
    -- Add check constraint for version based on status
    alter table responses
      add constraint version_status_check check (
        (status = 'skipped' and version is null) or
        (status = 'skipped' and version is not null) or
        (status = 'answered' and version is not null)
      );

-- 5. Actions
  -- Status
    -- Add status column with active/archived options
    alter table actions
      add column status text not null default 'active' check (status in ('active', 'archived'));
  
  -- Version
    -- Create a sequence that increments by 1 when edited
    create sequence action_version_seq;

    -- Modify the version column to use the sequence
    alter table actions 
      alter column version set default nextval('action_version_seq');

    -- Set the current version values to start from the sequence
    update actions 
      set version = nextval('action_version_seq')
      where version is not null;

-- 6. Sharing Events: No Changes
-- 7. Sharing Event Responses: No Changes
-- 8. Sharing Event Actions: No Changes