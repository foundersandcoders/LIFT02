**IMPORTANT FOR CLAUDE: Reference this file before implementing anything**

# Project: LIFT Digital Workplace Passport

## Project Overview

A digital workplace passport application that helps neurodivergent employees document and share their workplace needs with line managers, promoting a more inclusive workplace environment. See `FUNCTIONAL.md` for detailed requirements.

## Tech Stack

- Languages: TypeScript
- Frameworks: Svelte 5, SvelteKit
- Styling: TailwindCSS
- Data: Supabase (PostgreSQL)
- Authentication: Supabase Magic Link
- Testing: Vitest
- Hosting: Vercel
- Development: Local Supabase instance via Docker
- Database Management: Supabase CLI

## Code Style & Conventions

### Import/Module Standards

- Group imports by type: Svelte, external libraries, internal modules
- Avoid wildcard imports
- Use relative paths for imports within the same feature
- Use absolute imports (@lib) for shared code

### Naming Conventions

- Functions: camelCase, verb-first (e.g., `handleSubmit`, `fetchData`)
- Components: PascalCase (e.g., `ProfileCard.svelte`, `LoginForm.svelte`)
- Stores: camelCase, noun-based (e.g., `userStore`, `responsesStore`)
- Constants: UPPER_SNAKE_CASE for true constants, camelCase for config objects
- Files: PascalCase for components, camelCase for utilities and services
- Database columns: snake_case

### Patterns to Follow

- Flat component structure (all in `/lib/components`)
- Ultra-minimal routing (just login and dashboard)
- All categories in a single dashboard view with navigation
- Use Svelte stores for global state management
- SvelteKit server endpoints directly in page files
- HTTP-only cookies for auth token storage
- Component composition over inheritance
- Prefer native form validation when possible

## Development Workflow

- Branch strategy: feature/fix-description
- Commit message format: `type(scope): description` (e.g., `feat(auth): add magic link login`)
- PR requirements: Reference issue, pass all checks, meet accessibility standards

## Testing Strategy

- Test framework: Vitest for all tests
- Coverage requirements: 80% for critical paths
- Test naming conventions: `describe('Component/Function')`, `it('should do something')`
- Component testing: Vitest with @testing-library/svelte
- API testing: Vitest with mocked Supabase client

See `TESTING.md` for detailed examples and best practices. Basic pattern for component tests:

```typescript
import { describe, test, expect } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen } from '@testing-library/svelte';
import MyComponent from './MyComponent.svelte';

describe('MyComponent', () => {
	test('renders correctly', () => {
		render(MyComponent);
		expect(screen.getByText('Expected text')).toBeInTheDocument();
	});
});
```

## Environment Setup

- Required environment variables (for local development):

  - `PUBLIC_SUPABASE_URL=http://127.0.0.1:54321`
  - `PUBLIC_SUPABASE_ANON_KEY` (from supabase status)
  - `SUPABASE_SERVICE_KEY` (from supabase status, server-only)
  - `EMAIL_SERVICE_KEY` (for sending emails)

- Supabase environments:

  - **Development**: Local Supabase instance via Docker
  - **Production**: Remote Supabase project
  - Local instance provides full Supabase stack including Auth, Database, Storage, and Email testing

- Database seeding strategy:

  - `supabase/seed.sql`: Real questions data (auto-runs with `supabase db reset`)
  - `supabase/test_data_seed.sql`: Fake test data (run separately with script)
  - `scripts/seed-test-data.sh`: Environment-aware script for adding test data

- Setup commands:

  ```bash
  # Install dependencies
  npm install

  # Install Supabase CLI globally
  npm install -g supabase

  # Start local Supabase instance
  supabase start

  # Copy environment template and configure for local development
  cp .env.example .env.local

  # Set local environment variables:
  # PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
  # PUBLIC_SUPABASE_ANON_KEY=[anon key from supabase status]
  # SUPABASE_SERVICE_KEY=[service_role key from supabase status]
  ```

