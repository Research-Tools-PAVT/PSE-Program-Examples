#include "klee/klee.h"
#include <PSE.h>

int geo0(int flip) {
  int X = 0;
  while (flip == 0) {
    unsigned int d;
    make_pse_symbolic<unsigned int>(&d, sizeof(d), "d_symb", 0, 1);
    if (d) {
      flip = 1;
    } else {
      X = X + 1;
      mark_state_winning();
    }
  }
  return X;
}

int main(void) {

  int flip;
  klee_make_symbolic(&flip, sizeof(flip), "flip_symb");
  flip = 0;

  int X = geo0(flip);

  expected_value("X_exp_path", X);
  return 0;
}
