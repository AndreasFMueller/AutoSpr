//
// matcher.java -- Common matcher interface
//
// (c) 2012 Prof Dr Andreas Müller, Hochschule Rapperswil
//
package ch.hsr.autospr;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

/**
 * Common interface for regex matchers.
 *
 * Because the two regex matchers in question have completely
 * different APIs, we create a common API so that we can later
 * wrap both matchers in wrapper classes implementing this
 * common interface.
 *
 * @author Andreas Müller
 */
public interface matcher {
	/**
	 * Match a string against a regular expression.
	 * @param string	String to match
	 * @param regex		Regular expression string
	 */
	public boolean	matches(String string, String regex);
}
