<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Detail, TableName, ViewName } from '$lib/types/appState';
	import type { Action, Question, Resource } from '$lib/types/tableMain';
	import { randomNum } from '$lib/utils/random';
	import { updateAction, updateActionStatus } from '$lib/services/database/actions';
	import ActionStatusToggle from '../ui/ActionStatusToggle.svelte';
	import { getResources } from '$lib/services/database/resources';

	const getDevMode = getContext<() => boolean>('getDevMode');
	const devMode = $derived(getDevMode());

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Component Props
	let {
		item,
		table,
		textAlign = 'center'
	} = $props<{
		item: Action | Question | Resource;
		table: TableName;
		textAlign?: 'left' | 'center' | 'right';
	}>();

	// Local state for optimistic updates
	let localStatus = $state(item.status);
	let errorMessage = $state<string | null>(null);
	let showError = $state(false);

	// Context Pulls
	const setDetail = getContext<(detail: Detail) => void>('setDetail');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const onclick = (table: null | TableName, item: null | Action | Question) => {
		setViewName('detail');
		setDetail({
			table: table,
			item: {
				id: item ? item.id || null : null
			}
		});
	};

	const handleStatusToggle = async (newStatus: 'active' | 'archived', actionId: string) => {
		// Store original status for rollback
		const originalStatus = localStatus;

		// Optimistic update: immediately update local UI state
		localStatus = newStatus;

		// Perform database update
		const result = await updateActionStatus(actionId, newStatus);

		if (result.error) {
			// Rollback on error
			localStatus = originalStatus;
			console.error('Failed to update action status:', result.error);

			// Show user-friendly error feedback
			errorMessage = `Failed to update action status. Please try again.`;
			showError = true;

			// Auto-hide error after 5 seconds
			setTimeout(() => {
				showError = false;
			}, 5000);
		} else {
			console.log(`Successfully updated action ${actionId} to ${newStatus}`);
			// Clear any previous errors on success
			showError = false;
			errorMessage = null;
		}
	};
</script>

<button
	id="list-item-{item.id}"
	onclick={table === 'questions' ? () => onclick(table, item) : undefined}
	tabindex="0"
	class="list-item {table === 'questions' ? 'cursor-pointer' : 'cursor-default'}"
	disabled={table === 'actions' || table === 'resources'}
>
	<div class="list-item-row">
		<!-- [!] the status icon logic has to be replaced by db queries -->
		{#if table === 'questions'}
			<div id="list-item-{item.id}-status" class="flex items-center">
				{#if app.profile.id != '' && randomNum() > 7}
					<div id="list-item-{item.id}-status-icon" class="status-indicator-xl status-active"></div>
				{:else}
					<div
						id="list-item-{item.id}-status-icon"
						class="status-indicator-xl status-default"
					></div>
				{/if}
			</div>
		{/if}

		<div id="list-item-{item.id}-title" class="list-item-content prose text-{textAlign}">
			{#if table == 'actions'}
				<p>{item.description || 'No description'}</p>
			{:else if table == 'questions' && item}
				<p>{item.preview}</p>
			{:else if table == 'resources' && item}
				<p>{item.title}</p>
				{#if item.url}
					<a href={item.url} target="_blank" rel="noopener noreferrer" 
					   class="text-sm text-accent hover:text-accent-dark underline"
					   onclick={(e) => e.stopPropagation()}>
						{item.url}
					</a>
				{/if}
			{:else}
				{@const table = null}
				{@const item = { id: null }}
				<p>NULL</p>
			{/if}
		</div>

		<div id="list-item-{item.id}-action" class="flex flex-row items-center">
			{#if table === 'actions'}
				<ActionStatusToggle
					status={localStatus}
					onStatusChange={(newStatus) => handleStatusToggle(newStatus, item.id)}
				/>
			{:else if table === 'resources'}
				<!-- No action indicator for resources -->
			{:else if app.profile.id && randomNum() > 7}
				<div id="list-item-{item.id}-action-icon" class="status-indicator-xl status-action"></div>
			{:else}
				<div id="list-item-{item.id}-action-icon" class="status-indicator status-default"></div>
			{/if}
		</div>
	</div>
</button>

<!-- Error feedback toast -->
{#if showError && errorMessage}
	<div class="toast toast-top toast-end z-50">
		<div class="alert alert-error">
			<div class="flex items-center justify-between">
				<div class="flex items-center">
					<svg class="mr-2 h-6 w-6" fill="currentColor" viewBox="0 0 20 20">
						<path
							fill-rule="evenodd"
							d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
							clip-rule="evenodd"
						/>
					</svg>
					<span>{errorMessage}</span>
				</div>
				<button
					class="btn btn-sm btn-ghost ml-2"
					onclick={() => {
						showError = false;
						errorMessage = null;
					}}
					title="Dismiss"
				>
					✕
				</button>
			</div>
		</div>
	</div>
{/if}
