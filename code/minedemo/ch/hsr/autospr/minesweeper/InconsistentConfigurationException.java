//
// InconsistentConfigurationException.java -- exception thrown when an
//                                            inconsistent configuration is
//                                            encountered
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: InconsistentConfigurationException.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

public class InconsistentConfigurationException extends Exception {
	public InconsistentConfigurationException() { }
	public InconsistentConfigurationException(String message) {
		super(message);
	}
	public InconsistentConfigurationException(Throwable cause) {
		super(cause);
	}
	public InconsistentConfigurationException(String message,
		Throwable cause) {
		super(message, cause);
	}
}
