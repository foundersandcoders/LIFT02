<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, ViewName, List } from '$lib/types/appState';

	const getApp = getContext<() => AppState>('getApp');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');
	const setList = getContext<(list: List) => void>('setList');

	const app = $derived(getApp());

	interface BreadcrumbItem {
		label: string;
		clickable: boolean;
		action?: () => void;
	}

	// Generate breadcrumb items based on current app state
	const breadcrumbItems = $derived(() => {
		const items: BreadcrumbItem[] = [];
		const viewName = app.view.name;
		const listTable = app.list.table;
		const detailTable = app.detail.table;
		const categoryFormat = app.list.category.format;

		// Always start with Dashboard
		items.push({
			label: 'Dashboard',
			clickable: true,
			action: () => setViewName('dash')
		});

		// Add intermediate levels based on current view
		if (viewName === 'list') {
			if (listTable === 'questions' && categoryFormat) {
				items.push({
					label: categoryFormat,
					clickable: false
				});
			} else if (listTable === 'actions') {
				items.push({
					label: 'Actions',
					clickable: false
				});
			} else if (listTable === 'resources') {
				items.push({
					label: 'Resources',
					clickable: false
				});
			} else if (listTable === 'responses') {
				items.push({
					label: 'Responses',
					clickable: false
				});
			}
		} else if (viewName === 'detail') {
			// Add the list level first
			if (detailTable === 'responses') {
				if (categoryFormat) {
					items.push({
						label: categoryFormat,
						clickable: true,
						action: () => {
							setList({ table: 'questions', category: app.list.category });
							setViewName('list');
						}
					});
				}
				items.push({
					label: 'Response',
					clickable: false
				});
			} else if (detailTable === 'actions') {
				items.push({
					label: 'Actions',
					clickable: true,
					action: () => {
						setList({ table: 'actions', category: { raw: null, format: null } });
						setViewName('list');
					}
				});
				items.push({
					label: 'Action',
					clickable: false
				});
			} else if (detailTable === 'resources') {
				items.push({
					label: 'Resources',
					clickable: true,
					action: () => {
						setList({ table: 'resources', category: { raw: null, format: null } });
						setViewName('list');
					}
				});
				items.push({
					label: 'Resource',
					clickable: false
				});
			}
		} else if (viewName === 'email') {
			items.push({
				label: 'Email Preview',
				clickable: false
			});
		}

		return items;
	});

	// Always show breadcrumbs (at minimum shows current page)
	const showBreadcrumbs = $derived(breadcrumbItems().length > 0);
</script>

{#if showBreadcrumbs}
	<nav class="breadcrumb" aria-label="Breadcrumb navigation">
		<ol class="breadcrumb-list">
			{#each breadcrumbItems() as item, index (item.label)}
				<li class="breadcrumb-item">
					{#if item.clickable && item.action}
						<button
							class="breadcrumb-link"
							onclick={item.action}
							type="button"
						>
							{item.label}
						</button>
					{:else}
						<span class="breadcrumb-current">{item.label}</span>
					{/if}
					{#if index < breadcrumbItems().length - 1}
						<span class="breadcrumb-separator" aria-hidden="true">→</span>
					{/if}
				</li>
			{/each}
		</ol>
	</nav>
{/if}