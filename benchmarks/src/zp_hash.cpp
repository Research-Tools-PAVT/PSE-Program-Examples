#include <cstdio>
#include <iostream>
#include <random>
#include <stdlib.h>

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {

    // Could be a forall. Must be a large prime.
    int prime = 3;

    std::default_random_engine generator;
    std::uniform_int_distribution<int> int_dist(0, prime);
    std::uniform_int_distribution<int> int_dist_1(INT32_MIN, INT32_MAX);
    std::uniform_int_distribution<int> int_dist_2(1, prime);
    //   make_pse_symbolic(&aj, sizeof(aj), "a_j", 0, (int)prime);
    //   make_pse_symbolic(&bj, sizeof(bj), "b_j", 0, (int)prime);

    int x = int_dist_1(generator);
    int y = int_dist_1(generator);
    int aj = int_dist(generator);
    int bj = int_dist(generator);
    int w = int_dist_2(generator);

    //   klee_make_symbolic(&x, sizeof(x), "x");
    //   klee_make_symbolic(&y, sizeof(y), "y");
    //   klee_assume(x != y);
    while (x == y) {
      x = int_dist_1(generator);
    }
    //   klee_make_symbolic(&w, sizeof(w), "w");
    //   klee_assume(w >= 1);
    //   klee_assume(w <= prime);

    int hash_x = ((long)aj * x + bj) % prime % w;
    int hash_y = ((long)aj * y + bj) % prime % w;

    if (hash_x == hash_y) {
      // klee_dump_kquery_state();
      std::cout << hash_x << ", " << hash_y << "\n";
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}