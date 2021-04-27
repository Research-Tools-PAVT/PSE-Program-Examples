import random
import numpy as np
from scipy.stats import bernoulli


def ex9(inpt):
    x = 0
    n = 10  # N
    prob = inpt[0]
    while(n > 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x + n
        n = n - 1
    return x


'''
Lagrange Interpolation paper
Product of dependent random variables
I = -(1/4) * n + x * y + (1/2) * x * n + (1/2) * y * n + \
(1/4) * n^2 

Lagrange output:

pre=n(n-1) 
post=xy 
invariant = n^2 + 2nx + 2ny + 4xy - n
'''
'''
x -> [0,+inf],    n -> [0,30],    y -> [0,+inf]
'''
