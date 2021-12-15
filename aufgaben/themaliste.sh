#
# themaliste.sh -- list all topics
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
egrep -h -e '\\themaL?{' ?/*.tex | awk 'BEGIN {
	counter = 0;
}
/thema{/ {
	printf("%s\n", substr($0, 7));
}
/themaL{/ {
	printf("%s\n", substr($0, 8));
}
' | sort | uniq -c
