# 
# convert metapost source into images to be included in script
#
# (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
# $Id$
#
all:	cfg turing nea lang red comp pl reg mine

REGFILES = reg-1.pdf reg-2.pdf reg-3.pdf reg-4.pdf reg-5.pdf
NEAFILES = nea-1.pdf nea-2.pdf nea-3.pdf nea-4.pdf nea-5.pdf
CFGFILES = cfg-1.pdf cfg-2.pdf
TURINGFILES = turing-1.pdf turing-2.pdf turing-3.pdf turing-4.pdf
LANGFILES = lang-1.pdf lang-2.pdf lang-3.pdf lang-4.pdf lang-5.pdf lang-6.pdf
MINEFILES = mine-1.pdf mine-2.pdf mine-3.pdf mine-4.pdf mine-5.pdf
PLFILES = pl-1.pdf pl-2.pdf pl-3.pdf pl-4.pdf pl-5.pdf
REDFILES = red-1.pdf
COMPFILES = comp-1.pdf comp-2.pdf comp-3.pdf comp-4.pdf comp-5.pdf \
	comp-6.pdf comp-7.pdf

timestamp:	$(REGFILES) $(NEAFILES) $(CFGFILES) $(TURINGFILES) \
		$(LANGFILES) $(MINEFILES) $(PLFILES) $(REDFILES) $(COMPFILES)
	touch timestamp

nea:	$(NEAFILES) 
$(NEAFILES):	nea.mp Makefile
	TEX=latex mpost nea.mp
	for i in 1 2 3 4 5 6; \
	do \
		mptopdf nea.$${i}; \
	done

turing:	$(TURINGFILES)
$(TURINGFILES):	turing.mp Makefile
	TEX=latex mpost turing.mp
	for i in 1 2 3 4; \
	do \
		mptopdf turing.$${i}; \
	done
	
cfg:	$(CFGFILES)
$(CFGFILES): cfg.mp Makefile
	TEX=latex mpost cfg.mp
	for i in 1 2 3; \
	do \
		mptopdf cfg.$${i}; \
	done

lang:	$(LANGFILES)
$(LANGFILES):	lang.mp Makefile
	TEX=latex mpost lang.mp
	for i in 1 2 3 4 5 6; \
	do \
		mptopdf lang.$${i}; \
	done

red: $(REDFILES)
$(REDFILES): red.mp Makefile
	TEX=latex mpost red.mp
	for i in 1; \
	do \
		mptopdf red.$${i}; \
	done

comp: $(COMPFILES)
$(COMPFILES): comp.mp Makefile
	TEX=latex mpost comp.mp
	for i in 1 2 3 4 5 6 7; \
	do \
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
	for i in 1 2 3 4 5; \
	do \
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

