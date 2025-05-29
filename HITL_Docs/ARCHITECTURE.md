# LIFT Digital Workplace Passport - Architecture Specification

## Technology Stack

### Frontend

- **Framework**: Svelte 5 with SvelteKit
- **Styling**: TailwindCSS
- **State Management**: Svelte stores
- **Testing**: Vitest with @testing-library/svelte
  - Component testing using render/screen utilities
  - DOM assertions with @testing-library/jest-dom
  - User event simulation with fireEvent

### Backend

- **Data Storage**: Supabase
- **Authentication**: Supabase Magic Link
- **API**: SvelteKit server routes + Supabase client
- **Testing**: Vitest with mocked Supabase client
- **Database Management**: Supabase CLI for schema migrations and local development

### Infrastructure

- **Hosting**: Vercel
- **Environments**:
  - **Development**: Local Supabase instance via Docker
  - **Production**: Remote Supabase project
- **Database**: 
  - Local development uses Docker-based Supabase stack
  - Production uses remote Supabase project
  - Environment-specific configuration and credentials

## Project Structure

SvelteKit project structure:

```
project-root/
├── src/
│   ├── routes/                    # SvelteKit routes (pages)
│   │   ├── +layout.svelte         # Main layout
│   │   ├── +layout.server.ts      # Authentication checks
│   │   ├── +page.svelte           # Landing/login page
│   │   ├── dashboard/             # Dashboard section
│   │   │   └── +page.svelte       # Dashboard with all categories in one view
│   │   └── auth/                  # Auth related routes
│   │       └── callback/
│   │           └── +page.server.ts # Magic link callback handling
│   ├── lib/                       # Shared code
│   │   ├── components/            # All UI components
│   │   ├── stores/                # Svelte stores
│   │   ├── services/              # Supabase, email, etc.
│   │   └── utils.ts               # Small helpers
│   ├── app.html                   # HTML template
│   └── hooks.server.ts            # Server hooks
├── static/                        # Static assets
├── tests/                         # Test files
├── svelte.config.js               # Svelte configuration
├── tailwind.config.js             # Tailwind configuration
└── package.json                   # Project dependencies
```

## Data Architecture

### Database Structure

Supabase tables:

1. **users**

   - id (PK)
   - email
   - created_at
   - last_login

2. **profiles**
   - id (PK)
   - user_id (FK)
   - name
   - pronouns
   - job_title
   - employer_name # For MVP: plain text field
   - employer_id (FK, nullable) # For future: reference to employers table
   - line_manager_name # For MVP: plain text field
   - line_manager_email # For MVP: plain text field
   - line_manager_user_id (FK, nullable) # For future: self-reference to another user's profile

> **Note on users/profiles separation**: We maintain separate tables for users and profiles to follow best practices with Supabase. The `users` table is managed by Supabase Auth and handles authentication concerns, while the `profiles` table contains application-specific user data. This separation provides better security through row-level security policies, allows for independent schema evolution, and keeps authentication data separate from application data.

> **Note on line manager relationship**:
>
> - The profiles table uses a self-referencing relationship to represent line management
> - For the MVP, line manager information is stored as plain text (name and email)
> - The `line_manager_user_id` field is included but remains NULL in the MVP
> - In the future implementation, this field will reference another user's profile
> - This allows any user to be someone else's line manager
> - This approach provides a standard hierarchical relationship model

> **Note on future employer centralization**:
>
> - For the MVP, employer information is stored as plain text
> - The `employer_id` field is included but remains NULL in the MVP
> - In the future, employers will be centralized in their own table
> - This approach minimizes migration complexity when the feature is added

### Future Employers Table (Not Implemented in MVP)

```
employers
  - id (PK)
  - name
  - address
  - contact_email
  - contact_phone
  - created_at
  - updated_at
```

3. **questions**

   - id (PK)
   - category
   - question_text
   - order

4. **responses**
   - id (PK)
   - user_id (FK)
   - question_id (FK)
   - response_text
   - status (enum: 'answered', 'skipped')
   - visibility (enum: 'public', 'private')
   - version (integer) # Identifies this response's version number
   - is_latest (boolean) # Flag to easily identify the most recent version
   - created_at
   - updated_at

> **Note on response versioning**:
>
> - Each answer version is stored as a separate row in the responses table
> - Multiple responses with the same question_id but different version numbers represent the history of changes
> - The `is_latest` flag makes it easy to query only the most recent versions
> - When a user updates a response, a new row is created with incremented version number and is_latest=true
> - The previous version's is_latest flag is set to false
> - The `visibility` field gives users control over what information is shared

