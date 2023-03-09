#
# Makefile to build the problem collection
#
# (c) 2013 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
include Makefile.include

all:	
	@echo choose test, sammlung or 'woche(0?|1?)'

test:	test.pdf

sammlung:	aufgabensammlung.pdf

makeindex = makeindex
pdflatex = pdflatex --output-directory=$(workdir)
bibtex = bibtex
touch = touch

TEXFILES = aufgabensammlung.tex 					\
	macros/uebungen.tex						\
	macros/packages.tex						\
	macros/front.tex						\
	macros/vorwort.tex 						\
	macros/content.tex 						\
	$(workdir)/1.tex						\
	$(workdir)/2.tex						\
	$(workdir)/3.tex						\
	$(workdir)/4.tex						\
	$(workdir)/5.tex						\
	$(workdir)/6.tex						\
	$(workdir)/7.tex						\
	$(workdir)/8.tex						\
	$(aufgabenfiles)

topdir := ${PWD}
workdir := work

aufgabensammlung.pdf:	$(workdir)/aufgabensammlung.pdf
	cp $(workdir)/aufgabensammlung.pdf .

$(workdir)/aufgabensammlung.pdf:	$(workdir) $(TEXFILES) \
	$(workdir)/aufgabensammlung.ind thema.tex
	$(pdflatex) aufgabensammlung.tex

$(workdir)/aufgabensammlung.ind: $(workdir) $(workdir)/aufgabensammlung.idx
	cd $(workdir) ; $(makeindex) aufgabensammlung.idx

$(workdir)/aufgabensammlung.idx:	$(workdir) $(TEXILES) \
	aufgabensammlung.tex
	$(touch) $(workdir)/aufgabensammlung.ind
	$(pdflatex) aufgabensammlung.tex

thema.tex:      thema.tix mkthemaidx
	iconv -f ISO-8859-1 -t UTF-8 thema.tix > thema.tix2
	./mkthemaidx thema.tix2 thema.tex

thema.tix:      $(TEXFILES)
	$(pdflatex) aufgabensammlung.tex

mkthemaidx:     mkthemaidx.cpp
	g++ -Wall -g -O -o mkthemaidx mkthemaidx.cpp

clean:
	rm -f $(workdir)/*.dvi $(workdir)/*.log aufgabensammlung.pdf

$(workdir)/1.tex:	buildchapter.sh 1/*.tex
	./buildchapter.sh 1 > $(workdir)/1.tex

$(workdir)/2.tex:	buildchapter.sh 2/*.tex
	./buildchapter.sh 2 > $(workdir)/2.tex

$(workdir)/3.tex:	buildchapter.sh 3/*.tex
	./buildchapter.sh 3 > $(workdir)/3.tex

$(workdir)/4.tex:	buildchapter.sh 4/*.tex
	./buildchapter.sh 4 > $(workdir)/4.tex

$(workdir)/5.tex:	buildchapter.sh 5/*.tex
	./buildchapter.sh 5 > $(workdir)/5.tex

$(workdir)/6.tex:	buildchapter.sh 6/*.tex
	./buildchapter.sh 6 > $(workdir)/6.tex

$(workdir)/7.tex:	buildchapter.sh 7/*.tex
	./buildchapter.sh 7 > $(workdir)/7.tex

$(workdir)/8.tex:	buildchapter.sh 8/*.tex
	./buildchapter.sh 8 > $(workdir)/8.tex

woche01:	woche01.pdf
woche01.pdf:	$(workdir) $(TEXFILES) woche01.tex
	$(pdflatex) woche01.tex
	cp $(workdir)/woche01.pdf .

woche02:	woche02.pdf
woche02.pdf:	$(workdir) $(TEXFILES) woche02.tex
	$(pdflatex) woche02.tex
	cp $(workdir)/woche02.pdf .

woche03:	woche03.pdf
woche03.pdf:	$(workdir) $(TEXFILES) woche03.tex
	$(pdflatex) woche03.tex
	cp $(workdir)/woche03.pdf .

woche04:	woche04.pdf
woche04.pdf:	$(workdir) $(TEXFILES) woche04.tex
	$(pdflatex) woche04.tex
	cp $(workdir)/woche04.pdf .

woche05:	woche05.pdf
woche05.pdf:	$(workdir) $(TEXFILES) woche05.tex
	$(pdflatex) woche05.tex
	cp $(workdir)/woche05.pdf .

woche06:	woche06.pdf
woche06.pdf:	$(workdir) $(TEXFILES) woche06.tex
	$(pdflatex) woche06.tex
	cp $(workdir)/woche06.pdf .

images:
	for d in ?/*; \
	do \
		if [ -d $${d} -a -r $${d}/Makefile ]; \
		then \
			echo $${d}; \
			cd $${d}; \
			make || exit 1; \
			cd ../..; \
		fi; \
	done

test.pdf:	test.tex testaufgabe.tex $(TEXFILES)
	pdflatex test.tex

