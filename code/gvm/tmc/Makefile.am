#
# makefile for the turing machine compiler
#
# (c) 2012-2024 Prof Dr Andreas Mueller
#
SUBDIRS = pgm data

sleepinterval = 100

EXTRA_DIST = tmc.h tmc-tokens.l tmc-grammar.y

bin_PROGRAMS = tmc

tmc_SOURCES = tmc.c tmc-tokens.c tmc-grammar.c

tmc-tokens.c:	tmc-tokens.l tmc-grammar.h
	$(LEX) $< && mv lex.yy.c tmc-tokens.c

tmc-grammar.c tmc-grammar.h:		tmc-grammar.y
	$(YACC) -td $< && mv y.tab.h tmc-grammar.h && mv y.tab.c tmc-grammar.c

tmp:
	mkdir tmp

test:	tmc tmp 
	./tmc -d -p 3 -o tmp/beaver3.goto pgm/beaver3

tmp/add.goto:	pgm/add Makefile.am
	./tmc -p 0 -t '10100001011 01011001111' -o tmp/add.goto pgm/add

add:	tmc tmp tmp/add.goto
	../vm/gvm -s $(sleepinterval) tmp/add.goto

tmp/add1.goto:	tmc tmp pgm/add data/addtape1
	./tmc -p 0 -T data/addtape1 -o tmp/add1.goto pgm/add

add1:	tmp/add1.goto
	../vm/gvm -s $(sleepinterval) tmp/add1.goto

tmp/add2.goto:	tmc tmp pgm/add data/addtape2
	./tmc -p 2 -T data/addtape2 -o tmp/add2.goto pgm/add

add2:	tmp/add2.goto
	../vm/gvm -s $(sleepinterval) tmp/add2.goto

tmp/add3.goto:	tmc tmp pgm/add data/addtape3
	./tmc -p 2 -T data/addtape3 -o tmp/add3.goto pgm/add

add3:	tmp/add3.goto
	../vm/gvm -s `expr $(sleepinterval) / 5` tmp/add3.goto

tmp/beaver3.goto:	tmc tmp pgm/beaver3
	./tmc -p 10 -o tmp/beaver3.goto pgm/beaver3

b3:	tmp/beaver3.goto
	../vm/gvm -s $(sleepinterval) tmp/beaver3.goto

tmp/beaver4.goto:	tmc tmp pgm/beaver4
	./tmc -p 20 -o tmp/beaver4.goto pgm/beaver4

b4:	tmp/beaver4.goto
	../vm/gvm -s $(sleepinterval) tmp/beaver4.goto

tmp/beaver5.goto:	tmc tmp pgm/beaver5
	./tmc -p 20 -o tmp/beaver5.goto pgm/beaver5

b5:	tmp/beaver5.goto
	../vm/gvm -s $(sleepinterval) tmp/beaver5.goto

