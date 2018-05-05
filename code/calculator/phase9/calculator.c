/*
 * calculator.c
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <unistd.h>

extern int	yydebug;

void	yyerror(char *errmsg) {
	fprintf(stderr, "error: %s\n", errmsg);
}

int	yywrap() {
	return 1;
}

int	main(int argc, char *argv[]) {
	yydebug = 0;
	int	c;
	while (EOF != (c = getopt(argc, argv, "d")))
		switch (c) {
		case 'd':	yydebug = 1;
				break;
		}
	while (!feof(stdin)) {
		yyparse();
	}
	return 0;
}
