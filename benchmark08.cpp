/**
 * @file benchmark01.cpp
 * @author PSE Project
 * @brief Benchmark Example from PRINSYS (ex8)
 * @version 0.1
 * @date 2021-05-07
 * 
 * 
 *  assert(P(((x - (prob)(1/2)*n*(n+1) - (1-prob)*(n*y)) >= 0) > 0.5)
 *  E[x] = prob * 1/2 * n * (n + 1) + (1 − prob) * n * y
 */

// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

// def ex8(inpt):
//     x = 0
//     n = 10  # N
//     y = 10  # N
//     prob = inpt[0]
//     while(n > 0):
//         d = bernoulli.rvs(size=1, p=prob)[0]
//         if(d):
//             x = x + n
//         else:
//             x = x + y
//         n = n - 1
//     return x

int main () {
    return 0;
}