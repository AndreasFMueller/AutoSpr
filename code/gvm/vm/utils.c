/*
 * utils.c -- the goto virtual machine
 *
 * (c) 2012-2024 Prof Dr Andreas Mueller
 */
#include <includes.h>
#include <gvm.h> 
#include <utils.h>

extern int yydebug;

/*
The following musleep function is a terrible hack. I would have
prefered if nanosleep worked on Mac OS X and Linux just out of the
box. It doesn't.  To even get nanosleep exposed in the headers,
some feature test macros need be set, but these same macros cause
very strange behaviour in other parts of the program, e.g. consistent
segementation faults inside strdup.  So to avoid any problems, we
don't use nanosleep at all if configure does not see it immediately,
and we use select the old fashioned way.
*/
static void	musleep(unsigned long microseconds) {
#ifndef HAVE_NANOSLEEP
	struct timespec	rqtp;
	rqtp.tv_sec = 0;
	rqtp.tv_nsec = 1000 * microseconds;
	nanosleep(&rqtp, NULL);
#else /* HAVE_NANOSLEEP */
	struct timeval	tv;
	tv.tv_sec = microseconds / 1000000;
	tv.tv_usec = microseconds % 1000000;	
	if (0 != select(0, NULL, NULL, NULL, &tv)) {
		fprintf(stderr, "problem during select: %s\n",
			strerror(errno));
	}
#endif /* HAVE_NANOSLEEP */
}

/* some global variables */
int	gvm_trace;
int	gvm_file;

/* the gvm_read function is used by the YY_INPUT macros in tokens.l */
int	gvm_read(char *buf, int ms) {
	int	bytes = read(gvm_file, buf, ms);
	return bytes;
}

/* auxiliary function to display the current tm state */
void	gvm_printtmstate(gvm_t *gvmp, int size) {
	mpz_t	r, q, n;
	mpz_init(r); mpz_init(q); mpz_init(n);
	mpz_set(n, gvmp->vars[0]);
	printf("[");
	for (int i = 0; i < size; i++) {
		int	u = mpz_fdiv_qr_ui(q, r, n, 4);
		switch (u) {
		case 0:	putchar(' '); break;
		case 1: putchar('0'); break;
		case 2: putchar('1'); break;
		case 3: putchar('*'); break;
		}
		mpz_set(n, q);
	}
	printf("]\n ");
	int	position = mpz_get_ui(gvmp->vars[2]);
	for (int i = 0; i < position; i++) {
		putchar(' ');
	}
	printf("^%lu\n", mpz_get_ui(gvmp->vars[1]));
	mpz_clear(r);
}

/* display the current GOTO program */
void	gvm_display(gvm_t *gvmp) {
	/* display the program */
	for (int i = 0; i < gvmp->nnodes; i++) {
		if (gvmp->nodes[i].type > 0) {
			printf("%d: [%d]", i + 1, gvmp->nodes[i].type);
		}
		switch (gvmp->nodes[i].type) {
		case GVM_NODE_NONE:
			break;
		case GVM_NODE_ASSIGN_CONSTANT:
			gmp_printf("v%d := %Zd",
				gvmp->nodes[i].u.a.target_varno,
				gvmp->nodes[i].u.a.constant);
			break;
		case GVM_NODE_ASSIGN_VARIABLE:
			printf("v%d := v%d",
				gvmp->nodes[i].u.a.target_varno,
				gvmp->nodes[i].u.a.source_varno);
			break;
		case GVM_NODE_ASSIGN_OPERATOR_CONST:
			gmp_printf("v%d := v%d %c %Zd",
				gvmp->nodes[i].u.a.target_varno,
				gvmp->nodes[i].u.a.source_varno,
				gvmp->nodes[i].u.a.operator,
				gvmp->nodes[i].u.a.constant);
			break;
		case GVM_NODE_ASSIGN_OPERATOR:
			printf("v%d := v%d %c v%d",
				gvmp->nodes[i].u.a.target_varno,
				gvmp->nodes[i].u.a.source_varno,
				gvmp->nodes[i].u.a.operator,
				gvmp->nodes[i].u.a.source2_varno);
			break;
		case GVM_NODE_GOTO:
			printf("GOTO %d",
				gvmp->nodes[i].u.g.target + 1);
			break;
		case GVM_NODE_CONDITIONAL_GOTO:
			printf("IF v%d = %d GOTO %d",
				gvmp->nodes[i].u.g.condition_varno,
				gvmp->nodes[i].u.g.condition_constant,
				gvmp->nodes[i].u.g.target + 1);
			break;
		case GVM_NODE_HALT:
			printf("HALT");
			break;
		case GVM_NODE_PRINTSTRING:
			printf("PRINTSTRING \"%s\"", gvmp->nodes[i].u.p.string);
			break;
		case GVM_NODE_PRINTVAR:
			printf("PRINTVAR v%d", gvmp->nodes[i].u.p.varno);
			break;
		case GVM_NODE_PRINTTM:
			printf("PRINTTM");
			break;
		}
		if (gvmp->nodes[i].type > 0) {
			printf("\n");
		}
	}
}

