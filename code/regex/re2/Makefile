#
# Makefile -- Baue Beispielprogramm fuer die Verwendung des schnellen
#             Regex Matchers RE2 von Google
#
# (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
RE2PREFIX = /usr/local
regex:	regex.cpp
	g++ -Wall -g -O2 -o regex regex.cpp -I$(RE2PREFIX)/include \
		-L$(RE2PREFIX)/lib -Wl,-rpath,$(RE2PREFIX)/lib -lre2 -lpthread
