#include "regex.h"
#include <getopt.h>

#include <iostream>

static void	usage(const char *progname) {
	std::cout << "measure matching speed for std::regex" << std::endl;
	std::cout << "usage:" << std::endl;
	std::cout << "    " << progname << " [ -h?m ] [ -n,--length=<n> ] [ -r,--repetitions=<r> ]" << std::endl;
	std::cout << "options:" << std::endl;
	std::cout << "  --help,-h,-?          display this help message and exit" << std::endl;
	std::cout << "  --length=<n>          maximum length of regex" << std::endl;
	std::cout << "  --repetitions=<i>     number of repetitions for measurement" << std::endl;
}

struct option	options[] = {
{ "length",		required_argument,	NULL,	'n' },
{ "help",		no_argument,		NULL,	'h' },
{ "measure",		no_argument,		NULL,	'm' },
{ "repetitions",	required_argument,	NULL,	'r' },
{ NULL,		0,				NULL,	 0  }
};

int main(int argc, char *argv[]) {
	int	c;
	int	longindex;
	int	n = 26;
	bool	measure = false;
	int	repetitions = 1000;
	while (EOF != (c = getopt_long(argc, argv, "h?r:mn:", options, &longindex)))
		switch (c) {
		case 'h':
		case '?':
			usage(argv[0]);
			return EXIT_SUCCESS;
		case 'n':
			n = std::stoi(optarg);
			break;
		case 'r':
			repetitions = std::stoi(optarg);
			break;
		case 'm':
			measure = true;
			break;
		}
	Regex::test(std::cout, n, repetitions, measure);
}
