//
// Mine.java -- class to hold common constants for buttons and labels
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: Mine.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.mathi2.minesweeper;

/**
 * holder class for mine field states.
 *
 * @author Andreas Mueller
 */
public class Mine {
	public final static int UNKNOWN = -3;
	public final static int	BOMB = -2;
	public final static int	MARKED = -1;

	public final static int OPEN = 0;
	public final static int	BOMBS_0 = 0;
	public final static int	BOMBS_1 = 1;
	public final static int	BOMBS_2 = 2;
	public final static int	BOMBS_3 = 3;
	public final static int	BOMBS_4 = 4;
	public final static int	BOMBS_5 = 5;
	public final static int	BOMBS_6 = 6;
	public final static int	BOMBS_7 = 7;
	public final static int	BOMBS_8 = 8;

	public final static int	WIDTH = 20;
	public final static int HEIGHT = 20;

	public static boolean	isButtonState(int state) {
		return (state == UNKNOWN) || (state == BOMB);
	}

	public static boolean	isLabelState(int state) {
		return ((state >= -1) && (state <= BOMBS_8));
	}
}

