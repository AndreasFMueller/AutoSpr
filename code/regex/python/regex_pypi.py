#! /usr/bin/python
import regex
import time
r1 = ""
r2 = ""
i = 0
maxi = 26
while i < maxi:
	i += 1
	r1 += "a?"
	r2 += "a"
	r = r1 + r2
	start = time.time()
	if regex.match(r, r2):
		end = time.time()
		print("%*s matches %*s %*.3f s" % (maxi, r2, -3*maxi, r, 10, end-start))
	else:
		print("matching failure\n")

