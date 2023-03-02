#
# Makefile
#
# (c) 2023 Prof Dr Andreas Müller
#
all:	t j u

#
# Beispiel 1: Teilbarkeit einer Binärzahl durch 3
#

#
# Beispiel einer Binärzahl, die nicht in einen primitiven Datentypen
# von C oder Java konvertiert werden kann. Mit dem DEA, der Teilbarkeit
# durch 3 testen kann, kann man trotzdem den Rest bestimmen
#
b = 1010110111011011010001010101001010101001001010001010100101011011001101110101001101010101010101100111011011011010101101010101111011011110111110

#
# Implementation in C
#
t:	teilbar_fsm teilbar.pdf 

teilbar_fsm.c:	teilbar.c
	ragel -o teilbar_fsm.c -C teilbar.c

teilbar.dot:	teilbar.c
	ragel -V -o teilbar.dot teilbar.c

teilbar.pdf:	teilbar.dot Makefile
	sed -e s/48/\'0\'/g -e s/49/\'1\'/g teilbar.dot | \
		dot -Tpdf -oteilbar.pdf

teilbar_fsm:	teilbar_fsm.c
	gcc -o teilbar_fsm -g -Wno-unused-const-variable -O2 teilbar_fsm.c

testt:	teilbar_fsm
	./teilbar_fsm 1001 1111 100 101011 1010110100100010101110110101 $(b)

#
# Implementation in Java
#
j:	teilbar.class

teilbar.java:	teilbar.rl 
	ragel -J -oteilbar.java teilbar.rl
teilbar.class:	teilbar.java
	javac teilbar.java

testj:	teilbar.class
	java -classpath . teilbar 1001 1111 100 101011 1010110100100010101110110101 $(b)

#
# Beispiel 2: Zeichenketten mit einer ungeraden Anzal Einsen
#
u:	ungerade_fsm ungerade.pdf ungerade_minimized.pdf

ungerade_fsm.c:	ungerade.c
	ragel -o ungerade_fsm.c -C ungerade.c

#
# nicht minimierter Automat
#
ungerade.dot:	ungerade.c Makefile
	ragel -V -o ungerade.dot -n ungerade.c
ungerade.pdf:	ungerade.dot
	sed -e s/48/\'0\'/g -e s/49/\'1\'/g ungerade.dot | \
		dot -Tpdf -oungerade.pdf 

#
# minimierter Automat
#
ungerade_minimized.dot:	ungerade.c Makefile
	ragel -V -o ungerade_minimized.dot ungerade.c
ungerade_minimized.pdf:	ungerade_minimized.dot
	sed -e s/48/\'0\'/g -e s/49/\'1\'/g ungerade_minimized.dot | \
		dot -Tpdf -oungerade_minimized.pdf

ungerade_fsm:	ungerade_fsm.c
	gcc -o ungerade_fsm -g -Wno-unused-const-variable -O2 ungerade_fsm.c

testu:	ungerade_fsm
	./ungerade_fsm 1001 1111 100 101011 0101001001010011
