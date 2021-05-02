# -*- coding: utf-8 -*-

import z3
import os
import sys

# https://z3prover.github.io/api/html/classz3py_1_1_rat_num_ref.html#a1012d6314d35530c58f9c018269ec867
def num(r):
    """
    Convert from Z3 to python float values.
    """
    return float(r.numerator_as_long()) / float(r.denominator_as_long())


def get_value(r):
    """
    Convert from Z3 to python values.
    """
    if z3.is_int_value(r):
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

# ==== Will be Autogenerated by PyKLEE ====
n_sym, y_sym = z3.Ints("n_sym y_sym")
prob_sym = z3.Real("prob_sym")

path1 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    z3.Not((1 < n_sym)),
]

path2 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    z3.Not((2 < n_sym)),
]

path3 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    z3.Not((3 < n_sym)),
]

path4 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    z3.Not((4 < n_sym)),
]

path5 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    z3.Not((5 < n_sym)),
]

path6 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    z3.Not((6 < n_sym)),
]

path7 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    z3.Not((7 < n_sym)),
]

path8 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    z3.Not((8 < n_sym)),
]

path9 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    (8 < n_sym),
    (9 < n_sym),
]

path10 = [
    (1 <= n_sym),
    (5 <= y_sym),
    (y_sym <= 100000),
    (0.00000001 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    (8 < n_sym),
    z3.Not((9 < n_sym)),
]


paths = [path1, path2, path3, path4, path5, path6, path7, path8, path9, path10]

# prob == 0.5 during SE.

OPTIMIZE_ARR = [
    1 * y_sym - prob_sym * n_sym * y_sym,  # d == 1
    2 * y_sym - prob_sym * n_sym * y_sym,  # d == 1
    3 * y_sym - prob_sym * n_sym * y_sym,  # d == 0
    3 * y_sym - prob_sym * n_sym * y_sym,  # d == 0
    3 * y_sym - prob_sym * n_sym * y_sym,  # d == 0
    3 * y_sym - prob_sym * n_sym * y_sym,  # d == 1
    4 * y_sym - prob_sym * n_sym * y_sym,  # d == 0
    4 * y_sym - prob_sym * n_sym * y_sym,  # d == 1
    5 * y_sym - prob_sym * n_sym * y_sym,  # d == 1
    6 * y_sym - prob_sym * n_sym * y_sym,  # d == 0
]

# ==== Will be Autogenerated by PyKLEE ====


pwd = os.path.dirname(__file__)
if not os.path.isdir(os.path.join(pwd, "inputs")):
    os.mkdir(os.path.join(pwd, "inputs"))

inputFilePath = os.path.join(pwd, "inputs")


def generateCandidates(k: int):
    for index, path in enumerate(paths):

        print(f"Path {index + 1} : {path}")
        optpath = z3.Optimize()
        optpath.set("timeout", 5000)
        z3.set_option(
            precision=15,
            rational_to_decimal=True,
            max_args=10000000,
            max_lines=1000000,
            max_depth=10000000,
            max_visited=1000000,
        )
        # z3.set_option(precision=30)

        # This will get automated later to parse query
        # and retrieve directly from ProbQueryObject
        # COMMENT : Need to discuss the query constraints for this program.

        # Add the constraints and get candidate model from z3.
        for conds in path:
            optpath.add(conds)

        # COMMENT : Need to frame this optimization properly. How to automate it?
        optpath.minimize(OPTIMIZE_ARR[index])

        n = 0
        # TODO : Automate it later get MODELs.
        # (optpath.check() == z3.sat or optpath.check == z3.unknown)
        while n != k:

            print(optpath.check())
            m = optpath.model()
            # print(m)
            print(f"\tModel : {n + 1}")
            print("\t\t%s = %s" % (n_sym, get_value(m[n_sym])))
            print("\t\t%s = %s" % (y_sym, get_value(m[y_sym])))
            print("\t\t%s = %s" % (prob_sym, get_value(m[prob_sym])))

            with open(
                os.path.join(inputFilePath, f"model_{index}_{n}.txt"), mode="w"
            ) as fileptr:
                fileptr.write(f"{get_value(m[n_sym])}\n")
                fileptr.write(f"{get_value(m[y_sym])}\n")
                fileptr.write(f"{get_value(m[prob_sym])}\n")

            n += 1

            # TODO : Automate it later.
            # Added blocking clauses.
            # optpath.add(n_sym != m[n_sym])
            optpath.add(y_sym > m[y_sym] + 1)
            optpath.add(prob_sym != m[prob_sym])


if __name__ == "__main__":
    generateCandidates(int(sys.argv[1]))
