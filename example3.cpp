// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <vector>
#include "PSE.h"

int main()
{
    int a, x, i;
    klee_make_symbolic(&a, sizeof(a), "a_sym");
    klee_make_symbolic(&x, sizeof(x), "x_sym");
    for (i = 1; i <= 5; i++)
    {
        x = (a > i) ? x + 1 : x + 2;
    }
}
