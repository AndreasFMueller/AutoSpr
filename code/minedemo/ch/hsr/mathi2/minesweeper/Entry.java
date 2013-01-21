//
// Entry.java -- modifiable entries of the configuration
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: Entry.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.mathi2.minesweeper;

import javax.swing.*;

public class Entry {
	int	state;
	MineButton	button;
	
	public Entry(MineButton button) {
		this.button = button;
		state = Mine.UNKNOWN;
	}

	public void	setState(int state) throws IllegalStateException {
		switch (state) {
		case Mine.BOMB:
		case Mine.OPEN:
		case Mine.UNKNOWN:
			this.state = state;
		default:
			throw new IllegalStateException("bad state: " + state);
		}
	}

	public int	solve() throws InconsistentConfigurationException {
		return 0;
	}
}
