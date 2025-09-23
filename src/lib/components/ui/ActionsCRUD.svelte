<script lang="ts">
	import { getContext } from 'svelte';
	import {
		createAction,
		updateAction,
		archiveAction,
		getActionsByResponseId
	} from '$lib/services/database/actions';
	import type { Action } from '$lib/types/tableMain';
	import type { AppState } from '$lib/types/appState';
	import ConfirmModal from './ConfirmModal.svelte';

	interface Props {
		responseId: string | null;
	}

	let { responseId }: Props = $props();

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const profileId = $derived(app.profile.id);

	// Component state
	let actions = $state<Action[]>([]);
	let isLoading = $state(false);
	let editingActionId = $state<string | null>(null);
	let showDeleteModal = $state(false);
	let actionToDelete = $state<string | null>(null);

	// New action form state
	let newActionDescription = $state('');
	let showNewActionForm = $state(false);

	// Edit action form state
	let editDescription = $state('');

	// Debouncing and validation states
	let isCreating = $state(false);
	let isUpdating = $state(false);
	let newActionError = $state('');
	let editActionError = $state('');

	// Load actions when responseId changes
	$effect(() => {
		if (responseId && profileId) {
			loadActions();
		}
	});

	async function loadActions() {
		if (!responseId || !profileId) return;

		isLoading = true;
		try {
			const result = await getActionsByResponseId(profileId, responseId);
			if (result.data) {
				// Show only active actions (multiple actions per response now supported)
				actions = result.data.filter((action: Action) => action.status === 'active');
			}
		} catch (error) {
			console.error('Failed to load actions:', error);
		} finally {
			isLoading = false;
		}
	}

	function validateActionDescription(description: string): string {
		const trimmed = description.trim();
		if (!trimmed) {
			return 'Action description is required';
		}
		if (trimmed.length < 3) {
			return 'Action description must be at least 3 characters';
		}
		if (trimmed.length > 500) {
			return 'Action description must be less than 500 characters';
		}
		return '';
	}

	async function handleCreateAction() {
		if (!profileId || isCreating) return;

		// Clear previous error
		newActionError = '';

		// Validate description
		const validationError = validateActionDescription(newActionDescription);
		if (validationError) {
			newActionError = validationError;
			return;
		}

		// Prevent multiple concurrent requests
		isCreating = true;

		try {
			const actionData = {
				description: newActionDescription.trim(),
				type: 'general', // Default type for now
				response_id: responseId || undefined
			};

			const result = await createAction(profileId, actionData);
			if (result.data) {
				actions = [...actions, result.data];
				// Reset form
				newActionDescription = '';
				newActionError = '';
				showNewActionForm = false;
			}
		} catch (error) {
			console.error('Failed to create action:', error);
			newActionError = 'Failed to create action. Please try again.';
		} finally {
			isCreating = false;
		}
	}

	function startEdit(action: Action) {
		if (!action.id) return; // Don't edit actions without IDs
		editingActionId = action.id;
		editDescription = action.description || '';
	}

	function cancelEdit() {
		editingActionId = null;
		editDescription = '';
		editActionError = '';
	}

	async function handleUpdateAction() {
		if (!editingActionId || isUpdating) return;

		// Clear previous error
		editActionError = '';

		// Validate description
		const validationError = validateActionDescription(editDescription);
		if (validationError) {
			editActionError = validationError;
			return;
		}

		// Prevent multiple concurrent requests
		isUpdating = true;

		try {
			const updateData = {
				description: editDescription.trim(),
				type: 'general' // Keep existing type logic for now
			};

			const result = await updateAction(editingActionId, updateData);
			if (result.data) {
				// Update the action in the list
				actions = actions.map((action) => (action.id === editingActionId ? result.data! : action));
				cancelEdit();
			}
		} catch (error) {
			console.error('Failed to update action:', error);
			editActionError = 'Failed to update action. Please try again.';
		} finally {
			isUpdating = false;
		}
	}

	function confirmDelete(actionId: string) {
		actionToDelete = actionId;
		showDeleteModal = true;
	}

	async function handleDeleteAction() {
		if (!actionToDelete) return;

		try {
			await archiveAction(actionToDelete);
			// Remove from the list
			actions = actions.filter((action) => action.id !== actionToDelete);
			closeDeleteModal();
		} catch (error) {
			console.error('Failed to delete action:', error);
		}
	}

	function closeDeleteModal() {
		showDeleteModal = false;
		actionToDelete = null;
	}
