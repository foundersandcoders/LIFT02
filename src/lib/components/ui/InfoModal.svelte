<script lang="ts">
	import type { Snippet } from 'svelte';

	let { show, title, onclose, children } = $props<{
		show: boolean;
		title: string;
		onclose: () => void;
		children: Snippet;
	}>();

	let dialog = $state<HTMLDialogElement>();
	let previouslyFocused = $state<HTMLElement | null>(null);

	$effect(() => {
		if (show && dialog) {
			previouslyFocused = document.activeElement as HTMLElement;
			dialog.showModal();
			const autofocusElement = dialog.querySelector<HTMLElement>('[data-autofocus]');
			if (autofocusElement) {
				autofocusElement.focus();
			}
		} else if (!show && dialog && previouslyFocused) {
			dialog.close();
			previouslyFocused.focus();
			previouslyFocused = null;
		}
	});
</script>

<svelte:window
	onkeydown={(e) => {
		if (show && e.key === 'Escape') {
			onclose();
		}
	}}
/>

{#if show}
	<dialog
		bind:this={dialog}
		class="modal"
		onclick={(event) => {
			if (event.currentTarget === event.target) {
				onclose();
			}
		}}
	>
		<div class="modal-box modal-box-custom">
			<h3 class="text-lg font-bold">{title}</h3>
			<div class="prose max-w-none overflow-y-auto py-4">
				{@render children()}
			</div>
			<div class="modal-action">
				<button class="btn btn-primary" onclick={onclose} data-autofocus>Close</button>
			</div>
		</div>
	</dialog>
{/if}
