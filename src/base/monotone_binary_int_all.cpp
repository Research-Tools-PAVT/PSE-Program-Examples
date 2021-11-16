// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include <PSE.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

// Max 23 w/ 10 minute timeout
#define N 23
size_t monotone_check(int *f) {
  int last = f[0];
  size_t count = 0;
  for (size_t i = 1; i < N; i++) {
    if (last > f[i]) {
      count++;
    }
    last = f[i];
  }
  return count;
}

int main() {
  int f[N];
  for (int i = 0; i < N; i++) {
    int temp;
    std::string name = "fsym" + std::to_string(i);
    klee_make_symbolic(&temp, sizeof(temp), name.c_str());
    f[i] = temp;
  }
  //  klee_make_symbolic(&f, sizeof(f), "f");
  size_t x;
  klee_make_symbolic(&x, sizeof(x), "x");
  klee_assume(x >= 0);
  klee_assume(x < N);
  klee_assume(monotone_check(f) == x);

  int l = (int)ceil(log2(N - 1));
  int a = 0, i, b = N - 1;
  make_pse_symbolic(&i, sizeof(i), "i", (int)0, (int)(N - 1));

  bool reject = false;

  for (int t = 0; t < l; t++) {
    int p = (int)ceil((double(a + b)) / (double)2.0);
    if (i <= p) {
      if (f[i] > f[p]) {
        reject = true;
      }
      b = p;
    } else {
      if (f[i] < f[p]) {
        reject = true;
      }
      a = p + 1;
    }
  }

  if (!reject) {
    mark_state_winning();
    klee_dump_kquery_state();
  }

  return 0;
}