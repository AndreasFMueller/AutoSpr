/*
 * turing.c -- turing machine simulator
 *
 * (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <regex.h>
#include <getopt.h>
#include <unistd.h>

static int	verbose = 0;
static int	delay = 0;

#define	MOVE_LEFT	-1
#define	MOVE_RIGHT	1
#define	MOVE_HALT	0

typedef struct tm_state_change_s {
	char	value;
	int	nextstate;
	int	movement;
} tm_state_change_t;


typedef struct tm_state_s {
	tm_state_change_t	change[3]; /* in order: '0', '1', ' ' */
} tm_state_t;

typedef struct tape_s {
	int	size;
	char	*contents;
} tape_t;

typedef	struct tm_s {
	int	step;
	int	current;	/* current state */
	int	position;	/* current read/write head position */
	int	nstates;
	tm_state_t	*states;
	tape_t	*tape;
} tm_t;

/*
 * tm_reachable -- find out whether a state is reachable
 */
static int	tm_reachable(tm_t *tm, int state) {
	if (0 == state) {
		return 1; // start state
	}
	if ((state >= tm->nstates) || (state < 0)) {
		return 0;
	}
	for (int i = 0; i < tm->nstates; i++) {
		for (int j = 0; j < 3; j++) {
			if (tm->states[i].change[j].nextstate == state) {
				return 1;
			}
		}
	}
	return 0;
}

/*
 * tm_renamestate -- rename a state
 */
static void	tm_rename(tm_t *tm, int state, int renamedstate) {
	memcpy(tm->states[renamedstate].change, tm->states[state].change,
		3 * sizeof(tm_state_change_t));
	for (int i = 0; i < tm->nstates; i++) {
		for (int j = 0; j < 3; j++) {
			if (tm->states[i].change[j].nextstate == state) {
				tm->states[i].change[j].nextstate = renamedstate;
			}
		}
	}
	for (int j = 0; j < 3; j++) {
		tm->states[state].change[j].nextstate = -1;
		tm->states[state].change[j].value = j;
		tm->states[state].change[j].movement = MOVE_HALT;
	}
}

/*
 * tm_trunc -- cut off all states that are not needed
 */
static void	tm_trunc(tm_t *tm) {
	printf("truncating TM\n");
	while (tm->nstates > 0) {
		if (tm_reachable(tm, tm->nstates - 1)) {
			printf("TM truncated: %d\n", tm->nstates);
			return;
		} 
		tm->nstates--;
	}
}

/*
 * tm_compress -- compress the tm into as few consecutive states as possible
 */
static void	tm_compress(tm_t *tm) {
	int	state = 1;
	while (state < tm->nstates) {
		tm_trunc(tm);
		if ((state < tm->nstates) && (!tm_reachable(tm, state))) {
			int	i = state;
			do {
				i++;
				if (tm_reachable(tm, i)) {
					tm_rename(tm, i, state);
					i = tm->nstates;
				}
			} while (i < tm->nstates);
		}
		state++;
	}
}

/*
 * increase the size of the turing machine
 */
static void	tm_increase(tm_t *tm, int nstates) {
	if (nstates <= tm->nstates) {
		return;
	}
	tm->states = (tm_state_t*)realloc(tm->states,
		nstates * sizeof(tm_state_t));
	for (int i = tm->nstates; i < nstates; i++) {
		for (int j = 0; j < 3; j++) {
			tm->states[i].change[j].value = j;
			tm->states[i].change[j].nextstate = -1;
			tm->states[i].change[j].movement = MOVE_HALT;
		}
	}
	tm->nstates = nstates;
}

