<script lang="ts">
	import type { HelpContent } from '$lib/types/help';

	let { show, helpContent, onclose } = $props<{
		show: boolean;
		helpContent: HelpContent | null;
		onclose: () => void;
	}>();

	let dialog = $state<HTMLDialogElement>();
	let previouslyFocused = $state<HTMLElement | null>(null);

	$effect(() => {
		if (show && dialog) {
			previouslyFocused = document.activeElement as HTMLElement;
			document.body.inert = true;
			dialog.showModal();
			const autofocusElement = dialog.querySelector<HTMLElement>('[data-autofocus]');
			if (autofocusElement) {
				autofocusElement.focus();
			}
		} else if (!show && dialog) {
			dialog.close();
			document.body.inert = false;
			if (previouslyFocused) {
				previouslyFocused.focus();
				previouslyFocused = null;
			}
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

{#if show && helpContent}
	<dialog
		bind:this={dialog}
		class="modal"
		onclick={(event) => {
			if (event.currentTarget === event.target) {
				onclose();
			}
		}}
	>
		<div class="modal-box modal-box-help flex max-h-full flex-col">
			<h3 class="text-base-content mb-4 flex-shrink-0 text-lg font-bold">{helpContent.title}</h3>

			<div class="prose max-w-none min-h-0 flex-1 space-y-6 overflow-y-auto">
				{#each helpContent.sections as section}
					<div class="help-section">
						{#if section.heading}
							<h4 class="mb-2 text-base font-semibold">{section.heading}</h4>
						{/if}

						<p class="mb-4">{section.text}</p>

						<!-- Screenshots commented out - doesn't make sense to show screenshot of the current page
						{#if section.screenshot}
							<div class="screenshot-container mb-4">
								<img
									src={section.screenshot.src}
									alt={section.screenshot.alt}
									class="rounded-lg border border-base-300 shadow-md w-full max-w-md mx-auto"
									onerror={(e) => {
										e.currentTarget.style.display = 'none';
										const placeholder = e.currentTarget.nextElementSibling;
										if (placeholder) placeholder.style.display = 'block';
									}}
								/>
								<div class="screenshot-placeholder bg-base-200 border-2 border-dashed border-base-300 rounded-lg p-8 text-center max-w-md mx-auto" style="display: none;">
									<p class="text-base-content/50 text-sm">
										📷 Screenshot: {section.screenshot.caption || section.screenshot.alt}
									</p>
									<p class="text-xs text-base-content/40 mt-2">
										(Screenshot not available)
									</p>
								</div>
								{#if section.screenshot.caption}
									<p class="text-sm text-base-content/70 mt-2 text-center">{section.screenshot.caption}</p>
								{/if}
							</div>
						{/if}
						-->

						{#if section.callouts}
							<ul class="bg-base-200 list-inside list-disc space-y-1 rounded-lg p-4">
								{#each section.callouts as callout}
									<li class="text-sm">{callout}</li>
								{/each}
							</ul>
						{/if}
					</div>
				{/each}
			</div>

			<div
				class="border-base-300 mt-4 flex flex-shrink-0 items-center justify-end border-t pt-4"
			>
				<button class="btn btn-primary" onclick={onclose} data-autofocus>Close</button>
			</div>
		</div>
	</dialog>
{/if}
