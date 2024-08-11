/*
 * gvm.h -- goto virtual machine declarations
 *
 * (c) 2012-2024 Prof Dr Andreas Mueller
 */
#ifndef _gvm_h
#define _gvm_h

#include <includes.h>

#define	GVM_NODE_NONE				0
#define	GVM_NODE_ASSIGN_CONSTANT		1
#define	GVM_NODE_ASSIGN_VARIABLE		2
#define GVM_NODE_ASSIGN_OPERATOR_CONST		3
#define GVM_NODE_ASSIGN_OPERATOR		4
#define GVM_NODE_CONDITIONAL_GOTO		5
#define	GVM_NODE_GOTO				6
#define	GVM_NODE_HALT				7
#define	GVM_NODE_PRINTSTRING			8
#define GVM_NODE_PRINTVAR			9
#define GVM_NODE_PRINTTM			10
#define GVM_NODE_PRINTSTEPS			11

typedef struct gvm_assign_s {
	int	target_varno;
	int	source_varno;
	char	operator;
	int	source2_varno;
	mpz_t	constant;
} gvm_assign_t;

typedef struct gvm_goto_s {
	int	condition_varno;
	int	condition_constant;
	int	target;
} gvm_goto_t;

typedef union gvm_print_u {
	char	*string;
	int	varno;
} gvm_print_t;

typedef struct gvm_node_s {
	int	type;
	union gvm_node_payload_u {
		gvm_assign_t	a;
		gvm_goto_t	g;
		gvm_print_t	p;
	} u;
} gvm_node_t;

typedef struct gvm_s {
	int		nnodes;
	gvm_node_t	*nodes;
	int		nvars;
	mpz_t		*vars;
	int		sleep;
	int		steps;
} gvm_t;

extern gvm_t	gvm;

#endif /* _gvm_h */

