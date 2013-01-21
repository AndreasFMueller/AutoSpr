#
# Makefile to build the calculator project
#
# Prof Dr Andreas Mueller, Hochschule Rapperswil
#
build:
	for phase in phase{1,2,3,4,5,6,7,8,9}; \
	do \
		(cd $${phase}; make); \
	done

clean:
	for phase in phase{1,2,3,4,5,6,7,8,9}; \
	do \
		(cd $${phase}; make clean); \
	done

diff:
	for p in 1 2 3 4 5 6 7 8; \
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
	
