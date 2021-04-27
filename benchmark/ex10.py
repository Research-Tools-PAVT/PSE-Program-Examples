import random
import numpy as np
from scipy.stats import bernoulli


def ex10(inpt):
    x = 0
    n = 30  # N
    y = 0
    prob = inpt[0]
    while(n > 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x + 1
        else:
            y = y + 1
        n = n - 1
    return x*y


'''
Simulation of fair coin
Prinsys Paper
Lst 7
I = [x = 0 ∧ y − 1 = 0] − [x − 1 = 0 ∧ y = 0]  #as per prinsys template
'''
'''
x -> [0,1],    y -> [0,1]

Guess: True
'''
