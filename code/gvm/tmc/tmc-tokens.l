%{
/*
 * lexer definition for the Turing machine compiler
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 * $Id$
 */
#include <tmc-grammar.h>
#undef YY_INPUT
#define YY_INPUT(b, r, ms) ( r = tmc_read(b, ms))
#undef yywrap
%}
%x tapealphabet
%%

"//"[^\n]*\n	
->	{ return ARROW; }
[0-9]+	{
		yylval.state = atoi(yytext);
		return STATE;
	}
[()]	{
		return yytext[0];
	}
Left	{ return LEFT; }
Right	{ return RIGHT; }
Halt	{ return HALT; }

,	{
		BEGIN(tapealphabet);
		return yytext[0];
	}
<tapealphabet>.	{
		yylval.tapechar = yytext[0];
		BEGIN(INITIAL);
		return TAPECHAR;
	}

.	{ }
\n	{ }
%%
