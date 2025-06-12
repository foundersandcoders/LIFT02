#!/bin/bash

# Script to seed test fake data to local Supabase instance
# Executes the generated test_fake_data.sql file via psql

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding test fake data to local Supabase...${NC}"

# Check if the generated test data file exists
if [ ! -f "supabase/generated/test_fake_data.sql" ]; then
    echo -e "${RED}❌ Error: supabase/generated/test_fake_data.sql not found${NC}"
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

echo -e "${YELLOW}📤 Executing test_fake_data.sql...${NC}"

# Check if psql is available
if ! command -v psql >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: psql command not found${NC}"
    echo -e "${YELLOW}💡 Install PostgreSQL client: brew install postgresql${NC}"
    echo -e "${YELLOW}💡 Or use Docker: docker exec -i supabase_db_<project> psql -U postgres${NC}"
    exit 127
fi

# Execute the SQL file and capture output
SQL_OUTPUT=$(psql "$DB_URL" -f supabase/generated/test_fake_data.sql 2>&1)
SQL_EXIT_CODE=$?

if [ $SQL_EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✅ Test fake data seeded successfully!${NC}"
    
    # Show what was created
    echo -e "${YELLOW}📊 Data summary:${NC}"
    
    # Count records in each table
    ORGANIZATIONS_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM organizations;" 2>/dev/null | xargs)
    LINE_MANAGERS_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM line_managers;" 2>/dev/null | xargs)
    PROFILES_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM profiles;" 2>/dev/null | xargs)
    RESPONSES_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM responses;" 2>/dev/null | xargs)
    ACTIONS_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM actions;" 2>/dev/null | xargs)
    SHARING_COUNT=$(psql "$DB_URL" -t -c "SELECT COUNT(*) FROM sharing_events;" 2>/dev/null | xargs)
    
    echo "   - Organizations: ${ORGANIZATIONS_COUNT:-0}"
    echo "   - Line Managers: ${LINE_MANAGERS_COUNT:-0}"
    echo "   - Profiles: ${PROFILES_COUNT:-0}"
    echo "   - Responses: ${RESPONSES_COUNT:-0}"
    echo "   - Actions: ${ACTIONS_COUNT:-0}"
    echo "   - Sharing Events: ${SHARING_COUNT:-0}"
    
    echo -e "${GREEN}🎉 Local development environment ready with test data!${NC}"
    
    # Show any warnings or notices from SQL execution
    if [ ! -z "$SQL_OUTPUT" ] && [ "$SQL_OUTPUT" != "INSERT 0 5" ]; then
        echo -e "${YELLOW}📋 SQL execution output:${NC}"
        echo "$SQL_OUTPUT"
    fi
else
    echo -e "${RED}❌ Failed to seed test data${NC}"
    echo -e "${RED}SQL Error Output:${NC}"
    echo "$SQL_OUTPUT"
    echo ""
    echo -e "${YELLOW}💡 Check the SQL file for syntax errors or constraint violations${NC}"
    exit 1
fi