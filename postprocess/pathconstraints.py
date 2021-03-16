import os
import sys
import json
from parser import collectRecursive
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
                    return f'!({parsedRight})'

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
                    return f'!({parsedLeft})'

        # print(f'{lvariable} == {rvariable}')
        return(f'{lvariable} == {rvariable}')

    if expr.get("action") == "And":
        right = expr.get("right", None)
        left = expr.get("left", None)
        r = genericParse(right)
        l = genericParse(left)
        # print(f'({l} && {r})')
        return f'({l} && {r})'

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

        count += 1
        print(f'Path : {count}')
        klee_assumes = paths[0].get('nodeTrueQuery', None)

        for preds in klee_assumes:
            if preds is not None:
                parsed = collectRecursive(loads(preds))
                # print(parsed)
                if parsed.get("optype", None) is "CompareOp":
                    action = parsed.get("action", None)
                    const = parsed.get("const", None)
                    right = parsed.get("right", None)
                    if right is not None:
                        variable = right.get("var", None)
                    left = parsed.get("left", None)
                    if left is not None:
                        variable = left.get("var", None)
                if action is not None:
                    if action == "Sle" and right is not None:
                        print(f"{const} <= {variable}")
                    if action == "Slt":
                        print(f"{const} < {variable}")
                    if action == "Sle" and left is not None:
                        print(f"{variable} <= {const}")
                    if action == "Slt":
                        print(f"{variable} <= {const}")
                predicateList.append(preds)

        for nodes in paths:
            predicate = nodes.get('predicate', None)
            if predicate is not None:
                # print(predicate)
                parsed = collectRecursive(loads(predicate))
                # print(parsed)
                print(genericParse(parsed))
                predicateList.append(predicate)
        print(f'\n')
