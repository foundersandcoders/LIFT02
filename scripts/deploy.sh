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

# Increment patch version
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$(printf "%03d" $NEW_PATCH)"

echo "⬆️  Incrementing version to: $NEW_VERSION"

# Update version in package.json (single source of truth)
sed -i.bak "s/\"version\": \".*\"/\"version\": \"$NEW_VERSION\"/" "package.json"
rm "package.json.bak" 2>/dev/null || true

echo "✅ Version updated in package.json"

# Commit the version change
echo "📝 Committing version change..."
git add "package.json"
git commit -m "chore: bump version to $NEW_VERSION" || echo "⚠️  No changes to commit"

echo "🏗️  Building and deploying to production..."

# Deploy to Vercel
npx vercel --prod

echo "🎉 Deployment completed! New version: $NEW_VERSION"
echo "🔗 Check your deployment at: https://your-domain.vercel.app"