# Import dependencies.
import itertools
import random

# Specify model primitives.
numConstantChars = 4
exteriorBranches = 0.25
var('t1', 't2')

# Define a matrix of non-constant characters.
charOne = [1,1,1,0,0]
charTwo = [0,0,1,1,1]
charThree = [1,0,1,0,1]

charSet = matrix([charOne,charTwo,charThree])
numSites = charSet.dimensions()[1]

# Add constant characters.
constantChar = [0] * numSites

for i in range(numConstantChars):
    charSet = charSet.insert_row(0,constantChar)

# Find the analytic maximum of a two-variable differentiable function in variables t1 and t2.
def checkMax(function):
    # Set up primitive objects.
    d1 = diff(function(t1, t2), t1)
    d2 = diff(function(t1, t2), t2)
    d11 = diff(d1(t1, t2), t1)
    d22 = diff(d2(t1, t2), t2)
    d12 = diff(d1(t1, t2), t2)

    # Define the Hessian.
    def Hessian(x,y):
        return d11(x,y)*d22(x,y) - d12(x,y)^2

    # Get critical points
    points = solve([d1 == 0, d2 == 0], t1, t2, solution_dict = True)

    # Check for maxima by iterating over points. Return true if one is found.
    # FINISH THIS.

# Define a function which searches for a maximum inside a given orthant.
def searchInOrthant(charMatrix, orthant):

    # Define the primitive evaluation functions.
    def P00(t,alpha = 1): return 0.5 + 0.5*e**(-2*alpha*t)
    def P01(t,alpha = 1): return 0.5 - 0.5*e**(-2*alpha*t)
    def P11(t,alpha = 1): return P00(t,alpha)
    def P10(t,alpha = 1): return P01(t,alpha)

    # Wrap these together inside a switch.
    def evaluatePair(node1,node2,t):
        if node1 == node2:
            return P11(t)
        elif node1 != node2:
            return P01(t)

    # Compute the likelihood for any given character row.
    def calculateLikelihood(orthant,chars,t1,t2,leftNode,middleNode,rightNode):
        # Extract orthant information
        posA = orthant.index("A")
        valA = chars[0]
        posB = orthant.index("B")
        valB = chars[1]
        posC = orthant.index("C")
        valC = chars[2]
        posD = orthant.index("D")
        valD = chars[3]
        posE = orthant.index("E")
        valE = chars[4]

        # Construct the right topology.
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

    # Generate all the internal node characters.
    set = [0, 1]
    interior = []
    collection = [set]*3
    for i in itertools.product(*collection):
        interior.append(i)

    # Sum the likelihoods over all internal node realizations.
    def intermediateLikelihood(orthant, chars, t1,t2):
        sum = 0
        for i in range(len(interior)):
            sum += calculateLikelihood(orthant, chars, t1, t2, *interior[i])
        return sum

    # Return the likelihood for a given tree set of base tree parameters, over all character sets.
    def Likelihood(t1, t2):
        likelihood = 1
        for row in charMatrix:
            likelihood *= intermediateLikelihood(orthant,row,t1,t2)
        return likelihood

    # Calculate and return the maximum.
    # FINISH THIS.

# Then, define a function which iterates and searches over all orthants for a good example. 
