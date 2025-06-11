#!/bin/bash

# Generic script to execute SQL files in production
# This avoids creating migration files and keeps history clean
# Usage: ./scripts/execute-sql-production.sh path/to/file.sql

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if SQL file is provided
if [ -z "$1" ]; then
    echo -e "${RED}❌ Error: Please provide a SQL file path${NC}"
    echo "Usage: $0 <sql-file-path>"
    exit 1
fi

SQL_FILE="$1"

if [ ! -f "$SQL_FILE" ]; then
    echo -e "${RED}❌ Error: SQL file '$SQL_FILE' not found${NC}"
    exit 1
fi

echo -e "${GREEN}🚀 Executing SQL file: $SQL_FILE${NC}"

# Check if .env.production exists
if [ ! -f ".env.production" ]; then
    echo -e "${RED}❌ Error: .env.production file not found${NC}"
    exit 1
fi

# Source environment variables
echo -e "${YELLOW}📋 Loading environment variables...${NC}"
export $(grep -v '^#' .env.production | xargs)

# Validate required environment variables
if [ -z "$SUPABASE_DB_PASSWORD" ] || [ -z "$SUPABASE_PROJECT_ID" ]; then
    echo -e "${RED}❌ Error: Missing required environment variables${NC}"
    exit 1
fi

echo -e "${YELLOW}📡 Project ID: $SUPABASE_PROJECT_ID${NC}"

# Execute SQL using connection string (URL-encoded password)
ENCODED_PASSWORD=$(echo "$SUPABASE_DB_PASSWORD" | sed 's/\$/%24/g' | sed 's/\+/%2B/g')
DB_URL="postgresql://postgres:$ENCODED_PASSWORD@db.$SUPABASE_PROJECT_ID.supabase.co:5432/postgres"

echo -e "${YELLOW}📤 Executing SQL...${NC}"

# Try direct psql connection
if command -v psql >/dev/null 2>&1; then
    echo -e "${YELLOW}Attempting direct psql connection...${NC}"
    if psql "$DB_URL" -f "$SQL_FILE"; then
        echo -e "${GREEN}✅ SQL executed successfully via psql!${NC}"
        exit 0
    else
        echo -e "${YELLOW}Direct psql failed, trying line-by-line execution...${NC}"
    fi
else
    echo -e "${YELLOW}psql not available, trying line-by-line execution...${NC}"
fi

# Fallback: Execute SQL line by line
echo -e "${YELLOW}Executing SQL commands individually...${NC}"
success_count=0
error_count=0

while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*-- ]]; then
        continue
    fi
    
    # Execute non-empty, non-comment lines
    echo "Executing: ${line:0:50}..."
    if echo "$line" | psql "$DB_URL" >/dev/null 2>&1; then
        ((success_count++))
    else
        echo -e "${YELLOW}⚠️  Warning: Failed to execute line: $line${NC}"
        ((error_count++))
    fi
done < "$SQL_FILE"

if [ $success_count -gt 0 ]; then
    echo -e "${GREEN}✅ SQL execution completed: $success_count successful, $error_count failed${NC}"
    exit 0
else
    echo -e "${RED}❌ Failed to execute any SQL commands${NC}"
    exit 1
fi