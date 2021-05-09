/**
 * @file benchmark01.cpp
 * @author PSE Project
 * @brief Benchmark Example from PRINSYS (ex8)
 * @version 0.1
 * @date 2021-05-07
 * 
 * 
 *  assert(P((x - (prob) * (1 / 2) * n * (n + 1) - (1 - prob) * (n * y)) >= 0) > 0.5)
 *  E[x] = prob * (1/2) * n * (n + 1) + (1 − prob) * n * y
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

int main()
{
    double prob;
    int x = 0;
    int n, y, k = 0;

    // forall variables
    klee_make_symbolic(&y, sizeof(y), "y_sym");
    klee_make_symbolic(&n, sizeof(n), "n_sym");
    make_pse_symbolic(&prob, sizeof(prob), "prob_sym", 0, 1);
    klee_assume(y >= 10);
    klee_assume(0 < n && n <= 10);

    // Work around for silent concretization of prob.
    prob = 0.5;

    // Prob Sym Variables.
    klee_make_symbolic(&x, sizeof(x), "x_pse_sym");

    x = 0;
    std::default_random_engine generator;
    std::bernoulli_distribution bernoulli_rvs(prob);

    while (k < n)
    {
        int d;

        std::string d_symbolic("d_pse_");
        d_symbolic += std::to_string(k);
        d_symbolic += "_sym";

        std::string x_symbolic("x_pse_");
        x_symbolic += std::to_string(k);
        x_symbolic += "_sym";

        std::string k_symbolic("k_");
        k_symbolic += std::to_string(k);
        k_symbolic += "_sym";

        klee_make_symbolic(&d, sizeof(d), d_symbolic.c_str());

        // d = bernoulli_rvs(generator);

        if (d)
        {
            x = x + k;
        }
        else
        {
            x = x + y;
        }

        klee_dump_symbolic_details(&k, k_symbolic.c_str());
        klee_dump_symbolic_details(&d, d_symbolic.c_str());
        klee_dump_symbolic_details(&x, x_symbolic.c_str());

        k = k + 1;
    }

    return 0;
}

/**
 *  assert(P((x - (prob) * (1 / 2) * n * (n + 1) - (1 - prob) * (n * y)) >= 0) > 0.5)
 *  E[x] = prob * (1/2) * n * (n + 1) + (1 − prob) * n * y
 *  prob, n & y are foralls
 *  x is not a forall. 
*/