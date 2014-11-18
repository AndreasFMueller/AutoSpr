//
// IllegalStateException.java -- exception thrown when a bad state is set
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: IllegalStateException.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

public class IllegalStateException extends Exception {
	public IllegalStateException() { }
	public IllegalStateException(String message) { super(message); }
	public IllegalStateException(Throwable cause) { super(cause); }
	public IllegalStateException(String message, Throwable cause) {
		super(message, cause);
	}
}

