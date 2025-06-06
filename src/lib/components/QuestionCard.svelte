<script lang="ts">
	import { getQuestionById } from '$lib/services/database';

	interface Props {
		questionId: string;
	}

	interface QuestionData {
		data: {
			id: string;
			category: string;
			question_text: string;
			order: number;
		} | null;
		error: null | Error;
	}

	let { questionId }: Props = $props();

	let responseValue = '';
	let actionsValue = '';

	let responseInput = $state(responseValue);
	let actionsInput = $state(actionsValue);

	const getQuestion = async (): QuestionData => {
		const question = await getQuestionById(questionId);
		if (question) {
			console.log('=== QUESTION ===');
			console.log(question);
			return question;
		}
		return {
			data: null,
			error: new Error('Question not found')
		};
	};
	getQuestion();
</script>

{#await getQuestion() then question}
	<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
		<header>
			<h1 class="text-center text-2xl">{question.data.category}</h1>
		</header>

		<div class="flex flex-col">
			<label for="response-{questionId}" class="">{question.data.question_text}</label>
			<textarea
				id="response-{questionId}"
				bind:value={responseInput}
				placeholder="Enter your response here..."
				rows="4"
				class="mb-2 rounded-2xl border-2 border-[var(--pink)] p-2 outline-none focus:border-[var(--teal)]"
			></textarea>
		</div>

		<div class="flex flex-col">
			<label for="actions-{questionId}">Actions needed:</label>
			<textarea
				id="actions-{questionId}"
				bind:value={actionsInput}
				placeholder="Enter your response here..."
				rows="3"
				class="rounded-2xl border-2 border-[var(--pink)] p-2 outline-none focus:border-[var(--teal)]"
			></textarea>
		</div>

		<div class="flex justify-around">
			<button type="button" onclick={handleSkip} class="rounded-2xl border p-4">Skip</button>
			<button type="button" onclick={handleSubmit} class="rounded-2xl border p-4">Submit</button>
		</div>
	</div>
{/await}
