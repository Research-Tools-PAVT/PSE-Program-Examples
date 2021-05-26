#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import os
import sys
import random
import json
import z3

list_arr = []
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

    range_iter = (end - start) + 1

    arr = [z3.Int(f"arr_{i}") for i in range(forall_elems)]

    pivot = z3.Int('pivot')
    solver.add(z3.Or([pivot == arr[i + start] for i in range(range_iter)]))

    left_sum = z3.Int("left_sum")
    right_sum = z3.Int("right_sum")
    left_count = [z3.Int(f"left_{i}") for i in range(range_iter)]
    right_count = [z3.Int(f"right_{i}") for i in range(range_iter)]

    for i in range(range_iter):
        solver.add(z3.If(arr[i + start] < pivot, left_count[i]
                         == 1, left_count[i] == 0))
        solver.add(z3.If(arr[i + start] >= pivot, right_count[i]
                         == 1, right_count[i] == 0))

    solver.add(left_sum == z3.Sum(left_count))
    solver.add(right_sum == z3.Sum(right_count))

    solver.add(z3.And([arr[i] == temp_arr[i]
                       for i in range(len(temp_arr))]))

    print(solver.check())
    model = solver.model()
    print(find_index_pivot(
        temp_arr, get_value(model[pivot])))

    # index_pivot = random.randint(start, end)

    index_pivot = find_index_pivot(
        temp_arr, get_value(model[pivot]))
    pivot_value = temp_arr[index_pivot]
    temp_arr = swap(temp_arr, -1, index_pivot)

    i = start - 1
    j = start
    while(j <= end - 1):
        if (temp_arr[j] <= pivot_value):
            i += 1
            temp_arr = swap(temp_arr, i, j)
        j += 1

    temp_arr = swap(temp_arr, i + 1, -1)

    print(temp_arr[start:end])

    return index_pivot


def partition_routine(solver, arr, temp_arr, start, end, pivot):

    solver.add(z3.And([arr[i] == temp_arr[i]
                       for i in range(len(temp_arr))]))

    range_iter = (end - start) + 1

    if range_iter <= 0:
        return None, None, None

    left_sum = z3.Int("left_sum")
    right_sum = z3.Int("right_sum")
    left_count = [z3.Int(f"left_{i}") for i in range(range_iter)]
    right_count = [z3.Int(f"right_{i}") for i in range(range_iter)]

    # solver.check()
    # model = solver.model()

    # solver.add(z3.And([arr[i + start] == model[arr[i + start]]
    #            for i in range(range_iter)]))

    solver.add(z3.Or([pivot == arr[i + start] for i in range(range_iter)]))

    for i in range(range_iter):
        solver.add(z3.If(arr[i + start] < pivot, left_count[i]
                         == 1, left_count[i] == 0))
        solver.add(z3.If(arr[i + start] >= pivot, right_count[i]
                         == 1, right_count[i] == 0))

    solver.add(left_sum == z3.Sum(left_count))
    solver.add(right_sum == z3.Sum(right_count))

    if (solver.check() == z3.sat):
        model_before_pop = solver.model()

        index_pivot = find_index_pivot(
            temp_arr, get_value(model_before_pop[pivot]))

        pivot_value = get_value(model_before_pop[pivot])
        print(f"Temp Arr : {temp_arr}")

        temp_arr = swap(temp_arr, -1, index_pivot)

        i = start - 1
        j = start
        print(start)
        while(j <= end - 1):
            print(j)
            if (temp_arr[j] <= pivot_value):
                i += 1
                temp_arr = swap(temp_arr, i, j)
            j += 1

        temp_arr = swap(temp_arr, i + 1, -1)
        return model_before_pop, left_sum, right_sum
    else:
        print("unsat")
        return None, None, None


def quicksort_z3(solver, arr, temp_arr, start, end):

    z3.set_param("smt.random_seed", int(time.time()))

    if end - start <= 0:
        return

    solver.push()
    pivot_index_sort = partition_quicksort(solver, arr, temp_arr, start, end)
    solver.pop()

    print(
        f"Start: {start}, End: {end}, Pivot Index: {pivot_index_sort}")

    quicksort_z3(solver, arr, temp_arr, start, pivot_index_sort - 1)
    quicksort_z3(solver, arr, temp_arr, pivot_index_sort + 1, end)


forall_elems = 7

if __name__ == "__main__":
    solver = z3.Solver()

    arr = [z3.Int(f"arr_{i}") for i in range(forall_elems)]

    # solver.add(z3.And([arr[i] >= 3 for i in range(forall_elems)]))
    # solver.add(z3.And([arr[i] <= 100 for i in range(forall_elems)]))

    # solver.add(z3.Distinct(arr))

    solver.push()
    solver.add(arr[0] == 4)
    solver.add(arr[1] == 12)
    solver.add(arr[2] == 5)
    solver.add(arr[3] == 11)
    solver.add(arr[4] == 16)
    solver.add(arr[5] == 3)
    solver.add(arr[6] == 0)

    solver.check()
    init_model = solver.model()
    temp_arr = [get_value(init_model[arr[i]])
                for i in range(len(arr))]
    solver.pop()

    print(temp_arr)
    quicksort_z3(solver, arr, temp_arr, 0, len(arr) - 1)
    print(temp_arr)
