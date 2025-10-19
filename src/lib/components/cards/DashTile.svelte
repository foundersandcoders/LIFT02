<script lang="ts">
	import Tooltip from '../ui/Tooltip.svelte';
	import ProgressIndicator from '../ui/ProgressIndicator.svelte';

	interface Props {
		title: string | null;
		loading?: boolean;
		error?: string | null;
		disabled?: boolean;
		onclick?: () => void;
		variant?: 'square' | 'default';
		showStatus?: boolean;
		completed?: number;
		total?: number;
		completionText?: string;
	}

	let {
		title,
		loading = false,
		error = null,
		disabled = false,
		onclick,
		variant = 'default',
		showStatus = false,
		completed = 0,
		total = 0,
		completionText = ''
	}: Props = $props();

	const isComplete = $derived(completed === total && total > 0);
</script>

<button class={variant === 'square' ? 'dash-tile-square' : 'dash-tile-rect'} {onclick} {disabled}>
	{#if loading}
		<p class="text-center">Loading {title}...</p>
	{:else if error}
		<p class="text-center">Error: {error}</p>
	{:else}
		<div class="flex w-full items-center justify-between gap-2">
			{#if showStatus}
				<Tooltip
					text={isComplete ? 'All questions answered' : `${completed}/${total} questions answered`}
					position="right"
				>
					<ProgressIndicator {completed} {total} size="lg" />
				</Tooltip>
			{/if}
			<p class="text-center break-words hyphens-auto flex-1">{title}</p>
		</div>
	{/if}
</button>
