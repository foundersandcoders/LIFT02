#!/bin/bash

# API-based script to seed resources to production
# Reads from resources.json for single source of truth
# Deletes all existing resources first to avoid duplicates

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🌱 Seeding resources to production...${NC}"

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

# Check if resources source exists
if [ ! -f "supabase/data/resources.json" ]; then
    echo -e "${RED}❌ Error: supabase/data/resources.json not found${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Reading resources from JSON source...${NC}"
RESOURCES_DATA=$(cat supabase/data/resources.json)

# First, delete all existing resources to avoid duplicates
echo -e "${YELLOW}🗑️  Deleting existing resources to avoid duplicates...${NC}"
DELETE_RESPONSE=$(curl -s -X DELETE "$API_URL/resources" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$PREFER_HEADER")

# Check if deletion was successful (empty response or no error)
if echo "$DELETE_RESPONSE" | grep -q "error\|Error"; then
    echo -e "${YELLOW}⚠️  Delete response: $DELETE_RESPONSE${NC}"
    echo -e "${YELLOW}⚠️  Continuing with resource creation...${NC}"
else
    echo -e "${GREEN}✅ Existing resources deleted successfully${NC}"
fi

echo -e "${YELLOW}📤 Creating workplace resources from JSON source...${NC}"

# Create all resources from resources.json
RESOURCES_JSON=$(echo "$RESOURCES_DATA" | jq '.resources')
RESOURCES_RESPONSE=$(curl -s -X POST "$API_URL/resources" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" \
    -H "$CONTENT_HEADER" \
    -H "$PREFER_HEADER" \
    -d "$RESOURCES_JSON")

# Check if resources were created successfully
if echo "$RESOURCES_RESPONSE" | grep -q "error\|Error\|violates"; then
    echo -e "${RED}❌ Resources creation failed: $RESOURCES_RESPONSE${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Resources created successfully${NC}"
fi

# Verify resources count
RESOURCE_COUNT=$(curl -s -X GET "$API_URL/resources?select=count" \
    -H "$AUTH_HEADER" \
    -H "$APIKEY_HEADER" | grep -o '"count":[0-9]*' | cut -d':' -f2)

TOTAL_RESOURCES=$(echo "$RESOURCES_DATA" | jq '.resources | length')
echo -e "${GREEN}📊 Total resources in database: ${RESOURCE_COUNT:-0}${NC}"
echo -e "${GREEN}📊 Resources from source: $TOTAL_RESOURCES${NC}"

echo -e "${GREEN}🎉 All workplace resources seeded successfully from JSON source!${NC}"