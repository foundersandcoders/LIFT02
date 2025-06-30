<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';
	import type { QuestionDetails, RowId, TableName, ViewName } from '$lib/types/appState';
	import { getContext } from 'svelte';

	interface Props {
		text: string;
		visibility: string;
		details: QuestionDetails | null;
		table: TableName;
		buttonType: 'primary' | 'secondary';
		isUpdate: boolean;
		hasContent: boolean;
	}

	let { buttonType, details, hasContent, isUpdate, table, text, visibility }: Props = $props();

	const getProfileId = getContext<() => string>('getProfileId');
	const getQuestionId = getContext<() => string>('getDetailItemId');
	const setQuestionId = getContext<(newDetail: RowId | null) => void>('setDetailItemId');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const profileId = $derived(getProfileId());
	const questionId = $derived(getQuestionId());

	function clear() {
		setViewName('list');
		setQuestionId(null);
	}

	const onclick = async () => {
		console.group(`🔘 FormButton Click: ${text}`);
		console.log('📋 Button Props:', {
			text,
			buttonType,
			table,
			isUpdate,
			hasContent,
			visibility,
			profileId: profileId, // Force value resolution
			questionId: questionId // Force value resolution
		});
		console.log('📝 Question Details:', $state.snapshot(details));

		if (table === 'responses') {
			if (buttonType === 'primary') {
				const status = hasContent ? 'answered' : 'skipped';
				const response_text = hasContent ? details?.responseInput : null;

				const responseData = {
					response_text,
					question_id: questionId,
					status,
					visibility
				};

				console.log('🎯 PRIMARY BUTTON - Creating response:', responseData);

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
			// Future ActionCard functionality - unchanged for now
			const actionData = {
				type: details?.actionType || '',
				description: details?.actionsInput,
				response_id: details?.responseId
			};

			console.log('🎯 ACTION BUTTON - Creating action:', actionData);

			try {
				const result = await createAction(profileId, actionData);
				console.log('✅ Action created successfully:', result);
			} catch (error) {
				console.error('❌ Action creation failed:', error);
			}
		}

		clear();

		console.groupEnd();
	};
</script>

<button {onclick} type="submit" class="btn-submit">
	{text}
</button>
