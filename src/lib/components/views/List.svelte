<script lang="ts">
	import { getContext } from 'svelte';
	import type {
		AppState,
		ItemCategory,
		List,
		Profile,
		TableName,
		ViewName
	} from '$lib/types/appState';
	import type { Action, Question, Resource } from '$lib/types/tableMain';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestionsByCategory } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import ListItem from '$lib/components/cards/ListItem.svelte';
	import ShowArchivedToggle from '$lib/components/ui/ShowArchivedToggle.svelte';
	import { flip } from 'svelte/animate';

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	let category: ItemCategory = $derived(app.list.category);
	let profile: Profile = $derived(app.profile);
	let table: TableName | null = $derived(app.list.table);

	const setList = getContext<(list: List) => void>('setList');
	const setView = getContext<(view: ViewName) => void>('setViewName');

	// State for actions
	let showArchived = $state(false);
	let actionsData = $state<Action[]>([]);
	let isLoading = $state(true);
	let error = $state<Error | null>(null);

	// Fetch actions when component mounts or profile changes
	$effect(() => {
		if (table === 'actions' && profile.id) {
			isLoading = true;
			getLatestActions(profile.id, true)
				.then((result) => {
					if (result.data) {
						actionsData = result.data;
					}
					if (result.error) {
						error = result.error as Error;
					}
				})
				.finally(() => {
					isLoading = false;
				});
		}
	});

	let filteredActions = $derived(
		actionsData.filter((action) => showArchived || action.status === 'active')
	);
	$inspect(filteredActions).with((type, value) =>
		console.log(`🔍 Filtered Actions: ${type} ${value}`)
	);

	// DB Queries
	let queryResources = $derived(table == 'resources' ? getResources() : null);
	let queryQuestions = $derived(
		table == 'questions' && category.raw != null ? getQuestionsByCategory(category.raw) : null
	);

	// Event Handlers
	const onclick = () => {
		setView('dash');
		setList({
			table: null,
			category: { raw: null, format: null }
		});
	};

	const handleToggleArchived = (newShowArchived: boolean) => {
		showArchived = newShowArchived;
	};

	const updateActionStatus = (actionId: string, newStatus: 'active' | 'archived') => {
		const actionIndex = actionsData.findIndex((action) => action.id === actionId);
		if (actionIndex !== -1) {
			// Create a new array to ensure reactivity
			const newActions = [...actionsData];
			newActions[actionIndex] = { ...newActions[actionIndex], status: newStatus };
			actionsData = newActions;
		}
	};
</script>

<div id="list-view" class="view">
	<ViewHeader title={category.format as string} {onclick} />

	<div id="list-content" class="view-content">
		{#if table == 'actions'}
			<div class="mb-4 px-4">
				<ShowArchivedToggle {showArchived} onToggle={handleToggleArchived} />
			</div>
			{#if isLoading}
				<div class="list-row prose">
					<p>Loading...</p>
				</div>
			{:else if error}
				<div class="list-row prose">
					<p>Error: {error.message}</p>
				</div>
			{:else if filteredActions.length > 0}
				{#each filteredActions as action (action.id)}
					<div animate:flip={{ duration: 500 }} class="list-item-wrapper">
						<ListItem item={action as Action} {table} textAlign="left" {updateActionStatus} />
					</div>
				{/each}
			{:else}
				<div class="list-row prose">
					<p>No actions found</p>
				</div>
			{/if}
		{:else if table == 'resources'}
			{#await queryResources}
				<div class="list-row prose">
					<p>Loading...</p>
				</div>
			{:then result}
				{#if result?.data}
					{#each result.data as resource}
						<ListItem item={resource as Resource} {table} />
					{/each}
				{:else}
					<div class="list-row prose">
						<p>No resources found</p>
					</div>
				{/if}
			{:catch error}
				<div class="list-row prose">
					<p>Error: {error.message}</p>
				</div>
			{/await}
		{:else if table == 'questions' && category.raw}
			{#await queryQuestions}
				<div class="list-row prose">
					<p>Loading...</p>
				</div>
			{:then result}
				{#if result?.data}
					{#each result.data as question}
						<ListItem item={question as Question} {table} />
					{/each}
				{:else}
					<div class="list-row prose">
						<p>No questions found</p>
					</div>
				{/if}
			{:catch error}
				<div class="list-row prose">
					<p>Error: {error.message}</p>
				</div>
			{/await}
		{:else}
			<div class="list-row prose">
				<p>No list selected</p>
			</div>
		{/if}
	</div>
</div>
