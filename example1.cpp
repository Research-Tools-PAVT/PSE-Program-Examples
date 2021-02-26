// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"

int main(void)
{
    int a = 53, d;

    // forall variable
    klee_make_symbolic(&a, sizeof(a), "a_sym");

    // PSE variable
    make_pse_symbolic<int>(&d, sizeof(d), "d_prob_sym", 0, 650);

    int c = a + 100;

    // case 1
    if (a > 50)
    {
        c = a + 75;
    }
    else
    {
        c = a - 75;
    }

    // case 2
    if (d > 60)
        d = 250;

    // case 3 -> Complex Case
    if (c > d)
        c = d;

    return 0;
}