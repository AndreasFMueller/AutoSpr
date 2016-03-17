/*
 * d3.c -- test for divisibility by 3
 *
 * (c) 2016 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <stdio.h>
#include <stdlib.h>

int	yylex();

int	yywrap() {
	exit(EXIT_SUCCESS);
}

int	main(int argc, char *argv[]) {
	while (!feof(stdin)) {
		yylex();
	}
	return EXIT_SUCCESS;
}
