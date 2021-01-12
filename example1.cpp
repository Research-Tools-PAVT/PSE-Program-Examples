// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <klee/klee.h>
#include <algorithm>
#include <string>
#include <vector>
#include <stdio.h>
#include "PSE.h"

int main(void)
{
    int c, a, b, d;
    std::vector<int> dist1 = {5, 6, 7, 8, 9};
    std::vector<int> dist2 = {1, 2, 3, 4, 5, 6};

    klee_make_symbolic(&b, sizeof(b), "b_sym");
    make_pse_symbolic(&c, sizeof(c), "c_sym", dist1);
    make_pse_symbolic(&d, sizeof(d), "d_sym", dist2);

    if (a > b && c > d)
    {
        c = a * b;
    }
    else
    {
        d = a + b;
    }

    return 0;
}