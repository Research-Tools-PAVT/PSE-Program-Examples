#include "klee/klee.h"
#include <PSE.h>
#define PRECISION 100

int geo0(int flip, int prob) {
  int X = 0;
  while (flip == 0) {
    unsigned int d;
    make_pse_symbolic<unsigned int>(&d, sizeof(d), "d_symb", 0, 1);
    if (d) {
      flip = 1;
      prob *= prob;
    } else {
      X = X + 1;
      prob *= PRECISION - prob;
      mark_state_winning();
    }
  }
  return prob * X;
}

int main(void) {

  int flip;
  unsigned int prob;
  klee_make_symbolic(&flip, sizeof(flip), "flip_forall");
  klee_make_symbolic(&prob, sizeof(prob), "prob_forall");
  klee_assume(prob > 1 && prob < PRECISION);

  flip = 0;
  int X = geo0(flip, prob);

  expected_value("X_exp_path", X / PRECISION);
  return 0;
}
