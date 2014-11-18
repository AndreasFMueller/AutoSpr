//
// Solver.java -- find as many bombs as possible
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: Solver.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import java.util.Vector;

/**
 * Global solver algorithm.
 *
 * @author Andreas Mueller
 */
public class Solver {
	MineField	minefield;

	public Solver(MineField minefield) {
		this.minefield = minefield;
	}

	public void	solve() throws InconsistentConfigurationException {
		minefield.reset();
		// convert the 
		MineButton[]	fields = minefield.getModifiable();

		// go through the fields and try to determine the state
		// based on the information you find in the neighbor
		int	changes = 0;
		do {
			changes = 0;
			for (int i = 0; i < fields.length; i++) {
				changes += fields[i].solve();
			}
			System.out.println("changes: " + changes);
		} while (changes > 0);
		
	}

}

