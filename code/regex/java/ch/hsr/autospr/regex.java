//
// regex.java -- Demo der exponentiellen Laufzeit des Java Regex Matchers
//
//
// (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
package ch.hsr.autospr;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

// reflection classes used by factory method get(name)
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

/**
 * Runtime demo for the Java regex matchers.
 *
 * The Java runtime contains at least two regex matchers, with
 * different APIs. One is contained in the matches() method of
 * the String class java.lang.String, the other has its own package
 * java.lang.regex. This program allows to exercise them both
 * on the regex <i>(a?)^na^n</i>, which reveals whether the matcher
 * uses an NFA or a DFA.
 * 
 * @author Andreas Mueller
 */
public class regex {
	/**
	 * Maximum length of regular expression.
	 * The matcher creates regular expressions of the form <i>(a?)^na^n</i>
	 * with n between 1 and N.
 	 */
	public final static int	N = 29;

	/**
	 * Perform matches.
	 * This method builds a regular expression of the form (a?)^na^n
	 * for Values of n from 1 to N, an matches the string a^n against
	 * the regular expression. It then displays the result nicely
	 * formatted.
	 * @param match	Matcher instance to use for matches.
	 */
	static void	domatch(matcher match) {
		System.out.println("matching using "
			+ match.getClass().getName());
		String	s1 = "";
		String	s2 = "";
		// baue einen Präfix-String fuer die "schöne" Einrückung
		// der Resultate
		StringBuffer	prefix = new StringBuffer();
		for (int i = 0; i < N; i++) {
			prefix.append(" ");
		}

		// führe den Test durch fuer Stringlängen von 1 bis N
		for (int i = 1; i <= N; i++) {
			// Stringkomponenten verlaengern
			s1 = s1 + "a";
			s2 = s2 + "a?";
			String	r = s2 + s1;
			System.out.print(prefix.substring(i));
			System.out.print(s1);
			if (match.matches(s1, r)) {
				System.out.print(" matches ");
			} else {
				System.out.print(" doesn't match ");
			}
			System.out.println(r);
		}
	}

	/**
	 * Main function.
	 * @param args	command line arguments. Valid values are the
	 *              names of the matcher classes
	 */
	public static void	main(String[] args) {
		for (int argindex = 0; argindex < args.length; argindex++) {
			String	name = args[argindex];
			try {
				matcher	m = matcherfactory.get(name);
				domatch(m);
			} catch (Exception x) {
				System.out.println("cannot do matches with matcher named " +  name + ": " + x.toString());
			}
		}
	}
}
