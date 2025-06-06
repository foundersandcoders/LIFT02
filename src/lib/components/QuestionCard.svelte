<script lang="ts">
	interface Props {
		sectionHeader: string;
		questionText: string;
		responseValue?: string;
		actionsValue?: string;
		questionId?: string | number;
		onsubmit?: (data: {
			questionId: string | number | undefined;
			response: string;
			actions: string;
		}) => void;
		onskip?: (data: { questionId: string | number | undefined }) => void;
	}

	let {
		sectionHeader = 'Feelings',
		questionText = 'How are you today?',
		responseValue = '',
		actionsValue = '',
		questionId = 1,
		onsubmit = () => {
			console.log('submit clicked');
		},
		onskip = () => {
			console.log('skip clicked');
		}
	}: Props = $props();

	let responseInput = $state(responseValue);
	let actionsInput = $state(actionsValue);

	function handleSubmit() {
		onsubmit?.({
			questionId,
			response: responseInput,
			actions: actionsInput
		});
	}

	function handleSkip() {
		onskip?.({
			questionId
		});
	}
</script>

<div class=" m-auto flex min-h-[90dvh] w-sm flex-col justify-around rounded-3xl p-5 shadow-2xl">
	<header>
		<h1 class="text-center text-2xl">{sectionHeader}</h1>
	</header>

	<div class="flex flex-col">
		<label for="response-{questionId}" class="">{questionText}</label>
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
