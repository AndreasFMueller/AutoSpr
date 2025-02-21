#
# Makefile for the calculator project
#
CFLAGS = -g -O2 -Wall

main:	calculator

tokens.c:	tokens.l

tokens.o:	tokens.c grammar.h

grammar.h grammar.c:	grammar.y
	bison -td grammar.y \
	&& mv grammar.tab.h grammar.h \
	&& mv grammar.tab.c grammar.c

grammar.o:	grammar.c grammar.h

calculator.o:	calculator.c

calculator:	calculator.o tokens.o grammar.o

clean:
	rm -f tokens.c grammar.c grammar.h *.o calculator

log:	calculator
	echo '(1+3)*7' | ./calculator -d 2>&1 | egrep -ie 'shift|reduc'
