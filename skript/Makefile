#
# Makefile to build AutoSpr script
#
# (c) 2009 Prof Dr Andreas Mueller
# $Id$
#
all:	skript.pdf

TEXFILES = \
	skript.tex \
	0-einleitung/einleitung.tex					\
	1-grundlagen/chapter.tex					\
	1-grundlagen/notation.tex					\
	1-grundlagen/beweis.tex						\
	2-sprachen/sprachen.tex						\
	3-regulaer/chapter.tex						\
	3-regulaer/dea.tex						\
	3-regulaer/nea.tex						\
	3-regulaer/regex.tex						\
	3-regulaer/lex.tex						\
	4-cfg/chapter.tex						\
	4-cfg/grammatik.tex						\
	4-cfg/pda.tex							\
	4-cfg/noncfl.tex						\
	4-cfg/realworldparser.tex					\
	4-cfg/bison/tabelle1.tex					\
	4-cfg/bison/tabelle2.tex					\
	4-cfg/bison/tabelle3.tex					\
	4-cfg/bison/bisongrammar.txt					\
	4-cfg/bison/state14.txt						\
	5-turing/chapter.tex						\
	5-turing/turing.tex						\
	5-turing/varianten.tex						\
	5-turing/berechenbar.tex					\
	6-entscheidbarkeit/chapter.tex					\
	6-entscheidbarkeit/entscheidbar.tex				\
	6-entscheidbarkeit/akzeptanz.tex				\
	6-entscheidbarkeit/reduktion.tex				\
	6-entscheidbarkeit/nichtentscheidbar.tex			\
	6-entscheidbarkeit/rice.tex					\
	7-komplexitaet/chapter.tex					\
	7-komplexitaet/beispiele.tex					\
	7-komplexitaet/katalog.tex					\
	7-komplexitaet/laufzeit.tex					\
	7-komplexitaet/minesweeper.tex					\
	7-komplexitaet/npcomplete.tex					\
	7-komplexitaet/pnp.tex						\
	7-komplexitaet/reduktion.tex					\
	7-komplexitaet/sat.tex						\
	7-komplexitaet/sudoku.tex					\
	7-komplexitaet/ausfuellraetsel.tex				\
	7-komplexitaet/karp.tex						\
	8-vollstaendigkeit/chapter.tex					\
	8-vollstaendigkeit/vollstaendig.tex				\
	8-vollstaendigkeit/kontrollstrukturen.tex			\
	a-algorithmen/algorithmen.tex					\
	references.bib

images/timestamp:
	cd images; make timestamp

skript.pdf:	images/timestamp skript.ind
	latexmk -pdf skript.tex

skript.ind:	$(TEXFILES) 
	touch skript.ind
	pdflatex skript.tex
	makeindex skript.idx

clean:
	rm -f *.dvi *.log 

checklist.pdf:	checklist.tex
	pdflatexc checklist.tex
