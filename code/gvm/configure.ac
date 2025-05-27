#
# configure.ac -- create the configure script for the gvm project
#
# (c) 2012-2024 Prof Dr Andreas Mueller
#
AC_PREREQ([2.72])
AC_REVISION([1.0])dnl
AC_INIT([gvm],[1.1],[andreas.mueller@othello.ch])
AC_CONFIG_SRCDIR([vm/gvm.c])
AC_CANONICAL_TARGET([])
AM_INIT_AUTOMAKE
AC_CONFIG_HEADERS(common/config.h)

# Programs
AC_PROG_CC
AC_PROG_LEX(noyywrap)
AC_PROG_YACC

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
