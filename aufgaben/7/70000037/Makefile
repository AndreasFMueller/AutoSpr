#
# Makefile -- build images for problem 70000037
#
# (c) 2016 Prof Dr Andreas Müller
#
spielname=Flow
all: $(spielname)-aufgabe.png $(spielname)-loesung.png

geometry = 749x749+0+314

$(spielname)-aufgabe.png:	links-aufgabe.png Makefile
	convert -extract $(geometry) links-aufgabe.png $(spielname)-aufgabe.png

$(spielname)-loesung.png:	links-loesung.png Makefile
	convert -extract $(geometry) links-loesung.png $(spielname)-loesung.png
