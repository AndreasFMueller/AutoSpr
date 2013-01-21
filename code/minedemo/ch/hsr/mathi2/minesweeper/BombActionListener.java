//
// BombActionListener.java -- what to do when the user clicks on a button
//                            to place a bomb
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: BombActionListener.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.mathi2.minesweeper;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 * Action performed when a user clicks on a Minefield button.
 *
 * @author Andreas Mueller
 */
public class BombActionListener implements ActionListener {
	MineButton	button;

	public BombActionListener(MineButton button) {
		this.button = button;
	}

	public void actionPerformed(ActionEvent e) {
		System.out.println("Action on button "
			+ button.getPosition().toString() + ", state is now "
			+ ((button.isSelected()) ? "pressed" : "released"));
		try {
			button.setMineState(
				button.isSelected() ? Mine.BOMB : Mine.UNKNOWN);
		} catch (IllegalStateException x) { }
		// try to solve
		Solver	s = new Solver(button.getPosition().getMinefield());
		System.out.println("start solving");
		try {
			s.solve();
		} catch (InconsistentConfigurationException x) {
			System.err.println("inconsistent configuration: " + x);
		}
		System.out.println("solving complete");
	}
}

