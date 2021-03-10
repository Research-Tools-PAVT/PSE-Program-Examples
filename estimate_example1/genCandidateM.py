# -*- coding: utf-8 -*-

import os

pwd = os.path.dirname(__file__)
inputFilePath = os.path.join(pwd, "inputs")

a, c, d = 0, 0, 0

for a in range(2):
    for c in range(10):
        for d in range(10):
            with open(
                os.path.join(inputFilePath, f"model_{a}_{c}_{d}.txt"), mode="w"
            ) as fileptr:
                fileptr.write(f"{a}\n")
                fileptr.write(f"{c + 1}\n")
                fileptr.write(f"{d - 5}\n")
