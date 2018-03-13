%{
/*
 * lexer definition to recognize binary numbers divisible by 3
 *
 * (c) 2016 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <inttypes.h>
long	value(const char *s) {
	char	*end;
	return strtol(s, &end, 2);
}
%}
%%
(0|1(01*0)*1)*			{ printf("%s = %ld: divisible\n", yytext, value(yytext)); }
(0|(1(01*0)*1))*1(01*0)*	{ printf("%s = %ld: remainder 1\n", yytext, value(yytext)); }
0*1(01*0|10*1)*01* { printf("%s = %ld: remainder 2\n", yytext, value(yytext)); }
.*		{ printf("?\n"); }
\n		{ }
%%
