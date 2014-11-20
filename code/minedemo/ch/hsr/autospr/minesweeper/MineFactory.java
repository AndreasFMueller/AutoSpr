//
// MineFactory.java -- build mine buttons
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineFactory.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import javax.swing.*;

/**
 * Build Mine components (Labels are buttons).
 *
 * @author Andreas Mueller
 */
public class MineFactory {
	JComponent	get(int state) throws IllegalStateException {
		if (Mine.isButtonState(state)) {
			MineButton b = new MineButton(state);
			b.addActionListener(new BombActionListener(b));
			return b;
		}
		if (Mine.isLabelState(state)) {
			return new MineLabel(state);
		}
		return null;
	}
}
