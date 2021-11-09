# -*- coding: utf-8 -*-

import os
import sys
import json
from ptree import *
from parser import collectRecursive, findVars
from unionfind import processExpressionImap
from sexpdata import loads, dumps
from auxiliary import flatten
from z3write import genericParse
import uuid
import re
import pathlib

idxT = 0
flag = 1  # Controls the display of constraints in SymbEx Tree.
pathMap = {}
aliasMap = {}
nodeMap = {}
results = {}
paths = {}
winning_paths = []
Tree = ExecutionTree()
file = sys.argv[1]
name = sys.argv[2]
removals = 0
totPaths = 0
EdgePredicateLabels = {}
truePred = 0
falsePred = 0
# Find the parent node for a child or vice-versa

statesAnnotated = []
statesSuccessAnnotated = []
ExpectationValues = []


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


def getPredicateId(node):
    # Return Empty string if nothing matches.
    for edges in Tree.edgeSet:
        if node.data[0] == edges.child.data[0]:
            if not edges.label:
                return ""
            else:
                return edges.label
    return ""

# Grab the definitions for the constant arrays from the kquery dump files


def grabConstArrs(root):
    constArrMap = {}
    for filepath in root.rglob('*.kquery'):
        with open(filepath.resolve(), 'r') as fp:
            lines = fp.readlines()
            for l in lines:
                l = l.strip()
                if('array const_arr' in l):
                    args = l.split(' ')
                    arrName = args[1][:args[1].find('[')]
                    vals = l[l.rfind('['):]
                    constArrMap[arrName] = vals
    return constArrMap


constArrMap = grabConstArrs(pathlib.Path(f'klee_results/{name}_klee_out/'))

with open(file.strip(), mode='r') as fileptr:
    if constArrMap:
        constArrMap = dict((re.escape(k), v) for k, v in constArrMap.items())
        pattern = re.compile(
            "|".join(sorted(constArrMap.keys(), reverse=True)))
        text = pattern.sub(
            lambda m: constArrMap[re.escape(m.group(0))], fileptr.read())
        results = json.loads(text)
    else:
        results = json.load(fileptr)

symbolic_exec_tree = results.get('symbolic_execution_tree', None)
RemovedState = results.get('RemovedState', None)
if RemovedState is not None:
    for k, v in RemovedState.items():
        statesAnnotated.append(int(v.get('EmphId', -1)))

win_states = symbolic_exec_tree.get('win_states', None)
if win_states is not None:
    for k, v in win_states.items():
        statesSuccessAnnotated.append(int(v.get('EmphId', -1)))

exp_val_map = symbolic_exec_tree.get('exp_val_map', None)

