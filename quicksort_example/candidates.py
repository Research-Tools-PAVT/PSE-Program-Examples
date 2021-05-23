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

def generateCandidates(k=20):
    optpath = z3.Optimize()
    # COMMENT : Supply the timeout in minute value.
    # optpath.set("timeout", 60000 * int(sys.argv[4]))

    pivot = z3.Int("pivot")
    pivot_index = z3.Int("pivot_index")
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
        optpath.add(z3.If(arr[i] <= pivot, left_count[i] == 1, left_count[i] == 0))
        optpath.add(z3.If(arr[i] > pivot, right_count[i] == 1, right_count[i] == 0))

    optpath.add(left_sum == z3.Sum(left_count))
    optpath.add(right_sum == z3.Sum(right_count))

    for i in range(k):
        optpath.add(z3.If(arr[i] == pivot, pivot_index == i, pivot_index == 0))

    # optpath.add(pivot_index != 0)
    optpath.add(left_sum == right_sum)

    print(optpath.check())
    m = optpath.model()

    print(m)
    # for elem in model_dict.items():
    #     print(elem)

    # with open(sys.argv[5], mode="w") as file:
    #     json.dump(model_dict, file, indent=2)

    # z = 0
    # while z != 1000 and optpath.check() == z3.sat:
    #     # for i in range(10) :
    #     #     optpath.add(arr[i] == m[arr[i]])
        
    #     optpath.add(pivot != m[pivot])
    #     optpath.add(left_sum != m[left_sum])
    #     # optpath.add(right_sum != m[right_sum])

    #     left_count = [z3.Int(f"left_{i}") for i in range(k)]
    #     right_count = [z3.Int(f"right_{i}") for i in range(k)]

    #     for i in range(k):
    #         optpath.add(z3.If(arr[i] <= pivot, left_count[i] == 1, left_count[i] == 0))
    #         optpath.add(z3.If(arr[i] > pivot, right_count[i] == 1, right_count[i] == 0))
        
    #     optpath.add(left_sum == z3.Sum(left_count))
    #     optpath.add(right_sum == z3.Sum(right_count))
        
    #     print(optpath.check())
    #     m = optpath.model()
    #     print(m)
    #     z += 1

if __name__ == "__main__":
    # k : models needed in sum term, n : iterations (n-coin flips), prob : probability value.
    generateCandidates()