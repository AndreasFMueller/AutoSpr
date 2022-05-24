/*
 * utils.h -- the goto virtual machine
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#ifndef _utils_h
#define _utils_h

#include <gvm.h> 

extern int	gvm_file;
extern int	gvm_trace;

extern int	gvm_read(char *buf, int ms);
extern void	gvm_display(gvm_t *gvmp);
extern void	gvm_run(gvm_t *gvmp);
extern void	gvm_initvar(gvm_t *gvmp, char *v);

#endif /* _utils_h */
