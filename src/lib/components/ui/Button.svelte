<script lang="ts">
	interface Props {
		text: string;
		color?: string;
		variant?: 'primary' | 'secondary' | 'outline';
		size?: 'sm' | 'md' | 'lg';
		disabled?: boolean;
		type?: 'button' | 'submit' | 'reset';
		onclick?: () => void;
		class?: string;
	}

	let {
		text,
		color = 'var(--color-pink)',
		variant = 'primary',
		size = 'md',
		disabled = false,
		type = 'button',
		onclick,
		class: className = '',
		...restProps
	}: Props = $props();

	const baseClasses =
		'inline-flex items-center justify-center font-medium rounded-md transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed';

	const sizeClasses = {
		sm: 'px-3 py-1.5 text-sm',
		md: 'px-4 py-2 text-sm',
		lg: 'px-6 py-3 text-base'
	};

	const getVariantClasses = (variant: string) => {
		switch (variant) {
			case 'primary':
				return `text-white hover:opacity-90 focus:ring-2`;
			case 'secondary':
				return `bg-gray-100 text-gray-900 hover:bg-gray-200 focus:ring-gray-500`;
			case 'outline':
				return `bg-transparent border-2 hover:opacity-90 focus:ring-2`;
			default:
				return `text-white hover:opacity-90 focus:ring-2`;
		}
	};

	const buttonClasses = $derived([
		"btn",
		"btn-secondary",
		baseClasses,
		sizeClasses[size],
		getVariantClasses(variant),
		className
	].join(' '));

	const buttonStyle = $derived(
		variant === 'primary'
			? `background-color: ${color}; --tw-ring-color: ${color};`
			: variant === 'outline'
				? `border-color: ${color}; color: ${color}; --tw-ring-color: ${color};`
				: ''
	);
</script>

<button {type} {disabled} class={buttonClasses} style={buttonStyle} {onclick} {...restProps}>
	{text}
</button>
