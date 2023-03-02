/*
 * ungerade.c --- simple ragel example
 *
 * (c) 2023 Prof Dr Andreas Müller
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%%{
	machine ungerade;
	action istungerade { res = 1; }
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
		%%{
			ungerade :=  ('1'*'0'('1'|'0'('1')*'0')*) %istungerade;
			write init;
			write exec;
		}%%
		printf("%s %sgerade Anzahl Nullen\n", argv[i],
			(res) ? "un" : "");
	}
	return EXIT_SUCCESS;
}
