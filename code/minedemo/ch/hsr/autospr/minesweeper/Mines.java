//
// Mines.java -- main frame, contains a Mine Field and two buttons
//               that allow it to start the computation
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
//
package ch.hsr.autospr.minesweeper;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;

/**
 * Main window of the Minesweeper consistency demo application.
 *
 * @author Andreas Mueller
 */
public class Mines extends JFrame {
	final static long serialVersionUID = 1;
	JButton	computebutton, resetbutton;
	MineField	minefield;

	/**
	 * create a Mines window.
	 * @param title	string to display in the title area of the window
	 * @param states	
	 */
	public Mines(String title, int[][] states)
		throws IllegalStateException {
		super(title);
		// Mine Field portion
		minefield = new MineField(states);
		System.out.println("mine field: " + minefield);
		getContentPane().add(minefield, BorderLayout.NORTH);

		// button area
		JPanel	buttonarea = new JPanel();
		getContentPane().add(buttonarea, BorderLayout.SOUTH);

		// add the reset button
		resetbutton = new JButton("clear");
		resetbutton.addActionListener(
			new ResetActionListener(minefield));
		buttonarea.add(resetbutton);

		// default button
		getRootPane().setDefaultButton(resetbutton);

		// geometry
		pack();

		// handling closing
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		//  make it visible
		setVisible(true);
	}

	/**
	 * Wait for a notification.
	 * By calling wait, thread is suspended indefinitely, because
	 * there is notication anywhere that could wake the thread
	 * up again.
 	 */
	synchronized void	pause() {
		try {
			wait();
		} catch (InterruptedException x) {
			return;
		}
	}

	/**
	 * Main program.
	 * @param args	Command line arguments. A single file name of a 
	 *		mine field specification is expected.
	 */
	public static void	main(String args[]) {
		// set the look and feel of the application to MetaLook
		try {
			UIManager.setLookAndFeel(
				"javax.swing.plaf.metal.MetalLookAndFeel");
		} catch (Exception x) {
			System.out.println("cannot set look and feel: " + x);
		}

		// check that we really have a file name argument
		if (args.length != 1) {
			System.err.println("specifiy mines file as argument");
		}

		// application main stuff
		try {
			// create a mine field reader on the file
			String	filename = args[0];
			System.out.println("opening file " + filename);
			MineReader	mr = new MineReader(
				new File(filename));

			// read the states from the file
			int[][]	states = mr.readAll();
			if (states != null) {
				System.out.println("found states");
			}

			// create a new Mines window based on the state array
			Mines	mf = new Mines(filename, states);
			mf.pause();
		} catch (Exception x) {
			System.err.println("cannot process mines file: "
				+ x);
		}
	}
}
