%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
#include "tree.h"
#include <math.h>
#include <stdlib.h>
#include "constants.h"

extern void     yyerror(char *errmsg);
extern int      yylex(void);

static int	promptcounter = 1;
static void	showprompt() {
	fprintf(stdout, "i%d> ", ++promptcounter);
	fflush(stdout);
}

static int	outputcounter = 0;
static int	showoutput(int newline) {
	int	indent = printf("o%d> ", ++outputcounter);
	if (newline) printf("\n");
	return indent;
}

static treenode_p	*history = NULL;
static int	currentsize = 0;
static int	increment = 10;
static void	history_add(treenode_p treenode) {
	if (outputcounter >= currentsize) {
		history = (treenode_p *)realloc(history, (currentsize += increment) * sizeof(treenode_p));
	}
	history[outputcounter-1] = treenode;
}
static treenode_p	history_get(int i) {
	if (i > outputcounter) {
		return NULL;
	}
	return history[i-1];
}

static treenode_p	previous = NULL;

static void	previous_save(treenode_p treenode) {
	previous = treenode;
}
%}
%union {
	treenode_p	treenode;
}
%token TREE
%token ABS
%token ASINH ACOSH ATANH SINH COSH TANH
%token ATAN2 HYPOT
%token ASIN ACOS ATAN SIN COS TAN
%token SQRT CBRT
%token LOG EXP LOG10 LOG2
%token J0 J1 JN Y0 Y1 YN GAMMA
%token BINOM MOD DIV
%token FLOOR TRUNC
%token RAND
%token ERF
%token PREVIOUS
%token PRINT
%token HISTORYLIST
%token <treenode>NUMBER
%token <treenode>REGISTER
%token <treenode>CONSTANT
%token <treenode>HISTORY
%type <treenode>expr term factor exprline
%%
calculator:
	|	exprline		{ showprompt(); }
	|	calculator exprline	{ showprompt(); }
	;

exprline:
		'\n'
	|	expr '\n'		{
						$$ = $1;
						showoutput(0);
						printf("%f\n", treenode_value($$));
						previous_save($$);
						history_add($$);
					}
	|	TREE PREVIOUS '\n'	{
						$$ = previous;
						treenode_show(stdout, showoutput(1), previous);
						history_add($$);
					}
	|	TREE expr '\n' 		{
						$$ = $2;
						treenode_show(stdout, showoutput(1), $$);
						previous_save($$);
						history_add($$);
					}
	|	PRINT expr '\n'		{
						$$ = $2;
						showoutput(0);
						treenode_print(stdout, $$);
						fprintf(stdout, "\n");
						previous_save($$);
						history_add($$);
					}
	|	HISTORYLIST '\n'		{
						for (int i = 0; i < outputcounter; i++) {
							treenode_p	p = history[i];
							fprintf(stdout, "o%d> ", i+1);
							if (NULL != p) {
								treenode_print(stdout, p);
							}
							fprintf(stdout, "\n");
						}
					}
	|	error '\n'		{
						fprintf(stderr, "error\n");
						yyerrok;
					}
	;

expr:		term			{
						$$ = treenode_new("expr ::= term", EXPR, $1, NULL);
					}
	|	'-' term		{
						$$ = treenode_new("expr ::= -expr", EXPR, treenode_terminal('-'), $2, NULL);
					}
	|	expr '+' term		{
						$$ = treenode_new("expr ::= expr + term", EXPR, $1, treenode_terminal('+'), $3, NULL);
					}
	|	expr '-' term		{
						$$ = treenode_new("expr ::= expr - term", EXPR, $1, treenode_terminal('-'), $3, NULL);
					}
	;

term:		term '*' factor		{
						$$ = treenode_new("term ::= term * factor", TERM, $1, treenode_terminal('*'), $3, NULL);
					}
	|	term '/' factor		{
						$$ = treenode_new("term ::= term / factor", TERM, $1, treenode_terminal('/'), $3, NULL);
					}
	|	term '%' factor		{
						$$ = treenode_new("term ::= term % factor", TERM, $1, treenode_terminal('%'), $3, NULL);
					}
	|	factor			{
						$$ = treenode_new("term ::= factor", TERM, $1, NULL); $$->value = $1->value; }
	;

