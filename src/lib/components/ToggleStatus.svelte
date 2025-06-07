<script lang="ts">
	let { isPublic, toggleVisibility } = $props();
</script>

<div class="flex items-center gap-3">
	<div class="relative inline-block h-5 w-11">
		<input
			checked={toggleVisibility}
			onclick={toggleVisibility}
			id="switch-component"
			type="checkbox"
			class="peer h-5 w-11 cursor-pointer appearance-none rounded-full bg-slate-100 transition-colors duration-300 checked:bg-[var(--teal)]"
		/>
		<label
			for="switch-component"
			class="absolute top-0 left-0 h-5 w-5 cursor-pointer rounded-full border border-slate-300 bg-white shadow-sm transition-transform duration-300 peer-checked:translate-x-6 peer-checked:border-[var(--teal)]"
		>
		</label>
	</div>
	<span class=" text-sm font-medium">{isPublic}</span>
</div>
