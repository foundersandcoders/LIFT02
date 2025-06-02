#!/bin/bash

# Script to seed test data into Supabase database
# Works for both local development and production environments
# Run this after 'supabase db reset' (local) or when you need test data

set -e  # Exit on any error

echo "🌱 Seeding test data..."

# Check if we're in local development or production
if [ -f ".env.local" ] && [ -d "supabase" ]; then
    # Local development environment
    echo "📍 Detected local development environment"
    
    # Check if Supabase is running locally
    if ! supabase status &> /dev/null; then
        echo "❌ Local Supabase is not running. Start it with 'supabase start'"
        exit 1
    fi
    
    # For local, use default postgres password and set it via environment
    export PGPASSWORD="postgres"
    DB_HOST="127.0.0.1"
    DB_PORT="54322"
    DB_USER="postgres"
    DB_NAME="postgres"
    
else
    # Production or remote environment
    echo "📍 Detected production/remote environment"
    
    # Load environment variables for production
    if [ -f ".env" ]; then
        source .env
    fi
    
    # Check required environment variables for production
    if [ -z "$DATABASE_URL" ] && [ -z "$DB_HOST" ]; then
        echo "❌ Missing database connection info. Set DATABASE_URL or DB_HOST, DB_PORT, etc."
        exit 1
    fi
    
    # Use DATABASE_URL if available, otherwise construct from individual vars
    if [ -n "$DATABASE_URL" ]; then
        echo "🔗 Using DATABASE_URL for connection"
        psql "$DATABASE_URL" -f supabase/test_data_seed.sql
        echo "✅ Test data seeded successfully!"
        exit 0
    else
        # Use individual connection parameters
        DB_HOST="${DB_HOST:-localhost}"
        DB_PORT="${DB_PORT:-5432}"
        DB_USER="${DB_USER:-postgres}"
        DB_NAME="${DB_NAME:-postgres}"
        
        # Set password from environment if available
        if [ -n "$DB_PASSWORD" ]; then
            export PGPASSWORD="$DB_PASSWORD"
        fi
    fi
fi

# Run the test data seed
echo "🔌 Connecting to database at $DB_HOST:$DB_PORT"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f supabase/test_data_seed.sql

if [ $? -eq 0 ]; then
    echo "✅ Test data seeded successfully!"
    echo "   - 3 fake users with profiles"
    echo "   - Sample responses across different categories"
    echo "   - Workplace adjustments and actions"
    echo "   - Sharing events with line managers"
else
    echo "❌ Failed to seed test data"
    exit 1
fi