#
# Makefile -- example program to illustrate how to build good regex
#
# (c) 2015 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	part part.c.expanded

part:	part.c
	gcc -o part -Wall -g -O2 part.c

part.c.expanded:	part.c
	expand part.c > part.c.expanded

test:	part
	./part < testdata
