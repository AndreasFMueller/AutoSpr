/*
 * tree.c
 *
 * (c) 2023 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule 
 */
#include "tree.h"
#include "grammar.h"
#include "constants.h"
#include "functions.h"
#include <math.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

static int	treedebug = 0;
static double	registers[100];

treenode_p	treenode_new(char *name, int nodetype,
			treenode_p children, ...) {
	treenode_p	result = (treenode_p)malloc(sizeof(treenode_t));
	if (treedebug)
		fprintf(stderr, "new node %s (%d) at %p\n", name, nodetype, result);
	result->nodename = strdup(name);
	result->nodetype = nodetype;
	result->value = 0;
	result->children = (treenode_p*)malloc(sizeof(treenode_p));
	result->children[0] = NULL;
	int	length = 1;
	if (NULL == children) {
		return result;
	}
	treenode_add(result, children);
	va_list	ap;
	va_start(ap, children);
	treenode_p	child;
	while (NULL != (child = va_arg(ap, treenode_p))) {
		treenode_add(result, child);
	}
	va_end(ap);
	if (treedebug) {
		fprintf(stderr, "added %d children:", length - 1);
		for (treenode_p *p = result->children; *p; p++) {
			fprintf(stderr, " %p", *p);
		}
		fprintf(stderr, "\n");
	}
	return result;
}

treenode_p	treenode_terminal(char t) {
	char	v[2];
	v[0] = t;
	v[1] = '\0';
	return treenode_new(v, TERMINAL, NULL);
}

treenode_p	treenode_copy(treenode_p treenode) {
	treenode_p	result = treenode_new(treenode->nodename, treenode->nodetype, NULL);
	result->value = treenode->value;
	for (treenode_p *p = treenode->children; *p; p++) {
		treenode_add(result, treenode_copy(*p));
	}
	return result;
}

void	treenode_free(treenode_p treenode) {
	for (treenode_p *p = treenode->children; *p; p++) {
		treenode_free(*p);
	}
	free(treenode->children);
	free(treenode->nodename);
}

void	treenode_add(treenode_p treenode, treenode_p child) {
	int	length = treenode_children(treenode) + 2;
	if (treedebug)
		fprintf(stderr, "adding child %d: %p @ %p\n", length - 1, child, treenode->children + (length-2));
	treenode->children = (treenode_p*)realloc(treenode->children,
		length * sizeof(treenode_p));
	treenode->children[length - 2] = child;
	treenode->children[length - 1] = NULL;
}

void	treenode_show(FILE *out, int indent, treenode_p treenode) {
	if (NULL == treenode) {
		return;
	}
	fprintf(out, "%*.*s", indent, indent, "");
	switch (treenode->nodetype) {
	case CONSTANT:
		fprintf(out, "CONSTANT %s\n", treenode->nodename);
		return;
	case NUMBER:
		fprintf(out, "NUMBER %f\n", treenode->value);
		return;
	default:
		fprintf(out, "%s\n",
			(treenode->nodename) ? treenode->nodename : "(null)");
	}
	treenode_p	*p;
	for (p = treenode->children; NULL != *p; p++) {
		treenode_show(out, indent + 2, *p);
	}
}

int	treenode_children(treenode_p treenode) {
	int	counter = 0;
	treenode_p	*p;
	for (p = treenode->children; *p; p++)
		counter++;
	return counter;
}

treenode_p	treenode_child(treenode_p treenode, int i) {
	assert(i < treenode_children(treenode));
	return treenode->children[i];
}

double	treenode_expr_value(treenode_p treenode) {
	assert(EXPR == treenode->nodetype);
	switch (treenode_children(treenode)) {
	case 1:
		return treenode_value(treenode_child(treenode, 0));
		break;
	case 2:
		return -treenode_value(treenode_child(treenode, 1));
		break;
	case 3: {
			double	operand1 = treenode_value(treenode_child(treenode, 0));
			double	operand2 = treenode_value(treenode_child(treenode, 2));
			char	operator = treenode_child(treenode, 1)->nodename[0];
			switch (operator) {
			case '+':
				return operand1 + operand2;
			case '-':
				return operand1 - operand2;
			default:
				fprintf(stderr, "unknown operator: %c\n", operator);
			}
		}
	default:
		fprintf(stderr, "internal error\n");
	}
	return 0;
}

