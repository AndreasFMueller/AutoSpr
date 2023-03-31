/*
 * functions.c -- more functions for the calculator
 *
 * (c) 2023 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule 
 */
#include "functions.h"

double	binom(double n, double k) {
	int	_k = 1;
	double	result = 1;
	while (_k <= k) {
		result = result * n / _k;
		n = n - 1;
		_k = _k + 1;
	}
	return result;
}

double	mod(double n, double k) {
	int	result = (int)n % (int)k;
	return result;
}

double	idiv(double n, double k) {
	int	result = (int)n / (int)k;
	return result;
}
