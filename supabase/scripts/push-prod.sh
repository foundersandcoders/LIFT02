#!/bin/bash
set -e
source ./supabase/prod.env
echo "⚠️ Dry run for production:"
supabase db push --db-url "$SUPABASE_DB_URL" --dry-run
echo "✅ If it looks good, remove --dry-run and push to prod."
