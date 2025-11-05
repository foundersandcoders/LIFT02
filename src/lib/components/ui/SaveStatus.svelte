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
		<!-- Commented out "Saved" message - keeping error messages visible -->
		{#if status === 'error'}
			{statusText}
			{#if error}
				<span class="text-gray-500">({error})</span>
			{/if}
		{/if}
		<!-- Uncomment below to show "Saved" message -->
		<!-- {#if status === 'saved'}
			{statusText}
		{/if} -->
	</div>
{/if}