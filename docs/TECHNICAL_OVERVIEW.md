# LIFT Digital Workplace Passport - Technical Overview

**Comprehensive Technical Documentation for Developers**

---

## Relevant Source Files

This document is based on analysis of the following key files:

- [package.json](https://github.com/foundersandcoders/LIFT02/blob/main/package.json)
- [src/routes/+layout.svelte](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/+layout.svelte)
- [src/routes/dashboard/+page.svelte](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/dashboard/+page.svelte)
- [src/lib/services/database/responses.ts](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/services/database/responses.ts)
- [src/lib/types/appState.ts](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/types/appState.ts)
- [src/lib/components/views/Dash.svelte](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/components/views/Dash.svelte)
- [svelte.config.js](https://github.com/foundersandcoders/LIFT02/blob/main/svelte.config.js)
- [README.md](https://github.com/foundersandcoders/LIFT02/blob/main/README.md)

---

## Purpose and Scope

This document provides a comprehensive technical overview of the LIFT Digital Workplace Passport application, covering its architecture, technology stack, component structure, and data flow patterns. It is designed to help developers quickly understand the codebase and begin contributing effectively.

For additional documentation, see:
- **[ARCHITECTURE.md](./HITL_Docs/ARCHITECTURE.md)** - Detailed architecture patterns and design decisions
- **[FUNCTIONAL.md](./HITL_Docs/FUNCTIONAL.md)** - Feature documentation and specifications
- **[TESTING.md](./HITL_Docs/TESTING.md)** - Test patterns and guidelines
- **[CLAUDE.md](../CLAUDE.md)** - Project instructions and conventions

---

## Application Purpose

LIFT is a **digital workplace passport application** that helps neurodivergent employees document and share their workplace accommodation needs with line managers, promoting a more inclusive workplace environment. The application provides:

- **Question-based assessment** across multiple categories (communication, environment, work patterns, etc.)
- **Response management** with public/private visibility controls
- **Action tracking** for workplace accommodations and adjustments
- **Secure sharing** of workplace needs with line managers via email
- **User preferences** including accessibility features like adjustable font sizes
- **Resource library** with links to support materials

The application emphasizes accessibility, privacy, and user autonomy in managing workplace accommodations.

**Sources:** [README.md:1-3](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L1-L3)

---

## Technology Stack

The application is built on modern web technologies with a focus on developer experience and type safety:

| Category | Technology | Version | Purpose |
|----------|-----------|---------|---------|
| **Frontend Framework** | Svelte | 5.0.0 | Reactive UI components with modern runes API |
| **Fullstack Framework** | SvelteKit | 2.16.0 | SSR, routing, and server endpoints |
| **Build Tool** | Vite | 6.2.6 | Fast development server and optimized builds |
| **Styling - Utility** | TailwindCSS | 4.1.10 | Utility-first CSS framework |
| **Styling - Components** | DaisyUI | 5.0.43 | Pre-built component classes |
| **Typography** | @tailwindcss/typography | 0.5.16 | Prose styling for rich content |
| **Font** | @fontsource/metropolis | 5.2.5 | Custom Metropolis font |
| **Language** | TypeScript | 5.0.0 | Static type checking |
| **Database** | PostgreSQL | (via Supabase) | Relational data storage |
| **Backend Service** | Supabase | 2.49.8 | Auth, database, and API |
| **Authentication** | @supabase/ssr | 0.7.0 | Server-side auth with HTTP-only cookies |
| **Testing Framework** | Vitest | 3.0.0 | Unit and component testing |
| **Testing Library** | @testing-library/svelte | 5.2.8 | Component test utilities |
| **Code Quality - Linting** | ESLint | 9.18.0 | Code quality checks |
| **Code Quality - Formatting** | Prettier | 3.5.3 | Code formatting |
| **Validation** | Zod | 3.25.51 | Schema validation |
| **Sanitization** | isomorphic-dompurify | 2.28.0 | HTML sanitization |
| **Development** | Supabase CLI | 2.53.6 | Local database management |
| **Deployment** | @sveltejs/adapter-vercel | 5.6.3 | Vercel serverless deployment |

**Sources:** [package.json:1-63](https://github.com/foundersandcoders/LIFT02/blob/main/package.json#L1-L63)

---

## Architecture Overview

### Context-Based State Management

The application uses a **centralized context-based architecture** built on Svelte 5's `$state` runes and `setContext`/`getContext` APIs. This eliminates the need for global stores while maintaining reactive state management.

#### Root State Object

The entire application state is defined in the root layout as a single `AppState` object:

```typescript
interface AppState {
  profile: Profile;     // User authentication and preferences
  view: View;          // Current active view
  list: List;          // List view navigation state
  detail: Detail;      // Detail view navigation state
  dev: DevState;       // Development mode test data
}
```

**Sources:** [src/lib/types/appState.ts:7-13](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/types/appState.ts#L7-L13)

#### Context Providers

The root layout (`+layout.svelte`) provides 16+ context getters and setters:

| Context Key | Return Type | Purpose |
|-------------|-------------|---------|
| `getApp` | `() => AppState` | Access entire app state |
| `getProfile` | `() => Profile` | Get user profile |
| `getProfileId` | `() => string \| null` | Get current user ID |
| `getProfileName` | `() => string \| null` | Get user's name |
| `getView` | `() => View` | Get current view state |
| `getViewName` | `() => ViewName` | Get active view name |
| `getList` | `() => List` | Get list navigation state |
| `getListCategory` | `() => ItemCategory` | Get selected category |
| `getDetail` | `() => Detail` | Get detail navigation state |
| `getDetailItemId` | `() => string \| null` | Get selected item ID |
| `getDevMode` | `() => boolean` | Check if dev mode active |
| `setViewName` | `(view: ViewName) => void` | Change active view |
| `setList` | `(list: List) => void` | Update list state |
| `setDetail` | `(detail: Detail) => void` | Update detail state |
| `setProfile` | `(profile: Profile) => void` | Update user profile |
| `setDevMode` | `() => void` | Toggle dev mode |

**Sources:** [src/routes/+layout.svelte:106-151](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/+layout.svelte#L106-L151)

#### State Initialization

The application initializes state on mount with development mode support:

```typescript
// Root state initialization
let appState = $state<AppState>({
  profile: {
    id: null,
    name: null,
    is_line_manager: null,
    preferences: {}
  },
  view: { name: 'dash' },
  list: {
    table: null,
    category: { raw: null, format: null }
  },
  detail: {
    table: null,
    item: { id: null }
  },
  dev: {
    testProfileId: '550e8400-e29b-41d4-a716-446655440001',
    testProfileName: 'Perico Palotes'
  }
});
```

**Sources:** [src/routes/+layout.svelte:42-70](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/+layout.svelte#L42-L70)

### Application Initialization Flow

The application follows this initialization sequence:

1. **Browser Request** → SvelteKit server receives request
2. **Auth Middleware** (`hooks.server.ts`) → Validates session cookie, creates Supabase client
3. **Layout Server Load** (`/dashboard/+layout.server.ts`) → Fetches user profile if authenticated
4. **Root Layout Render** (`+layout.svelte`) → Initializes `AppState`, sets up context providers
5. **View Router** (`/dashboard/+page.svelte`) → Renders view based on `appState.view.name`
6. **Component Mounting** → Child components access state via `getContext()`

```typescript
// Example: Component accessing state
const getProfileId = getContext<() => string | null>('getProfileId');
const setViewName = getContext<(view: ViewName) => void>('setViewName');

const userId = getProfileId(); // Get current user ID
setViewName('list');           // Navigate to list view
```

**Sources:** [src/routes/dashboard/+page.svelte:9-12](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/dashboard/+page.svelte#L9-L12)

### Component Responsibilities

Components are organized by responsibility in `/src/lib/components/`:

| Directory | Component Count | Responsibilities | Examples |
|-----------|----------------|------------------|----------|
| **views/** | 4 | Main application views, orchestrate data fetching and layout | `Dash.svelte`, `List.svelte`, `Detail.svelte`, `Email.svelte` |
| **layouts/** | 3 | Page structure and navigation | `Header.svelte`, `Footer.svelte`, `ViewHeader.svelte` |
| **cards/** | 3 | Display data in card format | `DashTile.svelte`, `ListItem.svelte`, `QuestionCard.svelte` |
| **ui/** | 17 | Reusable UI elements and controls | `ConfirmModal.svelte`, `FormButton.svelte`, `Tooltip.svelte` |
| **logic/** | 1 | Complex logic and state visualization | `StateTable.svelte` (dev mode inspector) |

**Pattern:** All components follow a flat structure within their category directories. No nested subdirectories are used.

**Sources:** [README.md:511-534](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L511-L534)

---

## Core Features Overview

The application provides four main feature areas, each implemented as a view component:

### 1. Dashboard View (`Dash.svelte`)

**Purpose:** Overview of progress and quick navigation to categories

**Key Features:**
- Displays active actions count
- Shows question categories with completion status (e.g., "3/5 completed")
- Provides quick navigation to category lists
- Shows resources and information links

**Implementation Pattern:**
```typescript
const queryActions = $derived(
  app.profile.id ? getLatestActions(app.profile.id, false) : null
);
const queryQuestions = $state(getQuestions());
const queryResponses = $derived(
  app.profile.id ? getUserResponses(app.profile.id) : null
);
```

**Sources:** [src/lib/components/views/Dash.svelte:23-26](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/components/views/Dash.svelte#L23-L26)

### 2. List View (`List.svelte`)

**Purpose:** Display all questions within a selected category

**Key Features:**
- Filters questions by category (e.g., "Communication", "Environment")
- Shows response status for each question
- Provides navigation to question detail view
- Breadcrumb navigation back to dashboard

### 3. Detail View (`Detail.svelte`)

**Purpose:** Answer questions and manage related actions

**Key Features:**
- Question response input (textarea)
- Response visibility control (public/private toggle)
- Action/accommodation management (create, edit, delete)
- Save status indicator
- Auto-save with debouncing

### 4. Email View (`Email.svelte`)

**Purpose:** Share workplace needs with line manager

**Key Features:**
- Select which responses to share
- Select which actions to share
- Add custom message
- Preview email before sending
- Track sharing history

**Database Pattern:** Creates `sharing_events` with linked `sharing_event_responses` and `sharing_event_actions` for point-in-time reconstruction.

---

## Component Hierarchy

The application uses a simple, three-level component hierarchy:

```
+layout.svelte (Root Layout)
├── Header.svelte
├── +page.svelte (View Router)
│   ├── Dash.svelte
│   │   ├── ViewHeader.svelte
│   │   ├── DashTile.svelte (multiple instances)
│   │   └── InfoModal.svelte
│   ├── List.svelte
│   │   ├── ViewHeader.svelte
│   │   ├── Breadcrumb.svelte
│   │   └── ListItem.svelte (multiple instances)
│   ├── Detail.svelte
│   │   ├── ViewHeader.svelte
│   │   ├── Breadcrumb.svelte
│   │   ├── QuestionCard.svelte
│   │   ├── ActionsCRUD.svelte
│   │   └── SaveStatus.svelte
│   └── Email.svelte
│       ├── ViewHeader.svelte
│       ├── Breadcrumb.svelte
│       └── ConfirmModal.svelte
└── Footer.svelte
```

**Key Design Decision:** The view router (`/dashboard/+page.svelte`) conditionally renders one view at a time based on `appState.view.name`:

```svelte
{#if view === 'dash'}
  <Dash />
{:else if view === 'list'}
  <List />
{:else if view === 'detail'}
  <Detail />
{:else if view === 'email'}
  <Email />
{/if}
```

**Sources:** [src/routes/dashboard/+page.svelte:14-26](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/dashboard/+page.svelte#L14-L26)

---

## Data Flow Pattern

The application follows a unidirectional data flow pattern:

### Request Flow

1. **User Interaction** → User clicks "View Category"
2. **Event Handler** → Component calls `setViewName('list')` and `setList({ table: 'questions', category })`
3. **State Update** → Context setters update `appState.view.name` and `appState.list`
4. **Reactive Re-render** → View router detects change via `$derived(getViewName())`
5. **View Component Mounts** → `List.svelte` mounts and accesses context
6. **Data Fetching** → Component calls database service functions (e.g., `getQuestionsByCategory()`)
7. **Async Rendering** → Svelte `{#await}` blocks handle loading/success/error states
8. **UI Update** → Data renders in component template

### Data Fetching Pattern

All database operations follow a consistent pattern using `DbResult<T>` or `DbResultMany<T>`:

```typescript
// Service function signature
export async function getUserResponses(
  userId: string,
  options?: QueryOptions & FilterOptions
): Results<Response> {
  const { data, error } = await supabase
    .from('responses')
    .select('*')
    .eq('user_id', userId);

  if (error) {
    return { data: null, error };
  }

  // Type conversion from database types to application types
  const convertedData = data?.map((dbResponse) => ({
    id: dbResponse.id,
    user_id: dbResponse.user_id || '',
    question_id: dbResponse.question_id || '',
    response_text: dbResponse.response_text || undefined,
    status: dbResponse.status as 'answered' | 'skipped',
    visibility: dbResponse.visibility as 'public' | 'private',
    created_at: dbResponse.created_at || undefined,
    updated_at: dbResponse.updated_at || undefined
  })) || [];

  return { data: convertedData, error: null };
}
```

**Sources:** [src/lib/services/database/responses.ts:16-60](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/services/database/responses.ts#L16-L60)

### Component Usage Pattern

Components consume data using Svelte's async handling:

```svelte
<script lang="ts">
  const getProfileId = getContext<() => string | null>('getProfileId');
  const queryResponses = $derived(
    getProfileId() ? getUserResponses(getProfileId()!) : null
  );
</script>

{#await queryResponses}
  <p>Loading responses...</p>
{:then result}
  {#if result?.data}
    {#each result.data as response}
      <!-- Render response -->
    {/each}
  {/if}
{:catch error}
  <p>Error: {error.message}</p>
{/await}
```

**Sources:** [src/lib/components/views/Dash.svelte:26-26](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/components/views/Dash.svelte#L26-L26)

---

## Entry Points and Configuration

### Development Entry Points

| Entry Point | File Path | Purpose |
|-------------|-----------|---------|
| **Application Entry** | `src/routes/+layout.svelte` | Root layout with state management |
| **Login Page** | `src/routes/+page.svelte` | Magic link authentication |
| **Dashboard Entry** | `src/routes/dashboard/+page.svelte` | View router |
| **Auth Callback** | `src/routes/auth/callback/+server.ts` | OAuth/magic link handler |
| **Server Hooks** | `src/hooks.server.ts` | Server-side auth middleware |
| **CSS Entry** | `src/app.css` | Global styles and Tailwind config |

### Configuration Files

| File | Purpose | Key Settings |
|------|---------|--------------|
| **package.json** | Dependencies and scripts | Svelte 5, SvelteKit 2.16, 15+ npm scripts |
| **svelte.config.js** | Svelte/SvelteKit configuration | Vercel adapter, Vite preprocessing |
| **vite.config.ts** | Vite build configuration | Tailwind plugin, SvelteKit integration |
| **vitest.config.ts** | Test framework configuration | jsdom environment, test glob patterns |
| **tsconfig.json** | TypeScript compiler options | Strict mode, path aliases (`$lib/*`) |
| **eslint.config.js** | Linting rules | ESLint 9 flat config, TypeScript-ESLint |
| **.prettierrc** | Code formatting rules | Plugin integrations, custom overrides |
| **app.css** | CSS configuration | Tailwind plugins, DaisyUI theme, custom colors |

**Sources:** [svelte.config.js:1-9](https://github.com/foundersandcoders/LIFT02/blob/main/svelte.config.js#L1-L9)

### Build Scripts and Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server (Vite) |
| `npm run build` | Production build |
| `npm run deploy` | Preview deployment to Vercel |
| `npm run test` | Run all tests |
| `npm run test:unit` | Run tests in watch mode |
| `npm run check` | TypeScript type checking |
| `npm run lint` | ESLint code checking |
| `npm run format` | Prettier code formatting |
| `npm run lift:test` | Full test setup (Supabase + dev server) |
| `npm run db:reset` | Reset local database with seed data |
| `npm run db:generate-data` | Generate test data SQL |
| `supabase start` | Start local Supabase Docker instance |
| `supabase db push` | Deploy schema to production |

**Sources:** [package.json:6-21](https://github.com/foundersandcoders/LIFT02/blob/main/package.json#L6-L21)

---

## Key Architectural Patterns

### 1. Context-Based State Management

**Pattern:** Single source of truth in root layout, accessed via Svelte context API

**Benefits:**
- No global store pollution
- Type-safe access with TypeScript
- Granular context providers for performance
- Reactive updates via Svelte 5 `$state` runes

**Example:**
```typescript
// Root layout - provide context
setContext('getProfileId', () => appState.profile.id);

// Child component - consume context
const getProfileId = getContext<() => string | null>('getProfileId');
const userId = $derived(getProfileId());
```

**Sources:** [src/routes/+layout.svelte:114-114](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/+layout.svelte#L114-L114)

### 2. Service Layer Abstraction

**Pattern:** All database operations isolated in `/services/database` with consistent return types

**Structure:**
```
/services/database/
├── types.ts          # DbResult<T>, DbResultMany<T>, QueryOptions
├── responses.ts      # Response CRUD operations
├── actions.ts        # Action CRUD operations
├── questions.ts      # Question queries
├── profiles.ts       # Profile management
├── resources.ts      # Resource fetching
├── sharing.ts        # Sharing events
└── index.ts          # Barrel exports
```

**Return Type Pattern:**
```typescript
// Single item result
export type DbResult<T> = {
  data: T | null;
  error: PostgrestError | null;
};

// Multiple items result
export type DbResultMany<T> = {
  data: T[] | null;
  error: PostgrestError | null;
};
```

**Sources:** [src/lib/services/database/responses.ts:1-11](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/services/database/responses.ts#L1-L11)

### 3. View-Based Navigation

**Pattern:** Single-page application with programmatic view switching (no route changes)

**Four Views:**
- `dash` - Dashboard overview
- `list` - Category question list
- `detail` - Question response detail
- `email` - Sharing interface

**Navigation:**
```typescript
const setViewName = getContext<(view: ViewName) => void>('setViewName');
const setList = getContext<(list: List) => void>('setList');

// Navigate to list view with category
function viewCategory(category: ItemCategory) {
  setList({ table: 'questions', category });
  setViewName('list');
}
```

**Sources:** [src/lib/types/appState.ts:71-71](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/types/appState.ts#L71-L71)

### 4. Upsert Pattern for Responses

**Pattern:** Simplified data model using PostgreSQL `ON CONFLICT` for single response per question

**Implementation:**
```typescript
export async function upsertResponse(
  userId: string,
  questionId: string,
  data: Omit<ResponseInsert, 'user_id' | 'question_id'>
): Result<Response> {
  const upsertData = {
    ...data,
    user_id: userId,
    question_id: questionId
  };

  const { data: response, error } = await supabase
    .from('responses')
    .upsert(upsertData, {
      onConflict: 'user_id,question_id'  // Unique constraint
    })
    .select()
    .single();

  // ... error handling and type conversion
}
```

**Benefit:** Eliminates versioning complexity while maintaining data integrity via database constraints.

**Sources:** [src/lib/services/database/responses.ts:201-240](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/services/database/responses.ts#L201-L240)

### 5. Component Composition

**Pattern:** Semantic categorization with reusable components

**Design Principles:**
- Components are organized by purpose (cards, layouts, ui, views)
- No nested component directories (flat structure)
- UI components are highly reusable across views
- View components orchestrate data fetching and layout

**Example - Dashboard Tile Composition:**
```svelte
<!-- Dash.svelte -->
<DashTile
  title={`${activeCount} Active Actions`}
  onclick={() => navigateToActions()}
/>

<!-- Reused in multiple places with different data -->
```

**Sources:** [src/lib/components/views/Dash.svelte:69-72](https://github.com/foundersandcoders/LIFT02/blob/main/src/lib/components/views/Dash.svelte#L69-L72)

### 6. Row-Level Security (RLS)

**Pattern:** PostgreSQL Row-Level Security policies for data access control

**Policy Example:**
- Users can SELECT/INSERT/UPDATE/DELETE their own data only
- Service role has full access for administrative operations
- Cell-level access control via `user_id` column matching

**Database Setup:** RLS policies defined in migrations (`20250923195428_enable_row_level_security.sql`)

### 7. Development Mode with Test Data

**Pattern:** Built-in dev mode toggle with test profile switching

**Implementation:**
```typescript
let devMode = $state<boolean>(false);
setContext('getDevMode', () => devMode);
setContext('setDevMode', () => { devMode = !devMode; });

// Dev state with test profile
dev: {
  testProfileId: '550e8400-e29b-41d4-a716-446655440001',
  testProfileName: 'Perico Palotes'
}
```

**Usage:** Footer component provides dev mode toggle for rapid testing without authentication.

**Sources:** [src/routes/+layout.svelte:34-39](https://github.com/foundersandcoders/LIFT02/blob/main/src/routes/+layout.svelte#L34-L39)

---

## Development Environment Setup

### Prerequisites

1. **Node.js** v18+ ([nodejs.org](https://nodejs.org/))
2. **Docker Desktop** ([docker.com](https://www.docker.com/products/docker-desktop/))
3. **Git** ([git-scm.com](https://git-scm.com/))
4. **PostgreSQL Client** (for Linux: `sudo apt-get install postgresql-client`)

**Sources:** [README.md:70-115](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L70-L115)

### Quick Start

```bash
# 1. Clone repository
git clone https://github.com/foundersandcoders/LIFT02.git
cd LIFT02

# 2. Install dependencies
npm install

# 3. Set up environment variables
cp .env.example .env.local
# No changes needed - contains correct local development keys

# 4. Start local Supabase instance
supabase start
# First time: Downloads ~2-3GB Docker images (5-15 minutes)

# 5. Verify database is running
supabase status

# 6. Add test data (optional)
./scripts/local-seed-test-data.sh

# 7. Start development server
npm run dev

# 8. Open application
# Browser: http://localhost:5173
# Supabase Studio: http://127.0.0.1:54323
```

**Sources:** [README.md:119-176](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L119-L176)

### Database Management

```bash
# Reset database (includes question seed)
supabase db reset

# Add test data (5 fake users with comprehensive data)
./scripts/local-seed-test-data.sh

# Remove test data
./scripts/local-delete-test-data.sh

# Generate TypeScript types from schema
supabase gen types typescript --local > src/lib/types/supabase.ts

# Push schema changes to production
supabase db push --password 'YOUR_DB_PASSWORD'
# or use automated script:
./scripts/prod-run-migrations.sh
```

**Sources:** [README.md:179-356](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L179-L356)

### Testing

```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:unit

# Type checking
npm run check

# Linting
npm run lint

# Code formatting
npm run format
```

**Sources:** [README.md:452-503](https://github.com/foundersandcoders/LIFT02/blob/main/README.md#L452-L503)

### Deployment

```bash
# Preview deployment (safe - creates preview URL)
npm run deploy

# Production deployment (manual - requires approval)
npx vercel --prod
```

**Warning:** Production is manually controlled. Always test with preview deployments first.

**Sources:** [package.json:9-9](https://github.com/foundersandcoders/LIFT02/blob/main/package.json#L9-L9)

---

## Summary

LIFT Digital Workplace Passport is a modern, accessibility-focused web application built with:

- **Svelte 5** for reactive UI with modern runes API
- **SvelteKit** for SSR and routing
- **Supabase** for authentication and PostgreSQL database
- **Context-based state management** eliminating global stores
- **Service layer abstraction** for consistent data access
- **View-based navigation** for single-page application feel
- **Row-level security** for data protection
- **Comprehensive test coverage** with Vitest

The application emphasizes developer experience through:
- Type safety with TypeScript
- Automated code quality with ESLint and Prettier
- Local development with Docker-based Supabase
- Clear architectural patterns and documentation
- Built-in dev mode for rapid testing

For detailed information on specific topics, see the additional documentation files listed in the [Purpose and Scope](#purpose-and-scope) section.

---

**Document Version:** 1.0
**Last Updated:** 2025-12-08
**Generated By:** Claude Code - Technical Documentation Assistant