for currentState, elems in symbolic_exec_tree.items():
    stateIdSmash = elems.get("state_id", None)
    if stateIdSmash is not None:
        if (elems.get("Fork", None) != "False" and elems.get("isLeaf", None) == "False"):
            current = int(stateIdSmash)
            # klee_true = int(elems.get("True KLEE Id", current))
            generate_true = int(elems.get("True Generate ID", current))
            # klee_false = int(elems.get("False KLEE Id", current))
            generate_false = int(elems.get("False Generate ID", current))

            # print(current, generate_true, generate_false)
            # If node is present use it, else create new node
            # Nodes are reused here. Map as a cache.
            # Use the monotonically increasing state IDs as
            # main ID field.
            if nodeMap.get(current, None) is not None:
                # print("Node Exists : Reusing")
                node = nodeMap.get(current)
            else:
                node = ExecutionTreeNode(current)

            if nodeMap.get(generate_true, None) is None:
                # print(current, generate_true)
                left = ExecutionTreeNode(generate_true)
            else:
                # print("Node Exists : Reusing")
                left = nodeMap[generate_true]

            if nodeMap.get(generate_false, None) is None:
                # print(current, generate_false)
                right = ExecutionTreeNode(generate_false)
            else:
                # print("Node Exists : Reusing")
                right = nodeMap[generate_false]

            # Make sure we reuse the Node IDs.
            nodeMap[current] = node
            nodeMap[generate_true] = left
            nodeMap[generate_false] = right

            left.emphemeralId = generate_true
            right.emphemeralId = generate_false

            if left.emphemeralId in statesAnnotated:
                left.invalidated = True

            if right.emphemeralId in statesAnnotated:
                right.invalidated = True

            # Added the branch predicates
            trueExpr = elems.get("Branch Predicate", "UNK")
            falseExpr = elems.get("Negate Predicate", "UNK")

            # Added the queries so for to reach this state in PTree.
            node.trueQuerySet = elems.get("trueQuery", [])
            node.falseQuerySet = elems.get("falseQuery", [])

            # Convert to readable form.
            trueEdgeLabel = [
                genericParse(collectRecursive(loads(trueExpr)))
                # for x in trueExpr.strip().split(" (")
            ]

            falseEdgeLabel = [
                genericParse(collectRecursive(falseExpr))
                # for x in falseExpr.strip().split(" (")
            ]

            # Store the constraints in a map
            # show the map_id instead of the whole constraint.
            # pretty print option.
            truePred += 1
            EdgePredicateLabels[truePred] = "\n(".join(
                trueExpr.strip().split(" ("))

            # Adding the tree edges to nodes. (True Edge)
            node.edges.append(
                ExecutionTreeEdge(
                    node,
                    left,
                    label=f"cond_true_{truePred}" if flag else "\n(".join(
                        trueExpr.strip().split(" (")),
                    edgeLabel="\n(".join(
                        trueExpr.strip().split(" (")),
                    color="blue",
                )
            )

            # Store the constraints in a map
            # show the map_id instead of the whole constraint.
            # pretty print option.
            falsePred += 1
            EdgePredicateLabels[falsePred] = "\n(".join(
                falseExpr.strip().split(" ("))

            # Adding the tree edges to nodes. (False Edge)
            node.edges.append(
                ExecutionTreeEdge(
                    node,
                    right,
                    label=f"cond_false_{falsePred}" if flag else "\n(".join(
                        falseExpr.strip().split(" (")),
                    edgeLabel="\n(".join(
                        falseExpr.strip().split(" (")),
                    color="red",
                )
            )

            # We also maintain a global edgeset to make queries faster.
            # This is not used for displaying the SymbEx Tree.
            Tree.edgeSet.append(
                ExecutionTreeEdge(
                    node,
                    left,
                    label=f"cond_true_{truePred}" if flag else "\n(".join(
                        trueExpr.strip().split(" (")),
                    edgeLabel="\n(".join(
                        trueExpr.strip().split(" (")),
                    color="blue",
                )
            )

            Tree.edgeSet.append(
                ExecutionTreeEdge(
                    node,
                    right,
                    label=f"cond_false_{falsePred}" if flag else "\n(".join(
                        falseExpr.strip().split(" (")),
                    edgeLabel="\n(".join(
                        falseExpr.strip().split(" (")),
                    color="red",
                )
            )

# Add Nodes & update Path IDs for PathMap
for k, v in nodeMap.items():
    Tree.add_node(v)
    # Leaf nodes are path ends.
    # Update Path ID by Leaf node.
    if len(v.edges) == 0:
        # print(v)
        idxT += 1
        pathMap[idxT] = v

# Construct the paths from PathMaps
for pathIds, nodes in pathMap.items():
    path = []
    # winPath = []
    winCollect = {}
    winCollect["Path"] = pathIds
    winCollect["Var Name"] = ""
    winCollect["Var Value"] = ""
    temp = nodes
    imapsData = {}
    variableListing = []
    isWinningPath = False
    isPathFalseAnnotated = False
    variables_extra = set()

    # Recurse up from leaves to root,
    # collecting each edge information.
    while temp is not None:
        collection = {}
        data = " ".join(getLabel(temp).strip().split("\n"))
        predicateId = getPredicateId(temp)
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
        if data and data != "null":
            parsedData = loads(data)
            variables = flatten(findVars(parsedData))
            variableListing.append(variables)
            collection["predicate"] = " ".join(data.split())
