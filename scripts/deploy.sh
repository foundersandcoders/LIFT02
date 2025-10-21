#!/bin/bash

# Deploy script with automatic version increment
# Usage: ./scripts/deploy.sh

set -e  # Exit on any error

echo "🚀 Starting deployment process..."

# Read current version from package.json
CURRENT_VERSION=$(node -p "require('./package.json').version")

echo "📦 Current version: $CURRENT_VERSION"

# Parse version parts (assuming format: x.y.zzz)
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

# Increment patch version (force base 10 to avoid octal interpretation)
NEW_PATCH=$((10#$PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$(printf "%03d" $NEW_PATCH)"

echo "⬆️  Incrementing version to: $NEW_VERSION"

# Update version in package.json and version.ts
sed -i.bak "s/\"version\": \".*\"/\"version\": \"$NEW_VERSION\"/" "package.json"
rm "package.json.bak" 2>/dev/null || true

sed -i.bak "s/export const version = '.*'/export const version = '$NEW_VERSION'/" "src/lib/version.ts"
rm "src/lib/version.ts.bak" 2>/dev/null || true

echo "✅ Version updated in package.json and version.ts"

# Commit the version change
echo "📝 Committing version change..."
git add "package.json" "src/lib/version.ts"
git commit -m "chore: bump version to $NEW_VERSION" || echo "⚠️  No changes to commit"

echo "🏗️  Building and deploying to PREVIEW (not production)..."

# Deploy to Vercel PREVIEW (not production)
# IMPORTANT: We deploy to preview only. Production is manually controlled.
npx vercel

echo "🎉 Deployment completed! New version: $NEW_VERSION"
echo "⚠️  This was deployed as a PREVIEW deployment (not production)"
echo "🔗 Check the deployment URL from the vercel output above"
echo "📌 To deploy to production, use: npx vercel --prod (manual only!)"