<script lang="ts">
	import { getQuestionById } from '$lib/services/database';
	import SubmitButton from '../ui/SubmitButton.svelte';
	import ToggleStatus from '../ui/ToggleStatus.svelte';
	import { getQuestionDetails } from '$lib/utils/questionDetails';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';

	interface Props {
		questionId: string;
	}

	export interface QuestionDetails {
		responseInput: string | null;
		actionsInput: string | null;
		actionType: string | null;
		responseId: string | null;
	}

	let { questionId }: Props = $props();

	const getQuestionData = async () => {
		const question = await getQuestionById(questionId);
		const questionDetails = await getQuestionDetails(user_id, questionId);

		return {
			question: question || null,
			details: questionDetails || null
		};
	};

	let visibility = $state('private');
	const toggleVisibility = () => {
		visibility = visibility === 'public' ? 'private' : 'public';
	};
</script>

{#await getQuestionData() then response}
	{#if response.question && response.question.data}
		<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
			<header>
				<h1 class="text-center text-2xl">{response.question.data.category}</h1>
			</header>

			<ToggleStatus {visibility} {toggleVisibility} />

			<div class="flex flex-col">
				<label for="response-{questionId}" class="text-xl"
					>{response.question.data.question_text || 'Question'}</label
				>
				<textarea
					id="response-{questionId}"
					bind:value={response.details.responseInput}
					placeholder="Enter your response here..."
					rows="4"
					class="text-area"
				></textarea>
			</div>

			<div>
				<h2 class="text-xl">A description of what actions are for</h2>
				<label for="cars">Action type:</label>
				<select id="action-type-{questionId}" bind:value={response.details.actionType}>
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
						bind:value={response.details.actionsInput}
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
					{response.details}
					{visibility}
				/>
				<SubmitButton
					text="Submit"
					status="answered"
					{response.details}
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
		border: solid 2px var(--pink);
		border-radius: 10px;
		padding: 10px;
		outline: none;
	}

	.text-area:focus {
		border: solid 2px var(--teal);
	}
</style>
