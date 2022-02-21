#! /usr/bin/python
import time
import re
r1 = ""
r2 = ""
i = 0
while i < 29:
	i += 1
	r1 += "a?"
	r2 += "a"
	r = r1 + r2
	before = time.time()
	if re.match(r, r2):
		runtime = time.time() - before
		print(r2 + " matches " + r + " " + str(runtime))
	else:
		print("matching failure")

