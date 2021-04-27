import random
import numpy as np
from scipy.stats import bernoulli

'''
Lagrange Interpolation paper
Binomial Distribution
I=[y >= 0 and n − 1 >= 0] * (x + p * n * y)
'''
'''
x -> [0,+inf],    n -> [0,10]
'''


def ex7(inpt):
    x = 0
    n = 10  # N
    y = 10  # N
    prob = inpt[0]
    while(n > 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x + y
        n = n-1
    return x


'''
Lagrange Interpolation paper
Binomial Distribution 2 (bin2)
I = [y >= 0 and n − 1 >= 0] * (x + (0.125)* n * n + 0.125 * n − 0.75 * n * y)

p=0.25
'''
'''
x -> [0,+inf],    n -> [0,10],   [n-x <= 10]
'''
