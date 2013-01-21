//
// regex2.cpp -- Beispielcode zur Demonstration der Laufzeit des RE2 Matchers
//
// Die RE2 Bibliothek kann von Google Code heruntergeladen werden:
//
//     http://code.google.com/p/re2/
//
// (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
#include <re2/re2.h>
#include <stdio.h>
#include <stdlib.h>

#define	N	29

int	main(int argc, char *argv[]) {
	/* Initialisiere Stringkomponenten */
	char	s1[2 * N + 1], s2[N + 1], expr[3 * N + 1];
	*s1 = '\0';
	*s2 = '\0';

	// Fuehre den Test durch fuer Laengen des Teststrings zwischen
	// 1 und N
	for (int i = 1; i <= N; i++) {
		// verlaengere die beiden Komponenten jeweils um ein Element
		strncat(s1, "a?", sizeof(s1));
		strncat(s2, "a", sizeof(s2));

		// baue den neuen regulaeren Ausdruck
		strncpy(expr, s1, sizeof(expr));
		strncat(expr, s2, sizeof(expr));

		// fuehre den Match durch
		bool	match = RE2::FullMatch(s2, expr);
		printf("%*s %s %s\n", N, s2,
			(match) ? "matches" : "doesn't match" , expr);
	}
	exit(EXIT_SUCCESS);
}
