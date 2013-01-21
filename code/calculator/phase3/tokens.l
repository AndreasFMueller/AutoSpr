%{
/*
 * lexer for the calculator 
 */
#include "grammar.h"
%}
%%
[0-9]+(\.[0-9]*)?([eE]-?[0-9]+)?	{
					yylval.value = atof(yytext);
					return NUMBER;
				}
[+/\-*]	{ return yytext[0]; }
\(|\)	{ return yytext[0]; }
" "	{ }
;	{ return ';'; }
\n	{ return '\n'; }
%%
