#include "klee/klee.h"
#include <PSE.h>
#define PRECISION 100

int geo0(int flip, int prob) {

  int X, path_prob = 1;
  klee_make_symbolic(&X, sizeof(X), "rand_X_var");
  X = 0;

  while (flip == 0) {
    unsigned int d;
    make_pse_symbolic<unsigned int>(&d, sizeof(d), "d_symb", 0, 1);

    if (d == 1) {
      flip = 1;
      path_prob *= (prob / PRECISION);
    } else {
      X = X + 1;
      path_prob *= ((PRECISION - prob) / PRECISION);

      klee_assume(X < 10);
      mark_state_winning();
    }
  }

  return path_prob * X;
}

int main(void) {

  int flip;
  unsigned int prob;

  klee_make_symbolic(&flip, sizeof(flip), "flip_forall");
  klee_make_symbolic(&prob, sizeof(prob), "prob_forall");
  klee_assume(prob > 10 && prob < PRECISION);

  flip = 0;
  int X = geo0(flip, prob);

  expected_value("path_exp", X);
  return 0;
}
