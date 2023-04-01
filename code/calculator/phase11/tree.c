/*
 * tree.c -- tree-related functions
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
#include <wchar.h>
#include <stdio.h>
#include <assert.h>

static int	treedebug = 0;
static double	registers[100];

int	tree_precision = 3;
int	tree_format = TREE_FORMAT_DEFAULT;

void	treenode_format_number(FILE *out, double value) {
	switch (tree_format) {
	case TREE_FORMAT_FIXED:
		fprintf(out, "%.*f", tree_precision, value);
		break;
	case TREE_FORMAT_FLOAT:
		fprintf(out, "%.*e", tree_precision, value);
		break;
	case TREE_FORMAT_DEFAULT:
		fprintf(out, "%.*g", tree_precision, value);
		break;
	}
}

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

treenode_p	treenode_terminal(char *t) {
	return treenode_new(strdup(t), TERMINAL, NULL);
}

treenode_p	tree_copy(treenode_p treenode) {
	treenode_p	result = treenode_new(treenode->nodename, treenode->nodetype, NULL);
	result->value = treenode->value;
	for (treenode_p *p = treenode->children; *p; p++) {
		treenode_add(result, tree_copy(*p));
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

static void	tree_show_children(FILE *out, char *prefix, treenode_p treenode) {
	int	l = strlen(prefix);
	char	*newprefix = (char *)alloca((l + 7) * sizeof(char));
	strcpy(newprefix, prefix);
	if (l >= 3) {
		switch (prefix[l-3]) {
		case '+':
			strcpy(newprefix + (l - 3), "|  ");
			break;
		case '`':
			strcpy(newprefix + (l - 3), "   ");
			break;
		}
	}
	int	n = treenode_children(treenode);
	for (int i = 0; i < n; i++) {
		treenode_p	p = treenode_child(treenode, i);
		newprefix[l+1] = '-';
		newprefix[l+2] = '-';
		newprefix[l+3] = '\0';
		if (i == n - 1) {
			newprefix[l] = '`';
			tree_show(out, newprefix, p);
		} else {
			newprefix[l] = '+';
			tree_show(out, newprefix, p);
		}
	}
}

int	treewide = 1;

static void	treenode_printprefix(FILE *out, char *prefix) {
	if (!treewide) {
		fprintf(out, "%s", prefix);
		return;
	}
	char	c;
	for (int i = 0; (c = prefix[i]); i++) {
		switch (c) {
		case '`': fprintf(out, "\U00002517"); break;
		case '-': fprintf(out, "\U00002501"); break;
		case '|': fprintf(out, "\U00002503"); break;
		case '+': fprintf(out, "\U00002523"); break;
		default:  fprintf(out, " "); break;
		}
	}
}

void	tree_show(FILE *out, char *prefix, treenode_p treenode) {
	if (NULL == treenode) {
		return;
	}
	treenode_printprefix(out, prefix);
	switch (treenode->nodetype) {
	case CONSTANT:
		fprintf(out, "CONSTANT %s\n", treenode->nodename);
		return;
	case NUMBER:
		fprintf(out, "NUMBER ");
		treenode_format_number(out, treenode->value);
		fprintf(out, "\n");
		return;
	case TERMINAL:
		fprintf(out, "'%s'\n", treenode->nodename);
		return;
	case REGISTER:
		fprintf(out, "r%s\n", treenode->nodename);
		return;
	default:
		fprintf(out, "%s\n",
			(treenode->nodename) ? treenode->nodename : "(null)");
	}
	tree_show_children(out, prefix, treenode);
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
		return tree_value(treenode_child(treenode, 0));
		break;
	case 2:
		return -tree_value(treenode_child(treenode, 1));
		break;
	case 3: {
			double	operand1 = tree_value(treenode_child(treenode, 0));
			double	operand2 = tree_value(treenode_child(treenode, 2));
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
		return tree_value(treenode_child(treenode, 0));
	case 3:	{
			double	operand1 = tree_value(treenode_child(treenode, 0));
			double	operand2 = tree_value(treenode_child(treenode, 2));
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
			double	operand1 = tree_value(treenode_child(treenode, 0));
			treenode_p	child2 = treenode_child(treenode, 1);
			if (TERMINAL == child2->nodetype) {
				return tgamma(operand1 + 1);
			} else {
				double	operand2 = tree_value(treenode_child(treenode, 1));
				return operand1 * operand2;
			}
		}
	case 3:
		{
			treenode_p	center = treenode_child(treenode, 1);
			if (TERMINAL == center->nodetype) {
				double	operand2 = tree_value(treenode_child(treenode, 2));
				treenode_p	child1 = treenode_child(treenode, 0);
				switch (center->nodename[0]) {
				case '^':
					return pow(tree_value(child1), operand2);
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
				return tree_value(center);
			}
		}
	}
	return 0;
}

#define	T(x)	tree_value(treenode_child(treenode, x))
static double	sqr(double x) { return x * x; }

double	tree_value(treenode_p treenode) {
	switch (treenode->nodetype) {
	case EXPR:	return treenode_expr_value(treenode);
	case TERM:	return treenode_term_value(treenode);
	case FACTOR:	return treenode_factor_value(treenode);
	case ABS:	return fabs(T(2));
	case ASINH:	return asinh(T(2));
	case ACOSH:	return acosh(T(2));
	case ATANH:	return atanh(T(2));
	case SINH:	return sinh(T(2));
	case COSH:	return cosh(T(2));
	case TANH:	return tanh(T(2));
	case ASIN:	return asin(T(2));
	case ACOS:	return acos(T(2));
	case ATAN:	return atan(T(2));
	case ATAN2:	return atan2(T(2), T(4));
	case SIN:	return sin(T(2));
	case COS:	return cos(T(2));
	case TAN:	return tan(T(2));
	case HYPOT:	return hypot(T(2),T(4));
	case CBRT:	return cbrt(T(2));
	case SQRT:	return sqrt(T(2));
	case SQR:	return sqr(T(2));
	case LOG:	return log(T(2));
	case LOG10:	return log10(T(2));
	case LOG2:	return log2(T(2));
	case EXP:	return exp(T(2));
	case J0:	return j0(T(2));
	case J1:	return j1(T(2));
	case JN:	return jn(T(2), T(4));
	case Y0:	return y0(T(2));
	case Y1:	return y1(T(2));
	case YN:	return yn(T(2), T(4));
	case GAMMA:	return tgamma(T(2));
	case ERF:	return erf(T(2));
	case FLOOR:	return floor(T(2));
	case TRUNC:	return trunc(T(2));
	case BINOM:	return binom(T(2), T(4));
	case MOD:	return mod(T(2), T(4));
	case DIV:	return idiv(T(2), T(4));
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
		tree_print(out, *p);
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

void	tree_print(FILE *out, treenode_p treenode) {
	switch (treenode->nodetype) {
	case TERMINAL:	fprintf(out, "%s", treenode->nodename); break;
	case EXPR:	
	case TERM:	
	case FACTOR:
	case ABS:
	case ASINH:
	case ACOSH:
	case ATANH:
	case SINH:
	case COSH:
	case TANH:
	case ASIN:
	case ACOS:
	case ATAN:
	case ATAN2:
	case SIN:
	case COS:
	case TAN:
	case HYPOT:
	case CBRT:
	case SQRT:
	case SQR:
	case LOG:
	case LOG10:
	case LOG2:
	case EXP:
	case J0:
	case J1:
	case JN:
	case Y0:
	case Y1:
	case YN:
	case GAMMA:
	case ERF:
	case BINOM:
	case MOD:
	case DIV:
	case FLOOR:
	case TRUNC:
	case RAND:	treenode_print_children(out, treenode); break;
	case NUMBER:	treenode_format_number(out, treenode->value); break;
	case CONSTANT:	fprintf(out, "%%%s", treenode->nodename); break;
	case REGISTER:	fprintf(out, "r%s", treenode->nodename); break;
	}
}
