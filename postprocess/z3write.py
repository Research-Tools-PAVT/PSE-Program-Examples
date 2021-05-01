import os
import sys
import json
from parser import collectRecursive, findVars
from sexpdata import loads, dumps

"""
Parsing works for monty hall constraint cases
as of now, will work on the rest of the cases
later as examples evolve.
"""

operationsMap = {
    "Ult": "<",
    "Ule": "<=",
    "Ugt": ">",
    "Uge": ">=",
    "Slt": "<",
    "Sle": "<=",
    "Sgt": ">",
    "Sge": ">=",
    "Add": "+",
    "Sub": "-",
    "Mul": "*",
    "SDiv": "/",
    "UDiv": "/",
}

z3Defs = {"And": "z3.And", "Or": "z3.Or", "Xor": "z3.Xor"}

bitvector_expr_kind = ["Extract", "ZExt", "SExt"]


def getInfixExpression(expr, operator):

    if operator == "ReadLSB":
        variable = expr.get("var", None)
        # print(variable)
        return variable

    const = expr.get("const", None)
    right = expr.get("right", None)
    if right is not None:
        rexpr = genericParse(right)
    left = expr.get("left", None)
    if left is not None:
        lexpr = genericParse(left)

    if operator in bitvector_expr_kind:
        right = expr.get("right", None)
        r = genericParse(right)
        return r

    z3Op = z3Defs.get(operator, None)
    if z3Op is not None:
        if const is not None and right is not None:
            return f"{z3Defs[operator]}({const}, {rexpr})"

        if const is not None and left is not None:
            return f"{z3Defs[operator]}({lexpr}, {const})"

        if left is not None and right is not None:
            return f"{z3Defs[operator]}({lexpr}, {rexpr})"

    ArithOps = operationsMap.get(operator, None)
    if ArithOps is not None:
        if const is not None and right is not None:
            return f'({const} {operationsMap.get(operator, ",")} {rexpr})'

        if const is not None and left is not None:
            return f'({lexpr} {operationsMap.get(operator, ",")} {const})'

        if left is not None and right is not None:
            return f'({lexpr} {operationsMap.get(operator, ",")} {rexpr})'


def genericParse(expr):
    if expr is None:
        return

    if expr.get("action") == "Eq":
        lvariable = ""
        rvariable = ""
        right = expr.get("right", None)
        left = expr.get("left", None)
        const = expr.get("const", None)
        boolean = expr.get("bool", None)
        if right is not None:
            parsedRight = genericParse(right)
            rvariable = right.get("var", None)
            if const is not None:
                # print(f'{variable} == {const}')
                return f"{rvariable} == {const}"
            if boolean is not None:
                if boolean == "true":
                    # print(f'{parsedRight}')
                    return parsedRight
                if boolean == "false":
                    # print(f'!({parsedRight})')
                    return f"z3.Not({parsedRight})"

        if left is not None:
            parsedLeft = genericParse(left)
            lvariable = left.get("var", None)
            if const is not None:
                # print(f'{variable} == {const}')
                return f"{lvariable} == {const}"
            if boolean is not None:
                if boolean == "true":
                    # print(f'{parsedRight}')
                    return parsedLeft
                if boolean == "false":
                    # print(f'!({parsedRight})')
                    return f"z3.Not({parsedLeft})"

        # print(f'{lvariable} == {rvariable}')
        return f"{lvariable} == {rvariable}"

    return getInfixExpression(expr, expr.get("action"))


def z3write(file):
    """
    Parsing works for monty hall constraint cases
    as of now, will work on the rest of the cases
    later as examples evolve.
    """
    data = {}
    with open(file, mode="r") as f:
        data = json.load(f)

    count = 0
    pathConditions = dict()
    variables = set()
    for elems, paths in data.items():
        predicateList = []
        klee_assumes = set()
        count += 1

        # print(f'Path : {count}')
        true0 = paths[0].get("nodeTrueQuery", None)
        false0 = paths[0].get("nodeFalseQuery", None)
        for elems in true0:
            klee_assumes.add(elems)
        for elems in false0:
            klee_assumes.add(elems)

        # print("Assumes : ")
        for preds in klee_assumes:
            # COMMENT : This is not generic for Assumes.
            # May have other types of expressions as well. BUG !
            if preds is not None and any(["Sle" in preds]):
                parsed = collectRecursive(loads(preds))
                # print(genericParse(parsed))
                predicateList.append(genericParse(parsed))

        # print("\nPaths : ")
        for nodes in paths:
            extractVars = nodes.get("variables", None)
            if extractVars is not None:
                for v in extractVars:
                    variables.add(v)
            predicate = nodes.get("predicate", None)
            if predicate is not None:
                # print(predicate)
                parsed = collectRecursive(loads(predicate))
                # print(parsed)
                # print(genericParse(parsed))
                predicateList.append(genericParse(parsed))
        # print(f"Variables : {variables}")
        # for v in predicateList:
        #     print(v)
        pathConditions[count] = predicateList

    fmtv = " ".join(x for x in variables)
    varsList = ", ".join(x for x in variables)

    p = ""
    for x in range(count):
        p += f"path{x+1}, "

    print(f'import z3\n\n{varsList} = z3.Ints("{fmtv}")')
    for k, v in pathConditions.items():
        print(f"\npath{k} = [")
        constraints = ",\n".join(c for c in v)
        print(constraints)
        print("]")
    print(f"\n\npaths = [{p[:-2]}]")
    return variables, pathConditions


if __name__ == "__main__":
    z3write(sys.argv[1])
    # expression = "(Add w32 (Add w32 (ReadLSB w32 0 y_sym) (ReadLSB w32 0 y_sym)) (ReadLSB w32 0 y_sym))"
    # parsed = collectRecursive(loads(expression))
    # print(genericParse(parsed))