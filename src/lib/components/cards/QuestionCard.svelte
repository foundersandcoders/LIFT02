<script lang="ts">
	import { getQuestionById } from '$lib/services/database';
	import SubmitButton from '../buttons/SubmitButton.svelte';
	import type { DbResult } from '$lib/services/database/types';
	import type { Database } from '$lib/types/supabase';
	import { getLatestResponses } from '$lib/services/database/responses';
	import { getLatestActions } from '$lib/services/database';
	import ToggleStatus from '../buttons/ToggleStatus.svelte';

	type Question = Database['public']['Tables']['questions']['Row'];

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';

	interface Props {
		questionId: string;
	}

	let { questionId }: Props = $props();

	const getData = async () => {
		const question = await getQuestionById(questionId);
		const previousResponse = await getLatestResponse();

		if (previousResponse) responseInput = previousResponse;

		return {
			question: question || null,
			previousResponse: previousResponse || null
		};
	};

	const getLatestResponse = async () => {
		const response = await getLatestResponses(user_id);
		if (response?.data) {
			const questionResponse = response.data.find((r) => r.question_id === questionId);
			const previousAction = await getLatestAction(questionResponse?.id);
			if (previousAction?.description) {
				actionsInput = previousAction.description;
				actionType = previousAction.type;
			}
			if (questionResponse?.visibility) isPublic = questionResponse?.visibility;
			if (questionResponse?.id) responseId = questionResponse?.id;
			return questionResponse?.response_text;
		}
		return null;
	};
	let responseInput = $state('');
	let responseId = $state('');

	const getLatestAction = async (response_Id: string | undefined) => {
		const response = await getLatestActions(user_id);
		if (response?.data) {
			const actionResponse = response.data.find((r) => r.response_id === response_Id);
			return actionResponse;
		}
		return null;
	};
	let actionType = $state('');
	let actionsInput = $state('');
	let isPublic = $state('private');
	$inspect(isPublic);

	const toggleVisibility = () => {
		isPublic = isPublic === 'public' ? 'private' : 'public';
	};
</script>

{#await getData() then response}
	{#if response.question && response.question.data}
		<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
			<header>
				<h1 class="text-center text-2xl">{response.question.data.category}</h1>
			</header>

			<ToggleStatus {isPublic} {toggleVisibility} />

			<div class="flex flex-col">
				<label for="response-{questionId}" class="text-xl"
					>{response.question.data.question_text || 'Question'}</label
				>
				<textarea
					id="response-{questionId}"
					bind:value={responseInput}
					placeholder="Enter your response here..."
					rows="4"
					class="text-area"
				></textarea>
			</div>

			<div>
				<h2 class="text-xl">A description of what actions are for</h2>
				<label for="cars">Action type:</label>
				<select id="action-type-{questionId}" bind:value={actionType}>
					<option>Action type</option>
					<option value="workplace_adjustment">Workplace adjustment</option>
					<option value="schedule_adjustment">Schedule adjustment</option>
					<option value="communication">Communication</option>
					<option value="schedule_flexibility">Schedule flexibility</option>
				</select>

				<div class="flex flex-col">
					<label for="actions-{questionId}">Actions needed:</label>
					<textarea
						id="actions-{questionId}"
						bind:value={actionsInput}
						placeholder="Enter your response here..."
						rows="3"
						class="text-area"
					></textarea>
				</div>
			</div>

			<div class="flex justify-around">
				<SubmitButton
					text="Skip"
					status="skipped"
					{responseInput}
					{actionsInput}
					{actionType}
					{isPublic}
					{responseId}
				/>
				<SubmitButton
					text="Submit"
					status="answered"
					{responseInput}
					{actionsInput}
					{actionType}
					{isPublic}
					{responseId}
				/>
			</div>
		</div>
	{:else}
		<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
			Sorry! We can't load you're questions right now. Please try again later.
		</div>
	{/if}
{/await}

<style>
	.text-area {
		border: solid 2px var(--pink);
		border-radius: 10px;
		padding: 10px;
		outline: none;
	}

	.text-area:focus {
		border: solid 2px var(--teal);
	}
</style>
