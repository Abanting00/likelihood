# Import dependencies.
import itertools
import random



# Copy the individual node-node evaluation functions.
def P00(t,alpha = .3): return 0.5 + 0.5*e**(-2*alpha*t)
def P01(t,alpha = .3): return 0.5 - 0.5*e**(-2*alpha*t)
def P11(t,alpha = .3): return P00(t,alpha)
def P10(t,alpha = .3): return P01(t,alpha)

# Create a general function which selects the appropriate case.
def evaluateNode(node1,node2,t):
    if node1 == node2:
        return P11(t)
    elif node1 != node2:
        return P01(t)

# Define the columns for the 5-cycle.
LargePentagon = ["ABCED", "DEACB", "CBDAE", "AEBDC", "DCEAB"]

# Apply that function to a whole tree, given parameters.
def evaluateTree(treeParams,t1,t2,leftNode,middleNode,rightNode):
    # Initialize primitives.
    string = treeParams[0]
    posA = string.index("A")
    valA = treeParams[1]
    posB = string.index("B")
    valB = treeParams[2]
    posC = string.index("C")
    valC = treeParams[3]
    posD = string.index("D")
    valD = treeParams[4]
    posE = string.index("E")
    valE = treeParams[5]
    # Combine them.
    treeVals = [(posA, valA), (posB, valB), (posC, valC), (posD, valD), (posE, valE)]
    treeVals = sorted(treeVals)

    # Evaluate likelihood.
    product = 1
    for i in range(0,5):
        if i == 0 or i == 1:
            product *= evaluateNode(treeVals[i][1],leftNode,1/4)
        elif i == 2:
            product *= evaluateNode(treeVals[i][1],middleNode,1/4)
        else:
            product *= evaluateNode(treeVals[i][1],rightNode,1/4)
    product *= evaluateNode(leftNode,middleNode,t1)
    product *= evaluateNode(middleNode,rightNode,t2)
    return product

# Generate all the characters.
set = [0, 1]
interior = []
collection = [set]*3
for i in itertools.product(*collection):
    interior.append(i)

# Compute the likelihood for all trees on the given internal nodes.
def Likelihood(treeParams,t1,t2):
    sum = 0
    for i in range(len(interior)):
        sum += evaluateTree(treeParams,t1,t2,*interior[i])
    return sum

# Initialize for plotting.
v1 = var('t1')
v2 = var('t2')


topology = "ABCDE"

#treeParams1 = [0,0,0,0,0]
#treeParams2 = [0,1,0,0,1]
#treeParams3 = [0,1,0,1,1]
#treeParams4 = [0,0,1,1,1]

#treeParams1.insert(0, topology)
#treeParams2.insert(0, topology)
#treeParams3.insert(0, topology)
#treeParams4.insert(0, topology)

#print treeParams1

character_count = {'10011': 7, '11000': 7, '11100': 6, '00000': 6, '11010': 5, '00011': 5, '00101': 5, '11110': 4, '11011': 4, '00110': 4, '00010': 4, '10010': 4, '10111': 4, '00001': 4, '01100': 3, '11111': 3, '00111': 3, '00100': 3, '10101': 2, '01101': 2, '01000': 2, '01110': 2, '01111': 2, '01011': 2, '01010': 2, '10000': 1, '10001': 1, '01001': 1, '11001': 1, '11101': 1}

characters = list(character_count.keys())

print character_count

print characters

for i in range(len(characters)):
    characters[i] = list(characters[i])
    characters[i].insert(0, topology)

print characters


key = "".join(characters[2][1:])
exponent = character_count[key]
print key
print exponent

def OverallLikelihood(t1,t2):
    product = 1
    for c in characters:
        key = "".join(c[1:])
        exponent = character_count[key]
        product *= (Likelihood(c,t1,t2)^exponent)
    return product


plot3d(OverallLikelihood,(t1,0,1),(t2,0,1))