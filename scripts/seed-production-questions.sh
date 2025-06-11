#!/bin/bash

# Script to seed only questions data to production
# This seeds the real questions without test user data
# Uses the same approach as deploy-db.sh

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding questions data to production...${NC}"

# Check if .env.production exists
if [ ! -f ".env.production" ]; then
    echo -e "${RED}❌ Error: .env.production file not found${NC}"
    echo "Create .env.production with your production environment variables"
    exit 1
fi

# Source environment variables
echo -e "${YELLOW}📋 Loading environment variables from .env.production...${NC}"
export $(grep -v '^#' .env.production | xargs)

# Validate required environment variables
if [ -z "$SUPABASE_DB_PASSWORD" ]; then
    echo -e "${RED}❌ Error: SUPABASE_DB_PASSWORD not found in .env.production${NC}"
    exit 1
fi

if [ -z "$SUPABASE_PROJECT_ID" ]; then
    echo -e "${RED}❌ Error: SUPABASE_PROJECT_ID not found in .env.production${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Environment variables loaded${NC}"
echo -e "${YELLOW}📡 Project ID: $SUPABASE_PROJECT_ID${NC}"

# Login to Supabase (if not already logged in)
echo -e "${YELLOW}🔐 Checking Supabase authentication...${NC}"
if ! npx supabase projects list >/dev/null 2>&1; then
    echo -e "${YELLOW}🔑 Logging in to Supabase...${NC}"
    npx supabase login
fi

# Link project (if not already linked)
echo -e "${YELLOW}🔗 Linking to production project...${NC}"
npx supabase link --project-ref "$SUPABASE_PROJECT_ID" || true

# Create a temporary SQL file with the seed data
echo -e "${YELLOW}📤 Applying questions seed data...${NC}"
TEMP_SQL=$(mktemp)
cat supabase/seed.sql > "$TEMP_SQL"

# Execute the SQL using Supabase CLI
if command -v psql >/dev/null 2>&1; then
    # Use psql with Supabase connection if available
    psql "postgresql://postgres:$SUPABASE_DB_PASSWORD@db.$SUPABASE_PROJECT_ID.supabase.co:5432/postgres" -f "$TEMP_SQL" 2>/dev/null || {
        echo -e "${YELLOW}Direct psql failed, using Supabase CLI method...${NC}"
        # Fallback to inserting via migration with proper timestamp
        TIMESTAMP=$(date +"%Y%m%d%H%M%S")
        MIGRATION_FILE="supabase/migrations/${TIMESTAMP}_seed_questions.sql"
        echo "-- Temporary seed migration for questions" > "$MIGRATION_FILE"
        cat "$TEMP_SQL" >> "$MIGRATION_FILE"
        npx supabase db push --password "$SUPABASE_DB_PASSWORD"
        rm "$MIGRATION_FILE"
    }
else
    # Use Supabase CLI method with proper timestamp
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    MIGRATION_FILE="supabase/migrations/${TIMESTAMP}_seed_questions.sql"
    echo "-- Temporary seed migration for questions" > "$MIGRATION_FILE"
    cat "$TEMP_SQL" >> "$MIGRATION_FILE"
    npx supabase db push --password "$SUPABASE_DB_PASSWORD"
    rm "$MIGRATION_FILE"
fi

# Clean up
rm "$TEMP_SQL"

echo -e "${GREEN}✅ Questions seeded successfully in production!${NC}"