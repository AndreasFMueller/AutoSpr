/*
 * tmc.c -- driver program for the turing machine compiler
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <includes.h>
#include "tmc.h"

extern int	yydebug;
extern int	yyparse();

void	yyerror(char *errmsg) {
	fprintf(stderr, "error: %s\n", errmsg);
}

int	yywrap() {
	return 1;
}

tm_t	tm = {
	.nnodes = 0,
	.nodes = NULL,
	.initialstate = 0,
	.initialposition = 0,
	.initialtape = NULL
};

int	tm_file = -1;

int	tmc_read(char *buf, int ms) {
	int	bytes = read(tm_file, buf, ms);
	return bytes;
}

void	tmc_display(tm_t *tmp) {
	for (int i = 0; i < tmp->nnodes; i++) {
		printf("(%d,%c) -> (%d,%c) %s\n",
			tmp->nodes[i].from_state,
			tmp->nodes[i].from_tapechar,
			tmp->nodes[i].to_state,
			tmp->nodes[i].to_tapechar,
			(MOVEMENT_LEFT == tmp->nodes[i].movement)
				?  "Left"
				: (MOVEMENT_RIGHT == tmp->nodes[i].movement) 
					? "Right"
					: "Halt");
	}
}

int	get_charcode(char c) {
	switch (c) {
	case '0':	return 1;
	case '1':	return 2;
	}
	return 0;
}

void	tmc_compile(FILE *output, tm_t *tmp) {
	int	lineno = 1;
	if (tmp->initialtape) {
		// create a copy in reverse order
		char	*tapestring = strdup(tmp->initialtape);
		int	l = strlen(tapestring);
		for (int i = 0; i < l; i++) {
			tapestring[i] = tmp->initialtape[l - 1 - i];
		}
		// convert to standard encoding
		char	*p = tapestring;
		while (*p) {
			switch (*p) {
			case ' ':	*p = '0'; break;
			case '0':	*p = '1'; break;
			case '1':	*p = '2'; break;
			default:	*p = '3'; break;
			}
			p++;
		}
		// convert the tape into a number
		mpz_t	tape;
		mpz_init_set_str(tape, tapestring, 4);
		gmp_fprintf(output, "%d: v0 := %Zd\n", lineno++, tape);
		mpz_clear(tape);
		free(tapestring);
	} else {
		fprintf(output, "%d: v0 := 0\n", lineno++); // tape
	}
	// initial state
	fprintf(output, "%d: v1 := %d\n", lineno++, tmp->initialstate);
	// initial head position
	fprintf(output, "%d: v2 := %d\n", lineno++, tmp->initialposition);
	// initialize the TM state transition counter
	fprintf(output, "%d: v12 := 0\n", lineno++);
	// this is the point we have to return to
	int	loop = lineno;
	// show current state
	fprintf(output, "%d: PRINTTM\n", lineno++);
	// v3 will contain the current character
	fprintf(output, "%d: v3 := v0\n", lineno++);
	fprintf(output, "%d: v4 := v2\n", lineno++);
	fprintf(output, "%d: IF v4 = 0 GOTO %d\n", lineno, lineno + 4);
	lineno++;
	fprintf(output, "%d: v4 := v4 - 1\n", lineno++);
	fprintf(output, "%d: v3 := v3 / 4\n", lineno++);
	fprintf(output, "%d: GOTO %d\n", lineno, lineno - 3);
	lineno++;
	fprintf(output, "%d: v3 := v3 %% 4\n", lineno++);
	int	endline = lineno + tmp->nnodes * 7 + 26;
	for (int i = 0; i < tmp->nnodes; i++) {
		int	next = lineno + 7;
		fprintf(output, "%d: IF v1 = %d GOTO %d\n", lineno,
			tmp->nodes[i].from_state, lineno + 2);
		lineno++;
		fprintf(output, "%d: GOTO %d\n", lineno, next);
		lineno++;
		int	charcode = get_charcode(tmp->nodes[i].from_tapechar);
		fprintf(output, "%d: IF v3 = %d GOTO %d\n", lineno, charcode, lineno + 2);
		lineno++;
		fprintf(output, "%d: GOTO %d\n", lineno++, next);
		// remember new state in variable v7
		fprintf(output, "%d: v7 := %d\n", lineno++, tmp->nodes[i].to_state);
		// remember the new tape character in v6
		charcode = get_charcode(tmp->nodes[i].to_tapechar);
		fprintf(output, "%d: v6 := %d\n", lineno++, charcode);
		// remember the movement int v5
		switch (tmp->nodes[i].movement) {
		case MOVEMENT_LEFT:
			fprintf(output, "%d: v5 := 1\n", lineno++);
			break;
		case MOVEMENT_RIGHT:
			fprintf(output, "%d: v5 := 2\n", lineno++);
			break;
		case MOVEMENT_HALT:
			fprintf(output, "%d: v5 := 3\n", lineno++);
			break;
		}
	}
	// increment the step transition counter
	fprintf(output, "%d: v12 := v12 + 1\n", lineno++);
	// compute 4^(position)
	fprintf(output, "%d: v8 := v2\n", lineno++);
	fprintf(output, "%d: v9 := 1\n", lineno++);
	fprintf(output, "%d: IF v8 = 0 GOTO %d\n", lineno, lineno + 4); lineno++;
	fprintf(output, "%d: v9 := v9 * 4\n", lineno++);
	fprintf(output, "%d: v8 := v8 - 1\n", lineno++);
	fprintf(output, "%d: GOTO %d\n", lineno, lineno - 3); lineno++;
	// left part of the tape
	fprintf(output, "%d: v10 := v0 %% v9\n", lineno++);
	// right part of the tape
	fprintf(output, "%d: v11 := v0 / v9\n", lineno++);
	fprintf(output, "%d: v11 := v11 / 4\n", lineno++);
	fprintf(output, "%d: v11 := v11 * 4\n", lineno++);
	// add the new tape character
	fprintf(output, "%d: v11 := v11 + v6\n", lineno++);
	// put everything together
	fprintf(output, "%d: v11 := v11 * v9\n", lineno++);
	fprintf(output, "%d: v11 := v11 + v10\n", lineno++);
	fprintf(output, "%d: v0 := v11\n", lineno++);
	// modify the head position
	fprintf(output, "%d: IF v5 = 1 GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: v2 := v2 - 1\n", lineno++);
	fprintf(output, "%d: IF v5 = 2 GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: v2 := v2 + 1\n", lineno++);
	fprintf(output, "%d: IF v5 = 3 GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: GOTO %d\n", lineno, lineno + 2); lineno++;
	fprintf(output, "%d: GOTO %d\n", lineno++, endline);
	// new state
	fprintf(output, "%d: v1 := v7\n", lineno++);
	// loop
	fprintf(output, "%d: GOTO %d\n", lineno++, loop);
	// show last state of the turing machine
	fprintf(output, "%d: PRINTSTRING \"last tape contents:\"\n", lineno++);
	fprintf(output, "%d: PRINTTM\n", lineno++);
	fprintf(output, "%d: PRINTSTRING \"last state:\"\n", lineno++);
	fprintf(output, "%d: PRINTVAR v1\n", lineno++);
	fprintf(output, "%d: PRINTSTRING \"last tape position:\"\n", lineno++);
	fprintf(output, "%d: PRINTVAR v2\n", lineno++);
	fprintf(output, "%d: PRINTSTRING \"number of TM state transitions:\"\n",
		lineno++);
	fprintf(output, "%d: PRINTVAR v12\n", lineno++);
	fprintf(output, "%d: PRINTSTRING \"number of GOTO steps:\"\n", lineno++);
	fprintf(output, "%d: PRINTSTEPS\n", lineno++);
	fprintf(output, "%d: HALT\n", lineno);
}

char	*read_initialtape(char *filename) {
	FILE	*f = fopen(filename, "r");
	if (NULL == f) {
		fprintf(stderr, "cannot open file %s: %s\n", filename, strerror(errno));
		return NULL;
	}
	char	buffer[1024];
	fgets(buffer, sizeof(buffer), f);
	buffer[strlen(buffer) - 1] = '\0';
	fclose(f);
	return strdup(buffer);
}

static void	usage(const char *progname) {
	printf("usage: %s [ -dh? ] [ -o outfile ] [ -s state ] [ -p position ] \n\n", progname);
	printf("\t[ -t tape ] [ -T tapefile ] tmprogramfile\n\n");
	printf("read a turing machine (TM) description from <tmprogramfile> and convert\n");
	printf("it into a program in the GOTO language that can then be executed by the\n");
	printf("GOTO virtual machine program gvm.\n\n");
	printf("options:\n");
	printf("  -d,--debug                debug mode, shows lot's of messages during\n");
	printf("                            parsing and compilation of the TM program\n");
	printf("  -h,-?,--help              show this help message and exit\n");
	printf("  -o,--outfile=<outfile>    write compiled GOTO program to <outfile>\n");
	printf("  -s,--start=<state>        initialize the TM to start in state <state>\n");
	printf("                            instead of 0\n");
	printf("  -p,--position=<position>  initialize the TM to start at position <position>\n");
	printf("                            instead of 0\n");
	printf("  -t,--initialtype=<tape>   use string <tape> to initialize the tape of\n");
	printf("                            the TM\n");
	printf("  -T,--tapename=<tapefile>  read the initial tape contents from file\n");
	printf("                            <tapefile>\n");
}

static struct option options[] = {
{ "debug",		no_argument,		NULL,		'd' },
{ "help",		no_argument,		NULL,		'h' },
{ "outfile",		required_argument,	NULL,		'o' },
{ "start",		required_argument,	NULL,		's' },
{ "position",		required_argument,	NULL,		'p' },
{ "initialtape",	required_argument,	NULL,		't' },
{ "tapename",		required_argument,	NULL,		'T' },
{ NULL,			0,			NULL,		 0  }
};

int	main(int argc, char *argv[]) {
	yydebug = 0;
	int	c;
	char	*outfilename = "a.goto";
	int	longindex;
	while (EOF != (c = getopt_long(argc, argv, "do:s:p:t:T:h?",
			options, &longindex)))
		switch (c) {
		case 'd':
			yydebug = 1;
			break;
		case 'h':
		case '?':
			usage(argv[0]);
			exit(EXIT_SUCCESS);
			break;
		case 'o':
			outfilename = optarg;
			break;
		case 's':
			tm.initialstate = atoi(optarg);
			break;
		case 'p':
			tm.initialposition = atoi(optarg);
			break;
		case 't':
			tm.initialtape = optarg;
			break;
		case 'T':
			tm.initialtape = read_initialtape(optarg);
			if (NULL == tm.initialtape) {
				exit(EXIT_FAILURE);
			}
			break;
		}

	/* next argument must be turing machine program file name */
	if (optind >= argc) {
		fprintf(stderr, "no program argument\n");
		exit(EXIT_FAILURE);
	}

	char	*filename = argv[optind];
	if (yydebug) {
		printf("opening file %s\n", filename);
	}
	tm_file = open(filename, O_RDONLY, 0);
	if (tm_file < 0) {
		fprintf(stderr, "cannot open tm program file %s: %s\n",
			filename, strerror(errno));
	}

	/* parse the program */
	yyparse();

	/* display the parsed program */
	tmc_display(&tm);

	/* compile */
	FILE	*output = fopen(outfilename, "w");
	if (NULL == output) {
		fprintf(stderr, "cannot open output file %s for writing: %s\n",
			outfilename, strerror(errno));
		exit(EXIT_FAILURE);
	}
	tmc_compile(output, &tm);
	fclose(output);
	
	exit(EXIT_SUCCESS);
}
