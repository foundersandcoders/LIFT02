#!/bin/bash

# Generator script that creates both SQL and API scripts from test_data_source.json
# Single source of truth for all test data

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔧 Generating test data files from source...${NC}"

# Check if jq is available, if not provide manual instructions
if ! command -v jq >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  jq not available. Providing manual generation instructions...${NC}"
    echo ""
    echo -e "${GREEN}📋 To generate test data files:${NC}"
    echo "1. Install jq: sudo apt-get install jq"
    echo "2. Run this script again: ./scripts/generate-test-data.sh"
    echo ""
    echo -e "${YELLOW}💡 For now, the existing generated/test_fake_data.sql can be used${NC}"
    echo -e "${YELLOW}   or manually updated from supabase/data/test_data_source.json${NC}"
    exit 0
fi

# Check if source files exist
if [ ! -f "supabase/data/questions.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/questions.json not found${NC}"
    exit 1
fi

if [ ! -f "supabase/data/test_data_source.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/test_data_source.json not found${NC}"
    exit 1
fi

echo -e "${YELLOW}📤 Reading data sources...${NC}"

# Read the JSON files
QUESTIONS_DATA=$(cat supabase/data/questions.json)
TEST_DATA=$(cat supabase/data/test_data_source.json)

echo -e "${YELLOW}📝 Generating seed.sql file...${NC}"

# Generate the seed.sql file for questions (in root for auto-seeding)
cat > supabase/seed.sql << 'EOF'
-- Seed data for questions table
-- This file is auto-generated from data/questions.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate

INSERT INTO questions (category, question_text, "order", preview) VALUES
EOF

# Add questions
echo "$QUESTIONS_DATA" | jq -r '.questions | length as $len | to_entries | map(
  "  (\u0027" + .value.category + "\u0027, \u0027" + (.value.question_text | gsub("\u0027"; "\u0027\u0027")) + "\u0027, " + (.value.order | tostring) + ", \u0027" + .value.preview + "\u0027)" + (if (.key == ($len - 1)) then ";" else "," end)
) | join("\n")' >> supabase/seed.sql

echo -e "${GREEN}✅ Generated supabase/seed.sql${NC}"

echo -e "${YELLOW}📝 Generating test_fake_data.sql file...${NC}"

# Generate the SQL file
cat > supabase/generated/test_fake_data.sql << 'EOF'
-- Comprehensive fake test data for development and testing
-- This file is auto-generated from data/test_data_source.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate

-- ===========================================
-- AUTH USERS (for local testing only)
-- ===========================================

EOF

# Add auth users
echo "$TEST_DATA" | jq -r '.users[] | 
"INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    \u0027" + "00000000-0000-0000-0000-000000000000" + "\u0027,
    \u0027" + .id + "\u0027::uuid,
    \u0027authenticated\u0027,
    \u0027authenticated\u0027,
    \u0027" + .email + "\u0027,
    \u0027$2a$10$7Z1234567890abcdefghijklmnopqrstuvwxyz\u0027,
    NOW(),
    NOW(),
    NOW(),
    \u0027\u0027,
    \u0027\u0027,
    \u0027\u0027,
    \u0027\u0027
);"' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "-- PROFILES" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "" >> supabase/generated/test_fake_data.sql

# Add profiles
echo "INSERT INTO profiles (id, user_id, name, pronouns, job_title, employer_name, line_manager_name, line_manager_email) VALUES" >> supabase/generated/test_fake_data.sql

echo "$TEST_DATA" | jq -r '.users | length as $len | to_entries | map(
  "  (\u0027" + .value.id + "\u0027::uuid, \u0027" + .value.id + "\u0027::uuid, \u0027" + .value.name + "\u0027, ARRAY[" + (.value.pronouns | map("\u0027" + . + "\u0027") | join(", ")) + "], \u0027" + .value.job_title + "\u0027, \u0027" + .value.employer_name + "\u0027, \u0027" + .value.line_manager_name + "\u0027, \u0027" + .value.line_manager_email + "\u0027)" + (if (.key == ($len - 1)) then ";" else "," end)
) | join("\n")' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "-- RESPONSES" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "" >> supabase/generated/test_fake_data.sql

