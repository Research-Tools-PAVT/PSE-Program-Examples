# -*- coding: utf-8 -*-
import os
import sys
import json
from PTree import *
from Parser import *
from sexpdata import loads, dumps
import uuid

id = 0
pathMap = {}
aliasMap = {}
nodeMap = {}
results = []
paths = {}
Tree = ExecutionTree()
file = sys.argv[1]
name = sys.argv[2]

with open(file.strip(), "r") as fileptr:
    lines = fileptr.read().replace("\n", " ")
    for elems in lines.split("}"):
        if len(elems.strip()) != 0:
            ConstraintObj = elems.split("{")[1].strip()
            temp = {}
            for fields in ConstraintObj.split(","):
                if len(fields.strip().split(":")) == 2:
                    [key, value] = fields.strip().split(":")
                    if "Query" in key.strip():
                        temp[key.strip()] = [
                            ' '.join(x.strip().split()) for x in value.strip()
                            [1:len(value.strip()) -
                             1].strip().split(" > ")[1:len(value.strip())]
                        ]
                    elif "Branch" in key.strip() or "Negate" in key.strip():
                        temp[key.strip()] = ' '.join(value.strip().split())
                    else:
                        temp[key.strip()] = value.strip()
            results.append(temp)

results.sort(key=lambda x: int(x["Line"]), reverse=False)

for elems in results:
    if elems.get("Current State Id", None):
        current = int(elems["Current State Id"])
        klee_true = int(elems["True KLEE Id"])
        generate_true = int(elems["True Generate ID"])
        klee_false = int(elems["False KLEE Id"])
        generate_false = int(elems["False Generate ID"])

        node = nodeMap.get(
            f"{aliasMap.get(current, current)}",
            ExecutionTreeNode(f"{aliasMap.get(current, current)}"))
        left = nodeMap.get(f"{generate_true}",
                           ExecutionTreeNode(f"{generate_true}"))
        right = nodeMap.get(f"{generate_false}",
                            ExecutionTreeNode(f"{generate_false}"))

        nodeMap[aliasMap.get(current, current)] = node
        nodeMap[generate_true] = left
        nodeMap[generate_false] = right

        if (klee_true == current):
            aliasMap[current] = generate_true
            aliasMap[klee_false] = generate_false
        elif (klee_false == current):
            aliasMap[current] = generate_false
            aliasMap[klee_true] = generate_true
        else:
            pass

        trueExpr = elems["Branch Predicate"]
        falseExpr = elems["Negate Predicate"]

        node.edges.append(
            ExecutionTreeEdge(node,
                              left,
                              label='\n('.join(trueExpr.strip().split(' (')),
                              color="green"))

        node.edges.append(
            ExecutionTreeEdge(node,
                              right,
                              label='\n('.join(falseExpr.strip().split(' (')),
                              color="red"))

        Tree.edgeSet.append(
            ExecutionTreeEdge(node,
                              left,
                              label='\n('.join(trueExpr.strip().split(' (')),
                              color="green"))

        Tree.edgeSet.append(
            ExecutionTreeEdge(node,
                              right,
                              label='\n('.join(falseExpr.strip().split(' (')),
                              color="red"))

# Add Nodes & Get Leaves
for k, v in nodeMap.items():
    Tree.add_node(v)
    if len(v.edges) == 0:
        id = id + 1
        pathMap[id] = v


# Find the parent node for a child or vice-versa
def findNext(node):
    for edges in Tree.edgeSet:
        if node.data[0] == edges.child.data[0]:
            return edges.parent


# Find the parent node for a child or vice-versa
def getLabel(node):
    for edges in Tree.edgeSet:
        if node.data[0] == edges.child.data[0]:
            return edges.data


# Construct the paths.
for pathIds, nodes in pathMap.items():
    temp = nodes
    path = []
    while findNext(temp) is not None:
        collection = {}
        data = ' '.join(getLabel(temp).strip().split("\n"))
        collection["treeNode"] = temp
        if data is not None:
            collection["KLEE-Expr"] = data
            collection["Parse"] = collectRecursive(loads(data))
            path.append(collection)
        else:
            path.append(collection)
        temp = findNext(temp)
    paths[f"Path {pathIds}"] = path

Tree.save_cfg(filename=f"{name}_execution_tree", directory=f"{name}_processed")

with open(f"{name}_processed/{name}_processed.json", 'w',
          encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=4)

with open(f"{name}_processed/{name}_paths.json", 'w', encoding='utf-8') as f:
    json.dump(paths, f, ensure_ascii=False, indent=4)