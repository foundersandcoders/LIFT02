<script lang="ts">
	import '$lib/components/QuestionCard.svelte';
	import QuestionCard from '$lib/components/QuestionCard.svelte';
	import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	const questionId = '8b771be1-c38a-4242-8287-ec760cc96b6e';
</script>

<QuestionCard {questionId} />
