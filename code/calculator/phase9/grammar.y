%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
extern void     yyerror(char *errmsg);
extern int      yylex(void);

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
%token ABS
%token ASINH ACOSH ATANH SINH COSH TANH
%token ATAN2 HYPOT
%token ASIN ACOS ATAN SIN COS TAN
%token SQRT CBRT
%token LOG EXP LOG10 LOG2
%token J0 J1 JN Y0 Y1 YN GAMMA
%token ERF
%token PREVIOUS
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
	|	ABS '(' expr ')'	{ $$ = fabs($3); }
	|	SQRT '(' expr ')'	{ $$ = sqrt($3); }
	|	CBRT '(' expr ')'	{ $$ = cbrt($3); }
	|	ASINH '(' expr ')'	{ $$ = asinh($3); }
	|	ACOSH '(' expr ')'	{ $$ = acosh($3); }
	|	ATANH '(' expr ')'	{ $$ = atanh($3); }
	|	SINH '(' expr ')'	{ $$ = sinh($3); }
	|	COSH '(' expr ')'	{ $$ = cosh($3); }
	|	TANH '(' expr ')'	{ $$ = tanh($3); }
	|	ASIN '(' expr ')'	{ $$ = asin($3); }
	|	ACOS '(' expr ')'	{ $$ = acos($3); }
	|	ATAN '(' expr ')'	{ $$ = atan($3); }
	|	SIN '(' expr ')'	{ $$ = sin($3); }
	|	COS '(' expr ')'	{ $$ = cos($3); }
	|	TAN '(' expr ')'	{ $$ = tan($3); }
	|	LOG '(' expr ')'	{ $$ = log($3); }
	|	LOG10 '(' expr ')'	{ $$ = log10($3); }
	|	LOG2 '(' expr ')'	{ $$ = log2($3); }
	|	EXP '(' expr ')'	{ $$ = exp($3); }
	|	J0 '(' expr ')'		{ $$ = j0($3); }
	|	J1 '(' expr ')'		{ $$ = j1($3); }
	|	JN '(' expr ',' expr ')'{ $$ = jn($3, $5); }
	|	Y0 '(' expr ')'		{ $$ = y0($3); }
	|	Y1 '(' expr ')'		{ $$ = y1($3); }
	|	YN '(' expr ',' expr ')'{ $$ = yn($3, $5); }
	|	GAMMA '(' expr ')'	{ $$ = tgamma($3); }
	|	HYPOT '(' expr ',' expr ')' { $$ = hypot($3, $5); }
	|	ATAN2 '(' expr ',' expr ')' { $$ = atan2($3, $5); }
	|	ERF '(' expr ')'	{ $$ = erf($3); }
	|	factor '^' factor	{ $$ = pow($1, $3); }
	|	PREVIOUS		{ $$ = previous; }
	;
%%