## Common Commands

```bash
# Build command
npm run build

# Test command
npm run test        # Run all Vitest tests
npm run test:unit   # Run tests in watch mode

# Lint command
npm run lint

# Check command
npm run check       # TypeScript type checking

# Development server
npm run dev

# Local Supabase commands
supabase start                  # Start local Supabase instance
supabase stop                   # Stop local Supabase instance
supabase status                 # Check status and get keys
supabase db reset               # Reset and seed local database with questions
supabase db push                # Push schema changes to production
./scripts/deploy-db.sh          # Automated deployment using .env.production
                               # (run chmod +x ./scripts/deploy-db.sh if needed)

# Database seeding commands
# Make scripts executable first (if needed)
chmod +x ./scripts/seed-test-data.sh
chmod +x ./scripts/deploy-db.sh

./scripts/seed-test-data.sh     # Add test data (works local and production)
                               # Local: uses default postgres password
                               # Vercel: requires DATABASE_URL environment variable
```

## Project Structure

Key directories and their purpose:

- `/src` - Main source code
  - `/routes` - SvelteKit pages and layouts
    - `+layout.svelte` - Main app layout
    - `+layout.server.ts` - Auth protection
    - `+page.svelte` - Landing/login page
    - `/dashboard/+page.svelte` - Single dashboard with all categories
    - `/auth/callback` - Magic Link handling
  - `/lib` - Shared code
    - `/components` - All UI components
    - `/stores` - Svelte stores
    - `/services` - External service integrations
    - `utils.ts` - Helper functions
- `/static` - Static assets (images, icons)
- `/tests` - Test files

## Review Process Guidelines

Before submitting any code, ensure the following steps are completed:

1. **Run all lint, check and test commands**

2. **Review outputs and iterate until all issues are resolved**

3. **Assess compliance**:
   For each standard, explicitly state ✅ or ❌ and explain why:

   - Code style and formatting
   - Naming conventions
   - Architecture patterns (refer to `ARCHITECTURE.md`)
   - Error handling
   - Test coverage
   - Documentation
   - Accessibility (WCAG 2.2 AA)

4. **Self-review checklist**:
   - [ ] Code follows defined patterns
   - [ ] No debug/commented code
   - [ ] Error handling implemented
   - [ ] Tests written and passing
   - [ ] Documentation updated
   - [ ] Accessibility checked

## Deployment (Vercel)

### Environment Variables Setup

Set these environment variables in Vercel dashboard (Settings > Environment Variables):

**Required for application:**

- `PUBLIC_SUPABASE_URL` - Your production Supabase project URL
- `PUBLIC_SUPABASE_ANON_KEY` - Your production Supabase anon key
- `SUPABASE_SERVICE_KEY` - Your production Supabase service role key
- `EMAIL_SERVICE_KEY` - For sending emails

**Optional for test data seeding:**

- `DATABASE_URL` - Full PostgreSQL connection string (get from Supabase > Settings > Database)
  - Format: `postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres`

### Seeding Test Data in Production

```bash
# After deploying to Vercel, if you want to add test data:
# 1. Set DATABASE_URL environment variable in Vercel
# 2. Run locally with production env vars, or
# 3. Use Vercel CLI: vercel env pull && ./scripts/seed-test-data.sh
```

## Known Issues & Workarounds

- Supabase has limited support for transactions - use client-side data validation as additional protection
- Magic Link emails may be delayed - implement clear user feedback about checking email
- Refer to `FUNCTIONAL.md` and `ARCHITECTURE.md` for more details on implementation

## References

- [Svelte Documentation](https://svelte.dev/docs)
- [SvelteKit Documentation](https://kit.svelte.dev/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Supabase Documentation](https://supabase.io/docs)
- [WCAG 2.2 Guidelines](https://www.w3.org/TR/WCAG22/)
