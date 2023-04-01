/*
 * tree.h -- parse tree structure
 *
 * (c) 2023 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#ifndef _tree_h
#define _tree_h

#include <stdio.h>
#include <wchar.h>

#define TERMINAL	300
#define EXPR		301
#define	TERM		302
#define FACTOR		303

struct treenode_s;
typedef struct treenode_s {
	char	*nodename;
	int	nodetype;
	double	value;
	struct treenode_s	**children;
} treenode_t;
typedef treenode_t	*treenode_p;

treenode_p	treenode_new(char *name, int nodetype,
			treenode_p children, ...);
treenode_p	treenode_terminal(char *t);
treenode_p	treenode_copy(treenode_p treenode);
void	treenode_free(treenode_p treenode);
void	treenode_add(treenode_p treenode, treenode_p child);
extern int	treewide;
void	treenode_show(FILE *out, char *prefix, treenode_p treenode);
int	treenode_children(treenode_p treenode);
treenode_p	treenode_child(treenode_p treenode, int i);
treenode_p	treenode_copy(treenode_p treenode);
double	treenode_value(treenode_p treenode);
void	treenode_print(FILE *out, treenode_p treenode);

#endif /* _tree_h */

