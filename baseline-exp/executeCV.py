import os
import sys
import threading
import logging
import time
from alive_progress import alive_bar
from subprocess import run, CalledProcessError

pwd = os.path.dirname(__file__)

executable = sys.argv[1]
inputFilePath = os.path.join(pwd, "tests")
outputFilePath = os.path.join(pwd, "output")


def build():
    try:
        output = run(
            f"./runner.sh {executable}",
            shell=True,
            capture_output=False,
            text=True,
        )
    except CalledProcessError as err:
        print(f"Build Error : {err}")
    else:
        print(f"Return : {output.returncode}")
    return output.returncode


def executeCV(executable, inFile, outfile, errFile):
    try:
        output = run(
            f"bin/{executable} < {inFile} > {outfile} 2> {errFile}",
            shell=True,
            capture_output=False,
            text=True,
        )
    except CalledProcessError as err:
        print(f"Execute Error : {err}")
    else:
        pass
    return output.returncode


logging.basicConfig(level=logging.DEBUG)

if __name__ == "__main__":
    build()
    executeThreads = []
    with alive_bar(len(os.listdir(inputFilePath))) as executeBar:
        for index, inputFile in enumerate(os.listdir(inputFilePath)):
            executeBar.text(
                f"Running : {inputFile}, Benchmark : {sys.argv[1]}")
            executeBar()
            worker_thread = threading.Thread(
                target=executeCV,
                args=(
                    executable,
                    os.path.join(inputFilePath, inputFile),
                    os.path.join(outputFilePath, f"output_{index}.txt"),
                    os.path.join(outputFilePath, f"output_err_{index}.txt"),
                ),
            )
            executeThreads.append(worker_thread)
            worker_thread.start()
            time.sleep(1)

    for index, worker in enumerate(executeThreads):
        worker.join()

    # num_outs = len(os.listdir(outputFilePath))
    # sumtotal = 0.0
    # count = 0

    # with alive_bar(num_outs) as executeBar:
    #     for index, outputFile in enumerate(os.listdir(outputFilePath)):
    #         if "err" not in outputFile:
    #             with open(os.path.join(outputFilePath, outputFile), mode="r") as fileptr:
    #                 line = fileptr.readlines()
    #                 assertQuery = line[0].strip().split(':')[0]
    #                 value = line[0].strip().split(':')[1]
    #                 sumtotal += float(value)
    #                 count += 1
    #                 with open(os.path.join(pwd, "pathprobs.txt"), mode="a") as pathprobs:
    #                     pathprobs.write(
    #                         f'{assertQuery} : {value} : {line[-1].strip()}\n')
    #                 if float(value) < 0.8:
    #                     with open(os.path.join(pwd, "results.txt"), mode="a") as resultFile:
    #                         resultFile.write(
    #                             f'Fail : {assertQuery} : {value} : {line[-1].strip()}\n')
    #         time.sleep(0.1)
    #         executeBar()

    # prob = sumtotal/count
    # print(f'{assertQuery} : {prob}')
