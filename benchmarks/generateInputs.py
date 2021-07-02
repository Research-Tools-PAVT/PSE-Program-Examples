import os
import sys
import time
import random

# testWritter.write(
# f"{random.randint(-2147483648, 2147483647)}\n")

pwd = os.path.dirname(__file__)
inputFilePath = os.path.join(pwd, "tests")

if __name__ == "__main__":
    for index in range(int(sys.argv[1].strip())):
        with open(os.path.join(inputFilePath, f"input_{index + 1}.txt"), mode="w") as testWritter:
            testWritter.write(f"{int(sys.argv[1].strip())}\n")
            testWritter.write(
                f"{random.randint(1, 2000)}\n")
            testWritter.write(
                f"{random.randint(1, 100)}\n")
            testWritter.write(
                f"{round(random.uniform(0.000001, 1.000000), 6)}\n")
