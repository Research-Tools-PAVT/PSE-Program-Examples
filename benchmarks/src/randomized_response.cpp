#include <cstdio>
#include <iostream>
#include <time.h>

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    srand(time(0));
    int truth = rand() > 1500 ? 0 : 1;
    //   klee_make_symbolic(&truth, sizeof(truth), "truth");
    //   klee_assume(0 <= truth);
    //   klee_assume(truth <= 1);

    int first_flip = rand() > 1500 ? 0 : 1;
    //   make_pse_symbolic(&first_flip, sizeof(first_flip), "first_flip", 0, 1);

    // 0 = No, 1 = Yes
    int ret = 0; // default init

    // 0 = tails; 1 = heads
    if (first_flip == 0) {
      ret = truth;
    } else {
      int second_flip = rand() > 1500 ? 0 : 1;
      // make_pse_symbolic(&second_flip, sizeof(second_flip), "second_flip", 0,
      // 1);
      if (second_flip == 1) {
        ret = 1;
      } else {
        ret = 0;
      }
    }

    if (ret == truth) {
      // klee_dump_kquery_state();
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}