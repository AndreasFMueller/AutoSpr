%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
#include "tree.h"
#include "help.h"
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
%token TREE EXIT
%token FORMAT DEFAULT FIXED FLOAT
%token ABS
%token ASINH ACOSH ATANH SINH COSH TANH
%token ATAN2 HYPOT
%token ASIN ACOS ATAN SIN COS TAN
%token SQRT CBRT SQR
%token LOG EXP LOG10 LOG2
%token J0 J1 JN Y0 Y1 YN GAMMA
%token BINOM MOD DIV
%token FLOOR TRUNC
%token RAND
%token ERF
%token PREVIOUS
%token PRINT
%token HISTORYLIST
%token <treenode>NUMBER REGISTER CONSTANT
%token <treenode>HISTORY PRECISION HELP
%type <treenode>expr term factor exprline
%%
calculator:
	|	exprline		{ showprompt(); }
	|	calculator exprline	{ showprompt(); }
	;

exprline:
		'\n'			{ $$ = NULL; }
	|	expr '\n'		{
						$$ = $1;
						showoutput(0);
						treenode_format_number(stdout, tree_value($$));
						printf("\n");
						previous_save($$);
						history_add($$);
					}
	|	PREVIOUS '\n'		{
						$$ = previous;
						showoutput(0);
						treenode_format_number(stdout, tree_value($$));
						printf("\n");
						previous_save($$);
						history_add($$);
					}
	|	TREE PREVIOUS '\n'	{
						$$ = previous;
						tree_show(stdout, "", previous);
						history_add($$);
					}
	|	TREE expr '\n' 		{
						$$ = $2;
						tree_show(stdout, "", $$);
						previous_save($$);
						history_add($$);
					}
	|	PRINT expr '\n'		{
						$$ = $2;
						showoutput(0);
						tree_print(stdout, $$);
						fprintf(stdout, "\n");
						previous_save($$);
						history_add($$);
					}
	|	HISTORYLIST '\n'		{
						for (int i = 0; i < outputcounter; i++) {
							treenode_p	p = history[i];
							fprintf(stdout, "o%d> ", i+1);
							if (NULL != p) {
								tree_print(stdout, p);
							}
							fprintf(stdout, "\n");
						}
					}
	|	PRECISION NUMBER '\n'	{
						tree_precision = $2->value;
						$$ = NULL;
					}
	|	FORMAT DEFAULT '\n'		{
						tree_format = TREE_FORMAT_DEFAULT;
						$$ = NULL;
					}
	|	FORMAT FIXED '\n'	{
						tree_format = TREE_FORMAT_FIXED;
						$$ = NULL;
					}
	|	FORMAT FLOAT '\n'	{
						tree_format = TREE_FORMAT_FLOAT;
						$$ = NULL;
					}
	|	HELP '\n' 		{
						help();
						$$ = NULL;
					}
	|	EXIT '\n'		{
						exit(EXIT_SUCCESS);
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
						$$ = treenode_new("expr ::= -expr", EXPR, treenode_terminal("-"), $2, NULL);
					}
	|	expr '+' term		{
						$$ = treenode_new("expr ::= expr + term", EXPR, $1, treenode_terminal("+"), $3, NULL);
					}
	|	expr '-' term		{
						$$ = treenode_new("expr ::= expr - term", EXPR, $1, treenode_terminal("-"), $3, NULL);
					}
	;

term:		term '*' factor		{
						$$ = treenode_new("term ::= term * factor", TERM, $1, treenode_terminal("*"), $3, NULL);
					}
	|	term '/' factor		{
						$$ = treenode_new("term ::= term / factor", TERM, $1, treenode_terminal("/"), $3, NULL);
					}
	|	term '%' factor		{
						$$ = treenode_new("term ::= term % factor", TERM, $1, treenode_terminal("%"), $3, NULL);
					}
	|	factor			{
						$$ = treenode_new("term ::= factor", TERM, $1, NULL); $$->value = $1->value; }
	;

