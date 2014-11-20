//
// ResetActionListener.java
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: ResetActionListener.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import java.awt.event.*;

public class ResetActionListener implements ActionListener {
	MineField	field;
	public	ResetActionListener(MineField field) {
		this.field = field;
	}
	public void	actionPerformed(ActionEvent ev) {
		System.out.println("clearing field");
		field.clear();
	}
}
