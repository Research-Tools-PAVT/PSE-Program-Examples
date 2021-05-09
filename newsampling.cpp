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
    int n, path_prob;
    klee_make_symbolic(&path_prob, sizeof(path_prob), "path_prob_pse_sym");
    klee_make_symbolic(&prob, sizeof(prob), "prob_sym");

    n = 10;
    path_prob = 1;
    int sum = 0, k = 0;
    std::default_random_engine generator;
    std::bernoulli_distribution bernoulli_rvs(prob);

    int prob_value;
    klee_make_symbolic(&prob_value, sizeof(prob_value), "prob_value");

    while (n > 0)
    {
        int d, choice;

        std::string c_symbolic("choice_");
        c_symbolic += std::to_string(k);
        c_symbolic += "_sym";

        std::string d_symbolic("d_pse_");
        d_symbolic += std::to_string(k);
        d_symbolic += "_sym";

        klee_make_symbolic(&d, sizeof(d), d_symbolic.c_str());
        klee_make_symbolic(&choice, sizeof(choice), c_symbolic.c_str());

        (d == 1) ? choice = prob_value : choice = (1 - prob_value);
        path_prob = path_prob * choice;

        klee_dump_symbolic_details(&choice, c_symbolic.c_str());

        sum = sum + d;
        n = n - 1;
        k = k + 1;
    }

    klee_dump_symbolic_details(&path_prob, "weight_path_prob");
    klee_dump_symbolic_details(&sum, "expected_heads");
}
