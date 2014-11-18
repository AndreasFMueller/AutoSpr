//
// StringMatcher.java -- matcher implementation based on java.lang.String
//
//
// (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
package ch.hsr.autospr;

/**
 * Matcher implementation based on java.lang.String.
 *
 * @author Andreas Mueller
 */
public class StringMatcher implements matcher {
	public StringMatcher() { }
	public boolean matches(String string, String regex) {
		return string.matches(regex);
	}
}
