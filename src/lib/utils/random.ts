export function randomNum() {
	return Math.ceil(Math.random() * 10);
}

export function generateUniqueId(prefix: string = 'id'): string {
	const timestamp = Date.now().toString(36);
	const randomPart = Math.random().toString(36).substring(2);
	return `${prefix}-${timestamp}-${randomPart}`;
}
