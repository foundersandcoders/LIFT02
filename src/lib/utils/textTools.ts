import type { TextDestination, TextSource } from '$lib/types/utilText';

export function makePretty(
	input: string,
	source: TextSource,
	destination: TextDestination
): string {
	let output: string;

	switch (`${source} ${destination}`) {
		case 'db-table-name tile-text':
			output = toCaseTitle(cleanUnderscores(input));
			break;
		default:
			output = input;
	}

	return output;
}

export function cleanUnderscores(text: string): string {
	return text.replace('_', ' ');
}

function toCaseTitle(text: string): string {
	return text
		.split(' ')
		.map((word) => word.charAt(0).toUpperCase() + word.slice(1))
		.join(' ');
}
