import random
import numpy as np
from scipy.stats import bernoulli

'''
product.v2

Pre-expectation:	n*n
Post-expectation:	4*x*y

Lagrange Interpolation output:

Invariant:		n^2 + 2*n*y + 2*n*x + 4*x*y 

'''
'''
x -> [1,+inf], n->[0,N],  y->[1,1]
'''


def ex25(inpt):
    n = N
    x = 1  # random
    y = 1  # random
    prob1, prob2 = inpt
    while(n > 0):
        d1 = bernoulli.rvs(size=1, p=prob1)[0]
        if(d1):
            x = x + 1
        d2 = bernoulli.rvs(size=1, p=prob2)[0]
        if(d2):
            y = y + 1
        n = n - 1
    return (4 * x * y)
