#!/bin/bash
set -e
export SUPABASE_DNS_RESOLVER=native
source ./supabase/dev.env
supabase db push --db-url "$SUPABASE_DB_URL" --debug


echo "Database schema pushed to Supabase successfully."