double	treenode_term_value(treenode_p treenode) {
	assert(TERM == treenode->nodetype);
	switch (treenode_children(treenode)) {
	case 1:
		return treenode_value(treenode_child(treenode, 0));
	case 3:	{
			double	operand1 = treenode_value(treenode_child(treenode, 0));
			double	operand2 = treenode_value(treenode_child(treenode, 2));
			char	operator = treenode_child(treenode, 1)->nodename[0];
			switch (operator) {
			case '*':
				return operand1 * operand2;
			case '/':
				return operand1 / operand2;
			case '%':
				{
					int	o1 = operand1;
					int	o2 = operand2;
					return o1 % o2;
				}
			default:
				fprintf(stderr, "unknown operator: %c\n", operator);
			}
		}
	default:
		fprintf(stderr, "internal error\n");
	}
	return 0;
}

double	treenode_factor_value(treenode_p treenode) {
	assert(FACTOR == treenode->nodetype);
	switch (treenode_children(treenode)) {
	case 2:	{
			double	operand1 = treenode_value(treenode_child(treenode, 0));
			treenode_p	child2 = treenode_child(treenode, 1);
			if (TERMINAL == child2->nodetype) {
				return tgamma(operand1 + 1);
			} else {
				double	operand2 = treenode_value(treenode_child(treenode, 1));
				return operand1 * operand2;
			}
		}
	case 3:
		{
			treenode_p	center = treenode_child(treenode, 1);
			if (TERMINAL == center->nodetype) {
				double	operand2 = treenode_value(treenode_child(treenode, 2));
				treenode_p	child1 = treenode_child(treenode, 0);
				switch (center->nodename[0]) {
				case '^':
					return pow(treenode_value(child1), operand2);
				case '=':
					{
						int	r = atoi(child1->nodename);
						registers[r] = operand2;
						return operand2;
					}
				default:
					fprintf(stderr, "internal error\n");
				}
			} else {
				return treenode_value(center);
			}
		}
	}
	return 0;
}

#define	T(x)	treenode_value(treenode_child(treenode, x))

double	treenode_value(treenode_p treenode) {
	switch (treenode->nodetype) {
	case EXPR:	return treenode_expr_value(treenode);
	case TERM:	return treenode_term_value(treenode);
	case FACTOR:	return treenode_factor_value(treenode);
	case ABS:	return fabs(T(1));
	case ASINH:	return asinh(T(1));
	case ACOSH:	return acosh(T(1));
	case ATANH:	return atanh(T(1));
	case SINH:	return sinh(T(1));
	case COSH:	return cosh(T(1));
	case TANH:	return tanh(T(1));
	case ASIN:	return asin(T(1));
	case ACOS:	return acos(T(1));
	case ATAN:	return atan(T(1));
	case ATAN2:	return atan2(T(1), T(3));
	case SIN:	return sin(T(1));
	case COS:	return cos(T(1));
	case TAN:	return tan(T(1));
	case HYPOT:	return hypot(T(1),T(3));
	case CBRT:	return cbrt(T(1));
	case SQRT:	return sqrt(T(1));
	case LOG:	return log(T(1));
	case LOG10:	return log10(T(1));
	case LOG2:	return log2(T(1));
	case EXP:	return exp(T(1));
	case J0:	return j0(T(1));
	case J1:	return j1(T(1));
	case JN:	return jn(T(1), T(3));
	case Y0:	return y0(T(1));
	case Y1:	return y1(T(1));
	case YN:	return yn(T(1), T(3));
	case GAMMA:	return tgamma(T(1));
	case ERF:	return erf(T(1));
	case FLOOR:	return floor(T(1));
	case TRUNC:	return trunc(T(1));
	case BINOM:	return binom(T(1), T(3));
	case MOD:	return mod(T(1), T(3));
	case DIV:	return idiv(T(1), T(3));
	case RAND:	return random() / (double)4294967295;
	case NUMBER:	return treenode->value;
	case CONSTANT:	return constant(treenode->nodename);
	case REGISTER:	return registers[atoi(treenode->nodename)];
	default:
		return treenode->value;
	}
}

