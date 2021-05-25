# -*- coding: utf-8 -*-

import z3
import os
import sys
import json
import time
from alive_progress import alive_bar

# from scipy.stats import bernoulli

# https://z3prover.github.io/api/html/classz3py_1_1_rat_num_ref.html#a1012d6314d35530c58f9c018269ec867


def num(r):
    """
    Convert from Z3 to python float values.
    """
    return float(r.numerator_as_long()) / float(r.denominator_as_long())


def get_value(r):
    # https://stackoverflow.com/questions/12598408/z3-python-getting-python-values-from-model/12600208
    """
    Convert from Z3 to python values.
    """
    if z3.is_true(r):
        return z3.is_true(r)
    elif z3.is_false(r):
        return z3.is_false(r)
    elif z3.is_int_value(r):
        return r.as_long()
    elif z3.is_algebraic_value(r):
        return round(num(r.approx(15)), 10)
    elif z3.is_rational_value(r):
        return r.as_decimal(20)
    elif r is None:
        None
    else:
        return num(r)


"""
Below are a list of constraints that dictate which
path is taken during actual program execution.
We process KLEE constraints and simplify them to get these
constraints.
"""

# pwd = os.path.dirname(__file__)
# if not os.path.isdir(os.path.join(pwd, "inputs")):
#     os.mkdir(os.path.join(pwd, "inputs"))

# inputFilePath = os.path.join(pwd, "inputs")

z3.set_option(
    precision=10,
    rational_to_decimal=True,
    max_args=10000000,
    max_lines=10000000,
    max_depth=10000000,
    max_visited=10000000,
)

z3.set_param("smt.random_seed", int(time.time()))


def genConstraintsOverRange(model, pivot_trace, arr, start, end):

    z3.set_param("smt.random_seed", int(time.time()))

    solver = z3.Solver()

    for i in range(len(arr)):
        solver.add(arr[i] == model[arr[i]])

    pivot = z3.Int("pivot")
    pivot_index = z3.Int("pivot_index")

    left_sum = z3.Int("left_sum")
    right_sum = z3.Int("right_sum")

    k = end - start
    left_count = [z3.Int(f"left_{i}") for i in range(len(arr))]
    right_count = [z3.Int(f"right_{i}") for i in range(len(arr))]
    pivot_select = z3.Or([pivot == arr[start + i] for i in range(k)])

    for i in range(k):
        solver.add(z3.If(arr[i + start] < pivot, left_count[i]
                   == 1, left_count[i] == 0))
        solver.add(z3.If(arr[i + start] >= pivot, right_count[i]
                   == 1, right_count[i] == 0))

    solver.add(left_sum == z3.Sum(left_count))
    solver.add(right_sum == z3.Sum(right_count))

    solver.add(pivot_select)
    solver.add(pivot_index == left_sum + 1)
    # solver.add(left_sum == right_sum)

    print(solver.check())
    mode_new = solver.model()

    print(f"Arr : {[mode_new[arr[start + i]] for i in range(k)]}")
    print(f"Pivot Index: {mode_new[pivot_index]}")
    print(f"Pivot : {mode_new[pivot]}")
    print(f"Left : {mode_new[left_sum]}")
    print(f"Right : {mode_new[right_sum]}")
    return mode_new[pivot_index]


def generateCandidates(k=20):
    optpath = z3.Optimize()
    # COMMENT : Supply the timeout in minute value.
    # optpath.set("timeout", 60000 * int(sys.argv[4]))
    z3.set_param("smt.random_seed", int(time.time()))

    pivot = z3.Int("pivot")
    pivot_index = z3.Int("pivot_index")
    pivot_trace = [z3.Int(f"pvot_{i}") for i in range(k)]
    left_sum = z3.Int("left_sum")
    right_sum = z3.Int("right_sum")

    left_count = [z3.Int(f"left_{i}") for i in range(k)]
    right_count = [z3.Int(f"right_{i}") for i in range(k)]

    arr = [z3.Int(f"arr_{i}") for i in range(k)]
    pivot_select = z3.Or([pivot == arr[i] for i in range(k)])
    range_constraint = [z3.And(arr[i] > 0, arr[i] < 100000) for i in range(k)]

    optpath.add(z3.Distinct(arr))
    optpath.add(pivot_select)
    optpath.add(range_constraint)

    for i in range(k):
        optpath.add(z3.If(arr[i] < pivot, left_count[i]
                    == 1, left_count[i] == 0))
        optpath.add(z3.If(arr[i] >= pivot, right_count[i]
                    == 1, right_count[i] == 0))
        optpath.add(
            z3.If(pivot_index == i, pivot_trace[i] == 1, pivot_trace[i] == 0))

    optpath.add(left_sum == z3.Sum(left_count))
    optpath.add(right_sum == z3.Sum(right_count))

    optpath.add(pivot_index == left_sum + 1)

    optpath.add(left_sum == right_sum)

    print(optpath.check())
    m = optpath.model()

    print(f"Arr : {[m[arr[i]] for i in range(k)]}")
    print(f"Pivot : {m[pivot_index]}")

    index = get_value(m[pivot_index])

    # for elem in model_dict.items():
    #     print(elem)

    # with open(sys.argv[5], mode="w") as file:
    #     json.dump(model_dict, file, indent=2)

    genConstraintsOverRange(m, pivot_trace, arr,
                            0, index)

    genConstraintsOverRange(m, pivot_trace, arr,
                            index, len(arr))

    genConstraintsOverRange(m, pivot_trace, arr,
                            0, round(index/2))

    genConstraintsOverRange(m, pivot_trace, arr,
                            round(index/2), index)

    genConstraintsOverRange(m, pivot_trace, arr,
                            index, index + round(index/2))

    genConstraintsOverRange(m, pivot_trace, arr,
                            index + round(index/2), len(arr))


if __name__ == "__main__":
    # k : models needed in sum term, n : iterations (n-coin flips), prob : probability value.
    generateCandidates()
