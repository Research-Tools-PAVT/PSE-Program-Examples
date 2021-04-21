import random
import numpy as np
from scipy.stats import bernoulli

'''
ex0c


Prinsys paper
Lst 1
I = [z >= 0] * z + [z >= 0 and flip == 0] * (1 - prob)/prob
'''
'''
z -> [0,+inf], flip -> [0,1]
I' = z + [flip == 0] * (1 - prob)/prob

I' [flip == 0] = [flip == 0] (z + (1 - prob)/prob)

wp(body, I') = prob * wp(flip = 1, I') + (1-prob) * wp(z = z+1, I')
= prob * (z + 0) + (1-prob) * (z + 1 + [flip == 0] * (1 - prob)/prob)) 
= z + (1-prob) + [flip == 0] * (1-prob) * (1 - prob)/prob
= [flip != 0] (z + 1-prob) + [flip == 0] * (z + 1-prob + (1-prob) * (1 - prob)/prob)
= [flip != 0] (z + 1-prob) + [flip == 0] * (z + (1-prob)/prob)
[flip == 0] *wp(body, I') + [flip != 0] z
= [flip == 0] * (z + (1-prob)/prob) + [flip != 0] z 
= I' 
'''


def ex0(inpt):
    prob, _ = inpt
    z = 0
    flip = 0
    while (flip == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            flip = 1
        else:
            z = z + 1
    return z
# I -> post cond.
# Post == Pre
# (z > (1-prob)/prob)


'''
I = [z >= 0] * z + [z >= 0 and flip == 0] * (1 - prob)/prob 
Assertion Invariant: TODO
'''


def ex0a(inpt):
    prob, _ = inpt
    z = 0
    x = 0
    flip = 0
    while (flip == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            flip = 1
        else:
            x = x * 2
            z = z + 1
    return z


'''
I = [z >= 0] * z + [z >= 0 and flip == 0] * 2 * (1 - prob)/prob 
Assertion Invariant: TODO
'''


def ex0b(inpt):
    prob, _ = inpt
    z = 0
    i = 0
    flip = 0
    while (flip == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        i += 1
        if (i % 2) == 0:
            if d:
                flip = 1
            else:
                z = z + 2
    return z


'''
I = unclear
Assertion Invariant: TODO
'''


def ex0c(inpt):
    prob, _ = inpt
    z = 0
    i = 0
    flip = 0
    while (flip == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        i += 1
        if d:
            flip = 1
        else:
            if (i % 2) == 0:
                z = z + 2
    return z


'''
I = count + [not (c1 or c2)] * (p_1 + p_2) / (p_1 + p_2 - p_1 * p_2)
Assertion Invariant: TODO
I [not (c1 or c2)] = [not (c1 or c2)] * (count + (p_1 + p_2) / (p_1 + p_2 - p_1 * p_2))
wp(body, I) = wp({count = count + 1}[prob1]{skip}, wp({count = count + 1}[prob2]{skip}, I))
= wp({count = count + 1}[prob1]{skip}, prob2 * (I + 1) + (1-prob2) * I) 
= prob1 * (prob2 * (I + 1) + (1-prob2) * I + 1) + (1-prob1) * (prob2 * (I + 1) + (1-prob2) * I) 
= prob2 * (I + 1) + (1-prob2) * I + prob1 * 1 
= I + prob2 + prob1
Thus, I [not (c1 or c2)] <= I <= wp(body, I)
'''


def ex1(inpt):
    prob1, prob2 = inpt
    c1 = bernoulli.rvs(size=1, p=prob1)[0]
    if c1:
        count = count + 1
    c2 = bernoulli.rvs(size=1, p=prob2)[0]
    if c2:
        count = count + 1
    while not (c1 or c2):
        c1 = bernoulli.rvs(size=1, p=prob1)[0]
        if c1:
            count = count + 1
        c2 = bernoulli.rvs(size=1, p=prob2)[0]
        if c2:
            count = count + 1
    return count


''' 
Prinsys paper
Lst 4
I = rounds + [b > 0] * ((1 - p)/ p)
'''
'''
b -> [ 0,inf ], rounds -> [0,inf] 
I [b>0] = [b > 0] * (rounds + (1 - p)/ p)
wp(body,I) = wp({...}[p]{...}, rounds + 1 + [b > 0] * ((1 - p)/ p))
 = p * (rounds + 1) + (1-p) * (rounds + 1 + [b > 0] * ((1 - p)/ p))
 = rounds + 1 + [b > 0] * ((1 - p) * (1-p)/ p)
 = rounds + 1 + [b > 0] * ((1 - p)/ p + (p - 1))
 > rounds + [b > 0] * ((1 - p)/ p) 
'''


def ex2(inpt):
    prob, _ = inpt
    c = 0
    b = 1
    rounds = 0
    while b > 0:
        d = bernoulli.rvs(size=1, p=prob)
        if d:
            c = c + b
            b = 0
        else:
            c = c - b
            b = 2 * b
        rounds += 1
    return rounds


'''
Prinsys Paper 
Lst 5
I1 = x + [flip==0] * (p/(1-p)) ##for first while loop##
I2= x + [flip==0] * (-q/(1-q)) ##for second while loop##
'''
'''
flip -> [0,1], x -> [0,+inf]
guess: True
'''


def ex3a(inpt):
    prob1, prob2 = inpt
    x = 0
    flip = 0
    while (flip == 0):
        d1 = bernoulli.rvs(size=1, p=prob1)
        if d1:
            x = x + 1
        else:
            flip = 1
    flip = 0
    while (flip == 0):
        d2 = bernoulli.rvs(size=1, p=prob2)
        if d2:
            x = x - 1
        else:
            flip = 1

    return x


'''
Prinsys paper
Lst 6
I1= x + [flip==0]*(p/(1-p))  ##for first loop
I2= x + [flip==0]*(-1/(1-q)) ##for second loop
'''
'''
Assertion invariant: TODO
wp(body2, I2) = wp(x=x-1, q * x + (1-q) * (x + [flip==0]*(-1/(1-q))) )
 = wp(x=x-1, x + [flip==0]* -1/(1-q) * (1-q))
 = x - 1 + [flip==0]* -1/(1-q) * (1-q) 
 = x - 1 + [flip==0]* (-1)
I2 [flip == 0] = [flip==0] (x -1/(1-q))
not True that I2 [G] <= wp(body2, I2)  
'''


def ex3b(inpt):
    prob1, prob2 = inpt
    x = 0
    d1 = bernoulli.rvs(size=1, p=prob1)
    if d1:
        flip = 0
    else:
        flip = 1
    if flip == 0:
        while(flip == 0):
            d2 = bernoulli.rvs(size=1, p=prob2)
            if d2:
                x = x + 1
            else:
                flip = 1
    else:
        flip = 0
        while(flip == 0):
            x = x - 1
            d3 = bernoulli.rvs(size=1, p=prob2)
            if(d3):
                flip = 1
    return x


'''
Gambler's ruin problem
I= z + [0 < x and x < y] * x * (y - x)
Non-linear
Lagrange Interpolation Paper
'''
'''
Assertion invariant: z->[0,inf], [x-z<=1]  
'''


def ex4(inpt):
    z = 0
    prob = inpt[0]
    x = 1  # initial amount gambler has
    y = 21  # N#amount required to win
    while (x - 1) >= 0 and (x - y + 1) <= 0:
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            x = x + 1
        else:
            x = x - 1
        z = z + 1
    return z


'''
Page 13 of Lagrange Interpolation paper:
A variant of Geometric Distribution(2): 
    the player wins k more dollars if the tail turns up at kth flip
Assertion Invaraint: z -> [0,1], x -> [0,+inf], y -> [0,+inf]
Post-expectation:	x
Preexp Inv: I= [z >= 0 and z − 1 <= 0 and x >= 0 and y >= 0] * \
10 * (5 * p * z − 2 * p * z * z + x + p * n * x)
TODO: what is n here? Why are there both z and z * z? (z is a boolean)
Program variables: z, x, y
Guard variable: z
'''


def ex5(inpt):
    prob, _ = inpt
    x = 0
    z = 1
    y = 0
    while not(z == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        y = y + 1
        if(d):
            z = 0
        else:
            x = x + y
    return x


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


def ex11(inpt):
    x = 0
    y = 0
    prob1, prob2 = inpt
    while(x-y == 0):
        d1 = bernoulli.rvs(size=1, p=prob1)[0]
        if(d1):
            x = 1
        else:
            x = 0
        d2 = bernoulli.rvs(size=1, p=prob2)[0]
        if(d2):
            y = 1
        else:
            y = 0
    return x


'''
Prinsys paper 
Lst. 2
I = [x = 0] * (1-prob2)  + [x = 1]
'''
'''
x ->[-1,1]
'''


def ex12(inpt):
    x = 0
    prob1, prob2 = inpt
    while(x == 0):
        d1 = bernoulli.rvs(size=1, p=prob1)[0]
        if(d1):
            x = 0
        else:
            d2 = bernoulli.rvs(size=1, p=prob2)[0]
            if(d2):
                x = -1
            else:
                x = 1
    return x


'''
Tortoise and Hare
(Kaminski paper):A Weakest Pre–Expectation Semantics for Mixed–Sign Expectations
I = [h >= 0 and t >= 0 and count >= 0] * (1)
'''
# takes too long to run for small probability(p<=0.31)
'''
t -> [30,+inf], h -> [0,+inf], n -> [0,+inf], [h - t <= 2], [t-n <= 30], [h - n <= 32]
'''


def ex13(inpt):
    t = 30
    h = 0
    prob = inpt[0]
    n = 0
    while((t-h) >= 0):
        t = t + 1
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            h = h + 3
        n = n + 1
    return n


'''
Kaminski paper
Kozen's example
I = [x >= 0] * (c + 2x)
'''
'''
x -> [-inf,20],  c->[0,+inf]
'''


def ex14(inpt):
    x = 20  # n
    c = 0
    prob = inpt[0]
    while not(x == 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            x = x - 1
        c = c + 1
    return c


'''
Src: https://www.cs.colorado.edu/~srirams/papers/sas14-expectations.pdf 
Pg-3 fig 1

I = y − x
'''
'''

'''


def ex15(inpt):
    x = random.uniform(-5, 3)
    y = random.uniform(-3, 5)
    count = 0
    prob = inpt[0]
    while((x + y) <= 10):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            x = x + random.uniform(0, 2)
            y = y + 2
        count = count + 1
    return count


'''
Coupon collector problem
Kaminski

#col= number of coupons collected till now

I= 1 + Sum_(l=0 to w)[x>l] * (3 + 2 * Sum_(k=0 to w) ((#col+l)/N)^k) - \
   (2 * [cp[i] == 0]*[x>0] * Sum_(k=0 to w) (#col/N)^k)
'''


def ex16(inpt):
    x = 10
    cp = np.zeros(20)
    i = 1
    z = 0
    prob1, prob2 = inpt
    while(x-1 >= 0):
        while not(cp[i] == 0):
            i = random.randint(1, 10)
        cp[i] = 1
        x = x - 1
        z = z + 1
    return z


'''
http://www-i2.informatik.rwth-aachen.de/pub/index.php?type=download&pub_id=1274
pg-120
Fig 5.8

I = [x >= 0 and x − 1 <= 0 and (b − 1 == 0 or x == 0 or x − 1 == 0)] * (x)
'''
'''
b -> [0,1], z -> [0,+inf]
'''


def ex17(inpt):
    x = 20  # n
    b = 1
    prob = inpt[0]
    z = 0
    while b-1 == 0:
        d = bernoulli.rvs(size=1, p=prob)[0]
        if d:
            b = 0
        else:
            b = 1
        if(b-1 == 0):
            x = 2 * x
            if(x - 1 >= 0):
                x = x - 1
        elif(x - 0.5 >= 0):
            x = 1
        else:
            x = 0
        z = z+1
    return z


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


def ex19(inpt):
    t = 'A'
    c = 1
    prob1, prob2 = inpt
    n = 0
    while(c == 1):
        n = n + 1
        if t == 'A':
            d1 = bernoulli.rvs(size=1, p=prob1)[0]
            if d1:
                c = 0
            else:
                t = 'B'
        else:
            d2 = bernoulli.rvs(size=1, p=prob2)[0]
            if d2:
                c = 0
            else:
                t = 'A'
    return n


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


def ex21(inpt):
    x = 20
    prob = inpt[0]
    z = 0
    while(x-1 >= 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x - 1
        else:
            x = x - 2
        z = z + 1
    return z


'''
Kaminski pg 125
I = [x-1 >= 0] * x + 1 
'''
'''
x -> [0,20],   z -> [0,+inf]
'''


def ex22(inpt):
    x = 20
    prob = inpt[0]
    z = 0
    while(x-1 >= 0):
        d = bernoulli.rvs(size=1, p=prob)[0]
        if(d):
            x = x - 1
        z = z + 1
    return z


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
