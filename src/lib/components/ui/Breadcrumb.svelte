<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, ViewName, List } from '$lib/types/appState';
	import { getQuestionById } from '$lib/services/database/questions';

	const getApp = getContext<() => AppState>('getApp');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');
	const setList = getContext<(list: List) => void>('setList');

	const app = $derived(getApp());

	// Get current question title when in detail view
	let questionTitle = $state<string | null>(null);

	$effect(() => {
		if (app.view.name === 'detail' && app.detail.item.id) {
			getQuestionById(app.detail.item.id).then(result => {
				if (result.data) {
					questionTitle = result.data.preview;
				}
			});
		} else {
			questionTitle = null;
		}
	});

	interface BreadcrumbItem {
		label: string;
		clickable: boolean;
		action?: () => void;
	}

	// Generate breadcrumb items based on current app state
	const breadcrumbItems = $derived(() => {
		const viewName = app.view.name;
		const listTable = app.list.table;
		const detailTable = app.detail.table;
		const categoryFormat = app.list.category.format;

		// Debug logging
		console.log('🔍 Breadcrumb Debug:', { viewName, listTable, detailTable, categoryFormat });

		const items: BreadcrumbItem[] = [];

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
			if (detailTable === 'responses' || detailTable === 'questions' || !detailTable) {
				// For questions/responses, show the category breadcrumb
				if (categoryFormat) {
					items.push({
						label: categoryFormat,
						clickable: true,
						action: () => {
							const category = app.list.category || { raw: null, format: null };
							setList({ table: 'questions', category });
							setViewName('list');
						}
					});

					// Add the specific item type
					if (detailTable === 'questions') {
						items.push({
							label: questionTitle || 'Question',
							clickable: false
						});
					} else if (detailTable === 'responses') {
						items.push({
							label: questionTitle || 'Response',
							clickable: false
						});
					} else {
						// Fallback for null detailTable
						items.push({
							label: questionTitle || 'Question',
							clickable: false
						});
					}
				}
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

	// Cache the breadcrumb items to avoid multiple function calls
	const items = $derived(breadcrumbItems());

	// Always show breadcrumbs (at minimum shows current page)
	const showBreadcrumbs = $derived(items.length > 0);
</script>

{#if showBreadcrumbs}
	<nav class="breadcrumb" aria-label="Breadcrumb navigation" style="min-width: 0;">
		<ol class="breadcrumb-list">
			{#each items as item, index (item.label)}
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
					{#if index < items.length - 1}
						<span class="breadcrumb-separator" aria-hidden="true">→</span>
					{/if}
				</li>
			{/each}
		</ol>
	</nav>
{/if}