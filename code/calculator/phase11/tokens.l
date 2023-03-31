%{
/*
 * lexer for the calculator 
 */
#include "tree.h"
#include "grammar.h"
%}
%%
tree	{ return TREE; }
print	{ return PRINT; }
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
binom	{ return BINOM; }
mod	{ return MOD; }
div	{ return DIV; }
floor	{ return FLOOR; }
trunc	{ return TRUNC; }
rand	{ return RAND; }
history	{ return HISTORYLIST; }
\%\%	{ return PREVIOUS; }
\%[a-z]+	{
			yylval.treenode = treenode_new(yytext + 1, CONSTANT, NULL);
			return CONSTANT;
		}
%[0-9]+	{
			yylval.treenode = treenode_new(yytext + 1, HISTORY, NULL);
			return HISTORY;
		}
r[0-9][0-9]?	{
			yylval.treenode = treenode_new(yytext + 1, REGISTER, NULL);
			return REGISTER;
		}
[0-9]+(\.[0-9]*)?([eE]-?[0-9]+)?	{
					yylval.treenode = treenode_new(yytext, NUMBER, NULL);
					yylval.treenode->value = atof(yytext);
					return NUMBER;
				}
[+/\-*^!=]	{ return yytext[0]; }
\(|\)	{ return yytext[0]; }
" "	{ }
,	{ return ','; }
\n	{ return '\n'; }
%%
