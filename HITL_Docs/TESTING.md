# LIFT Digital Workplace Passport - Testing Guide

## Testing Stack

- **Unit and Component Testing**: Vitest + @testing-library/svelte
- **Integration Testing**: Vitest with mocked Supabase client
- **Coverage Target**: 80% for critical paths

## Setting Up Tests

The project uses Vitest as the test runner and @testing-library/svelte for component testing. This combination provides a modern, fast testing environment with a user-centric approach to testing components.

### Dependencies

```bash
npm install --save-dev vitest @testing-library/svelte @testing-library/jest-dom jsdom
```

These are already installed in the project.

## Writing Component Tests

### Basic Component Test

Here's a basic example of testing a Svelte component:

```typescript
// src/components/LoginForm.svelte.test.ts
import { describe, test, expect } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen } from '@testing-library/svelte';
import LoginForm from './LoginForm.svelte';

describe('LoginForm', () => {
	test('renders email input', () => {
		render(LoginForm);

		// Find elements by their accessible roles
		const emailInput = screen.getByLabelText('Email');

		// Assert the element exists
		expect(emailInput).toBeInTheDocument();
		expect(emailInput).toHaveAttribute('type', 'email');
	});
});
```

### Testing User Interactions

```typescript
// src/components/LoginForm.svelte.test.ts
import { describe, test, expect, vi } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen, fireEvent } from '@testing-library/svelte';
import LoginForm from './LoginForm.svelte';

describe('LoginForm', () => {
	test('calls submit handler when form is submitted', async () => {
		// Create a mock function
		const handleSubmit = vi.fn();

		// Render component with props
		const { component } = render(LoginForm, {
			props: {
				onSubmit: handleSubmit
			}
		});

		// Get form elements
		const emailInput = screen.getByLabelText('Email');
		const submitButton = screen.getByRole('button', { name: /send magic link/i });

		// Interact with the form
		await fireEvent.input(emailInput, { target: { value: 'test@example.com' } });
		await fireEvent.click(submitButton);

		// Assert the handler was called with correct value
		expect(handleSubmit).toHaveBeenCalledWith(
			expect.objectContaining({
				email: 'test@example.com'
			})
		);
	});
});
```

### Testing Asynchronous Behavior

```typescript
// src/components/ProfileForm.svelte.test.ts
import { describe, test, expect, vi } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/svelte';
import ProfileForm from './ProfileForm.svelte';

describe('ProfileForm', () => {
	test('displays success message after saving', async () => {
		// Mock the save function that returns a promise
		const saveProfile = vi.fn().mockResolvedValue({ success: true });

		render(ProfileForm, {
			props: {
				saveProfile
			}
		});

		// Fill out form
		await fireEvent.input(screen.getByLabelText('Name'), {
			target: { value: 'John Doe' }
		});

		// Submit form
		await fireEvent.click(screen.getByRole('button', { name: /save/i }));

		// Wait for async operations to complete
		await waitFor(() => {
			expect(screen.getByText(/profile saved successfully/i)).toBeInTheDocument();
		});

		expect(saveProfile).toHaveBeenCalledWith(
			expect.objectContaining({
				name: 'John Doe'
			})
		);
	});
});
```

## Testing Store Interactions

Testing components that use Svelte stores:

```typescript
// src/components/Dashboard.svelte.test.ts
import { describe, test, expect, beforeEach, vi } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen } from '@testing-library/svelte';
import Dashboard from './Dashboard.svelte';
import { profileStore } from '../stores/profileStore';

// Mock the store
vi.mock('../stores/profileStore', () => ({
	profileStore: {
		subscribe: vi.fn().mockImplementation((callback) => {
			callback({
				name: 'Test User',
				job_title: 'Developer'
			});
			return () => {}; // Unsubscribe function
		})
	}
}));

describe('Dashboard', () => {
	test('displays user profile data from store', () => {
		render(Dashboard);

		expect(screen.getByText('Test User')).toBeInTheDocument();
		expect(screen.getByText('Developer')).toBeInTheDocument();
	});
});
```

## Testing Accessibility

```typescript
// src/components/Button.svelte.test.ts
import { describe, test, expect } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen } from '@testing-library/svelte';
import { axe, toHaveNoViolations } from 'jest-axe';
import Button from './Button.svelte';

expect.extend(toHaveNoViolations);

describe('Button', () => {
	test('should have no accessibility violations', async () => {
		const { container } = render(Button, {
			props: {
				label: 'Submit',
				type: 'submit'
			}
		});

		const results = await axe(container);
		expect(results).toHaveNoViolations();
	});
});
```

## Test Organization

- Test files should be named `*.test.ts` or `*.spec.ts`
- Place test files next to the components they test
- Use descriptive test names that explain the expected behavior

## Running Tests

```bash
# Run all tests
npm run test

# Run tests in watch mode during development
npm run test:unit

# Run tests with coverage (add to package.json if needed)
npm run test -- --coverage
```

## Best Practices

1. **Test Behavior, Not Implementation**

   - Focus on what the component does, not how it does it
   - Test from the user's perspective

2. **Use Accessible Queries**

   - Prefer `getByRole`, `getByLabelText`, `getByText` over `getByTestId`
   - This ensures your components are accessible while also making tests more robust

3. **Isolate Tests**

   - Mock external dependencies
   - Each test should be independent of others

4. **Keep Tests Simple**

   - Test one thing per test
   - Use descriptive test names

5. **Test Edge Cases**
   - Empty states
   - Loading states
   - Error states

## Mocking Supabase

When testing components that interact with Supabase:

```typescript
// src/lib/supabase.ts (mock version)
vi.mock('../lib/supabase', () => ({
	supabase: {
		auth: {
			signInWithOtp: vi.fn().mockResolvedValue({ data: {}, error: null }),
			getSession: vi.fn().mockResolvedValue({
				data: {
					session: {
						user: { id: 'test-user-id', email: 'test@example.com' }
					}
				},
				error: null
			})
		},
		from: vi.fn().mockImplementation((table) => ({
			select: vi.fn().mockReturnThis(),
			insert: vi.fn().mockReturnThis(),
			update: vi.fn().mockReturnThis(),
			delete: vi.fn().mockReturnThis(),
			eq: vi.fn().mockReturnThis(),
			single: vi.fn().mockReturnThis(),
			order: vi.fn().mockReturnThis(),
			limit: vi.fn().mockReturnThis(),
			then: vi.fn().mockImplementation((callback) => {
				// Mock response data based on the table
				let data;
				if (table === 'profiles') {
					data = { data: [{ id: 1, name: 'Test User' }], error: null };
				} else if (table === 'responses') {
					data = { data: [{ id: 1, response_text: 'Test response' }], error: null };
				}
				return Promise.resolve(callback(data));
			})
		}))
	}
}));
```

This mock implementation can be adjusted based on the specific Supabase functions your components use.
