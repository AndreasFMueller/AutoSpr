#
# Makefile -- graphik zu Aufgabe 30000025 bauen
#
# (c) 2016 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
pl_FILES = pl-1.pdf
$(pl_FILES): pl.mp
	TEX=latex mpost pl.mp
	for f in pl.[0-9]*; \
	do \
		mptopdf $${f}; \
	done
