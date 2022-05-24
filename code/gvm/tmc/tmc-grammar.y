%{
/*
 * parser for TM compiler
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <includes.h>
#include "tmc.h"
extern void    yyerror(char *errmsg);
extern int	yylex (void);
%}
%union {
	int	state;
	int	tapechar;
	int	movement;
}
%token <state>STATE
%token <tapechar>TAPECHAR
%type <movement>movement
%token ARROW LEFT RIGHT HALT
%%
program:	command
	|	program command
	;

command:	'(' STATE ',' TAPECHAR ')' ARROW '(' STATE ',' TAPECHAR ')' movement {
		int	nnodes = tm.nnodes + 1;
		tm.nodes = (tm_node_t *)realloc(tm.nodes, nnodes * sizeof(tm_node_t));
		tm.nodes[tm.nnodes].from_state = $2;
		tm.nodes[tm.nnodes].from_tapechar = $4;
		tm.nodes[tm.nnodes].to_state = $8;
		tm.nodes[tm.nnodes].to_tapechar = $10;
		tm.nodes[tm.nnodes].movement = $12;
		tm.nnodes = nnodes;
	}

movement:	LEFT	{ $$ = MOVEMENT_LEFT; }
	|	RIGHT	{ $$ = MOVEMENT_RIGHT; }
	|	HALT	{ $$ = MOVEMENT_HALT; }
	;
%%
