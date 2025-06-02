# LIFT Digital Workplace Passport

> A digital workplace passport application that helps neurodivergent employees document and share their workplace needs with line managers, promoting a more inclusive workplace environment.

## Technology Stack

- **Frontend**: Svelte 5 + SvelteKit
- **Styling**: TailwindCSS
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Magic Link
- **Testing**: Vitest + @testing-library/svelte

## Prerequisites

Before starting development, ensure you have the following installed:

### Required Software

1. **Node.js** (v18 or higher)
   ```bash
   # Check your version
   node --version
   ```
   Download from [nodejs.org](https://nodejs.org/) if needed.

2. **Docker Desktop**
   - **macOS**: Download from [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)
   - **Windows**: Download from [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
   - **Linux**: Follow [Docker Engine installation](https://docs.docker.com/engine/install/) for your distribution

   ```bash
   # Verify Docker is running
   docker --version
   docker ps
   ```

3. **Git**
   ```bash
   # Check if installed
   git --version
   ```

## Development Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/foundersandcoders/LIFT02.git
   cd LIFT02
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Set up environment variables:

   ```bash
   cp .env.example .env.local
   ```

   **Note**: The `.env.example` already contains the correct local development keys that Supabase always uses.

4. Install Supabase CLI:

   ```bash
   # Using npm
   npm install -g supabase

   # Using Homebrew (macOS)
   brew install supabase/tap/supabase
   ```

   For other installation options, see the [Supabase CLI docs](https://supabase.com/docs/guides/cli/getting-started).

5. Start local Supabase instance:
   ```bash
   supabase start
   ```

   **First time setup notes**:
   - This will download several Docker images (~2-3GB total)
   - The download may take 5-15 minutes depending on your internet connection
   - Docker Desktop must be running before executing this command
   - All database migrations will be automatically applied

6. Verify setup:
   ```bash
   # Start the development server
   npm run dev
   
   # In another terminal, check Supabase Studio
   open http://127.0.0.1:54323
   ```

## Database Management

### Local Development

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

### Database Seeding

The project uses a two-tier seeding strategy to separate real data from test data:

#### 1. Questions Seed (Production Data)
- **File**: `supabase/seed.sql`
- **Content**: Real workplace passport questions
- **Auto-runs**: Automatically applied when you run `supabase db reset`
- **Purpose**: Contains the actual questions users will answer

#### 2. Test Data Seed (Development/Testing)
- **File**: `supabase/test_data_seed.sql`
- **Content**: Fake users, responses, actions, and sharing events
- **Manual**: Run separately when you need test data
- **Purpose**: Provides realistic test data for development and testing

#### Adding Test Data to Local Database

After resetting your database, add test data for development:

```bash
# Reset database (includes questions)
supabase db reset

# Add test data (5 fake users with comprehensive responses)
./scripts/seed-test-data.sh
```

**What the test data includes:**
- 5 fake users with diverse profiles
- Multiple responses across all question categories
- Some questions answered multiple times (different versions)
- Mix of answered and skipped questions
- Workplace adjustments and actions linked to responses
- Sample sharing events with line managers

#### Environment-Smart Seeding Script

The `seed-test-data.sh` script automatically detects your environment:

**Local Development:**
- Detects local Supabase instance
- Uses default `postgres` password (no prompts)
- Connects to `127.0.0.1:54322`

**Production/Vercel:**
- Uses environment variables from Vercel dashboard
- Requires `DATABASE_URL` to be set
- Connects to production Supabase instance

### Production Deployment

When ready to deploy schema changes to production:

```bash
# Push local schema changes to production Supabase project
supabase db push
```

#### Seeding Test Data in Production

If you need test data in your production environment (e.g., for demos or testing):

1. **Set environment variables in Vercel dashboard:**
   - Go to your Vercel project → Settings → Environment Variables
   - Add `DATABASE_URL` with your production Supabase connection string
   - Format: `postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres`

2. **Run the seeding script:**
   ```bash
   # Option 1: Run locally with production env vars
   vercel env pull .env.production
   source .env.production
   ./scripts/seed-test-data.sh
   
   # Option 2: Run with environment variables directly
   DATABASE_URL="your-production-url" ./scripts/seed-test-data.sh
   ```

⚠️ **Warning**: Only add test data to production if you need it for demos or testing. Real user data should come through the application interface.

### Generating Types

Generate TypeScript types from your local database schema:

```bash
supabase gen types typescript --local > src/lib/types/supabase.ts
```

### Accessing Local Services

When running locally, you can access:

- **API**: http://127.0.0.1:54321
- **Database**: postgresql://postgres:postgres@127.0.0.1:54322/postgres  
- **Studio**: http://127.0.0.1:54323
- **Email Testing (Inbucket)**: http://127.0.0.1:54324

## Troubleshooting

### Common Issues

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

### Getting Help

If you encounter issues not covered here:
1. Check `supabase status` for service health
2. Check `docker ps` to see running containers
3. Check the [Supabase CLI docs](https://supabase.com/docs/guides/cli)

## Development Workflow

Start the development server:

```bash
npm run dev

# or open in a new browser tab
npm run dev -- --open
```

## Testing

Run tests with Vitest:

```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:unit

# Run with coverage
npm run test -- --coverage
```

## Linting and Formatting

```bash
# Format code
npm run format

# Lint code
npm run lint

# Type checking
npm run check
```

## Building for Production

```bash
npm run build
```

Preview the production build:

```bash
npm run preview
```

## Project Structure

The project follows a standard SvelteKit structure:

- `/src` - Application source code
  - `/routes` - SvelteKit routes (pages)
  - `/lib` - Shared components, utilities, and services
- `/static` - Static assets

## Documentation

- [FUNCTIONAL.md](./HITL_Docs/FUNCTIONAL.md) - Functional requirements
- [ARCHITECTURE.md](./HITL_Docs/ARCHITECTURE.md) - Technical architecture
- [TESTING.md](./HITL_Docs/TESTING.md) - Testing guide

Explore this codebase on [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/foundersandcoders/LIFT02)
