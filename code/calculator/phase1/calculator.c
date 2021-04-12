/*
 * calculator.c
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <stdio.h>
#include <stdlib.h>

extern int	yydebug;
extern int	yyparse();

void	yyerror(char *errmsg) {
}

int	yywrap() {
	return 1;
}

int	main(int argc, char *argv[]) {
	yydebug = 1;
	while (!feof(stdin)) {
		yyparse();
	}
	return 0;
}
