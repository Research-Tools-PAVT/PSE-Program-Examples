# -*- coding: utf-8 -*-

import os
import sys
import json
from ptree import *
from parser import collectRecursive, findVars
from unionfind import processExpressionImap
from sexpdata import loads, dumps
from auxiliary import flatten
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


# Find the parent node for a child or vice-versa
def findNext(node):
    for edges in Tree.edgeSet:
        if node.data[0] == edges.child.data[0]:
            return edges.parent


# Find the parent node for a child or vice-versa
def getLabel(node):
    # Return Empty string if nothing matches.
    for edges in Tree.edgeSet:
        if node.data[0] == edges.child.data[0]:
            if not edges.data:
                return ""
            else:
                return edges.data
    return ""


# Process the file dump from KLEE
with open(file.strip(), "r") as fileptr:
    lines = fileptr.read().replace("\n", " ")

    # We read all lines here.
    # We dont need the original dump after this point.
    for elems in lines.split("}"):
        if len(elems.strip()) != 0 and len(elems.split("{")) > 1:
            ConstraintObj = elems.split("{")[1].strip()
            temp = {}

            # We seperate into each dump item, array constructed.
            for fields in ConstraintObj.split(","):
                if len(fields.strip().split(":")) == 2:
                    [key, value] = fields.strip().split(":")

                    # TrueQuery & FalseQuery need specialized processing.
                    if "Query" in key.strip():
                        key_splits = [
                            ' '.join(x.strip().split()) for x in value.strip()
                            [1:len(value.strip()) - 1].strip().split("|")[0:len(value.strip())]
                        ]
                        temp[key.strip()] = [
                            x for x in key_splits[0:len(key_splits) - 1]]

                    # Add the branch condition.
                    elif "Branch" in key.strip() or "Negate" in key.strip():
                        temp[key.strip()] = ' '.join(value.strip().split())
                    else:
                        temp[key.strip()] = value.strip()

            # Add to result.
            results.append(temp)

results.sort(key=lambda x: int(x["Line"]), reverse=False)

for elems in results:
    if elems.get("Current State Id", None):
        current = int(elems["Current State Id"])
        klee_true = int(elems["True KLEE Id"])
        generate_true = int(elems["True Generate ID"])
        klee_false = int(elems["False KLEE Id"])
        generate_false = int(elems["False Generate ID"])

        # Nodes are reused here. Map as a cache.
        node = nodeMap.get(
            f"{aliasMap.get(current, current)}",
            ExecutionTreeNode(f"{aliasMap.get(current, current)}"))
        left = nodeMap.get(f"{generate_true}",
                           ExecutionTreeNode(f"{generate_true}"))
        right = nodeMap.get(f"{generate_false}",
                            ExecutionTreeNode(f"{generate_false}"))

        # Make sure we reuse the Node IDs.
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

        # Added the branch predicates
        trueExpr = elems.get("Branch Predicate", "UNK")
        falseExpr = elems.get("Negate Predicate", "UNK")

        # Added the queries so for to reach this state in PTree.
        node.trueQuerySet = elems.get("trueQuery", [])
        node.falseQuerySet = elems.get("falseQuery", [])

        # Adding the tree edges to nodes.
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

        # We also maintain a global edgeset to make queries faster.
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

# Add Nodes & update Path IDs for PathMap
for k, v in nodeMap.items():
    Tree.add_node(v)
    # Leaf nodes are path ends.
    # Update Path ID by Leaf node.
    if len(v.edges) == 0:
        id = id + 1
        pathMap[id] = v

# Construct the paths from PathMaps
for pathIds, nodes in pathMap.items():
    path = []
    temp = nodes
    imapsData = {}
    variableListing = []
    variables_extra = set()

    # Recurse up from leaves to root,
    # collecting each edge information.
    while temp is not None:
        collection = {}
        data = ' '.join(getLabel(temp).strip().split("\n"))
        collection["treeNode"] = temp

        # COMMENT : Must collect all the variables in the expression.
        if len(nodes.trueQuerySet) > 0:
            for e in nodes.trueQuerySet:
                parse_e = loads(e)
                for v in flatten(findVars(parse_e)):
                    variables_extra.add(v)

        if len(nodes.falseQuerySet) > 0:
            for e in nodes.falseQuerySet:
                parse_e = loads(e)
                for v in flatten(findVars(parse_e)):
                    variables_extra.add(v)

        # COMMENT : If the label/edge has an associated "predicate" with it.
        if data:
            parsedData = loads(data)
            variables = flatten(findVars(parsedData))
            variableListing.append(variables)
            collection["predicate"] = data
            processExpressionImap(imapsData, variables)
            # All query lead to this particular node.
            # KLEE Assumes also come-in at this point.
            collection["variables"] = variables
            collection["IMap"] = imapsData

        # Print the full query even for the first Node.
        # whatever the case be
        collection["nodeTrueQuery"] = temp.trueQuerySet
        collection["nodeFalseQuery"] = temp.falseQuerySet

        # Append to path the collection so far
        path.append(collection)
        temp = findNext(temp)
    paths[f"Path {pathIds}"] = path

for _, path in paths.items():
    path.sort(key=lambda x: int(x["treeNode"]["nodeId"]), reverse=False)

Tree.save_cfg(filename=f"{name}_execution_tree", directory=f"{name}_processed")

with open(f"{name}_processed/{name}_processed.json", 'w',
          encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=4)

with open(f"{name}_processed/{name}_paths.json", 'w', encoding='utf-8') as f:
    json.dump(paths, f, ensure_ascii=False, indent=4)

print(f"Paths Processed : {len(paths)}")
