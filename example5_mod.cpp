// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <random>
#include <vector>
#include "PSE.h"

int unroll = 2500;
long long int termCount = 50000;

int main()
{
    long double prob = 0.00000000001;
    int d, flip = 0, win = 0;
    long long unsigned int z = 0, run = 0, prob_runs = 0;

    while (termCount--)
    {
        flip = 0;
        z = 0;
        scanf("%Lf", &prob);

        std::random_device rd{};
        std::mt19937 rng{rd()};

        std::bernoulli_distribution rvs(prob);

        // fprintf(stderr, "prob : %Lf\n", prob);
        while (flip == 0 && unroll--)
        {
            int d = rvs(rng);
            if (d)
            {
                flip = 1;
            }
            else
            {
                z += 1;
            }
            if (z > ((double)(1 - prob) / (prob)))
                win++;
            run++;
        }
        prob_runs++;
    }

    auto pwin = (double)win / run;
    // printf("P(z > (1-p)/p) : %f\nRuns : %d\n", pwin, run);
    // fprintf(stdout, "prob(p) : %Lf\n", prob);
    // fprintf(stdout, "z : %lld\n(1-p)/p : %Lf\n", z, (double)(1 - prob) / (prob));
    // if ((pwin > 0.00))
    // {
    printf("%f & %lld & %lld", pwin, run, prob_runs);
    fprintf(stdout, " & %0.10Lf", prob);
    fprintf(stdout, " & %lld & %0.10Lf \\\\ \\hline \n", z, (double)(1 - prob) / (prob));
    // }
    return 0;
}