static const char	*regstrerror(int rc) {
	switch (rc) {
#ifdef REG_NOMATCH
	case REG_NOMATCH:	return "no match"; break;
#endif
#ifdef REG_BADPAT
	case REG_BADPAT:	return "invalid regular expression"; break;
#endif
#ifdef REG_ECOLLATE
	case REG_ECOLLATE:	return "invalid collating element"; break;
#endif
#ifdef REG_ECTYPE
	case REG_ECTYPE:	return "invalid character class"; break;
#endif
#ifdef REG_EESCAPE
	case REG_EESCAPE:	return "\\ applied to unescapable character";
				break;
#endif
#ifdef REG_ESUBREG
	case REG_ESUBREG:	return "invalid backreference number"; break;
#endif
#ifdef REG_EBRACK
	case REG_EBRACK:		return "brackets not balanced"; break;
#endif
#ifdef REG_EPAREN
	case REG_EPAREN:	return "parentheses not balanced"; break;
#endif
#ifdef REG_EBRACE
	case REG_EBRACE:	return "braces not balanced"; break;
#endif
#ifdef REG_BADBR
	case REG_BADBR:		return "invalid repetition count(s) in {}";
				break;
#endif
#ifdef REG_ERANGE
	case REG_ERANGE:	return "invalid character range in []"; break;
#endif
#ifdef REG_ESPACE
	case REG_ESPACE:	return "ran out of space"; break;
#endif
#ifdef REG_BADRPT
	case REG_BADRPT:	return "?, * or + operand invalid"; break;
#endif
#ifdef REG_EMPTY
	case REG_EMPTY:		return "empty (sub)expression"; break;
#endif
#ifdef REG_ASSERT
	case REG_ASSERT:	return "can't happen, you found a bug"; break;
#endif
#ifdef REG_INVARG
	case REG_INVARG:	return "invalid argument, e.g. negative-length "
					"string"; break;
#endif
#ifdef REG_ILLSEQ
	case REG_ILLSEQ:	return "invalid byte sequence (bad multibyte "
					"character)"; break;
#endif
	}
	return "no error";
}

static regex_t	rx;
static const char	*match
	 = ".*\\(([0-9]*),([01B])\\).*\\(([0-9]*),([01B])\\).*(Left|Right|Halt).*"; 

static void	init_regex(const char *match) {
	int	rc;
	if ((rc = regcomp(&rx, match, REG_EXTENDED)) != 0) {
		fprintf(stderr, "cannot compile regex %s: %s\n",
			match, regstrerror(rc));
		exit(EXIT_FAILURE);
	}
}

#define	SUBEXPRESSIONS	10

static int	tm_getstate(const char *line, regmatch_t *r) {
	char	buffer[20];
	memset(buffer, '\0', sizeof(buffer));
	strncpy(buffer, &line[r->rm_so], r->rm_eo - r->rm_so);
	return atoi(buffer);
}
static int	tm_getmovement(const char *line, regmatch_t *r) {
	if (0 == strncmp("Left", &line[r->rm_so], r->rm_eo - r->rm_so)) {
		return MOVE_LEFT;
	}
	if (0 == strncmp("Right", &line[r->rm_so], r->rm_eo - r->rm_so)) {
		return MOVE_RIGHT;
	}
	if (0 == strncmp("Halt", &line[r->rm_so], r->rm_eo - r->rm_so)) {
		return MOVE_HALT;
	}
	return MOVE_HALT;
}

static int	tm_valuechar(char c) {
	switch (c) {
	case '0':	return 0; break;
	case '1':	return 1; break;
	case 'B':	return 2; break;
	}
	return ' ';
}

static void	tm_addline(tm_t *tm, const char *line, int lineno) {
	regmatch_t	matches[SUBEXPRESSIONS];
	printf("analyzing line: %s", line);
	int	rc = regexec(&rx, line, SUBEXPRESSIONS, matches, 0);
	if (rc != 0) {
		fprintf(stderr, "error on line %d: %s, skipped\n", lineno,
			regstrerror(rc));
		return;
	}
	int	currentstate = tm_getstate(line, &matches[1]);
	tm_increase(tm, currentstate + 1);
	int	nextstate = tm_getstate(line, &matches[3]);
	tm_increase(tm, nextstate + 1);
	int	change = tm_valuechar(line[matches[2].rm_so]);
	tm->states[currentstate].change[change].nextstate = nextstate;
	tm->states[currentstate].change[change].value 
		= tm_valuechar(line[matches[4].rm_so]);
	tm->states[currentstate].change[change].movement
		= tm_getmovement(line, &matches[5]);
}

/*
 * read turing machine program
 */
tm_t	*read_tm(const char *filename, tape_t *tape, int offset) {
	tm_t	*tm = (tm_t *)malloc(sizeof(tm_t));
	tm->tape = tape;
	tm->current = 0;
	tm->position = offset;
	tm->states = NULL;
	tm->nstates = 0;
	tm->step = 0;

	/* open file and read machine definition */
	FILE	*f = fopen(filename, "r");
	if (NULL == f) {
		fprintf(stderr, "cannot open machine description file %s: %s\n",
			filename, strerror(errno));
		free(tm);
		return NULL;
	}

	/* read the file line by line */
	char	line[128];
	int	lineno = 0;
	while (NULL != fgets(line, sizeof(line), f)) {
		tm_addline(tm, line, ++lineno);
	}

	/* close the file */
	fclose(f);

	/* that's it */
	return tm;
}

/*
 * dump a turing machine
 */
