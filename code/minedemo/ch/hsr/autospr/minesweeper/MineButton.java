//
// MineButton.java -- a button class for buttons on the MineSweeper field
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineButton.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import java.awt.*;
import javax.swing.*;
import java.util.Iterator;
import java.net.URL;

/**
 * Button class for the mine field.
 *
 * @author Andreas Mueller
 */
public class MineButton extends JToggleButton implements MineComponent {
	private static final long serialVersionUID = 1;
	int	originalstate;
	int	state;
	Position	fieldposition;

	public void	setMineState(int state) throws IllegalStateException {
		switch (state) {
		case Mine.UNKNOWN:
		case Mine.BOMB:
		case Mine.OPEN:
			break;
		default:
			throw new IllegalStateException("cannot set state " +
				state + " in MineButton");
		}
		this.state = state;
		setBomb(state == Mine.BOMB);
		setText(null);
	}

	public void	reset() {
		if (!isSelected()) {
			try {
				setMineState(originalstate);
			} catch (IllegalStateException x) {
				System.err.println("inconsistent internal state: " + x);
			}
		}
	}
	public void	clear() {
		try {
			setMineState(originalstate);
		} catch (IllegalStateException x) {
			System.err.println("inconsistent internal state: " + x);
		}
		if (isSelected()) {
			getModel().setSelected(false);
		}
	}

	public MineButton(int state) throws IllegalStateException {
		originalstate = state;
		setSize(new Dimension(Mine.WIDTH, Mine.HEIGHT));
		setMineState(state);
	}

	public Position	getPosition() { return fieldposition; }

	public void	setPosition(Position fieldposition) {
		this.fieldposition = fieldposition;
	}

	public boolean	isSelected() {
		return getModel().isSelected();
	}
	public void	setBomb(boolean bomb) {
		if (bomb) {
			URL	url = this.getClass().getResource("/resources/smBomb.png");
			setIcon(new ImageIcon(url));
		} else {
			setIcon(null);
		}
	}
	public boolean	isBomb() {
		return state == Mine.BOMB;
	}
	public boolean	isUnknown() {
		return state == Mine.UNKNOWN;
	}
	public boolean	hasBombcount() {
		return false;
	}

	public int	solve() throws InconsistentConfigurationException {
		System.out.println("working on button position "
			+ fieldposition.toString());
		int	changes = 0;
		Iterator	i = fieldposition.getNeighbors();
		while (i.hasNext()) {
			MineComponent	c = (MineComponent)i.next();
			if (c.hasBombcount()) {
				MineLabel	b = (MineLabel)c;
				changes += b.solve();
			}
		}
		return changes;
	}

}
