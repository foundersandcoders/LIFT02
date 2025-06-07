<script lang="ts">
	import { getQuestionById } from '$lib/services/database';
	import SubmitButton from './SubmitButton.svelte';
	import type { DbResult } from '$lib/services/database/types';
	import type { Database } from '$lib/types/supabase';

	type Question = Database['public']['Tables']['questions']['Row'];

	interface Props {
		questionId: string;
	}

	let { questionId }: Props = $props();

	let responseInput = $state('');
	let actionsInput = $state('');
	let actionType = $state('');
	$inspect(actionType);

	const getQuestion = async (): DbResult<Question> => {
		return await getQuestionById(questionId);
	};
</script>

{#await getQuestion() then question}
	{#if question.data}
		<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
			<header>
				<h1 class="text-center text-2xl">{question.data.category}</h1>
			</header>

			<div class="flex flex-col">
				<label for="response-{questionId}" class="text-xl"
					>{question.data.question_text || 'Question'}</label
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
				<SubmitButton text="Skip" {responseInput} {actionsInput} {actionType} />
				<SubmitButton text="Submit" {responseInput} {actionsInput} {actionType} />
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
