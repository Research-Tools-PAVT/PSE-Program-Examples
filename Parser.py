# -*- coding: utf-8 -*-
import re
import sys
import json
from sexpdata import loads, dumps

name = sys.argv[1]
arithmetic_expr_kind = ["Add", "Sub", "Mul", "UDiv", "URem", "SDiv", "SRem"]
bitwise_expr_kind = ["And", "Or", "Xor", "Shl", "LShr", "AShr"]
comparison_expr_kind = [
    "Eq", "Ne", "Ult", "Ule", "Ugt", "Uge", "Slt", "Sle", "Sgt", "Sge"
]
macro_expr_kind = ["Neg", "ReadLSB", "ReadMSB"]
bitvector_expr_kind = ["Concat", "Extract", "ZExt", "SExt"]
special_expr = ["Read", "Select"]
query_command = ["query"]

AllExprTypes = [
    "Add", "Sub", "Mul", "UDiv", "URem", "SDiv", "SRem", "And", "Or", "Xor",
    "Shl", "LShr", "query", "AShr", "Eq", "Ne", "Ult", "Ule", "Ugt", "Uge",
    "Slt", "Sle", "Sgt", "Sge", "Neg", "ReadLSB", "ReadMSB", "Concat",
    "Extract", "ZExt", "SExt", "Read", "Select"
]

BooleanType = ["true", "false"]


class sExprNode(dict):
    def __init__(self, expr=""):
        self.expr = expr
        self.first = None
        self.second = None
        self.operator = None


def isInt(val):
    try:
        num = int(val)
    except ValueError:
        return False
    return True


def collectRecursive(arr):
    if not any(isinstance(x, list) for x in arr):
        temp = {}
        for elems in arr:
            type = ""
            if elems in [loads(x) for x in AllExprTypes]:
                temp["sub_action"] = dumps(elems)
            elif elems in [loads(x) for x in BooleanType]:
                temp["bool"] = dumps(elems)
            elif re.match("^w\d", dumps(elems)) is not None:
                temp["size"] = dumps(elems)
            elif isInt(dumps(elems)):
                temp["const"] = dumps(elems)
            else:
                temp["var"] = dumps(elems)
        return temp
    else:
        ExprContainer = {}
        for index, elems in enumerate(arr):
            anotherTemp = {}
            if isinstance(elems, list):
                ExprContainer.update({f"arg_{index}": collectRecursive(elems)})
            else:
                type = ""
                if elems in [loads(x) for x in AllExprTypes]:
                    type = "main_action"
                elif elems in [loads(x) for x in BooleanType]:
                    type = "bool"
                elif re.match("^w\d", dumps(elems)) is not None:
                    type = "size"
                elif isInt(dumps(elems)):
                    type = "const"
                else:
                    type = "var"
                ExprContainer.update({f"{type}": dumps(elems)})
        return ExprContainer


def findVars(expr):
    pass


if __name__ == "__main__":
    data = {}
    with open(f"{name}_processed/{name}_paths.json", 'r',
              encoding='utf-8') as f:
        data = json.load(f)

    resultObjs = []
    collector = []
    for pathIds, path in data.items():
        for nodes in path:
            sExpr = nodes.get("sExpr", None)
            print(collectRecursive(loads(sExpr), collector))
