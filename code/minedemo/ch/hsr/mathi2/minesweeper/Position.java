//
// Position.java -- abstraction for a point on the field
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: Position.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.mathi2.minesweeper;

import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;

/**
 * Position wrapper class.
 *
 * This class give easy access to a field on a mine field, but also to
 * the set of all its neighbours.
 *
 * @author Andreas Mueller
 */
public class Position {
	MineField	field;
	int	x, y;

	public Position(MineField field, int x, int y) {
		this.field = field;
		this.x = x; this.y = y;
	}

	public int	getX() { return x; }
	public int	getY() { return y; }
	public MineField	getMinefield() { return field; }

	public String	toString() {
		return "x=" + Integer.toString(x) + "/y=" + Integer.toString(y);
	}

	/**
 	 * Access neighbours of a field.
	 * @return an interator through the set of all neighbours of the field
 	 */
	public Iterator	getNeighbors() {
		Set	neighbors = new HashSet();
		if (field.isInField(x-1, y))
			neighbors.add(field.elementAt(x-1, y));
		if (field.isInField(x-1, y-1))
			neighbors.add(field.elementAt(x-1, y-1));
		if (field.isInField(x-1, y+1))
			neighbors.add(field.elementAt(x-1, y+1));
		if (field.isInField(x, y-1))
			neighbors.add(field.elementAt(x, y-1));
		if (field.isInField(x, y+1))
			neighbors.add(field.elementAt(x, y+1));
		if (field.isInField(x+1, y))
			neighbors.add(field.elementAt(x+1, y));
		if (field.isInField(x+1, y-1))
			neighbors.add(field.elementAt(x+1, y-1));
		if (field.isInField(x+1, y+1))
			neighbors.add(field.elementAt(x+1, y+1));
		return neighbors.iterator();
	}
}