</script>

<ConfirmModal
	show={showDeleteModal}
	title="Delete Action"
	message="Are you sure you want to delete this action? This action cannot be undone."
	onConfirm={handleDeleteAction}
	onCancel={closeDeleteModal}
/>

<div class="actions-crud">
	<div class="actions-header">
		<h4 class="form-label">
			Manage actions you'd like your manager to take in response to this question.
		</h4>
	</div>

	<!-- Existing Actions List -->
	{#if isLoading}
		<div class="loading-state">Loading actions...</div>
	{:else if actions.length > 0}
		<div class="actions-list">
			{#each actions as action (action.id)}
				<div class="action-item">
					{#if editingActionId === action.id}
						<!-- Edit Mode -->
						<div class="action-edit-form">
							<textarea
								bind:value={editDescription}
								placeholder="Action description"
								rows="2"
								class="action-description-input"
								class:border-error={editActionError}
							></textarea>
							{#if editActionError}
								<div class="text-error mt-1 text-sm">{editActionError}</div>
							{/if}
							<div class="action-edit-buttons">
								<button
									onclick={handleUpdateAction}
									class="btn-submit btn-sm"
									disabled={isUpdating}
								>
									{#if isUpdating}
										<span class="loading loading-spinner loading-xs"></span>
										Saving...
									{:else}
										Save
									{/if}
								</button>
								<button onclick={cancelEdit} class="btn btn-sm" disabled={isUpdating}>
									Cancel
								</button>
							</div>
						</div>
					{:else}
						<!-- View Mode -->
						<div class="action-view">
							<p class="action-description">{action.description}</p>
							<div class="action-meta">
								{#if action.created_at}
									<span class="action-date">
										Created {new Date(action.created_at).toLocaleDateString()}
									</span>
								{/if}
								<div class="action-buttons">
									{#if action.id}
										<button
											onclick={() => startEdit(action)}
											class="btn btn-sm"
											aria-label="Edit action"
										>
											Edit
										</button>
									{/if}
									{#if action.id}
										<button
											onclick={() => confirmDelete(action.id!)}
											class="btn btn-sm btn-error"
											aria-label="Delete action"
										>
											Delete
										</button>
									{/if}
								</div>
							</div>
						</div>
					{/if}
				</div>
			{/each}
		</div>
	{:else}
		<div class="no-actions">
			<p class="text-base-content/60 text-sm">No actions yet. Add one below.</p>
		</div>
	{/if}

	<!-- Add New Action -->
	{#if showNewActionForm}
		<div class="new-action-form">
			<textarea
				bind:value={newActionDescription}
				placeholder="Describe the action you'd like your manager to take..."
				rows="3"
				class="action-description-input"
				class:border-error={newActionError}
			></textarea>
			{#if newActionError}
				<div class="text-error mt-1 text-sm">{newActionError}</div>
			{/if}
			<div class="new-action-buttons">
				<button onclick={handleCreateAction} class="btn-submit btn-sm" disabled={isCreating}>
					{#if isCreating}
						<span class="loading loading-spinner loading-xs"></span>
						Creating...
					{:else}
						Add Action
					{/if}
				</button>
				<button
					onclick={() => {
						showNewActionForm = false;
						newActionError = '';
						newActionDescription = '';
					}}
					class="btn btn-sm"
					disabled={isCreating}
				>
					Cancel
				</button>
			</div>
		</div>
	{:else}
		<button
			onclick={() => (showNewActionForm = true)}
			class="btn-submit btn-sm"
		>
			Add Action
		</button>
	{/if}
</div>
