//
// RegexMatcher.java -- Matcher implementation based on java.util.regex
//
//
// (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
package ch.hsr.autospr;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

/**
 * Matcher implementation based on java.util.regex.
 *
 * This matcher uses the classes java.lang.regex.Pattern and
 * java.lang.regex.Matcher to perform matches.
 *
 * @author Andreas Mueller
 */
public class RegexMatcher implements matcher {
	public RegexMatcher() { }
	public boolean matches(String string, String regex) {
		Pattern	p = Pattern.compile(regex);
		Matcher	m = p.matcher(string);
		return m.matches();
	}
}
