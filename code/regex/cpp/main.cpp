#include "regex.h"
#include <getopt.h>

#include <iostream>

struct option	options[] = {
{ "length",	required_argument,	NULL,	'n' },
{ NULL,		0,			NULL,	 0  }
};

int main(int argc, char *argv[]) {
	int	c;
	int	longindex;
	int	n = 26;
	while (EOF != (c = getopt_long(argc, argv, "n:", options, &longindex)))
		switch (c) {
		case 'n':
			n = std::stoi(optarg);
			break;
		}
	Regex::test(std::cout, n);
}
