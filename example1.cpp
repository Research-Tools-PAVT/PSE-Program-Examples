// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

int main(void)
{
    int a, b, c, d;

    // forall variable
    klee_make_symbolic(&a, sizeof(a), "a_sym");
    klee_make_symbolic(&b, sizeof(b), "b_sym");
    klee_make_symbolic(&c, sizeof(c), "c_sym");

    // PSE variable
    make_pse_symbolic<int>(&d, sizeof(d), "d_prob_sym", 0, 500);

    // PSE variable : Random Sampling
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution(0, 500);

    if (a + b > c + d)
    {
        if (a > b)
        {
            a = 100;
            b = 500;
        }
        else
        {
            a = 500;
            b = 100;
        }
    }
    else
    {
        if (c > d)
        {
            a = 100;
            c = 100;
            b = 600;
            d = distribution(generator);
        }
        else
        {
            a = 600;
            c = 600;
            b = 100;
            d = distribution(generator);
        }
    }

    if (a + c > b + d)
    {
        a = 200;
        b = -150;
        c = -20;
        d = distribution(generator);
    }

    // assert(a + b + c + d <= 1100);

    // Query Parse : P(a + b + c + d <= 1100) >= 0.5
    // Query : assert fails atleast half of the times.

    // Query Parse : P(a + b + c + d <= 1100) <= 0.5
    // Query : assert fails atmost half of the times.

    // Query Parse : P(a + b + c + d <= 1100) == 0.5
    // Query : assert fails exactly half of the times.
    return 0;
}