# Add responses with dynamic question lookup
echo "$TEST_DATA" | jq -r '.responses[] | 
"INSERT INTO responses (id, user_id, question_id, response_text, status, visibility, version, is_latest) 
SELECT 
  \u0027" + .id + "\u0027::uuid,
  \u0027" + .user_id + "\u0027::uuid,
  q.id,
  \u0027" + (.response_text | gsub("\u0027"; "\u0027\u0027")) + "\u0027,
  \u0027" + .status + "\u0027,
  \u0027" + .visibility + "\u0027,
  " + (.version | tostring) + ",
  " + (.is_latest | tostring) + "
FROM questions q WHERE q.category = \u0027" + .question_category + "\u0027 AND q.\"order\" = " + (.question_order | tostring) + ";"' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "-- ACTIONS" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "" >> supabase/generated/test_fake_data.sql

# Add actions
echo "$TEST_DATA" | jq -r '.actions[] | 
"INSERT INTO actions (id, user_id, response_id, type, description, status, version, is_latest) VALUES
  (\u0027" + .id + "\u0027::uuid, \u0027" + .user_id + "\u0027::uuid, \u0027" + .response_id + "\u0027::uuid, \u0027" + .type + "\u0027, \u0027" + (.description | gsub("\u0027"; "\u0027\u0027")) + "\u0027, \u0027" + .status + "\u0027, " + (.version | tostring) + ", " + (.is_latest | tostring) + ");"' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "-- SHARING EVENTS" >> supabase/generated/test_fake_data.sql
echo "-- ===========================================" >> supabase/generated/test_fake_data.sql
echo "" >> supabase/generated/test_fake_data.sql

# Add sharing events
echo "$TEST_DATA" | jq -r '.sharing_events[] | 
"INSERT INTO sharing_events (id, user_id, recipient_email, message, shared_at) VALUES
  (\u0027" + .id + "\u0027::uuid, \u0027" + .user_id + "\u0027::uuid, \u0027" + .recipient_email + "\u0027, \u0027" + (.message | gsub("\u0027"; "\u0027\u0027")) + "\u0027, NOW());"' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- Link responses to sharing events" >> supabase/generated/test_fake_data.sql

# Add sharing event responses
echo "$TEST_DATA" | jq -r '.sharing_events[] | 
.response_ids[] as $response_id |
"INSERT INTO sharing_event_responses (sharing_event_id, response_id) VALUES (\u0027" + .id + "\u0027::uuid, \u0027" + $response_id + "\u0027::uuid);"' >> supabase/generated/test_fake_data.sql

echo "" >> supabase/generated/test_fake_data.sql
echo "-- Link actions to sharing events" >> supabase/generated/test_fake_data.sql

# Add sharing event actions  
echo "$TEST_DATA" | jq -r '.sharing_events[] | 
.action_ids[] as $action_id |
"INSERT INTO sharing_event_actions (sharing_event_id, action_id) VALUES (\u0027" + .id + "\u0027::uuid, \u0027" + $action_id + "\u0027::uuid);"' >> supabase/generated/test_fake_data.sql

echo -e "${GREEN}✅ Generated supabase/generated/test_fake_data.sql${NC}"

echo -e "${YELLOW}📝 Generating delete SQL file...${NC}"

# Generate delete SQL file
cat > supabase/generated/delete_test_fake_data.sql << 'EOF'
-- Delete all fake test data from tables (keeping questions intact)
-- This file is auto-generated from data/test_data_source.json
-- DO NOT EDIT MANUALLY - run scripts/generate-test-data.sh to regenerate

-- Delete in reverse dependency order to avoid foreign key constraint violations
-- Only deletes data related to specific test users to avoid affecting real data

