<script lang="ts">
	import { getQuestionById, upsertResponse, updateResponse } from '$lib/services/database';
	import { supabase } from '$lib/services/supabaseClient';
	import ToggleStatus from '../ui/ToggleStatus.svelte';
	import UndoButton from '../ui/UndoButton.svelte';
	import Tooltip from '../ui/Tooltip.svelte';
	import type { QuestionConnections, RowId, ViewName } from '$lib/types/appState';
	import { getQuestionConnections } from '$lib/utils/getContent.svelte';
	import { getContext } from 'svelte';
	import type { AppState } from '$lib/types/appState';
	import ConfirmModal from '../ui/ConfirmModal.svelte';
	import ActionsCRUD from '../ui/ActionsCRUD.svelte';

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const profileId = $derived(app.profile.id);

	let showDeleteModal = $state(false);

	const openDeleteModal = () => {
		showDeleteModal = true;
	};

	const closeDeleteModal = () => {
		showDeleteModal = false;
	};

	const setQuestionId = getContext<(newDetail: RowId | null) => void>('setDetailItemId');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');
	const triggerResponsesChanged = getContext<() => void>('triggerResponsesChanged');

	const clearDetail = () => {
		setViewName('list');
		setQuestionId(null);
	};

	const deleteResponse = async () => {
		if (!profileId || !connectionDetails.responseId) {
			throw new Error('Cannot delete response without a profile ID and response ID.');
		}

		try {
			// Delete response - CASCADE will automatically delete associated actions
			const { error } = await supabase
				.from('responses')
				.delete()
				.eq('id', connectionDetails.responseId);

			if (error) {
				throw error;
			}
		} catch (error) {
			console.error('❌ Failed to delete response:', error);
			throw error;
		}
	};

	let connectionDetails = $state<QuestionConnections>({
		responseInput: null,
		responseId: null,
		visibility: 'private'
	});

	interface Props {
		questionId: string;
	}

	let { questionId }: Props = $props();

	const getData = async () => {
		const question = await getQuestionById(questionId);
		const connections = await getQuestionConnections(profileId || '', questionId);

		connectionDetails = connections;

		// Update visibility based on details or default to 'private'
		visibility = connections.visibility || 'private';

		const data = {
			queryId: questionId,
			question: question || null,
			details: connectionDetails || null
		};

		return data;
	};

	let visibility = $state('private');
	let privacySaveStatus = $state<'idle' | 'saving' | 'saved' | 'error'>('idle');
	let privacySaveError = $state<string | null>(null);

	// Simple undo functionality
	let previousText = $state<string>('');
	let canUndo = $state(false);

	// Save state tracking
	let lastSavedText = $state<string>('');
	let hasChanges = $state(false);
	let isSaving = $state(false);
	let saveError = $state<string | null>(null);
	let saveSuccess = $state(false);

	// Helper function to save or update response using upsert pattern
	const saveOrUpdateResponse = async (responseData: any) => {
		if (!profileId || !questionId) return null;

		// Use upsert function which handles create or update automatically
		const result = await upsertResponse(profileId, questionId, responseData);
		return result;
	};

	const savePrivacySetting = async (newVisibility: string) => {
		if (!profileId || !questionId) return { success: false };

		try {
			privacySaveStatus = 'saving';
			privacySaveError = null;

			// Use simplified updateResponse function
			const result = await updateResponse(profileId, questionId, { visibility: newVisibility });

			if (!result.data) {
				throw new Error('Failed to update visibility');
			}

			privacySaveStatus = 'saved';

			// Trigger re-check of email button enablement
			triggerResponsesChanged();

			// Reset to idle after 2 seconds
			setTimeout(() => {
				if (privacySaveStatus === 'saved') {
					privacySaveStatus = 'idle';
				}
			}, 2000);

			return { success: true };
		} catch (error) {
			privacySaveStatus = 'error';
			privacySaveError = error instanceof Error ? error.message : 'Save failed';
			return { success: false };
		}
	};

	const toggleVisibility = async () => {
		const previousVisibility = visibility;
		const newVisibility = visibility === 'public' ? 'private' : 'public';

		// Optimistic update - change UI immediately
		visibility = newVisibility;

		try {
			const result = await savePrivacySetting(newVisibility);

			if (!result.success) {
				// Rollback on failure
				visibility = previousVisibility;
			}
		} catch (error) {
			// Rollback on error
			visibility = previousVisibility;
			console.error('Failed to toggle visibility:', error);
		}
	};

	// Initialize when user focuses (starts editing)
	const saveTextOnFocus = () => {
		const currentText = connectionDetails.responseInput || '';
		previousText = currentText;
		// Initialize lastSavedText if not set (first time)
		if (lastSavedText === '') {
			lastSavedText = currentText;
		}
		canUndo = false; // No undo available yet
		checkForChanges();
	};

	// Check for changes and enable undo when user types
	const handleInput = () => {
		canUndo = true;
		saveError = null; // Clear error when user starts typing
		checkForChanges();
	};

	// Check if current text differs from last saved
	const checkForChanges = () => {
		const currentText = connectionDetails.responseInput || '';
		hasChanges = currentText !== lastSavedText;
	};

	// Save response to database
	const saveResponse = async () => {
		if (!profileId || !questionId || isSaving) return;

		try {
			isSaving = true;
			saveError = null; // Clear any previous errors
			const currentText = connectionDetails.responseInput || '';

			// Prevent saving empty responses
			if (!currentText.trim()) {
				saveError = 'Response cannot be empty';
				// Auto-restore previous text to help user
				if (canUndo) {
					handleUndo();
				}
				return;
			}

			const responseData = {
				response_text: currentText,
				question_id: questionId,
				status: currentText.trim() ? 'answered' : 'unanswered',
				visibility
			};

			const result = await saveOrUpdateResponse(responseData);

			if (result?.data?.id) {
				// Update the connectionDetails with the response ID
				connectionDetails.responseId = result.data.id;
			}

			// Update saved state
			lastSavedText = currentText;
			hasChanges = false;
			saveSuccess = true;

			// Trigger re-check of email button enablement
			triggerResponsesChanged();

			// Clear success message after 2 seconds
			setTimeout(() => {
				saveSuccess = false;
			}, 2000);
		} catch (error) {
			console.error('Failed to save response:', error);
			saveError = 'Failed to save response. Please try again.';
		} finally {
			isSaving = false;
		}
	};

	const handleUndo = () => {
		if (canUndo) {
			connectionDetails.responseInput = previousText;
			canUndo = false;
			checkForChanges(); // Check if we need to enable Save button after undo
		}
	};

	const handleKeydown = (event: KeyboardEvent) => {
		const isMac = navigator.userAgent.toUpperCase().indexOf('MAC') >= 0;
		const ctrlKey = isMac ? event.metaKey : event.ctrlKey;

		if (ctrlKey && event.key === 'z' && !event.shiftKey) {
			event.preventDefault();
			handleUndo();
		}
	};
