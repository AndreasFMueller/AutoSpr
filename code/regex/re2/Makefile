#
# Makefile -- Baue Beispielprogramm fuer die Verwendung des schnellen
#             Regex Matchers RE2 von Google
#
# (c) 2010-2020 Prof Dr Andreas Mueller, Hochschule Rapperswil
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

regex:	regex.cpp
	g++ --std=c++17 -Wall -g -O2 -o regex regex.cpp			\
		$$(pkg-config --cflags re2)				\
		$$(pkg-config --libs re2)

test:	regex
	./regex
