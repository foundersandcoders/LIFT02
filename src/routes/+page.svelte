<script lang="ts">
	import '$lib/components/QuestionCard.svelte';
	import QuestionCard from '$lib/components/QuestionCard.svelte';
	import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	//Delete later --> This needs to manually updated every time you db reset
	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';
</script>

<QuestionCard {questionId} />
