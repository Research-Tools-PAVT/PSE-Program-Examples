// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"

int main(void)
{
  int c, a, b, d;

  klee_make_symbolic(&a, sizeof(a), "a_sym");
  klee_make_symbolic(&b, sizeof(b), "b_sym");
  make_pse_symbolic(&c, sizeof(c), "c_sym", 90, 1200);

  if (a > 0 && c > 0 && c < d && d > a && d > b)
  {
    c = a * b;
  }
  else
  {
    d = a + b;
  }

  if (c > d)
  {
    a = 0;
    b = 0;
  }

  return 0;
}