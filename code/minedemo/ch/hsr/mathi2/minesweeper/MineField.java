//
// MineField.java -- a mine field is a pane containing lots of MineButtons
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineField.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.mathi2.minesweeper;

import java.awt.*;
import javax.swing.*;
import java.util.Iterator;

/**
 * Mine field.
 *
 * A Mine field is essentially an array of buttons or labels. Buttons
 * are fields of the mine field that the user can modify, all other
 * fields are implemented as buttons.
 */
public class MineField extends JPanel {
	public final static int	topborder = 10;
	public final static int	bottomborder = 10;
	public final static int	leftborder = 10;
	public final static int	rightborder = 10;
	MineFactory	minefactory;
	JComponent	mines[][];

	public int	getFieldwidth() { return mines[0].length; }
	public int	getFieldheight() { return mines.length; }

	/**
	 * Add a mine to the minefield.
	 * @param position	where to place the mine
	 * @param state         current state of the entry
 	 */
	JComponent	addMine(Position position, int state)
		throws IllegalStateException {
		JComponent	b = minefactory.get(state);
		((MineComponent)b).setPosition(position);
		Insets	insets = getInsets();
		b.setBounds(Mine.WIDTH * position.getX() + insets.left
				+ leftborder,
			Mine.HEIGHT * position.getY() + insets.top
				+ topborder,
			Mine.WIDTH, Mine.HEIGHT);
		add(b);
		return b;
	}

	/* query state of a field */
	public boolean	isUnknown(int i, int j) {
		return ((MineComponent)mines[i][j]).isUnknown();
	}
	public boolean	isModifiable(int i, int j) {
		return mines[i][j] instanceof MineButton;
	}
	public boolean	isBomb(int i, int j) {
		return ((MineComponent)mines[i][j]).isBomb();
	}
	public int	getNeighbors(int i, int j) {
		return ((MineLabel)mines[i][j]).getNeighbors();
	}

	/**
	 * reset all components of the mine field.
 	 */
	public void	reset() {
		for (int i = 0; i < mines.length; i++) {
			for (int j = 0; j < mines[0].length; j++) {
				MineComponent	c = (MineComponent)mines[i][j];
				c.reset();
			}
		}
	}

	/**
	 * clear all components of the mine field.
 	 */
	public void	clear() {
		for (int i = 0; i < getFieldheight(); i++) {
			for (int j = 0; j < getFieldwidth(); j++) {
				MineComponent	c = (MineComponent)mines[i][j];
				c.clear();
			}
		}
	}

	/**
	 * access the component at a given position.
	 */
	public MineComponent	elementAt(int x, int y) {
		return (MineComponent)mines[y][x];
	}

	/**
	 * create a minefield.
	 * @param states initial states of the fields of the mine field
	 */
	public MineField(int[][] states) throws IllegalStateException {
		super();

		// get dimensions from the state array
		mines = new JComponent[states.length][states[0].length];
		int	fieldwidth = getFieldwidth();
		int	fieldheight = getFieldheight();
		minefactory = new MineFactory();

		// compute dimensions
		Insets	insets = getInsets();
		Dimension	dimension = new Dimension(
			Mine.WIDTH * fieldwidth + insets.left + insets.right
				+ leftborder + rightborder,
			Mine.HEIGHT * fieldheight + insets.top + insets.bottom
				+ topborder + bottomborder);

		// work without a layout manager
		setLayout(null);

		// set dimensions
		setSize(dimension);
		setMinimumSize(dimension);
		setMaximumSize(dimension);
		setPreferredSize(dimension);

		// create all the mine objects
		for (int i = 0; i < fieldheight; i++) {
			mines[i] = new JComponent[fieldwidth];
			for (int j = 0; j < fieldwidth; j++) {
				mines[i][j] = addMine(new Position(this, j, i),
					states[i][j]);
			}
		}
	}

	/**
	 * get a list off all buttons that are possibly modifiable.
	 * @return	an array of MineButton objects, only modifiable
	 *		elements are returned.
	 */
	public MineButton[]	getModifiable() {
		int	count = 0;
		for (int i = 0; i < getFieldheight(); i++) {
			for (int j = 0; j < getFieldwidth(); j++) {
				if (isModifiable(i, j))
					count++;
			}
		}
		MineButton[]	result = new MineButton[count];
		int	offset = 0;
		for (int i = 0; i < getFieldheight(); i++) {
			for (int j = 0; j < getFieldwidth(); j++) {
				if (isModifiable(i, j)) {
					result[offset++]
						= (MineButton)mines[i][j];
				}
			}
		}
		return result;
	}

	public boolean	isInField(int x, int y) {
		return ((0 <= x) && (x < getFieldwidth()))
			&& ((0 <= y) && (y < getFieldheight()));
	}
}
