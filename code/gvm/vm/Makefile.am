#
# Makefile.am -- build the Makefile for the gvm project
#
# (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
# $Id$
#
EXTRA_DIST = test.goto gvm.h utils.h tokens.l grammar.y

bin_PROGRAMS = gvm

gvm_SOURCES = gvm.c tokens.c grammar.c utils.c

tokens.c:	tokens.l grammar.h
	$(LEX) $< && mv lex.yy.c tokens.c

grammar.h grammar.c:	grammar.y
	$(YACC) -td $< && mv y.tab.h grammar.h && mv y.tab.c grammar.c


test:	gvm test.goto
	./gvm -d test.goto

add:	gvm ../tmc/tmp/add1.goto
	./gvm -s 200 ../tmc/tmp/add1.goto

add1:	gvm ../tmc/tmp/add1.goto
	./gvm ../tmc/tmp/add1.goto

add3:	gvm ../tmc/tmp/add3.goto
	./gvm ../tmc/tmp/add3.goto
