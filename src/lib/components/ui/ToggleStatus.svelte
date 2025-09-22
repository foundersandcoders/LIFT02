<script lang="ts">
	import Tooltip from './Tooltip.svelte';

	let { visibility, toggleVisibility } = $props();

	const checked = visibility === 'private' ? false : true;

	const onclick = () => {
		toggleVisibility();
	};
</script>

<fieldset id="vis" class="form-fieldset">
	<label for="vis-label" class="label text-sm">
		Visibility to employer. This answer and actions will be included on the email
	</label>

	<label class="flex items-center gap-2">
		<Tooltip
			text="Public responses are included in emails shared with line managers"
			position="left"
		>
			<input id="vis-toggle" type="checkbox" {checked} {onclick} class="toggle toggle-accent" />
		</Tooltip>
		{visibility}
	</label>
</fieldset>
