<script lang="ts">
	interface Props {
		show: boolean;
		title: string;
		message: string;
		onConfirm: () => void;
		onCancel: () => void;
	}

	let { show, title, message, onConfirm, onCancel }: Props = $props();
</script>

<svelte:window
	on:keydown={(e) => {
		if (show && e.key === 'Escape') {
			onCancel();
		}
	}}
/>
{#if show}
	<dialog
		class="modal modal-open"
		onclick={(event) => {
			if (event.currentTarget === event.target) {
				onCancel();
			}
		}}
	>
		<div class="modal-box">
			<h3 class="text-lg font-bold">{title}</h3>
			<p class="py-4">{message}</p>
			<div class="modal-action">
				<button class="btn" onclick={onCancel}>Cancel</button>
				<button class="btn btn-primary" onclick={onConfirm}>Confirm</button>
			</div>
		</div>
	</dialog>
{/if}
