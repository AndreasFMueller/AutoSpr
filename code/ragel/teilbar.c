/*
 * teilbar.c --- simple ragel example
 *
 * (c) 2023 Prof Dr Andreas Müller
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int	main(int argc, char *argv[]) {
	int	cs, res = 0;
	int	i;
	for (i = 1; i < argc; i++) {
		res = 0;
		char	*p = argv[i];
		char	*pe = p + strlen(p);
		char	*eof = pe;
		%% write init;
		%% write exec;
		printf("%s %s\n", argv[i], (res) ? "teilbar" : "nicht teilbar");
	}
	return EXIT_SUCCESS;
}
