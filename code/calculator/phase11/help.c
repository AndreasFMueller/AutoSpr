/*
 * help.c
 *
 * (c) 2023 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include "help.h"
#include <stdio.h>

void	help() {
	printf("enter arithmetic expression and evaluate it\n");
	printf("    arithmetic operators implemented: + - * / ! (factorial)\n");
	printf("    registers:              r0 - r99\n");
	printf("    register assignment:    r<x> = <expression> (can be inside expression)\n");
	printf("    constants:              %%pi %%e %%gamma %%phi\n");
	printf("    most recent expression: %%%%\n");
	printf("    numbered expression:    %%<d> (<d> number of the expression)\n");
	printf("commands:\n");
	printf("    tree ...        display the parse tree instead of evaluating\n");
	printf("    print ...       print the expression instead of evaluating\n");
	printf("    precision <x>   display <x> digits after the decimal point\n");
	printf("    format <f>      choose display format ('fixed' or 'float')\n");
	printf("    history         display all commands history\n");
	printf("    help            show this help message\n");
	printf("    exit            exit the calculator\n");
	printf("functions available (see libm manual pages for details):\n");
	printf("    abs trunc floor div mod\n");
	printf("    sqrt cbrt pow\n");
	printf("    sin cos tan asin acos atan atan2 hypot\n");
	printf("    sinh cosh tanh asinh acosh atanh\n");
	printf("    exp log log10 log2\n");
	printf("    j0 j1 jn y0 y1 yn gamma erf\n");
	printf("    binom\n");
}
