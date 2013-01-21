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

grammar.o:	grammar.c grammar.h constants.h

constants.o:	constants.c constants.h

calculator.o:	calculator.c

calculator:	calculator.o tokens.o grammar.o constants.o

clean:
	rm -f tokens.c grammar.c grammar.h *.o calculator
