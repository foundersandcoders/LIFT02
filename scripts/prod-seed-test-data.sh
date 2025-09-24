#!/bin/bash

# Advanced API-based script to seed comprehensive test data to production
# Reads from test_data_source.json for single source of truth
# Creates users via auth API and profiles/responses via REST API

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding comprehensive test data to production...${NC}"

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

echo -e "${GREEN}✅ Environment variables loaded${NC}"
echo -e "${YELLOW}📡 API URL: $PUBLIC_SUPABASE_URL${NC}"

# Set up API headers
API_URL="$PUBLIC_SUPABASE_URL/rest/v1"
AUTH_HEADER="Authorization: Bearer $SUPABASE_SERVICE_ROLE_KEY"
APIKEY_HEADER="apikey: $SUPABASE_SERVICE_ROLE_KEY"
CONTENT_HEADER="Content-Type: application/json"
PREFER_HEADER="Prefer: return=minimal"

echo -e "${YELLOW}📤 Step 1: Creating auth users via admin API...${NC}"

# Read test data from JSON source
if [ ! -f "supabase/data/test_data_source.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/test_data_source.json not found${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Reading test data from JSON source...${NC}"
TEST_DATA=$(cat supabase/data/test_data_source.json)

# Extract and create auth users (these need to be created via admin API)
USERS_JSON=$(echo "$TEST_DATA" | jq -r '.users[] | "\(.id):\(.email):\(.name)"')
declare -a TEST_USERS
while IFS= read -r line; do
    TEST_USERS+=("$line")
done <<< "$USERS_JSON"

for user_data in "${TEST_USERS[@]}"; do
    USER_ID="${user_data%%:*}"
    REMAINING="${user_data#*:}"
    EMAIL="${REMAINING%%:*}"
    NAME="${REMAINING#*:}"
    
    echo "Creating user: $EMAIL..."
    RESPONSE=$(curl -s -X POST "$PUBLIC_SUPABASE_URL/auth/v1/admin/users" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" \
        -H "$CONTENT_HEADER" \
        -d "{
            \"user_metadata\": {\"name\": \"$NAME\"},
            \"email\": \"$EMAIL\",
            \"email_confirm\": true,
            \"id\": \"$USER_ID\",
            \"password\": \"temp_password_123\"
        }" 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q "error\|Error"; then
        echo "⚠️  User creation failed for $EMAIL: $RESPONSE"
    else
        echo "✅ User created: $EMAIL"
    fi
done

echo -e "${YELLOW}📤 Step 2: Creating organizations via API...${NC}"

# Create organizations using the data from JSON source
ORGANIZATIONS_JSON=$(echo "$TEST_DATA" | jq '.organizations')

ORG_RESPONSE=$(curl -s -X POST "$API_URL/organizations" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$CONTENT_HEADER" \
    -H "$PREFER_HEADER" \
    -d "$ORGANIZATIONS_JSON" 2>/dev/null)

if echo "$ORG_RESPONSE" | grep -q "error\|Error\|violates"; then
    echo -e "${RED}❌ Organization creation failed: $ORG_RESPONSE${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Organizations created successfully${NC}"
fi

echo -e "${YELLOW}📤 Step 3: Creating profiles (without line_manager FK) via API...${NC}"

# Create profiles using the data from JSON source (without line_manager FK first)
PROFILES_JSON=$(echo "$TEST_DATA" | jq '[.users[] | {
    id: .id,
    user_id: .id,
    name: .name,
    pronouns: .pronouns,
    job_title: .job_title,
    is_line_manager: .is_line_manager
}]')

PROFILE_RESPONSE=$(curl -s -X POST "$API_URL/profiles" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$CONTENT_HEADER" \
    -H "$PREFER_HEADER" \
    -d "$PROFILES_JSON" 2>/dev/null)

if echo "$PROFILE_RESPONSE" | grep -q "error\|Error\|violates"; then
    echo -e "${RED}❌ Profile creation failed: $PROFILE_RESPONSE${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Profiles created successfully${NC}"
fi

echo -e "${YELLOW}📤 Step 4: Creating line managers via API...${NC}"

# Create line managers using the data from JSON source
LINE_MANAGERS_JSON=$(echo "$TEST_DATA" | jq '.line_managers')

LM_RESPONSE=$(curl -s -X POST "$API_URL/line_managers" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$CONTENT_HEADER" \
    -H "$PREFER_HEADER" \
    -d "$LINE_MANAGERS_JSON" 2>/dev/null)

if echo "$LM_RESPONSE" | grep -q "error\|Error\|violates"; then
    echo -e "${RED}❌ Line manager creation failed: $LM_RESPONSE${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Line managers created successfully${NC}"
fi

echo -e "${YELLOW}📤 Step 5: Updating profiles with line_manager FK via API...${NC}"

# Update profiles to set line_manager FK for users who have one
echo "$TEST_DATA" | jq -c '.users[] | select(.line_manager != null)' | while read -r user; do
    USER_ID=$(echo "$user" | jq -r '.id')
    LINE_MANAGER_ID=$(echo "$user" | jq -r '.line_manager')
    
    curl -s -X PATCH "$API_URL/profiles?id=eq.$USER_ID" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" \
        -H "$CONTENT_HEADER" \
        -H "$PREFER_HEADER" \
        -d "{\"line_manager\": \"$LINE_MANAGER_ID\"}" > /dev/null
    
    echo "✅ Updated profile $USER_ID with line manager"
done

echo -e "${YELLOW}📤 Step 6: Creating responses via API...${NC}"

# Create responses with dynamic question lookup
echo "$TEST_DATA" | jq -c '.responses[]' | while read -r response; do
    RESPONSE_ID=$(echo "$response" | jq -r '.id')
    USER_ID=$(echo "$response" | jq -r '.user_id')
    QUESTION_ORDER=$(echo "$response" | jq -r '.question_order')
    QUESTION_CATEGORY=$(echo "$response" | jq -r '.question_category')
    RESPONSE_TEXT=$(echo "$response" | jq -r '.response_text')
    STATUS=$(echo "$response" | jq -r '.status')
    VISIBILITY=$(echo "$response" | jq -r '.visibility')

    # Get question ID (note: "order" is a reserved word, so we need to escape it)
    QUESTION_ID=$(curl -s -X GET "$API_URL/questions?category=eq.$QUESTION_CATEGORY&%22order%22=eq.$QUESTION_ORDER&select=id" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" 2>/dev/null | jq -r '.[0].id // empty')

    if [ ! -z "$QUESTION_ID" ]; then
        curl -s -X POST "$API_URL/responses" \
            -H "$AUTH_HEADER" \
            -H "$APIKEY_HEADER" \
            -H "$CONTENT_HEADER" \
            -H "$PREFER_HEADER" \
            -d "{
                \"id\": \"$RESPONSE_ID\",
                \"user_id\": \"$USER_ID\",
                \"question_id\": \"$QUESTION_ID\",
                \"response_text\": \"$RESPONSE_TEXT\",
                \"status\": \"$STATUS\",
                \"visibility\": \"$VISIBILITY\"
            }" > /dev/null
        echo "✅ Created response for question $QUESTION_ORDER in $QUESTION_CATEGORY"
    else
        echo "⚠️  Question not found: $QUESTION_CATEGORY order $QUESTION_ORDER"
    fi
done

echo -e "${YELLOW}📤 Step 7: Creating actions via API...${NC}"

# Create actions
echo "$TEST_DATA" | jq -c '.actions[]' | while read -r action; do
    ACTION_JSON=$(echo "$action" | jq '.')
    
    curl -s -X POST "$API_URL/actions" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" \
        -H "$CONTENT_HEADER" \
        -H "$PREFER_HEADER" \
        -d "$ACTION_JSON" > /dev/null
    
    ACTION_TYPE=$(echo "$action" | jq -r '.type')
    echo "✅ Created action: $ACTION_TYPE"
done

echo -e "${YELLOW}📤 Step 8: Creating sharing events via API...${NC}"

# Create sharing events and their relationships
echo "$TEST_DATA" | jq -c '.sharing_events[]' | while read -r sharing_event; do
    SHARING_ID=$(echo "$sharing_event" | jq -r '.id')
    USER_ID=$(echo "$sharing_event" | jq -r '.user_id')
    RECIPIENT_EMAIL=$(echo "$sharing_event" | jq -r '.recipient_email')
    MESSAGE=$(echo "$sharing_event" | jq -r '.message')
    
    # Create sharing event
    curl -s -X POST "$API_URL/sharing_events" \
        -H "$AUTH_HEADER" \
        -H "$APIKEY_HEADER" \
        -H "$CONTENT_HEADER" \
        -H "$PREFER_HEADER" \
        -d "{
            \"id\": \"$SHARING_ID\",
            \"user_id\": \"$USER_ID\",
            \"recipient_email\": \"$RECIPIENT_EMAIL\",
            \"message\": \"$MESSAGE\",
            \"shared_at\": \"$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)\"
        }" > /dev/null
    
    # Link responses
    echo "$sharing_event" | jq -r '.response_ids[]' | while read -r response_id; do
        curl -s -X POST "$API_URL/sharing_event_responses" \
            -H "$AUTH_HEADER" \
            -H "$APIKEY_HEADER" \
            -H "$CONTENT_HEADER" \
            -H "$PREFER_HEADER" \
            -d "{
                \"sharing_event_id\": \"$SHARING_ID\",
                \"response_id\": \"$response_id\"
            }" > /dev/null
    done
    
    # Link actions
    echo "$sharing_event" | jq -r '.action_ids[]' | while read -r action_id; do
        curl -s -X POST "$API_URL/sharing_event_actions" \
            -H "$AUTH_HEADER" \
            -H "$APIKEY_HEADER" \
            -H "$CONTENT_HEADER" \
            -H "$PREFER_HEADER" \
            -d "{
                \"sharing_event_id\": \"$SHARING_ID\",
                \"action_id\": \"$action_id\"
            }" > /dev/null
    done
    
    echo "✅ Created sharing event to $RECIPIENT_EMAIL"
done

echo -e "${GREEN}✅ Comprehensive test data seeded successfully!${NC}"
echo -e "${YELLOW}   📊 Created from JSON source:${NC}"
ORG_COUNT=$(echo "$TEST_DATA" | jq '.organizations | length')
LINE_MANAGER_COUNT=$(echo "$TEST_DATA" | jq '.line_managers | length')
USER_COUNT=$(echo "$TEST_DATA" | jq '.users | length')
RESPONSE_COUNT=$(echo "$TEST_DATA" | jq '.responses | length') 
ACTION_COUNT=$(echo "$TEST_DATA" | jq '.actions | length')
SHARING_COUNT=$(echo "$TEST_DATA" | jq '.sharing_events | length')
echo -e "${YELLOW}   - $ORG_COUNT organizations${NC}"
echo -e "${YELLOW}   - $LINE_MANAGER_COUNT line managers${NC}"
echo -e "${YELLOW}   - $USER_COUNT diverse user profiles${NC}"
echo -e "${YELLOW}   - $RESPONSE_COUNT response entries${NC}"
echo -e "${YELLOW}   - $ACTION_COUNT workplace adjustments and actions${NC}"
echo -e "${YELLOW}   - $SHARING_COUNT sharing events with relationships${NC}"

echo -e "${GREEN}🎉 Production test environment ready!${NC}"