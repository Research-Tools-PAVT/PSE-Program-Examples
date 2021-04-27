import random
import numpy as np
from scipy.stats import bernoulli

'''
Max 3SAT problem
Theorem 2.1 in http://timroughgarden.org/w16/l/l18.pdf

I= [n<=10] + [n>10] * (n*(7/8)*m)

Post=n*(7/8)*m
'''


def ex20(inpt):
    prob1, prob2 = inpt
    n = 0
    x1, x2, x3 = 0, 0, 0
    z = 0
    while(n <= 10):
        d1 = bernoulli.rvs(size=1, p=prob1)[0]
        if(d1):
            x1 = 1
        else:
            x1 = 0
        d2 = bernoulli.rvs(size=1, p=prob2)[0]
        if(d2):
            x2 = 1
        else:
            x2 = 0
        d3 = bernoulli.rvs(size=1, p=prob2)[0]
        if(d3):
            x3 = 1
        else:
            x3 = 0

        c1 = x1 + x2 + x3  # c1 = "x1 or x2 or x3"
        if c1 >= 1:
            c1 = 1
        c2 = x1 + (1-x2) + x3  # c2 = "not x1 or x2 or x3"
        if c2 >= 1:
            c2 = 1
        c3 = (1-x1) + x2 + x3  # c3 = "not x2 or x1 or x3"
        if c3 >= 1:
            c3 = 1
        n = n + 1
        z = c1 + c2 + c3
    return z


'''
Kaminski pg 125
I = [x-1 >= 0] + [x-1 < 0] * z
'''
'''
x -> [-1,20],  z -> [0,+inf]
'''
