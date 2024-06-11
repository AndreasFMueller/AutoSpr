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
#include <cstdio>
#include <cstdlib>
#include <getopt.h>
#include <iostream>

#define	N	30

static void     usage(const char *progname) {
	std::cout << "measure matching speed for std::regex" << std::endl;
	std::cout << "usage:" << std::endl;
	std::cout << "    " << progname << " [ -h?m ] [ -r,--repetitions=<r> ]" << std::endl;
	std::cout << "options:" << std::endl;
	std::cout << "  --help,-h,-?          display this help message and exit" << std::endl;
	std::cout << "  --measure             whether or not to measure" << std::endl;
	std::cout << "  --repetitions=<i>     number of repetitions for measurement" << std::endl;
}

struct option   options[] = {
{ "help",		no_argument,		NULL,	'h' },
{ "measure",		no_argument,		NULL,	'm' },
{ "repetitions",	required_argument,	NULL,	'r' },
{ NULL,			0,			NULL,	 0  }
};

int	main(int argc, char *argv[]) {
	int	repetitions = 1000;
	bool	measure = false;

	/* kommandozeile */
	int	c;
	int	longindex;
	while (EOF != (c = getopt_long(argc, argv, "h?r:m:", options, &longindex)))
		switch (c) {
		case 'h':
		case '?':
			usage(argv[0]);
			break;
		case 'm':
			measure = true;
			break;
		case 'r':
			repetitions = std::stoi(optarg);
			break;
		}

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
		RE2	re(expr);
		bool	match = false;
		int	counter = (measure) ? repetitions : 1;
                auto beginonce = std::chrono::high_resolution_clock::now();
		while (counter-- > 0) {
			match = RE2::FullMatch(s2, re);
		}
                auto endonce = std::chrono::high_resolution_clock::now();
                counter = (measure) ? repetitions : 1;
                double  t = std::chrono::duration_cast<std::chrono::nanoseconds>(endonce - beginonce).count() * 1e-3 / counter;
		char	timestring[20];
		snprintf(timestring, sizeof(timestring), "%10.6f", t);
		printf("%*s %s %*.*s%s\n", N, s2,
			(match) ? "matches" : "doesn't match" , -3*N, 3*N, expr, timestring);
	}
	exit(EXIT_SUCCESS);
}
