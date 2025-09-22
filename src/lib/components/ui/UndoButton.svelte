<script lang="ts">
	interface Props {
		canUndo: boolean;
		onclick: () => void;
	}

	let { canUndo, onclick }: Props = $props();
</script>

{#if canUndo}
	<button
		type="button"
		{onclick}
		class="btn btn-sm btn-ghost text-xs"
		title="Undo last change (Ctrl+Z)"
	>
		↶ Undo
	</button>
{/if}