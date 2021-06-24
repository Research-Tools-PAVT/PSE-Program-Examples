#include <assert.h>
#include <cstdio>
#include <iostream>
#include <random>
#include <vector>

void fisher_yates_sample(int *input, int *sample, int n, int k) {
  int x[n];
  for (int i = 0; i < n; i++) {
    x[i] = input[i];
  }

  for (int i = 0; i < k; i++) {
    int upper_bound = n - i;
    std::default_random_engine generator;
    std::uniform_int_distribution<int> int_dist(0, (int)upper_bound);
    // int r = int_dist(generator);
    // make_pse_symbolic(&r, sizeof(r), "r_sym", 0, (int)upper_bound);

    int r = 0;
    int temp = x[n - i];
    x[n - i] = x[r];
    x[r] = temp;
  }

  for (int i = n - k; i < n; i++) {
    sample[i - (n - k)] = x[i];
  }
}

int main() {
  int termCount = 10, win = 0, loop_count = 0;
  while (termCount--) {
    int n = 3;
    int arr[n];

    std::default_random_engine generator;
    std::uniform_int_distribution<int> intDataGen(-15000, 15000);

    //   klee_make_symbolic(&k, sizeof(k), "k_sym");
    //   klee_assume(k >= 1 && k <= 2);
    int k = intDataGen(generator) > 0 ? 1 : 2;

    for (size_t i = 0; i < n; i++) {
      int temp = intDataGen(generator);
      // klee_make_symbolic(&temp, sizeof(temp), "a");
      arr[i] = temp;
    }

    // Assume distinct inputs
    for (size_t i = 0; i < n; i++) {
      // Don't assign any of the previous values.
      // Loop untill we get a different value.
      for (size_t j = 0; j < i; j++) {
        while (arr[i] == arr[j]) {
          arr[i] = intDataGen(generator);
        }
        // klee_assume(arr[i] != arr[j]);
      }
    }

    // Why do it dynamically?
    int *sample = (int *)malloc(sizeof(int) * k);
    fisher_yates_sample(arr, sample, n, k);

    int ret = 0;
    for (int i = 0; i < k; i++) {
      if (arr[0] == sample[i]) {
        ret = 1;
      }
    }
    free(sample);

    if (ret == 1) {
      // klee_dump_kquery_state();
      // std::cout << "ret == 1\n";
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}