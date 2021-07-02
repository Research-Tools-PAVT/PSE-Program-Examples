#include <cmath>
#include <cstdio>
#include <iostream>
#include <random>
#include <string>
#include <unordered_map>
#include <vector>

#define N 100

size_t monotone_check(unsigned char *f) {
  unsigned char last = f[0];
  size_t count = 0;
  for (size_t i = 1; i < N; i++) {
    if (last > f[i]) {
      count++;
    }
    last = f[i];
  }
  return count;
}

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {

    // TODO : Sample N from 1 to 100.
    unsigned char f[N];
    for (int i = 0; i < N; i++) {
      std::default_random_engine generator;
      std::uniform_int_distribution<int> value_dist(INT32_MIN, INT32_MAX);
      unsigned char temp = value_dist(generator);
      // klee_make_symbolic(&temp, sizeof(temp), "f");
      f[i] = temp;
    }
    //  klee_make_symbolic(&f, sizeof(f), "f");

    std::default_random_engine generator;
    std::uniform_int_distribution<int> N_range(0, N - 1);
    size_t x = N_range(generator);
    //   klee_make_symbolic(&x, sizeof(x), "x");
    //   klee_assume(x >= 0);
    //   klee_assume(x < N);

    // TODO : Do we put assumes?
    //   klee_assume(monotone_check(f) == x);

    unsigned char l = (unsigned char)ceil(log2(N)) - 1;
    unsigned char a = 0;
    unsigned char b = N - 1;

    unsigned char i = N_range(generator);
    // make_pse_symbolic(&i, sizeof(i), "i", (unsigned char)0,
    // (unsigned char)(N - 1));

    bool reject = false;

    for (unsigned char t = 0; t < l; t++) {
      unsigned char p = (unsigned char)ceil((double(a + b)) / (double)2.0);
      if (i <= p) {
        if (f[i] > f[p]) {
          reject = true;
        }
        b = p;
      } else {
        if (f[i] < f[p]) {
          reject = true;
        }
        a = p + 1;
      }
    }

    if (!reject) {
      // klee_dump_kquery_state();
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}