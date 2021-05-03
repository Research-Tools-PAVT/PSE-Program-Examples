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
    int i, mean, stddev;

    make_pse_symbolic(&prob, sizeof(prob), "prob_sym", 0, 1);
    klee_make_symbolic(&i, sizeof(i), "i_sym");

    prob = 0.35;
    mean = 75;
    stddev = 25;
    i = 0;

    std::default_random_engine generator;
    std::normal_distribution<double> gaussian_distribution(mean, stddev);
    std::uniform_int_distribution<int> int_distribution(100, 1000);

    for (i = 0; i < 100; i++)
    {
        if (i % 2)
        {
            int d, trials;

            std::string name("d_binom_");
            name += std::to_string(i);
            name += "_sym";

            std::string trial_sym("trial_");
            trial_sym += std::to_string(i);
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
            int d;
            std::string name("d_gauss_");
            name += std::to_string(i);
            name += "_sym";

            klee_make_symbolic(&d, sizeof(d), name.c_str());
            d = gaussian_distribution(generator);

            klee_dump_symbolic_details(&d, name.c_str());
        }
    }
    return 0;
}
