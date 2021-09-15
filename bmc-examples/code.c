#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define FLIPS 10
#define UNROLL 5

int main(void) {

  // Forall Variables
  int y = __VERIFIER_nondet_uint();
  float prob = __VERIFIER_nondet_float();

  // ASSUME : Forall Specific Assumes.
  __ESBMC_assume(prob > 0.0001f);
  __ESBMC_assume(prob <= 1.0f);

  __ESBMC_assume(y > 0);
  __ESBMC_assume(y <= 1000);

  // Program specific variables
  // We need to initalize these values.
  long int expected_sum = 0L, path_index = -1, __path_id = 0L;
  float prob_weight = 0.80f, sum_prob = 0.00f;
  unsigned long long int ptids[UNROLL];

  // Unrolling 100 times atleast.
  while (sum_prob <= prob_weight * prob) {

    // probabilistic paths taken so far.
    // ASSUME : Each "__ptid" must represents a different path.
    path_index += 1;
    float product_prob = 1.00f;
    long int expected_value = 0L;

    // Unrolling FLIPS times always.
    unsigned long long int __ptid = 0LL;
    for (int i = 0; i < FLIPS; i++) {
      int flip = ((double)(nondet_double() / (RAND_MAX))) >= prob ? 1 : 0;
      __ptid += (flip == 1) ? 1 << (63 - i) : 0 << (63 - i);
      product_prob *= (flip == 1) ? prob : 1.00f;
      expected_value += (flip == 1) ? y : 0L;
    }

    // COMMENT : assume(distinct(__ptid));
    ptids[path_index] = __ptid;
    for (int i = 0; i < path_index; i++) {
      __ESBMC_assume(ptids[i] != __ptid);
    }

    // Probability mass accumalated for this run/path.
    sum_prob += product_prob;
    expected_sum += expected_value;
  }

  // End Assert must hold with the optimized values.
  // ASSERT : if (prob <= 0.5) E(x) < 0.4 * n * y
  //            else E(x) >= 0.6 * n * y
  if (prob <= 0.5f) {
    assert(expected_sum < 0.4 * FLIPS * y);
  } else {
    assert(expected_sum >= 0.6 * FLIPS * y);
  }

  return 0;
}