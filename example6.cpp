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
    double prob;
    int n, d, trials, k, mean, stddev;

    make_pse_symbolic(&prob, sizeof(prob), "prob_sym", 0, 1);
    klee_make_symbolic(&n, sizeof(n), "n_sym");
    klee_assume(1 <= n && n <= 20);

    prob = 0.5;
    mean = 75;
    stddev = 25;

    std::default_random_engine generator;
    std::normal_distribution<double> gaussian_distribution(mean, stddev);
    std::uniform_int_distribution<int> int_distribution(500, 1000);

    k = 0;
    while (k < n)
    {
        if (k % 2) // This must not fork.
        {
            // int d, trials;
            std::string name("d_binom_");
            name += std::to_string(k);
            name += "_sym";

            std::string trial_sym("trial_");
            trial_sym += std::to_string(k);
            trial_sym += "_sym";

            klee_make_symbolic(&d, sizeof(d), name.c_str());

            trials = int_distribution(generator);
            std::binomial_distribution<int> binom_distribution(trials, prob);
            d = binom_distribution(generator);

            klee_dump_symbolic_details(&d, name.c_str());
            klee_dump_symbolic_details(&trials, trial_sym.c_str());
        }
        else
        {
            // int d;
            std::string name("d_gauss_");
            name += std::to_string(k);
            name += "_sym";

            klee_make_symbolic(&d, sizeof(d), name.c_str());
            d = gaussian_distribution(generator);

            klee_dump_symbolic_details(&d, name.c_str());
        }
        k = k + 1;
    }
    return 0;
}
