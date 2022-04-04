#
# Makefile to build the calculator project
#
# Prof Dr Andreas Mueller, Hochschule Rapperswil
#
subdirs = 								\
	phase1								\
	phase2								\
	phase3								\
	phase4								\
	phase5								\
	phase6								\
	phase7								\
	phase8								\
	phase9								\
	phase10

build:
	for p in 1 2 3 4 5 6 7 8 9 10; \
	do \
		(cd phase$${p} && make); \
	done

clean:
	for p in 1 2 3 4 5 6 7 8 9 10; \
	do \
		(cd phase$${p}; make clean); \
	done

diff:
	for p in 1 2 3 4 5 6 7 8 9 10; \
	do \
		q=`expr $${p} + 1`; \
		diff -ru phase$${p} phase$${q} > phase$${p}-phase$${q}.diff; \
	done; \
	exit 0

diffps:	diff
	for p in 1 2 3 4 5 6 7 8; \
	do \
		q=`expr $${p} + 1`; \
		name=phase$${p}-phase$${q}; \
		enscript -2rGE -p $${name}.ps $${name}.diff; \
	done
	