5. **actions**
   - id (PK)
   - user_id (FK)
   - response_id (FK, nullable)
   - type (enum)
   - description
   - version (integer) # Identifies this action's version number
   - is_latest (boolean) # Flag to easily identify the most recent version
   - created_at
   - updated_at

> **Note on action versioning**:
>
> - Actions use the same versioning approach as responses
> - Each version is stored as a separate row
> - The is_latest flag identifies current versions
> - This ensures consistent historical tracking for both responses and actions

6. **sharing_events**

   - id (PK)
   - user_id (FK)
   - recipient_email # Line manager's email
   - shared_at
   - message # Optional message to accompany the sharing

7. **sharing_event_responses**

   - id (PK)
   - sharing_event_id (FK)
   - response_id (FK) # Points to the specific response version

8. **sharing_event_actions**
   - id (PK)
   - sharing_event_id (FK)
   - action_id (FK)

> **Note on sharing and versioning**:
>
> - Each sharing event represents an email sent from a user to their line manager
> - The `sharing_event_responses` junction table links specific response rows (including their versions) to sharing events
> - The `sharing_event_actions` junction table links actions to sharing events
> - This creates a true point-in-time snapshot of what was shared without duplicating content
> - When querying for the current state of responses, filter by is_latest=true
> - When retrieving a historical shared passport, join with the junction tables to get the exact content shared
> - This approach provides a complete audit trail while maintaining data normalization

## Authentication Flow

1. User enters email on login page
2. System sends Magic Link email via Supabase
3. User clicks link in email
4. Supabase verifies token and establishes session
5. Session token stored in HTTP-only cookie
6. Session refreshed automatically via Supabase client

## Component Architecture

### Core Components

#### Auth Components

- `LoginForm.svelte` - Email input for Magic Link (embedded in landing page)

#### Dashboard Components

- `CategorySection.svelte` - Individual category section (form, questions, etc.)
- `ProfileSection.svelte` - Profile display and edit
- `CategoryNavigation.svelte` - Navigation between categories (next/prev buttons or tabs)

#### Form Components

- `QuestionForm.svelte` - Renders questions for a category
- `ResponseInput.svelte` - Free text input for responses
- `AdjustmentSelector.svelte` - Follow-up action selector

#### Adjustment Components

- `AdjustmentsList.svelte` - List of all adjustments
- `AdjustmentItem.svelte` - Individual adjustment display
- `AdjustmentForm.svelte` - Form to add/edit adjustments

#### Sharing Components

- `SharingForm.svelte` - Form to share with managers
- `DocumentPreview.svelte` - Preview of downloadable document

## State Management

### Svelte Stores

1. **authStore.js**

   - Manages authentication state
   - Tracks current user

2. **profileStore.js**

   - Manages user profile data
   - Handles profile updates

3. **responsesStore.js**

   - Tracks user responses to questions
   - Manages temporary form state

4. **adjustmentsStore.js**
   - Manages workplace adjustments
   - Tracks created/updated adjustments

## Security Architecture

1. **Authentication Security**

   - Magic Link (passwordless)
   - Short-lived tokens
   - HTTP-only cookies

2. **Authorization**

   - Row-Level Security in Supabase
   - User can only access their own data

3. **Data Security**
   - Encrypted data at rest (Supabase)
   - Secure API endpoints
   - Input validation

## Performance Considerations

1. **Client-side**

   - Lazy loading components
   - Optimized Tailwind usage
   - Minimal JavaScript bundle

2. **Server-side**
   - Efficient database queries
   - Caching where appropriate
   - Optimized API responses

## Accessibility Architecture

1. **Semantic HTML structure**
2. **ARIA attributes where needed**
3. **Focus management for keyboard navigation**
4. **Color contrast compliance**
5. **Screen reader compatibility**

## Error Handling

1. **Global Error Boundaries**

   - SvelteKit error pages
   - Fallback UI for critical errors

2. **Form Validation**

   - Client-side validation
   - Server-side validation
   - User-friendly error messages

3. **API Error Handling**
   - Consistent error response format
   - Detailed error logging
   - Graceful degradation

## Monitoring and Logging

1. **Initial minimal logging**

   - Critical errors
   - Authentication events

2. **Future expansion**
   - More comprehensive monitoring tools
   - Usage analytics
