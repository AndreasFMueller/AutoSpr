%{
/*
 * lexer for the calculator 
 */
#include "grammar.h"
%}
%%
abs	{ return ABS; }
asinh	{ return ASINH; }
acosh	{ return ACOSH; }
atanh	{ return ATANH; }
sinh	{ return SINH; }
cosh	{ return COSH; }
tanh	{ return TANH; }
asin	{ return ASIN; }
acos	{ return ACOS; }
atan2	{ return ATAN2; }
atan	{ return ATAN; }
sin	{ return SIN; }
cos	{ return COS; }
tan	{ return TAN; }
hypot	{ return HYPOT; }
cbrt	{ return CBRT; }
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
erf	{ return ERF; }
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
