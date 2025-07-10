<script lang="ts">
	interface Props {
		title: string | null;
		loading?: boolean;
		error?: string | null;
		disabled?: boolean;
		onclick?: () => void;
		variant?: 'square' | 'default';
	}

	let {
		title,
		loading = false,
		error = null,
		disabled = false,
		onclick,
		variant = 'default'
	}: Props = $props();
</script>

<button class={variant === 'square' ? 'dash-tile-square' : 'list-item'} {onclick} {disabled}>
	{#if loading}
		<p class="text-center">Loading {title}...</p>
	{:else if error}
		<p class="text-center">Error: {error}</p>
	{:else}
		<p class="text-center">{title}</p>
	{/if}
</button>
