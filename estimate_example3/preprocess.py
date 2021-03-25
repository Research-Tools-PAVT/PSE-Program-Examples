# -*- coding: utf-8 -*-

import os
import sys


def transformPass(code_file):
    code = []
    with open(code_file, mode="r+") as fileptr:
        code_lines = fileptr.readlines()
        for lines in code_lines:
            if lines.strip().startswith("klee_make_symbolic", 0):
                forallVar = lines.strip().split(",")[0].split("&")[1].strip()
                print(f"forall : {forallVar}")
                code.append(f"scanf(%d, &{forallVar});")
            if lines.strip().startswith("make_pse_symbolic", 0):
                forallVar = lines.strip().split(",")[0].split("&")[1].strip()
                print(f"ProbVar : {forallVar}")
                code.append(f"scanf(%d, &{forallVar});")


if __name__ == "__main__":
    transformPass(sys.argv[1])
