#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import os
import sys
import random
import math
import json
import z3


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
                pivot_vector, left_counter, start, end, takeNextPivot):

    if takeNextPivot >= arr_size:
        return

    print(f"quicksort{start, end}, {takeNextPivot}")

    optimizer.add(z3.Or([pivot_vector[takeNextPivot] == arr[i]
                         for i in range(arr_size)]))

    i = start
    while(i <= end):
        optimizer.add(
            z3.If(arr[i] <= pivot_vector[takeNextPivot], left_counter[takeNextPivot][i] == 1, left_counter[takeNextPivot][i] == 0))
        i += 1

    takeNextPivot += 1

    quickSortZ3(optimizer, arr, arr_size,
                pivot_vector, left_counter, start, end - takeNextPivot, takeNextPivot)

    # optimizer.add(pvot_point == z3.Sum(pivot_counter))

    # takeNextPivot += 1
    # quickSortZ3(optimizer, arr, arr_size, pivot_vector,
    #             left_counter, right_counter, start, pvot_point - 1,
    #             takeNextPivot)

    # takeNextPivot += 1
    # quickSortZ3(optimizer, arr, arr_size, pivot_vector,
    #             left_counter, right_counter, pvot_point + 1, end,
    #             takeNextPivot)


def generateRandomRuns(models=50, arr_size=10):
    z3.set_param("smt.random_seed", int(time.time()))
    optimizer = z3.Optimize()

    arr = [z3.Int(f'arr_{i}') for i in range(arr_size)]
    optimizer.add(z3.And([arr[i] > 1 for i in range(arr_size)]))
    optimizer.add(z3.Distinct(arr))

    pivot_vectors = [[z3.Int(f'pvot_{i}_{j}')
                      for i in range(arr_size)] for j in range(models)]

    left_counters = [[[z3.Int(f'left_{k}_{i}_{j}')
                      for k in range(arr_size)] for i in range(arr_size)] for j in range(models)]

    # for k in range(models):
    #     for i in range(arr_size):
    #         optimizer.add(
    #             z3.And(pivot_vectors[k][i] >= 0, pivot_vectors[k][i] <= arr_size - 1))

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
        quickSortZ3(optimizer, arr, arr_size,
                    pivot_vectors[k], left_counters[k], 0, arr_size - 1, 0)

    optimizer.check()
    model_found = optimizer.model()

    print(f"Arr : {[model_found[arr[i]] for i in range(arr_size)]}")

    for k in range(models):
        print(
            f"PVOT_{k} : {[model_found[pivot_vectors[k][i]] for i in range(arr_size)]}")
        for j in range(arr_size):
            print(
                f"\tLEFT_{k} : {[model_found[left_counters[k][j][i]] for i in range(arr_size)]}")


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
    generateRandomRuns()
