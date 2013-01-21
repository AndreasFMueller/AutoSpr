#! /usr/bin/perl
#
# Nachweis der potentiell exponentiellen Laufzeit des Regex Matchers von Perl
#
# Der regulaere Ausdruck
#
#      a?a?a?a?a?a?aaaa
#
# beziehungsweise seine Verallgemeinerung (a?)^na^n akzeptiert den
# String a^n, aber ein NEA wird dafuer Zeit O(2^n) benoetigen.
# 
# Das Programm erzeugt nacheinander regulaere Ausdruecke und passende
# Strings immer groesserer Laenge. Dabei kann man das exponentielle
# Anwachsen der Laufzeit beobachten.
#
# Ausfuehrung:
#
#  $ perl regex.pl
#
# (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
$string = "";
$regex = "";

# Test den Regex Matcher fuer Stringlaengen zwischen 1 und 29
for ($i = 1; $i <= 29; $i++) {
	# Verlaengere die Komponenten $regex und $string um je ein
	# zusaetzliches Element
	$string .= "a";
	$regex .= "a?";

	# Baue daraus jetzt den regulaeren Ausdruck auf
	$r = $regex.$string;

	# Fuehre den Regex Match durch
	if ($string =~ m/$r/) {
		printf("%29s matches %s\n", $string, $r);
	} else {
		printf("%29s does not match %s\n", $string, $r);
	}
}

exit 0;
