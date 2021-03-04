import io
import os
import sys
import time

from subprocess import run, CalledProcessError

pwd = os.path.dirname(__file__)
executable = os.path.join(pwd, os.pardir, f"bin/example")
inputFile = os.path.join(pwd, os.pardir, f"inputs/model")
codeFile = os.path.join(pwd, os.pardir, f"example1_mod.cpp")
outputFile = os.path.join(pwd, os.pardir, f"inputs/outputs")


def build():
    # TODO : Compile and execute program
    try:
        # print(f"Running Binary Example {example}.c")
        output = run(
            f'g++ {codeFile} -o {executable}',
            shell=True, capture_output=False, text=True)
    except CalledProcessError as err:
        print(f"Build Error : {err}")
    else:
        print(f"Return : {output.returncode}")
    return output.returncode


def executeCV():
    # TODO : Compile and execute program
    try:
        # print(f"Running Binary Example {example}.c")
        output = run(
            f'{executable} < {inputFile} > {outputFile}',
            shell=True, capture_output=True, text=True)
    except CalledProcessError as err:
        print(f"Execute Error : {err}")
    else:
        print(f"Return : {output.returncode}")
    return output.returncode


if __name__ == "__main__":
    build()
    executeCV()
