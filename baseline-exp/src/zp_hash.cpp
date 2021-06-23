#include <cstdio>
#include <iostream>
#include <stdlib.h>

int main() {
  int prime = 3;
  int aj;
  int bj;
  //   make_pse_symbolic(&aj, sizeof(aj), "a_j", 0, (int)prime);
  //   make_pse_symbolic(&bj, sizeof(bj), "b_j", 0, (int)prime);
  int x;
  int y;
  int w;
  //   klee_make_symbolic(&x, sizeof(x), "x");
  //   klee_make_symbolic(&y, sizeof(y), "y");
  //   klee_assume(x != y);
  //   klee_make_symbolic(&w, sizeof(w), "w");
  //   klee_assume(w >= 1);
  //   klee_assume(w <= prime);

  int hash_x = ((long)aj * x + bj) % prime % w;
  int hash_y = ((long)aj * y + bj) % prime % w;

  if (hash_x == hash_y) {
    // klee_dump_kquery_state();
    std::cout << hash_x << ", " << hash_y << "\n";
  }
  return 0;
}