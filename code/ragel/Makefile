#
# Makefile
#
# (c) 2023 Prof Dr Andreas Müller
#
all:	teilbar_fsm teilbar.pdf

teilbar_fsm.c:	teilbar.c
	ragel -o teilbar_fsm.c -C teilbar.c

teilbar.dot:	teilbar.c
	ragel -V -o teilbar.dot teilbar.c

teilbar.pdf:	teilbar.dot
	dot -Tpdf -oteilbar.pdf teilbar.dot

teilbar_fsm:	teilbar_fsm.c
	gcc -o teilbar_fsm -g -Wno-unused-const-variable -O2 teilbar_fsm.c

test:	teilbar_fsm
	./teilbar_fsm 1001 1111 100 101011
