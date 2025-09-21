<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Detail, TableName, ViewName } from '$lib/types/appState';
	import type { Action, Question, Resource, Response } from '$lib/types/tableMain';
	import { randomNum } from '$lib/utils/random';
	import {
		updateAction,
		updateActionStatus as updateActionStatus_DB
	} from '$lib/services/database/actions';
	import { getLatestResponses } from '$lib/services/database/responses';
	import { getActionsByResponseIds } from '$lib/services/database/actions';
	import ActionStatusToggle from '../ui/ActionStatusToggle.svelte';
	import { fade } from 'svelte/transition';
	import Tooltip from '../ui/Tooltip.svelte';

	const getDevMode = getContext<() => boolean>('getDevMode');
	const devMode = $derived(getDevMode());

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Component Props
	let {
		item,
		table,
		textAlign = 'center',
		updateActionStatus
	} = $props<{
		item: Action | Question | Resource;
		table: TableName;
		textAlign?: 'left' | 'center' | 'right';
		updateActionStatus?: (actionId: string, newStatus: 'active' | 'archived') => void;
	}>();

	// Local state for optimistic updates
	let localStatus = $state(item.status);
	let errorMessage = $state<string | null>(null);
	let showError = $state(false);

	// Database queries for status indicators (only for questions with logged-in user)
	let userResponses = $derived(
		table === 'questions' && app.profile.id ? getLatestResponses(app.profile.id) : null
	);

	// Find the user's response for this question
	let questionResponse = $derived.by(() => {
		if (table !== 'questions' || !app.profile.id || !userResponses) return null;

		// Wait for userResponses to resolve
		return userResponses.then((result) => {
			if (!result.data) return null;
			return result.data.find((response) => response.question_id === item.id) || null;
		});
	});

	// Get actions for the user's response
	let responseActions = $derived.by(() => {
		if (table !== 'questions' || !app.profile.id || !questionResponse) return null;

		return questionResponse.then((response) => {
			if (!response) return null;
			return getActionsByResponseIds([response.id!]);
		});
	});

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

		// Optimistic update: immediately update local UI state and parent data
		localStatus = newStatus;
		if (updateActionStatus && item.id) {
			updateActionStatus(item.id, newStatus);
		}

		// Perform database update
		const result = await updateActionStatus_DB(actionId, newStatus);

		if (result.error) {
			// Rollback on error
			localStatus = originalStatus;
			if (updateActionStatus && item.id) {
				updateActionStatus(item.id, originalStatus);
			}
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
	class="list-item {table === 'questions' ? 'cursor-pointer' : 'cursor-default'}"
	onclick={table === 'questions' ? () => onclick(table, item) : undefined}
	tabindex="0"
	disabled={table === 'actions' || table === 'resources'}
	transition:fade={{ duration: 300 }}
>
	<div
		id="list-item-{item.id}-row"
		class="flex w-full {table === 'questions' ? 'flex-row items-center justify-between' : table === 'resources' ? 'flex-row items-center justify-center' : 'flex-col items-start md:flex-row md:items-center md:justify-between'}"
	>
		{#if table === 'actions'}
			<!-- Text content for actions, stacked vertically -->
			<div class="flex flex-col">
				<p class="action-question-preview text-left">
					{item.question_preview || 'Question not found'}
				</p>
				<p class="action-description text-left font-bold">
					{item.description || 'No description'}
				</p>
			</div>
			<!-- Toggle with responsive margin -->
			<div id="list-item-{item.id}-action" class="mt-4 self-end md:mt-0 md:self-center">
				<ActionStatusToggle
					status={localStatus}
					onStatusChange={(newStatus) => handleStatusToggle(newStatus, item.id)}
				/>
			</div>
		{:else}
			<!-- Original layout for other table types -->
			<!-- Status Icon -->
			{#if table === 'questions'}
				<div id="list-item-{item.id}-status" class="flex items-center">
					{#if app.profile.id}
						{#await questionResponse}
							<Tooltip text="Question already answered or skipped" position="right">
								<div
									id="list-item-{item.id}-status-icon"
									class="status-indicator-lg status-default flex items-center justify-center"
								>
									<span class="text-white text-xs">✓</span>
								</div>
							</Tooltip>
						{:then response}
							{@const hasValidStatus =
								response && response.status && ['answered', 'skipped'].includes(response.status)}
							{#if hasValidStatus}
								<!-- Grey -->
								<Tooltip text="Question already answered or skipped" position="right">
									<div
										id="list-item-{item.id}-status-icon"
										class="status-indicator-lg status-default flex items-center justify-center"
									>
										<span class="text-white text-xs">✓</span>
									</div>
								</Tooltip>
							{:else}
								<!-- Magenta -->
								<Tooltip text="Question requires attention from user" position="right">
									<div
										id="list-item-{item.id}-status-icon"
										class="status-indicator-lg status-active flex items-center justify-center"
									>
										<span class="text-white text-xs">?</span>
									</div>
								</Tooltip>
							{/if}
						{:catch}
							<Tooltip text="Question already answered or skipped" position="right">
								<div
									id="list-item-{item.id}-status-icon"
									class="status-indicator-lg status-default flex items-center justify-center"
								>
									<span class="text-white text-xs">✓</span>
								</div>
							</Tooltip>
						{/await}
					{:else}
						<Tooltip text="Question already answered or skipped" position="right">
							<div
								id="list-item-{item.id}-status-icon"
								class="status-indicator-lg status-default flex items-center justify-center"
							>
								<span class="text-white text-xs">✓</span>
							</div>
						</Tooltip>
					{/if}
				</div>
			{/if}

			<div
				id="list-item-{item.id}-title"
				class="list-item-content prose text-{textAlign} {table === 'actions' ? 'max-w-none' : ''}"
			>
				{#if table == 'questions' && item}
					<p class="truncate">{item.preview}</p>
				{:else if table == 'resources' && item}
					<p class="break-words">{item.title}</p>
					{#if item.url}
						<a
							href={item.url}
							target="_blank"
							rel="noopener noreferrer"
							class="text-accent hover:text-accent-dark text-sm underline break-all"
							onclick={(e) => e.stopPropagation()}
						>
							{item.url}
						</a>
					{/if}
				{:else}
					{@const table = null}
					{@const item = { id: null }}
					<p>NULL</p>
				{/if}
			</div>

			<!-- Action Toggle -->
			<div id="list-item-{item.id}-action" class="flex flex-row items-center">
				<!-- No toggle for non-action items -->
			</div>
		{/if}
	</div>
</button>

<!-- Error Feedback Toast -->
{#if showError && errorMessage}
	<div class="toast toast-top toast-end z-50" role="alert" aria-live="polite">
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
