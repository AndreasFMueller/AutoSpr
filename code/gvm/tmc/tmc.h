/*
 * tmc.h -- global declarations for the turing machine compiler
 *
 * (c) 2012 Prof Dr Andraes Mueller, Hochschule Rapperswil
 */
#ifndef _tmc_h
#define _tmc_h

#define	MOVEMENT_LEFT 	1
#define MOVEMENT_RIGHT	2
#define MOVEMENT_HALT	0

extern int	tmc_read(char *buf, int ms);

typedef struct tm_node_s {
	int	from_state;
	int	from_tapechar;
	int	to_state;
	int	to_tapechar;
	int	movement;
} tm_node_t;

typedef struct tm_s {
	int	nnodes;
	tm_node_t	*nodes;
	int	initialstate;
	int	initialposition;
	char	*initialtape;
} tm_t;

extern tm_t	tm;

extern int	tmc_read(char *buffer, int ms);

extern void	tmc_display(tm_t *tm);

#endif /* _tmc_h */
