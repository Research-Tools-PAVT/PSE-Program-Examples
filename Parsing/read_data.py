# -*- coding: utf-8 -*-
import os
import sys
from sexpdata import loads, dumps

data = """
(And (Eq false
     (Eq N0:(ReadLSB w32 0 a_pse_sym)
         (Mul w32 2 N0)))
(Slt (Add w32 4294967295
               N0:(ReadLSB w32 0 a_pse_sym))
      N0)
(And (Slt N0:(ReadLSB w32 0 a_pse_sym)
           (Add w32 1 N0))
      (Eq false (Eq 10 N0))))"""

sexpr_parse_result = loads(data)

for elems in sexpr_parse_result:
    if isinstance(elems, list):
        for objs in elems:
            print(objs)
    else:
        print(elems)

with open('../example4_klee_out/conds_dump.txt', "r") as fileptr:
    for lines in fileptr:
        stripped_line = lines.strip()
        if "File" in stripped_line:
            pass
        elif "Predicate" in stripped_line:
            pass
        elif "Current" in stripped_line:
            pass
        elif "True" in stripped_line:
            pass
        elif "False" in stripped_line:
            pass
        else:
            pass
