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
- Development: Supabase environments (no local instances)
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

- Required environment variables:
  - `PUBLIC_SUPABASE_URL`
  - `PUBLIC_SUPABASE_ANON_KEY`
  - `SUPABASE_SERVICE_KEY` (server-only)
  - `EMAIL_SERVICE_KEY` (for sending emails)

- Supabase environments:
  - Development, staging, and production projects in Supabase
  - No local Supabase instance required
  - Environment-specific database and auth settings

- Setup commands:
  ```bash
  # Install dependencies
  npm install
  
  # Copy environment template
  cp .env.example .env.local
  
  # Fill in environment variables with appropriate Supabase project keys
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