#
# configure.ac -- create the configure script for the gvm project
#
# (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
# $Id$
#
AC_PREREQ([2.57])
AC_REVISION([1.0])dnl
AC_INIT
AC_CONFIG_SRCDIR([vm/gvm.c])
AC_CANONICAL_TARGET([])
AM_INIT_AUTOMAKE(gvm, 1.0)
AM_CONFIG_HEADER(common/config.h)

# Programs
AC_PROG_CC
AC_PROG_LEX
AC_PROG_YACC

AC_HEADER_STDC
AC_CHECK_HEADERS(errno.h stdio.h getopt.h fcntl.h time.h sys/time.h sys/types.h sys/select.h getopt.h)
AC_CHECK_FUNC(nanosleep, AC_DEFINE(HAVE_NANOSLEEP, [], [Define if nanosleep(2) function is present]), )

AC_CHECK_HEADERS([gmp.h])
AC_CHECK_LIB(gmp, __gmpz_init)

AC_C_CONST

case `uname` in
	Linux)	CFLAGS="-D_DEFAULT_SOURCE ${CFLAGS}"
		;;
	*)
		;;
esac

# substitutions
AC_CONFIG_FILES([Makefile
		common/Makefile
		vm/Makefile
		tmc/Makefile tmc/pgm/Makefile tmc/data/Makefile
		doc/Makefile])
AC_OUTPUT
