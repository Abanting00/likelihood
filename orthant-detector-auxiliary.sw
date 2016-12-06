# Initialize primitives.
import itertools
var('t1', 't2')
exteriorBranches = 0.25

# Define the primitive evaluation functions.
def P00(t,alpha = 1): return 0.5 + 0.5*e**(-2*alpha*t)
def P01(t,alpha = 1): return 0.5 - 0.5*e**(-2*alpha*t)
def P11(t,alpha = 1): return P00(t,alpha)
def P10(t,alpha = 1): return P01(t,alpha)

# Place these inside a switch.
def evaluatePair(node1,node2,t):
    if node1 == node2:
        return P11(t)
    elif node1 != node2:
        return P01(t)

# Compute the likelihood for any single character, inside a particular orthant.
def calculateSingleLikelihood(orthant, char, t1, t2, leftNode, MiddleNode, rightNode):
    # Extract orthant information
    posA = orthant.index("A")
    valA = char[0]
    posB = orthant.index("B")
    valB = char[1]
    posC = orthant.index("C")
    valC = char[2]
    posD = orthant.index("D")
    valD = char[3]
    posE = orthant.index("E")
    valE = char[4]
    treeVals = [(posA, valA), (posB, valB), (posC, valC), (posD, valD), (posE, valE)]
    treeVals = sorted(treeVals)
    # Compute the likelihood.
    product = 1
    for i in range(0,5):
        if i == 0 or i == 1:
            product *= evaluatePair(treeVals[i][1],leftNode,exteriorBranches)
        elif i == 2:
            product *= evaluatePair(treevals[i][1],middleNode,exteriorBranches)
        else:
            product *= evaluatePair(treeVals[i][1],rightNode,exteriorBranches)
        product *= evaluatePair(leftNode,middleNode,t1)
        product *= evaluatePair(middleNode,rightNode,t2)
    return product

# Generate all internal node characters.
set = [0, 1]
interior = []
collection = [set]*3
for i in itertools.product(*collection):
    interior.append(i)

# Sum a given character over all interior node realizations, inside a particular orthant.
def summedLikelihood(orthant, char, t1,t2):
    sum = 0
    for i in range(len(interior)):
        sum += calculateSingleLikelihood(orthant, char, t1, t2, *interior[i])
    return sum

# Return the likelihood for a given tree set of base tree parameters, over all character sets, inside a particular orthant.
def Likelihood(orthant, t1, t2):
    likelihood = 1
    for row in charMatrix:
        likelihood *= summedLikelihood(orthant,row,t1,t2)
    return likelihood

# Find the analytic maximum of a two-variable function.
def findMax(function):
    # Take derivatives.
    d1 = diff(function(t1, t2), t1)
    d2 = diff(function(t1, t2), t2)
    d11 = diff(d1(t1, t2), t1)
    d22 = diff(d2(t1, t2), t2)
    d12 = diff(d1(t1, t2), t2)

    # Define the Hessian.
    def Hessian(x,y):
        return d11(x,y)*d22(x,y) - d12(x,y)^2

    # Get critical points.
    points = solve([d1 == 0, d2 == 0], t1, t2, solution_dict = True)

    # Check for maxima by iterating over points. Return true if one is found.


# Search over all orthants.
def orthantSearch(charMatrix):
    for topology in itertools.permutations(["A", "B", "C", "D", "E"]):
        topString = topology[0] + topology[1] + topology[2] + topology[3] + topology[4]
        print(topString)
    return topString
