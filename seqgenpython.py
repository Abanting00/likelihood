#!/usr/bin/env python

# Driver file for generating sequences

import os
import time

num_characters = 300
num_datasets = 1
if not os.path.exists("sequences01.txt"):
    os.system("./seqgenv133 -mGTR -l" + str(num_characters) + " -n" + str(num_datasets) + " -f0.25,0.25,0.25,0.25 -r0.35,0.15,0.15,0.15,0.15,0.35 -or < tree.txt > sequences.txt")

    time.sleep(3)

    infile = open("sequences.txt",'r')
    outfile = open("sequences01.txt",'w')
    for line in infile:
        line =line.replace("A","0")
        line =line.replace("C","0")
        line =line.replace("G","1")
        line =line.replace("T","1")
        outfile.write(line)    
    outfile.close()

else:
    print("Not generated")

    
infile01 = open("sequences01.txt",'r')

count = {}

lines = infile01.readlines()

a = lines[1] [2:]
b = lines[2] [2:]
c = lines[3] [2:]
d = lines[4] [2:]
e = lines[5] [2:]

##print(a)
##print(b)
##print(c)
##print(d)
##print(e)

for i in range(len(a)):
    s = a[i] + b[i] + c[i] + d[i] + e[i]
    count[s] = count.get(s, 0) + 1 
print(count) 


    
    
    
