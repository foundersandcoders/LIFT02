#!/bin/bash

# Script to delete test fake data from local Supabase instance
# Executes the generated delete_test_fake_data.sql file via psql

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🧹 Cleaning test fake data from local Supabase...${NC}"

# Check if the generated delete script exists
if [ ! -f "supabase/generated/delete_test_fake_data.sql" ]; then
    echo -e "${RED}❌ Error: supabase/generated/delete_test_fake_data.sql not found${NC}"
    echo -e "${YELLOW}💡 Run ./scripts/generate-test-data.sh first${NC}"
    exit 1
fi

# Check if Supabase is running locally
if ! curl -s http://127.0.0.1:54321/rest/v1/ > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Local Supabase instance not running${NC}"
    echo -e "${YELLOW}💡 Start it with: supabase start${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Local Supabase instance detected${NC}"

# Get the local database URL (standard local Supabase setup)
DB_URL="postgresql://postgres:postgres@127.0.0.1:54322/postgres"

echo -e "${YELLOW}🗑️  Executing delete_test_fake_data.sql...${NC}"

# Execute the delete SQL file
if psql "$DB_URL" -f supabase/generated/delete_test_fake_data.sql > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Test fake data deleted successfully!${NC}"
    
    # Show what remains
    echo -e "${YELLOW}📊 Data summary after cleanup:${NC}"
    
    # Count records in each table
    PROFILES_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM profiles;" 2>/dev/null | xargs)
    RESPONSES_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM responses;" 2>/dev/null | xargs)
    ACTIONS_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM actions;" 2>/dev/null | xargs)
    SHARING_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM sharing_events;" 2>/dev/null | xargs)
    QUESTIONS_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM questions;" 2>/dev/null | xargs)
    
    echo "   - Profiles: ${PROFILES_COUNT:-0}"
    echo "   - Responses: ${RESPONSES_COUNT:-0}"
    echo "   - Actions: ${ACTIONS_COUNT:-0}"
    echo "   - Sharing Events: ${SHARING_COUNT:-0}"
    echo "   - Questions: ${QUESTIONS_COUNT:-0} (preserved)"
    
    echo -e "${GREEN}🎉 Local database cleaned, ready for fresh test data!${NC}"
else
    echo -e "${RED}❌ Failed to delete test data${NC}"
    echo -e "${YELLOW}💡 Check the SQL file for syntax errors${NC}"
    exit 1
fi