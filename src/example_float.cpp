// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include <PSE.h>
#include <assert.h>
#include <stdio.h>

int main() {

  /* This example doesn't work for KLEE. KLEE Float */
  // KLEE: WARNING ONCE: silently concretizing (reason: floating point)
  // expression (ReadLSB w32 0 a_sym) to value 0 (src/example_float.cpp:19)

  int a;
  int b;
  klee_make_symbolic(&a, sizeof(a), "a_sym");
  klee_make_symbolic(&b, sizeof(b), "b_sym");

  if (a > 0.754 * 125) {
    a = a + 2.5;
  } else {
    b = b - 7;
  }

  return 0;
}