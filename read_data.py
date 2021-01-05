# -*- coding: utf-8 -*-
import os
import sys
import json

results = []
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
                    temp[key.strip()] = value.strip(
                    )[1:len(value.strip()) -
                      1].strip().split("->")[1:len(value.strip())]
                else:
                    temp[key.strip()] = value.strip()
            results.append(temp)

line_predicates = []
for objs in results:
    temp = {}
    temp["Line"] = objs["Line"]
    temp["Predicate"] = objs["Predicate"]
    temp["trueQuery"] = objs["trueQuery"]
    temp["falseQuery"] = objs["falseQuery"]
    line_predicates.append(temp)

results.sort(key=lambda x: x["Line"], reverse=False)
with open(f"{name}_processed.json", 'w', encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=4)

line_predicates.sort(key=lambda x: x["Line"], reverse=False)
with open(f"{name}_predicates.json", 'w', encoding='utf-8') as f:
    json.dump(line_predicates, f, ensure_ascii=False, indent=4)