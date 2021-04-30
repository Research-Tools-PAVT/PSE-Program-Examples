// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <random>
#include <vector>
#include "PSE.h"

int main()
{
    double prob = 0.5;
    int x, n, y;

    // forall variables
    klee_make_symbolic(&y, sizeof(y), "y_sym");
    klee_make_symbolic(&n, sizeof(n), "n_sym");
    make_pse_symbolic(&prob, sizeof(prob), "prob_sym", 0, 1);
    klee_assume(y >= 0);
    klee_assume(1 <= n && n <= 10);

    // Work around for silent concretization of prob.
    prob = 0.5;

    // Prob Sym Variables.
    make_pse_symbolic(&x, sizeof(x), "x_pse_sym", 0, 2147483647);

    std::default_random_engine generator;
    std::bernoulli_distribution bernoulli_rvs(prob);

    while (n > 0)
    {
        int d = bernoulli_rvs(generator);
        if (d)
        {
            klee_assume(d == 1);
            x = x + y;
            klee_dump_symbolic_details(&d, "d_loop");
            klee_dump_symbolic_details(&x, "x_loop");
        }
        n = n - 1;
    }
    return 0;
}

/**
 * assert(Prob(x - prob * n * y <= 0) <= 0.6)
 * E(x) <= prob * n * y 
 * prob, n & y are foralls
 * x is not a forall. 
*/