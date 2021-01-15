// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"

int getmax(int a, int b)
{
    return a > b ? a : b;
}

int main(void)
{
    int a, b, c, d;

    klee_make_symbolic(&a, sizeof(a), "a_sym");
    make_pse_symbolic<int>(&b, sizeof(b), "b_sym", 0, 20);
    make_pse_symbolic<int>(&c, sizeof(c), "c_prob_sym", 0, 800);
    make_pse_symbolic<int>(&d, sizeof(d), "d_prob_sym", 0, 650);

    if (a > b)
    {
        a = c * 2;
        b = d * 2;
    }
    else if (c > d)
    {
        c = a * 3;
        d = b * 3;
    }
    else
    {
        a = getmax(c, d);
        b = getmax(c, b);
    }

    if (a >= 0 && b >= 0)
    {
        c = c + 1;
        d = getmax(a, b);
    }

    if (c > 0)
    {
        b = 0;
    }

    return 0;
}