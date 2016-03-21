/*
 * regex.c -- Regex-Matcher testen der C-Library testen
 *
 * (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
 * $Id$
 */
#include <stdio.h>
#include <stdlib.h>
#include <regex.h>
#include <string.h>

#define	N	29

int	main(int argc, char *argv[]) {
	/* Initialisierung der Strings */
	char	regex[3 * N + 1];
	char	s1[2 * N + 1];
	char	s2[N + 1];
	memset(regex, 0, sizeof(regex));
	memset(s1, 0, sizeof(s1));
	memset(s2, 0, sizeof(s2));

	/* baue regulaeren Ausdruck und Teststring fuer Laengen zwischen
           1 und N */
	for (int i = 1; i <= N; i++) {
		/* Komponenten s1 und s2 um je ein Teilstueck verlaengern */
		strcat(s1, "a?");
		strcat(s2, "a");
		strcpy(regex, s1);
		strcat(regex, s2);

		/* Regex-Matcher fuer diesen regulaeren Ausdruck aufbauen */
		regex_t	r;
		regcomp(&r, regex, REG_NOSUB);
		int	match = regexec(&r, s2, 0, NULL, 0);
		if (match) {
			printf("%*s matches %s\n", N, s2, regex);
		} else {
			printf("%*s doesn\'t match %s\n", N, s2, regex);
		}
	}
	exit(EXIT_SUCCESS);
}
