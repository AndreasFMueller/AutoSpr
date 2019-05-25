%{
/*
 * lexer for the calculator 
 */
#include "grammar.h"
%}
%%
sin	{ return SIN; }
cos	{ return COS; }
tan	{ return TAN; }
sqrt	{ return SQRT; }
log	{ return LOG; }
log10	{ return LOG10; }
log2	{ return LOG2; }
exp	{ return EXP; }
\%\%	{ return PREVIOUS; }
\%[a-z]+	{
			strncpy(yylval.name, yytext + 1, 9);
			return CONSTANT;
		}
r[0-9][0-9]?	{
			yylval.reg = atoi(yytext + 1);
			return REGISTER;
		}
[0-9]+(\.[0-9]*)?([eE]-?[0-9]+)?	{
					yylval.value = atof(yytext);
					printf("value = %f\n", yylval.value);
					return NUMBER;
				}
[+/\-*^=]	{ return yytext[0]; }
\(|\)	{ return yytext[0]; }
" "	{ }
;	{ return ';'; }
\n	{ return '\n'; }
%%
