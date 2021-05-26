#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import os
import sys
import random
import math
import json
import z3

compare_vector = []
list_arr = []
pivot_vector = []
counter = 0


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


def partition_quicksort(solver, arr, temp_arr, start, end):

    compare = 0
    range_iter = (end - start) + 1

    pivot = z3.Int("pivot")
    solver.add(z3.Or([pivot == temp_arr[i + start] for i in range(range_iter)]))

    solver.check()
    model = solver.model()
    index_pivot = find_index_pivot(temp_arr, get_value(model[pivot]))

    # index_pivot = random.randint(start, end)
    temp_arr = swap(temp_arr, index_pivot, end)

    i = start - 1
    pivot_value = temp_arr[end]

    j = start
    while j <= end - 1:
        compare += 1
        if temp_arr[j] <= pivot_value:
            i += 1
            temp_arr = swap(temp_arr, i, j)
        j += 1

    temp_arr = swap(temp_arr, i + 1, end)
    ypvot = i + 1

    solver.push()

    arr = [z3.Int(f"arr_{i}") for i in range(len(temp_arr))]

    solver.add(
        z3.And(
            [arr[iterator] == temp_arr[iterator] for iterator in range(len(temp_arr))]
        )
    )

    # left_sum = z3.Int("left_sum")
    # right_sum = z3.Int("right_sum")
    # left_count = [z3.Int(f"left_{iterator}") for iterator in range(len(temp_arr))]
    # right_count = [z3.Int(f"right_{iterator}") for iterator in range(len(temp_arr))]

    # iterator = start
    # while iterator <= end - 1:
    #     solver.add(
    #         z3.If(
    #             arr[iterator] <= pivot_value,
    #             left_count[iterator - start] == 1,
    #             left_count[iterator - start] == 0,
    #         )
    #     )
    #     solver.add(
    #         z3.If(
    #             arr[iterator] > pivot_value,
    #             right_count[iterator - start] == 1,
    #             right_count[iterator - start] == 0,
    #         )
    #     )
    #     iterator += 1

    # solver.add(left_sum == z3.Sum(left_count))
    # solver.add(right_sum == z3.Sum(right_count))

    solver.check()
    model = solver.model()

    solver.pop()

    left_side = 0
    right_side = 0
    for h in range(len(temp_arr)):
        if get_value(model[arr[h]]) <= pivot_value:
            left_side += 1
        else:
            right_side += 1

    # COMMENT : Why are the values not matching here ?
    # print(temp_arr[start:end])
    pivot_vector.append((ypvot, left_side - 1, right_side))
    compare_vector.append(compare)

    return ypvot


def quicksort_z3(solver, arr, temp_arr, start, end):

    if start < end:
        solver.push()
        pivot_index_sort = partition_quicksort(solver, arr, temp_arr, start, end)
        solver.pop()
        # print(f"Start: {start}, End: {end}, Pivot Index: {pivot_index_sort}")
        quicksort_z3(solver, arr, temp_arr, start, pivot_index_sort - 1)
        quicksort_z3(solver, arr, temp_arr, pivot_index_sort + 1, end)


forall_elems = 10

if __name__ == "__main__":

    z3.set_param("smt.random_seed", int(time.time()))
    solver = z3.Solver()
    arr = [z3.Int(f"arr_{i}") for i in range(forall_elems)]

    # solver.push()
    # solver.add(z3.And([arr[i] >= 3 for i in range(forall_elems)]))
    # solver.add(z3.And([arr[i] <= 100 for i in range(forall_elems)]))
    # solver.check()
    # init_model = solver.model()
    # temp_arr = [get_value(init_model[arr[i]]) for i in range(len(arr))]
    # solver.add(z3.Distinct(arr))
    # solver.pop()

    solver.push()
    solver.add(arr[0] == 4)
    solver.add(arr[1] == 12)
    solver.add(arr[2] == 5)
    solver.add(arr[3] == 11)
    solver.add(arr[4] == 16)
    solver.add(arr[5] == 3)
    solver.add(arr[6] == 0)
    solver.add(arr[7] == 5)
    solver.add(arr[8] == 18)
    solver.add(arr[9] == 1)
    solver.check()
    init_model = solver.model()
    temp_arr = [get_value(init_model[arr[i]]) for i in range(len(arr))]
    solver.pop()

    print(temp_arr)
    quicksort_z3(solver, arr, temp_arr, 0, len(arr) - 1)
    print(temp_arr)
    print(pivot_vector)
    print(forall_elems * math.log2(forall_elems) - sum(compare_vector))