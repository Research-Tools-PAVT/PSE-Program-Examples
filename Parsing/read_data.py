# -*- coding: utf-8 -*-
import os
import sys
import json

results = []
with open('testing.txt', "r") as fileptr:
    lines = fileptr.read().replace("\n", " ")
    for elems in lines.split("}"):
        if len(elems.strip()) != 0:
            ConstraintObj = elems.split("{")[1].strip()
            temp = {}
            for fields in ConstraintObj.split(","):
                [key, value] = fields.strip().split(":")
                if "Query" in key.strip():
                    temp[key.strip()] = value.strip()[1:len(value.strip()) -
                                                      1].strip().split("\t\t")
                else:
                    temp[key.strip()] = value.strip()
            results.append(temp)

with open('data.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=4)
