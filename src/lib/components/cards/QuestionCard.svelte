<script lang="ts">
	import { getQuestionById, createResponse } from '$lib/services/database';
	import { getActionsByResponseId, deleteAction } from '$lib/services/database/actions';
	import { supabase } from '$lib/services/supabaseClient';
	import ToggleStatus from '../ui/ToggleStatus.svelte';
	import SaveStatus from '../ui/SaveStatus.svelte';
	import UndoButton from '../ui/UndoButton.svelte';
	import type { QuestionConnections, RowId, ViewName } from '$lib/types/appState';
	import type { Action } from '$lib/types/tableMain';
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

	const clearDetail = () => {
		setViewName('list');
		setQuestionId(null);
	};

	const deleteResponse = async () => {
		if (!profileId || !connectionDetails.responseId) {
			throw new Error('Cannot delete response without a profile ID and response ID.');
		}

		console.log('🎯 Deleting response and all associated actions:', connectionDetails.responseId);

		try {
			// First, get all actions for this response (both active and archived)
			const actionsResult = await getActionsByResponseId(profileId, connectionDetails.responseId);

			if (actionsResult.data && actionsResult.data.length > 0) {
				console.log(`🗑️ Deleting ${actionsResult.data.length} associated actions...`);

				// Delete all actions (both active and archived)
				await Promise.all(
					actionsResult.data.map((action: Action) => {
						if (action.id) {
							console.log(`Deleting action: ${action.id} (${action.status})`);
							return deleteAction(action.id);
						}
					}).filter(Boolean)
				);
			}

			// Now delete the response itself
			const { error } = await supabase
				.from('responses')
				.delete()
				.eq('id', connectionDetails.responseId);

			if (error) {
				throw error;
			}

			console.log('✅ Response and all associated actions deleted successfully');
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
		console.groupCollapsed('🏗️ QuestionCard: getData');
		console.log('📍 Question ID:', questionId);
		console.log('👤 Profile ID:', profileId);

		const question = await getQuestionById(questionId);
		console.log('❓ Question:', question.data);

		const connections = await getQuestionConnections(profileId || '', questionId);
		console.log('📝 Connections:', connections);

		connectionDetails = connections;

		// Update visibility based on details or default to 'private'
		visibility = connections.visibility || 'private';

		const data = {
			queryId: questionId,
			question: question || null,
			details: connectionDetails || null
		};

		console.log('📤 Return:', data);
		console.groupEnd();

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


	const savePrivacySetting = async () => {
		if (!profileId || !questionId) return;

		try {
			privacySaveStatus = 'saving';
			privacySaveError = null;

			// Use existing response data but update visibility
			const responseData = {
				response_text: connectionDetails.responseInput,
				question_id: questionId,
				status: connectionDetails.responseInput ? 'answered' : 'unanswered',
				visibility
			};

			await createResponse(profileId, responseData);

			privacySaveStatus = 'saved';

			// Reset to idle after 2 seconds
			setTimeout(() => {
				if (privacySaveStatus === 'saved') {
					privacySaveStatus = 'idle';
				}
			}, 2000);
		} catch (error) {
			privacySaveStatus = 'error';
			privacySaveError = error instanceof Error ? error.message : 'Save failed';
		}
	};

	const toggleVisibility = () => {
		visibility = visibility === 'public' ? 'private' : 'public';
		savePrivacySetting();
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
			const currentText = connectionDetails.responseInput || '';

			const responseData = {
				response_text: currentText,
				question_id: questionId,
				status: currentText.trim() ? 'answered' : 'unanswered',
				visibility
			};

			await createResponse(profileId, responseData);

			// Update saved state
			lastSavedText = currentText;
			hasChanges = false;
		} catch (error) {
			console.error('Failed to save response:', error);
		} finally {
			isSaving = false;
		}
	};

	const handleUndo = () => {
		if (canUndo) {
			connectionDetails.responseInput = previousText;
			canUndo = false;
			checkForChanges(); // Check if we need to enable OK button after undo
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
			<div id="question-{questionId}-header" class="card-header">
				<h3>{data.question.data.preview}</h3>

				<div class="flex flex-col gap-1">
					<ToggleStatus {visibility} {toggleVisibility} />
					<SaveStatus status={privacySaveStatus} error={privacySaveError} />
				</div>
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

				<div class="flex items-center gap-2 mt-2">
					<button
						onclick={saveResponse}
						disabled={!hasChanges || isSaving}
						class="btn-submit btn-sm"
						title="Save response to database"
					>
						{#if isSaving}
							<span class="loading loading-spinner loading-xs"></span>
							Saving...
						{:else}
							OK
						{/if}
					</button>
					<UndoButton canUndo={canUndo} onclick={handleUndo} />
				</div>
			</div>

			<div id="question-{questionId}-actions" class="card-content">
				<ActionsCRUD responseId={connectionDetails.responseId} />
			</div>

			{#if connectionDetails.responseId}
				<div class="flex justify-end mx-4 mb-4 mt-2">
					<button
						onclick={openDeleteModal}
						class="btn btn-error btn-sm"
						title="Delete this response and all related actions"
					>
						Delete Response & Actions
					</button>
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
