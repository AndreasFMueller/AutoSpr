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
j0	{ return J0; }
j1	{ return J1; }
jn	{ return JN; }
y0	{ return Y0; }
y1	{ return Y1; }
yn	{ return YN; }
gamma	{ return GAMMA; }
[0-9]+(\.[0-9]*)?([eE]-?[0-9]+)?	{
					yylval.value = atof(yytext);
					printf("value = %f\n", yylval.value);
					return NUMBER;
				}
[+/\-*]	{ return yytext[0]; }
\(|\)	{ return yytext[0]; }
" "	{ }
,	{ return ','; }
;	{ return ';'; }
\n	{ return '\n'; }
%%