void	treenode_print_children(FILE *out, treenode_p treenode) {
	for (treenode_p *p = treenode->children; *p; p++) {
		treenode_print(out, *p);
	}
}

void	treenode_expr_print(FILE *out, treenode_p treenode) {
	assert(EXPR == treenode->nodetype);
}

void	treenode_term_print(FILE *out, treenode_p treenode) {
	assert(TERM == treenode->nodetype);
}

void	treenode_factor_print(FILE *out, treenode_p treenode) {
	assert(FACTOR == treenode->nodetype);
}

void	treenode_print(FILE *out, treenode_p treenode) {
	switch (treenode->nodetype) {
	case TERMINAL:	fprintf(out, "%c", treenode->nodename[0]); break;
	case EXPR:	
	case TERM:	
	case FACTOR:	treenode_print_children(out, treenode); break;
	case ABS:	fprintf(out, "abs");    treenode_print_children(out, treenode); break;
	case ASINH:	fprintf(out, "asinh");  treenode_print_children(out, treenode); break;
	case ACOSH:	fprintf(out, "acosh");  treenode_print_children(out, treenode); break;
	case ATANH:	fprintf(out, "atanh");  treenode_print_children(out, treenode); break;
	case SINH:	fprintf(out, "sinh");   treenode_print_children(out, treenode); break;
	case COSH:	fprintf(out, "cosh");   treenode_print_children(out, treenode); break;
	case TANH:	fprintf(out, "tanh");   treenode_print_children(out, treenode); break;
	case ASIN:	fprintf(out, "asin");   treenode_print_children(out, treenode); break;
	case ACOS:	fprintf(out, "acos");   treenode_print_children(out, treenode); break;
	case ATAN:	fprintf(out, "atan");   treenode_print_children(out, treenode); break;
	case ATAN2:	fprintf(out, "atan2");  treenode_print_children(out, treenode); break;
	case SIN:	fprintf(out, "sin");    treenode_print_children(out, treenode); break;
	case COS:	fprintf(out, "cos");    treenode_print_children(out, treenode); break;
	case TAN:	fprintf(out, "tan");    treenode_print_children(out, treenode); break;
	case HYPOT:	fprintf(out, "hypot");  treenode_print_children(out, treenode); break;
	case CBRT:	fprintf(out, "cbrt");   treenode_print_children(out, treenode); break;
	case SQRT:	fprintf(out, "sqrt");   treenode_print_children(out, treenode); break;
	case LOG:	fprintf(out, "log");    treenode_print_children(out, treenode); break;
	case LOG10:	fprintf(out, "log10");  treenode_print_children(out, treenode); break;
	case LOG2:	fprintf(out, "log2");   treenode_print_children(out, treenode); break;
	case EXP:	fprintf(out, "exp");    treenode_print_children(out, treenode); break;
	case J0:	fprintf(out, "j0");     treenode_print_children(out, treenode); break;
	case J1:	fprintf(out, "j1");     treenode_print_children(out, treenode); break;
	case JN:	fprintf(out, "jn");     treenode_print_children(out, treenode); break;
	case Y0:	fprintf(out, "y0");     treenode_print_children(out, treenode); break;
	case Y1:	fprintf(out, "y1");     treenode_print_children(out, treenode); break;
	case YN:	fprintf(out, "yn");     treenode_print_children(out, treenode); break;
	case GAMMA:	fprintf(out, "tgamma"); treenode_print_children(out, treenode); break;
	case ERF:	fprintf(out, "erf");    treenode_print_children(out, treenode); break;
	case BINOM:	fprintf(out, "binom");  treenode_print_children(out, treenode); break;
	case MOD:	fprintf(out, "mod");    treenode_print_children(out, treenode); break;
	case DIV:	fprintf(out, "div");    treenode_print_children(out, treenode); break;
	case FLOOR:	fprintf(out, "floor");  treenode_print_children(out, treenode); break;
	case TRUNC:	fprintf(out, "trunc");  treenode_print_children(out, treenode); break;
	case RAND:	fprintf(out, "rand");   treenode_print_children(out, treenode); break;
	case NUMBER:	fprintf(out, "%f", treenode->value); break;
	case CONSTANT:	fprintf(out, "%%%s", treenode->nodename); break;
	case REGISTER:	fprintf(out, "r%s", treenode->nodename); break;
	}
}