/* run the turing machine program */
void	gvm_run(gvm_t *gvmp) {
	/* we need program counter variable */
	int	pc = 0;
	gvmp->steps = 0;

	/* the following variables are mainly operands and results for
	   assignment commands */
	mpz_t	*operand1;
	mpz_t	*operand2;
	mpz_t	constant;
	mpz_init(constant);
	mpz_t	result;
	mpz_init(result);

	/* here starts the "big" execution loop */
	while (pc < gvmp->nnodes) {
		if (gvm_trace) {
			printf("%d: ", pc + 1);
		}
		gvmp->steps++;
		switch (gvmp->nodes[pc].type) {
		case GVM_NODE_ASSIGN_CONSTANT:
			mpz_set(gvmp->vars[gvmp->nodes[pc].u.a.target_varno],
				gvmp->nodes[pc].u.a.constant);
			if (gvm_trace) {
				gmp_printf("v%d = %Zd --> ",
					gvmp->nodes[pc].u.a.target_varno,
					gvmp->nodes[pc].u.a.constant);
				gmp_printf("%Zd\n",
					gvmp->vars[gvmp->nodes[pc].u.a.target_varno]);
			}
			pc += 1;
			break;
		case GVM_NODE_ASSIGN_VARIABLE:
			mpz_set(gvmp->vars[gvmp->nodes[pc].u.a.target_varno],
				gvmp->vars[gvmp->nodes[pc].u.a.source_varno]);
			if (gvm_trace) {
				printf("v%d = v%d --> ",
					gvmp->nodes[pc].u.a.target_varno,
					gvmp->nodes[pc].u.a.source_varno);
				gmp_printf("%Zd\n",
					gvmp->vars[gvmp->nodes[pc].u.a.target_varno]);
			}
			pc += 1;
			break;
		case GVM_NODE_ASSIGN_OPERATOR_CONST:
			operand1 = &gvmp->vars[gvmp->nodes[pc].u.a.source_varno];
			mpz_set(constant, gvmp->nodes[pc].u.a.constant);
			switch (gvmp->nodes[pc].u.a.operator) {
			case '+':	mpz_add(result, *operand1, constant);
					break;
			case '-':	mpz_sub(result, *operand1, constant);
					break;
			case '*':	mpz_mul(result, *operand1, constant);
					break;
			case '/':	mpz_fdiv_q(result, *operand1, constant);
					break;
			case '%':	mpz_fdiv_r(result, *operand1, constant);
					break;
			}
			mpz_set(gvmp->vars[gvmp->nodes[pc].u.a.target_varno], result);
			if (gvm_trace) {
				gmp_printf("v%d = v%d %c %Zd --> ",
					gvmp->nodes[pc].u.a.target_varno,
					gvmp->nodes[pc].u.a.source_varno,
					gvmp->nodes[pc].u.a.operator,
					gvmp->nodes[pc].u.a.constant);
				gmp_printf("%Zd\n",
					gvmp->vars[gvmp->nodes[pc].u.a.target_varno]);
			}
			pc += 1;
			break;
		case GVM_NODE_ASSIGN_OPERATOR:
			operand1 = &gvmp->vars[gvmp->nodes[pc].u.a.source_varno];
			operand2 = &gvmp->vars[gvmp->nodes[pc].u.a.source2_varno];
			switch (gvmp->nodes[pc].u.a.operator) {
			case '+':	mpz_add(result, *operand1, *operand2);
					break;
			case '-':	mpz_sub(result, *operand1, *operand2);
					break;
			case '*':	mpz_mul(result, *operand1, *operand2);
					break;
			case '/':	mpz_fdiv_q(result, *operand1, *operand2);
					break;
			case '%':	mpz_fdiv_r(result, *operand1, *operand2);
					break;
			}
			mpz_set(gvmp->vars[gvmp->nodes[pc].u.a.target_varno], result);
			if (gvm_trace) {
				printf("v%d = v%d %c v%d --> ",
					gvmp->nodes[pc].u.a.target_varno,
					gvmp->nodes[pc].u.a.source_varno,
					gvmp->nodes[pc].u.a.operator,
					gvmp->nodes[pc].u.a.source2_varno);
				gmp_printf("%Zd\n",
					gvmp->vars[gvmp->nodes[pc].u.a.target_varno]);
			}
			pc += 1;
			break;
		case GVM_NODE_GOTO:
			pc = gvmp->nodes[pc].u.g.target;
			if (gvm_trace) {
				printf("GOTO %d\n", pc + 1);
			}
			break;
		case GVM_NODE_CONDITIONAL_GOTO:
			if (0 == mpz_cmp_ui(
				gvmp->vars[gvmp->nodes[pc].u.g.condition_varno],
				gvmp->nodes[pc].u.g.condition_constant)) {
				pc = gvmp->nodes[pc].u.g.target;
				if (gvm_trace) {
					printf("GOTO %d\n", pc + 1);
				}
			} else {
				if (gvm_trace) {
					printf("NEXT\n");
				}
				pc += 1;
			}
			break;
		case GVM_NODE_HALT:
			if (gvm_trace) {
				printf("HALT\n");
			}
			pc = gvmp->nnodes;
			break;
		case GVM_NODE_PRINTSTRING:
			if (gvm_trace) {
				printf("PRINTSTRING \"%s\"\n",
					gvmp->nodes[pc].u.p.string);
			}
			printf("%s\n", gvmp->nodes[pc].u.p.string);
			pc += 1;
			break;
		case GVM_NODE_PRINTVAR:
			if (gvm_trace) {
				printf("PRINTVAR v%d\n", gvmp->nodes[pc].u.p.varno);
			}
			gmp_printf("%Zd\n", gvmp->vars[gvmp->nodes[pc].u.p.varno]);
			pc += 1;
			break;
		case GVM_NODE_PRINTTM:
			if (gvm_trace) {
				printf("PRINTTM\n");
			}
			gvm_printtmstate(gvmp, 70);
			pc += 1;
			break;
		case GVM_NODE_PRINTSTEPS:
			if (gvm_trace) {
				printf("PRINTSTEPS\n");
			}
			printf("%d\n", gvmp->steps);
			pc += 1;
			break;
		}
		/* sleep if sleep was required */
		if (gvmp->sleep > 0) {
			musleep(gvmp->sleep);
		}
	}
}

/* auxiliary function to initialize variable 0 */
void	gvm_initvar(gvm_t *gvmp, char *v) {
	if (1 > gvm.nvars) {
		printf("initializing v0\n");
		gvm.vars = (mpz_t *)realloc(gvm.vars, sizeof(mpz_t));
		gvm.nvars = 1;
		mpz_init(gvm.vars[0]);
	}
	char	*p = v;
	while (*p) {
		switch (*p) {
		case ' ':
			*p = '0';
			break;
		case '0':
			*p = '1';
			break;
		case '1':
			*p = '2';
			break;
		}
		p++;
	}
	mpz_get_str(v, 4, gvm.vars[0]);
}
