# -*- coding: utf-8 -*-
import json
import re
from sexpdata import loads, dumps

arithmetic_expr_kind = ["Add", "Sub", "Mul", "UDiv", "URem", "SDiv", "SRem"]
bitwise_expr_kind = ["And", "Or", "Xor", "Shl", "LShr", "AShr"]
comparison_expr_kind = [
    "Eq", "Ne", "Ult", "Ule", "Ugt", "Uge", "Slt", "Sle", "Sgt", "Sge"
]
macro_expr_kind = ["Neg", "ReadLSB", "ReadMSB"]
bitvector_expr_kind = ["Concat", "Extract", "ZExt", "SExt"]
special_expr = ["Read", "Select"]
query_command = ["query"]


def collectRecursive(arr, collector):
    for elems in arr:
        if isinstance(elems, list):
            collectRecursive(elems, collector)
        else:
            collector.append(elems)


def findVars(expr):
    pass


data = {}
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

resultObjs = []
for objs in data:
    lineNo = objs["Line"]
    trueQuery = [loads(x) for x in objs["trueQuery"]]
    falseQuery = [loads(x) for x in objs["falseQuery"]]
