//
// MineReader.java -- reads a mines file into an array of integers
//
// (c) 2008 Prof Dr Andreas Mueller, Hochschule Rapperswil
// $Id: MineReader.java,v 1.1 2008/03/12 14:53:20 afm Exp $
//
package ch.hsr.autospr.minesweeper;

import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.EOFException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Vector;
import java.util.Iterator;

/**
 * Read a mine specification file.
 *
 * A mine field specification is a character array where containing 
 * digits from '0' to '8' or the characters 'U' or 'M'. 'M' indicates
 * that this field contains a mine, and 'U' means that the contents of
 * this field is unknown, and the player should find out. Digits indicate
 * the number of mines on surrounding fields.
 *
 * @author Andreas Mueller
 */
public class MineReader extends BufferedReader {
	public	MineReader(File input) throws FileNotFoundException {
		super(new FileReader(input));
	}

	/**
	 * Read a mine field file.
	 * This method reads the mine field file line by line, splits it
	 * up into characters and then decides about the state of each
	 * field.
 	 */
	public int[][]	readAll() throws IOException {
		int[][]	result = null;
		// first read all lines
		Vector	lines = new Vector();
		int	linecount = 0;
		String	line;
		while (null != (line = readLine())) {
			System.out.println("got line '" + line + "'");
			lines.add(line);
			linecount++;
		}
		System.out.println("lines read: " + linecount);

		// now parse every line
		Iterator	i = lines.iterator();
		int	j = 0;
		while (i.hasNext()) {
			char[] chars = ((String)i.next()).toCharArray();
			if (null == result) {
				result = new int[lines.size()][chars.length];
			}
			result[j] = new int[chars.length];
			for (int k = 0; k < chars.length; k++) {
				switch (chars[k]) {
				case 'U':	result[j][k] = Mine.UNKNOWN;
						break;
				case 'M':	result[j][k] = Mine.MARKED;
						break;
				case '0':	
				case ' ':	result[j][k] = 0;
						break;
				case '1':	result[j][k] = 1;
						break;
				case '2':	result[j][k] = 2;
						break;
				case '3':	result[j][k] = 3;
						break;
				case '4':	result[j][k] = 4;
						break;
				case '5':	result[j][k] = 5;
						break;
				case '6':	result[j][k] = 6;
						break;
				case '7':	result[j][k] = 7;
						break;
				case '8':	result[j][k] = 8;
						break;
				default:
					throw new IOException("unknown state found in mines file: " + chars[k]);
				}
			}
			j++;
		}

		// consistency check: all lines should be the same length
		for (int k = 0; j < result.length - 1; k++) {
			if (result[k].length != result[k + 1].length) {
				throw new IOException("inconsistent mines file: lines " + k + " and " + (k + 1) + " have different length");
			}
		}

		// if we get to this point, then the 
		if (result == null) {
			throw new IOException("bad result array");
		}
		return result;
	}
}
