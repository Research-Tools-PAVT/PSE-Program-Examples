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

long long int termCount = 100000;

int main() {
  long double prob = 0.500;
  int x = 0, n = 10, y = 10, n_start, y_start;
  long long unsigned int win = 0, loop_run = 0, prob_runs = 0;

  scanf("%d", &n);
  scanf("%d", &y);
  scanf("%Lf", &prob);

  n_start = n;
  y_start = y;

  while (termCount--) {
    x = 0;
    int n_loop = n;

    // program execution
    std::default_random_engine generator;
    std::bernoulli_distribution bernoulli_rvs(prob);

    while (n_loop > 0) {
      int d = bernoulli_rvs(generator);
      if (d) {
        x = x + n_loop;
      } else {
        x = x + y;
      }
      n_loop -= 1;

      // Iterations of the loop.
      prob_runs++;
    }

    // Sample for probability. This is the assert condition.
    if ((x - (prob) * (1 / 2) * n * (n + 1) - (1 - prob) * (n * y)) >= 0)
      win++;

    // No. of times the program gets executed.
    loop_run++;
  }

  auto pwin = (double)win / loop_run;
  fprintf(stdout,
          "P((x - (prob) * (1 / 2) * n * (n + 1) - (1 - prob) * (n * y)) >= 0) "
          ": %.10lf\n\n",
          pwin);
  if (n_start != 0)
    fprintf(stderr,
            "%.10Lf & %lld & %lld & %lld & %.6lf & %d & %d \\\\ \\hline\n",
            prob, loop_run, prob_runs, win, pwin, n_start, y_start);
  return 0;
}

/**
 *  assert(P((x - (prob) * (1 / 2) * n * (n + 1) - (1 - prob) * (n * y)) >= 0) >
 * 0.5) E[x] = prob * (1/2) * n * (n + 1) + (1 − prob) * n * y prob, n & y are
 * foralls x is not a forall.
 */