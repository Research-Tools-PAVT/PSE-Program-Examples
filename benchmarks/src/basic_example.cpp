#include <assert.h>
#include <cstdio>
#include <iostream>
#include <random>
#include <vector>

int main() {

  long double prob = 0;
  int n = 0, y = 0, termCount = 0;
  long long unsigned int win = 0, loop_run = 0;

  // Randomly Sample the ForAlls.
  scanf("%d", &termCount);
  scanf("%d", &n);
  scanf("%d", &y);
  scanf("%Lf", &prob);

  std::cout << "ForALL Setting : n : " << n << ", y : " << y
            << ", prob : " << prob << "\n";
  // We read one sample of ForAlls setting
  // and start simulation.
  while (termCount--) {
    /**
     * @brief We simulate the sampling of
     * probabilistic variables here.
     *
     * They are sampled each time from a distribution.
     */

    // program execution starts
    std::default_random_engine generator;
    std::bernoulli_distribution bernoulli_rvs(prob);
    int n_loop = n, x = 0;

    while (n_loop--) {
      // Sample the probabilistic variable.
      int d = bernoulli_rvs(generator);
      // std::cout << "d : " << d << "\n";
      if (d) {
        x = x + y;
      }
    }

    // Sample for probability. This is the assert condition.
    // Number of times assert is HIT.
    // std::cout << (double)x - (prob * n * y) << "\n";
    if ((double)x - (prob * n * y) <= 0)
      win++;

    // No. of times the program gets executed.
    loop_run++;
  }

  auto pwin = (double)win / loop_run;
  fprintf(stdout, "P(x - (prob * n * y) <= 0) : %.6lf, %lld, %lld\n", pwin, win,
          loop_run);
  return 0;
}