# -*- coding: utf-8 -*-

import os
import random

pwd = os.path.dirname(__file__)
inputFilePath = os.path.join(pwd, "foralls")
sampleList = [0, 1]

for i in range(21):
    randomList = random.choices(
        sampleList, weights=(50 + 2 * i, 50 - 2 * i), k=1000001)

    with open(os.path.join(inputFilePath, f"model_monty_more_{i}.txt"), mode="w") as fileptr:
        for i in randomList:
            fileptr.write(f"{i}\n")


for i in range(21):
    randomList = random.choices(
        sampleList, weights=(50 - 2 * i, 50 + 2 * i), k=1000001)

    with open(os.path.join(inputFilePath, f"model_monty_less_{i}.txt"), mode="w") as fileptr:
        for i in randomList:
            fileptr.write(f"{i}\n")
