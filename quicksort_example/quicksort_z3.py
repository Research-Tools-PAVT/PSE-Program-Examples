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


def generateRandomRuns(models, arr_size):
    z3.set_param("smt.random_seed", int(time.time()))
    optimizer = z3.Solver()

    y = z3.Int('y')
    arr = z3.Array('arr', z3.IntSort(), z3.IntSort())

    optimizer.add(z3.And(y >= 0, y <= arr_size))
    optimizer.add(z3.ForAll([y], z3.And(arr[y] > 0, arr[y] < 10000000)))

    pivot_vector = [z3.Int(f'pvot_{i}')
                    for i in range(arr_size)]

    # sum_array = [z3.Int(f'sums_{i}')
    #              for i in range(arr_size)]

    left_counter = [[z3.Int(f'leftcounts_{i}_{j}')
                    for i in range(arr_size)] for j in range(arr_size)]

    optimizer.add(z3.Distinct(pivot_vector))

    for k in range(arr_size):
        x = z3.Int(f'x_sym_{k}')
        outcome = z3.Int(f'outcome_{k}')
        sums = z3.Int(f'left_sums_{k}')

        optimizer.add(z3.And(x >= k, x <= arr_size))
        optimizer.add(z3.Exists([x], pivot_vector[k] == arr[x]))

        for i in range(arr_size):
            optimizer.add(z3.If(arr[i] <= pivot_vector[k],
                                left_counter[k][i] == 1,
                                left_counter[k][i] == 0))

        optimizer.add(z3.If(sums > arr_size - x, outcome ==
                            sums, outcome == arr_size - x))

        optimizer.add(sums == z3.Sum(left_counter[k]))

    # print(optimizer.assertions())
    print(optimizer.check())
    model_found = optimizer.model()

    print(model_found)

    print(
        f'pvot_vec = {[model_found[pivot_vector[i]] for i in range(arr_size)]}')


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
