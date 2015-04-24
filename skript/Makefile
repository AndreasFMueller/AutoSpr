#
# Makefile to build AutoSpr script
#
# (c) 2009 Prof Dr Andreas Mueller
# $Id$
#
all:	skript.pdf

TEXFILES = cfg.tex grundlagen.tex komplexitaet.tex regulaer.tex \
	skript.tex sprachen.tex turing.tex entscheidbarkeit.tex \
	einleitung.tex vollstaendig.tex realworldparser.tex karp.tex \
	sudoku.tex algorithmen.tex \
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
