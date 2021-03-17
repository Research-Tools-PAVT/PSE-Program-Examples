import os
import sys
import json
from parser import collectRecursive, findVars
from sexpdata import loads, dumps

'''
Parsing works for monty hall constraint cases
as of now, will work on the rest of the cases
later as examples evolve.
'''


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
                return f'{rvariable} == {const}'
            if boolean is not None:
                if boolean == "true":
                    # print(f'{parsedRight}')
                    return parsedRight
                if boolean == "false":
                    # print(f'!({parsedRight})')
                    return f'z3.Not({parsedRight})'

        if left is not None:
            parsedLeft = genericParse(left)
            lvariable = left.get("var", None)
            if const is not None:
                # print(f'{variable} == {const}')
                return f'{lvariable} == {const}'
            if boolean is not None:
                if boolean == "true":
                    # print(f'{parsedRight}')
                    return parsedLeft
                if boolean == "false":
                    # print(f'!({parsedRight})')
                    return f'z3.Not({parsedLeft})'

        # print(f'{lvariable} == {rvariable}')
        return(f'{lvariable} == {rvariable}')

    if expr.get("action") in "Slt":
        const = expr.get("const", None)
        right = expr.get("right", None)
        if right is not None:
            rexpr = genericParse(right)
        left = expr.get("left", None)
        if left is not None:
            lexpr = genericParse(left)

        if const is not None and right is not None:
            return f'({const} < {rexpr})'

        if const is not None and left is not None:
            return f'({lexpr} < {const})'

        if left is not None and right is not None:
            return f'({lexpr} < {rexpr})'

    if expr.get("action") in "Sle":
        const = expr.get("const", None)
        right = expr.get("right", None)
        if right is not None:
            rexpr = genericParse(right)
        left = expr.get("left", None)
        if left is not None:
            lexpr = genericParse(left)

        if const is not None and right is not None:
            return f'({const} <= {rexpr})'

        if const is not None and left is not None:
            return f'({lexpr} <= {const})'

        if left is not None and right is not None:
            return f'({lexpr} <= {rexpr})'

    if expr.get("action") in "Sgt":
        const = expr.get("const", None)
        right = expr.get("right", None)
        if right is not None:
            rexpr = genericParse(right)
        left = expr.get("left", None)
        if left is not None:
            lexpr = genericParse(left)

        if const is not None and right is not None:
            return f'({const} > {rexpr})'

        if const is not None and left is not None:
            return f'({lexpr} > {const})'

        if left is not None and right is not None:
            return f'({lexpr} > {rexpr})'

    if expr.get("action") in "Sge":
        const = expr.get("const", None)
        right = expr.get("right", None)
        if right is not None:
            rexpr = genericParse(right)
        left = expr.get("left", None)
        if left is not None:
            lexpr = genericParse(left)

        if const is not None and right is not None:
            return f'({const} >= {rexpr})'

        if const is not None and left is not None:
            return f'({lexpr} >= {const})'

        if left is not None and right is not None:
            return f'({lexpr} >= {rexpr})'

    if expr.get("action") == "ReadLSB":
        variable = expr.get("var", None)
        # print(variable)
        return variable

    if expr.get("action") == "And":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} && {r})')
        return f'z3.And({l}, {r})'

    if expr.get("action") == "Or":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} || {r})')
        return f'z3.Or({l}, {r})'

    if expr.get("action") == "Add":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} + {r})')
        return f'({l} + {r})'

    if expr.get("action") == "Sub":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} - {r})')
        return f'({l} - {r})'

    if expr.get("action") == "Mul":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} * {r})')
        return f'({l} * {r})'

    if expr.get("action") == "Xor":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} && {r})')
        return f'z3.Xor({l}, {r})'

    if expr.get("action") == "Extract":
        right = expr.get("right", None)
        r = genericParse(right)
        return(r)

    if expr.get("action") == "ZExt":
        right = expr.get("right", None)
        r = genericParse(right)
        return(r)


if __name__ == "__main__":
    '''
    Parsing works for monty hall constraint cases
    as of now, will work on the rest of the cases
    later as examples evolve.
    '''
    data = {}
    with open(sys.argv[1], mode="r") as f:
        data = json.load(f)

    count = 0
    predicateList = []

    for elems, paths in data.items():
        variables = set()
        count += 1
        print(f'Path : {count}')
        klee_assumes = paths[0].get('nodeTrueQuery', None)

        print("Assumes : ")
        for preds in klee_assumes:
            if preds is not None and any(["Slt" in preds, "Sle" in preds, "Sgt" in preds, "Sge" in preds]):
                parsed = collectRecursive(loads(preds))
                print(genericParse(parsed))
                predicateList.append(preds)

        print("\nPaths : ")
        for nodes in paths:
            extractVars = nodes.get('variables', None)
            if extractVars is not None:
                for v in extractVars:
                    variables.add(v)
            predicate = nodes.get('predicate', None)
            if predicate is not None:
                # print(predicate)
                parsed = collectRecursive(loads(predicate))
                # print(parsed)
                print(genericParse(parsed))
                predicateList.append(predicate)
        print("\nVariables : ")
        print(variables)
        print(f'\n')
