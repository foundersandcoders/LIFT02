<script lang="ts">
	import { getContext } from 'svelte';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import DashTile from '../cards/DashTile.svelte';
	import Tooltip from '../ui/Tooltip.svelte';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestions } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import type { Question } from '$lib/types/tableMain';
	import type { AppState, ItemCategory, List, TableName, ViewName, Profile } from '$lib/types/appState';
	import { makePretty } from '$lib/utils/textTools';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const setList = getContext<(list: List) => void>('setList');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let queryActions = $derived(app.profile.id ? getLatestActions(app.profile.id, false) : null);
	let queryQuestions = $state(getQuestions());
	let queryResources = $state(getResources());

	function extractCategories(questions: Question[]): ItemCategory[] {
		// TODO: Move extractCategories() to a utils file
		const categoriesRaw: string[] = questions.map((question: Question) => question.category);
		const categoriesUnique = [...new Set(categoriesRaw)];

		return categoriesUnique.map((category: string) => ({
			raw: category,
			format: makePretty(category, 'db-table-name', 'tile-text')
		}));
	}

	const onclick = (table: TableName, category: ItemCategory) => {
		// TODO: Create a utils file for regular view transitions
		setList({ table, category });
		setViewName('list');
	};

	// ========== TESTING ONLY - REMOVE WHEN DONE ==========
	const getTestUsers = getContext<() => Profile[]>('getTestUsers');
	const setTestUser = getContext<(userId: string, userName: string) => Promise<void>>('setTestUser');

	const sortedTestUsers = $derived(
		[...(getTestUsers() || [])]
			.filter(
				(user): user is Profile & { id: string; name: string } =>
					user.id !== null && user.name !== null && user.is_line_manager === false
			)
			.sort((a, b) => a.id.localeCompare(b.id))
	);

	let dropdownExpanded = $state(false);
	let selectedUserId = $state<string | null>(null);

	async function handleUserSelect(userId: string, userName: string) {
		await setTestUser(userId, userName);
		selectedUserId = userId;
		console.log('Test user selected:', userName, userId);

		// Close dropdown after selection
		dropdownExpanded = false;
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}

	function toggleDropdown() {
		dropdownExpanded = !dropdownExpanded;
	}
	// ======================================================
</script>

<div id="dash-view" class="view">
	<ViewHeader title="Dashboard" />

	<div id="dash-tiles" class="view-content">
		{#if app.profile.id == null}
			<div class="dash-grid-1">
				<DashTile title="No Profile Selected" variant="square" disabled />

				<!-- ========== TESTING ONLY - REMOVE WHEN DONE ========== -->
				<div class="dropdown mt-4">
					<button
						type="button"
						class="btn btn-primary btn-sm"
						onclick={toggleDropdown}
						onkeydown={(e) => (e.key === 'Enter' || e.key === ' ' ? toggleDropdown() : null)}
						aria-label="Select test user for development"
						aria-expanded={dropdownExpanded}
						aria-haspopup="listbox"
					>
						Select Test User
					</button>
					<ul
						class="dropdown-content menu bg-base-100 rounded-box text-base-content z-1 w-52 p-2 shadow-sm"
						role="listbox"
						aria-label="Available test users"
					>
						{#each sortedTestUsers as user (user.id)}
							<li role="option" aria-selected={selectedUserId === user.id}>
								<button
									onclick={() => handleUserSelect(user.id, user.name)}
									class="text-left"
									aria-label="Select {user.name} as test user"
								>
									<span class="text-xs opacity-60">{user.id.slice(-2)}</span>
									{user.name}
								</button>
							</li>
						{/each}
					</ul>
				</div>
				<!-- ====================================================== -->
			</div>
		{:else}
			<div id="dash-tiles-top" class="dash-grid-2">
				<!-- Actions -->
				{#await queryActions}
					<DashTile title="Actions" loading={true} variant="square" disabled />
				{:then result}
					{#if result && result.data}
						{@const table = 'actions'}
						{@const category = { raw: 'actions', format: 'Actions' }}
						{@const num = result.data.length}
						{@const any = result.data.length > 0}
						{@const name = "Active Actions"}
						<DashTile
							title={any ? `${num} ${name}` : `No ${name}`}
							variant="square"
							onclick={() => onclick(table, category)}
						/>
					{:else}
						<DashTile title="No Active Actions" variant="square" disabled />
					{/if}
				{:catch error}
					<DashTile title="Error Getting Actions" error={error.message} variant="square" disabled />
				{/await}

				<!-- Resources -->
				{#await queryResources}
					<DashTile title="Resources" loading={true} variant="square" disabled />
				{:then}
					{@const table = 'resources'}
					{@const category = { raw: 'resources', format: 'Resources' }}
					<DashTile
						title={'Resources'}
						variant="square"
						onclick={() => onclick(table, category)}
					/>
				{:catch error}
					<DashTile
						title="Error Getting Resources"
						error={error.message}
						variant="square"
						disabled
					/>
				{/await}
			</div>

			<div class="card bg-base-100 shadow-sm mt-4">
				<div class="card-body p-4">
					<h3 class="card-title text-base opacity-70 mb-2">Categories</h3>
					<div class="dash-vertical-container">
						<!-- Questions -->
						{#await queryQuestions}
							<div class="list-item">
								<p class="text-center">Loading Questions...</p>
							</div>
						{:then result}
							{#if result.data}
								{#each extractCategories(result.data) as category}
									{@const table = 'questions'}
									<DashTile title={category.format} onclick={() => onclick(table, category)} />
								{/each}
							{:else}
								<div class="list-item">
									<p class="text-center">No Questions Found</p>
								</div>
							{/if}
						{:catch error}
							<div class="list-item">
								<p class="text-center">Loading Questions...</p>
							</div>
						{/await}
					</div>
				</div>
			</div>
		{/if}
	</div>
</div>
