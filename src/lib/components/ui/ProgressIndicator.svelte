<script lang="ts">
	interface Props {
		completed: number;
		total: number;
		size?: 'sm' | 'md' | 'lg';
	}

	let { completed, total, size = 'lg' }: Props = $props();

	const percentage = $derived(total > 0 ? (completed / total) * 100 : 0);
	const isComplete = $derived(completed === total);

	// Size mapping for the circle
	const sizeMap = {
		sm: { radius: 8, strokeWidth: 3, fontSize: 'text-sm' },
		md: { radius: 12, strokeWidth: 4, fontSize: 'text-base' },
		lg: { radius: 12, strokeWidth: 4, fontSize: 'text-base' }
	};

	const config = $derived(sizeMap[size]);
	const circumference = $derived(2 * Math.PI * config.radius);
	const dashOffset = $derived(circumference - (percentage / 100) * circumference);
</script>

<div class="relative inline-flex items-center justify-center">
	<svg
		width={config.radius * 2 + config.strokeWidth * 2}
		height={config.radius * 2 + config.strokeWidth * 2}
		class="transform -rotate-90"
	>
		<!-- Background circle (pink/magenta for incomplete, teal for complete) -->
		<circle
			cx={config.radius + config.strokeWidth}
			cy={config.radius + config.strokeWidth}
			r={config.radius}
			stroke={isComplete ? 'oklch(65% 0.1 195)' : 'oklch(69% 0.27 339)'}
			stroke-width={config.strokeWidth}
			fill="none"
		/>

		<!-- Progress circle (teal) - only show if not complete -->
		{#if !isComplete && percentage > 0}
			<circle
				cx={config.radius + config.strokeWidth}
				cy={config.radius + config.strokeWidth}
				r={config.radius}
				stroke="oklch(65% 0.1 195)"
				stroke-width={config.strokeWidth}
				fill="none"
				stroke-dasharray={circumference}
				stroke-dashoffset={dashOffset}
				stroke-linecap="round"
				class="transition-all duration-300"
			/>
		{/if}

		<!-- White background circle for icon visibility -->
		<circle
			cx={config.radius + config.strokeWidth}
			cy={config.radius + config.strokeWidth}
			r={config.radius - config.strokeWidth - 1}
			fill="white"
		/>
	</svg>

	<!-- Icon overlay -->
	<div
		class="absolute inset-0 flex items-center justify-center {config.fontSize} font-bold"
		style="color: {isComplete ? 'oklch(65% 0.1 195)' : 'oklch(69% 0.27 339)'}"
	>
		{isComplete ? '✓' : '?'}
	</div>
</div>
