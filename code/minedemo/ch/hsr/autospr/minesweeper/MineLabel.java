//
// MineLabel.java -- labels for fields that cannot be changed
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineLabel.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import javax.swing.*;
import java.awt.*;
import java.util.Iterator;
import java.net.URL;

/**
 * Mine components that are immutable (labels).
 *
 * Some fields of the minefield are either preset by the number of
 * bombs (0 to 8) surrounding the field, or by a bomb. They are
 * implemented as a JLabel object in MineField.
 *
 * @author Andreas Mueller
 */
public class MineLabel extends JLabel implements MineComponent {
	final static long serialVersionUID = 1;
	int	state;
	final static int	emphasize_thickness = 3;
	Position	fieldposition;
	public MineLabel(int s) throws IllegalStateException {
		state = s;
		setSize(new Dimension(Mine.WIDTH, Mine.HEIGHT));
		setText(null);
		setIcon(null);
		setBorder(BorderFactory.createLineBorder(Color.gray));
		setHorizontalAlignment(CENTER);
		switch (state) {
			case Mine.MARKED:
				URL	url = this.getClass().getResource("/resources/marker.png");
				setIcon(new ImageIcon(url));
				break;
			case Mine.OPEN:
				setText("<html></html> ");
				break;
			case Mine.BOMBS_1:
				setText("<html><font color='red'>1</font></html>");
				break;
			case Mine.BOMBS_2:
				setText("<html><font color='blue'>2</font></html>");
				break;
			case Mine.BOMBS_3:
				setText("<html><font color='#ff00ff'>3</font></html>");
				break;
			case Mine.BOMBS_4:
				setText("<html><font color='#aa4422'>4</font></html>");
				break;
			case Mine.BOMBS_5:
				setText("<html><font color='green'>5</font></html>");
				break;
			case Mine.BOMBS_6:
				setText("<html><font color='black'>6</font></html>");
				break;
			case Mine.BOMBS_7:
				setText("<html><font color='yellow'>7</font></html>");
				break;
			case Mine.BOMBS_8:
				setText("<html><font color=''>8</font></html>");
				break;
			default:
				throw new IllegalStateException("state " +
					state + " cannot be set in MineLabel");
		}
	}
	public boolean	isBomb() {
		return (state == Mine.MARKED);
	}
	public int	getNeighbors() {
		if (state != Mine.MARKED) {
			return state;
		}
		return -1;
	}

	public int	countUnknownNeighbors() {
		Iterator	i = fieldposition.getNeighbors();
		int	counter = 0;
		while (i.hasNext()) {
			MineComponent	b = (MineComponent)i.next();
			if (b.isUnknown()) { counter++; }
		}
		return counter;
	}
	public int	countBombNeighbors() {
		Iterator	i = fieldposition.getNeighbors();
		int	counter = 0;
		while (i.hasNext()) {
			MineComponent	b = (MineComponent)i.next();
			if (b.isBomb()) { counter++; }
		}
		return counter;
	}

	/**
	 * Solve the consistency problem.
	 * This method first checks whether the bombs in the neighborhood
	 * are consistent, and throws an exception if the aren't. Then
	 * it sets all unknown neighbors to bombs if the number of unknowns
	 * is equal to the number of not yet marked bombs. If there are
	 * no bombs missing, then similarly the unknowns are set to open.
	 */
	public int	solve() throws InconsistentConfigurationException {
		System.out.println("    working on label position: "
			+ fieldposition.toString());
		int	bombs = countBombNeighbors();
		int	unknowns = countUnknownNeighbors();
		int	discrepancy = state - bombs;
		System.out.println("    bombs=" + bombs + ", unknowns=" + unknowns
			+ ", state=" + state);
		int	changes = 0;
		if (bombs > state) {
			setBorder(BorderFactory.createLineBorder(Color.red,
				emphasize_thickness));
			throw new InconsistentConfigurationException(
				"more bombs than allowed: " + bombs + " > "
				+ state);
		}
		if ((bombs + unknowns) < state) {
			setBorder(BorderFactory.createLineBorder(Color.red,
				emphasize_thickness));
			throw new InconsistentConfigurationException(
				"not enough space for: " + (bombs  + unknowns)
				+ " < " + state);
		}

		// if the discrepancy does not allow to decide the bombs,
		// mark the label with a green border
		if ((discrepancy != 0) && (discrepancy != unknowns)) {
			setBorder(BorderFactory.createLineBorder(
				new Color(100, 150, 100), emphasize_thickness));
			return 0;
		}

		// if we get to this point, then we have gained everything
		// we possibly can from this field, so mark it with a gray
		// border
		setBorder(BorderFactory.createLineBorder(Color.gray));

		// if there are no unknown fields in the neighborhood,
		// we are done at this point
		if (0 == unknowns) {
			return 0;
		}
		// if the number of unknowns coincides with the number of
		// lacking bombs, we can change all unknown neighbors to
		// bombs
		if (unknowns == (state - bombs)) {
			System.out.println("        setting bombs");
			// set all unknowns to bombs
			Iterator	i = fieldposition.getNeighbors();
			while (i.hasNext()) {
				MineComponent	c = (MineComponent)i.next();
				if (c.isUnknown()) {
					MineButton	b = (MineButton)c;
					try {
						System.out.println("            " + b.getPosition());
						b.setMineState(Mine.BOMB);
						changes++;
					} catch (IllegalStateException x) { }
				}
			}
		}
		if (0 == (state - bombs)) {
			// set all unknowns to open
			System.out.println("        clearing bombs");
			Iterator	i = fieldposition.getNeighbors();
			while (i.hasNext()) {
				MineComponent	c = (MineComponent)i.next();
				if (c.isUnknown()) {
					MineButton	b = (MineButton)c;
					try {
						System.out.println("            " + b.getPosition());
						b.setMineState(Mine.OPEN);
						changes++;
					} catch (IllegalStateException x) { }
				}
			}
		}
		return changes;
	}

	public void	setPosition(Position position) {
		fieldposition = position;
	}
	public Position	getPosition() { return fieldposition; }
	public boolean	isUnknown() {
		return false;
	}
	public boolean	hasBombcount() {
		return state != Mine.MARKED;
	}
	public void	reset() {
		setBorder(BorderFactory.createLineBorder(Color.gray));
	}
	public void	clear() {
		reset();
	}
}
