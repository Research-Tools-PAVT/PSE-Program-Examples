#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import os
import sys
import random
import math
import json
import z3

recusion_depth = 1


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


def swap(arr, x1, x2):
    arr[x1], arr[x2] = arr[x2], arr[x1]
    return arr


def find_index_pivot(arr, elem):
    for index, item in enumerate(arr):
        if elem == item:
            return index


def quickSortZ3(optimizer, arr, arr_size,
                pivot_vector, start, end, nextPivot):

    if nextPivot >= arr_size - 1:
        return

    print(f"quicksort{start, end}, {nextPivot}")
    nextPivot += 1

    optimizer.add(start >= end)

    z = z3.Int(f'z_{nextPivot}')
    x = z3.Int(f'x_{nextPivot}')

    # x = random.randint(start, end)

    optimizer.add(z3.And(x >= start, x <= end))
    optimizer.add(z3.Exists([x], pivot_vector[nextPivot] == arr[x]))

    # pivot_sum = z3.Int(f"pivot_sum_{nextPivot}")
    # i = z3.Int(f'i_{nextPivot}')
    # s = z3.Int(f's_{nextPivot}')

    # UFsumfunction = z3.Function(
    #     f'sum_function', z3.IntSort(), z3.IntSort())

    # left_counter = z3.Array(
    #     f'left_counter_{nextPivot}', z3.IntSort(), z3.IntSort())

    # optimizer.add(z3.And(s >= start, s <= end))
    # optimizer.add(z3.ForAll([s], z3.And(
    #     left_counter[s] >= 0, left_counter[s] <= 1)))

    # optimizer.add(z3.And(i >= start, i <= end))
    # optimizer.add(z3.ForAll([i], z3.If(arr[i] <= pivot_vector[nextPivot],
    #                                    left_counter[i] == 1,
    #                                    left_counter[i] == 0)))

    # optimizer.add(z3.And(z >= start, z <= end))
    # optimizer.add(z3.ForAll([z], z3.If(z <= x,
    #                                    arr[z] <= pivot_vector[nextPivot],
    #                                    arr[z] > pivot_vector[nextPivot])))

    quickSortZ3(optimizer, arr, arr_size,
                pivot_vector, start, x - 1, nextPivot)

    quickSortZ3(optimizer, arr, arr_size,
                pivot_vector, x + 1, end, nextPivot)


def generateRandomRuns(models, arr_size):
    z3.set_param("smt.random_seed", int(time.time()))
    optimizer = z3.Solver()

    y = z3.Int('y')
    arr = z3.Array('arr', z3.IntSort(), z3.IntSort())
    optimizer.add(z3.ForAll([y], z3.And(arr[y] > 0, arr[y] < 10000000)))

    pivot_vectors = [[z3.Int(f'pvot_{j}_{i}')
                      for i in range(arr_size)] for j in range(models)]

    for i in range(models):
        for j in range(models):
            if i > j:
                optimizer.add(
                    z3.Not(
                        z3.And(
                            [
                                (pivot_vectors[i][k] == pivot_vectors[j][k])
                                for k in range(arr_size)
                            ]
                        )
                    )
                )
            else:
                break

    for k in range(models):
        print(f"\t\tCandidate : {k}")
        quickSortZ3(optimizer, arr, arr_size,
                    pivot_vectors[k], 0, arr_size - 1, -1)

    print(optimizer.assertions())
    print(optimizer.check())
    model_found = optimizer.model()

    for x in model_found.decls():
        print(x, model_found[x])


if __name__ == "__main__":
    z3.set_option(
        precision=10,
        rational_to_decimal=True,
        max_args=10000000,
        max_lines=10000000,
        max_depth=10000000,
        max_visited=10000000,
    )
    z3.set_param("smt.random_seed", int(time.time()))

    if len(sys.argv) >= 3:
        models_parameter = sys.argv[1]
        arr_size_parameter = sys.argv[2]
        generateRandomRuns(models=int(models_parameter),
                           arr_size=int(arr_size_parameter))
    else:
        generateRandomRuns(models=3, arr_size=5)
