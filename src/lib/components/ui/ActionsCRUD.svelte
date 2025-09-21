<script lang="ts">
	import { getContext } from 'svelte';
	import { createAction, updateAction, archiveAction, getActionHistory } from '$lib/services/database/actions';
	import type { Action } from '$lib/types/tableMain';
	import type { AppState } from '$lib/types/appState';
	import ConfirmModal from './ConfirmModal.svelte';

	interface Props {
		responseId: string | null;
		questionId: string;
	}

	let { responseId, questionId }: Props = $props();

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
	let newActionType = $state('');
	let showNewActionForm = $state(false);

	// Edit action form state
	let editDescription = $state('');
	let editType = $state('');

	// Load actions when responseId changes
	$effect(async () => {
		if (responseId && profileId) {
			await loadActions();
		}
	});

	async function loadActions() {
		if (!responseId || !profileId) return;

		isLoading = true;
		try {
			const result = await getActionHistory(profileId, responseId);
			if (result.data) {
				// Filter to get only the latest version of each action (active ones)
				const latestActions = result.data.filter(action => action.status === 'active');
				actions = latestActions;
			}
		} catch (error) {
			console.error('Failed to load actions:', error);
		} finally {
			isLoading = false;
		}
	}

	async function handleCreateAction() {
		if (!profileId || !newActionDescription.trim()) return;

		try {
			const actionData = {
				description: newActionDescription,
				type: newActionType || 'general',
				response_id: responseId || undefined
			};

			const result = await createAction(profileId, actionData);
			if (result.data) {
				actions = [...actions, result.data];
				// Reset form
				newActionDescription = '';
				newActionType = '';
				showNewActionForm = false;
			}
		} catch (error) {
			console.error('Failed to create action:', error);
		}
	}

	function startEdit(action: Action) {
		editingActionId = action.id || null;
		editDescription = action.description || '';
		editType = action.type || '';
	}

	function cancelEdit() {
		editingActionId = null;
		editDescription = '';
		editType = '';
	}

	async function handleUpdateAction() {
		if (!editingActionId || !editDescription.trim()) return;

		try {
			const updateData = {
				description: editDescription,
				type: editType
			};

			const result = await updateAction(editingActionId, updateData);
			if (result.data) {
				// Update the action in the list
				actions = actions.map(action =>
					action.id === editingActionId ? result.data! : action
				);
				cancelEdit();
			}
		} catch (error) {
			console.error('Failed to update action:', error);
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
			actions = actions.filter(action => action.id !== actionToDelete);
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
		<label class="form-label">Actions for your manager</label>
		<p class="text-sm text-base-content/70 mb-3">
			Manage actions you'd like your manager to take in response to this question.
		</p>
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
							<input
								type="text"
								bind:value={editType}
								placeholder="Action type (optional)"
								class="action-type-input"
							/>
							<textarea
								bind:value={editDescription}
								placeholder="Action description"
								rows="2"
								class="action-description-input"
							></textarea>
							<div class="action-edit-buttons">
								<button onclick={handleUpdateAction} class="btn-submit btn-sm">
									Save
								</button>
								<button onclick={cancelEdit} class="btn btn-sm">
									Cancel
								</button>
							</div>
						</div>
					{:else}
						<!-- View Mode -->
						<div class="action-view">
							<div class="action-content">
								{#if action.type && action.type !== 'general'}
									<span class="action-type">{action.type}</span>
								{/if}
								<p class="action-description">{action.description}</p>
								{#if action.created_at}
									<span class="action-date">
										Created {new Date(action.created_at).toLocaleDateString()}
									</span>
								{/if}
							</div>
							<div class="action-buttons">
								<button
									onclick={() => startEdit(action)}
									class="btn btn-sm"
									aria-label="Edit action"
								>
									Edit
								</button>
								<button
									onclick={() => confirmDelete(action.id || '')}
									class="btn btn-sm btn-error"
									aria-label="Delete action"
								>
									Delete
								</button>
							</div>
						</div>
					{/if}
				</div>
			{/each}
		</div>
	{:else}
		<div class="no-actions">
			<p class="text-sm text-base-content/60">No actions yet. Add one below.</p>
		</div>
	{/if}

	<!-- Add New Action -->
	{#if showNewActionForm}
		<div class="new-action-form">
			<input
				type="text"
				bind:value={newActionType}
				placeholder="Action type (optional)"
				class="action-type-input"
			/>
			<textarea
				bind:value={newActionDescription}
				placeholder="Describe the action you'd like your manager to take..."
				rows="3"
				class="action-description-input"
			></textarea>
			<div class="new-action-buttons">
				<button onclick={handleCreateAction} class="btn-submit btn-sm">
					Add Action
				</button>
				<button onclick={() => showNewActionForm = false} class="btn btn-sm">
					Cancel
				</button>
			</div>
		</div>
	{:else}
		<button
			onclick={() => showNewActionForm = true}
			class="btn btn-outline btn-sm add-action-btn"
		>
			+ Add Action
		</button>
	{/if}
</div>