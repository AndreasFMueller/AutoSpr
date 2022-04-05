%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
extern void     yyerror(char *errmsg);
extern int      yylex(void);

#include <math.h>
%}
%union {
	double	value;
}
%token SIN COS TAN SQRT LOG EXP LOG10 LOG2 J0 J1 JN Y0 Y1 YN GAMMA
%token <value>NUMBER
%type <value>expr term factor
%%
calculator:
	|	exprline
	|	calculator exprline
	;
exprline:	expr '\n'		{ printf("result = %f\n", $1); }
	|	expr ';'		{ printf("result = %f;\n", $1); }
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
	|	SIN '(' expr ')'	{ $$ = sin($3); }
	|	COS '(' expr ')'	{ $$ = cos($3); }
	|	TAN '(' expr ')'	{ $$ = tan($3); }
	|	SQRT '(' expr ')'	{ $$ = sqrt($3); }
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
	;
%%

