#!/bin/bash

# Database deployment script
# This script uses environment variables from .env.production to deploy schema changes

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting database deployment...${NC}"

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

# Check if npx is available
if ! command -v npx >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: npx command not found${NC}"
    echo -e "${YELLOW}💡 Run this script in your regular Terminal app (not VS Code)${NC}"
    echo -e "${YELLOW}💡 Or install Node.js/npm to make npx available${NC}"
    exit 127
fi

# Login to Supabase (if not already logged in)
echo -e "${YELLOW}🔐 Checking Supabase authentication...${NC}"
if ! npx supabase projects list >/dev/null 2>&1; then
    echo -e "${YELLOW}🔑 Logging in to Supabase...${NC}"
    npx supabase login
fi

# Link project (if not already linked)
echo -e "${YELLOW}🔗 Linking to production project...${NC}"
npx supabase link --project-ref "$SUPABASE_PROJECT_ID" || true

# Push database changes
echo -e "${YELLOW}📤 Pushing database schema changes...${NC}"
npx supabase db push --password "$SUPABASE_DB_PASSWORD"

echo -e "${GREEN}🎉 Database deployment completed successfully!${NC}"