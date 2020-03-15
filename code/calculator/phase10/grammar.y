%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
#include <math.h>
#include "constants.h"

double	registers[100];
double	previous;
%}
%union {
	int	reg;
	double	value;
	char	name[10];
}
%token SIN COS TAN SQRT LOG EXP LOG10 LOG2 PREVIOUS
%token <value>NUMBER
%token <reg>REGISTER
%token <name>CONSTANT
%type <value>expr term factor
%%
calculator:
	|	exprline
	|	calculator exprline
	;
exprline:	expr '\n'		{ printf("result = %f\n", $1); previous = $1; }
	|	expr ';'		{ printf("result = %f;\n", $1); previous = $1; }
	|	REGISTER '=' expr ';'	{ registers[$1] = $3; previous = $3; }
	|	REGISTER '=' expr '\n'	{ registers[$1] = $3; previous = $3; }
	;
expr:		term			{ $$ = $1; }
	|	'-' term		{ $$ = -$2; }
	|	expr '+' term		{ $$ = $1 + $3; }
	|	expr '-' term		{ $$ = $1 - $3; }
	;
term:		term '*' factor		{ $$ = $1 * $3; }
	|	term '/' factor		{ $$ = $1 / $3; }
	|	factor			{ $$ = $1; }
	;
factor:		'(' expr ')'		{ $$ = $2; }
	|	NUMBER			{ $$ = $1; }
	|	REGISTER		{ $$ = registers[$1]; }
	|	CONSTANT		{ $$ = constant($1); }
	|	SIN '(' expr ')'	{ $$ = sin($3); }
	|	COS '(' expr ')'	{ $$ = cos($3); }
	|	TAN '(' expr ')'	{ $$ = tan($3); }
	|	SQRT '(' expr ')'	{ $$ = sqrt($3); }
	|	LOG '(' expr ')'	{ $$ = log($3); }
	|	LOG10 '(' expr ')'	{ $$ = log10($3); }
	|	LOG2 '(' expr ')'	{ $$ = log2($3); }
	|	EXP '(' expr ')'	{ $$ = exp($3); }
	|	factor '^' factor	{ $$ = pow($1, $3); }
	|	factor factor		{ $$ = $1 * $2; }
	|	PREVIOUS		{ $$ = previous; }
	;
%%

