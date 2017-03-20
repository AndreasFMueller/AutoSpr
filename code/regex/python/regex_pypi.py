#! /usr/bin/python
import regex
r1 = ""
r2 = ""
i = 0
while i < 29:
	i += 1
	r1 += "a?"
	r2 += "a"
	r = r1 + r2
	if regex.match(r, r2):
		print(r2 + " matches " + r)
	else:
		print("matching failure\n")

