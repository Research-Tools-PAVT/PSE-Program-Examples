#include "klee/klee.h"
#include <PSE.h>

int main() {
  int truth;
  klee_make_symbolic(&truth, sizeof(truth), "truth");
  klee_assume(0 <= truth);
  klee_assume(truth <= 1);

  int second_flip;
  int first_flip;
  make_pse_symbolic(&first_flip, sizeof(first_flip), "first_flip", 0, 1);

  // 0 = No, 1 = Yes
  int ret = 0;

  // 0 = tails; 1 = heads
  if (first_flip == 0) {
    ret = truth;
  } else {
    make_pse_symbolic(&second_flip, sizeof(second_flip), "second_flip", 0, 1);

    if (second_flip == 1) {
      ret = 1;
    } else {
      ret = 0;
    }
  }

  if (ret == truth) {
    // expected_value("ret", ret);
    klee_dump_kquery_state();
    mark_state_winning();
  }

  return 0;
}