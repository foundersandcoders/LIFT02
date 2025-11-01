<script lang="ts">
	interface Props {
		status: 'idle' | 'saving' | 'saved' | 'error';
		error?: string | null;
	}

	let { status, error = null }: Props = $props();

	const statusText = $derived(
		status === 'saved' ? 'Saved' :
		status === 'error' ? 'Save failed' : ''
	);

	const statusClass = $derived(
		status === 'saved' ? 'text-success' :
		status === 'error' ? 'text-error' : ''
	);
</script>

{#if status !== 'idle' && status !== 'saving'}
	<div class="text-xs font-medium {statusClass}">
		{statusText}
		{#if status === 'error' && error}
			<span class="text-gray-500">({error})</span>
		{/if}
	</div>
{/if}