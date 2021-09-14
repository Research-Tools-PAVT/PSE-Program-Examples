#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define FLIPS 10
#define UNROLL 100

int main(void) {

  // Forall Variables
  int y = nondet_uint();
  float prob = nondet_float();

  // ASSUME : Forall Specific Assumes.
  __ESBMC_assume(prob > 0.00001f);
  __ESBMC_assume(prob <= 1.0f);

  __ESBMC_assume(y > 0);
  __ESBMC_assume(y <= 1000);

  // Program specific variables
  // We need to initalize these values.
  long int expected_sum = 0L, path_index = -1, __path_id = 0L;
  float prob_weight = 0.80f, sum_prob = 0.00f;

  unsigned long long int PTIDs[UNROLL];
  // Unrolling 100 times atleast.
  while (sum_prob <= prob_weight * prob) {

    // probabilistic paths taken so far.
    // ASSUME : Each "__path_id" must represents a different path.
    path_index += 1;
    __path_id = path_index;
    __ESBMC_assume(__path_id == path_index);

    float product_prob = 1.00f;
    long int expected_value = 0L;

    // vec(d) = <1, 1, 0, 1...> => encode flips[] array
    // For two different probabilistic paths, p1, p2
    // COMMENT vec(d1) != vec(d2) forall pairs(d1, d2)
    // COMMENT : Add it to SMT Formula later.
    unsigned char flips[FLIPS];

    // Unrolling FLIPS times always.
    unsigned long long int __ptid = 0LL;
    for (int i = 0; i < FLIPS; i++) {

      double r = (double)(nondet_double() / (RAND_MAX));
      flips[i] = r >= prob ? 1 : 0;

      // Needed in the SMT Formula.
      if (r >= prob) {
        __ESBMC_assume(flips[i] == 1);
        __ptid += 1 << (63 - i);
      } else {
        __ESBMC_assume(flips[i] == 0);
        __ptid += 0 << (63 - i);
      }
      product_prob *= flips[i] == 1 ? prob : 1.00f;
      expected_value += flips[i] == 1 ? y : 0L;
    }

    // COMMENT : assume(distinct(__ptid));
    PTIDs[path_index] = __ptid;
    __ESBMC_assume(PTIDs[path_index] == __ptid);

    // Probability mass accumalated for
    // this run/path.
    sum_prob += product_prob;
    expected_sum += expected_value;
  }

  /**
   * @brief
   * XOR of x ^ x = 0
   * XOR of x ^ 0 = x
   */
  unsigned long long int __XOR_PTIDS = PTIDs[0] ^ PTIDs[1];
  for (int i = 2; i < UNROLL; i++) {
    __XOR_PTIDS ^= PTIDs[i];
  }

  // COMMENT : assume(distinct(__ptid));
  __ESBMC_assume(__XOR_PTIDS != 0);
  __ESBMC_assert(__path_id == path_index, "This must hold : Num Prob paths.");

  // ASSERT : This is a dummy assert.
  // COMMENT : Maximize(expected_sum)
  long int expected_sum_holder = expected_sum;
  __ESBMC_assert(expected_sum_holder == expected_sum,
                 "We want to optimize this expression later.");

  // End Assert must hold with the optimized values.
  // ASSERT : if (prob <= 0.5) E(x) < 0.4 * n * y else E(x) >= 0.6 * n * y
  if (prob <= 0.5f) {
    assert(expected_sum < 0.4 * FLIPS * y);
  } else {
    assert(expected_sum >= 0.6 * FLIPS * y);
  }

  return 0;
}