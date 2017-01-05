import os
import collections
import sys

DATASET_LINES = {"1": 1, "2": 7, "3": 13, "4": 19, "5": 25,}

def character_counter(dataset): 

	#dataset = int(sys.argv[1])

	if dataset not in range(1,6):
		print "There are only 5 datasets"
		return

	a = b = c = d = e = ""

	start_line = DATASET_LINES[str(dataset)]

	with open("sequences01.txt", "r") as f:
		lines = f.readlines()
		a = lines[start_line]
		b = lines[start_line+1]
		c = lines[start_line+2]
		d = lines[start_line+3]
		e = lines[start_line+4]

	characters = []

	for i in range(2,102):
		s = a[i] + b[i] + c[i] + d[i] + e[i]
		characters.append(s)

	counter = collections.Counter(characters)
	print counter

#if __name__ == '__main__':
#    main()