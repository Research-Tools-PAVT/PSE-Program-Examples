#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define FLIPS 10

struct result {
  long int sum;
  float prob;
};

struct result simulateOnePath(int y, float prob) {

  // We collect the values in variables
  // and use them later in analysis
  float product_prob = 1.00f;
  long int expected_value = 0L;

  // vec(d) = <1, 1, 0, 1...> => encode flips
  // For two different probabilistic paths, p1, p2
  // vec(d1) != vec(d2)
  // TODO : Assumes for distinct probabilistic paths.
  // COMMENT : Add it to SMT Formula later.
  _Bool flips[FLIPS] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

  for (int i = 0; i < FLIPS; i++) {
    double r = ((double)rand() / (RAND_MAX));
    flips[i] = r >= prob ? 1 : 0;
    product_prob *= flips[i] == 1 ? prob : 1.00f;
    expected_value += flips[i] == 1 ? y : 0L;
  }

  struct result r1 = {product_prob, expected_value};
  return r1;
}

int main(void) {

  srand(time(NULL));

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
  long int expected_sum = 0L, path_index = -1;
  float prob_weight = 0.75f, sum_prob = 0.00f;

  while (sum_prob >= prob_weight * prob) {
    path_index += 1; // # paths taken so far.
    // We simulate a single trial here.
    struct result res = simulateOnePath(y, prob);
    sum_prob += res.prob;
    expected_sum += res.sum;
    printf("Sum Prob : %lf\n", sum_prob);
  }

  // ASSERT : This is a dummy assert.
  __ESBMC_assert(FLIPS * prob * y >= 0, "Optimization Dummy");

  // End Assert must hold with the optimized values.
  // ASSERT : if (prob <= 0.5) E(x) < 0.4 * n * y else E(x) >= 0.6 * n * y
  if (prob <= 0.5f) {
    __ESBMC_assert(expected_sum < 0.4 * FLIPS * y, "Less Than Assert");
  } else {
    __ESBMC_assert(expected_sum >= 0.6 * FLIPS * y, "Greater Than Assert");
  }

  return 0;
}

/**
 * @brief Encoding
    (set-logic QF_AUFBV)
    (set-info :status unknown)
    (set-option :produce-models true)
 */