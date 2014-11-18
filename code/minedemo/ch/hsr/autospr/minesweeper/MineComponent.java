//
// MineComponent.java -- common methods for 
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineComponent.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

public interface MineComponent {
	public void	setPosition(Position where);
	public Position	getPosition();	
	public void	reset();
	public void	clear();
	public boolean	isBomb();
	public boolean	isUnknown();
	public boolean	hasBombcount();
}
