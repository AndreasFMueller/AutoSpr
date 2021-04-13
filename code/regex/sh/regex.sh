#! /bin/sh
#
# The shell does not have a built in regex matcher, so the only hope is to
# use some command line tool The standard tool for this purpose would be
# expr(1), so how fast is regex matching in expr? Unfortunately, expr
# only understands a relatively old syntax of regex, in particular, it
# does not understand the ? character. Never mind, this script puts together
# an equivalent form.
#
# (c) 2010 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
string1='a'
string2='a\{0,1\}'
i=0
while [ $i -lt 29 ]
do
	if expr ${string1} : ${string2}${string1} >/dev/null
	then
		printf "%29s matches %s\n" ${string1} ${string2}${string1}
	else
		printf "%29s does not match %s\n" ${string1} ${string2}${string1}
	fi
	i=`expr $i + 1`
	string1="${string1}"a
	string2="${string2}"'a\{0,1\}'
done
