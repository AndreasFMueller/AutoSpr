#
# Makefile
#
# (c) 2023 Prof Dr Andreas Müller
#
all:	u

t:	teilbar_fsm teilbar.pdf 

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

# Beispiel: Zeichenketten mit einer ungeraden Anzal Einsen
u:	ungerade_fsm ungerade.pdf

ungerade_fsm.c:	ungerade.c
	ragel -o ungerade_fsm.c -C ungerade.c

ungerade.dot:	ungerade.c
	ragel -V -o ungerade.dot ungerade.c

ungerade.pdf:	ungerade.dot
	dot -Tpdf -oungerade.pdf ungerade.dot

ungerade_fsm:	ungerade_fsm.c
	gcc -o ungerade_fsm -g -Wno-unused-const-variable -O2 ungerade_fsm.c

testu:	ungerade_fsm
	./ungerade_fsm 1001 1111 100 101011 0101001001010011
