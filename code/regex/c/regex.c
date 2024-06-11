/*
 * regex.c -- Regex-Matcher testen der C-Library testen
 *
 * (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <stdio.h>
#include <stdlib.h>
#include <regex.h>
#include <string.h>
#include <getopt.h>
#include <sys/resource.h>

#define	N	30

static void	usage(const char *progname) {
	printf("measure regex library performance\n");
	printf("usage:\n");
	printf("    regex [ -hm? ] [ -i <i> ]\n");
	printf("options:\n");
	printf("    --help,-h,-?       show this help message and exit\n");
	printf("    --measure,-m       perform high precision measurement\n");
	printf("    --iterations=<i>   number of iterations of matches to use\n");
	printf("                       for precision measurement\n");
}

static struct option	longopts[] = {
{ "help",	no_argument,		NULL,	'h' },
{ "iterations",	required_argument,	NULL,	'i' },
{ "measure",	no_argument,		NULL,	'm' },
{ NULL,		0,			NULL,	 0  }
};

int	main(int argc, char *argv[]) {
	int	iterations = 1000;
	int	measure = 0;

	/* Kommandozeilenoptionen */
	int	c;
	int	longindex;
	while (EOF != (c = getopt_long(argc, argv, "hi:m?", longopts,
		&longindex))) {
		switch (c) {
		case 'h':
		case '?':
			usage(argv[0]);
			exit(EXIT_SUCCESS);
		case 'i':
			iterations = atoi(optarg);
			break;
		case 'm':
			measure = 1;
			break;
		}
	}

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

		/* Datenstrukturen für Zeitmessung vorbereiten */
		struct rusage	start;
		struct rusage	end;
		getrusage(RUSAGE_SELF, &start);

		/* Regex match durchführen */
		int	match = 0;
		int	counter = (measure) ? iterations : 1;
		while (counter-- > 0) {
			match = regexec(&r, s2, 0, NULL, 0);
		}

		/* Laufzeit auswerten */
		getrusage(RUSAGE_SELF, &end);
		double	time = end.ru_utime.tv_sec - start.ru_utime.tv_sec
			+ 1e-6 * (end.ru_utime.tv_usec - start.ru_utime.tv_usec);
		time = 1000000 * time / iterations;
		char	timestring[13];
		if (measure) {
			snprintf(timestring, sizeof(timestring), "%12.6f", time);
		} else {
			timestring[0] = '\0';
		}

		/* Resultate reportieren */
		if (match) {
			printf("%*s matches %*.*s%s\n", N, s2, -3*N, 3*N, regex, timestring);
		} else {
			printf("%*s doesn\'t match %*.*s%s\n", N, s2, -3*N, 3*N, regex, timestring);
		}
	}
	exit(EXIT_SUCCESS);
}
