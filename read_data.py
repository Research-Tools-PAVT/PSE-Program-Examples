# -*- coding: utf-8 -*-
import os
import sys
import json
from PTree import *
import uuid

results = []
Tree = ExecutionTree()
root = ExecutionTreeNode("Root", 0)
file = sys.argv[1]
name = sys.argv[2]
with open(file.strip(), "r") as fileptr:
    lines = fileptr.read().replace("\n", " ")
    for elems in lines.split("}"):
        if len(elems.strip()) != 0:
            ConstraintObj = elems.split("{")[1].strip()
            temp = {}
            for fields in ConstraintObj.split(","):
                [key, value] = fields.strip().split(":")
                if "Query" in key.strip():
                    temp[key.strip()] = [
                        ' '.join(x.strip().split()) for x in value.strip()
                        [1:len(value.strip()) -
                         1].strip().split("->")[1:len(value.strip())]
                    ]
                elif "Branch" in key.strip() or "Negate" in key.strip():
                    temp[key.strip()] = ' '.join(value.strip().split())
                else:
                    temp[key.strip()] = value.strip()
            results.append(temp)

line_predicates = []
linePredicateMap = dict()
for index, objs in enumerate(results):
    temp = {}
    predicates = []

    if objs["Line"] not in linePredicateMap:
        linePredicateMap[objs["Line"]] = []

    temp["Predicate"] = objs["Predicate"]
    temp["Branch Predicate"] = ' '.join(
        objs["Branch Predicate"].strip().split())
    temp["Negate Predicate"] = ' '.join(
        objs["Negate Predicate"].strip().split())
    temp["trueQuery"] = objs["trueQuery"]
    temp["falseQuery"] = objs["falseQuery"]

    linePredicateMap[objs["Line"]].append(temp)

    print("Building Execution Tree")
    node = ExecutionTreeNode(index, index)
    left = ExecutionTreeNode(2 * index + 1, 2 * index + 1)
    right = ExecutionTreeNode(2 * index + 2, 2 * index + 2)
    Tree.add_node(node)
    Tree.add_node(left)
    Tree.add_node(right)
    trueExpr = objs["Branch Predicate"]
    falseExpr = objs["Negate Predicate"]
    node.edges.append(
        ExecutionTreeEdge(node,
                          left,
                          label='\n('.join(trueExpr.strip().split(' (')),
                          color="green"))
    node.edges.append(
        ExecutionTreeEdge(node,
                          right,
                          label='\n('.join(falseExpr.strip().split(' (')),
                          color="Red"))
    temp["Line"] = objs["Line"]
    line_predicates.append(temp)

Tree.save_cfg(filename=f"{name}_execution_tree")

results.sort(key=lambda x: int(x["Line"]), reverse=False)
with open(f"{name}_processed.json", 'w', encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=4)

line_predicates.sort(key=lambda x: int(x["Line"]), reverse=False)
with open(f"{name}_perline.json", 'w', encoding='utf-8') as f:
    json.dump(line_predicates, f, ensure_ascii=False, indent=4)

for elems in linePredicateMap:
    linePredicateMap[elems].sort(key=lambda x: int(x["Predicate"]),
                                 reverse=False)
with open(f"{name}_bypredicates.json", 'w', encoding='utf-8') as f:
    json.dump(linePredicateMap, f, ensure_ascii=False, indent=4)