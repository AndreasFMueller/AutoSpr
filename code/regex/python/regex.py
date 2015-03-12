#! /usr/bin/python
import re
r1 = ""
r2 = ""
i = 0
while i < 30:
	i += 1
	r1 += "a?"
	r2 += "a"
	r = r1 + r2
	if re.match(r, r2):
		print r2 + " matches " + r
	else:
		print "matching failure\n"

