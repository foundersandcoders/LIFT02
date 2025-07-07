<script lang="ts">
	import { getContext } from 'svelte';
	import type {
		AppState,
		Detail,
		ItemCategory,
		List,
		Profile,
		RowId,
		TableName,
		ViewName
	} from '$lib/types/appState';
	import type { Action, Question, Resource } from '$lib/types/tableMain';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestionsByCategory } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import ListItem from '$lib/components/cards/ListItem.svelte';

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	let category: ItemCategory = $derived(app.list.category);
	let profile: Profile = $derived(app.profile);
	let table: TableName | null = $derived(app.list.table);
	let queryResources = $derived(table == 'resources' ? getResources() : null);

	const setList = getContext<(list: List) => void>('setList');
	const setView = getContext<(view: ViewName) => void>('setViewName');

	// DB Queries
	let queryActions = $derived(
		table == 'actions' && profile.id ? getLatestActions(profile.id) : null
	);
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
</script>

<div id="list-view" class="flex h-full w-full flex-col overflow-hidden">
	<ViewHeader title={category.format as string} {onclick} />

	<div id="list-body" class="list justify-left m-2 flex flex-1 flex-col overflow-y-auto">
		{#if table == 'actions'}
			{#await queryActions}
				<div class="list-row prose">
					<p>Loading...</p>
				</div>
			{:then result}
				{#if result?.data}
					{#each result.data as action}
						<ListItem item={action as Action} {table} textAlign="left" />
					{/each}
				{:else}
					<div class="list-row prose">
						<p>No actions found</p>
					</div>
				{/if}
			{:catch error}
				<div class="list-row prose">
					<p>Error: {error.message}</p>
				</div>
			{/await}
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
