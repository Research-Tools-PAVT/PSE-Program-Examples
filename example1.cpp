// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

int main(void)
{
    int a, b, c, d, e, win, win_ones = 0, win_zeros = 0;

    // forall variable
    klee_make_symbolic(&a, sizeof(a), "a_sym"); // [0, 1]
    klee_make_symbolic(&c, sizeof(b), "c_sym"); // [1, 10]
    klee_make_symbolic(&d, sizeof(c), "d_sym"); // [-5, 5]

    // PSE variable
    make_pse_symbolic<int>(&b, sizeof(b), "b_prob_sym", 0, 1);
    make_pse_symbolic<int>(&e, sizeof(e), "e_prob_sym", 1, 6);

    // // PSE variable : Random Sampling
    // std::default_random_engine generator;
    // std::uniform_int_distribution<int> distribution1(0, 1);
    // std::uniform_int_distribution<int> distribution1(1, 6);

    if (a > b)
    {
        if (c + e > 14) // 14 may need tweaking to discover Bug
        {
            win = 1;
            win_ones++;
        }
        else
        {
            win = 0;
            win_zeros++;
        }
    }
    else
    {
        if (d + e < 0) // 0 may need tweaking to discover Bug
        {
            win = 1;
            win_ones++;
        }
        else
        {
            win = 0;
            win_zeros++;
        }
    }

    assert(win == 1);
    // COMMENT : assert(P(win == 1) > 0.5);
    // COMMENT : Bug only when c >= 9 and d == 5
    return 0;
}