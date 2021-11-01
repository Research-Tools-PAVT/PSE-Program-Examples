# -*- coding: utf-8 -*-

import re
import sys
import json
import uuid
from sexpdata import loads, dumps
from auxiliary import flatten, isFloat, isInt

arithmetic_expr_kind = ["Add", "Sub", "Mul", "UDiv", "URem", "SDiv", "SRem"]
bitwise_expr_kind = ["And", "Or", "Xor", "Shl", "LShr", "AShr"]
comparison_expr_kind = [
    "Eq",
    "Ne",
    "Ult",
    "Ule",
    "Ugt",
    "Uge",
    "Slt",
    "Sle",
    "Sgt",
    "Sge",
]
macro_expr_kind = ["Neg", "ReadLSB", "ReadMSB"]
bitvector_expr_kind = ["Concat", "Extract", "ZExt", "SExt"]
special_expr = ["Read", "Select"]
query_command = ["query"]

AllExprTypes = [
    "Add",
    "Sub",
    "Mul",
    "UDiv",
    "URem",
    "SDiv",
    "SRem",
    "And",
    "Or",
    "Xor",
    "Shl",
    "LShr",
    "query",
    "AShr",
    "Eq",
    "Ne",
    "Ult",
    "Ule",
    "Ugt",
    "Uge",
    "Slt",
    "Sle",
    "Sgt",
    "Sge",
    "Neg",
    "ReadLSB",
    "ReadMSB",
    "Concat",
    "Extract",
    "ZExt",
    "SExt",
    "Read",
    "Select",
    "Undef",
    "None",
    "Unsat",
    "UNK",
]

BooleanType = ["true", "false"]


class sExprNode(dict):
    def __init__(self, expr=""):
        self.expr = expr
        self.first = None
        self.second = None
        self.operator = None
        dict.__init__(
            self,
            exprId=str(uuid.uuid4()),
            left=self.first,
            right=self.second,
            optype=self.operator,
        )


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
    # print(f"{arr}\n")
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
                key = "left"
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


if __name__ == "__main__":
    string = '''         (Eq false
             (Slt N2
                  (ReadLSB w32 N5:(Extract w32 0 (Mul w64 4 (SExt w64 N4))) U0:[23=N6:(Read w8 3 f_5),
                                                                                22=N7:(Read w8 2 f_5),
                                                                                21=N8:(Read w8 1 f_5),
                                                                                20=N9:(Read w8 0 f_5),
                                                                                19=N10:(Read w8 3 f_4),
                                                                                18=N11:(Read w8 2 f_4),
                                                                                17=N12:(Read w8 1 f_4),
                                                                                16=N13:(Read w8 0 f_4),
                                                                                15=N14:(Read w8 3 f_3),
                                                                                14=N15:(Read w8 2 f_3),
                                                                                13=N16:(Read w8 1 f_3),
                                                                                12=N17:(Read w8 0 f_3),
                                                                                11=N18:(Read w8 3 f_2),
                                                                                10=N19:(Read w8 2 f_2),
                                                                                9=N20:(Read w8 1 f_2),
                                                                                8=N21:(Read w8 0 f_2),
                                                                                7=N22:(Read w8 3 f_1),
                                                                                6=N23:(Read w8 2 f_1),
                                                                                5=N24:(Read w8 1 f_1),
                                                                                4=N25:(Read w8 0 f_1),
                                                                                3=N26:(Read w8 3 f),
                                                                                2=N27:(Read w8 2 f),
                                                                                1=N28:(Read w8 1 f),
                                                                                0=N29:(Read w8 0 f)] @ const_arr1)))'''
    print(json.dumps(collectRecursive(loads(string)), indent=4, sort_keys=True))
