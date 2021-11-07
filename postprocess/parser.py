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
    string = '''        (Eq false      (Eq (ReadLSB w32 0 arr_sym)          (ReadLSB w32 4 U0:[(Add w32 3                                      N0:(Extract w32 0 (Mul w64 4                                                                 (SExt w64 (ReadLSB w32 0 j_pse_4_sym)))))=(Read w8 (Add w32 3                                                                                                                             N1:(Extract w32 0 (Mul w64 4                                                                                                                                                        (SExt w64 (Add w32 3                                                                                                                                                                           N2:(ReadLSB w32 0 k_sym))))))                                                                                                                    arr_sym),                             (Add w32 2 N0)=(Read w8 (Add w32 2 N1)                                                     arr_sym),                             (Add w32 1 N0)=(Read w8 (Add w32 1 N1)                                                     arr_sym),                             N0=(Read w8 N1 arr_sym),                             (Add w32 3                                      N3:(Extract w32 0 (Mul w64 4                                                                 (SExt w64 (ReadLSB w32 0 j_pse_3_sym)))))=(Read w8 (Add w32 3                                                                                                                             N4:(Extract w32 0 (Mul w64 4                                                                                                                                                        (SExt w64 (Add w32 2 N2)))))                                                                                                                    arr_sym),                             (Add w32 2 N3)=(Read w8 (Add w32 2 N4)                                                     arr_sym),                             (Add w32 1 N3)=(Read w8 (Add w32 1 N4)                                                     arr_sym),                             N3=(Read w8 N4 arr_sym),                             7=(Read w8 7 arr_sym),                             6=(Read w8 6 arr_sym),                             5=(Read w8 5 arr_sym),                             4=(Read w8 4 arr_sym),                             3=N5:(Read w8 3 arr_sym),                             2=N6:(Read w8 2 arr_sym),                             1=N7:(Read w8 1 arr_sym),                             0=N8:(Read w8 0 arr_sym)] @ const_arr12)))'''
    print(json.dumps(collectRecursive(loads(string)), indent=4, sort_keys=True))
    print(loads(string))
