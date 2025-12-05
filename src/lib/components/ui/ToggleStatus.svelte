<script lang="ts">
	import Tooltip from './Tooltip.svelte';
	import SaveStatus from './SaveStatus.svelte';

	interface Props {
		visibility: string;
		toggleVisibility: () => void;
		disabled?: boolean;
		saveStatus?: 'idle' | 'saving' | 'saved' | 'error';
		saveError?: string | null;
	}

	let {
		visibility,
		toggleVisibility,
		disabled = false,
		saveStatus = 'idle',
		saveError = null
	}: Props = $props();

	const checked = visibility === 'private' ? false : true;

	const onclick = () => {
		if (!disabled) {
			toggleVisibility();
		}
	};
</script>

<fieldset id="vis" class="visibility-panel">
	<label
		for="vis-toggle"
		class="label text-base-content flex-1 pr-4 text-sm break-words whitespace-normal"
	>
		Visibility to employer. If private, answer and actions won't be included in email.
	</label>

	<div>
		<label class="flex flex-shrink-0 items-center gap-2">
			<Tooltip
				text={disabled
					? 'Save your response first to change visibility'
					: 'Public responses are included in emails shared with line managers'}
				position="left"
			>
				<input
					id="vis-toggle"
					type="checkbox"
					{checked}
					{onclick}
					{disabled}
					class="toggle toggle-accent"
					class:opacity-50={disabled}
				/>
			</Tooltip>
			{visibility}
		</label>
	</div>

	<!-- Position save status absolutely -->
	<div class="absolute top-2 right-2 z-10">
		<SaveStatus status={saveStatus} error={saveError} />
	</div>
</fieldset>
