#! /bin/bash
#
# The bash supports regex matching without recourse to an external program.
# And it supports modern standard regex metacharacters. Here is how it
# performs.
#
# (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
# $Id$
#
string1='a'
string2='a?'
i=0
while [ $i -lt 29 ]
do
	if [[ ${string1} =~ ${string2}${string1} ]]
	then
		printf "%29s matches %s\n" ${string1} ${string2}${string1}
	else
		printf "%29s does not match %s\n" ${string1} ${string2}${string1}
	fi
	i=`expr $i + 1`
	string1="${string1}"a
	string2="${string2}"'a?'
done
