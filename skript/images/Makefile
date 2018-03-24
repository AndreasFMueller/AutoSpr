#
# convert metapost source into images to be included in script
#
# (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
# $Id$
#
all:	cfg turing nea lang red comp pl reg mine graph stack sudoku ausfuell palindrom

REGFILES = reg-1.pdf reg-2.pdf reg-3.pdf reg-4.pdf reg-5.pdf reg-6.pdf
NEAFILES = nea-1.pdf nea-2.pdf nea-3.pdf nea-4.pdf nea-5.pdf nea-6.pdf nea-7.pdf
CFGFILES = cfg-1.pdf cfg-2.pdf
TURINGFILES = turing-1.pdf turing-2.pdf turing-3.pdf turing-4.pdf
LANGFILES = lang-1.pdf lang-2.pdf lang-3.pdf lang-4.pdf lang-5.pdf lang-6.pdf
MINEFILES = mine-1.pdf mine-2.pdf
PLFILES = pl-1.pdf pl-2.pdf pl-3.pdf pl-4.pdf pl-5.pdf
REDFILES = red-1.pdf
COMPFILES = comp-1.pdf comp-2.pdf comp-3.pdf comp-4.pdf comp-5.pdf \
	comp-6.pdf comp-7.pdf
GRAPHFILES = graph-1.pdf
STACKFILES = stack-1.pdf stack-2.pdf
SUDOKUFILES = sudoku-1.pdf
PALINDROMFILES = palindrom-1.pdf
AUSFUELLFILES = ausfuell-1.pdf ausfuell-2.pdf

timestamp:	$(REGFILES) $(NEAFILES) $(CFGFILES) $(TURINGFILES) \
		$(LANGFILES) $(MINEFILES) $(PLFILES) $(REDFILES) $(COMPFILES) \
		$(GRAPHFILES) $(STACKFILES) $(SUDOKUFILES) $(PALINDROMFILES)
	touch timestamp

nea:	$(NEAFILES)
$(NEAFILES):	nea.mp Makefile
	TEX=latex mpost nea.mp
	for f in nea.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "nea\.\(.\)"`; \
		mptopdf nea.$${i}; \
	done

turing:	$(TURINGFILES)
$(TURINGFILES):	turing.mp Makefile
	TEX=latex mpost turing.mp
	for f in turing.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "turing\.\(.\)"`; \
		mptopdf turing.$${i}; \
	done
	
cfg:	$(CFGFILES)
$(CFGFILES): cfg.mp Makefile
	TEX=latex mpost cfg.mp
	for f in cfg.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "cfg\.\(.\)"`; \
		mptopdf cfg.$${i}; \
	done

lang:	$(LANGFILES)
$(LANGFILES):	lang.mp Makefile
	TEX=latex mpost lang.mp
	for f in lang.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "lang\.\(.\)"`; \
		mptopdf lang.$${i}; \
	done

red: $(REDFILES)
$(REDFILES): red.mp Makefile
	TEX=latex mpost red.mp
	for f in red.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "red\.\(.\)"`; \
		mptopdf red.$${i}; \
	done

comp: $(COMPFILES)
$(COMPFILES): comp.mp Makefile
	TEX=latex mpost comp.mp
	for f in comp.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "comp\.\(.\)"`; \
		mptopdf comp.$${i}; \
	done

pl: $(PLFILES)
$(PLFILES):	pl.mp Makefile
	TEX=latex mpost pl.mp
	for f in pl.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "pl\.\(.\)"`; \
		mptopdf pl.$${i}; \
	done

reg: $(REGFILES)
$(REGFILES):	reg.mp Makefile
	TEX=latex mpost reg.mp
	for f in reg.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "reg\.\(.\)"`; \
		mptopdf reg.$${i}; \
	done

mine: $(MINEFILES)
$(MINEFILES):	mine.mp Makefile
	TEX=latex mpost mine.mp
	for f in mine.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "mine\.\(.\)"`; \
		mptopdf mine.$${i}; \
	done

graph:	$(GRAPHFILES)
$(GRAPHFILES):	graph.mp Makefile
	TEX=latex mpost graph.mp
	for f in graph.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "graph\.\(.\)"`; \
		mptopdf graph.$${i}; \
	done

stack:	$(STACKFILES)
$(STACKFILES):	stack.mp Makefile
	TEX=latex mpost stack.mp
	for f in stack.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "stack\.\(.\)"`; \
		mptopdf stack.$${i}; \
	done

sudoku:	$(SUDOKUFILES)
$(SUDOKUFILES):	sudoku.mp Makefile
	TEX=latex mpost sudoku.mp
	for f in sudoku.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "sudoku\.\(.\)"`; \
		mptopdf sudoku.$${i}; \
	done

palindrom:	$(PALINDROMFILES)
$(PALINDROMFILES):	palindrom.mp Makefile
	TEX=latex mpost palindrom.mp
	for f in palindrom.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "palindrom\.\(.\)"`; \
		mptopdf palindrom.$${i}; \
	done

ausfuell:	$(AUSFUELLFILES)
$(AUSFUELLFILES):	ausfuell.mp Makefile
	TEX=latex mpost ausfuell.mp
	for f in ausfuell.?; \
	do \
		echo $${f}; \
		i=`expr $${f} : "ausfuell\.\(.\)"`; \
		mptopdf ausfuell.$${i}; \
	done
