<script lang="ts">
	interface Props {
		status: 'idle' | 'saving' | 'saved' | 'error';
		error?: string | null;
	}

	let { status, error = null }: Props = $props();

	const statusText = $derived(() => {
		switch (status) {
			case 'saving':
				return 'Saving...';
			case 'saved':
				return 'Saved';
			case 'error':
				return 'Save failed';
			default:
				return '';
		}
	});

	const statusClass = $derived(() => {
		switch (status) {
			case 'saving':
				return 'text-blue-600';
			case 'saved':
				return 'text-green-600';
			case 'error':
				return 'text-red-600';
			default:
				return '';
		}
	});
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