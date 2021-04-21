# -*- coding: utf-8 -*-

import z3
import sys
import os

"""
Below are a list of constraints that dictate which 
path is taken during actual program execution. 
We process KLEE constraints and simplify them to get these 
constraints. 
"""

# ==== Will be Autogenerated by PyKLEE ====

z_sym, flip_pse_sym = z3.Ints("z_sym flip_pse_sym")
prob_sym = z3.Real("prob_sym")

path1 = [
    (flip_pse_sym <= 1),
    (0 <= flip_pse_sym),
    (prob_sym <= 1),
    (0 <= prob_sym),
    (0 <= z_sym),
    flip_pse_sym == 0
]

path2 = [
    (flip_pse_sym <= 1),
    (0 <= flip_pse_sym),
    (prob_sym <= 1),
    (0 <= prob_sym),
    (0 <= z_sym),
    z3.Not(flip_pse_sym == 0)
]

paths = [path1, path2]

# ==== Will be Autogenerated by PyKLEE ====

pwd = os.path.dirname(__file__)
inputFilePath = os.path.join(pwd, "inputs")


def generateCandidates(k: int):
    for index, path in enumerate(paths):

        print(f"Path {index + 1} : {path}")
        optpath = z3.Optimize()

        # This will get automated later to parse query
        # and retrieve directly from ProbQueryObject
        # COMMENT : Need to discuss the query constraints for this program.

        # Add the constraints and get candidate model from z3.
        for conds in path:
            optpath.add(conds)

        # COMMENT : Need to frame this optimization properly
        # optpath.maximize(z_sym * prob_sym - (1 - prob_sym))

        n = 0
        # TODO : Automate it later get MODEL.
        while optpath.check() == z3.sat and n != k:

            m = optpath.model()
            n += 1

            print(f"\tModel : {n}")
            print("\t\t%s = %s" % (flip_pse_sym, m[flip_pse_sym]))
            value_fraction = m[prob_sym].as_fraction()
            value = float((value_fraction.numerator)) / \
                float((value_fraction.denominator))
            print("\t\t%s = %.25f" % (prob_sym, value))

            # TODO : Automate it later.
            # See Model Values
            with open(
                os.path.join(inputFilePath, f"model_{index}_{n}.txt"), mode="w"
            ) as fileptr:
                # fileptr.write(f"{m[flip_pse_sym]}\n")
                fileptr.write(f"{value:.25f}\n")
                # fileptr.write(f"{m[car_door_pse_sym]}\n")
                # fileptr.write(f"{m[door_switch_pse_sym]}\n")

            # TODO : Automate it later.
            # Added blocking clauses.

            # optpath.add(flip_pse_sym != m[flip_pse_sym])
            optpath.add(prob_sym != m[prob_sym])

            # optpath.maximize(z_sym * prob_sym - (1 - prob_sym))


if __name__ == "__main__":
    generateCandidates(int(sys.argv[1]))
