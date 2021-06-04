// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>
#include <stdio.h>
#include <vector>

int main() {
  double prob = 0.5;
  int d, x, n, y, k = 0;

  // forall variables
  klee_make_symbolic(&y, sizeof(y), "y_sym");
  klee_make_symbolic(&n, sizeof(n), "n_sym");
  make_pse_symbolic(&prob, sizeof(prob), "prob_sym", 0, 1);
  klee_assume(y >= 0);
  klee_assume(1 <= n && n <= 10);

  // Work around for silent concretization of prob.
  prob = 0.5;

  // Prob Sym Variables.
  klee_make_symbolic(&x, sizeof(x), "x_pse_sym");

  x = 0;
  std::default_random_engine generator;
  std::bernoulli_distribution bernoulli_rvs(prob);

  while (k < n) {
    d = bernoulli_rvs(generator);
    klee_dump_symbolic_details(&k, "k_loop");
    klee_dump_symbolic_details(&d, "d_loop");
    if (d) {
      // klee_dump_kquery_state();
      x = x + y;
    }
    klee_dump_symbolic_details(&x, "x_loop");
    k = k + 1;
  }
  return 0;
}

/**
 * assert(Prob(x - prob * n * y <= 0) <= 0.6)
 * E(x) <= prob * n * y
 * prob, n & y are foralls
 * x is not a forall.
 */