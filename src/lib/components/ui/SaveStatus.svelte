<script lang="ts">
	interface Props {
		status: 'idle' | 'saving' | 'saved' | 'error';
		error?: string | null;
	}

	let { status, error = null }: Props = $props();

	const statusText = $derived(
		status === 'saving' ? 'Saving...' :
		status === 'saved' ? 'Saved' :
		status === 'error' ? 'Save failed' : ''
	);

	const statusClass = $derived(
		status === 'saving' ? 'text-blue-600' :
		status === 'saved' ? 'text-green-600' :
		status === 'error' ? 'text-red-600' : ''
	);
</script>

{#if status !== 'idle'}
	<div class="text-xs {statusClass} flex items-center gap-1">
		{#if status === 'saving'}
			<div class="loading loading-spinner loading-xs"></div>
		{/if}
		{statusText}
		{#if status === 'error' && error}
			<span class="text-gray-500">({error})</span>
		{/if}
	</div>
{/if}