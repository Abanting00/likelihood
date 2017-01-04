# Import Dependencies.
using StatsBase

# Third experiment.
a = "1011100100011000111100000000011001000110001010100100011100101110100011111100100011010110011000111000"
b = "1010101010010100110010100000101100000110010010010001101010000001100001111100010001100001100100110101"
c = "1001101110001000011011101000111000101101101010100101110010000010000111110100000101100010010110011001"
d = "0000101100011111011001111011101011000111000000011101110101011101000000100100110110011011010011001011"
e = "0010111111111101110000001111100010010111101100011000110111011011001010101101010011000101100000000010"
numChars = length(a)

# First, grab the matrices for each.
charArray = Array{Array}(100)

for i in 1:numChars
  charArray[i] = [parse(Int,a[i]), parse(Int, b[i]), parse(Int, c[i]), parse(Int, d[i]), parse(Int, e[i])]
end

# Puts a 1 in the leading position of each, just to reduce number of distinct characters. 
function makeStandard!(v::Vector)
  if v[1] == 1
    return true
  else
    for i in 1:length(v)
      if v[i] == 1
        v[i] = 0
      else
        v[i] = 1
      end
    end
  end
end

for array in charArray
  makeStandard!(array)
end

countmap(charArray)