</script>

<ConfirmModal
	show={showDeleteModal}
	title="Delete Response & Actions"
	message="Are you sure you want to delete this response and all related actions? This action cannot be undone."
	onConfirm={deleteResponse}
	onSuccess={clearDetail}
	onCancel={closeDeleteModal}
/>

<section id="question-{questionId}" class="view-layout">
	{#await getData()}
		<div id="question-{questionId}-header" class="card-header">
			<h3>Loading...</h3>
		</div>
	{:then data}
		{#if data.question && data.question.data}
			<!-- Question Title -->
			<div class="px-4 pt-4">
				<h3>{data.question.data.preview}</h3>
			</div>

			<!-- Privacy Section -->
			<div>
				<ToggleStatus
					{visibility}
					{toggleVisibility}
					disabled={!connectionDetails.responseId}
					saveStatus={privacySaveStatus}
					saveError={privacySaveError}
				/>
			</div>

			<div id="question-{questionId}-response" class="card-content flex flex-col">
				<label for="question-{questionId}-response-input" class="form-label">
					{data.question.data.question_text || 'Question'}
				</label>

				<textarea
					id="question-{questionId}-response-input"
					class="text-area form-textarea"
					rows="4"
					bind:value={connectionDetails.responseInput}
					onfocus={saveTextOnFocus}
					oninput={handleInput}
					onkeydown={handleKeydown}
				></textarea>

				<div class="mt-2 flex items-center gap-2">
					<Tooltip text="Save response to database" position="top_right">
						<button
							onclick={saveResponse}
							disabled={!hasChanges || isSaving}
							class="btn-submit btn-sm"
						>
							Save
						</button>
					</Tooltip>
					<UndoButton {canUndo} onclick={handleUndo} />
					{#if saveSuccess}
						<span class="text-success text-sm font-medium">Saved</span>
					{/if}
				</div>
				{#if saveError}
					<div class="text-error mt-2 text-sm">
						{saveError}
					</div>
				{/if}
			</div>

			<div id="question-{questionId}-actions" class="card-content">
				<ActionsCRUD responseId={connectionDetails.responseId} />
			</div>

			{#if connectionDetails.responseId}
				<div class="mx-4 mt-2 mb-4 flex justify-end">
					<Tooltip text="Delete this response and all related actions" position="left">
						<button onclick={openDeleteModal} class="btn btn-error btn-sm">
							Delete Response & Actions
						</button>
					</Tooltip>
				</div>
			{/if}
		{:else}
			<section
				id="question-not-found"
				class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl"
			>
				<p>No question found with ID {data.queryId}</p>
			</section>
		{/if}
	{:catch error}
		<section
			id="db-query-error"
			class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl"
		>
			<p>DB Query Error: {error.message}</p>
		</section>
	{/await}
</section>
