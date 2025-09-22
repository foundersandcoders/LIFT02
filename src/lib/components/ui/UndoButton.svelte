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
		class="btn-submit btn-sm"
		title="Undo last change (Ctrl+Z)"
	>
		Undo
	</button>
{/if}