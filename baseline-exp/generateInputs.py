import os
import sys
import time
import random

pwd = os.path.dirname(__file__)
inputFilePath = os.path.join(pwd, "tests")

if __name__ == "__main__":
    for index in range(int(sys.argv[1].strip())):
        with open(os.path.join(inputFilePath, f"input_{index + 1}.txt"), mode="w") as testWritter:
            for tests in range(10):
                testWritter.write(
                    f"{random.randint(int(sys.argv[2].strip()), int(sys.argv[3].strip()))}\n")
