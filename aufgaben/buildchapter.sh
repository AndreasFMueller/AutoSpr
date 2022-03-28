#! /bin/sh
#
# build a chapter include file
#
# (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
if [ ! -d "${1}" ]
then
	echo "must specify directory"
	exit 1
fi
dir="${1}"
cd ${dir}
ls *.tex | awk '{
	file = substr($1, 1, length($1) - 4)
	printf("\\aufgabe{%s}\n", file)
}'
