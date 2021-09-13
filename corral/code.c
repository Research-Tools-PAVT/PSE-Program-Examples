#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

float getProbValueOnePath(int n, int y, float prob, int *sum) {
  int flips_needed = n;
  for (int i = 0; i < flips_needed; i++) {
  }
  return 0.019f;
}

int main(void) {

  // BMC will produce only one path unlike
  // multiple paths that KLEE (SymbEx produces)
  int n = __VERIFIER_nondet_uint() % 50, y = __VERIFIER_nondet_uint(), sum = 0;
  float prob_weight = 0.80f, sum_prob = 0.00f, prob = __VERIFIER_nondet_float();

  __ESBMC_assume(prob > 0.00000f);
  __ESBMC_assume(prob <= 1.0f);

  while (sum_prob <= prob_weight * prob) {
    sum_prob += getProbValueOnePath(n, y, prob, &sum);
    printf("Sum Prob : %lf\n", sum_prob);
  }

  // BMC tries to fail this.
  __ESBMC_assert(n * prob <= 100 * sum_prob, "Failed End Assert");
  return 0;
}