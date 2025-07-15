# LIFT Digital Workplace Passport

A digital workplace passport application that helps neurodivergent employees document and share their workplace needs with line managers, promoting a more inclusive workplace environment.

---

> [!CAUTION]
> **Documentation Accuracy**<br/>
> <br/>
> This documentation is not up to date with the latest feature set & build. Many dev tools have been packaged in scripts. Start with `./package.json`.

---

> [!TIP]
> **Auto-Generated Documentation**<br/>
> <br/>
> Available on [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/foundersandcoders/LIFT02)

---

- [1. Technology Stack](#1-technology-stack)
- [2. Prerequisites](#2-prerequisites)
  - [2.1. Node.js (v18+)](#21-nodejs-v18)
  - [2.2. Docker Desktop](#22-docker-desktop)
  - [2.3. git](#23-git)
  - [2.4. PostgreSQL Client](#24-postgresql-client)
- [3. Development Setup](#3-development-setup)
  - [3.1. Clone the repository](#31-clone-the-repository)
  - [3.2. Install dependencies](#32-install-dependencies)
  - [3.3. Set up environment variables](#33-set-up-environment-variables)
  - [3.4. Install Supabase CLI](#34-install-supabase-cli)
  - [3.5. Start local Supabase instance](#35-start-local-supabase-instance)
  - [3.6. Verify Setup](#36-verify-setup)
- [4. Database Management](#4-database-management)
  - [4.1. Local Development](#41-local-development)
  - [4.2. Database Seeding](#42-database-seeding)
  - [4.3. Production Deployment](#43-production-deployment)
  - [4.4. Generating Types](#44-generating-types)
  - [4.5. Accessing Local Services](#45-accessing-local-services)
- [5. Troubleshooting](#5-troubleshooting)
  - [5.1. Common Issues](#51-common-issues)
  - [5.3. Getting Help](#53-getting-help)
- [6. Development Scripts](#6-development-scripts)
  - [6.1. Development Workflow](#61-development-workflow)
  - [6.2. Testing](#62-testing)
  - [6.3. Linting \& Formatting](#63-linting--formatting)
  - [6.4. Building for Production](#64-building-for-production)
  - [6.5. Preview the production build](#65-preview-the-production-build)
- [7. Project Structure](#7-project-structure)
- [8. Documentation](#8-documentation)

---

## 1. Technology Stack

| Area                    | Technology                |
| ----------------------- | ------------------------- |
|   Frontend Framework    | Svelte 5                  |
|   Fullstack Framework   | SvelteKit                 |
|   Utility Classes       | TailwindCSS               |
|   Component Classes     | DaisyUI                   |
|   DB Query Language     | PostgreSQL                |
|   Database Hosting      | Supabase                  |
|   Auth Provider         | Supabase (Magic Link)     |
|   Testing               | Vitest                    |
|                         | `@testing-library/svelte` |

---

## 2. Prerequisites

Before starting development, ensure you have the following installed:

### 2.1. Node.js (v18+)

```bash
# Check your version
node --version
```

Download from [nodejs.org](https://nodejs.org/) if needed.

### 2.2. Docker Desktop

- **macOS**: [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)
- **Windows**: [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
- **Linux**: [Docker Engine installation](https://docs.docker.com/engine/install/)

```bash
# Verify Docker is running
docker --version
docker ps
```

### 2.3. git

```bash
# Check if installed
git --version
```

### 2.4. PostgreSQL Client

Required for Linux, particularly Ubuntu. This is needed for the seed scripts to work correctly with Supabase.

```bash
# Check if installed
psql --version

# If not installed (Ubuntu/Debian)
sudo apt-get update && sudo apt-get install postgresql-client

# If not installed (Fedora/RHEL)
sudo dnf install postgresql
```

---

## 3. Development Setup

### 3.1. Clone the repository

```bash
git clone https://github.com/foundersandcoders/LIFT02.git
cd LIFT02
```

### 3.2. Install dependencies

```bash
npm install
```

### 3.3. Set up environment variables

```bash
cp .env.example .env.local
```

**Note**: The `.env.example` already contains the correct local development keys that Supabase always uses.

### 3.4. Install Supabase CLI

```bash
# Using npm
npm install supabase --save-dev

# Using Homebrew (macOS)
brew install supabase/tap/supabase
```

For other installation options, see the [Supabase CLI docs](https://supabase.com/docs/guides/cli/getting-started).

### 3.5. Start local Supabase instance

```bash
supabase start
```

<h4>First time setup notes</h4>

- If Supabase Docker containers are not already downloaded, this command will automatically download them (~2-3GB total)
- The download may take 5-15 minutes depending on your internet connection
- Docker Desktop must be running before executing this command
- All database migrations will be automatically applied

### 3.6. Verify Setup

```bash
# Start the development server
npm run dev

# In another terminal, check Supabase Studio
open http://127.0.0.1:54323
```

---

## 4. Database Management

### 4.1. Local Development

Your local Supabase instance runs entirely in Docker containers. The database schema is automatically applied from the migrations when you start the instance.

```bash
# Start the local Supabase stack
supabase start

# Check status and get connection details
supabase status

# Reset local database (clears data and re-applies migrations + questions seed)
supabase db reset

# Stop the local instance
supabase stop
```

### 4.2. Database Seeding

The project uses a two-tier seeding strategy to separate real data from test data:

#### 4.2.1. Questions Seed (Production Data)

- **File**: `supabase/seed.sql`
- **Content**: Real workplace passport questions
- **Auto-runs**: Automatically applied when you run `supabase db reset`
- **Purpose**: Contains the actual questions users will answer

#### 4.2.2. Test Data Seed (Development/Testing)

- **File**: `supabase/test_data_seed.sql`
- **Content**: Fake users, responses, actions, and sharing events
- **Manual**: Run separately when you need test data
- **Purpose**: Provides realistic test data for development and testing

#### 4.2.3. Adding Test Data to Local Database

After resetting your database, add test data for development:

```bash
# Reset database (includes questions)
supabase db reset

# Add test data (5 fake users with comprehensive responses)
# Make script executable first (if needed)
chmod +x ./scripts/local-seed-test-data.sh
./scripts/local-seed-test-data.sh
```

**What the test data includes:**

- 5 fake users with diverse profiles
- Multiple responses across all question categories
- Some questions answered multiple times (different versions)
- Mix of answered and skipped questions
- Workplace adjustments and actions linked to responses
- Sample sharing events with line managers

#### 4.4.4. Environment-Smart Seeding Script

The `prod-seed-test-data.sh` script automatically detects your environment:

**Local Development:**

- Detects local Supabase instance
- Uses default `postgres` password (no prompts)
- Connects to `127.0.0.1:54322`

**Production/Vercel:**

- Uses environment variables from Vercel dashboard
- Requires `DATABASE_URL` to be set
- Connects to production Supabase instance

### 4.3. Production Deployment

When ready to deploy schema changes to production:

#### 4.3.1. First Time: Linking Your Local Project to Production

If this is your first time pushing to production, you need to link your local project:

1. **Login to Supabase CLI:**

   ```bash
   supabase login
   ```

   This will open a browser window for authentication.

2. **Link your local project to the remote Supabase project:**

   ```bash
   supabase link --project-ref YOUR_PROJECT_REF --password "YOUR_DB_PASSWORD"
   ```

   **Important**: When prompted to "Enter your database password (or leave blank to skip):", press **Enter** to skip. This avoids IPv6 connection issues while still linking the project successfully.

3. **Push schema changes:**

```bash
supabase db push
```

#### 4.3.2. Subsequent Deployments

Once linked, you can push schema changes using one of these methods:

##### 4.3.2.1. Option 1: Direct command with password

```bash
# Push local schema changes to production Supabase project
npx supabase db push --password 'YOUR_DB_PASSWORD'
```

##### 4.3.2.2. Option 2: Use the deployment script (recommended)

```bash
# Make script executable first (if needed)
chmod +x ./scripts/prod-run-migrations.sh
# Uses environment variables from .env.production
./scripts/prod-run-migrations.sh
```

##### 4.3.2.3. Option 3: Traditional interactive prompt

```bash
# Push local schema changes to production Supabase project
npx supabase db push
```

#### 4.3.3. Seeding Test Data in Production

If you need test data in your production environment (e.g., for demos or testing):

1. **Set environment variables in Vercel dashboard:**

   - Go to your Vercel project → Settings → Environment Variables
   - Add `DATABASE_URL` with your production Supabase connection string
   - Format: `postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres`

2. **Run the seeding script:**

   ```bash
   # Make script executable first (if needed)
   chmod +x ./scripts/prod-seed-test-data.sh

   # Option 1: Run locally with production env vars
   vercel env pull .env.production
   source .env.production
   ./scripts/prod-seed-test-data.sh

   # Option 2: Run with environment variables directly
   DATABASE_URL="your-production-url" ./scripts/prod-seed-test-data.sh
   ```

⚠️ **Warning**: Only add test data to production if you need it for demos or testing. Real user data should come through the application interface.

### 4.4. Generating Types

Generate TypeScript types from your local database schema:

```bash
supabase gen types typescript --local > src/lib/types/supabase.ts
```

### 4.5. Accessing Local Services

When running locally, you can access:

- **API**: `http://127.0.0.1:54321`
- **Database**: `postgresql://postgres:postgres@127.0.0.1:54322/postgres`
- **Studio**: `http://127.0.0.1:54323`
- **Email Testing (Inbucket)**: `http://127.0.0.1:54324`

---

## 5. Troubleshooting

### 5.1. Common Issues

1. **"Docker not found" error**

   - Ensure Docker Desktop is installed and running
   - Try restarting Docker Desktop
   - On Windows: Make sure you're using PowerShell or Command Prompt as Administrator

2. **Port conflicts (ports 54321-54327 already in use)**

   ```bash
   # Stop any existing Supabase instances
   supabase stop

   # If that doesn't work, find and kill processes using the ports
   lsof -ti:54321 | xargs kill -9
   ```

3. **Migration errors or missing tables**

   ```bash
   # Reset and reapply all migrations
   supabase db reset
   ```

4. **VS Code Supabase extension can't connect**

   - Use URL: `http://127.0.0.1:54321` (not https)
   - Get anon key from `supabase status`
   - Try reloading VS Code window

5. **Slow Docker image downloads**

   - Initial setup downloads ~2-3GB of Docker images
   - Consider running setup during good internet connectivity
   - Images are cached after first download

6. **First time setup prompts**

   - When running `supabase start` for the first time, you may be prompted to run `supabase init` first
   - Run `supabase init` as instructed
   - When prompted if you want to set up Edge Functions with Deno, answer "No"
   - After initialization is complete, run `supabase start` again

7. **Docker Architecture Mismatch**

   - If you see errors like `exec /usr/bin/sh: exec format error`, it means you're trying to run Docker containers built for a different CPU architecture

   **For Apple Silicon (M1/M2) users**:

   ```bash
   # Force pull ARM64 images
   docker pull --platform=linux/arm64 supabase/postgres:15.1.0
   docker pull --platform=linux/arm64 supabase/edge-runtime:v1
   # (add other images as needed)
   ```

   **For Intel/AMD users**:

   ```bash
   # Force pull AMD64 images
   docker pull --platform=linux/amd64 supabase/postgres:15.1.0
   docker pull --platform=linux/amd64 supabase/edge-runtime:v1
   # (add other images as needed)
   ```

   You may need to specify the platform in your Docker configuration:

   ```bash
   # Example adding platform to supabase start
   DOCKER_DEFAULT_PLATFORM=linux/amd64 supabase start  # For Intel/AMD
   # or
   DOCKER_DEFAULT_PLATFORM=linux/arm64 supabase start  # For Apple Silicon
   ```

   If you continue having issues, try:

   1. Remove existing containers: `supabase stop && docker system prune -a`
   2. Set the default platform before starting: `export DOCKER_DEFAULT_PLATFORM=linux/[your-arch]`
   3. Restart Supabase: `supabase start`

### 5.3. Getting Help

If you encounter issues not covered here:

1. Check `supabase status` for service health
2. Check `docker ps` to see running containers
3. Check the [Supabase CLI docs](https://supabase.com/docs/guides/cli)

---

## 6. Development Scripts

### 6.1. Development Workflow

Start the development server:

```bash
npm run dev

# or open in a new browser tab
npm run dev -- --open
```

### 6.2. Testing

Run tests with Vitest:

```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:unit

# Run with coverage
npm run test -- --coverage
```

### 6.3. Linting & Formatting

```bash
# Format code
npm run format

# Lint code
npm run lint

# Type checking
npm run check
```

### 6.4. Building for Production

```bash
npm run build
```

### 6.5. Preview the production build

```bash
npm run preview
```

---

## 7. Project Structure

The project follows a standard SvelteKit structure:

```src
.
├── docs
├── scripts
├── src
│   ├── lib
│   │   ├── components
│   │   │   ├── cards
│   │   │   ├── layouts
│   │   │   ├── logic
│   │   │   ├── ui
│   │   │   └── views
│   │   ├── services
│   │   │   └── database
│   │   ├── types
│   │   └── utils
│   └── routes
├── static
│   └── logo
└── supabase
    ├── data
    ├── generated
    └── migrations
```

---

## 8. Documentation

> [!WARNING] WIP
