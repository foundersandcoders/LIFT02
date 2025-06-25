# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Supabase database structure and management in this repository.

## Database Architecture Overview

The LIFT Digital Workplace Passport uses a sophisticated PostgreSQL database hosted on Supabase with advanced versioning, sharing, and organizational features. The database is designed around neurodivergent workplace accommodation tracking with complete audit trails.

## Core Database Patterns

### Versioning System
- **Response Versioning**: Each user response edit creates a new row with incremented `version` and `is_latest=true`
- **Action Versioning**: Actions follow the same versioning pattern as responses
- **Sequences**: `response_version_seq` and `action_version_seq` manage version incrementing
- **Historical Preservation**: All previous versions remain in database for audit trails

### Sharing System Architecture
- **Point-in-Time Snapshots**: Sharing events capture exact response/action versions via junction tables
- **Junction Tables**: `sharing_event_responses` and `sharing_event_actions` link specific versions to sharing events
- **Complete Audit Trail**: Full history of what was shared, when, and to whom

### Organizational Structure
- **Recent Migration**: Added `organizations` and `line_managers` tables (2025-06-12)
- **Self-Referencing**: Profiles can reference other profiles as line managers
- **Future-Proofing**: Employer relationships designed for centralization

## Database Schema Structure

### Core Tables

**profiles** - User profile data
- Self-referencing line manager relationships
- Pronouns stored as 3-element text array
- Future-ready with `employer_id` and `line_manager_user_id` fields

**questions** - Survey questions
- Category-based organization (my_wellbeing, communication, etc.)
- Ordered presentation via `order` field
- Preview text for dashboard tiles

**responses** - User answers with versioning
- Versioned responses using `version` and `is_latest` pattern
- Status: 'answered' or 'skipped'
- Visibility: 'public' or 'private'

**actions** - Follow-up actions with versioning
- Linked to responses via `response_id`
- Same versioning pattern as responses
- Action types define different accommodation categories

### Relationship Tables

**sharing_events** - Email sharing instances
- Records when users share their passport with line managers
- Includes optional message and recipient email

**sharing_event_responses** & **sharing_event_actions** - Junction tables
- Link specific response/action versions to sharing events
- Enable point-in-time reconstruction of shared content

**organizations** & **line_managers** - Organizational structure
- Centralized organization management
- Line manager relationships with email contact

## Migration Management

### Migration Files
- `20250601170554_init_schema.sql`: Initial database schema with versioning
- `20250612170600_restructure_profiles_add_line_managers.sql`: Added organizational structure

### Migration Patterns
- Forward-only migrations (no rollbacks)
- Constraint validation for data integrity
- Sequence management for versioning

## Data Management Strategy

### Seeding Structure
- **Real Data**: `seed.sql` contains actual survey questions (auto-runs on `supabase db reset`)
- **Test Data**: Generated from `data/test_data_source.json` via generation scripts
- **Environment Separation**: Local development vs production data management

### Data Generation Workflow
1. **Source Files**: JSON files in `/data/` directory serve as single source of truth
2. **Generated SQL**: Scripts create SQL files from JSON sources
3. **Execution**: Scripts handle both seeding and cleanup operations

## Development Patterns

### Local Development
- **Docker-Based**: Local Supabase instance via Docker containers
- **Auto-Seeding**: Questions automatically seeded on `supabase db reset`
- **Test Data**: Separate test data seeding for development workflows

### Production Operations
- **Schema Deployment**: Migrations pushed via `supabase db push`
- **Controlled Seeding**: Optional test data seeding for production testing
- **Environment Variables**: Secure credential management

## Query Patterns

### Versioning Queries
```sql
-- Get latest responses only
SELECT * FROM responses WHERE is_latest = true;

-- Get historical sharing content
SELECT r.* FROM responses r
JOIN sharing_event_responses ser ON r.id = ser.response_id
WHERE ser.sharing_event_id = $sharing_event_id;
```

### Security Patterns
- **Row-Level Security**: User-scoped data access via Supabase RLS
- **Cascade Deletes**: Proper cleanup when users are removed
- **Constraint Validation**: Data integrity via check constraints

## Data Integrity Features

### Constraints
- **Pronouns Array**: Exactly 3 elements required
- **Status Validation**: Responses must be 'answered' or 'skipped'
- **Visibility Control**: 'public' or 'private' only
- **Version Consistency**: Complex checks for version/status relationships

### Sequences
- **Version Management**: Automatic incrementing for response and action versions
- **Reset Capability**: Scripts can reset sequences for clean development environments

## Common Operations

### Development Setup
```bash
supabase start                      # Start local instance
supabase db reset                   # Reset with questions
./scripts/local-seed-test-data.sh   # Add test data
```

### Schema Management
```bash
supabase db diff                    # Check for schema changes
supabase migration new <name>       # Create new migration
supabase db push                    # Deploy to production
```

### Data Management
```bash
./scripts/generate-test-data.sh     # Regenerate from JSON
./scripts/local-delete-test-data.sh # Clean test data
```

## Troubleshooting

### Common Issues
- **Version Sequence Conflicts**: Reset sequences after data cleanup
- **Foreign Key Violations**: Follow proper deletion order (sharing → actions → responses → profiles → users)
- **RLS Policies**: Ensure proper authentication context for data access
- **Migration Conflicts**: Use `supabase db pull` to sync remote changes

### Debugging Patterns
- Use `supabase logs` for real-time database activity
- Check constraint violations in PostgreSQL error messages
- Verify RLS policies with `EXPLAIN` queries in authenticated context