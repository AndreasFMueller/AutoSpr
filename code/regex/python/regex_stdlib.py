#! /usr/bin/python
import time
import re
r1 = ""
r2 = ""
i = 0
maxi = 26
while i < maxi:
	i += 1
	r1 += "a?"
	r2 += "a"
	r = r1 + r2
	before = time.time()
	if re.match(r, r2):
		runtime = time.time() - before
		print("%*s matches %*s %*.3f s" % (maxi, r2, -3*maxi, r, 10, runtime))
	else:
		print("matching failure")

