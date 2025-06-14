#!/bin/bash

# API-based script to seed questions to production
# Reads from questions.json for single source of truth

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding questions to production...${NC}"

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

# Check if questions source exists
if [ ! -f "supabase/data/questions.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/questions.json not found${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Reading questions from JSON source...${NC}"
QUESTIONS_DATA=$(cat supabase/data/questions.json)

echo -e "${YELLOW}📤 Creating workplace passport questions from JSON source...${NC}"

# Create all questions from questions.json
QUESTIONS_JSON=$(echo "$QUESTIONS_DATA" | jq '.questions')
QUESTIONS_RESPONSE=$(curl -s -X POST "$API_URL/questions" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$CONTENT_HEADER" \
    -H "$PREFER_HEADER" \
    -d "$QUESTIONS_JSON")

# Check if questions were created successfully
if echo "$QUESTIONS_RESPONSE" | grep -q "error\|Error\|violates"; then
    echo -e "${RED}❌ Questions creation failed: $QUESTIONS_RESPONSE${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Questions created successfully${NC}"
fi

# Verify questions count
QUESTION_COUNT=$(curl -s -X GET "$API_URL/questions?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

TOTAL_QUESTIONS=$(echo "$QUESTIONS_DATA" | jq '.questions | length')
echo -e "${GREEN}📊 Total questions in database: ${QUESTION_COUNT:-0}${NC}"
echo -e "${GREEN}📊 Questions from source: $TOTAL_QUESTIONS${NC}"

echo -e "${GREEN}🎉 All workplace passport questions seeded successfully from JSON source!${NC}"