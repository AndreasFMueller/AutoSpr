#
# Makefile for the calculator project
#
CFLAGS = -g -O2 -Wall
LDFLAGS = -lm

main:	calculator

tokens.c:	tokens.l

tokens.o:	tokens.c grammar.h

grammar.h grammar.c:	grammar.y
	bison -td grammar.y \
	&& mv grammar.tab.h grammar.h \
	&& mv grammar.tab.c grammar.c

grammar.o:	grammar.c grammar.h constants.h tree.h help.h

constants.o:	constants.c constants.h

tree.o:	tree.c tree.h constants.h functions.h grammar.h

functions.o:	functions.c functions.h

help.o:	help.c help.h

libcalc.a:	tokens.o grammar.o constants.o tree.o functions.o help.o
	ar r libcalc.a tokens.o grammar.o constants.o tree.o functions.o help.o

calculator.o:	calculator.c

calculator:	calculator.o libcalc.a
	gcc calculator.o -L. -lcalc -lm -o calculator

clean:
	rm -f tokens.c grammar.c grammar.h *.o calculator
