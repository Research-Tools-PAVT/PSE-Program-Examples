import random
import numpy as np
from scipy.stats import bernoulli

'''
src: http://www-i2.informatik.rwth-aachen.de/pub/index.php?type=download&pub_id=1274
pg-120
Fig 5.9

I = [x ≥ 0 and x − n ≤ 0 and n − M ≤ 0] * (x/M - p*n/M + p) 

'''
'''
x -> [0,0], n -> [0,0]               recheck
guess: [x ≥ 0 and x − n ≤ 0 and n − M ≤ 0]
x -> [0,4], n -> [0,4]
'''


def ex18(inpt):
    x = 0
    n = 0
    prob = inpt[0]
    M = 5
    while n - M + 1 <= 0:
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            x = x + 1
        n = n + 1
    return n


'''
src: https://moves.rwth-aachen.de/wp-content/uploads/WS1819/probprog/prob-prog-2018-lec89.pdf
Joost-Pieter Katoen
I = [t = A ∧ c = 0]+ [t = A ∧ c = 1] * (p1/(p1 + p2 - p1 * p2))+ \
 [t = B ∧ c = 1] * ((1 - p2)/(p1 + p2 - p1 * p2))
'''
'''
c -> [0,1],   t -> ['A','B'],  n -> [0,+inf]
'''
