import random
import numpy as np
from scipy.stats import bernoulli


def ex8(inpt):
    x = 0
    n = 10  # N
    y = 10  # N
    prob = inpt[0]
    while(n > 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x + n
        else:
            x = x + y
        n = n - 1
    return x


'''
Lagrange Interpolation paper
Sum of Random Series
I= [n − 1 >= 0] * (x + (1/4) * n * n + (1/4) * n)
'''
'''
x -> [0,+inf],    n -> [0,10],  [n - x <= 10]
'''
