// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <random>
#include <vector>
#include "PSE.h"

int unroll = 10000;

int main()
{
    double prob = 0.6;
    int d, z = 0, flip = 0;

    scanf("%f", &prob);

    std::random_device rd{};
    std::mt19937 rng{rd()};

    std::bernoulli_distribution rvs(prob);

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
    }

    return 0;
}