<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Profile } from '$lib/types/appState';
	import { updateProfile } from '$lib/services/database/profiles';
	import Tooltip from './Tooltip.svelte';

	// Get app state from context
	const getApp = getContext<() => AppState>('getApp');
	const setProfile = getContext<(newProfile: Profile) => void>('setProfile');
	const app = $derived(getApp());

	// Check if user is loaded
	const isUserLoaded = $derived(!!app.profile.id);

	// Font size state - read from appState preferences or default to medium
	let fontSize = $state<'extra-small' | 'small' | 'medium' | 'large' | 'extra-large'>('medium');

	// Keep fontSize in sync with appState preferences
	$effect(() => {
		fontSize = app.profile.preferences?.fontSize || 'medium';
	});
	let showModal = $state(false);

	const fontSizeLabels = {
		'extra-small': 'Extra small',
		'small': 'Small',
		'medium': 'Medium',
		'large': 'Large',
		'extra-large': 'Extra large'
	};

	// Helper function to update both local state and appState preferences
	const updateFontSize = async (newSize: typeof fontSize) => {
		fontSize = newSize;

		// Update appState preferences immediately for UI responsiveness
		const updatedProfile = {
			...app.profile,
			preferences: {
				...app.profile.preferences,
				fontSize: newSize
			}
		};
		setProfile(updatedProfile);

		// Save to database if user is logged in
		if (app.profile.id) {
			try {
				const result = await updateProfile(app.profile.id, {
					preferences: updatedProfile.preferences
				});
				if (result.error) {
					console.error('Database error saving font size preference:', result.error);
				}
			} catch (error) {
				console.error('Failed to save font size preference:', error);
			}
		}
	};

	const increaseFontSize = () => {
		if (fontSize === 'extra-small') updateFontSize('small');
		else if (fontSize === 'small') updateFontSize('medium');
		else if (fontSize === 'medium') updateFontSize('large');
		else if (fontSize === 'large') updateFontSize('extra-large');
	};

	const decreaseFontSize = () => {
		if (fontSize === 'extra-large') updateFontSize('large');
		else if (fontSize === 'large') updateFontSize('medium');
		else if (fontSize === 'medium') updateFontSize('small');
		else if (fontSize === 'small') updateFontSize('extra-small');
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
	<Tooltip text={isUserLoaded ? "Font size settings" : "Font size settings (disabled until user is loaded)"} position="top_left">
		<button
			onclick={toggleModal}
			disabled={!isUserLoaded}
			class="w-10 h-10 rounded-full border-2 border-white bg-transparent flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed group"
			type="button"
			aria-label="Font size settings"
		>
			<div class="flex items-center text-white leading-none gap-1 transition-transform group-hover:scale-125">
				<div class="flex flex-col items-center leading-none -space-y-1">
					<span class="text-sm leading-none">+</span>
					<span class="text-sm leading-none">-</span>
				</div>
				<span class="font-serif text-lg leading-none">A</span>
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

		<div class="absolute bottom-12 right-0 bg-white rounded-lg shadow-[0_0_15px_rgba(0,0,0,0.3)] border-2 border-gray-400 p-4 min-w-48 z-50">
			<div class="flex flex-col space-y-3">
				<h3 class="font-medium text-gray-900 mb-2">Font size</h3>

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

					<span class="text-gray-700 font-medium px-4 whitespace-nowrap">{fontSizeLabels[fontSize]}</span>

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