#            winCollect["Path"].append(" ".join(data.split()))

            collection["EmphemeralId"] = temp.emphemeralId
            if exp_val_map is not None:
                collection["exp_value"] = exp_val_map.get(
                    f"{temp.emphemeralId}", None)

            collection["removed"] = False
            if temp.emphemeralId in statesAnnotated:
                collection["removed"] = True
                isPathFalseAnnotated = True
            if temp.emphemeralId in statesSuccessAnnotated:
                collection["marked_success"] = True
                isWinningPath = True
            # Show the id of the constraint that belongs to this edge
            # in the SymbEx tree.
            collection["predicateId"] = predicateId

            # IMaps Expressions
            # processExpressionImap(imapsData, variables)
            # collection["IMap"] = imapsData

            # All query lead to this particular node.
            # KLEE Assumes also come-in at this point.
            collection["variables"] = variables

        # Print the full query even for the first Node.
        # whatever the case be
        collection["nodeTrueQuery"] = temp.trueQuerySet
        collection["nodeFalseQuery"] = temp.falseQuerySet

        # Append to path the collection so far
        path.append(collection)
        temp = findNext(temp)

    totPaths += 1
    if isPathFalseAnnotated:
        removals += 1
        # print(f"\033[1;34mPath {pathIds} invalid\033[0m")

    if not isPathFalseAnnotated:
        paths[f"{pathIds}"] = path

        # For Expected Values
        last_node_id = path[0].get("EmphemeralId", None)
        if last_node_id is not None and exp_val_map is not None:
            values = exp_val_map.get(f"{last_node_id}")
            winCollect["Var Name"] = values[0]
            winCollect["Var Value"] = values[1]
            # if str.isdigit(values[1]):
            # winCollect["Var Value"] = int(values[1])

    if isWinningPath:
        winning_paths.append(winCollect)
        print(f"\033[1;36mPath {pathIds} Winning\033[0m")

for _, path in paths.items():
    path.sort(key=lambda x: int(x["treeNode"]["nodeId"]), reverse=False)

# For Expected Values in the Path
# if exp_val_map is not None:
#     for idt, path in paths.items():
#         last_node_id = path[-1].get("EmphemeralId", None)
#         if last_node_id is not None:
#             obj = {}
#             values = exp_val_map.get(f"{last_node_id}")
#             obj["Var Name"] = values[0]
#             obj["Var Value"] = values[1]
#             paths[idt].append(obj)

Tree.save_cfg(filename=f"{name}_execution_tree.dot",
              directory=f"{name}_processed")

getLines = []
with open(f"{name}_processed/{name}_execution_tree.dot", "r") as fileptr:
    getLines = fileptr.readlines()

for elems in statesAnnotated:
    getLines.insert(
        2, f"\t{elems} [color=blue, fillcolor=red, style=filled, fontcolor=white, fontname=\"Courier-Bold\"]\n")

for elems in statesSuccessAnnotated:
    getLines.insert(
        2, f"\t{elems} [color=blue, fillcolor=green, style=filled, fontcolor=black, fontname=\"Courier-Bold\"]\n")

with open(f"{name}_processed/{name}_execution_tree.dot", "w") as fileptr:
    for lines in getLines:
        fileptr.write(lines)

with open(f"{name}_processed/{name}_processed.json", "w", encoding="utf-8") as f:
    json.dump(results, f, ensure_ascii=False, indent=4)

with open(f"{name}_processed/{name}_paths.json", "w", encoding="utf-8") as f:
    json.dump(paths, f, ensure_ascii=False, indent=4)

with open(f"{name}_processed/{name}_winning.json", "w", encoding="utf-8") as f:
    json.dump(winning_paths, f, ensure_ascii=False, indent=4)

print(f"Paths Processed : {totPaths - removals}")