static char	*tm_strmovement(int m) {
	switch (m) {
	case -1:	return "Left"; break;
	case 0:		return "Halt"; break;
	case 1:		return "Right"; break;
	}
	return "(unknown)";
}
static char	tm_charvalue(int value) {
	switch (value) {
	case 0:	return '0'; break;
	case 1:	return '1'; break;
	case 2:	return 'B'; break;
	}
	return ' ';
}

void	tm_dump(tm_t *tm, const char *machineoutput) {
	FILE	*outfile = stdout;
	if (NULL != machineoutput) {
		outfile = fopen(machineoutput, "w");
	}
	printf("turing machine has %d states\n", tm->nstates);
	for (int i = 0; i < tm->nstates; i++) {
		fprintf(outfile, "(%d,0) -> (%d,%c) %s\n", i,
			(tm->states[i].change[0].nextstate < 0)
				? i : tm->states[i].change[0].nextstate,
			tm_charvalue(tm->states[i].change[0].value),
			tm_strmovement(tm->states[i].change[0].movement)
		);
		fprintf(outfile, "(%d,1) -> (%d,%c) %s\n", i,
			(tm->states[i].change[1].nextstate < 0)
				? i : tm->states[i].change[1].nextstate,
			tm_charvalue(tm->states[i].change[1].value),
			tm_strmovement(tm->states[i].change[1].movement)
		);
		fprintf(outfile, "(%d,B) -> (%d,%c) %s\n\n", i,
			(tm->states[i].change[2].nextstate < 0)
				? i : tm->states[i].change[2].nextstate,
			tm_charvalue(tm->states[i].change[2].value),
			tm_strmovement(tm->states[i].change[2].movement)
		);
	}
	if (NULL != machineoutput) {
		fclose(outfile);
	}
}

/*
 * create an empty tape of a given size
 */
tape_t	*empty_tape(const int size) {
	tape_t	*tape = (tape_t *)malloc(sizeof(tape_t));
	tape->size = size; 
	tape->contents = (char *)malloc(tape->size);
	memset(tape->contents, ' ', tape->size);
	return tape;
}

/*
 * read initial tape contents
 */
tape_t	*read_tape(const char *filename, int size, int offset) {
	/* find out how long the file is, this allows us to allocate a
	   reasonable amount of memory, unless size is given */
	struct stat	sb;
	if (stat(filename, &sb) < 0) {
		fprintf(stderr, "cannot stat tape description %s: %s\n",
			filename, strerror(errno));
		return NULL;
	}

	/* open file to read tape contents */
	int	fd = open(filename, O_RDONLY);
	if (fd < 0) {
		fprintf(stderr, "cannot open tape description %s: %s",
			filename, strerror(errno));
		return NULL;
	}

	/* allocate the tape */
	int	altsize = ((sb.st_size + offset) > size)
			? (sb.st_size + offset) : size;
	tape_t	*tape = empty_tape(altsize);
	read(fd, tape->contents + offset, altsize);
	close(fd);

	/* verify that all characters are legal */
	for (int i = 0; i < tape->size; i++) {
		switch (tape->contents[i]) {
		case '0':
		case '1':
		case ' ':
			break;
		default:
			tape->contents[i] = ' ';
			break;
		}
	}

	/* tape definition completely read */
	return tape;
}

/*
 * show the current tape contents
 */
void	show_tape(tape_t *tape) {
	putchar('[');
	for (int i = 0; i < tape->size; i++) {
		putchar(tape->contents[i]);
	}
	putchar(']');
}

/*
 * new content value
 */
static char	tm_nextcontent(int value) {
	switch (value) {
	case 0:	return '0'; break;
	case 1:	return '1'; break;
	case 2:	return ' '; break;
	}
	return ' ';
}

/*
 * show_tm
 */
static void	show_tm(tm_t *tm) {
	show_tape(tm->tape);
	printf(" %d\n", tm->step);
	for (int i = 0; i <= tm->position; i++) {
		putchar(' ');
	}
	putchar('^');
	printf("%d\n", tm->current);
}

/*
 * \brief start turing computation
 *
 * \param tm	the turing machine to run
 */
