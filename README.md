# LIFT Digital Workplace Passport

A digital workplace passport application that helps neurodivergent employees document and share their workplace needs with line managers, promoting a more inclusive workplace environment.

## Technology Stack

- **Frontend**: Svelte 5 + SvelteKit
- **Styling**: TailwindCSS
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Magic Link
- **Testing**: Vitest + @testing-library/svelte

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

   Fill in the `.env.local` file with your Supabase project details.

4. Install Supabase CLI:
   ```bash
   # Using npm
   npm install -g supabase

   # Using Homebrew (macOS)
   brew install supabase/tap/supabase
   ```

   For other installation options, see the [Supabase CLI docs](https://supabase.com/docs/guides/cli/getting-started).

5. Login to Supabase:
   ```bash
   supabase login
   ```

6. Link your local project to Supabase:
   ```bash
   supabase link --project-ref <your-project-reference>
   ```

   You can find your project reference in the Supabase dashboard URL: `https://supabase.com/dashboard/project/<project-reference>`.

## Database Management

### Pushing Schema Changes

To push database schema changes to your Supabase project:

```bash
supabase db push
```

### Generating Types

Generate TypeScript types from your database schema:

```bash
supabase gen types typescript --local > src/lib/types/supabase.ts
```

### Seeding the Database

```bash
# Run the seed script
supabase db reset
```

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

For more detailed information, see:

- [FUNCTIONAL.md](./HITL_Docs/FUNCTIONAL.md) - Functional requirements
- [ARCHITECTURE.md](./HITL_Docs/ARCHITECTURE.md) - Technical architecture
- [TESTING.md](./HITL_Docs/TESTING.md) - Testing guide