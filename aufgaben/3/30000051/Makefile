#
# Makefile -- Primzahlen sind nicht regulär
#
# (c) 2016 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
pl_FILES = pl-1.pdf pl-2.pdf
pl:	$(pl_FILES)
$(pl_FILES):	pl.mp
	TEX=latex mpost pl.mp
	for f in pl.[0-9]*; \
	do \
		mptopdf $${f}; \
	done
