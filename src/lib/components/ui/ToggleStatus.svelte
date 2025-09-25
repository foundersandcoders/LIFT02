<script lang="ts">
	import Tooltip from './Tooltip.svelte';

	let { visibility, toggleVisibility, disabled = false } = $props();

	const checked = visibility === 'private' ? false : true;

	const onclick = () => {
		if (!disabled) {
			toggleVisibility();
		}
	};
</script>

<fieldset id="vis" class="form-fieldset">
	<label for="vis-toggle" class="label text-sm whitespace-normal break-words flex-1 pr-4">
		Visibility to employer. This answer and actions will be included on the email
	</label>

	<label class="flex items-center gap-2 flex-shrink-0">
		<Tooltip
			text={disabled ? "Save your response first to change visibility" : "Public responses are included in emails shared with line managers"}
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
</fieldset>
