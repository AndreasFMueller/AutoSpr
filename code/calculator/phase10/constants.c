/*
 * constants.c -- constant lookup
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 * $Id$
 */
#include "constants.h"
#include <math.h>
#include <stdio.h>

double	constant(const char *name) {
	if (0 == strcmp(name, "pi")) {
		return M_PI;
	}
	if (0 == strcmp(name, "e")) {
		return exp(1);
	}
	if (0 == strcmp(name, "gamma")) {
		return 0.57721566490153286060651;
	}
	if (0 == strcmp(name, "phi")) {
		return (1+sqrt(5))/2;
	}
}
