%{
/*
 * parser for the GVM 
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <includes.h>
#include <gvm.h>
#include <utils.h>
extern int 	yylineno;

/* when allocating memory for the vm, do it in chunks */
#define	ALLOC_CHUNK	100	
%}
%union {
	int	lineno;
	int	varno;
	mpz_t	constant;
	gvm_node_t	node;
	char	operator;
	char	*string;
}
%token <lineno>LINENO
%token <lineno>GOTO
%token <varno>VARIABLE
%token PRINTVAR
%token PRINTTM
%token PRINTSTRING
%token <constant>CONSTANT
%token <operator>OPERATOR
%token ASSIGN IF
%type <node>expression
%token HALT
%token <string>STRING
%%
program:
	|	line
	|	program line
	;

line:	LINENO expression '\n'	{
			int	newlineno = $1;
			if (yydebug) {
				printf("program so far:\n");
				gvm_display(&gvm);
				printf("adding line %d\n", newlineno);
			}
			if (1 == (newlineno % ALLOC_CHUNK)) {
				int	nn = 1 + (newlineno / ALLOC_CHUNK);
				nn *= ALLOC_CHUNK;
				if (yydebug) {
					printf("reallocating %p to size %lu\n",
						nn, nn * sizeof(gvm_node_t));
				}
				gvm.nodes = (gvm_node_t *)realloc(gvm.nodes,
					nn * sizeof(gvm_node_t));
				for (int i = gvm.nnodes; i < nn; i++) {
					gvm.nodes[i].type = 0;
				}
				gvm.nnodes = nn;
			}
			memcpy(&(gvm.nodes[$1 - 1]), &$2, sizeof(gvm_node_t));
			if (yydebug) {
				printf("copying %lu bytes from %p to %p\n",
					sizeof(gvm_node_t),
					&$2, &(gvm.nodes[$1 - 1]));
				printf("program now:\n");
				gvm_display(&gvm);
			}
		}
	;

expression:	VARIABLE ASSIGN CONSTANT {
			$$.type = GVM_NODE_ASSIGN_CONSTANT;
			$$.u.a.target_varno = $1;
			mpz_init_set($$.u.a.constant, $3);
		}
	|	VARIABLE ASSIGN VARIABLE {
			$$.type = GVM_NODE_ASSIGN_VARIABLE;
			$$.u.a.target_varno = $1;
			$$.u.a.source_varno = $3;
		}
	|	VARIABLE ASSIGN VARIABLE OPERATOR CONSTANT {
			$$.type = GVM_NODE_ASSIGN_OPERATOR_CONST;
			$$.u.a.target_varno = $1;
			$$.u.a.source_varno = $3;
			$$.u.a.operator = $4;
			mpz_init_set($$.u.a.constant, $5);
		}
	|	VARIABLE ASSIGN VARIABLE OPERATOR VARIABLE {
			$$.type = GVM_NODE_ASSIGN_OPERATOR;
			$$.u.a.target_varno = $1;
			$$.u.a.operator = $4;
			$$.u.a.source_varno = $3;
			$$.u.a.source2_varno = $5;
		}
	|	GOTO CONSTANT		{
			$$.type = GVM_NODE_GOTO;
			$$.u.g.target = mpz_get_ui($2) - 1;
		}
	|	IF VARIABLE '=' CONSTANT GOTO CONSTANT {
			$$.type = GVM_NODE_CONDITIONAL_GOTO;
			$$.u.g.condition_varno = $2;
			$$.u.g.condition_constant = mpz_get_ui($4);
			$$.u.g.target = mpz_get_ui($6) - 1;
		}
	|	HALT	{
			$$.type = GVM_NODE_HALT;
		}
	|	PRINTVAR VARIABLE {
			$$.type = GVM_NODE_PRINTVAR;
			$$.u.p.varno = $2;
		}
	|	PRINTSTRING STRING {
			$$.type = GVM_NODE_PRINTSTRING;
			$$.u.p.string = strdup($2);
		}
	|	PRINTTM {
			$$.type = GVM_NODE_PRINTTM;
		}
	;

%%
