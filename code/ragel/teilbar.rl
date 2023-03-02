/*
 * teilbar.java --- simple ragel example
 *
 * (c) 2023 Prof Dr Andreas Müller
 */

public class teilbar {

%%{
	machine teilbar;
	action istteilbar { res = 1; }
	teilbar :=
		start: (
			'0' -> start |
			'1' -> one |
			'' %istteilbar -> final
		),
		one: (
			'0' -> two |
			'1' -> start
		),
		two: (
			'0' -> one |
			'1' -> two
		);
}%%

%% write data;

	public static void	main(String args[]) {
		int	cs, res = 0;
		int	i;
		for (i = 1; i < args.length; i++) {
			String	s = args[i];
			System.out.print(s + ": ");

			byte[]	data = s.getBytes();
			res = 0;
			int p = 0;
			int pe = data.length;
			int eof = pe;
			%% write init;
			%% write exec;
			
			if (res == 0) {
				System.out.print("nicht ");
			}
			System.out.println("teilbar");
		}
	}

}
