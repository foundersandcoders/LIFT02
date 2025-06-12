#!/bin/bash

# API-based script to delete comprehensive test data from production
# Reads from test_data_source.json for single source of truth
# Removes all test users and related data while preserving questions

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🧹 Cleaning up comprehensive test data...${NC}"

# Check if .env.production exists
if [ ! -f ".env.production" ]; then
    echo -e "${RED}❌ Error: .env.production file not found${NC}"
    exit 1
fi

# Source environment variables
echo -e "${YELLOW}📋 Loading environment variables...${NC}"
export $(grep -v '^#' .env.production | xargs)

# Validate required environment variables
if [ -z "$PUBLIC_SUPABASE_URL" ] || [ -z "$SUPABASE_SERVICE_ROLE_KEY" ]; then
    echo -e "${RED}❌ Error: Missing required API credentials${NC}"
    exit 1
fi

# Set up API headers
API_URL="$PUBLIC_SUPABASE_URL/rest/v1"
AUTH_HEADER="Authorization: Bearer $SUPABASE_SERVICE_ROLE_KEY"
APIKEY_HEADER="apikey: $SUPABASE_SERVICE_ROLE_KEY"
CONTENT_HEADER="Content-Type: application/json"

echo -e "${YELLOW}📡 API URL: $PUBLIC_SUPABASE_URL${NC}"

# Delete test data by targeting specific test user IDs
# This is safer than DELETE without WHERE clauses

# Read test data from JSON source
if [ ! -f "supabase/data/test_data_source.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/test_data_source.json not found${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Reading test data from JSON source...${NC}"
TEST_DATA=$(cat supabase/data/test_data_source.json)

echo -e "${YELLOW}🗑️  Deleting test data for specific users...${NC}"

# Extract test user IDs from JSON
USER_IDS_JSON=$(echo "$TEST_DATA" | jq -r '.users[].id')
declare -a TEST_USER_IDS
while IFS= read -r line; do
    TEST_USER_IDS+=("$line")
done <<< "$USER_IDS_JSON"

# Create a filter for the user IDs
USER_FILTER="user_id.in.($(IFS=,; echo "${TEST_USER_IDS[*]}"))"

echo "Deleting sharing event links for test users..."
curl -s -X DELETE "$API_URL/sharing_event_actions?action_id.in.(select(id).from(actions).where($USER_FILTER))" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

curl -s -X DELETE "$API_URL/sharing_event_responses?response_id.in.(select(id).from(responses).where($USER_FILTER))" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

echo "Deleting sharing events for test users..."
curl -s -X DELETE "$API_URL/sharing_events?$USER_FILTER" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

echo "Deleting actions for test users..."
curl -s -X DELETE "$API_URL/actions?$USER_FILTER" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

echo "Deleting responses for test users..."  
curl -s -X DELETE "$API_URL/responses?$USER_FILTER" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

echo "Deleting profiles for test users..."
curl -s -X DELETE "$API_URL/profiles?$USER_FILTER" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" > /dev/null

echo "Deleting line managers..."
# Delete line managers one by one to avoid filter issues
echo "$TEST_DATA" | jq -c '.line_managers[]' | while read -r lm; do
    LM_ID=$(echo "$lm" | jq -r '.id')
    LM_EMAIL=$(echo "$lm" | jq -r '.email')
    
    echo "Deleting line manager: $LM_EMAIL ($LM_ID)"
    LM_DELETE_RESPONSE=$(curl -s -X DELETE "$API_URL/line_managers?id=eq.$LM_ID" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" 2>&1)
    
    if echo "$LM_DELETE_RESPONSE" | grep -q "error\|Error"; then
        echo "⚠️  Failed to delete line manager $LM_EMAIL: $LM_DELETE_RESPONSE"
    else
        echo "✅ Deleted line manager: $LM_EMAIL"
    fi
done

echo "Deleting organizations..."
# Delete organizations one by one to avoid filter issues
echo "$TEST_DATA" | jq -c '.organizations[]' | while read -r org; do
    ORG_ID=$(echo "$org" | jq -r '.id')
    ORG_NAME=$(echo "$org" | jq -r '.name')
    
    echo "Deleting organization: $ORG_NAME ($ORG_ID)"
    ORG_DELETE_RESPONSE=$(curl -s -X DELETE "$API_URL/organizations?id=eq.$ORG_ID" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" 2>&1)
    
    if echo "$ORG_DELETE_RESPONSE" | grep -q "error\|Error"; then
        echo "⚠️  Failed to delete organization $ORG_NAME: $ORG_DELETE_RESPONSE"
    else
        echo "✅ Deleted organization: $ORG_NAME"
    fi
done

echo -e "${YELLOW}🗑️  Deleting test users from auth...${NC}"

# Extract test emails from JSON
USER_EMAILS_JSON=$(echo "$TEST_DATA" | jq -r '.users[].email')
declare -a TEST_EMAILS
while IFS= read -r line; do
    TEST_EMAILS+=("$line")
done <<< "$USER_EMAILS_JSON"

# Delete specific test users via admin API

for email in "${TEST_EMAILS[@]}"; do
    echo "Deleting user: $email..."
    
    # Get the user by email and delete
    USER_DATA=$(curl -s -X GET "$PUBLIC_SUPABASE_URL/auth/v1/admin/users?email=$email" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER")
    
    USER_ID=$(echo "$USER_DATA" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)
    
    if [ ! -z "$USER_ID" ]; then
        curl -s -X DELETE "$PUBLIC_SUPABASE_URL/auth/v1/admin/users/$USER_ID" \
            -H "$AUTH_HEADER" \
            -H "$APIKEY_HEADER" > /dev/null
        echo "✅ Deleted user: $email"
    else
        echo "⚠️  User not found: $email"
    fi
done

echo -e "${GREEN}✅ Test data cleanup completed!${NC}"

# Verify cleanup
echo -e "${YELLOW}📊 Verifying cleanup...${NC}"

ORG_COUNT=$(curl -s -X GET "$API_URL/organizations?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

LINE_MANAGER_COUNT=$(curl -s -X GET "$API_URL/line_managers?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

PROFILE_COUNT=$(curl -s -X GET "$API_URL/profiles?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

RESPONSE_COUNT=$(curl -s -X GET "$API_URL/responses?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

QUESTION_COUNT=$(curl -s -X GET "$API_URL/questions?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

echo "📊 Database status after cleanup:"
echo "   - Organizations: ${ORG_COUNT:-0}"
echo "   - Line Managers: ${LINE_MANAGER_COUNT:-0}"
echo "   - Profiles: ${PROFILE_COUNT:-0}"
echo "   - Responses: ${RESPONSE_COUNT:-0}" 
echo "   - Questions: ${QUESTION_COUNT:-0} (preserved)"
echo ""
echo -e "${GREEN}💡 Data definitions managed in: supabase/data/test_data_source.json${NC}"

echo -e "${GREEN}🎉 Ready for fresh test data!${NC}"