-- 1. Delete sharing event links for test users
DELETE FROM sharing_event_actions 
WHERE action_id IN (
    SELECT a.id FROM actions a 
    WHERE a.user_id IN (
EOF

# Add user IDs for sharing event actions
echo "$TEST_DATA" | jq -r '.users | map("        \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
    )
);

DELETE FROM sharing_event_responses 
WHERE response_id IN (
    SELECT r.id FROM responses r 
    WHERE r.user_id IN (
EOF

# Add user IDs for sharing event responses  
echo "$TEST_DATA" | jq -r '.users | map("        \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
    )
);

-- 2. Delete sharing events for test users
DELETE FROM sharing_events 
WHERE user_id IN (
EOF

# Add user IDs for sharing events
echo "$TEST_DATA" | jq -r '.users | map("    \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
);

-- 3. Delete actions for test users
DELETE FROM actions 
WHERE user_id IN (
EOF

# Add user IDs for actions
echo "$TEST_DATA" | jq -r '.users | map("    \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
);

-- 4. Delete responses for test users
DELETE FROM responses 
WHERE user_id IN (
EOF

# Add user IDs for responses
echo "$TEST_DATA" | jq -r '.users | map("    \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
);

-- 5. Delete profiles for test users
DELETE FROM profiles 
WHERE user_id IN (
EOF

# Add user IDs for profiles
echo "$TEST_DATA" | jq -r '.users | map("    \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
);

-- 6. Delete specific test users
DELETE FROM auth.users 
WHERE id IN (
EOF

# Add user IDs for auth users
echo "$TEST_DATA" | jq -r '.users | map("    \u0027" + .id + "\u0027::uuid") | join(",\n")' >> supabase/generated/delete_test_fake_data.sql

cat >> supabase/generated/delete_test_fake_data.sql << 'EOF'
);

-- Reset sequences to ensure clean state
SELECT setval('response_version_seq', 1, false);
SELECT setval('action_version_seq', 1, false);

-- Verification queries (uncomment to see results)
/*
SELECT 'auth.users' as table_name, COUNT(*) as remaining_rows FROM auth.users
UNION ALL
SELECT 'profiles', COUNT(*) FROM profiles  
UNION ALL
SELECT 'responses', COUNT(*) FROM responses
UNION ALL 
SELECT 'actions', COUNT(*) FROM actions
UNION ALL
SELECT 'sharing_events', COUNT(*) FROM sharing_events
UNION ALL
SELECT 'sharing_event_responses', COUNT(*) FROM sharing_event_responses
UNION ALL
SELECT 'sharing_event_actions', COUNT(*) FROM sharing_event_actions
UNION ALL
SELECT 'questions', COUNT(*) FROM questions;
*/
EOF

echo -e "${GREEN}✅ Generated supabase/generated/delete_test_fake_data.sql${NC}"

echo -e "${YELLOW}📊 Summary:${NC}"
QUESTION_COUNT=$(echo "$QUESTIONS_DATA" | jq '.questions | length')
USER_COUNT=$(echo "$TEST_DATA" | jq '.users | length')
RESPONSE_COUNT=$(echo "$TEST_DATA" | jq '.responses | length') 
ACTION_COUNT=$(echo "$TEST_DATA" | jq '.actions | length')
SHARING_COUNT=$(echo "$TEST_DATA" | jq '.sharing_events | length')

echo "   - Questions: $QUESTION_COUNT"
echo "   - Users: $USER_COUNT"
echo "   - Responses: $RESPONSE_COUNT"
echo "   - Actions: $ACTION_COUNT"
echo "   - Sharing Events: $SHARING_COUNT"

echo -e "${GREEN}🎉 Test data files generated successfully!${NC}"
echo -e "${YELLOW}📝 Files created:${NC}"
echo "   - supabase/seed.sql (auto-runs on db reset)"
echo "   - supabase/generated/test_fake_data.sql"
echo "   - supabase/generated/delete_test_fake_data.sql"