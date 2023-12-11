import sys

seqmat = [[int(n) for n in line.rstrip().split(" ")] for line in sys.stdin]

result = 0

for seq in seqmat:
  n = range(len(seq))
  order = 0
  xs = seq
  
  while len(set(xs)) > 1:
    xs = [xs[1+i] - xs[i] for i in range(len(xs)-1)]
    order += 1
  
  A = matrix([[x**o for o in range(order+1)] for x in range(len(seq))])
  
  Y = A.solve_right(vector(seq))
  
  R = sum([Y[o]*(-1)**o for o in range(order+1)])
  
  result += R

print(result)
