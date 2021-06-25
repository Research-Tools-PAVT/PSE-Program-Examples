#include <cstdio>
#include <iostream>
#include <random>

unsigned char pow(unsigned char x, unsigned char p) {
  unsigned char temp = 1;
  for (int j = 1; j <= p; j++) {
    temp *= x;
  }
  return temp;
}

bool schwartz_zippel(unsigned char *poly, unsigned char *r, unsigned char *d,
                     size_t n) {
  unsigned int sum = 0;
  for (size_t i = 0; i < n; i++) {
    sum += poly[i] * pow(r[i], d[i]);
  }
  return sum == 0;
}

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {

    // Could also be a forall.
    size_t n = 3;
    unsigned char poly[n];

    std::default_random_engine generator;
    std::uniform_int_distribution<int> random_range(INT32_MIN, INT32_MAX);
    std::uniform_int_distribution<int> poly_range(1, INT32_MAX);

    for (size_t i = 0; i < n; i++) {
      unsigned char temp = poly_range(generator);
      // klee_make_symbolic(&temp, sizeof(temp), "x");
      // klee_assume(temp != 0);
      poly[i] = temp;
    }

    unsigned char subset_max = 11;
    unsigned char r[n];
    for (size_t i = 0; i < n; i++) {
      std::default_random_engine generator;
      std::uniform_int_distribution<int> rand_range(0, subset_max);
      unsigned char temp = rand_range(generator);
      // make_pse_symbolic(&temp, sizeof(temp), "r_sym", (unsigned char)0,
      //   (unsigned char)subset_max);
      r[i] = temp;
    }

    unsigned char d[] = {1, 1, 1};
    auto ret = schwartz_zippel(poly, r, d, n);
    if (ret != 0) {
      // klee_dump_kquery_state();
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}