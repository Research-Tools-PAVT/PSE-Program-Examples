# -*- coding: utf-8 -*-

import z3
import os

"""
Below are a list of constraints that dictate which 
path is taken during actual program execution. 
We process KLEE constraints and simplify them to get these 
constraints. 
"""

# ==== Will be Autogenerated by PyKLEE ====
car_door_pse_sym, door_switch_pse_sym, choice_pse_sym = z3.Ints(
    "car_door_pse_sym door_switch_pse_sym choice_pse_sym")

path1 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
    z3.Not(z3.Not(door_switch_pse_sym == 0))
]

path2 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
    z3.Not(door_switch_pse_sym == 0),
    z3.Not(choice_pse_sym == 1)
]

path3 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
    z3.Not(door_switch_pse_sym == 0),
    choice_pse_sym == 1
]

path4 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
    z3.Not(door_switch_pse_sym == 0),
    z3.Not(choice_pse_sym == 1)
]

path5 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(z3.Not(door_switch_pse_sym == 0)),
    choice_pse_sym == car_door_pse_sym
]

path6 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(z3.Not(door_switch_pse_sym == 0)),
    z3.Not(choice_pse_sym == car_door_pse_sym)
]

path7 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
    z3.Not(z3.Not(door_switch_pse_sym == 0)),
    choice_pse_sym == car_door_pse_sym
]

path8 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
    z3.Not(z3.Not(door_switch_pse_sym == 0)),
    z3.Not(choice_pse_sym == car_door_pse_sym)
]

path9 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(door_switch_pse_sym == 0),
    choice_pse_sym == 2,
    car_door_pse_sym == 3
]

path10 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(door_switch_pse_sym == 0),
    choice_pse_sym == 2,
    z3.Not(car_door_pse_sym == 3)
]

path11 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(door_switch_pse_sym == 0),
    z3.Not(choice_pse_sym == 2),
    car_door_pse_sym == 2
]

path12 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
    z3.Not(door_switch_pse_sym == 0),
    z3.Not(choice_pse_sym == 2),
    z3.Not(car_door_pse_sym == 2)
]

path13 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
    z3.Not(door_switch_pse_sym == 0),
    choice_pse_sym == 1,
    car_door_pse_sym == 3
]

path14 = [
    (0 <= door_switch_pse_sym),
    (door_switch_pse_sym <= 1),
    (0 <= choice_pse_sym),
    (choice_pse_sym <= 3),
    (0 <= car_door_pse_sym),
    (car_door_pse_sym <= 3),
    z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
    z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
    z3.Not(door_switch_pse_sym == 0),
    choice_pse_sym == 1,
    z3.Not(car_door_pse_sym == 3)
]


paths = [path1, path2, path3, path4, path5, path6, path7,
         path8, path9, path10, path11, path12, path13, path14]


# ==== Will be Autogenerated by PyKLEE ====


# ==== Automatically added By Query Parse ====
class ProbQueryObject:
    """
    This object is responsible for storing the query proposed by the user
    The user may specify as a comment in the C/C++ code used to symbex via KLEE
    """

    def __init__(self, objective, objectiveType):
        self.objective = objective
        self.type = objectiveType
        self.predicates = []
        # self.eval = eval(self.objective)

    def __repr__(self):
        pass

    def __str__(self):
        pass

    def __index__(self, index):
        return self.predicates[index]

    def __getitem__(self, key):
        pass

    def getObjective(self):
        return self.objective

    def typeObjective(self):
        return self.type

    def processObjective(self):
        # process objective & return each predicate
        return self.predicates


# Will automate this more later on.


class Optimizer:
    def __init__(self):
        self.constraints = []
        self.optimizerObj = z3.Optimize()

    def printModel(self):
        pass

    def printConstraints(self):
        pass

    def __str__(self):
        pass

    def __index__(self, index):
        return self.constraints[index]

    def negateModel(self):
        pass

    def checkModel(self):
        pass

    def addConstraint(self, constraint):
        self.constraints.append(constraint)
        return self.optimizerObj.check()


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

        n = 0
        # TODO : Automate it later get MODELs.
        while optpath.check() == z3.sat and n != k:

            m = optpath.model()
            n += 1

            # TODO : Automate it later.
            # See Model Values
            with open(
                os.path.join(inputFilePath, f"model_{index}_{n}.txt"), mode="w"
            ) as fileptr:
                fileptr.write(f"{m[door_switch_pse_sym]}\n")
                # fileptr.write(f"{m[car_door_pse_sym]}\n")
                # fileptr.write(f"{m[door_switch_pse_sym]}\n")

            print(f"\tModel : {n}")
            print("\t\t%s = %s" % (choice_pse_sym, m[choice_pse_sym]))
            print("\t\t%s = %s" % (car_door_pse_sym, m[car_door_pse_sym]))
            print("\t\t%s = %s" %
                  (door_switch_pse_sym, m[door_switch_pse_sym]))

            # TODO : Automate it later.
            # Added blocking clauses.
            # optpath.add(a != m[a])
            optpath.add(door_switch_pse_sym != m[door_switch_pse_sym])
            # optpath.add(d != m[d])


if __name__ == "__main__":
    generateCandidates(2)