static void	tm_run(tm_t *tm) {
	while (1) {
		tm_state_change_t	*statechange;
		switch (tm->tape->contents[tm->position]) {
		case '0':
			statechange = &tm->states[tm->current].change[0];
			break;
		case '1':
			statechange = &tm->states[tm->current].change[1];
			break;
		case ' ':
			statechange = &tm->states[tm->current].change[2];
			break;
		default:
			fprintf(stderr, "corrupt tape\n");
			exit(EXIT_FAILURE);
			break;
		}
		tm->tape->contents[tm->position]
			= tm_nextcontent(statechange->value);
		tm->position += statechange->movement;
		tm->current = statechange->nextstate;

		/* verify the we are still in the valid tape */
		if (tm->position < 0) {
			fprintf(stderr, "past left end of tape\n");
			exit(EXIT_FAILURE);
		}
		if (tm->position >= tm->tape->size) {
			fprintf(stderr, "past right end of tape\n");
			exit(EXIT_FAILURE);
		}
		tm->step++;
		if (verbose) {
			show_tm(tm);
			if (delay > 0) {
				usleep(delay);
			}
		} else {
			if (0 == (tm->step % 1000000)) {
			show_tm(tm);
			//	printf(".");
			//	fflush(stdout);
			}
		}

		/* stop if last movement was a halt */
		if (MOVE_HALT == statechange->movement) {
			return;
		}
	}
}

/*
 * usage 
 */
void	usage(char *progname) {
	printf("usage: %s [ -vc ] [ -s size ] [ -t tapecontents ] [ -o offset ] \\\n     [ -m output ] [ -p pause ] program\n", progname);
	printf("Simulate a turing maschine decribed in the <program> file.\n");
	printf("The program first reads the contents of the program file,\n");
	printf("and dumps its contents reordered to standard output. It then\n");
	printf("reads the data tape (if specified) and positions the read/write\n");
	printf("head at the beginning or the offset specified with the -o option.\n"),
	printf("It then simulates the machine and writes the resulting tape contents\n");
	printf("to standard output.\n");
	printf("Options:\n");
	printf("  -v                 Verbose output, every step of the machine is displayed\n");
	printf("  -c                 Compress the turing machine description so as to use\n");
	printf("                     as small integers to represent states as possible.\n");
	printf("  -s size            Size of the tape. An abstract turing machine has\n");
	printf("                     of course an infinite tape, for the simulation\n");
	printf("                     We need to specify how large the tape would be.\n");
	printf("                     Default size ist 1024.\n");
	printf("  -t tapecontents    The file tapecontents contains the initial\n");
	printf("                     tape contents\n");
	printf("  -o offset          Initial offset of the read/write head into the tape\n");
	printf("  -m output          Write the output of the simulation to the file output\n");
	printf("  -p pause           After each step, pause for <pause> microseconds\n");
	printf("  -h, -?             Display this help message\n");
}

/*
 * main program
 */
int	main(int argc, char *argv[]) {
	int	c;
	int	size = 1024;
	int	offset = 0;
	int	compress = 0;
	const char	*tapefile = NULL;
	const char	*machineoutput = NULL;

	/* initialize regex */
	init_regex(match);

	/* parse command line */
	while (EOF != (c = getopt(argc, argv, "s:t:o:vp:cm:h?")))
		switch (c) {
		case 's':
			size = atoi(optarg);
			break;
		case 't':
			tapefile = optarg;
			break;
		case 'o':
			offset = atoi(optarg);
			break;
		case 'v':
			verbose = 1;
			break;
		case 'p':
			delay = atoi(optarg);
			break;
		case 'c':
			compress = 1;
			break;
		case 'm':
			machineoutput = optarg;
			break;
		case 'h':
		case '?':
			usage(argv[0]);
			return EXIT_SUCCESS;
		}

	/* next argument should be machine description */
	if (argc <= optind) {
		fprintf(stderr, "machine description file name missing\n");
		usage(argv[0]);
		exit(EXIT_FAILURE);
	}
	const char *machinefile = argv[optind];
	printf("machine description: %s\n", machinefile);

	/* read a tape */
	tape_t	*tape = NULL;
	if (NULL == tapefile) {
		tape = empty_tape(size);
	} else {
		tape = read_tape(tapefile, size, offset);
	}
	if (NULL == tape) {
		fprintf(stderr, "cannot create tape\n");
		exit(EXIT_FAILURE);
	}

	/* read turing machine description */
	tm_t	*tm = read_tm(machinefile, tape, offset);
	if (compress) {
		printf("compressing\n");
		tm_compress(tm);
	}
	tm_dump(tm, machineoutput);

	/* simulate turing machine computation */
	printf("start state of the machine:\n");
	show_tm(tm);
	printf("start the machine\n");
	tm_run(tm);
	printf("machine terminates after %d steps in state %d at tape position %d\n",
		tm->step, tm->current, tm->position);

	exit(EXIT_SUCCESS);
}
