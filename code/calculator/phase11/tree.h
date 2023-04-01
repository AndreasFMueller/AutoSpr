/*
 * tree.h -- parse tree structure
 *
 * (c) 2023 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#ifndef _tree_h
#define _tree_h

#include <stdio.h>
#include <wchar.h>

#define TERMINAL	400
#define EXPR		401
#define	TERM		402
#define FACTOR		403

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
void	treenode_free(treenode_p treenode);
void	treenode_add(treenode_p treenode, treenode_p child);
extern int	treewide;
extern int	tree_precision;
extern int	tree_format;
#define TREE_FORMAT_FIXED	0
#define TREE_FORMAT_FLOAT	1
#define TREE_FORMAT_DEFAULT	2

void	treenode_format_number(FILE *out, double value);
int	treenode_children(treenode_p treenode);
treenode_p	treenode_child(treenode_p treenode, int i);

double	tree_value(treenode_p treenode);
void	tree_show(FILE *out, char *prefix, treenode_p treenode);
void	tree_print(FILE *out, treenode_p treenode);
treenode_p	tree_copy(treenode_p treenode);

#endif /* _tree_h */

