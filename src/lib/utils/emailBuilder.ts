const jason = makeGrammar('Jason', ['he', 'him', 'his']);
craftEmail(jason);

const jaz = makeGrammar('Jaz', ['they', 'them', 'theirs']);
craftEmail(jaz);

function makeGrammar(name: string, pronouns: string[]): User {
	return {
		name: name,
		pro: {
			sub: pronouns[0],
			obj: pronouns[1],
			pos: pronouns[2]
		},
		responses: [
			/* from the DB */
		],
		manager: [
			/* from the DB */
		]
	};
}

function craftEmail(user: User) {
	return `Dear ${user.manager},
    
    ${user.name} has chosen to share ${user.pro.pos} latest responses with you.
    
    Have a look at them before your next review with ${user.pro.obj}.

    ${user.responses /* loop through */}
  `;
}

interface User {
	name: string;
	pro: Pronouns;
	responses: [
		/* from the DB */
	];
	manager: [
		/* from the DB */
	];
}

interface Pronouns {
	sub: string;
	obj: string;
	pos: string;
}
