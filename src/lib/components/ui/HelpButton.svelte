<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState } from '$lib/types/appState';
	import type { HelpContent, HelpContextKey } from '$lib/types/help';
	import Tooltip from './Tooltip.svelte';
	import HelpModal from './HelpModal.svelte';
	import { getHelpContent } from '$lib/services/helpContent';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	let showHelpModal = $state(false);
	let helpContent = $state<HelpContent | null>(null);
	let isLoading = $state(false);

	// Determine current context for help content
	const helpContext = $derived(() => {
		const viewName = app.view.name;
		const hasProfile = !!app.profile.id;
		const listTable = app.list.table;

		// Email Preview
		if (viewName === 'email') {
			return 'email';
		}

		// Dashboard states
		if (viewName === 'dash') {
			return hasProfile ? 'dashboard-profile' : 'dashboard-no-profile';
		}

		// List view - determine what type of list
		if (viewName === 'list') {
			if (listTable === 'actions') {
				return 'actions';
			}
			if (listTable === 'resources') {
				return 'resources';
			}
			if (listTable === 'questions') {
				return 'categories';
			}
			if (listTable === 'responses') {
				return 'responses';
			}
		}

		// Detail view - determine what type of detail
		if (viewName === 'detail') {
			const detailTable = app.detail.table;
			if (detailTable === 'responses') {
				return 'responses';
			}
			if (detailTable === 'actions') {
				return 'actions';
			}
			if (detailTable === 'resources') {
				return 'resources';
			}
		}

		// Fallback
		return 'dashboard-no-profile';
	});

	async function handleHelpClick() {
		if (isLoading) return;
		
		isLoading = true;
		try {
			helpContent = await getHelpContent(helpContext() as HelpContextKey);
			showHelpModal = true;
		} catch (error) {
			console.error('Failed to load help content:', error);
		} finally {
			isLoading = false;
		}
	}

	function closeHelpModal() {
		showHelpModal = false;
		helpContent = null;
	}
</script>

<Tooltip text="Get help" position="bottom_left">
	<button
		id="help-button"
		class="w-8 h-8 rounded-full border-2 border-white bg-transparent flex items-center justify-center hover:bg-white hover:bg-opacity-20 transition-colors text-white font-bold text-base disabled:opacity-50"
		type="button"
		aria-label="Get help for current section"
		onclick={handleHelpClick}
		disabled={isLoading}
	>
		{isLoading ? '...' : 'i'}
	</button>
</Tooltip>

<HelpModal
	show={showHelpModal}
	{helpContent}
	onclose={closeHelpModal}
/>