factor:		'(' expr ')'		{
						$$ = treenode_new("factor", FACTOR, treenode_terminal("("), $2, treenode_terminal(")"), NULL);
					}
	|	NUMBER			{
						$$ = $1;
					}
	|	factor '!' 		{
						$$ = treenode_new("factorial", FACTOR, $1, treenode_terminal("!"), NULL);
					}
	|	REGISTER		{
						$$ = $1;
					}
	|	REGISTER '=' expr	{
						$$ = treenode_new("assign", FACTOR, $1, treenode_terminal("="), $3, NULL);
					}
	|	CONSTANT		{
						$$ = $1;
					}
	|	ABS '(' expr ')'	{
						$$ = treenode_new("factor", ABS, treenode_terminal("abs"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	SQRT '(' expr ')'	{
						$$ = treenode_new("factor", SQRT, treenode_terminal("sqrt"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	SQR '(' expr ')'	{
						$$ = treenode_new("factor", SQR, treenode_terminal("sqr"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	CBRT '(' expr ')'	{
						$$ = treenode_new("factor", CBRT, treenode_terminal("cbrt"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ASINH '(' expr ')'	{
						$$ = treenode_new("factor", ASINH, treenode_terminal("asinh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ACOSH '(' expr ')'	{
						$$ = treenode_new("factor", ACOSH, treenode_terminal("acosh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ATANH '(' expr ')'	{
						$$ = treenode_new("factor", ATANH, treenode_terminal("atanh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	SINH '(' expr ')'	{
						$$ = treenode_new("factor", SINH, treenode_terminal("sinh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	COSH '(' expr ')'	{
						$$ = treenode_new("factor", COSH, treenode_terminal("cosh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	TANH '(' expr ')'	{
						$$ = treenode_new("factor", TANH, treenode_terminal("tanh"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ASIN '(' expr ')'	{
						$$ = treenode_new("factor", ASIN, treenode_terminal("asin"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ACOS '(' expr ')'	{
						$$ = treenode_new("factor", ACOS, treenode_terminal("acos"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ATAN '(' expr ')'	{
						$$ = treenode_new("factor", ATAN, treenode_terminal("atan"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	SIN '(' expr ')'	{
						$$ = treenode_new("factor", SIN, treenode_terminal("sin"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	COS '(' expr ')'	{
						$$ = treenode_new("factor", COS, treenode_terminal("cos"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	TAN '(' expr ')'	{
						$$ = treenode_new("factor", TAN, treenode_terminal("tan"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	LOG '(' expr ')'	{
						$$ = treenode_new("factor", LOG, treenode_terminal("log"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	LOG10 '(' expr ')'	{
						$$ = treenode_new("factor", LOG10, treenode_terminal("log10"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	LOG2 '(' expr ')'	{
						$$ = treenode_new("factor", LOG2, treenode_terminal("log2"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	EXP '(' expr ')'	{
						$$ = treenode_new("factor", EXP, treenode_terminal("exp"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	J0 '(' expr ')'		{
						$$ = treenode_new("factor", J0, treenode_terminal("j0"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	J1 '(' expr ')'		{
						$$ = treenode_new("factor", J1, treenode_terminal("j1"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	JN '(' expr ',' expr ')'{
						$$ = treenode_new("factor", JN, treenode_terminal("jn"), treenode_terminal("("), $3, $5, treenode_terminal(")"), NULL);
					}
	|	Y0 '(' expr ')'		{
						$$ = treenode_new("factor", Y0, treenode_terminal("y0"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	Y1 '(' expr ')'		{
						$$ = treenode_new("factor", Y1, treenode_terminal("y1"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	YN '(' expr ',' expr ')'{
						$$ = treenode_new("factor", YN, treenode_terminal("yn"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	GAMMA '(' expr ')'	{
						$$ = treenode_new("factor", GAMMA, treenode_terminal("tgamma"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	HYPOT '(' expr ',' expr ')' {
						$$ = treenode_new("factor", HYPOT, treenode_terminal("hypot"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	ATAN2 '(' expr ',' expr ')' {
						$$ = treenode_new("factor", ATAN2, treenode_terminal("atan2"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	BINOM '(' expr ',' expr ')' {
						$$ = treenode_new("factor", BINOM, treenode_terminal("binom"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	MOD '(' expr ',' expr ')' {
						$$ = treenode_new("factor", MOD, treenode_terminal("mod"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	DIV '(' expr ',' expr ')' {
						$$ = treenode_new("factor", DIV, treenode_terminal("mod"), treenode_terminal("("), $3, treenode_terminal(","), $5, treenode_terminal(")"), NULL);
					}
	|	FLOOR '(' expr ')'	{
						$$ = treenode_new("factor", FLOOR, treenode_terminal("floor"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	TRUNC '(' expr ')'	{
						$$ = treenode_new("factor", TRUNC, treenode_terminal("trunc"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	ERF '(' expr ')'	{
						$$ = treenode_new("factor", ERF, treenode_terminal("erf"), treenode_terminal("("), $3, treenode_terminal(")"), NULL);
					}
	|	RAND '(' ')'		{
						$$ = treenode_new("factor", RAND, treenode_terminal("rand"), treenode_terminal("("), treenode_terminal(")"), NULL);
					}
	|	factor '^' factor	{
						$$ = treenode_new("factor", FACTOR, $1, treenode_terminal("^"), $3, NULL);
					}
	|	factor factor		{
						$$ = treenode_new("factor factor", FACTOR, $1, $2, NULL);
					}
	|	PREVIOUS		{
						$$ = tree_copy(previous);
					}
	|	HISTORY			{
						int	i = atoi($1->nodename);
						treenode_p	h = history_get(i);
						if (NULL != h) {
							$$ = tree_copy(h);
						} else {
							fprintf(stderr, "history entry not found\n");
							YYERROR;
						}
					}
	;
%%

