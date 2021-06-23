#include <cstdio>
#include <iostream>

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
  size_t n = 3;
  unsigned char poly[n];

  for (size_t i = 0; i < n; i++) {
    unsigned char temp;
    // klee_make_symbolic(&temp, sizeof(temp), "x");
    // klee_assume(temp != 0);
    poly[i] = temp;
  }

  unsigned char subset_max = 11;
  unsigned char r[n];
  for (size_t i = 0; i < n; i++) {
    unsigned char temp;
    // make_pse_symbolic(&temp, sizeof(temp), "r_sym", (unsigned char)0,
    //   (unsigned char)subset_max);
    r[i] = temp;
  }

  unsigned char d[] = {1, 1, 1};
  auto ret = schwartz_zippel(poly, r, d, n);
  if (ret) {
    // klee_dump_kquery_state();
    std::cout << "ret :" << ret << "\n";
  }

  return 0;
}