factor:		'(' expr ')'		{
						$$ = treenode_new("factor", FACTOR, treenode_terminal('('), $2, treenode_terminal(')'), NULL);
					}
	|	NUMBER			{
						$$ = $1;
					}
	|	factor '!' 		{
						$$ = treenode_new("factorial", FACTOR, $1, treenode_terminal('!'), NULL);
					}
	|	REGISTER		{
						$$ = $1;
					}
	|	REGISTER '=' expr	{
						$$ = treenode_new("assign", FACTOR, $1, treenode_terminal('='), $3);
					}
	|	CONSTANT		{
						$$ = $1;
					}
	|	ABS '(' expr ')'	{
						$$ = treenode_new("abs", ABS, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
						$$->value = fabs($3->value);
					}
	|	SQRT '(' expr ')'	{
						$$ = treenode_new("sqrt", SQRT, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
						$$->value = sqrt($3->value);
					}
	|	CBRT '(' expr ')'	{
						$$ = treenode_new("cbrt", CBRT, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
						$$->value = cbrt($3->value);
					}
	|	ASINH '(' expr ')'	{
						$$ = treenode_new("asinh", ASINH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
						$$->value = asinh($3->value);
					}
	|	ACOSH '(' expr ')'	{
						$$ = treenode_new("acosh", ACOSH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	ATANH '(' expr ')'	{
						$$ = treenode_new("atanh", ATANH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	SINH '(' expr ')'	{
						$$ = treenode_new("sinh", SINH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	COSH '(' expr ')'	{
						$$ = treenode_new("cosh", COSH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	TANH '(' expr ')'	{
						$$ = treenode_new("tanh", TANH, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	ASIN '(' expr ')'	{
						$$ = treenode_new("asin", ASIN, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	ACOS '(' expr ')'	{
						$$ = treenode_new("acos", ACOS, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	ATAN '(' expr ')'	{
						$$ = treenode_new("atan", ATAN, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	SIN '(' expr ')'	{
						$$ = treenode_new("sin", SIN, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	COS '(' expr ')'	{
						$$ = treenode_new("cos", COS, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	TAN '(' expr ')'	{
						$$ = treenode_new("tan", TAN, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	LOG '(' expr ')'	{
						$$ = treenode_new("log", LOG, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	LOG10 '(' expr ')'	{
						$$ = treenode_new("log10", LOG10, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	LOG2 '(' expr ')'	{
						$$ = treenode_new("log2", LOG2, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	EXP '(' expr ')'	{
						$$ = treenode_new("exp", EXP, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	J0 '(' expr ')'		{
						$$ = treenode_new("j0", J0, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	J1 '(' expr ')'		{
						$$ = treenode_new("j1", J1, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	JN '(' expr ',' expr ')'{
						$$ = treenode_new("jn", JN, treenode_terminal('('), $3, $5, treenode_terminal(')'), NULL);
					}
	|	Y0 '(' expr ')'		{
						$$ = treenode_new("y0", Y0, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	Y1 '(' expr ')'		{
						$$ = treenode_new("y1", Y1, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	YN '(' expr ',' expr ')'{
						$$ = treenode_new("yn", YN, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	GAMMA '(' expr ')'	{
						$$ = treenode_new("tgamma", GAMMA, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	HYPOT '(' expr ',' expr ')' {
						$$ = treenode_new("hypot", HYPOT, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	ATAN2 '(' expr ',' expr ')' {
						$$ = treenode_new("atan2", ATAN2, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	BINOM '(' expr ',' expr ')' {
						$$ = treenode_new("binom", BINOM, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	MOD '(' expr ',' expr ')' {
						$$ = treenode_new("binom", MOD, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	DIV '(' expr ',' expr ')' {
						$$ = treenode_new("binom", DIV, treenode_terminal('('), $3, treenode_terminal(','), $5, treenode_terminal(')'), NULL);
					}
	|	FLOOR '(' expr ')'	{
						$$ = treenode_new("floor", FLOOR, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	TRUNC '(' expr ')'	{
						$$ = treenode_new("trunc", TRUNC, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	ERF '(' expr ')'	{
						$$ = treenode_new("erf", ERF, treenode_terminal('('), $3, treenode_terminal(')'), NULL);
					}
	|	RAND '(' ')'		{
						$$ = treenode_new("rand", RAND, treenode_terminal('('), treenode_terminal(')'), NULL);
					}
	|	factor '^' factor	{
						$$ = treenode_new("pow", FACTOR, $1, treenode_terminal('^'), $3, NULL);
					}
	|	factor factor		{
						$$ = treenode_new("factor * factor", FACTOR, $1, $2, NULL);
					}
	|	PREVIOUS		{
						$$ = treenode_copy(previous);
					}
	|	HISTORY			{
						int	i = atoi($1->nodename);
						treenode_p	h = history_get(i);
						if (NULL != h) {
							$$ = treenode_copy(h);
						} else {
							fprintf(stderr, "history entry not found\n");
							YYERROR;
						}
					}
	;
%%

