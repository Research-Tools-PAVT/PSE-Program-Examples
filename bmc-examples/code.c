#include <math.h>
#include <stdio.h>

#define FLIPS 10
#define UNROLL 1000

int main(void) {

  // Forall Variables
  int y = nondet_uint();
  // float prob = nondet_float();

  // ASSUME : Forall Specific Assumes.
  float prob = 0.450;

  __ESBMC_assume(y > 0);
  __ESBMC_assume(y <= 1000);

  // Program specific variables
  // We need to initalize these values.
  long long int expected_sum = 0, path_index = -1;
  float weight_acc = 0.80, sum_prob = 0.00;
  unsigned long long int ptids[UNROLL], UNROLLING = UNROLL;

  // Unrolling UNROLL times atleast.
  while (UNROLLING--) {

    // probabilistic paths taken so far.
    // ASSUME : Each "__ptid" must represents a different path.
    path_index += 1;
    float product_prob = 1.0;
    long int expected_value = 0;
    unsigned long long int __ptid = 0;

    // [x] ---- Simulate One Run ----
    // Unrolling FLIPS times always.
    for (int i = 0; i < FLIPS; i++) {
      // float x = nondet_float();
      // __ESBMC_assume(!isnan(x));
      unsigned char flip = nondet_bool();
      __ptid += (flip == 1) ? 1 << (63 - i) : 0 << (63 - i);
      product_prob *= (flip == 1) ? prob : (1 - prob);
      expected_value += (flip == 1) ? y : 0;
    }
    // [x] ---- Simulate One Run ----

    // Probability mass accumalated for this run/path.
    sum_prob += product_prob;
    expected_sum += expected_value;
    ptids[path_index] = __ptid;
  }

  // COMMENT : assume(distinct(__ptid));
  for (int i = 0; i < UNROLL; i++) {
    for (int j = 0; j < UNROLL; j++) {
      if (i < j)
        __ESBMC_assume(ptids[i] != ptids[j]);
      else
        break;
    }
  }

  unsigned long long int optimize_over = expected_sum - FLIPS * prob * y;
  __ESBMC_assert(optimize_over != 0, "Optimization Maximize");
  // End Assert must hold with the optimized values.
  // ASSERT : if (prob <= 0.5) E(x) < 0.4 * n * y
  //            else E(x) >= 0.6 * n * y
  // if (prob <= 0.5) {
  //   __ESBMC_assert(expected_sum < 0.40 * FLIPS * y, "Lesser");
  // } else {
  //   __ESBMC_assert(expected_sum >= 0.60 * FLIPS * y, "Greater");
  // }
  return 0;
}

// grep optimize_over file.smt2 | head -n 1 | cut -f2 -d"|"