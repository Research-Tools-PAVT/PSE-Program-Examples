// Corral Adaptation.
// smack --no-verify --integer-encoding=bit-vector --float example.c -bpl
// example.bpl
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define FLIPS 5
#define UNROLL 25

int main(void) {

  // Forall Variables
  int y = __VERIFIER_nondet_uint();
  float prob = __VERIFIER_nondet_float();

  // ASSUME : Forall Specific Assumes.
  assume(prob > 0.0001);
  assume(prob <= 1.0);

  assume(y > 0);
  assume(y <= 1000);

  // Program specific variables
  // We need to initalize these values.
  long int expected_sum = 0, path_index = -1;
  float weight_acc = 0.80, sum_prob = 0.00;
  unsigned long long int ptids[UNROLL];
  long long int UNROLLING = UNROLL;

  // Unrolling UNROLL times atleast.
  while ((sum_prob <= weight_acc * prob) && UNROLLING--) {

    // probabilistic paths taken so far.
    // ASSUME : Each "__ptid" must represents a different path.
    path_index += 1;
    float product_prob = 1.0;
    long int expected_value = 0;
    unsigned long long int __ptid = 0;

    // [x] ---- Simulate One Run ----
    // Unrolling FLIPS times always.
    for (int i = 0; i < FLIPS; i++) {
      unsigned char flip =
          (((float)(__VERIFIER_nondet_double() / (RAND_MAX))) >= prob) ? 1 : 0;
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
        assume(ptids[i] != ptids[j]);
    }
  }

  unsigned long long int optimize_over = expected_sum - FLIPS * prob * y;
  assert(optimize_over <= 0);
  return 0;
}