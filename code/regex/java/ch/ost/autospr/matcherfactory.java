//
// matcherfactory.java -- factory class to build matchers
//
// (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
package ch.ost.autospr;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

/**
 * Construct matchers at runtime based on the class name.
 *
 * @author Andreas Mueller
 */
public class matcherfactory {
	/**
	 * Factory Method to construct matchers.
	 * @param name	Name identifying the matcher.
	 */
	static public matcher	get(String name) throws ClassNotFoundException,
		NoSuchMethodException, SecurityException,
		InstantiationException, IllegalAccessException,
		InvocationTargetException {
		Class<?>	c = Class.forName(name);
		Constructor<?>	constructor = c.getConstructor();
		return (matcher)constructor.newInstance();
	}
}
