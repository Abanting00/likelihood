#!/usr/bin/env python

# Driver file for generating sequences

import os
import time
import sys
from character_count import character_counter

dataset = int(sys.argv[1])

num_characters =100
num_datasets = 5
os.system("./seq-gen_v1.3.3 -mGTR -l" + str(num_characters) + " -n" + str(num_datasets) + " -f0.25,0.25,0.25,0.25 -r0.35,0.15,0.15,0.15,0.15,0.35 -or < tree.txt > sequences.txt")

time.sleep(1)

infile = open("sequences.txt",'r')
outfile = open("sequences01.txt",'w')
for line in infile:
    line =line.replace("A","0")
    line =line.replace("C","0")
    line =line.replace("G","1")
    line =line.replace("T","1")
    outfile.write(line)
outfile.close()

character_counter(dataset)