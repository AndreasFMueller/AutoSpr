#
# Makefile -- build divisible by 3 demo program
#
# (c) 2016 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	divisible

divisible.c:	divisible.l Makefile
	flex -o divisible.c --verbose --interactive divisible.l

divisible:	divisible.c d3.c
	gcc -o divisible -Wall -g -O2 divisible.c d3.c

test:	divisible
	./count | ./divisible
