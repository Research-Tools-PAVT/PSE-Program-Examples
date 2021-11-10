#!/usr/bin/env sage

from sage.all import *

def iverson(x) :
    if x:
        return 1
    else:
        return 0

retval, n = var('retval, n_sym')
eq = lambda rand_sym : ((((5 < rand_sym) and (retval == 1)) + (not(5 < rand_sym) and retval == 0))  / n)
print(eq)
x = var('x')
sumFun = sum(eq(x), x, 0, n)
print(sumFun)
assume(retval == 1)
assume(n >= 5)
S = solve(sumFun > 0, n)
#S = solve(sum(i,i,0,n) > 5, n)
print(S)
