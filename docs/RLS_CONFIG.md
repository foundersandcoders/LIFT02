# Row Level Security (RLS) Configuration

## Overview

This document describes the Row Level Security implementation for the LIFT Digital Workplace Passport application. RLS provides database-level access control to ensure users can only access their own data, protecting sensitive workplace accommodation information.

## Current Implementation Status

### ✅ Development Environment
- **Status**: Fully implemented and tested
- **Configuration**: Permissive policies for development workflow
- **Access**: Anon role can access all data for testing

### ⚠️ Production Environment
- **Status**: Requires migration deployment
- **Configuration**: Will enforce strict user-scoped access
- **Access**: Only authenticated users can access their own data

## Security Architecture

### Database Tables with RLS

All user-related tables have RLS enabled:

- `profiles` - User profile data
- `responses` - Survey responses
- `actions` - Follow-up actions
- `sharing_events` - Email sharing instances
- `sharing_event_responses` - Shared response snapshots
- `sharing_event_actions` - Shared action snapshots
- `line_managers` - Line manager relationships

### Public Tables (No RLS)

These tables contain non-sensitive data accessible to all users:

- `questions` - Survey questions
- `organizations` - Organizational data
- `resources` - Public resources

## Policy Structure

### Development Policies (Current)

**Purpose**: Enable development workflow without authentication barriers

```sql
-- Example: Profiles table policy
CREATE POLICY "Allow profile access" ON profiles
  FOR ALL USING (
    auth.role() = 'anon' OR                    -- Development access
    auth.role() = 'service_role' OR            -- Admin access
    auth.uid() = user_id                       -- User's own data
  );
```

**Access Levels**:
- `anon` role: Full access (development only)
- `service_role`: Full access (admin operations)
- `authenticated` users: Own data only

### Production Policies (Target)

**Purpose**: Enforce strict data isolation for production security

```sql
-- Example: Production-ready policy
CREATE POLICY "Users can access own profiles" ON profiles
  FOR ALL USING (
    auth.role() = 'service_role' OR            -- Admin access only
    auth.uid() = user_id                       -- User's own data
  );
```

**Access Levels**:
- `service_role`: Full access (admin operations only)
- `authenticated` users: Own data only
- `anon` role: **NO ACCESS** (security requirement)

## Migration Files

### Applied Migrations

1. **`20250923195428_enable_row_level_security.sql`**
   - Enables RLS on all user tables
   - Creates initial strict policies
   - **Status**: Applied to development

2. **`20250923205100_allow_service_role_access.sql`**
   - Adds service role bypass for admin operations
   - **Status**: Applied to development

3. **`20250923205334_allow_anon_access_for_dev.sql`**
   - Adds anon role access for development
   - **Status**: Applied to development, **DO NOT APPLY TO PRODUCTION**

### Production Migration Strategy

**Option A: Apply all migrations then remove dev access**
```bash
# Apply all existing migrations
npx supabase db push

# Create and apply production hardening migration
npx supabase migration new harden_rls_for_production
# This migration removes anon access
```

**Option B: Apply only production-ready migrations**
```bash
# Apply only the first two migrations to production
# Skip the dev-specific migration
```

## Production Deployment Steps

### Prerequisites

1. **Magic Link Authentication**: Must be implemented before production deployment
2. **User Registration Flow**: Profile creation on first login
3. **Session Management**: Proper JWT token handling

### Step 1: Apply RLS Migrations

```bash
# Navigate to project directory
cd /path/to/project

# Apply migrations to production database
npx supabase db push --linked

# Or using production script
./scripts/prod-run-migrations.sh
```

### Step 2: Create Production Hardening Migration

Create `supabase/migrations/YYYYMMDDHHMMSS_harden_rls_for_production.sql`:

```sql
-- Remove anon access for production security
-- Keep only authenticated user access and service role for admin

-- Update all table policies to remove anon role
DROP POLICY IF EXISTS "Allow profile access" ON profiles;
CREATE POLICY "Users can access own profiles" ON profiles
  FOR ALL USING (
    auth.role() = 'service_role' OR
    auth.uid() = user_id
  );

-- Repeat for all other tables...
```

### Step 3: Verify Security

**Test authenticated access**:
```sql
-- As authenticated user, should only see own data
SELECT COUNT(*) FROM profiles; -- Should return 1 (own profile)
```

**Test anon access**:
```sql
-- As anon user, should see no data
SELECT COUNT(*) FROM profiles; -- Should return 0
```

## Security Considerations

### Current Vulnerabilities (Development Only)

⚠️ **CRITICAL**: Development environment allows anon access to all user data
- **Risk**: Complete data exposure without authentication
- **Mitigation**: DO NOT deploy dev migrations to production
- **Timeline**: Must be resolved before production launch

### Production Security Features

✅ **Database-Level Protection**: RLS enforced at PostgreSQL level
✅ **Defense in Depth**: Application + database security layers
✅ **Audit Trail**: All access attempts logged by Supabase
✅ **User Isolation**: Zero data leakage between users

### Authentication Integration

**Required for Production**:
1. Magic link authentication implementation
2. JWT token validation in RLS policies
3. User profile creation on first login
4. Session management and refresh

**RLS Policy Dependencies**:
- `auth.uid()` requires valid JWT token
- `auth.role()` identifies user permissions
- Profile relationships enable data scoping

## Testing & Verification

### Development Testing

```bash
# Verify anon access works (development)
curl -H "Authorization: Bearer $ANON_KEY" \
     "$SUPABASE_URL/rest/v1/profiles"

# Should return all profiles
```

### Production Testing

```bash
# Verify anon access blocked (production)
curl -H "Authorization: Bearer $ANON_KEY" \
     "$SUPABASE_URL/rest/v1/profiles"

# Should return empty array or 401 error

# Verify authenticated access (production)
curl -H "Authorization: Bearer $USER_JWT" \
     "$SUPABASE_URL/rest/v1/profiles"

# Should return only user's own profile
```

## Troubleshooting

### Common Issues

**Problem**: App can't load data after RLS deployment
- **Cause**: Anon key blocked by production policies
- **Solution**: Implement authentication before RLS deployment

**Problem**: Users see other users' data
- **Cause**: RLS policies not properly scoped
- **Solution**: Verify `auth.uid() = user_id` in all policies

**Problem**: Admin operations fail
- **Cause**: Missing service role bypass
- **Solution**: Ensure `auth.role() = 'service_role'` in policies

### Debugging Commands

```sql
-- Check RLS status
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public';

-- View current policies
SELECT * FROM pg_policies
WHERE tablename = 'profiles';

-- Test policy as different roles
SET ROLE anon;
SELECT COUNT(*) FROM profiles;

SET ROLE authenticated;
SELECT COUNT(*) FROM profiles;
```

## Migration Rollback Plan

If RLS causes production issues:

```sql
-- Emergency disable RLS (temporary)
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
-- Repeat for other tables...

-- Re-enable after fixing policies
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
```

## Next Steps

1. **Implement Magic Link Authentication**
2. **Create Production Hardening Migration**
3. **Test Authentication Flow with RLS**
4. **Deploy to Production with Monitoring**
5. **Verify Security in Production Environment**

---

**⚠️ IMPORTANT**: The current development configuration is NOT production-ready. The anon role bypass must be removed before production deployment to prevent unauthorized data access.