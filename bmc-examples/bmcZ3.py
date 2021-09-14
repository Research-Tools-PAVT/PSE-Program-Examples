import sys
import json
import os
from z3 import *

if __name__ == '__main__':
    ctx = z3.Context()
    s = z3.Optimize(ctx=ctx)
    optim = z3.Int('optim', ctx=ctx)
    f = z3.parse_smt2_file("file.smt2")
    s.maximize(optim)

    print(s.model())
