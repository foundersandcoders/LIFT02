<script lang="ts">
	import { getQuestionById, createResponse } from '$lib/services/database';
	import FormButton from '../ui/FormButton.svelte';
	import ToggleStatus from '../ui/ToggleStatus.svelte';
	import type { TableName, QuestionConnections, RowId, ViewName } from '$lib/types/appState';
	import { getQuestionConnections } from '$lib/utils/getContent.svelte';
	import { getContext } from 'svelte';
	import type { AppState } from '$lib/types/appState';
	import ConfirmModal from '../ui/ConfirmModal.svelte';

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
		if (!profileId) {
			throw new Error('Cannot delete response without a profile ID.');
		}

		const responseData = {
			response_text: null,
			question_id: questionId,
			status: 'skipped',
			visibility: 'private' // Force private for skipped/deleted responses
		};

		console.log('🎯 Deleting response:', responseData);
		await createResponse(profileId, responseData);
		console.log('✅ Response deleted successfully:');
	};

	// TODO This should be read from appState context
	let table: TableName = $state('responses');
	let connectionDetails = $state<QuestionConnections>({
		responseInput: null,
		actionsInput: null,
		actionType: null,
		responseId: null,
		visibility: 'private'
	});

	$inspect(connectionDetails.responseId).with((type, value) =>
		console.log(`🆔 responseId: ${type} ${value}`)
	);

	// Button State
	const isUpdate = $derived(connectionDetails.responseId !== null);

	const hasResponseContent = $derived(
		connectionDetails.responseInput !== null &&
			connectionDetails.responseInput !== undefined &&
			connectionDetails.responseInput.trim() !== ''
	);

	const hasActionContent = $derived(
		connectionDetails.actionsInput !== null &&
			connectionDetails.actionsInput !== undefined &&
			connectionDetails.actionsInput.trim() !== ''
	);

	const buttonConfig = $derived(() => {
		return isUpdate
			? { primaryText: 'Submit', secondaryText: 'Delete' }
			: { primaryText: 'Submit', secondaryText: 'Skip' };
	});

	$inspect(isUpdate).with((type, value) => console.log(`🔄 isUpdate: ${type} ${value}`));
	$inspect(hasResponseContent).with((type, value) =>
		console.log(`📝 hasResponseContent: ${type} ${value}`)
	);
	$inspect(hasActionContent).with((type, value) =>
		console.log(`📝 hasActionContent: ${type} ${value}`)
	);
	$inspect(buttonConfig().primaryText).with((type, value) =>
		console.log(`🔘 Button 1: ${type} ${value}`)
	);
	$inspect(buttonConfig().secondaryText).with((type, value) =>
		console.log(`🔘 Button 2: ${type} ${value}`)
	);

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
		connectionDetails.actionsInput = null;

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
	$inspect(visibility).with((type, value) =>
		console.log(`📝 visibility (local): ${type} ${value}`)
	);

	const toggleVisibility = () => {
		visibility = visibility === 'public' ? 'private' : 'public';
	};
</script>

<ConfirmModal
	show={showDeleteModal}
	title="Confirm Deletion"
	message="Are you sure you want to delete this response? This action cannot be undone."
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

				<ToggleStatus {visibility} {toggleVisibility} />
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
				></textarea>
			</div>

			<div id="question-{questionId}-actions" class="card-content">
				<div id="question-{questionId}-action-response" class="flex flex-col">
					<label for="question-{questionId}-action-response-text" class="form-label">
						Would you like your manager to take any actions in response to this?
					</label>

					<textarea
						id="question-{questionId}-actions-response-text"
						bind:value={connectionDetails.actionsInput}
						placeholder="Enter your response here..."
						rows="3"
						class="text-area form-textarea"
					></textarea>
				</div>
			</div>

			<div id="question-{questionId}-buttons" class="flex justify-around">
				<FormButton
					text={buttonConfig().primaryText}
					buttonType="primary"
					{table}
					{isUpdate}
					{hasResponseContent}
					{hasActionContent}
					details={connectionDetails}
					{visibility}
				/>
				<FormButton
					text={buttonConfig().secondaryText}
					buttonType="secondary"
					{table}
					{isUpdate}
					{hasResponseContent}
					{hasActionContent}
					details={connectionDetails}
					{visibility}
					onclick={isUpdate ? openDeleteModal : undefined}
				/>
			</div>
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
