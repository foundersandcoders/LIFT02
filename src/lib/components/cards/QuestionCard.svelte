<script lang="ts">
	import { getQuestionById } from '$lib/services/database';
	import SubmitButton from '../ui/SubmitButton.svelte';
	import ToggleStatus from '../ui/ToggleStatus.svelte';
	import { getQuestionDetails } from '$lib/utils/questionDetails.svelte';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';

	let actionType = $state('');
	let questionDetails = $state<QuestionDetails>({
		responseInput: null,
		actionsInput: null,
		actionType: '',
		responseId: null
	});

	interface Props {
		questionId: string;
	}

	export interface QuestionDetails {
		responseInput: string | null;
		actionsInput: string | null;
		actionType: string;
		responseId: string | null;
	}

	let { questionId }: Props = $props();

	const getQuestionData = async () => {
		const question = await getQuestionById(questionId);
		const details = await getQuestionDetails(user_id, questionId);
		questionDetails = details;
		if (details.actionType !== '') actionType = details.actionType;

		return {
			question: question || null,
			details: details || null
		};
	};

	let visibility = $state('private');
	const toggleVisibility = () => {
		visibility = visibility === 'public' ? 'private' : 'public';
	};
</script>

{#await getQuestionData() then response}
	{#if response.question && response.question.data}
		<div class="w-fill flex flex-col justify-around m-2 p-2 space-y-4">
			<header class="mb-4 bg-base-100 rounded-xl shadow p-2">
				<h1 class="text-center text-2xl mb-2">{response.question.data.category}</h1>
				
				<ToggleStatus {visibility} {toggleVisibility} />
			</header>


			<div class="flex flex-col bg-base-100 rounded-xl shadow p-2">
				<label for="response-{questionId}" class="text-lg mb-1"
					>{response.question.data.question_text || 'Question'}</label
				>
				<textarea
					id="response-{questionId}"
					bind:value={questionDetails.responseInput}
					placeholder="Enter your response here..."
					rows="4"
					class="text-area"
				></textarea>
			</div>
			<div class="bg-base-100 rounded-xl shadow p-2">
				<h2 class="text-lg mb-1">A description of what actions are for</h2>
				<label for="action-type-{questionId}" class="text-md">Action type:</label>
				<select id="action-type-{questionId}" bind:value={actionType} class="border-2 border-primary rounded p-2 mb-2 focus:border-accent outline-none">
					<option value="default" selected >Action type</option>
					<option value="workplace_adjustment">Workplace adjustment</option>
					<option value="schedule_adjustment">Schedule adjustment</option>
					<option value="communication">Communication</option>
					<option value="schedule_flexibility">Schedule flexibility</option>
				</select>

				<div class="flex flex-col">
					<textarea
						id="actions-{questionId}"
						bind:value={questionDetails.actionsInput}
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
					{actionType}
					details={questionDetails}
					{visibility}
				/>
				<SubmitButton
					text="Submit"
					status="answered"
					{actionType}
					details={questionDetails}
					{visibility}
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
		border: solid 2px var(--color-primary);
		border-radius: 10px;
		padding: 10px;
		outline: none;
	}

	.text-area:focus {
		border: solid 2px var(--color-accent);
	}
</style>
