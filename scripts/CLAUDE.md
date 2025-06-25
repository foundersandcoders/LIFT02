# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with database management scripts in this repository.

## Scripts Overview

The `/scripts/` directory contains 7 database management scripts that handle environment-specific operations for the LIFT Digital Workplace Passport project. These scripts manage data seeding, migrations, and cleanup operations across local development and production environments.

## Script Dependencies

### Required Tools
- **psql**: PostgreSQL client for direct database operations
- **jq**: JSON processor for data generation (optional, falls back to manual instructions)
- **npx/npm**: Node.js package manager for Supabase CLI operations
- **curl**: HTTP client for health checks

### Environment Variables

**Local Development:**
- Standard local Supabase setup uses: `postgresql://postgres:postgres@127.0.0.1:54322/postgres`

**Production:**
- Requires `.env.production` file with:
  - `SUPABASE_DB_PASSWORD`: Production database password
  - `SUPABASE_PROJECT_ID`: Production project reference ID
  - `DATABASE_URL`: Full PostgreSQL connection string (for direct psql operations)

## Script Execution Patterns

### Data Generation Workflow
```bash
# 1. Generate test data files from JSON sources
./scripts/generate-test-data.sh

# 2. Seed local development with test data  
./scripts/local-seed-test-data.sh

# 3. Clean up test data when needed
./scripts/local-delete-test-data.sh
```

### Production Deployment Workflow
```bash
# 1. Deploy schema changes to production
./scripts/prod-run-migrations.sh

# 2. Populate the questios
./scripts/prod-seed-questions.sh

# 3. Optionally seed production with test data
./scripts/prod-seed-test-data.sh
```

## Script Execution Order

### Critical Dependencies
1. **generate-test-data.sh** must run first to create SQL files from JSON sources
2. Local seeding requires Supabase instance running (`supabase start`)
3. Production operations require proper authentication (`supabase login`)

### Error Handling Patterns
- All scripts use `set -e` for fail-fast behavior
- Colored output for status messages (GREEN/YELLOW/RED)
- Comprehensive pre-flight checks for required tools and environments
- Detailed error messages with suggested remediation steps

## Generated Files

### Auto-Generated SQL Files
- `supabase/seed.sql`: Questions data (auto-runs on `supabase db reset`)
- `supabase/generated/test_fake_data.sql`: Complete test dataset
- `supabase/generated/delete_test_fake_data.sql`: Cleanup operations

### Single Source of Truth
- `supabase/data/questions.json`: Real question data
- `supabase/data/test_data_source.json`: Comprehensive test dataset

## Common Operations

### Local Development Setup
```bash
# Start fresh with clean test data
supabase db reset                    # Resets DB + seeds questions
./scripts/generate-test-data.sh      # Regenerate SQL from JSON
./scripts/local-seed-test-data.sh    # Add test users/responses
```

### Production Deployment
```bash
# Deploy schema and optionally seed test data
./scripts/prod-run-migrations.sh     # Deploy schema changes
./scripts/prod-seed-questions.sh.    # Populate the questions
./scripts/prod-seed-test-data.sh     # Add test data (optional)
```

### Data Management
```bash
# Clean slate local development
./scripts/local-delete-test-data.sh  # Remove test data only
supabase db reset                    # Full reset with questions

# Regenerate test data files
./scripts/generate-test-data.sh      # Update SQL from JSON sources
```

## Error Recovery

### Common Issues
1. **Missing psql**: Install PostgreSQL client (`brew install postgresql`)
2. **Missing jq**: Install JSON processor (`brew install jq`)
3. **Supabase not running**: Start local instance (`supabase start`)
4. **Missing .env.production**: Create file with required environment variables
5. **Authentication errors**: Run `supabase login` for production operations

### Verification Patterns
- Scripts include comprehensive health checks before execution
- Post-execution summaries show record counts for verification
- Exit codes properly indicate success/failure status

## Security Considerations

### Environment Separation
- Local scripts use hardcoded local database URLs
- Production scripts require explicit environment variable configuration
- No production credentials stored in code

### Data Safety
- Delete operations target specific test user IDs only
- Foreign key cascade handling prevents orphaned records
- Sequence resets maintain database integrity

## Troubleshooting

### Script Execution Issues
- Run scripts from project root directory
- Ensure proper file permissions (`chmod +x ./scripts/*.sh`)
- Check environment variable availability before production operations
- Verify Supabase CLI authentication status

### Database Connection Issues
- Local: Ensure Supabase Docker containers are running
- Production: Verify network connectivity and credentials
- Use `supabase status` to check local instance health