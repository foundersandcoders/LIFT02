<script lang="ts">
	let {
		show,
		title,
		onclose
	} = $props<{
		show: boolean;
		title: string;
		onclose: () => void;
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
		<div class="modal-box">
			<h3 class="text-lg font-bold">{title}</h3>
			<div class="prose py-4 max-w-none">
				<slot />
			</div>
			<div class="modal-action">
				<button class="btn" onclick={onclose} data-autofocus>Close</button>
			</div>
		</div>
	</dialog>
{/if}
