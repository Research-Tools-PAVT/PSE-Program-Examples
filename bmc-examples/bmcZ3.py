import sys
import json
import os
from z3 import *

if __name__ == '__main__':
    set_option(max_args=10000000, max_lines=1000000,
               max_depth=10000000, max_visited=1000000)
    f = z3.parse_smt2_file("example.smt2")
    ctx = z3.Context()
    s = z3.Optimize(ctx=ctx)

    if s.check() == sat:
        m = s.model()
        print(sorted([(d, m[d]) for d in m], key=lambda x: str(x[0])))
