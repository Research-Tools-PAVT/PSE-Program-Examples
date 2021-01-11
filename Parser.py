# -*- coding: utf-8 -*-
import re
import sys
import json
import uuid
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
    "Extract", "ZExt", "SExt", "Read", "Select", "Undef", "None", "Unsat"
]

BooleanType = ["true", "false"]


class sExprNode(dict):
    def __init__(self, expr=""):
        self.expr = expr
        self.first = None
        self.second = None
        self.operator = None
        dict.__init__(self,
                      exprId=str(uuid.uuid4()),
                      left=self.first,
                      right=self.second,
                      optype=self.operator)


def flatten(arr):
    if isinstance(arr, list) and len(arr) == 0:
        return arr
    if isinstance(arr[0], list):
        return flatten(arr[0]) + flatten(arr[1:])
    return arr[:1] + flatten(arr[1:])


def getOps(elems):
    if elems in arithmetic_expr_kind:
        return "BinaryArithOp"
    elif elems in bitwise_expr_kind:
        return "BitwiseOp"
    elif elems in comparison_expr_kind:
        return "CompareOp"
    elif elems in macro_expr_kind:
        return "MacroOp"
    elif elems in bitvector_expr_kind:
        return "BitVectorOp"
    elif elems in special_expr:
        return "MemoryOp"
    elif elems in query_command:
        return "QueryAction"
    else:
        pass


def isInt(val):
    try:
        num = int(val)
    except ValueError:
        return False
    return True


def isFloat(val):
    try:
        num = float(val)
    except ValueError:
        return False
    return True


def getTerminalType(elems):
    temp = {}
    if elems in [loads(x) for x in AllExprTypes]:
        operationType = getOps(dumps(elems))
        temp["action"] = dumps(elems)
        temp["optype"] = operationType
    elif elems in [loads(x) for x in BooleanType]:
        temp["bool"] = dumps(elems)
    elif re.match("^w\d", dumps(elems)) is not None:
        temp["size"] = dumps(elems)
    elif isInt(dumps(elems)):
        temp["const"] = dumps(elems)
    else:
        temp["var"] = dumps(elems)
    return temp


def returnIfVars(elems):
    if elems in [loads(x) for x in AllExprTypes]:
        return None
    elif elems in [loads(x) for x in BooleanType]:
        return None
    elif re.match("^w\d", dumps(elems)) is not None:
        return None
    elif isInt(dumps(elems)):
        return None
    else:
        return dumps(elems)


def collectRecursive(arr):
    # Not a list
    if not isinstance(arr, list):
        return getTerminalType(arr)
    # list but not a list of list
    if not any(isinstance(x, list) for x in arr):
        temp = {}
        for elems in arr:
            temp.update(getTerminalType(elems))
        return temp
    else:
        # list of list
        ExprContainer = {}
        for index, elems in enumerate(arr):
            if index == 1:
                key = "left"
            elif index == 2:
                key = "right"
            else:
                key = f"arg_{index}"
            if isinstance(elems, list):
                ExprContainer.update({f"{key}": collectRecursive(elems)})
            else:
                ExprContainer.update(getTerminalType(elems))
        return ExprContainer


def findVars(expr):
    temp = []
    if not isinstance(expr, list):
        if returnIfVars(expr) is not None:
            return returnIfVars(expr)
        else:
            return temp
    if not any(isinstance(x, list) for x in expr):
        for elems in expr:
            if returnIfVars(elems) is not None:
                temp.append(returnIfVars(elems))
        return temp
    else:
        for elems in expr:
            if isinstance(elems, list):
                result = findVars(elems)
                if isinstance(result, list) and len(result) > 1:
                    temp.append(result)
                else:
                    temp.append(result)
            else:
                if returnIfVars(elems) is not None:
                    temp.append(returnIfVars(elems))
        return temp


def processExpressionImap(expr):
    return flatten(findVars(expr))


if __name__ == "__main__":
    # data = {}
    # with open(f"{name}_processed/{name}_paths.json", 'r',
    #           encoding='utf-8') as f:
    #     data = json.load(f)

    # for pathIds, path in data.items():
    #     for nodes in path:
    #         sExpr = nodes.get("KLEE-Expr", None)
    #         print(findVars(loads(sExpr)))

    sampleExpr = "(Eq false (And (Eq false (Eq 2 (ReadLSB w32 0 car_door_sym))) (Eq false (Eq 2 (ReadLSB w32 0 choice_pse_var_sym)))))"
    temp = []
    print(flatten(findVars(loads(sampleExpr))))