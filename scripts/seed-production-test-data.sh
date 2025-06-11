#!/bin/bash

# Script to seed test data to production
# This seeds fake test users and responses for development/testing
# Uses the same approach as deploy-db.sh and seed-production-questions.sh

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding test data to production...${NC}"

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

# Execute the test data file directly (no migration history pollution)
echo -e "${YELLOW}📤 Applying test data...${NC}"
./scripts/execute-sql-production.sh supabase/test_data_seed.sql

echo -e "${GREEN}✅ Test data seeded successfully in production!${NC}"
echo -e "${YELLOW}   - 5 fake users with profiles${NC}"
echo -e "${YELLOW}   - Sample responses across different categories${NC}"
echo -e "${YELLOW}   - Workplace adjustments and actions${NC}"
echo -e "${YELLOW}   - Sharing events with line managers${NC}"