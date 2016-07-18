#
# Makefile -- Skript int einzelne Kapitel zerlegen
#
# (c) 2016 Prof Dr Andreas Müller, Hochschule Rapperswil
#
parts =	skript-00-intro.pdf		\
	skript-01-chapter1.pdf		\
	skript-02-chapter2.pdf		\
	skript-03-chapter3.pdf		\
	skript-04-chapter4.pdf		\
	skript-05-chapter5.pdf		\
	skript-06-chapter6.pdf		\
	skript-07-chapter7.pdf		\
	skript-08-chapter8.pdf		\
	skript-09-algorithmen.pdf	\
	skript-10-index.pdf

parts:	$(parts)

skript-00-intro.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-00-intro.pdf ../skript.pdf 1-10

skript-01-chapter1.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-01-chapter1.pdf ../skript.pdf 11-22

skript-02-chapter2.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-02-chapter2.pdf ../skript.pdf 23-26

skript-03-chapter3.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-03-chapter3.pdf ../skript.pdf 27-64

skript-04-chapter4.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-04-chapter4.pdf ../skript.pdf 65-96

skript-05-chapter5.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-05-chapter5.pdf ../skript.pdf 97-116

skript-06-chapter6.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-06-chapter6.pdf ../skript.pdf 117-132

skript-07-chapter7.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-07-chapter7.pdf ../skript.pdf 133-174

skript-08-chapter8.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-08-chapter8.pdf ../skript.pdf 175-186

skript-09-algorithmen.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-09-algorithmen.pdf ../skript.pdf 187-191

skript-10-index.pdf:	../skript.pdf Makefile
	pdfjam --outfile skript-10-index.pdf ../skript.pdf 192-195
