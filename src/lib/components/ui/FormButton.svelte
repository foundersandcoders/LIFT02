<script lang="ts">
	import { createResponse } from '$lib/services/database/responses';
	import type { QuestionConnections, RowId, TableName, ViewName } from '$lib/types/appState';
	import { getContext } from 'svelte';

	interface Props {
		text: string;
		visibility: string;
		details: QuestionConnections | null;
		table: TableName;
		buttonType: 'primary' | 'secondary';
		isUpdate: boolean;
		hasResponseContent: boolean;
		onclick?: () => void;
	}

	let {
		buttonType,
		details,
		hasResponseContent,
		isUpdate,
		table,
		text,
		visibility,
		onclick
	}: Props = $props();

	const getProfileId = getContext<() => string>('getProfileId');
	const getQuestionId = getContext<() => string>('getDetailItemId');
	const setQuestionId = getContext<(newDetail: RowId | null) => void>('setDetailItemId');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const profileId = $derived(getProfileId());
	const questionId = $derived(getQuestionId());

	// const hasActionData = $derived(() => {
	// 	const hasType =
	// 		details?.actionType && details.actionType !== '' && details.actionType !== 'default';
	// 	const hasDescription = details?.actionsInput && details.actionsInput.trim() !== '';
	// 	return hasType && hasDescription;
	// });

	function clearDetail() {
		setViewName('list');
		setQuestionId(null);
	}

	const handleClick = async () => {
		if (onclick) {
			onclick();
			return;
		}

		console.groupCollapsed(`🔘 FormButton Click: ${text}`);
		console.log('📋 Button Props:', {
			text,
			buttonType,
			table,
			isUpdate,
			hasResponseContent,
			visibility,
			profileId: profileId, // Force value resolution
			questionId: questionId // Force value resolution
		});
		console.log('📝 Question Details:', details ? $state.snapshot(details) : null);

		if (table === 'responses') {
			if (buttonType === 'primary') {
				const status = hasResponseContent ? 'answered' : 'skipped';
				const response_text = hasResponseContent ? details?.responseInput : null;

				const responseData = {
					response_text,
					question_id: questionId,
					status,
					visibility
				};

				console.log('🎯 Primary Button (Creating Response):', responseData);

				try {
					const result = await createResponse(profileId, responseData);
					console.log('✅ Response created successfully:', result);
				} catch (error) {
					console.error('❌ Response creation failed:', error);
				}
			} else if (buttonType === 'secondary') {
				// Secondary button: "Delete" (if isUpdate) or "Skip" (if !isUpdate)
				// Both create a "skipped" response with no content
				const responseData = {
					response_text: null,
					question_id: questionId,
					status: 'skipped',
					visibility: 'private' // Force private for skipped/deleted responses
				};

				console.log(
					`🎯 SECONDARY BUTTON (${isUpdate ? 'DELETE' : 'SKIP'}) - Creating response:`,
					responseData
				);

				try {
					const result = await createResponse(profileId, responseData);
					console.log('✅ Response created successfully:', result);
				} catch (error) {
					console.error('❌ Response creation failed:', error);
				}
			}
		} else if (table === 'actions') {
			// Actions are now handled by ActionsCRUD component
			console.log('🎯 ACTION BUTTON - Actions are managed by ActionsCRUD component');
		}

		clearDetail();

		console.groupEnd();
	};
</script>

<button onclick={handleClick} type="submit" class="btn-submit">
	{text}
</button>
