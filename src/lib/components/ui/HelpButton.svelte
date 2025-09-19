<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState } from '$lib/types/appState';
	import Tooltip from './Tooltip.svelte';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Determine current context for help content
	const helpContext = $derived(() => {
		const viewName = app.view.name;
		const hasProfile = !!app.profile.id;
		const listTable = app.list.table;
		const listCategory = app.list.category.raw;

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

	// Help content for each context
	const helpContent = $derived(() => {
		switch (helpContext()) {
			case 'dashboard-no-profile':
				return 'Welcome! Select a profile from the dropdown to get started with your workplace passport. Once selected, you can explore categories, add responses, and create action plans.';
			
			case 'dashboard-profile':
				return 'Your dashboard shows category tiles with your progress. Click on any category to explore questions and add your responses. Use the email button to share your responses with your line manager.';
			
			case 'actions':
				return 'Actions are personal plans you create to help with workplace challenges. You can add new actions, mark them as complete, and track your progress. Actions can be shared with your line manager via email.';
			
			case 'resources':
				return 'Resources are helpful materials and links related to workplace support. Browse available resources to find information that might help you in your role.';
			
			case 'categories':
				return 'Categories group related workplace topics. Each category contains questions you can respond to. Your responses help document your workplace needs and preferences.';
			
			case 'responses':
				return 'Your responses document your workplace needs and preferences. You can edit existing responses, add new ones, and control their visibility (public/private). Public responses can be shared with your line manager.';
			
			case 'email':
				return 'Email preview shows a summary of your responses and actions that can be shared with your line manager. Review the content before sending to ensure it accurately represents your workplace needs.';
			
			default:
				return 'Get help and guidance for using your digital workplace passport effectively.';
		}
	});
</script>

<Tooltip text={helpContent()} position="bottom_left">
	<button
		id="help-button"
		class="w-8 h-8 rounded-full border-2 border-white bg-transparent flex items-center justify-center hover:bg-white hover:bg-opacity-20 transition-colors text-white font-bold text-base"
		type="button"
		aria-label="Get help for current section"
	>
		i
	</button>
</Tooltip>