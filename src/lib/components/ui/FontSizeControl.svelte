<script lang="ts">
	import Tooltip from './Tooltip.svelte';

	// Font size state
	let fontSize = $state<'extra-small' | 'small' | 'medium' | 'large' | 'extra-large'>('medium');
	let showModal = $state(false);

	const fontSizeLabels = {
		'extra-small': 'Extra Small',
		'small': 'Small',
		'medium': 'Medium',
		'large': 'Large',
		'extra-large': 'Extra Large'
	};

	const increaseFontSize = () => {
		if (fontSize === 'extra-small') fontSize = 'small';
		else if (fontSize === 'small') fontSize = 'medium';
		else if (fontSize === 'medium') fontSize = 'large';
		else if (fontSize === 'large') fontSize = 'extra-large';
	};

	const decreaseFontSize = () => {
		if (fontSize === 'extra-large') fontSize = 'large';
		else if (fontSize === 'large') fontSize = 'medium';
		else if (fontSize === 'medium') fontSize = 'small';
		else if (fontSize === 'small') fontSize = 'extra-small';
	};

	const toggleModal = () => {
		showModal = !showModal;
	};

	const handleKeydown = (event: KeyboardEvent) => {
		if (event.key === 'Escape' || event.key === 'Enter' || event.key === ' ') {
			toggleModal();
		}
	};

	// Apply font size to document root
	$effect(() => {
		const root = document.documentElement;
		root.classList.remove('font-size-extra-small', 'font-size-small', 'font-size-medium', 'font-size-large', 'font-size-extra-large');
		root.classList.add(`font-size-${fontSize}`);
	});
</script>

<div class="relative flex items-center">
	<Tooltip text="Font size settings" position="bottom_left">
		<button
			onclick={toggleModal}
			class="w-8 h-8 rounded-full border-2 border-white bg-transparent flex items-center justify-center hover:bg-white hover:bg-opacity-20 transition-colors"
			type="button"
			aria-label="Font size settings"
		>
			<div class="flex flex-col items-center text-white leading-none">
				<span class="text-[6px] leading-none">+</span>
				<span class="italic font-serif text-xs leading-none">A</span>
				<span class="text-[6px] leading-none">-</span>
			</div>
		</button>
	</Tooltip>

	{#if showModal}
		<!-- Overlay to capture outside clicks -->
		<div
			class="fixed inset-0 z-40"
			onclick={toggleModal}
			onkeydown={handleKeydown}
			role="button"
			tabindex="-1"
			aria-label="Close font size modal"
		></div>

		<div class="absolute top-10 right-0 bg-white rounded-lg shadow-lg border border-gray-200 p-4 min-w-48 z-50">
			<div class="flex flex-col space-y-3">
				<h3 class="font-medium text-gray-900 mb-2">Font Size</h3>

				<div class="flex items-center justify-between">
					<button
						onclick={decreaseFontSize}
						disabled={fontSize === 'extra-small'}
						class="btn btn-sm btn-secondary disabled:opacity-50"
						type="button"
						aria-label="Decrease font size"
					>
						-
					</button>

					<span class="text-gray-700 font-medium px-4">{fontSizeLabels[fontSize]}</span>

					<button
						onclick={increaseFontSize}
						disabled={fontSize === 'extra-large'}
						class="btn btn-sm btn-secondary disabled:opacity-50"
						type="button"
						aria-label="Increase font size"
					>
						+
					</button>
				</div>

				<button
					onclick={toggleModal}
					class="btn btn-sm btn-accent text-white mt-2"
					type="button"
				>
					Close
				</button>
			</div>
		</div>
	{/if}
</div>