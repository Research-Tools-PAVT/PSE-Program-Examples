#!/usr/bin/env sage

import sys
from sage.all import *

def iverson(x):
    if x > 0:
        return 1
    else:
        return 0

x = var('x')
print([ i for i in [0..x]])

